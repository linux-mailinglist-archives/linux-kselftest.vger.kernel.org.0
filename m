Return-Path: <linux-kselftest+bounces-12096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477090B936
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 20:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444991C22B9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3A194A41;
	Mon, 17 Jun 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhHDGpMI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27C18FC6F
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647922; cv=none; b=SI1ARkxAq45wWKi88fRhbh1IyvE23vg4F/KcQJccpjHX6oDVqfKjJHJsnPTCbHSgAk49xL68sYl4lzEpgMuV+Cpbu2DCpeUzezajVeJSUDB021MMNLqMLpGc7IwpMv5tx4mli0pKuyHC0Q/smjuF9T9/KZaVAHEhA8ohpky+wVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647922; c=relaxed/simple;
	bh=sOOJR726A7GE+HOuZoZptXkv2RkHdnUnOBCXAnmQaLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXWgMUdpw1wM30fUGbsP4JsmOxLmBSZAKTRajhAI95MejGmUFUTL8a/FMhGCGp1CQRH/cZYn+VkiBUQbHF/YzFWYSRKFvdKBlRumUTHLB40EfwdkMgtx4UM7H40DXid+djSKaazU6SC6UKqq0CR6lqKRIkrN63diKoy2l68d2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhHDGpMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D+rLi8MKV+U8G4ot33rd+CqDcsYiPGOTwuUMtg0xt/s=;
	b=OhHDGpMIYD0LaFBEfnKrb1a3fEU0avHcUpIlS+UnA1XhpYTUV0MgI19EWJVuhQss+ioAvR
	DLWT3RgKDsBSF9ZgXOeaFbu3KHbcUD17Y6mlMRixcnFcYJ38d+seDmWIm/7Sep1QlRfI3R
	iVdLr4QLcb6VXxSm0Un5gLBay8U8dsM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-Zml1G3-eMeyz9QUxyUgnBQ-1; Mon, 17 Jun 2024 14:11:57 -0400
X-MC-Unique: Zml1G3-eMeyz9QUxyUgnBQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421f3b7b27eso40625755e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 11:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647917; x=1719252717;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+rLi8MKV+U8G4ot33rd+CqDcsYiPGOTwuUMtg0xt/s=;
        b=wr/AAgkiRDyh0d2Z1YGiZiVgQOKlo5QZ1YFOc6b+kmfZTg73Fp3rEw97adKn45K9St
         oKsOzQ4BF7MLgSoHYS31LGTRbXrKqBwohLkIMMtwjFm8Ry8tvo25658e7U3tXmLVloTa
         b8VZzXehg56q+vX8NXKNzeoWujRyOswdSuKAfDSi9PXPA+aTvRsmOq9G683RJNxDuYVb
         gZuFUHM0Xrl1iJ8wXyYxMEU+pfYJSKrjixjehwoVLFVIKUmG6plrCTUMjmxf55ytiZTK
         r8/x2FcSCiSlUcruEs4J+RnP9imlxgJQXa73YWfMtDYkRrKIlUwYzSTaD5bslt6A10JS
         9idw==
X-Forwarded-Encrypted: i=1; AJvYcCUwiLjwCUTSiIOnWYv8MYmBLh1pcv7xpEuujQyQq/jIE7ifLyOdriYq7o8Iog6s9TnhSxaXS4SNzhMo7H1mFbN9PXqqBTZm/jnLR07t1jlF
X-Gm-Message-State: AOJu0YxtTcjvacmdVCw8MeBaiVp/5T6q3VCv4YXb06J40VeLKbriWIOD
	rxqyh7J20MTdZ7lYg7yBge7ews2kzwBrFAb7JqsEuYXaVuUJYnteVfAjf6RFH9giWdjwR2dxQz1
	higfUh/4eqvO29LNgOkJee0KfzJaivXL1lleeGI1Ec4LkDuB/ycMwoWv9SFw7XEVapA==
X-Received: by 2002:a05:600c:1895:b0:422:44f4:9800 with SMTP id 5b1f17b1804b1-423048211aemr104848765e9.15.1718647916880;
        Mon, 17 Jun 2024 11:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT4usN/O/Tu2TN8Yu3N5hZIqYaQ+HzLQylreBS52iFrIRpNcpIhOCpd8HRXNNft0vVk4X8iw==
X-Received: by 2002:a05:600c:1895:b0:422:44f4:9800 with SMTP id 5b1f17b1804b1-423048211aemr104848465e9.15.1718647916486;
        Mon, 17 Jun 2024 11:11:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:2200:95d8:cbf4:fffd:7f81? (p200300cbc740220095d8cbf4fffd7f81.dip0.t-ipconnect.de. [2003:cb:c740:2200:95d8:cbf4:fffd:7f81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c70sm165273455e9.30.2024.06.17.11.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:11:56 -0700 (PDT)
Message-ID: <984d4e18-5e85-4751-b101-8bc7c559f440@redhat.com>
Date: Mon, 17 Jun 2024 20:11:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-2-jhubbard@nvidia.com>
 <1ea35568-bfe5-430e-9f4b-edef17f0b22b@redhat.com>
 <e6378446-6087-4ffc-9ce9-320c5e128bd6@redhat.com>
 <9f3d50b9-6acf-4bab-b6ff-cd524ad0a2c8@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9f3d50b9-6acf-4bab-b6ff-cd524ad0a2c8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.06.24 20:02, John Hubbard wrote:
> On 6/14/24 5:41 AM, David Hildenbrand wrote:
>> On 14.06.24 14:28, David Hildenbrand wrote:
>>> On 14.06.24 04:30, John Hubbard wrote:
>>>> The selftests/mm build isn't exactly "broken", according to the current
>>>> documentation, which still claims that one must run "make headers",
>>>> before building the kselftests. However, according to the new plan to
>>>> get rid of that requirement [1], they are future-broken: attempting to
>>>> build selftests/mm *without* first running "make headers" will fail due
>>>> to not finding __NR_mseal.
>>>>
>>>> Therefore,  add ./usr/include/asm/unistd_[32|x32|64].h (created via
>>>> "make headers") to tools/uapi/, and change the selftests/mm files that
>>>> require __NR_mseal to include from the correct location. The way to do
>>>> so is to include <linux/unistd.h> instead of just <unistd.h>.
>>>>
>>>> [1] commit e076eaca5906 ("selftests: break the dependency upon local
>>>> header files")
>>>>
>>>> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
>>>> Cc: Jeff Xu <jeffxu@chromium.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>>> ---
>>>
>>> If it works, great
>>
>> ... thinking again, are some of these headers arch-specific (IOW,
>> generating them per-arch would result in something slightly different)?
> 
> Oh wow, yes they are. I'm guilty of x86-centric thinking (again).
> 
> hmm, this is going to make it really a lot of trouble to do this
> approach. But there's no point in turning back now, so I guess I'd
> better fire up the cross-compilers and generate for all the arches.
> 

Cross compilers might not be required.

At least for me, at simple

rm -rf usr/include
export ARCH=s390
make headers
make headers_install

Installed the proper s390 headers, and "usr/include/asm" would contain 
the s390 specifics.

Some scripting would be required to make this much easier to 
generate+wire up for all archs semi-automatically.

>>
>> In tools/include/uapi/asm-generic/unistd.h, we already do have
>> __NR_mseal ...
> 
> Yes, but it doesn't get used in selftests/mm, with the way headers are
> set up right now.

Right

-- 
Cheers,

David / dhildenb


