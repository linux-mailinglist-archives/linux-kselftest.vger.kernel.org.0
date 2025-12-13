Return-Path: <linux-kselftest+bounces-47548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CCFCBA4DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 05:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794773079EB7
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 04:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF36248873;
	Sat, 13 Dec 2025 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GphHhu07";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lNvE8Mo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898CA1F92E
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Dec 2025 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765601948; cv=none; b=AVOgEZFfWQTEHofSt/IUEytwy48qsfye05eUhL0+DO+2uxX8MuQokt1wf48adZ49380S4wu9DMU6nGUkj7ivRXLUqin54CmtulswD98zF5dLU5ejeXGOlwEW4r/zPVz348k7tZDRfnV1HKijjnZQQB1mx18PzBdZwQ4W1HvwAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765601948; c=relaxed/simple;
	bh=yPzs/f+Lh44vbmrhItPCB7ZJc+MI/3tKjjsKrA9CI9I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ltAiJgClHLMGeZkQPvjuZhSXHZRcLP6bv8N3hU1TUUgfDVycZdcXSGwE2Z3+utuchQIXBtG0vHkjyebUWOXWRMy6P1dn3ntIFf0yVC6ffuO2Q0NVcSRaopuZ++JgWigJ2ol5D6YoUpWy0HoIsurkz4dQp7VrviUBMcUZWkF0bSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GphHhu07; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lNvE8Mo2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765601943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJGiqBB7uCME6Sbe4VgAoga7zrBVZpzS1c9EWdQdkYE=;
	b=GphHhu07RzUmNx9ElROG/2LdEteAzocPwTn2YhpVAu7W7A6eVyMwquk4/zbRf0aX0uzoKZ
	gD+jlXFjupwF4WHY69kw0WaFCl7K+Oca3+f5pckjJmLLJlIoGQVhkWugG9NlZW3Mzv+WTP
	+e08vugIWx5kLpgQVFMV7NlfmlbCbWs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-pFWG7IBkPzCViy3bW0Loeg-1; Fri, 12 Dec 2025 23:59:01 -0500
X-MC-Unique: pFWG7IBkPzCViy3bW0Loeg-1
X-Mimecast-MFC-AGG-ID: pFWG7IBkPzCViy3bW0Loeg_1765601940
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2955f0b8895so19085665ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 20:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765601940; x=1766206740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJGiqBB7uCME6Sbe4VgAoga7zrBVZpzS1c9EWdQdkYE=;
        b=lNvE8Mo2liI+cWn3q+4T0ifFJW3QL79udDs7ODRxeVFmapI6vxkxZNZkWMYTrWA+ob
         d44RHd52X46QGqCfXNHaGQsKYCKuPQpnFGDebwDiWK/+Omdpc5kpAKS7k+Vb0UBXh7g/
         2qCAThHRN6B3+scTgtjPfDWwEefs5z2+hpDEK2z725qgzIjGeraTqQvqyIhyMxu9yqJh
         cp73gqLxGArRcgzFAmXHMpdHnvOQ0kLDP2txs0LgRNTF0IZC92iSo0f+Gi9Ql2zzNMhL
         3Lynrcezx3yVDP+h5vDnDN3G58SAQid2q2hdAm+5cfmW4Lb2FCiY0+yIV7gKMBRvpK3D
         VHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765601940; x=1766206740;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJGiqBB7uCME6Sbe4VgAoga7zrBVZpzS1c9EWdQdkYE=;
        b=vGXiN5IDUV+vQUX6ND0TepRFtPKmogDQTqYBn9YbsebCN6aPZqDKgGer6y+/YSWqO6
         SQfgHmLq2kE2mZcEZ8RHMwwFrEKCCa8mI/NhSAEgrOtW+U/2OCYEYtNHjKG+IVP2i6lB
         zWOxKx0Pb5lX5b+GzrkGO+mWYE6wPnLChM+wuR/6pG7A+Uj3ndKVk9uxTdCYP8+tH8Ze
         U5663g5XaQ0wpUMAn0OyACnQfO7Z3goOG+ly+NsQPD4/aCePQdgQSEqe8AlB7xxpWHfn
         JIFfHji49YCe+4Xz52pfahLefmc+W8J27oA8wJT5JGT5BUvSSfp1lnqZcHuFF655W3uK
         GLoA==
