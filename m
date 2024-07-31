Return-Path: <linux-kselftest+bounces-14566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F23943574
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109C81C21664
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CA2030A;
	Wed, 31 Jul 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LKJgh6Vq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274B3A1BA
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449595; cv=none; b=mO8FQYFzHGuRWGSB3OQJO058bVnzTNX44i9t1duFl8yiAh5dRj2QeK4657NESt8YIfB0B6wGJipKBDoW4QZuAhW0bAu7xo8JWox01k1UCkeZwhwRjUxQbqV5BYci8DH6l2HXMuj0q9P/YxkGjSNLMUMf/znG+X+1DeRNevsNIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449595; c=relaxed/simple;
	bh=uQwOrxQmn4UWuOdYTz/ZFVXWCNeQRZ3Mc8Mz/PrYA1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5GhvW91Z/dJBh6wNxtwNFRBL0h3e6vb6o+eDUnAMtIMRCVOlNCPHYCA/mX1tBeGTOZ1f968/UJFV8U19Smyqh4hjzsloCoWQpAkFPKZHaeB1ZNhMa2LGVfJJkxHynKpnlC6BGlaZKWo+Of+BE7p80LT5n63NnFcU4oUGK+rJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LKJgh6Vq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f82478b70so32418439f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722449593; x=1723054393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9U9Aeo88raKDsbH9TG7H5YN1vzWt4rRDmAinflLvkZ4=;
        b=LKJgh6Vq8t2oIct4QSI7B7b0sjNqG9lQ5K41NH0USiieBt2LcX/oFy40qw5t8CAue0
         UkxRL1HxzeDpMxBWDm5WTV3lhaDAQDscwLKKY7gVPTEC25kpyxAwzGQuF24QT8C7kdzQ
         Y1c1l/rzJS6a9Y4l7J0QBqAzN9rnPOOFtxMhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449593; x=1723054393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9U9Aeo88raKDsbH9TG7H5YN1vzWt4rRDmAinflLvkZ4=;
        b=Gf+Xf4ZFpuDQgctmyA1DKJ0gQaljvdWnKfVm7E47wysiVzmUtD8wevLJnLrV9/Mfk1
         CmH/w0DrHI/Goy9OCBgEVMZSMScDXmKgR26h9feenBRa2j7SXgZCqM036tFPTLWX+0VL
         ptdrKPeOCD0VsNFA3cBaGE7Mr+f6mXznSaOuXSK4e1HTUljy1IpTy76YXjnAjniS4q4a
         gyw58MeFpYM3huv6tdossW6Llv/7l5ZBx4Yo5XcugIsurrIB3ulwztEx8TJ60QmtJI16
         cgoAG34m4ynGGtEku46O/qarSoHx3feqw8BnfqWBxoweQLD6uTz5/LGnyKH0OepbF+EY
         1Czw==
X-Forwarded-Encrypted: i=1; AJvYcCUJl+GEWyNOn8HS0JDqisHI1pxuUxMJyXO6oudZ/3MTJWV23y9DLWk/aB0aL7EsqcX5xAN5HWr/4/wuwNN/Y9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOp3VXJyyjgdBXZKrdV99wMea2Q+E7JSDMVbvmatWXkIMVaRT9
	j1x2Jh4XHiOPjySrQyZRjwwdG2G8ab2G7qFki6Gk7ef303/vXyWcUFafmNHg8Hw=
X-Google-Smtp-Source: AGHT+IEHDc/6KXUE+4h4v4FSTmQPsunt90tpxasZpI82+oz/OgCHb5Aq6q70sUiWXESPFmm2+pk1Tw==
X-Received: by 2002:a6b:ea0d:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-81fcc13167emr9584739f.0.1722449592803;
        Wed, 31 Jul 2024 11:13:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f88597d83sm390466939f.6.2024.07.31.11.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 11:13:12 -0700 (PDT)
Message-ID: <2fb7e346-f49c-4a4a-812b-2b6d3c0edd25@linuxfoundation.org>
Date: Wed, 31 Jul 2024 12:13:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: lib: remove strscpy test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725121212.808206-1-usama.anjum@collabora.com>
 <9d5c0793-e90a-4549-92b1-41ad06b85de6@linuxfoundation.org>
 <d26b317b-edda-4bb8-a022-912cd1f76b3a@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d26b317b-edda-4bb8-a022-912cd1f76b3a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 02:32, Muhammad Usama Anjum wrote:
> On 7/31/24 3:37 AM, Shuah Khan wrote:
>> On 7/25/24 06:11, Muhammad Usama Anjum wrote:
>>> The strscpy test loads test_strscpy module for testing. But test_strscpy
>>> was converted to Kunit (see fixes). Hence remove strscpy.
>>>
>>> Fixes: 41eefc46a3a4 ("string: Convert strscpy() self-test to KUnit")
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - Remove from Makefile and config file as well
>>> ---
>>
>> As mentioned in other threads on this conversion to kunit and removal
>> of kselfttest - NACK on this patch.
>>
>> Please don't send me any more of these conversion and removal patches.
> This patch is removing a dead kselftest as its corresponding test module
> was moved years ago (in 2022). This test has been failing since then. It
> seems like misunderstanding that I'm removing something.
> 


Thank you for the clarification

Applied linux-kselftest for Linux 6.12-rc1

thanks,
-- Shuah

