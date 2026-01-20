Return-Path: <linux-kselftest+bounces-49547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH47E/nOb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49547-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:52:41 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D149D29
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9EE96C51B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB44611D3;
	Tue, 20 Jan 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1twhqfN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52345BD5C
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933332; cv=pass; b=poz5TTUJjdt54qgYCtvBR5Esrv8JpvOakKmnSwInUERj/tWDfaR1Fz+w2n/2sAkfx/SVDAdAJCpQkt4+fwTtnqjqxC9bEUjbB9vqnB1/o5hFT5Dxy0lKOUQ/UE1AOw+p3+P/euAeB6hF68J70mYUcWYo1+c1qr/nX9di4h5dzvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933332; c=relaxed/simple;
	bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0CAjju2FKop3ljE5HEhnYulk2TK43kkv2g0pZ308ZHhbW8kI7ZRq+eqKnYfeqll67OGVZeMTDwIrPU7gQSvzGcRSA8fYo4brFBQinZTkajlQz13SbxXSs0sQErwST5p2izw/XgDavIfVSNYqM3PULSQsxw6YGkR7+bmgRtZ/Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1twhqfN; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c52c67f64cso597485585a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 10:22:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933329; cv=none;
        d=google.com; s=arc-20240605;
        b=DDt+Qzd92LCr5gDnGlaTKwLPEVmlg7rbnVi//faf+Rzp/sMwW2TxT699ZJroPa2C5z
         uG+aqdt+PxVCQKKMhobPUzsD7hRyOYaj62e8WUSWkM6UMC3yQjdDoZhnK/HjUywQaDog
         IZZtPsCGErW4AJiscZJPhmA52f5XyR+Xy1XRjj2IlYs7O90RO2//P0lLc2H26Gq1PI7i
         np5cI0eftFEDBBf8rFuQIvJDVH+x4HLa1og/KcEtcxVvIg6Mvgu2sLmp+mS3wM+h+xFM
         K/0wP2ufrWHNnde9EoV97F6xd5Srr/2oZF6pKsM/omYv6HbPnxkXRbMiZOzWcwWOvdzR
         o9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        fh=emFuAfbv8Am8NRI1cOWAam9y0EEyxYLYIDdmhubu2Vg=;
        b=e4YivlpcAyBVEOJSArTDYqcICDKBAf9GQ1GwI1eibULkOlyByOlsboMTSkV86nidtx
         icJGReHIE+RFvlkfmHm+4O7k9nq3S9o8huv+3o1bH7UAgp67VIywmEwOKHyBif04MP5f
         wyTpdqOw3mVKGpr7UZDK8UYdWxU1gV8/PK/CFlW9ZOZuKxoMUfT3VwrjCrHOytm5VVuy
         szgPaRZeqQgH0kvp0d/wNOFnrTKuQtbOgFJ6wQEJFZjHrX4aMbPWLGKQieD8DyHkePpA
         BuBVKj6R7OMmevGYLJt1OGqX0wEBuzErTtgw3Fl0PT0AHBTlRdBrzNUmN/zgpkX0ht3v
         1Vzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933329; x=1769538129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        b=V1twhqfNQgxIqAL86UhV6eZ5ewl1/+v1oclnw3QqGrQ+4Efb5K5rcNuQwnoPMEk/iM
         MedsZuiGr2botbP8R9adTT78c99XtNZ0e1rcB3fkasa3i8QT+wtFnUypT9PqHmc8Qi1f
         0z555qgfXkq+ft1tx7Ki/WOaJAyQZrqM+Af6/YSYb6fImgkhnSnQPw5dnlYmRDkYunlI
         py5Sj9CvGbgStbZrcTxi/AUJIXJjqoBjCh6//Qls/ZJG9KBuFNTA7+IMHa/W9ksBidi0
         HstoMirl5zMXIwoUKPrDf1arq8oeiNJeXr8KuSIvIlfhKahPRUAPph1w7tsS1pyTcjKm
         b8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933329; x=1769538129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        b=qHWqONvajgj2k1CQWUeIZlJUXR+fc42BwnKVJLFwZb7e3BH38iheDCy11kj4q1Gnzx
         ykUfkIEvnZKxqs8HQDX0mA5y6zyKoYV58FAk3kX7/5QQTMUAqyu6MA64DcJv9fCTfel2
         3lAiUtOipwE0+rl0cda5m05Iijy2LOVtmqbYRD4zqlgAEI737kzD5O+Ej/qoEpzPgm06
         ywJmkT8MxZnOPSJVLhsb0vTuyuab7Gyq3I39nDDvPy43/IlTstFprjnfHIGbh+b6x0NJ
         UpXaK1ahEyy9s2Uwx2SFM/s/XNyDfqHaR8h8r8B6f67p9nHxNYP1rmI5ep6UMd+wy2y9
         M/fw==
