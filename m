Return-Path: <linux-kselftest+bounces-14465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1942940FF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEA41F21853
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C76195F1A;
	Tue, 30 Jul 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zki5zI4s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94A18A958
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336708; cv=none; b=ggX4IsALx5wlXn2DMF1MwWT0duG8SKa7J/bX9Ekl5SaRqcPwly9xzrEdxmfGusqdBZp1JIDrsDPxedbLEv2WNOq9KWai+MtpyinQjucbZO0CwWSeLSiDEOBCHyh7Ujdw4eovt3RXaOVjp5QPd1hm6jkYi5ZXbuQQ4S6TwGBE8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336708; c=relaxed/simple;
	bh=NVy6RN9UJ7x5SUNJVs+jH2G33Zl5cTJuJ6ZUmdQRBlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCmABGE+T7tn7Gq9YGSp0oOUvPYGPBIAKqOiIXoUHPfTIiifQVZnNjH5e7sq3IcccVHHv5zBMj334iJLw2bpQUu0Mf+bPWm9eZCfFFlryrjjONJBYhh0mmnpMMH2H5815UY/3Ekmzm2HuzPP7ylmFnlO3sWg3RnooId03Y+LCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zki5zI4s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722336705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hB8Q6mu68koU2jQoQEu66GSXIlhsKY8wiFrY5lywKE=;
	b=Zki5zI4snH/j2v7pUZSaksnKZ1BCwwtbxXe/pNCPU9WQP+b0vB6AASEDohwSGqcvdTLZJe
	wSvSB63Jm4XGuDPxoqfDoFWmVKppRnAYHRM25Bi6kKT+iuHBZHZtAZveTWrHE30NBCtjxZ
	zftqHJNhxCtUibQ/1mem1lxz39khMhg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Vz2sNfx_Mgi4TOlov6TqvA-1; Tue, 30 Jul 2024 06:51:44 -0400
X-MC-Unique: Vz2sNfx_Mgi4TOlov6TqvA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3684636eb06so111197f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 03:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722336703; x=1722941503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hB8Q6mu68koU2jQoQEu66GSXIlhsKY8wiFrY5lywKE=;
        b=WJLR6Fl68dWCXS0BMg74HEKPVvwY+dsQUIiX+UEGGJ0j26AiKmVSKDDypFJ9ZVlTD9
         qJ6lRhdpHK6LsvjUJ4LeVJr7M20lUHi8CkeQ7d51aKzKJAY1eoM/K6k+ALYh5+FI+QrS
         Nfo4n+uFfL7+4Gx7dwVkqHoByFlgduOac1zyVOXOtRtyv12h8X7SqfqCDaK/JyCxFIFr
         8Uy5SpxUV1WQ76VJo9j2uHNWA1yfy8vfQ2hBt0MutWQN6VTSGm0CLJpxN4Cq6G/RUmSS
         dALObG+9bIprpBEuPI3jep4yspMSUZbvOM9xLsUH1OPOvsO9XATIYd262OA35BSX+lVa
         ZSdw==
X-Forwarded-Encrypted: i=1; AJvYcCXv/IRZIOC9X9eJloKSuIzsH/T1zIgSjrRISdvVvYmCuvwPvEuWrPwbVcNAbXic4gvIqN3+oud8u0uH02pSAAQtQIb4usswPLldSyAFFwVr
X-Gm-Message-State: AOJu0YzdmJYPNbVt+X3IXOrB2rJWFMn6RTKRLenLylO6cnoNdiIWgNCg
	yPkhBbq6he5GOOapdOSnD+QiB+8l6Njgvt6NldP20tJU5U4NIxboJ0mXF7JifnFusEiIP0+1ox9
	hOUkz63MfSmvJ/HhtcwwJ6FjiT6IP8RaVjGfaSMxDOTTsvL+PAQcEuU5mGhPuGlt6uQ==
X-Received: by 2002:a05:600c:1c2a:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-4280542e12bmr73159225e9.1.1722336702741;
        Tue, 30 Jul 2024 03:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZaoR6bpS2N4mm+HmZ4X2wXHynNhoxBj3SH6BYXqnLt+gsQ3kywAuClBogEKuCnft44Z7HAg==
X-Received: by 2002:a05:600c:1c2a:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-4280542e12bmr73159135e9.1.1722336702196;
        Tue, 30 Jul 2024 03:51:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281fd617desm49917915e9.35.2024.07.30.03.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 03:51:41 -0700 (PDT)
Message-ID: <8c2835ed-9066-4adb-8f8b-f38416d97849@redhat.com>
Date: Tue, 30 Jul 2024 12:51:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net/selftests: TCP-AO selftests updates
To: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 04:12, Dmitry Safonov wrote:
> First 4 patches are more-or-less cleanups/preparations.
> 
> Patch 5 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> kernels to run TCP-AO.
> 
> Patch 6 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> the issue, but I hope it will fix netdev flakes for connect-deny-*
> tests.
> 
> And the biggest change is adding TCP-AO tracepoints to selftests.
> I think it's a good addition by the following reasons:
> - The related tracepoints are now tested;
> - It allows tcp-ao selftests to raise expectations on the kernel
>    behavior - up from the syscalls exit statuses + net counters.
> - Provides tracepoints usage samples.
> 
> As tracepoints are not a stable ABI, any kernel changes done to them
> will be reflected to the selftests, which also will allow users
> to see how to change their code. It's quite better than parsing dmesg
> (what BGP was doing pre-tracepoints, ugh).
> 
> Somewhat arguably, the code parses trace_pipe, rather than uses
> libtraceevent (which any sane user should do). The reason behind that is
> the same as for rt-netlink macros instead of libmnl: I'm trying
> to minimize the library dependencies of the selftests. And the
> performance of formatting text in kernel and parsing it again in a test
> is not critical.
> 
> Current output sample:
>> ok 73 Trace events matched expectations: 13 tcp_hash_md5_required[2] tcp_hash_md5_unexpected[4] tcp_hash_ao_required[3] tcp_ao_key_not_found[4]
> 
> Previously, tracepoints selftests were part of kernel tcp tracepoints
> submission [1], but since then the code was quite changed:
> - Now generic tracing setup is in lib/ftrace.c, separate from
>    lib/ftrace-tcp.c which utilizes TCP trace points. This separation
>    allows future selftests to trace non-TCP events, i.e. to find out
>    an skb's drop reason, which was useful in the creation of TCP-CLOSE
>    stress-test (not in this patch set, but used in attempt to reproduce
>    the issue from [2]).
> - Another change is that in the previous submission the trace events
>    where used only to detect unexpected TCP-AO/TCP-MD5 events. In this
>    version the selftests will fail if an expected trace event didn't
>    appear.
>    Let's see how reliable this is on the netdev bot - it obviously passes
>    on my testing, but potentially may require a temporary XFAIL patch
>    if it misbehaves on a slow VM.

It looks like this is not well digested by the CI, e.g.:

https://netdev.bots.linux.dev/flakes.html?tn-needle=tcp-ao

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/705502/8-restore-ipv4/stdout

BTW wearing for a moment Cato the censor's shoes, I note that patch 1 && 
2 commit messages are quite more informal and less informative than the 
average;)

Thanks,

Paolo


