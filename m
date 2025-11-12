Return-Path: <linux-kselftest+bounces-45374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E874C507C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 05:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1569B18993D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 04:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AC32C327C;
	Wed, 12 Nov 2025 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqGPCslN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekFg/j6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED915271451
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 04:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920575; cv=none; b=pnIvyF/R/JYLTy9/U2y9KLidO/gP5Ia1ahGS85GHXiIJ+HhpFpU+zsC1begKAaW9YV4SQFS1qhGCEwrEq9GDhPGu3/umrnplgWtNhXOw0FRzDTQ5IapfE9h6skZdYlLx0uR8j8foYpxrHd0f9md/Zs25HdF24lCeyOEzwqYoUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920575; c=relaxed/simple;
	bh=9PW+A3JHWzURTlDXLHDmB0OKXZRnM2OGKf4qPL38i74=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pzh/GO6zq5cE+TfTBe8Ze5jFLZmfj7bJ2nfXtRjRrmzZchXv3pdRWpjFxRS10vV3eoz0Ky3+kBr+2Ma3oa+kg9l+Jkjm+C+7rO+XtMUHx9XkmFoitjX6vkJNQq08ypGrjvNcbjVaG5/BAy75VIHkrTfs06ostGA+AppukZSQcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqGPCslN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekFg/j6a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762920572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBULf+ZIkA9FqHKiIs1320k4feJF2I1rgP/b6d4F0Mk=;
	b=RqGPCslNWScVnn2Ck8198zp8k3QFwJYzUEuVbqRCtQLYv2/sfM0iFmajjpAhRgAuSCvhp9
	Cbg7FJRC6OJXEFBWv/PmqM9xc3NYFCRGjAEZ5gvR6fZbgty7GwRv4P15aqJNps20rNWsfT
	bXN54Zvd4ak6z5h70UF33wK13wLegW4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-TUm3fSwHMRSCD8i9XpqTWQ-1; Tue, 11 Nov 2025 23:09:31 -0500
X-MC-Unique: TUm3fSwHMRSCD8i9XpqTWQ-1
X-Mimecast-MFC-AGG-ID: TUm3fSwHMRSCD8i9XpqTWQ_1762920571
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb366a926so4959571cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 20:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762920571; x=1763525371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jBULf+ZIkA9FqHKiIs1320k4feJF2I1rgP/b6d4F0Mk=;
        b=ekFg/j6aJfbuCI/fUdbBHYO8FmybPehHCL7m55Fnh0HjygoTnq+HTAe0eYnXO+75oz
         Fc/b/tdXULJVMhXcohj3c9qQols4VKsA1uFCztCyQgeRvso/io1K3UYQOljc0E7lPLOC
         a7MkjAXGg5R/2WA/oNYIs38rFTE2fgEU6SPP7l+txRfcjQccaIN3MMVprsaiGheYPSRw
         2uSTJBPY6bHhz1IPfk0FC7zX37tPfX7h76Lkz4aggmGZbmos5zAqXRePPhu+9+HUHeRQ
         8egx2jc37454HovImtru3UjyT1psiGVYihYQnxj2zGv7G+hS/9k9nQHJj9x/0KlEVR2A
         g//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762920571; x=1763525371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBULf+ZIkA9FqHKiIs1320k4feJF2I1rgP/b6d4F0Mk=;
        b=saMJ2+91+wGKO288NnH+4oSFNNoqL19687jSRxH8TuHfkNY6TCDdnPzCpOUXWdllRD
         N76qINplSse/cmxMSDGJ279Vr4QI7fcPjKtCTntldrWls7eVWbMOG97EtIjjaG7U0pe8
         l8MSZFnY3FcKwRwQ0WL3LAupknWB/gSorYApQn/szLeJVS0vR9D8MF/HJRdtOrDfWItz
         ekR3yxkpTPhCJI5fA+JFEsqkU2zY8EYscd/yAiUhaJIhQofxZzxD6HRfFSmTNFz41P0f
         ktMuKLQfYNciFRd/dEZWuu3WA+S83sLP1KaHSENgQ1frm6NAf1vJKIbFT3Mj+hrSRzVQ
         MJhw==
X-Forwarded-Encrypted: i=1; AJvYcCWX9mR8ZhgRUmcChyDht1hY8Ulaa6E0TIpH4fCfbVRnPQvTVs/mE+sLRQIfsAw1YKiKtnMI1pgotIKA4kHg/L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpW/Hq8NKWbMP8FPv0QkV3IRQWRhmY1qE2E+28sSHySDaX+84r
	6mwWGBz5Lk1fczkdqgs0/KWzJVkxO4Rut2XYtjWmESDa5j/9J/tb/p493iBtTuzYzZT0r9Gdbst
	vaveK0IjIwluUXG2AvF/gJ9kiO8B6UWPuQNIo9L7sbaUsH3QnfRi08kyY/mmNpuuOrEC+rA==
X-Gm-Gg: ASbGncuJtWO87BEbY+TX7W3v/ASl1nfWnY9JwwHOb1ssME6LPHNhaNs2VtcX7n/llom
	Cj0/TBDfHcMnOZMYGNmoRbWwYe+obGsaYPPYMr2BdMpaochhhae1+Gyx8fazwyNdkCox5iNS0ag
	wdRltLrQArs4njbgcKO+zaOuRe3LRkDdx5QSWj2o+QhV74OttWTncYBuhrgFI7Jq0M2gSD7iBIy
	lJE5WwwaB7J2yCHZu4AuwSjMTZm2jQow4ftuzOKA8aBrOW2VDJH+iG+rApw+d+hhSddy0WtOPI1
	vJdymKFPoVsBLX/hRdh2UAbsCKZVEYNx5SibNujj34JGRo7CQlLJNTn5NRgOC1nRlXxTpFibSS7
	dOWQmRdMmUbejGUMsFaeu4+Y3FwQKWACTvDzmzX0gasb+Mg==
X-Received: by 2002:ac8:5a15:0:b0:4e8:ada0:450a with SMTP id d75a77b69052e-4eddbd774bamr18423781cf.45.1762920571010;
        Tue, 11 Nov 2025 20:09:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPWTMesD++oG9Eb6d/7De7HTmZLuSnw0p9oUBYq3+RbK0SLKI1SdBODf1yz+ndvuVag3fpAg==
X-Received: by 2002:ac8:5a15:0:b0:4e8:ada0:450a with SMTP id d75a77b69052e-4eddbd774bamr18423691cf.45.1762920570668;
        Tue, 11 Nov 2025 20:09:30 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda563fbfcsm77229701cf.10.2025.11.11.20.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 20:09:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
Date: Tue, 11 Nov 2025 23:09:29 -0500
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
> Does this rule have any negative impact on your products?
>
> The CPUs specified by the user (including cpuset.cpus and cpuset.cpus.exclusive) can be treated as
> the dedicated exclusive CPUs for the partition. For the cases you provided, both siblings can be
> partitions. For example, in case 1, A1 can also be converted to a partition. If this rule is
> relaxed, I don’t see any check for exclusive conflicts when A1 becomes a partition.
>
> Additionally, I think we should preserve the CPU affinity as the user intends as much as possible.

Where does the original patch sent to? I didn't see it.

Anyway it is late for me. I will take a further look tomorrow.

Cheers,
Longman


