Return-Path: <linux-kselftest+bounces-28335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1FA50CDA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F79188582F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5650B254B08;
	Wed,  5 Mar 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGbEPJ1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897B24E4B4
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208142; cv=none; b=r0FWWGcPoZ2P6/XWeZCPS5OganaXL8teJHiyx5GxMwrVs1TOk3Ck91sNJ76G+ImZvG7M4inJKXmb9JxZbOj6Gm7h6YMMVUZDkbe1L5GH9uAjly3X8JIxqETTNWYUojzAWjSE+POpG1IPiSZrgNjY4+SLQDqnozLxaalBD6vqLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208142; c=relaxed/simple;
	bh=bSmgTlvwLJjJS9L24cNfFPZSeRDSXYM8VhcAjGh++W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+Djcr0fFtYF80yC9wr69BWTdA7fCHBzOiTGWFGRjkFYsWJEJCi84DpLNI3ToA0HR6xpVjzFqJppOw1SMS2ni3iPcIRn82eDY7CykXDcQ/mzclnX4ju87P9j5dBeoLxL6dJZMqHwXdqSPsgVSclDDEXs61zUz5/dUwDGmW2x070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGbEPJ1R; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d284b9734fso69935175ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 12:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741208138; x=1741812938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TN8E9XEAktH2/BlknMuwwP6SKex4SrVTEApM/n+g1SI=;
        b=XGbEPJ1R7diNBroP0CN6KuG3oDaIZIARDkDbd7KK9q6gXIThtKdR2aB/nhWq6FP83Z
         aBcq0e19AJwODJ2clkq39Bmfp64X46zlcE4TNOXoakQWX+So5096ODQH48YQh84WotK/
         S/e1aPqVSAdDStSb1zJ9NprYw/dkGJ+9XwKAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208138; x=1741812938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TN8E9XEAktH2/BlknMuwwP6SKex4SrVTEApM/n+g1SI=;
        b=sPcdDrIJ8DiaxlIs9KfNp2NFYmlijeCXhTH7cuNcWa1PkOGjQqArhDBe2o3fMmOiA9
         8hPKFyVFyXoZQ7Kd9X0ROSTVw4b1gsweulVEsYb/GxcE4o4h6a9QBjT7y6pIJdbzEPki
         ah5qQPSxmWGULMwiqSHstlLlaJSgboCRHXaOmw9f9H/QgCh8csk7Q6b7LIjlTzFtSgG+
         FBX+q8zw845Tg9S3AFeDm8fCP1XD90xCwC6VHNGTcpLSoGmRGq44BTWoi/aAS+s914Tm
         4yA1UsiZVJafwahRdXw7Fhew/Vgujnf3ohJ1e2X9XdspPUU4VBHzryzKIlgSpEcAyXrH
         bYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLB+crrW2OMAHsrHhZscfNxNs9WYrionhiEaIwUzBI+i7wFrYqMOIchS9obooWibRxeE8gSP6j4Wds6R1B/Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3H8DHJFnQZZdDQMwzipMuicrcUFOk8+gQfoF83lMIkBMc55Q
	Www7ECWG2o2xMH5PE2n2hr1nplflzR/ZmEBLmjuosUKHvCMUbOiUVCeDvDoN000=
X-Gm-Gg: ASbGncv7Mu9OeLmxN5Mix7z7ObS2yKU6WCxEnVMotXi7cSLCf8lQ1vnfz8THNtBNVNF
	ojGrKZvAbx4aDf3/3YgzrwxQiBe9iD903fyG3hOFW9D5yhI8rgL8mhRS3s0C0wsKVCo0AVufGyA
	rlaP3bw6Un85o+1Yq5L0rZXvRFqaxjx1VGODLlxqCiTv+MyxYnk1XsXQf9ekfjSQdJqcGedsRIm
	8/2sDoISR7Nw9QpD6IT/HwOgJpLMfeeUvKAnM/2/YnRoaIf1NIDRkxgJRhUhCV0NUu0eBinSLjd
	9mRIWf+VbnwbPwac6AratSboNvKhz9NAIAGC0HEXI2gUK1d7L1O9Ca0=
X-Google-Smtp-Source: AGHT+IFrK0wfx0wuMhLxEg3F3kYX4kOQtUjrt8xsLzF6cSSoaI3+ZeJj3tJLZ7Y1D69zwAQp2NcUtA==
X-Received: by 2002:a05:6e02:1c25:b0:3d0:19c6:c9e1 with SMTP id e9e14a558f8ab-3d42b8bf084mr52134995ab.13.1741208137900;
        Wed, 05 Mar 2025 12:55:37 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f086a996fesm2503730173.33.2025.03.05.12.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 12:55:37 -0800 (PST)
Message-ID: <c82318cf-39f2-4b08-9eb9-7e7a89fbb34a@linuxfoundation.org>
Date: Wed, 5 Mar 2025 13:55:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [brauner-github:vfs.all 205/231] WARNING: modpost: vmlinux:
 section mismatch in reference: initramfs_test_cases+0x0 (section: .data) ->
 initramfs_test_extract (section: .init.text)
To: David Disseldorp <ddiss@suse.de>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Christian Brauner <christianvanbrauner@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <202503050109.t5Ab93hX-lkp@intel.com>
 <20250305114701.28c0ee0b.ddiss@suse.de>
 <20250305235601.464f6432.ddiss@suse.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305235601.464f6432.ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 05:56, David Disseldorp wrote:
> On Wed, 5 Mar 2025 11:47:01 +1100, David Disseldorp wrote:
> 
>> [cc'ing linux-kselftest and kunit-dev]

+ Adding David and Brendan

David, Brendan, Any thoughts on how this can be fixed?

>>
>> Hi,
>>
>> On Wed, 5 Mar 2025 01:47:55 +0800, kernel test robot wrote:
>>
>>> tree:   https://github.com/brauner/linux.git vfs.all
>>> head:   ea47e99a3a234837d5fea0d1a20bb2ad1eaa6dd4
>>> commit: b6736cfccb582b7c016cba6cd484fbcf30d499af [205/231] initramfs_test: kunit tests for initramfs unpacking
>>> config: x86_64-buildonly-randconfig-002-20250304 (https://download.01.org/0day-ci/archive/20250305/202503050109.t5Ab93hX-lkp@intel.com/config)
>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050109.t5Ab93hX-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202503050109.t5Ab93hX-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>>    
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> initramfs_test_extract (section: .init.text)
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x30 (section: .data) -> initramfs_test_fname_overrun (section: .init.text)
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x60 (section: .data) -> initramfs_test_data (section: .init.text)
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x90 (section: .data) -> initramfs_test_csum (section: .init.text)
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xc0 (section: .data) -> initramfs_test_hardlink (section: .init.text)
>>>>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xf0 (section: .data) -> initramfs_test_many (section: .init.text)
>>
>> These new warnings are covered in the commit message. The
>> kunit_test_init_section_suites() registered tests aren't in the .init
>> section as debugfs entries are retained for results reporting (without
>> an ability to rerun them).
>> IIUC, the __kunit_init_test_suites->CONCATENATE(..., _probe) suffix is
>> intended to suppress the modpost warning - @kunit-dev: any ideas why
>> this isn't working as intended?
> 
> Stephen Rothwell (cc'ed) mentioned that we might be able to use
> __refdata for initramfs_test_cases. The __ref* description in init.h
> does indicate that it's suitable, and I now see that it's present in
> kunit-example-test.c . I'll propose a patch which can be squashed in
> with the existing commit.
> 
> Thanks, David
> 


