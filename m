Return-Path: <linux-kselftest+bounces-13886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB793502A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 17:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456DF282E32
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B221448F6;
	Thu, 18 Jul 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RfPyJT1k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445A6F312
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317720; cv=none; b=PVtnUoBqfqM8ZQLrUdBLbr4tpPhU/D3/QnKmemM3zRTbBMqQ9SQo5bQcjxc23uy7fyNYWlSv34/gKvMXLgv6MAipnyyZXnR6bgJ0wjYPavWjAM/BCKJW8435GC+iQSYOkjQkuN64V/5poCBAKrOGyO69gTfIlApFXu/PYZYBWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317720; c=relaxed/simple;
	bh=N4NafWiJVnP1G9rk3JnOz5c3tGQd7s3GEI4Ga4+SnHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2H7M6CxyHiWCNix0vO1AQKnRgWcM4shQxln0mbz1Md6pQKuFJ3jyM0CSfGv6Hk+UkBXO2m9tICoL2QctdEBTWg3omYCGePmfBvybU1i/mjlxPDrJ2pEMRal9l4VkGfmmqYYQwBcceNMafrv5qNZw2qG5B8fEfVHrJfi0kkeeaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RfPyJT1k; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39633f58414so488985ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721317717; x=1721922517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu/hFtc8rLkm1iv/03/RXKvj2O6JntzacsCG00S9+0w=;
        b=RfPyJT1kcOKPNN7Sm9j2xTYD6SCuYRtERisjmpyMWsASaesNFV8s6SXzYOSo5514JW
         S3muiXpNe2sX9z0c7V+rFBNUv0OXdlIP2K9VrJajH+G5c0fH3u1PqRVrSJ4O7zj0kena
         hrHdgF1K/P5s5WF75s0ZZYQ38sZW2eOMSt3Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317717; x=1721922517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu/hFtc8rLkm1iv/03/RXKvj2O6JntzacsCG00S9+0w=;
        b=Io0nVORk9DUp823qdm/ALtx6BxtlrL+8CG1hKnuGmRTfchgoPY9HqlWsGFOKc3oGY9
         PfjTNwPsdnVwVu1kdQ0DAphwDRbF7vgmJV0e7QkWpL3jd9rxoDbVppzCdvC8IrPVRShK
         4VPya8JWYyrclmvMM3JWEkr+mkN/5s+JYiC+1JOqhPmSQarnK2E2NRyaIz0Fmp08RBr1
         NBmxI4LHclji3YXt47qdOO9yGSuX4eyAZfOq+f1tqpX5v6uJK3hSUk3dnO1ztxsgEfXT
         4e1PO76/P0CRqfPPXlue4uCyA5aoU6vDalCRZPYTlOyZr+e2uXLPVjRPDnQerS/1tnJV
         dMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDGEelsbYA0aIZerODNaOBXpa1vteGIRmvshEkdZGufirlobBgnsVVrR2YzrkCf8N+x26x8vk23eBfdG5dkiQ2cBallBbr6yQUPPVB7CfR
X-Gm-Message-State: AOJu0Yx1WeOWX7yrsc+lhrLYLGxLo7JSmTHezfoL0jQG7sajD3GZW3AJ
	p60mTn2db19IX5alfeGVa64OYFGi8IWd0RnkLQxHh0Vr/pS0nsTnRvjAxhEn5i0=
X-Google-Smtp-Source: AGHT+IHmMdklMnDvF81muBrH8Y8NYIzffDfV4N4oKaFAtm0kA/02HZYqEw0UAHd8izBu71UsG/SmHg==
X-Received: by 2002:a05:6602:1dca:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-817124ec4ffmr365101139f.3.1721317716717;
        Thu, 18 Jul 2024 08:48:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c35da741sm149375839f.49.2024.07.18.08.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 08:48:36 -0700 (PDT)
Message-ID: <6a477f29-3425-434d-88a7-b3d619fef2b8@linuxfoundation.org>
Date: Thu, 18 Jul 2024 09:48:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] selftests: x86: check_initial_reg_state: remove
 manual counting and increase maintainability
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
 <20240718113222.867116-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240718113222.867116-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 05:32, Muhammad Usama Anjum wrote:
> Removes manual counting of pass and fail tests. This increases readability
> of tests, but also improves maintainability of the tests. Print logs in
> standard format (without [RUN], [OK] tags)
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - correct description of the patch
> 
> Changes since v2:
> - Update description of the patch and add before/after output
> 
> Before:
>    # selftests: x86: check_initial_reg_state_32
>    # [OK]	All GPRs except SP are 0
>    # [OK]	FLAGS is 0x202
>    ok 5 selftests: x86: check_initial_reg_state_32
> 
> After:
>    # selftests: x86: check_initial_reg_state_32
>    # TAP version 13
>    # 1..2
>    # ok 1 All GPRs except SP are 0
>    # ok 2 FLAGS is 0x202
>    # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>    ok 5 selftests: x86: check_initial_reg_state_32

What's the output you see if you were run this as:

make ksefltest TARGETS=x86

How is this different from the output from the above command?

Please provide the same information for your other patches in this
series

thanks,
-- Shuah

