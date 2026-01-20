Return-Path: <linux-kselftest+bounces-49476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B23D3C3FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F3D6C0576
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D643C1FF1;
	Tue, 20 Jan 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFtTGZHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B703C00A8
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901265; cv=pass; b=hSosswhaOex7szisWoGYdwljQY1zYnUnEKSUZUWSxHST3/oCq76oacH9ez1bC4IvemkICYmpV/FT+CwQlPkt0AKll0RL0YaHw+dP1TKtVt87bM7EbRXh7Y8ZManYa6p0Jfz0bPpJMjyK2Fvv9CSuywZESCvRIaZS3M0uMmibkF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901265; c=relaxed/simple;
	bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKHcrbV5gOWpYsl3sIF/zDnGb98vAnuw4sc7cJXzeEBMy5PY7ATzsE/f1BLUZGtRTZhSjCOdCGfpsyUN99R3G2MpU774ceFVSODScBBZ/WaViLChc8Iy5Un3vwjmm07jhg4G/Fzf0zad9g2IaOAsIf23AkFQeWmOML9b8UtA97o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFtTGZHF; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501506f448bso29287401cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901262; cv=none;
        d=google.com; s=arc-20240605;
        b=cWXakJ6plxFQvzsgQLIkefsc4RZ7si8PD/FU3P6k646uAdne3N0SA5PIvQCSkdRNRQ
         zGX7ksr/7bDLWCRrZFioZcgI9c9fDRpKcNdKPS9TbqH8paUUpqdg4eaOZyFGItpefi94
         xYDCdUS7I47+QZ9O+Li3WAtj5I1mixZGC4nMxTG33iRt33Z5bNm+E/maTfo8mjnbHUaB
         rh+13b9YIRqpem/2/QBnKG2T8b66DVq7XRgUpzaT2vCgINDYOcK5BDRYn5Svx76WyXdp
         cFW+xvFRsNfCSxE1OOXADcQzWVtWBuF/QBflWW2Sx1ngHe2v4FZfRDYQQxRk4Yyx7qFh
         hBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        fh=bOaTO8gnBSNp7ygj4QHu04TzWwwT6XT4GNBI3oUlT8g=;
        b=Y9X48id7+iFUttgRKM3Gsck4mLCYHb+07Teimyb3CabiaMpTB5xs8qj/BpdX7YqI/N
         AaBYNV710+0cftt29bsX3Kp9RgMPHjN8AGY9iKl5+PJwmIJSCkAxzp1BfibekiUXPklG
         jQJ+LttDNDPlcer3rqJGO3H8t58N3eSemLmkXqr8Q43xfeuE0mHhQ3CZyaeE5m0So2r2
         r+mvRD2qnDbHfi6Kaa9j4NmMGFab2wptHGPhEnZqGHEYL1evhVH8gkQ+PKwISgbpcHy9
         tNHeqfjmyXBrl725NG1joVkHxc+fDcwc7tyb9Hm1HtOeGlfk7ORj/tWL/EutNf4LWPHI
         q+mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901262; x=1769506062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        b=SFtTGZHF9NsJIabBnvYroZCzVEpdC2Hb+eE2ztAAX+AP/pxQ2GQn7gUzykX3xJE1T9
         Ic3+0XhwYEuVO/+V7CTqq8bK8EbVBGm14wXQZAdOhxbgZZMUMf9Znai9ninsnRo+wuBU
         tu+6U1tkqdA6QIiB0ZZEWgrBSf0CwqLCg11DMnxlCHHx1KnfwFltcwLKdvLS81XGy3Ib
         L/g09oZlVwkvnAM5lZhMgbe4I3ro46YYjP41sN8IevjoS/Ikjp6uK/5GoMwOTCddfmBZ
         od9r0TIDu2IfiN9us/4iZw1g2e/ZpWXGGBJWpcln/Gof4PS9uLDQvaUkilSORvAE5IYo
         jpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901262; x=1769506062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        b=DSDO3Bnj9crb8uwmpLl/FAPWN1a3mXLDwDHPgN/TD73f8xtx6DZvQYo5UuJ4uPjaLg
         qL13yKvt8cgleuN8nLYRPvZwmOBUB1laMyMlwjfP4l0ooN8NN3o0p5ehYmQgGMU3AlIL
         EEkM38quKT4Lk+qtApDnrg33MuW3eIVGpoxmS03oum7i2TcZp7AbBkBqmbXORm/ZVAEZ
         yoG3HZjpMF1V+QJteMh2RDMtr9imNjeFFEkTJUIqTwWBtQzL0maBZT5f9/w8AYOw+qTR
         66dnIG55jHH9FsY0IwdcUWoG/W1NUt/ctlvQgfcb68js+3X6ClSpS4hEKSqwEhBZUE85
         OPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIsTy8KT9eC6vKcN8oH7GcxQ/XWYf2SMJnwE2lvqxR0HbxyyJseyC/U4s0SN0iRobcoU41g7BuZuXy2Aeld/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWihhSrRCZi8KvxnF3hwDfjnmbL25FBwLLL3KtCi7Jxgwv+LnF
	Ct90pMo2aVEU6+H8Tib7tBC3y9uZUDqA5Ov0C3xrLnSN8PSyFib4IGIaWtRyIsyxgrm9LdizNZq
	aIw9s7SqZDqFobVaqmF4LHlzGokgDT7fT5HHXVCzj
X-Gm-Gg: AY/fxX41fQADqIZv1c9y533KUcT1NnnxsLcVVqT8ZzwdbEGxqxTmsEbDZUEvQjei06y
	uTlN1JU3nqqFPE+HyQblicVDn4DmIs7zqgLDuSsQ5DD8HKjSMN8wFGyvp4zJrYTs5ez6slPpd4K
	+erGgxACR4iGGdPZkMEr0FeinyWMQfKWLGJMu3jqPgkgkfipcDra4uDqDGbrsgNsu8hPhx5DIOo
	OXRg7JG0zWsbIGXD7tC+S7Tn10szOZ6UpXCkZ0QjUHRszFACVcn0cmhVLtZO+1pfd4CtFc=
X-Received: by 2002:a05:622a:180e:b0:501:47d3:217a with SMTP id
 d75a77b69052e-502d829a969mr10411241cf.25.1768901262067; Tue, 20 Jan 2026
 01:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-2-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:27:30 +0100
X-Gm-Features: AZwV_Qh2C6qterbUps9ipHoZiFx2JUtmLIyzTtH8Kko470SyemAziOwyIlRmsJc
Message-ID: <CANn89i+44At=GtWMjksjjMmARZONeVAAiDgqAP2jXWSK3BxJLQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Add newly acked pkts EWMA. When ACK thinning occurs, select
> between safer and unsafe cep delta in AccECN processing based
> on it. If the packets ACKed per ACK tends to be large, don't
> conservatively assume ACE field overflow.
>
> This patch uses the existing 2-byte holes in the rx group for new
> u16 variables withtout creating more holes. Below are the pahole
> outcomes before and after this patch:

Reviewed-by: Eric Dumazet <edumazet@google.com>

