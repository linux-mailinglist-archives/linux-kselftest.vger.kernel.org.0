Return-Path: <linux-kselftest+bounces-10938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8318D521B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689FD285029
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968986E5EC;
	Thu, 30 May 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILMPnuhG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A56D1D2
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096200; cv=none; b=sbAkHo2ezeXeqLGSOmAz7rnLja7/lxXkqtIB2ReX/aps7ZruNcKcapjOHlWYchBMPhdW9rkkzi32oS0oaEysGpZ2e6wgNWIaHJywy398bVxeWoXHhvt5iuyzXvTD+FHdGgFtsT3fg+BeCbgja36REMjgNInGnO824OIcdkTYQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096200; c=relaxed/simple;
	bh=xDFSARpGqCzo0/7RFIXaYWJVdeCDcGwisUU1BrK4egA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beiJgYi5b2pVkorqH9f4QfkBXjriQoOuP0wsYrDaCJBAEDU81yysc48jyv5hPGca5XO1J0NlizKIZpzwdsKixCp8TvB+bWIe65SB26s1gx9k6beuWyAvgItbnSURC01ty3oc0cFDerGedyanz6l1W9/HwlRPByS2GgUHJcR28Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILMPnuhG; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e22af6fed5so7312639f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717096198; x=1717700998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcKB/OzN80KdCv2vfgGkfs7hKHO3oNyK2DZlDHQX5Es=;
        b=ILMPnuhGFVYOy/ypbr/FlTznuN1Y7K8DGO93XpzOsTfj2KsQZ3C2s5cG9R9DU2Ib5e
         XUcwjvyLDdSHiW5sZ8nCAM4PMeuzH4wpUgNaQr41DUGvzQMVZRJuR/hmpgCq0EkowMVc
         TFapqL6TRIwDVUmj7jN6MO1lFxpdsRWMvrxC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717096198; x=1717700998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcKB/OzN80KdCv2vfgGkfs7hKHO3oNyK2DZlDHQX5Es=;
        b=AR2I+t6UtW5tWcjPzOdm3wpRyQo7SerTKVCSungJ7HfmufFSDhIXQ4oJQP99A0xUhq
         W74zsS5f11vJPAzuh/wYYhI4Bzomv2qPkIAj4Ou7hkHvNnoDXsZ6XDos1IA1kXezZGIt
         WnzuKka7o+n148kVouAqAgitXP4+eH6DW+foghLin3QoucBBtMUKwfV9bO63ze+gazcQ
         1W/q5e2ZMd8Gpxb1TOOgYJ8luFvzd2jUL/MNOqTdlcJSsc5QGj6V9y/QBZFmvEfb4O1Q
         e5/BtfIu2BjeGr8SO+o9Cogho1dfnXbDvZP0QSXY6QxM6Gy6qj1aScWuR9ItnhzFcgJ8
         CALw==
X-Forwarded-Encrypted: i=1; AJvYcCXob0FeteYsmeIsaY1J7hH0aK+OCwVSKmwOtbeR9OV3pjJzHKtT5LyGJ3T98P29kpBMlQLmuU8MEwM6KNpu9nRN0h+e24gM3gAgo5BR7zuQ
X-Gm-Message-State: AOJu0YyD5teteiZmgwCvQ08ni9Sl8zOekfKXKPaELce4OnXiBCMzBF53
	B8ZVj2sGwKkoX2hU4nlpcu7c9KmYI3ZiLkLyDuT2l6zcgXDm2IR6uNhmxm65S54=
X-Google-Smtp-Source: AGHT+IFkN8Ai4VWwR2PnmlSq/IYFOdiHtE3kJJIeH5v5Cghihl734+b5MpoKYjTzHOlYkXDDq77yvQ==
X-Received: by 2002:a05:6602:6426:b0:7e1:8829:51f6 with SMTP id ca18e2360f4ac-7eaff5e2ca8mr14707139f.1.1717096198165;
        Thu, 30 May 2024 12:09:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b488e4b35asm67021173.79.2024.05.30.12.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:09:57 -0700 (PDT)
Message-ID: <a56e4c6e-fffe-4c88-9bb2-8bcafbd91fa6@linuxfoundation.org>
Date: Thu, 30 May 2024 13:09:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] selftests/futex: clang-inspired fixes
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <b6641940-f10a-4ed4-a672-69c6d51125a7@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b6641940-f10a-4ed4-a672-69c6d51125a7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 08:23, Shuah Khan wrote:
> On 5/28/24 20:29, John Hubbard wrote:
>> Hi,
>>
>> Here's a few fixes that are part of my effort to get all selftests
>> building cleanly under clang. Plus one that I noticed by inspection.
>>
>> Changes since the first version:
>>
>> 1) Rebased onto Linux 6.10-rc1
>> 2) Added Reviewed-by's.
>>
>> ...and it turns out that all three patches are still required, on -rc1,
>> in order to get a clean clang build.
> 
> Thank you. I will apply these for the next rc.


John Hubbard (3):
   selftests/futex: don't redefine .PHONY targets (all, clean)
   selftests/futex: don't pass a const char* to asprintf(3)

Patch 1/3 and 2/3 please see changes requested.

Applied to linux-kselftest fixes branch
   selftests/futex: pass _GNU_SOURCE without a value to the compiler

thanks,
-- Shuah

