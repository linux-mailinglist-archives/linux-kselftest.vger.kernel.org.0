Return-Path: <linux-kselftest+bounces-22134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85D9CFCB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 05:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266101F23BF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 04:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9819004A;
	Sat, 16 Nov 2024 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5tw9pYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7192F43;
	Sat, 16 Nov 2024 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731733188; cv=none; b=hKRMawpCaTqHCK7z56c6IvYPFYbJab3yPH/Um1QOSPF6VAVlu3hxKZRWNPjR8qw4kUjuh7DPeT+BLMtSIRHNUbziwSUCFWMjV5y8Lycqby/BeJw8qyz8naLtFD3WuntfO9K9wyw0uIuBTxaUDMbJVzP1ZYGRNoiMaZHIBepf/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731733188; c=relaxed/simple;
	bh=czEypLg5rhL/Hsmui2oum8LRJFVGZyIUxVUVv95gxLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCytBCXHuQbuFd84L+j6LuUro1dhWHefs8dlpBK3k127Qcwx6mVyn73gRxBz9txrsP7wZucOiAsn4Cz8Q1QfPgvQRcFvJKHDGPV4Revu6cDupvm/UkBc2XKLx9ULzXqNC54XYRq4bnx+2WSGq0OdLXADJEKQWoZUMe3ylhaUtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5tw9pYB; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-72487ebd2f5so191281b3a.1;
        Fri, 15 Nov 2024 20:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731733186; x=1732337986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgrsO90Q/kQR5moYmJrLgREwrffHDZ1CRD5mltXd304=;
        b=I5tw9pYB2gaVG7rej01kjHjO7NT8CxzEttTAKIsIOr98QLrUpMznbFp07I2yZl2I3j
         t5f6yFwC400XHAgLnbymaF5issUqIoH5tIQzhvu6yFObZYfOghsCn490/vt5JTtrC2sK
         XxYB/61NmMrEPjyC2LTg/kcB4LO4Wxp50tdsB/aKmVvfYiURUyOPKhPKp9Ifb1GVXocw
         PDce611YRbgCazsOw1GPWMvloFx4eUPCG434ZFktYRCAaLQfUVYx1yvixD2LwSijnfnd
         cj5sXZJnuLRcAfIYD3Q04QjeKoHSp7DyfJ5WEPGBchg0neCyNacHitejPCkdj8nXhml0
         Ucqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731733186; x=1732337986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgrsO90Q/kQR5moYmJrLgREwrffHDZ1CRD5mltXd304=;
        b=Jc4zJ2kecSU6lPgu2YKyxwsznBRXui04p5jz96rFj1PtyiwFG3v9BWE+FIHlYFrTej
         X8FisVmO4CbjGA8xsTJJRU/KWG+67uYxiFITrN6CRJiL4vr/kqwi2bDpdAkCn6CTO3hj
         xMiy23h/uBAuDQ4Yk1Og4KUNJIvDbxmcIAH3bJ4OGxPuWC7baACOSyucSLWXvwWH+zUu
         7mkyoRYCdgCstv5SUKZCvhCCaRXuzuwuLKMKJHh1Am2WW7LuS4uY+wgUMe0iTG84hGjR
         lMOvhWxAKn+O434V+qnHzsRytAlfP0qCFXU20JBq5Tx3HECeYrZpHLiN2JhpUcsQBUcG
         WPKg==
X-Forwarded-Encrypted: i=1; AJvYcCU7yQSOuNIq7ax+5jUoq7TOnW9SLU/HWBkN04cJDuxpQVKZG12PuddfPwsjtK/IyC45EHynDiJ0eJ6aL/I=@vger.kernel.org, AJvYcCWZQhWIhJfLnDnlxOU95DWAofipjR2OINUWEEQDP9Q+CKcJfVnzpZ51eldQUVjIgFb4KtZ3LhOV@vger.kernel.org, AJvYcCWoI5bwds0xSePreNQnd1gu3Knla8QnR3ghbHJ2BjYKM+VS5RfYkgRZhxHRLMAds9stkwUQgq3xgLy7BgQDtAO3@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlJWvvo8RGjK78umNC+2r3qRo6SeFUHn3mBuM4EKo35a8Ftyp
	2gkwAcwTHUObMTUTlEm6S1j+ny1RtyWX5u8MRzbPtwYswpKO0xjR
X-Google-Smtp-Source: AGHT+IE5OsztyYS/i0shTpCRiXJrtm/VlhUWHJatf18eVJCCA1Zt4i7TUBq8iVpmMCYTd74EAitrVg==
X-Received: by 2002:a05:6a00:18a2:b0:71e:2a0:b0b8 with SMTP id d2e1a72fcca58-72476b728e7mr6452195b3a.1.1731733186166;
        Fri, 15 Nov 2024 20:59:46 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:1128:c4a9:977c:8412? ([2409:8a55:301b:e120:1128:c4a9:977c:8412])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477139130sm2219678b3a.85.2024.11.15.20.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 20:59:45 -0800 (PST)
Message-ID: <4f9de1ec-8679-408e-a2d6-5baeac1618d6@gmail.com>
Date: Sat, 16 Nov 2024 12:59:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 1/7] mm: page_frag: add a test module for
 page_frag
To: Mark Brown <broonie@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Duyck <alexander.duyck@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Duyck <alexanderduyck@fb.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Aishwarya.TCV@arm.com
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <20241028115343.3405838-2-linyunsheng@huawei.com>
 <ZzYfBp0IO1WW6Cao@finisterre.sirena.org.uk>
 <a031f13e-a5ee-4db9-89a3-983b962c3c1b@huawei.com>
 <ZzdWuUgyAET1babn@finisterre.sirena.org.uk>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <ZzdWuUgyAET1babn@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/2024 10:12 PM, Mark Brown wrote:

...

> 
>> make -C tools/testing/selftests/livepatch/test_modules/
> 
> Ah, this one is actually using some framework support for building
> modules - it's putting the modules in a separate directory and using
> TEST_GEN_MODS_DIR.  Crucially, though, it has guards which ensure that
> we don't try to build the modules if KDIR doesn't exist - you should
> follow that pattern.

Will add a checking whether to build the test modules around the
TEST_GEN_MODS_DIR setup to avoid rsync copy error when the test module
compiling need to be skipped.

> 
>>> in the main kernel tree and enabled by the config file for the mm tests.
> 
>> As discussed in [1], this module is not really a vaild kernel module by
>> returning '-EAGAIN', which is the main reason that it is setup in the
>> selftests instead of the main kernel tree.
> 
> Sure, we have other test stuff in the main kernel.
> 
>> As above, I am not sure if there is some elegant way to avoid the above error
>> in the selftest core, one possible way to avoid the above error is to skip
>> compiling like below as tools/testing/selftests/mm/test_page_frag.sh already
>> skip the testing for page_frag if the test module is not compiled:
> 
> Since the tests currently don't build the test systems are by and by
> large not getting as far as trying to run anything, the entire mm suite
> is just getting skipped.

I just sent a fix for above, it would be good if you can test it if it
fixes the above problem.

I tested it with both latest net-next main kernel and older host kernel,
it seems to work.

1. 
https://lore.kernel.org/lkml/20241116042314.100400-1-yunshenglin0825@gmail.com/


