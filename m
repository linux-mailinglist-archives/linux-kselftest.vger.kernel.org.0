Return-Path: <linux-kselftest+bounces-30383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965EA81902
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 00:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0F03AE32A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626882566DB;
	Tue,  8 Apr 2025 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TM51klGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0D2566D9
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152485; cv=none; b=aDVTl9KdPFSyvkjJ/fVa7YqS4koyVdDXRixmdoc6j9rTTlVoftFuUnccpmuP2p4zsLMEez9KjursETwMYGc70qezTczytK3Uvn3uZTzPUbB5/GdS/w3jaQI6bL/bWLBB8rGiu3yrn+M+fh0+VLB/pKGX99ZZVe440WsEi3ZnHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152485; c=relaxed/simple;
	bh=y8+CvYLiEM3KjA1U3H6Z9Auf+nQ0YwmBzELzoP/gG1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhQjtNJyKUoBXJuRZ4owyokz/RMvJBez8YiVtPgCxnEPMXfztWedQtedrClVUIPE5EvHK7v0/bMWQuCOzP8CFirJ8TuE+wf757ehg4z18UoJ/Y7xvO8Ph++9+4yp07Y9XAAeyEkHGQkm1B0NKlTGDTaDoboOg26cnNlDe8ywAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TM51klGh; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so28318735ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744152482; x=1744757282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qApWvkE8mya8gnajvL4RevZsfcaInJhP7Ceavgsce2A=;
        b=TM51klGhQWpo2u+3VIwGR325eG15VRbHE1vdcQJslVVHhA18+VY3cFatnOhI8fPeih
         XfkMhlFN6oqM1py1CjZiqdxTFTybXd3yW+eomzMvF8R2aJVEBfG3gAt/4QXuduuA+A2b
         pYivClFpTc5kyrp1W3wfHI1kzc2auNAw7ZDgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152482; x=1744757282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qApWvkE8mya8gnajvL4RevZsfcaInJhP7Ceavgsce2A=;
        b=g3iqOXILKwqcZLmJpMSV3rWzZQyyHYPrNVf85tBVS+pyIFnT7aGTeBdMc43BROuDVd
         bpaDyAvv0l1VpcBpl607vZspmMk1xTyd5qzIZkbhkVWET1emNhViq+Ib9XngRtI/I/ya
         CLv12rDI5CrQ6mcrnMfr5f+gzDTuRfO7xxgwkj1WFyAuKn0+IjKAbVBVD459ssf5yodc
         ILN8tT5HEP28eHdiFn/pKBfqDW2JTXat1m9+gN+Yo/kuZiyjZ3MdyRLmYiwFGlbHQPOM
         9V9TOpmRtxuC3GV9opaidOA6O0F6BNLoOph2O1WJVsNIP4RC54h7Rao0wLRTTCRybeWD
         6/8g==
X-Forwarded-Encrypted: i=1; AJvYcCV4JXxGSzWvUMRwdyxiAko+pk/FUw9G7kr6yUHIr5h8Wb+Hekq1Ev88GDEnJ50pCdrMftWFonOcCJa4IMvjXGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WsamY2YZb35xeO4VD3iCSGi2CGwDRHNZ+QtrXf1MXeSwkzjC
	xD3PtQZhPj+Vb4wfqFZi8alFop/hGh8GuqpjtBb8hfxfTECbrmw59m4m1+yWUj8=
X-Gm-Gg: ASbGnctitBKJQFtW5gjKH+2uHjMvA4u9eU+Wh1X26wDogKAOpkyAfU5aHpStVvxqPMx
	gR6iC1K2Oy7lnrVtrgEs+/Mvy1DJKCGDjnYGo/6MNQOI9CaY3HnIxe3oTmycDz4BHRgjgZStJqh
	4LWZ1mE62OScWIEcRbNKyCA6UNsHLktuvpkHcUSk5QA9vVeekTtQpSvlm4gvVCH/vcpj3rBPEbc
	rny5G59VMeAXS53ANMFrQrP84jyiqkxHrJnYZrUv9hZVmuCsFEEpv+2JNmS7fyum/sDIOjZ1I4j
	YVUJgtPl4GHMa3i8LgoL1CMTEejLDpiVJZwQpo/mLGmqpnoaEml5Amc=
X-Google-Smtp-Source: AGHT+IG23EEm2QBJqLMY7MUecoZNLZpu2SPnxQB0VkemmEKLyn83DujZHxWYhEbMsa3U0tEJsaD81Q==
X-Received: by 2002:a05:6e02:250d:b0:3d6:cbed:3302 with SMTP id e9e14a558f8ab-3d7b45fd041mr3850745ab.2.1744152482461;
        Tue, 08 Apr 2025 15:48:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f43d31cbsm719034173.36.2025.04.08.15.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:48:02 -0700 (PDT)
Message-ID: <803bf3ec-08ff-49c5-8bf1-1fa27f2477e7@linuxfoundation.org>
Date: Tue, 8 Apr 2025 16:48:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/pid_namespace: Add missing sys/mount.h
To: "T.J. Mercier" <tjmercier@google.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250407225953.1540476-1-tjmercier@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250407225953.1540476-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/25 16:59, T.J. Mercier wrote:
> pid_max.c: In function ‘pid_max_cb’:
> pid_max.c:42:15: error: implicit declaration of function ‘mount’
>                                         [-Wimplicit-function-declaration]
>     42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>        |               ^~~~~
> pid_max.c:42:36: error: ‘MS_PRIVATE’ undeclared (first use in this
>                                    function); did you mean ‘MAP_PRIVATE’?
>     42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>        |                                    ^~~~~~~~~~
>        |                                    MAP_PRIVATE
> pid_max.c:42:49: error: ‘MS_REC’ undeclared (first use in this function)
>     42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>        |                                                 ^~~~~~
> pid_max.c:48:9: error: implicit declaration of function ‘umount2’; did
>                 you mean ‘SYS_umount2’? [-Wimplicit-function-declaration]
>     48 |         umount2("/proc", MNT_DETACH);
>        |         ^~~~~~~
>        |         SYS_umount2
> pid_max.c:48:26: error: ‘MNT_DETACH’ undeclared (first use in this
>                                                                 function)
>     48 |         umount2("/proc", MNT_DETACH);
> 
> Fixes: 615ab43b838b ("tests/pid_namespace: add pid_max tests")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Change the short log to include the subsystem. Send v2 with this
change.

selftests: pid_namespace: Add missing sys/mount.h

thanks,
-- Shuah

