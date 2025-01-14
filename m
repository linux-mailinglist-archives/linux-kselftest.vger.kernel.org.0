Return-Path: <linux-kselftest+bounces-24538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755B8A115C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 00:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2392F3A1048
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D521420F;
	Tue, 14 Jan 2025 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3BoAAcV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A498218ADB
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899118; cv=none; b=JxfWzRJ7VqzHNDVE+iyEGaa6f+cvvN48tFqxPjV61wXqaK6Py8Jus22m5OXhR3SeXM4FlIOREgtXkVIb371JZMpxs71rEq75b6U+vDxt+isdWb7MmMYjlc2mjxcq5UM/KC2zxYDYxFz5yQTqAc/W6fZ7igCLQXeMMhC5FDkyuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899118; c=relaxed/simple;
	bh=cwhi7Y7gDXB8FS6VjttCPmdquZTBNR0LUtnMhB7Seoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhJGMGVD5W2nOCRrdmmYGp0rV4UqABVqgPoUAoOnDb4oYa6qneprC81yt405lEahnnKQrtDX7U0QRMGXFQHZSc2kmQj7S2mryRYZM9x9Lu0uMQdPYe6ZKAutT4Yc5uCQPwKEZV9KtWr8R+fN6oXH7/OnZNkJsypT4N28pVsW9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3BoAAcV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844e6d1283aso11408139f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 15:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736899115; x=1737503915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQb1StZPkutIEy+KPYthSS0qIAi/qoKLpAFcyWkAIeU=;
        b=g3BoAAcVwT4e7JQfUrx9csMCZzjPcYSRK/JnnljQ+P9v6PR9oS2kAea3Lmyaplu2QO
         dPSGCzTVd9532gDafMhDJQ3GH5CW9cjmYTYWS+Bya2Miok5TwEpyJizZvX4L47phJSnB
         4ZH2NOCuvQyCoBK7WEnaRbDJ7wGDAw0RpnzxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736899115; x=1737503915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQb1StZPkutIEy+KPYthSS0qIAi/qoKLpAFcyWkAIeU=;
        b=jvpSVq3dNjQUYRouM6hVFoDwCxIVqlfamA30ijD7XjGpna5LSOtHqZu7LKaaRDXYjy
         3sQ44jWBEop30ZbPIIHaWHGXB0EUJlqUrFQ+WWIsS4th7aIaMLZKSrgl7kCXd6wjAibL
         S/kCZ1LFq/gUhlAQLeXQtmODOtIYc84fGXT2k2IoHsiwnJd9IjBUzs7/UuEDC4j10Gcy
         X8uJaA9zGmbL+CNm2aY3zkZPUySVhEk9k8qp6AHHDiIR5WQ5uaT3lsKDwcKOYbmc6Zni
         XiOjBoyiHP9EXuHPr12NgYozYYjd87nZlAjNzCgO80Z6I3HdcaJ4T//Unga/IoPvhoRJ
         ejkQ==
X-Gm-Message-State: AOJu0Yzw+DQPurSbIkYAaDS0j/PpB55T90nWH0O3lTc/kaMGUrLHPnZc
	M2KdmY9NrVLs/ST8e6uzE0tBR+xKGs12qJUaO416BuDr4bBJKKYXVlieURq1pQM=
X-Gm-Gg: ASbGncv/DW+CAz2I94tHRuJtuCjUMyaLXkcTfmNnCMSxiG8pr3ANnqRjoe6BAGad9I2
	+nWyaMxbT3+wdUmGoi/ZTl/7YHsptGUSSHwlYnFpQ+OCVxmKyaN6SfqmAymk26W5iOa4/d1r0gV
	fZI8a78EvYep47694DwEVGLsEgagFV3FLVkWrTkkGNK77O6ZSfekkfxed0vBs/zildgaop7fifz
	KCnSlr5RlAKO0a2aIWfcfxmTUs3TfKSZu5NYsvB6TVfY4NGK6QeRnuoxpjHqmN19LU=
X-Google-Smtp-Source: AGHT+IHoJzNRt1SqisAOZIMv010M4XMStUdJKpztck1cMBtYMFdgIQtvl9ogkx95HkEyP1IxjQQQtw==
X-Received: by 2002:a05:6e02:4c2:b0:3cd:c260:9f55 with SMTP id e9e14a558f8ab-3ce849908dcmr7116835ab.4.1736899115460;
        Tue, 14 Jan 2025 15:58:35 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce7b151929sm7734445ab.10.2025.01.14.15.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 15:58:35 -0800 (PST)
Message-ID: <4c34c66e-6861-4195-8837-5debbb0f71da@linuxfoundation.org>
Date: Tue, 14 Jan 2025 16:58:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] selftests/resctrl: SNC kernel support discovery
To: Reinette Chatre <reinette.chatre@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 fenghua.yu@intel.com, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, tony.luck@intel.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
 <808036fb-9a2c-44c3-ac6c-5406313a232a@intel.com>
 <9223d698-d16a-43c8-95c1-9839b81c2c23@intel.com>
 <c1fd1a9a-ead7-4203-af55-5eeddef76f2d@linuxfoundation.org>
 <e9971c30-8a0f-49d8-a7f5-ccd64e12f895@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e9971c30-8a0f-49d8-a7f5-ccd64e12f895@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 16:28, Reinette Chatre wrote:
> 
> 
> On 1/14/25 3:25 PM, Shuah Khan wrote:
>>
>> Thank you for bumping it up to top of my Inbox.
>> I will apply these for 6.14-rc1 now.
>>
> 
> Thank you very much Shuah.
> 
> Reinette

Done. These two patches are now in linux-kselftest next.

thanks,
-- Shuah

