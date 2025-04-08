Return-Path: <linux-kselftest+bounces-30387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62EA8192A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 01:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE14B1B879DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98B2550D0;
	Tue,  8 Apr 2025 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ot8LN0Vi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB89255233
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153883; cv=none; b=ohL8NxFuwl9D7rTrXKl0QqJs/GkXz5uZxXwh4l2Iab9GokobFvdq8jEx8up6q7kXLAL1oePI4sISioTvyq1ZHsAF0zcSqIlnKoVFIYG4268S1+vCUwSQUBKSy8o448yEXuFGiNwX7/99Q/vQ6YjjKXLeYZXn1OQ12tlXt2j/+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153883; c=relaxed/simple;
	bh=23wHBGgsH5jBNyuNmKzigQNOA5mvjQLOs+NUFRrY4EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqaNbCrbTDX9xLTZTjlOGwBdi/hEzi2wXAJK2CJ3MQIRhAvfeSnV/QceDYve1rTfs2AJ+UahqDX9OJV/HUO5yX0zVfEJusyWQlrBokzjNOMvGxTR85QSN/JJl7YbeFNMfvwdfhG2ISJbdDnFA3bpNhN8x0Y8FadLk1ohWbiA9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ot8LN0Vi; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce87d31480so32422405ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744153880; x=1744758680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dD5iYytJiVCBSD73c8y55/TXbsf914daN1sVk0Fn9ig=;
        b=Ot8LN0ViVgj5UKavmkKYurT4WybO9zhjTAlnvWbcFih11mRKAeNSBRTTxO3r3r3pQT
         /0dZHQZfp2zzF/CNKoO7gcLNUzCoYUn5kaAJPWfJ05CBnp62PQxiHxg++ADNVTaasxxR
         cpIWBokq89LeDwICn1ABbz+3j8Nf9qMlXlPUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744153880; x=1744758680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dD5iYytJiVCBSD73c8y55/TXbsf914daN1sVk0Fn9ig=;
        b=rpLsx19iuQavePnoeyslWtSikfil/a/ICpf2y70KPPHqdhPvFv3htafdL2R5sXnLFR
         R/MsOjwPCq9SfvXinriACk9hiWh+DW7e9ZIP52gyCkzFNx0JiWk/4jLqOy5pkxQ5t0PT
         ottAh+qLF6qEkAgmk13cPxvv0s80ZoHJGXAW9UaATDUuIugKuT5h0H9UquloK1C5LQ8D
         IcwY1q4XTVEoLNrZmwwgr8bT2U4eRmZ4rxipf5k5DROlxqBt8oCLFbGWhzWdSO8yj+j6
         Qh3EWb5TvriogTka/z/1+jlUsWiQJK6rpLIPXx09YF+fh8f36OQC+OqAklAybxJqFiDG
         RrXw==
X-Gm-Message-State: AOJu0YxkrjkvuWDd+XbMjkXvcemk1w8prwhn1zLzmuftMZVC1ZUJ9L6N
	zPELwhNQO68DaKeBxWRWlLe34Ht4dav58WV+NxvAnT8TRivKqxDR62VcO6RJRG0=
X-Gm-Gg: ASbGncukFX0HRKsdqVa+rxmFegliO4luI85HF5+YbNcyLF9OFqxikSPmCWZpgT5QStU
	fz1XiRYb1KKNKmbEB0gK1rylHOh/JkD4RC+JzgYVT/VJZFV+kCxO4Wfhd22oBYwuGilvhob6M5r
	SI0xE4aH8SHAviH8vjKHnCvl440wd5nmg+tYg9Jqkb39uT1ZaKzy3sDDYl9sHCBLzJdwftrLFe+
	6xr7Hlylr+6kxVOuZ5R3ReHIjUQPggKRV+ZCDoWDoLsacucpf1ogoy2IJqaYR4XH74f2RRsQkj9
	Yu/7ngYUjT74Sx/NnoNPgcm3vrlnkb0dPkKv7TZLm6zhLOlW0c0vwB0=
X-Google-Smtp-Source: AGHT+IGKXugYQoyibpRwBTrzYG8RaEkBTnSjqht2TQIWoe/F35s2coNwMsuxBUIizt/QiUAPYpfMeg==
X-Received: by 2002:a92:ca0c:0:b0:3d6:cb9b:cbd6 with SMTP id e9e14a558f8ab-3d7b46214fdmr3134135ab.13.1744153879728;
        Tue, 08 Apr 2025 16:11:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f43d1337sm741448173.30.2025.04.08.16.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 16:11:19 -0700 (PDT)
Message-ID: <f9a861ca-754b-41e7-a6dd-16d77958ab51@linuxfoundation.org>
Date: Tue, 8 Apr 2025 17:11:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftests/mincore: Allow read-ahead pages to reach
 the end of the file
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "shuah@kernel.org"
 <shuah@kernel.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Lai, Yi1" <yi1.lai@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250311080940.21413-1-qiuxu.zhuo@intel.com>
 <CY8PR11MB7134D020E20B290625057A4089B52@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CY8PR11MB7134D020E20B290625057A4089B52@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 20:42, Zhuo, Qiuxu wrote:
> Hi Shuah Khan,
> 
> Just a gentle ping regarding this patch.
> If you have any questions, please feel free to let me know.
> 
> Thanks!
> -Qiuxu
> 
>> From: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
>> [...]
>> Subject: [PATCH 1/1] selftests/mincore: Allow read-ahead pages to reach the
>> end of the file
>>
>> When running the mincore_selftest on a system with an XFS file system, it
>> failed the "check_file_mmap" test case due to the read-ahead pages reaching
>> the end of the file. The failure log is as below:
>>
>>     RUN           global.check_file_mmap ...
>>    mincore_selftest.c:264:check_file_mmap:Expected i (1024) < vec_size (1024)
>>    mincore_selftest.c:265:check_file_mmap:Read-ahead pages reached the
>> end of the file
>>    check_file_mmap: Test failed
>>             FAIL  global.check_file_mmap
>>
>> This is because the read-ahead window size of the XFS file system on this
>> machine is 4 MB, which is larger than the size from the #PF address to the end
>> of the file. As a result, all the pages for this file are populated.
>>
>>    blockdev --getra /dev/nvme0n1p5
>>      8192
>>    blockdev --getbsz /dev/nvme0n1p5
>>      512
>>
>> This issue can be fixed by extending the current FILE_SIZE 4MB to a larger
>> number, but it will still fail if the read-ahead window size of the file system is
>> larger enough. Additionally, in the real world, read-ahead pages reaching the
>> end of the file can happen and is an expected behavior.
>> Therefore, allowing read-ahead pages to reach the end of the file is a better
>> choice for the "check_file_mmap" test case.
>>
>> Reported-by: Yi Lai <yi1.lai@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> ---

Applied for Linux 6.15-rc2

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes

thanks,
-- Shuah

