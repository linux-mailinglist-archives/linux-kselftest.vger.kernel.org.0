Return-Path: <linux-kselftest+bounces-17181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8196C973
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BC7280D41
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000515533F;
	Wed,  4 Sep 2024 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCQJLvn0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747616EC0E;
	Wed,  4 Sep 2024 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484569; cv=none; b=o2O3GL7kfns15rU0Tz75LRG/IMXQ0y2ix8APzmK/FL74/VdH05lApp0KMYGlZiUWHhX5ItC+lqMSvxcMPc5yTJ+QKFYatDZpGf8XF5O1vbON1YvaLz/VFV5l7uEQSEaSG1cWD3XES/+79FzvmkVMQH8FsCmIP4zlMZYTefwNvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484569; c=relaxed/simple;
	bh=XIOhPWNCZD8THUM03rXIiWUsk22pZIjsz1jB60svhHA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q+Q3vB7hk3wPWeSA/7JTtkpoi6jVThWga4OIUTZ5k8meBHZb3PspxrcSQ9ZJLoUKvUKdCDzDbvR/gf4JtLBpSqKdGxGxesfqsxsAo5h2FeeTdUqc9d8HM+4ZgdgYvj3UYBO48TTFxne4kf13gimEOz1a/wUx0A52QWfSYWhStF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCQJLvn0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4567587224eso523071cf.0;
        Wed, 04 Sep 2024 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725484566; x=1726089366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR5HwwybxGpjog3v5EIhBzghqmw085R7LmQx7RMB1bg=;
        b=BCQJLvn0l8mIFcxdpNRVFN4TL/yytzLBT0zwmakaLzokVTZfkmk2CXfL0LgbakBMcS
         XEvgOFTlB3vyBuzGDKsDyELoZHmBKZH6O+V9+9yWhUnI+xzmB9wMD1t/AMf6z4CrVofn
         xUwZMiv4/RUUEXxWoX5s3Lc5y2dJ7Ebw69I3Rp73mYhDgHlI2Aj/ScwXKto4M+iFzgc8
         6wPL505HgcF9P5ObK2K3eXaxIjbXugIQP7JSDTN0bKpnay52w6CRiX5FDUehwWedo5Py
         pgUNT23yvX2FGWc5kfNS9IzkwxKy37z/nJO/+amtn2uGlfnJSKsUgh1D7yjBwjVSWxl9
         sF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484566; x=1726089366;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uR5HwwybxGpjog3v5EIhBzghqmw085R7LmQx7RMB1bg=;
        b=WMcbn5Y5y5SuHslCm40+WNcHMGXzTvte99LbIj7NEro7jbJBAYm3dBtIDVzUqDnfdV
         vaBTENP6kHiP1BY9uBd70iDFEmo9P0pPXOLXPHltnSCSmf0IqYQRQeY++bKsu/w1ny8Y
         CjjHqoxJuRR/NGbMkew5jW2F/4TvPr7KgfUCkl8Q0x7Xu0C1B1CqQqdCgexZzTAwgxB4
         QNPfQyMYB2KFGgv20qZflgggiCUj/pzQO7kEHwvSKIdCKf+i8Rhiyub2QYr4J725k70S
         LYuS23CHiR4eTXSD8CO4i1tKm8p8fVmRk9kBoh+j/79IOi8jAkYW4bx7RXq68R2p39R5
         Q4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVn4ZQ/NowBrmup5AaMBC+EpGf4/WJ4tC4E+PdCDe/c834bi94UmpHJPFeNydN+dq/ttARkt5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZA43lVqX1GmWDb8t0emelNnSSQWrvNYn5F3K77b7u9abjYIRp
	Ho5db1uwkZIT4E2eP8G0hujf1HUR63zqRvy2qZkusPOVsp7S+Fr2
X-Google-Smtp-Source: AGHT+IGR/Sp3g4z7ERDR2SEXAHfLWR7r6GYqgbL8KilaQEurX7TcnmOMvKNcxxgkZsWVOi8X5mRgww==
X-Received: by 2002:a05:622a:4cc6:b0:453:1afe:c711 with SMTP id d75a77b69052e-4567f55e9acmr226561101cf.28.1725484566018;
        Wed, 04 Sep 2024 14:16:06 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801a1539esm1885851cf.11.2024.09.04.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:16:05 -0700 (PDT)
Date: Wed, 04 Sep 2024 17:16:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d8ce15415ec_163d93294a2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240904144446.41274-1-kerneljasonxing@gmail.com>
References: <20240904144446.41274-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests: return failure when timestamps can't
 be parsed
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I was trying to modify the tx timestamping feature, I found that
> running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the fact
> properly.

Did not reflect what fact? Sorry, I don't entirely follow the issue
you raise.

> In this selftest file, we respectively test three tx generation flags.
> With the generation and report flag enabled, we expect that the timestamp
> must be returned to the userspace unless 1) generating the timestamp
> fails, 2) reporting the timestamp fails. So we should test if the
> timestamps can be read and parsed succuessfuly in txtimestamp.c, or

typo: successfully

> else there is a bug in the kernel.
> 
> After adding the check so that running ./txtimestamp will reflect the
> result correctly like this if there is an error in kernel:
> protocol:     TCP
> payload:      10
> server port:  9000
> 
> family:       INET
> test SND
>     USR: 1725458477 s 667997 us (seq=0, len=0)
> Failed to parse timestamps
>     USR: 1725458477 s 718128 us (seq=0, len=0)
> Failed to parse timestamps
>     USR: 1725458477 s 768273 us (seq=0, len=0)
> Failed to parse timestamps
>     USR: 1725458477 s 818416 us (seq=0, len=0)
> Failed to parse timestamps
> ...
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> I'm not sure if I should also check if the cur->tv_sec or cur->tv_nsec
> is zero in __print_timestamp(). Could it be valid when either of
> them is zero?

tv_nsec can be zero. tv_sec cannot.

> ---
>  tools/testing/selftests/net/txtimestamp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index ec60a16c9307..b69aae840a67 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -358,6 +358,10 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, int payload_len)
>  
>  	if (batch > 1)
>  		fprintf(stderr, "batched %d timestamps\n", batch);
> +	else if (!batch) {
> +		fprintf(stderr, "Failed to parse timestamps\n");
> +		test_failed = true;
> +	}

nit: if adding braces around one side of a branch, then add to both (all).

This is not so much a parsing failure as that no timestamps arrived.

More importantly, this function gets called also if
recvmsg(fd, .., MSG_ERRQUEUE) returned 0:

        if (ret >= 0) {
                __recv_errmsg_cmsg(&msg, ret);

That seems counterintuitive, as there is no data. But this was
introduced with cfg_loop_nodata (SOF_TIMESTAMPING_OPT_TSONLY). When
there may be packets looped, just 0B packets. In those cases we also
expect timestamps.

But, can __recv_errmsg_cmsg now also be called when there truly is
nothing on the error queue? It is a non-blocking read, after all.

Judging from

                while (!recv_errmsg(fd)) {}

The caller can. But if there is nothing waiting it returns -1 with
EAGAIN:

        ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
        if (ret == -1 && errno != EAGAIN)
                error(1, errno, "recvmsg");

So long story short, subject to a few nits your patch sounds okay to
me (but it's not entirely trivial that that is so: sharing so that you
also double check, thanks).

>  }
>  
>  static int recv_errmsg(int fd)
> -- 
> 2.37.3
> 



