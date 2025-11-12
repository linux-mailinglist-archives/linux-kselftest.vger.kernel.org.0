Return-Path: <linux-kselftest+bounces-45431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED68C539F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 18:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E5934EE925
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED933AD95;
	Wed, 12 Nov 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g91Ev8u1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4ogwg8j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA433A026
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965625; cv=none; b=HyVt/fy5axQelXMCuiHlBUbs1vcpNjhbGIbtpkYqtGmGSwVB8qtjTTJZsEGzpJhYWyHj/6cPJ9MfnN2N46Sy3rANK6ZfoouIvleB9avrZnBwhyoomrsArH6D70l/3CYjCBiuz0RGJ7VCyXvS01c1pFqov/98J3UgWvYfu0tturc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965625; c=relaxed/simple;
	bh=NPKmesSgG0k5cHihrVZICOAHxzeS6yl0o6Q6Msfzyf0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KUGO96FbmL6b1Tt/LSQCQwO9rgLYO/Qo/QOVbQ1Odjf5MYoqTnnb2a7++JG/4ahOrRKCQnyxuNZmsSzicDaSijRsSJhB8eB/PnnCJQucQquVLIDBsxGPwPwymWHVDO6tVeBz43HNdlVuzIzo1LkCGxYMkgEdIfE5hXH9Sg753H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g91Ev8u1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4ogwg8j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762965622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
	b=g91Ev8u1afu4bq1UfBvB5aoeteoWUxZ39l6EmIJzg0etMQFOnQWy73AuRWtySO22pvY/vg
	gc6jJ5/FzBdoUeHvkXae2dk9QaZ2U2vljGgqjl0uJYp/mlmi+XdTBsO3vlXZLAgIO0HB34
	BiTNEyAh0do3LlhQj0pch4oPXPa+C6s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-0jatgx43PXK5FF66OUYB2A-1; Wed, 12 Nov 2025 11:40:21 -0500
X-MC-Unique: 0jatgx43PXK5FF66OUYB2A-1
X-Mimecast-MFC-AGG-ID: 0jatgx43PXK5FF66OUYB2A_1762965621
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22d590227so128016185a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762965621; x=1763570421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
        b=U4ogwg8j0AkH0dSCF16QZLstcV5ZtOrLLgzfytX0ey0f+aDo6nI7UjT/4mLSN+1rch
         I5oPWSCFEWiwN5zNGLA5tf6LY7p0aoOo4tE6+AMIuABCxpjChI+t/B03dHZtdn8VmRQv
         6WYcRZpAeM8PFbYJ5GsSxcgbGr5ZZNpWzcNU4nTpRU68EaS8LkpvLKhfs6Hm64Ansxsb
         C6ShRFRlGcXfbXsQZa+wc37LLumw1hrDT0/QI8Kv8+K8Hq40PAgpeTPiOxCmm9mICVdd
         t62e1ga2v0npHM4tBcXTgw5rBXmqHiHa+B3AtenWLTIKQetr6Bmq2YxwZ6dat7kpNn2y
         7Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965621; x=1763570421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
        b=d9BzYQ239F4qijshNcNN4h10qQv+1lqPY3i2H+d9EVdjGLpk8Iof5wDBYIzIbXf/fR
         kn3zCzCCIHuFhKIzEyqYhrb++3gionwQ5WiMqBuQ6TM5fX+ZrFwzbEJ0kO4Iu3ixtwGo
         8TT0IHqD8XFNQrk6g9lmF90z1UORXNX6IGY5WW7YkEAuR3e9xwKIq4n8lGaQb0/YFRmD
         Gr+Q12F69XjUEui+ASWhm0pI7mksoA7rqB7cmKDwN8RqmnDnuBQA85TS4bCX/zOWJ0x9
         k0Pi3QyGKTQx1GUv9OICX3jajUDDfUHTklmMDXbVC+yqRBazwGbrxkRNhwxYdUb37sQh
         BWUw==
X-Forwarded-Encrypted: i=1; AJvYcCVPmiKWfv0oajLFZi3weba/obJmHi4e3xzNrRgvyowTcDSezI/5cgp2iyhojt6j4Pel8umbsx25l0ioZzseoiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjDaaBsaYtu3x3CobTk2s/Y7fFYZcq5c+G6pSb9DFRHP6GIMX
	u4v293RH72nAEwh7+0qlRxOMZrHjzC8u4ExZxcItFZ8KtaqAAez+ma0FrI6dEyEXs6Gg1H+uPaz
	KA7mYxE3F2qa50wAG4c3QBcpscyBbhLzJFmB69oruWEyYWIsPpUhHB1mBWR+U7bJRx5cgsg==
