Return-Path: <linux-kselftest+bounces-13409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE692C504
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 22:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3461F23360
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567AC152E1D;
	Tue,  9 Jul 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNiLcKjE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771913EFF3
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558514; cv=none; b=MlqZBhL3Nc+MwMyOVybyjrXPcyxtK0k5fRYsIOL4ZLaII9sY69LOR5lQy4gVEPuAAlJZ2/8klFsz6B42kF2htY0iZFOH1sRULQoXDpUo28ZgavcF8Fsz+P9rGnDtc8/iJR6xHsrE+2+mKvnXmo3x3jJBn8VyLchGrbsYCspLiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558514; c=relaxed/simple;
	bh=o+kjmggQJg9k2C51wKggJKaDqzA0Rap7ZoYOuaO1xOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDS95/Jmp+3ZmtujUiHvGv4mOxHrEmovg0nJDeilvVnyc0r6yfDTIGi0AIR1xr7nwImIhecTOCw/Gi/PddG0vpWedfsvmDa6EeHjgO593GiO5vA7BiYa7JEXDvUGbh+3/Tq0f7qGEUPyUFoOFG7ZjK/eKHuBRtN5Cyiuc+vqlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNiLcKjE; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f95c28f2a7so9848939f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720558512; x=1721163312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojllmUSpZm6yrskg60MuCouRkTNtpmyHnalLRc4XlN0=;
        b=bNiLcKjEiUicPQpwDjybJj6Lon+olKxM1ydDuvjC7guaewUnyn5aZUS05xgkjKczZN
         Ej6O5Xona0klOgQ+NW6G47+pdn45/caQt8deL0U6PXNPKwuIKTp5g+lcNkZP8mRu9r9H
         5b6XikVbGlz8OYIhyObqanUOlMIcEbNdjq/gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720558512; x=1721163312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojllmUSpZm6yrskg60MuCouRkTNtpmyHnalLRc4XlN0=;
        b=U6WpA5OxcE+Orje/ZXquprrGI9eTcBnnKnVw9Gq9gRK2WtUFu6n98jNwSA/a/CnVQY
         rURLY56LZxANED2dsmKSSkQEdFYUmXZANc5NqGtIU+7FWzCeBxLt9+gzD7anLEPmKUi9
         HrjabJTpohdcVTZb5J5Pn5lTToAv1QOtJhHv7uCf2Zzr0bful/c5vN5/Iecizha4HTY0
         BLAQG3250sl4PNEPI1g+0mLIj2aNS7xpSb46ZPjuIFm26Xth6zEGl7N8V0IaO4MvRkVO
         SBwn2e4qHCX5ztNhpYWX9gicC1xeV+gV8vUpGmed+cm/YDJcmmHQmz4d0Lsm7HMaRrm7
         L/1w==
X-Forwarded-Encrypted: i=1; AJvYcCVg6XB1nw0sGgS26Ln23IEKkQvOrJhiGPKZNH5f1kBIFrAREXyR1Lv2psvTEXt57fLXRKPjPBjFxf8Geo5BV+U9hy6vXcz5DXBGF5uObAdb
X-Gm-Message-State: AOJu0Yx8sOhJwC/KR1+F4mRPKQ9U+y/2Zn63pEHC4xdWFquJ8JbLQEZX
	HSYAHMz6LW84i0eM8hjRoBm61ZEXAonZ/29knLGfBmN0kPva5GuSAhuBfteqIx0=
X-Google-Smtp-Source: AGHT+IGsTMwpROjo3tzdIGl+v6KmheqJ1Zkqq2lQFdbmodzrdfcJ5ZovcBQXKo9Hg/rrSAQ8WBlnZg==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-80004dea088mr421983139f.2.1720558511891;
        Tue, 09 Jul 2024 13:55:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1b5c55fsm687026173.77.2024.07.09.13.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:55:11 -0700 (PDT)
Message-ID: <0ce444f4-8d49-472f-a687-34804347296e@linuxfoundation.org>
Date: Tue, 9 Jul 2024 14:55:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
 <a08e6846-2f9e-4fb4-910f-b33fe779fa01@linuxfoundation.org>
 <49c14f8f-0c08-41e0-b987-7c4253edf6de@nvidia.com>
 <78c3ed1e-32b2-43aa-9979-0479fa524018@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <78c3ed1e-32b2-43aa-9979-0479fa524018@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/24 14:51, Shuah Khan wrote:
> On 7/9/24 14:40, John Hubbard wrote:
>> On 7/9/24 1:34 PM, Shuah Khan wrote:
>>> On 7/4/24 01:24, John Hubbard wrote:
>> ...>> Muhammad Usama Anjum (1):
>>>>    selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp
>>>
>>>
>>> Usama and John,
>>>
>>> I am seeing checkpatch warnings in this series.
>>>
>>> v4-3-7
>>> WARNING: externs should be avoided in .c files
>>> #210: FILE: tools/testing/selftests/x86/fsgsbase_restore.c:46:
>>> +unsigned int dereference_seg_base(void);
> 
> This one looked new though.
> 

Never mind. Looks like there are a few existing warns - pulling
these now for Linux 6.11-rc1.

Thank you both for fixing these.

thanks,
-- Shuah


