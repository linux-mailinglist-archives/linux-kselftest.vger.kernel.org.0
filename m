Return-Path: <linux-kselftest+bounces-7075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8C896EB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065E41C23B76
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132F145FF8;
	Wed,  3 Apr 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GimEpVd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A9145B3F
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146283; cv=none; b=eIJYRftNU2vNDl117xbhKtZBQcotL8GBC0Ktz4PTj9SrDmubIckpctzD0FkMGj/4jjAvmfBpYGdYbQ2nDKu1oxDtMODO3GQpnapsbfBVKF/qzVQ+DYbmIrP4brqfPGTpdsMVAvx4CoBi9WIEJrI+6nD7uPUOVq4YPw+XCzgXPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146283; c=relaxed/simple;
	bh=KWr9TMPovk/8n3uu6M5XQ5h5IV9QUs202qfvEewr0is=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=CMpG78+36AcwfPdNTOwxH1/onglmlsABLFmWkE1HB0ZsRjEb03qbgMdW3sygr8Xb77vojIHQa5gGyVwT0tw/cgs9N3E6+qwkPzO3s3rht6hkv+OTqI7HEDlISVcMXZU3npskh66znd/B+cA5eUwS71VXkMBmLb2lFNGOrrlaTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GimEpVd9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d82713f473so37138271fa.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712146280; x=1712751080; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=E/6jutSMH9HOi65qZAuauoWMsdofEyugP9Pw6B07T3Q=;
        b=GimEpVd9c1l1jDR7Qs2J05ofaan9X+ByknwyhehPYVYRO8HZQAp4eTM36ju1EtzJfz
         XYXM9vn6ulZmmWIHUTpI4j09rUddq8GqSYCFIcUDbJMw0kU9wvqpTqobnQrwhVAaWMGf
         T3o3xSvJCRozSFKohzDzWRMt59q61g34yIbqvnzgKMYE1gYJ+seta65i4i0kzSkcAa6A
         WxTUh/wHyXvKl4S2MlKH0YygT+di3KK9yVkHw1xLuy3NczetuU+OeyWWsc6NdfO/YSvt
         ML1Gl3xy8yEu3WizVGdp7ZBvk4I/M5SN4lRZIb2NLgkHO8ngvB5NaXWe3gCea6DMXrkU
         67Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712146280; x=1712751080;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/6jutSMH9HOi65qZAuauoWMsdofEyugP9Pw6B07T3Q=;
        b=g0k/gT+OKQrtVMal0CIhpzoCOOfyth70BJ09tEkE4U0WTUcbI/rEOvnEsMSSEummgO
         qGL0knUq/EvGWH3bv58O/GJDI99P00NBJ/2o4jCWZdTFzmeGgNOisvzk6rIlci3zU/7S
         G+3+nNrPnewcDz00jQdr/cFZXBVnnKri5HwVtpidpJ+cVwE59SxI6NePiKrMPmhZNZWA
         wBgZcuTVlxWFIu2OOmwcgZEwBnvo/6MHZVALz337jXhcH31gca3FZtuc8Wg7HNSvtOCE
         ZV/7Mgo0/oOdAUADUPmF+T9r4LKVds2Gp384j50XpaEv5LKKvit1lpnIMA89CEk9vRqi
         w0jw==
X-Forwarded-Encrypted: i=1; AJvYcCXyifWxlkpdkL7Gz3bJAQV7GtnAUiXVbcB5xcbHbGFsWRxjCkUjGPFhsOhiraulB5MC/+lcghSi6trcuoSL7fXOBR1f0//l11bvN2/hrHYn
X-Gm-Message-State: AOJu0Yy0NHwuqEqumRz3CW+d78LXXOZUTVL7aFJ3Rk0R5pefS9CYymfE
	GorbSzbXZAWzHqi27vNZNQiHQ6qOAH4oHBMcKXJHVnpHWlZQfgmkznt1OBS3QoA=
X-Google-Smtp-Source: AGHT+IGkm3/n0mQbHm6UaH2L78GSMSCfKZoZ8m257TT2XTg51wvJGKb4jYOo5jokHdvhLRoeyalb5A==
X-Received: by 2002:a05:651c:83:b0:2d6:c749:17bc with SMTP id 3-20020a05651c008300b002d6c74917bcmr3711259ljq.31.1712146279752;
        Wed, 03 Apr 2024 05:11:19 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:158])
        by smtp.gmail.com with ESMTPSA id gy16-20020a170906f25000b00a45f2dc6795sm7666878ejb.137.2024.04.03.05.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:11:19 -0700 (PDT)
References: <b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 bpf@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Add F_SETFL for fcntl
Date: Wed, 03 Apr 2024 14:05:41 +0200
In-reply-to: <b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
Message-ID: <878r1ubq8q.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Geliang,

On Wed, Apr 03, 2024 at 04:32 PM +08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> 3rd one.
>
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 024a0faafb3b..34d6a1e6f664 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -603,7 +603,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>  		struct timeval timeout;
>  		fd_set w;
>  
> -		fcntl(fd, fd_flags);
> +		fcntl(fd, F_SETFL, fd_flags);
>  		/* Account for pop bytes noting each iteration of apply will
>  		 * call msg_pop_data helper so we need to account for this
>  		 * by calculating the number of apply iterations. Note user

Good catch. But we also need to figure out why some tests failing with
this patch applied and fix them in one go:

# 6/ 7  sockmap::txmsg test skb:FAIL
#21/ 7 sockhash::txmsg test skb:FAIL
#36/ 7 sockhash:ktls:txmsg test skb:FAIL
Pass: 42 Fail: 3

I'm seeing this error message when running `test_sockmap`:

detected skb data error with skb ingress update @iov[0]:0 "00 00 00 00" != "PASS"
data verify msg failed: Unknown error -5
rx thread exited with err 1.

I'd also:
- add an error check for fnctl, so we don't regress,
- get rid of fd_flags, pass O_NONBLOCK flag directly to fnctl.

Thanks,
-jkbs