X-Gm-Gg: ASbGncvm4bYNDyT5XlDWwem2ZvpAJ/B1Qzz3e+9HYnCwsTW3s4ksjrNuNaxw5os5CAo
	BSOqKZxt0XVXzph6qUf9/MgL+iflHqS6BqJrt3PQqH0/YAN6LG1ktTND5KS1tK8+4fOaqRydyfZ
	Vw178Q87XF1XmTahh8AKGPtEyK829f5bRpwl8P2r0pXvZvZ+0lQ4IHi3aOFs6trg/MNzZAR+EJb
	+66zZCtPPmYlXInFnJC0ZCZpo4FvNPFNYJgKSC2PgEQgNHDyd8jKhhqj2/czkNqrNbHms0df7FA
	5fnig/S1SWpExzS4DhhLjQvRXntUZjxKW7QDyCumLpLWuHgXK3dHuKyumrLqPfo98eZ5NUc4J4S
	aypLmxA1o0pv5WXZ0JiHFphWGDhSmo0C01n2ff5n8M5hKHg==
X-Received: by 2002:a05:620a:45a7:b0:89e:99b3:2e9f with SMTP id af79cd13be357-8b29b7d96c9mr432074685a.54.1762965620707;
        Wed, 12 Nov 2025 08:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeRHn0TE7WSuy/RawTo+0uqdbnmzeUBkTfUMKCdOV0bkTaq6MIRt0f6pTVYA0aGPlXvo+hcw==
X-Received: by 2002:a05:620a:45a7:b0:89e:99b3:2e9f with SMTP id af79cd13be357-8b29b7d96c9mr432071385a.54.1762965620280;
        Wed, 12 Nov 2025 08:40:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85e0e8sm222910385a.15.2025.11.12.08.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:40:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com>
Date: Wed, 12 Nov 2025 11:40:18 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Chen Ridong <chenridong@huaweicloud.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251112021120.248778-1-sunshaojie@kylinos.cn>
 <380567da-9079-4a4d-afae-42bde42d2a58@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <380567da-9079-4a4d-afae-42bde42d2a58@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 10:33 PM, Chen Ridong wrote:
>
> On 2025/11/12 10:11, Sun Shaojie wrote:
> Hello Shaojie,
>
>> Currently, when a non-exclusive cpuset's "cpuset.cpus" overlaps with a
>> partitioned sibling, the sibling's partition state becomes invalid.
>> However, this invalidation is often unnecessary.
>>
>> This can be observed in specific configuration sequences:
>>
>> Case 1: Partition created first, then non-exclusive cpuset overlaps
>>   #1> mkdir -p /sys/fs/cgroup/A1
>>   #2> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>>   #3> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>>   #4> mkdir -p /sys/fs/cgroup/B1
>>   #5> echo "0-3" > /sys/fs/cgroup/B1/cpuset.cpus
>>   // A1's partition becomes "root invalid" - this is unnecessary
>>
>> Case 2: Non-exclusive cpuset exists first, then partition created
>>   #1> mkdir -p /sys/fs/cgroup/B1
>>   #2> echo "0-1" > /sys/fs/cgroup/B1/cpuset.cpus
>>   #3> mkdir -p /sys/fs/cgroup/A1
>>   #4> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>>   #5> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>>   // A1's partition becomes "root invalid" - this is unnecessary
>>
>> In Case 1, the effective CPU mask of B1 can differ from its requested
>> mask. B1 can use CPUs 2-3 which don't overlap with A1's exclusive
>> CPUs (0-1), thus not violating A1's exclusivity requirement.
>>
>> In Case 2, B1 can inherit the effective CPUs from its parent, so there
>> is no need to invalidate A1's partition state.
>>
>> This patch relaxes the overlap check to only consider conflicts between
>> partitioned siblings, not between a partitioned cpuset and a regular
>> non-exclusive one.
>>
The current cgroup v2 exclusive cpuset behavior follows the v1 behavior 
of cpuset.cpus.exclusive flag. Even if we want to relax the cgroup v2 
behavior, we will still need to maintain the v1 behavior as we want to 
minimize any changes to cgroup v1.  IOW, we have to gate this change 
specific to v2.

Cheers,
Longman


