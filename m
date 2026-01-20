Return-Path: <linux-kselftest+bounces-49540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLbVBdfVb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49540-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 20:21:59 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB584A326
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7C887E0D9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F0350D64;
	Tue, 20 Jan 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/2fDR8E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75464350D48
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929216; cv=none; b=Rf47llf+7znrNA78e/m0fyOtunl5eExJw1atQjE/bX6nX05nPbTj+3oDbTm2CMpFSWSrgricDuMrmXlE4WNFd4GEIdc7TJIwGrGEEo5KjOUU3f3eeWMYv1MKJ3s+2+YK/xdUqlTs5IC8iNRApoy+JmQmI+4IFVGQK4KcK3BwO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929216; c=relaxed/simple;
	bh=Ckdv+LBfVcrA4JvvMxCIADVWbw04Tilid9Ikn1lV+1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+DAaJADVb4hB2mmJ69cNJsu7yuvrgjzf7wuTgZPWEjq2cIWwPeiugcKXE2cw2Az9dTzFwwjRzzu7Cxaaq14J2APHVtFZuI1sNguJO3uicNG1LYk5ZhilB6Wd9YP9IbSU1ln3ma/Eazsgc7oyVuJLz6yt/TsqeeWIhgbMoDPMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/2fDR8E; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12336c0a8b6so11815844c88.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768929214; x=1769534014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=md0g+j6qZSK2w0IJlJPci/fZMbMlDX58xj6TKgMT//Y=;
        b=U/2fDR8ELM+fyEwCNTKmR8NRnFb7/7mBUoZ3trQHIjxl0OOv95Gacw6frHzq+JSvmV
         YqNJAh4o1DZoUr+4DsG3KZXJunAViFUnUylTWZWSw4GHyXKvzJv9gY3nyqVYZLpPD0gt
         cvnoEfdsteoW8CDTCMsblLgVT8DQl6TrFPRA1teD2Fv+GeEkRtfVbDwdX3oy6QTpzYjh
         i/NjtOwTFPuF7o9EYhVO4H0KxeaQATF1CKVb8Ka5xE5D3OjSfHgZOipLF4LlwrSKndRX
         5+x1c4Qv5p9zQwACbF97zwham/NRGKqMdbuC8KokGnxi1cenTVdEf4YxlIjpluf/dn7W
         agFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929214; x=1769534014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md0g+j6qZSK2w0IJlJPci/fZMbMlDX58xj6TKgMT//Y=;
        b=jOuCyus5R/uzY/zGmBhOg+RoQXBne6CFrLbMSo3MrGeafuTuR0NBIkoDiEw2IFujgT
         Sd/3T2n4xEEbIdD+dW9j8ZP+xOIopz8gJvUTSMlvAyQ7lOxvyRdf8pMfOvvyADx9RK6F
         gyzobv+WjFtrhjZtBmcxpKyJJFI420vw+9CEZEggRg8I8vn9wLhCZXpupvGqOAdtivTI
         B2VKGfF+oC/lGEWq58T/s7k3U6B2q0zyY3gCtuEPyVRCFfghYk5A4v9CKFitqWejgxC+
         ItclRWJTY7wjCadOf3zz6aBTvLldh64b6Yo+BQ8s9LWYpNi+lwm3sHE3jRWmdD4X4vWe
         LxMg==
X-Forwarded-Encrypted: i=1; AJvYcCVPEoMjCF0rCHeYtMrzPbMx3o6URvLbelgcYnQYA/4mMdA39WcLTUDTEVllvYYvmgtG0G3/rTrAfBl1rkTChBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiSULmzcYW7cnvdiHHn349s/5/UPFgGa5ozfShl4iq19xvvKm
	PeQ6aJm3DbCLYduN8nb3vUC5R5gTKmKQuatj31TlyBO0HAZJA+hgVPVrftJWbg==
X-Gm-Gg: AY/fxX588lUD9IO3SpQX2aMIRx9SXcNNjQ3e0J/xcCHQQ8ZRiTNEWQxLAuOhAdgvit3
	Nimkp5DsWyxK1z8KGoJdKukVkPUZGdQ8dYSMqL9NkwC0ofeTU5ilSy7eOrUK2CzN/vdVLk6ff9f
	wVK0ee3oxpeCTcJMDFpwWxpzGk8X+S3LbI9BRCK6szJlunyDkoFi4VkmH2XV5J8vHvDj1ga+ZRS
	kqjM7Xyi7+heX4hkTKpjFTh3J/ZkK47uXomBVR+YUfsWvO2GAxpB/OAtwI0YWmRpvfCo6Szbbey
	dmJqzODxdNRdoA3VQBRgpSJpCfg1TGAwzJFDMWe6CRpxagfSi9+J/osa7LCNXn4A4De3zoenDLN
	a5GawpkL/UAwVY80LR0V3WDHmTRR4mmqsDy4R6D1yxl6uIM8gByaVbuy24E/TelAugtESmn09S8
	jfVgyy8PfFyiU=
X-Received: by 2002:a17:902:d4cb:b0:2a7:9196:a94e with SMTP id d9443c01a7336-2a79196aa80mr1234755ad.15.1768923524001;
        Tue, 20 Jan 2026 07:38:44 -0800 (PST)
Received: from gmail.com ([98.97.43.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce693sm112017965ad.36.2026.01.20.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:38:43 -0800 (PST)
Date: Tue, 20 Jan 2026 07:38:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
Message-ID: <20260120153807.gzwnhxxtcocycfmr@gmail.com>
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
 <20260113025121.197535-2-jiayuan.chen@linux.dev>
 <875x8wuy4e.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x8wuy4e.fsf@cloudflare.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-49540-lists,linux-kselftest=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,rbox.co,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,linux-kselftest@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-kselftest];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,linux.dev:email,cloudflare.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: ABB584A326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-20 16:01:21, Jakub Sitnicki wrote:
> On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> > A socket using sockmap has its own independent receive queue: ingress_msg.
> > This queue may contain data from its own protocol stack or from other
> > sockets.
> >
> > The issue is that when reading from ingress_msg, we update tp->copied_seq
> > by default. However, if the data is not from its own protocol stack,
> > tcp->rcv_nxt is not increased. Later, if we convert this socket to a
> > native socket, reading from this socket may fail because copied_seq might
> > be significantly larger than rcv_nxt.
> >
> > This fix also addresses the syzkaller-reported bug referenced in the
> > Closes tag.
> >
> > This patch marks the skmsg objects in ingress_msg. When reading, we update
> > copied_seq only if the data is from its own protocol stack.
> >
> >                                                      FD1:read()
> >                                                      --  FD1->copied_seq++
> >                                                          |  [read data]
> >                                                          |
> >                                 [enqueue data]           v
> >                   [sockmap]     -> ingress to self ->  ingress_msg queue
> > FD1 native stack  ------>                                 ^
> > -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
> >                                        |                  |
> >                                        |             ingress to FD1
> >                                        v                  ^
> >                                       ...                 |  [sockmap]
> >                                                      FD2 native stack
> >
> > Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> > Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

[...]

> > @@ -487,6 +494,14 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> >  out:
> >  	return copied;
> >  }
> > +EXPORT_SYMBOL_GPL(__sk_msg_recvmsg);
> 
> Nit: Sorry, I haven't caught that before. tcp_bpf is a built-in. We
> don't need to export this internal helper to modules.

We could probably push this without the 2/3 patch? If we are debating
that patch still would be good to get this merged.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

