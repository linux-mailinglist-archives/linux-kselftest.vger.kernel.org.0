Return-Path: <linux-kselftest+bounces-9546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245E18BD43E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4E0B2189D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FE1586F3;
	Mon,  6 May 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE0vQ+R6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2C197;
	Mon,  6 May 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018428; cv=none; b=LhHSIvYP+3a67Od1C391/Do7JFjwtDIUC3GZJzgcv0PYpZV7pYkt+Y7EswQTBWTXogqepgO9J+PnVCEIall/MjcmEF5ZeF4sMduvvYKFD34mKmkNCwCz7E0rkpBY8u+Xcxl6t0xq/pDz/FBl6VMoMBBD8yCbySIToQ9z0sI8kYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018428; c=relaxed/simple;
	bh=no6tilYKngaoTOqfGFWOgA/5oNjItKCJRl53C/eguWs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SflK/qCXpvhQZtf6wTN2tDm0BXbCyCV5AfbIN+seXLEKuDZepjOasmYlJejUjkAWZQ3AK8YQ/J7bzDHdr9BJRiAU8UW7XUofQJwUsklbN8EQNIpk+hcp4iY4LiWD5Wjtn0qnvrX733B9ti59IrvNxLyvPfs9PEadHmTIIn73XIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE0vQ+R6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b5de48126so6386056d6.3;
        Mon, 06 May 2024 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715018426; x=1715623226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewxWon8y3EC8f5KNKIlRB63vgk6021CZpyEJEMa3QaQ=;
        b=YE0vQ+R6b8+ln631z0TtxZkL1Hc1RORoY4+kXk8FURwK21zPa25F8JvJ8zqnt53rtK
         gw3EvkB5iLLQiGvYeJTaSArvTf3sv3Rjt2aeti674KU0iyDw6IglO/nDFouh6e1Kow6h
         c+qQwBR8VY13D86XMOFeH8i7lIM7VHLAJZgP/uyZXY6gO1v+pZsIpr3Q9HYUpESJr0Wm
         rZYLikTE77RD1uyHASYnGmUDEd7mLSNjSD05bzyaB17eEXr3AXqLDBDxgWuJRzUE7+eq
         QE9RXAqPB0GO322+dT8WSmtofjBxuJdUSHPWzmfFl7bU9bqsMpmBsUorPfzEYX6iIzmd
         PBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018426; x=1715623226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewxWon8y3EC8f5KNKIlRB63vgk6021CZpyEJEMa3QaQ=;
        b=WWiIWcSgiSmpwjm+EggzLxwtn3qXwQPYu6aqUPHmas1N19MOHcjPqbEzX1X2wxwUsE
         iXg/9PwamYRkj65GYurSGpMeO2n1OT4ckeuDMAett6LegDJ8zztPtbFOQ40bSYQ30AuI
         vQzXMnv96eWenNhU4lr+PxsPSd/xQ5g5LGmnsBy122cFMJdG6XmreIWjsTFMIjjMOOnZ
         Qo/IhV6BKo02Zj7yv+aJrAK8x2qSa/RHB7O6mOmcgHIlC2REJtT/rbhMRKloTO1KxTWz
         jp/VMfvH47mFOcxTn/DdLFJYBCmVTXl9hzxZv4A7ktBqpen3rVuiYOcKizmb6D3tLOLI
         n+vw==
X-Forwarded-Encrypted: i=1; AJvYcCUfD0366mWmWkicBUoCOMr1l+74+NHMSSfYuBMfZwD1xbiSP1VQMoxMatVuObq/DFtyInwpjMfhc12zn3fPUg3LtGciHgxsSemtdBcEubsOfWTJc0EmTVPquKmRXRzzY9UWJxSKUUkGn2KbkWHFXLP7JT3YpVCIV+vzO6l38tfzB3Sw1+en
X-Gm-Message-State: AOJu0YxiXNso2uEDwj1kbZuHgnDup8G0nozOxzcNOQGKzh1JV+i9BlBA
	mvI1f08b/VP3rhdqpAzOmG4f9r0gnDl6tk/VUwUGM2z7EkN5d/d2cneAZQ==
X-Google-Smtp-Source: AGHT+IHwxi+MsesdxS51NMGdi8E37iQPGrsyCgG+iNUpxejrVgz1gYPJSIt1PiQCGOpKWPnlFwfCJg==
X-Received: by 2002:a05:6214:19e8:b0:69b:17b2:df34 with SMTP id q8-20020a05621419e800b0069b17b2df34mr13732146qvc.63.1715018424782;
        Mon, 06 May 2024 11:00:24 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id qb17-20020ad44711000000b006a0e585dc77sm3903456qvb.70.2024.05.06.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:00:24 -0700 (PDT)
Date: Mon, 06 May 2024 14:00:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>, 
 richardbgobert@gmail.com
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 zhujun2 <zhujun2@cmss.chinamobile.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Benjamin Poirier <bpoirier@nvidia.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-actions@lists.infradead.org, 
 mptcp@lists.linux.dev, 
 dev@openvswitch.org, 
 Valentin Obst <kernel@valentinobst.de>, 
 linux-kselftest@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, 
 llvm@lists.linux.dev, 
 John Hubbard <jhubbard@nvidia.com>
Message-ID: <66391ab83771c_516de294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240505222639.70317-2-jhubbard@nvidia.com>
References: <20240505222639.70317-1-jhubbard@nvidia.com>
 <20240505222639.70317-2-jhubbard@nvidia.com>
Subject: Re: [PATCH 2/2] selftests/net: fix uninitialized variables
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about three variables that are not initialized in all
> cases:
> 
> 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> not "ip". This seems like an actual bug.
> 
> 2) The addr_len is used uninitialized, but only in the assert case,
>    which bails out, so this is harmless.
> 
> 3) The family variable in add_listener() is only used uninitialized in
>    the error case (neither IPv4 nor IPv6 is specified), so it's also
>    harmless.
> 
> Fix by initializing each variable.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/net/gro.c                 | 3 ++-
>  tools/testing/selftests/net/ip_local_port_range.c | 2 +-
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 353e1e867fbb..0eb61edaad83 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -110,7 +110,8 @@ static void setup_sock_filter(int fd)
>  	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
>  	const int ethproto_off = offsetof(struct ethhdr, h_proto);
>  	int optlen = 0;
> -	int ipproto_off, opt_ipproto_off;
> +	int ipproto_off;
> +	int opt_ipproto_off = 0;

This is only intended to be used in the case where the IP proto is not TCP:

                        BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, ipproto_off),
+                       BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 2, 0),
+                       BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, opt_ipproto_off),
                        BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),

In that case the test tries again at a different offset that accounts
for optional IPv6 extension headers.

This is indeed buggy, in that it might accidentally accept packets
that should be dropped.

Initializing to 0 compares against against the first byte of the
Ethernet header. Which is an external argument to the test. So
safest is to initialize opt_ipproto_off to ipproto_off and just
repeat the previous check. Perhaps:

@@ -118,6 +118,7 @@ static void setup_sock_filter(int fd)
        else
                next_off = offsetof(struct ipv6hdr, nexthdr);
        ipproto_off = ETH_HLEN + next_off;
+       opt_ipproto_off = ipproto_off;  /* overridden later if may have exthdrs */