X-Forwarded-Encrypted: i=1; AJvYcCXAxKGhbVXyki157C0+8PLPCNuRrf8XUFVib23c5BnB60C+p2386YJ6AaKWPm+oMwShVupGGdwl2HToFIIrFRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ1f/aWLxiOf2ov5jZa84au0Jqiu1aSiZ5L4wDmVgxscmQuxop
	gpTHQqsytD1eB+rLyWgycl4+Uw4e4Yz+8h5+yKuJBtYnq3D4BB7S9OYlh1l5tIaA5YCwe0CS+Oc
	hfdHX6j8tYpaLlgo99PMR+tZ7Z2zvk0JM1TK7UWFohPtI5AqAUMff1fnEoK/gY1YeHdtIHA==
X-Gm-Gg: AY/fxX5WzNLgz2bPrb2C7yva7oSBUiszFLk8FGV+6GbJGXZbSEM5Lh4TUGw0JlNAomK
	G5U+jJgB1M32xjDNS+z9mA7jRbvhkiOvkfUI6FAkvM8vV4RFfa1XSV3PB5b5EWk0f3OaCKtCfYW
	GK1GDLeaflnOdybS6p/0laORcdVIrqyXpq6Sra+hmUBgqxDg3h4mVRgb1IXmuE9D6BxHtgBQVH2
	kG5pDIs3xq0bJZHVXWTKaH7yCuK4HN2RDWEN4PtDW4Eo7AP0TGIrTBmSZtDoCfurWOJ257jVZuD
	cm3hNZejV3AVMDco4JOJFWwGh1l89fN5zhsHPwuZEwSi5MbXs0PtL/juqplJzglNWQmIAV35+uk
	cbzil90OE7PoIyVAbh7znWztG/k4EAfP4fwdTTEbgtuA=
X-Received: by 2002:a17:902:da92:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-29f24800550mr46650855ad.0.1765601940321;
        Fri, 12 Dec 2025 20:59:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2XlZ804IhqEpFO2N9sRBt5uGyIMXcNGs6Cj7VK4kPb19a3EfN0cxzXdjmp0UnK+0tBp2ahw==
X-Received: by 2002:a17:902:da92:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-29f24800550mr46650615ad.0.1765601939917;
        Fri, 12 Dec 2025 20:58:59 -0800 (PST)
Received: from [10.200.2.27] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f2e40765csm30273205ad.0.2025.12.12.20.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 20:58:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1e2eef0a-4637-4b4f-aea5-71e3e519757d@redhat.com>
Date: Fri, 12 Dec 2025 23:58:53 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
 <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
 <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>
 <3jkvuruuxdykpxjjdwhuqjfqi4nrtxojotswaoc7ehuwxp4s32@hfrvfato6q5b>
Content-Language: en-US
In-Reply-To: <3jkvuruuxdykpxjjdwhuqjfqi4nrtxojotswaoc7ehuwxp4s32@hfrvfato6q5b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/8/25 9:32 AM, Michal Koutný wrote:
> Hi Waiman.
>
> On Wed, Nov 26, 2025 at 02:43:50PM -0500, Waiman Long <llong@redhat.com> wrote:
>> Modification to cpumasks are all serialized by the cpuset_mutex. If you are
>> referring to 2 or more tasks doing parallel updates to various cpuset
>> control files of sibling cpusets, the results can actually vary depending on
>> the actual serialization results of those operations.
> I meant the latter when the difference in results when concurrent tasks
> do the update (e.g. two containers start in parallel), I don't see an
> issue with the race wrt consistency of in-kernel data. We're on the same
> page here.
>
>> One difference between cpuset.cpus and cpuset.cpus.exclusive is the fact
>> that operations on cpuset.cpus.exclusive can fail if the result is not
>> exclusive WRT sibling cpusets, but becoming a valid partition is guaranteed
>> unless none of the exclusive CPUs are passed down from the parent. The use
>> of cpuset.cpus.exclusive is required for creating remote partition.
>>
>> OTOH, changes to cpuset.cpus will never fail, but becoming a valid partition
>> root is not guaranteed and is limited to the creation of local partition
>> only.
>>
>> Does that answer your question?
> It does help my understanding. Do you envision that remote and local
> partitions should be used together (in one subtree)?

It should be rare to have both remote and local partition enabled in the 
same system, though it is not disallowed. The local partition should 
only be used on system that run a small number of applications with one 
or just a few that need partition support. For systems that run a large 
number of containerized applications like a Kubernetes managed system, 
local partition cannot be used because of the way container management 
is being done as the actual cgroups associated with a container can be a 
bit far from the cgroup root. Remote partition was created for such a 
use case where local partition will be used at all.

Cheers,
Longman