X-Forwarded-Encrypted: i=1; AJvYcCU3YZRJW4ZSbffzPtgea5cGg5vU0iEP/YSV9ZLCmgA2ug9yLyalRsn1DX6MbPMprTbcNQrmaGi4JvLssgg6b4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxagvy0qYgsQRAoLf0MwUO9aAnbTqtlTARqCJP5QqKswAJEivc
	zXAjASAV/dhmShzZ+bOsVV+FsUwupFocUUu+ilCADQ/cjojsGhzcy2VOHg0hhh/tD8TPz5asHC4
	hGJMju2T+lT5Ola/UiJrIbtlatcUclw1N3vDSsQsk
X-Gm-Gg: AY/fxX5WWw771hUwFSAr81+MszYDD/qSp+aQuQLPtdlUyQSuTyfeQRrgPSmsRZue9Yz
	9MOJVN9Rtl/0V/TYGdKbL8omD1WdtSZq4B9pi3rdGfy7+ebWK2eVKq2KVNRKoq+Ex+Xn6yhfOlx
	AnZeKCcd3Qud8QhTqveJHKNF9rMXWMpiWBKDVhZMyCtdK/ZlvKNO+YnoweYmwQyYNR43U3DpXak
	Zqt9izWnfyyoz1Bo9VA9xAc/pj/6huqUSSAraEdhLaXjhxBgez1Wix1Q3L0EmahOLy23PMx
X-Received: by 2002:a05:620a:2947:b0:897:56e7:6aa3 with SMTP id
 af79cd13be357-8c6a676db0amr2122139685a.56.1768933328887; Tue, 20 Jan 2026
 10:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
 <CANn89i+NEyZ+1R1pouUcroarCfNrQEN01azsEhOuZoeR0Y3mhA@mail.gmail.com> <PAXPR07MB7984E2D22D4337CA97EBB9CBA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984E2D22D4337CA97EBB9CBA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 19:21:57 +0100
X-Gm-Features: AZwV_QhBrdPdlMbRCuth_kzLC6UfgC6v0TcEzAFsayFTN8n9oL2sLEky-qL_slw
Message-ID: <CANn89iK5jhfO7B1yZK11bEs4DyF3Wjfr6DUgOt-JMDzEAs+94A@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "parav@nvidia.com" <parav@nvidia.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-49547-lists,linux-kselftest=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: B88D149D29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:11=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
>
> Hi Eric,
>
> Thanks for the feedback.
> Do you mean sk_listener here is read-only despite there is no const here?

It is not const because we probably need to increment reference counts on i=
t.

But if you have 1000 SYN_RECV, they might share the same listener
socket, and we do not lock the listener socket,
this would not scale very well on servers with 10,000,000 tcp sockets :)

So using any listener-fields to store 'per-syn-recv' information is racy.

>
> Then, could you help to suggest the way please?
> Beacuse for AccECN, here we need to set fail flag after retransmitting SY=
N/ACK > 1 time.

Why not use state in req itself ? (Or tcp_rsk())

> And this was done within tcp_make_synack(), but now move to every place w=
here could retransmit SYN/ACK.
>
> Thanks.
> Chia-Yu

