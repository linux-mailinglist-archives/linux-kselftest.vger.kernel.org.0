Return-Path: <linux-kselftest+bounces-48144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B003CF1607
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 22:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B5C53001007
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 21:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980531A56D;
	Sun,  4 Jan 2026 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ff1kOcEg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tliSzznS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FD31A54A
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767563293; cv=none; b=UZzkfAvtC6ljxU0NH1RbsRhfCIx4xtGN7qUzkTGLXorotHOCh63V5Q83yDBCjqaLnMbYxSEI7l4TsBhCpifKS2E2ssvhIEDPLiA3v8XdTGicAUIFn13y8YhfGYsnTxonC3CcjrNbv8DHlOYGPSchjHze5rhZf4CuV7tVsR4DT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767563293; c=relaxed/simple;
	bh=y0sc11w6iKkgJZhc5ra4q3irne+xMlYBsG9oiAF3S8E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b2WBKQDgCCG2b/Mvjw0NgvtCCIDNG/upfzAuh9nGDa1h6ePOvvxXDn1v1w6dTbelud+WU75LHzpYrXWe4GFdLUg7Y/zmoZWwW1hkosUHLcp+UHyGIhrf+t0PDWLUwAZnugN+JL5gdQNwWo7WMVtBA8QTuOjVIRMzxrFEFbUKg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ff1kOcEg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tliSzznS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767563290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y078SXfKEIKRd5VwmHPxExsqrlkRflvvVfuy30oz9Iw=;
	b=ff1kOcEgKxtC/amYFduXAwUExgj9AhYxA7UCwKCns4oeNDxHn/sjxvTnPc3btX3wd7c5Oo
	va91h52PmunSWXWtxseggIrMAVwGh+0uexD2hleDKgqcp3viw8enmP1ml7juZTdb9m4Jlm
	W7oQK3tXY2iLqZE+XIVydtiDVOecERQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-5gaHroRZNryFEOmN6UXI3Q-1; Sun, 04 Jan 2026 16:48:09 -0500
X-MC-Unique: 5gaHroRZNryFEOmN6UXI3Q-1
X-Mimecast-MFC-AGG-ID: 5gaHroRZNryFEOmN6UXI3Q_1767563289
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8bb3388703dso4918416785a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 13:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767563289; x=1768168089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y078SXfKEIKRd5VwmHPxExsqrlkRflvvVfuy30oz9Iw=;
        b=tliSzznSG3XM7WGPMZ6z7fcqN5CGzRFZQtKvBTiBSBLM3WJaAJYUYGkteqQzZRR1Wr
         izKdkqdBAtt28aA3WvNjT+lbeeXNVjJWEDLu4yR/iIKHlZpGbQ2fJNGFzPH4FcC5uPmg
         tTpHem1CzZ2hZxLRb+IkRmtedLkedDZ73etU7SAu2xwziJgcs2nM7edkGDYrwmVk8ayf
         nibJqjVC3minQecGRLKxzgovwDGRYFLvK9JuZnD8PGEXoVh7FQQHqvoQKDGUirnSF+VV
         bPoVqfjoQE5Zkt2HvKPJI2W01pPmn1e0ILFN1jMIoh4xjy4e86FYE+xJCXPaYnC0M8Fv
         NIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767563289; x=1768168089;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y078SXfKEIKRd5VwmHPxExsqrlkRflvvVfuy30oz9Iw=;
        b=Ee78fVWV/3fk0mYEQJV2DU9vma/gEBG6/Kz55GvNx1p/S1SRk/EgZa71CnJ99l9Mm8
         sU5ZpMR5W1q5gLVPlXKQVcS7V9odi7BOdrX2K895Ktml7t6pNrIgufK0ztzqnCkg64qj
         nGSB2vQYRyIl0JbQIVZR+QciLgmiXg2Zxq4A4zOxed7MxrxtSerXXRtbgVIWNCEZx/2v
         GlfV5kVslFqzR77Cn63nvuaLSZi1AKWjIrZiF1Q1dO4n24O2vXOGBDz74VgsecIwGLu0
         aZIRXeS20+rcVQjxKfNmJxlj2d1nthd9locTS9ixdCMD6VLfM6izv/Y0qRcQEahIxQQe
         xwsg==
X-Forwarded-Encrypted: i=1; AJvYcCVUNZYuTG+MyY2d6DAa5XG/fBSUM3fOx2GI1L3vm8ClbMvdHfwfkgInk3ZyCufzlDHETSYc5PCSYvlbGNusC5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrUrUABp75wg0knOk/r5OPxXiVSKtk/sP9Tteh2PE/TF/z8d9
	XfBS7EfdSTKe46CtylG+pYKeU4bU1xeauxAygXMNc/N8H6m3UaOZCKlOaa8bJ9t9v+I3jhf3Dxz
	m+RHl6VB2EsOifi4rQh/HzaACHcABPj6Oh0tF3rjoJ0SfCpD8CQdgeLr2vA1qTu8z4mv07g==
X-Gm-Gg: AY/fxX68vAHJKUGX0LX+NQ7w/Sef9ciirStTGx2y45F0qeYCg+BGuTf3PSoEhMLN4ef
	lt9k7W5MZr4ZrxmJaszV7xFuTTuqFO11UoLh5O5NAAio9b+Jo+ZhWUaDQXTb5EHoHvrpagV4XTD
	MR6fmDXio7CIXJILNGksSsa0xTaJ5fCMrYz6ehvxj40mKHRK01QCPgimMKlkbMYpIif+iJEpvmX
	8iiINGDgZxxY/xCT2LBUVbN5ADoZM2uN8CLMZ37gWg4d+dHERuvSx4sVb2fJgSGPygG2NR9YRt8
	N5HLOdztt2imQeUg7vgx95JCcnKhPUKxQAwKZK6wuaAtnCG1xlcymSbQ5bGLGuIbvChs9uMKInN
	AFznbbQlmc+iObNFv/EFbLcwYONB2Sb4k54PIt4foICMbxNPxnH+fXKS4
X-Received: by 2002:a05:620a:472c:b0:8b2:edf1:7c4a with SMTP id af79cd13be357-8c08f682c7amr7291368585a.39.1767563289031;
        Sun, 04 Jan 2026 13:48:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgx/Ro8LIsSGzA6GrLW/huLR0mhax5aa71Iw9IGeyKEOdpg2Rc4aEZNIq7X9MHlTlbpRgEJg==
X-Received: by 2002:a05:620a:472c:b0:8b2:edf1:7c4a with SMTP id af79cd13be357-8c08f682c7amr7291366685a.39.1767563288604;
        Sun, 04 Jan 2026 13:48:08 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973ee08dsm3652997385a.36.2026.01.04.13.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:48:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6eedf67b-3538-4fd1-903b-b7d8db4ff43d@redhat.com>
Date: Sun, 4 Jan 2026 16:48:06 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 3/4] cgroup/cpuset: Don't fail
 cpuset.cpus change in v2
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-4-longman@redhat.com>
 <efdcd90c-95ed-4cfc-af9a-3dc0e8f0a488@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <efdcd90c-95ed-4cfc-af9a-3dc0e8f0a488@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/26 2:09 AM, Chen Ridong wrote:
>
> On 2026/1/2 3:15, Waiman Long wrote:
>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>> until valid partition") introduced a new check to disallow the setting
>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>> cpuset.cpus value so that there will at least be one CPU left in the
>> sibling in case the cpuset becomes a valid partition root. This new
>> check does have the side effect of failing a cpuset.cpus change that
>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>
>> With v2, users are supposed to be allowed to set whatever value they
>> want in cpuset.cpus without failure. To maintain this rule, the check
>> is now restricted to only when cpuset.cpus.exclusive is being changed
>> not when cpuset.cpus is changed.
>>
> Hi, Longman,
>
> You've emphasized that modifying cpuset.cpus should never fail. While I haven't found this
> explicitly documented. Should we add it?
>
> More importantly, does this mean the "never fail" rule has higher priority than the exclusive CPU
> constraints? This seems to be the underlying assumption in this patch.

Before the introduction of cpuset partition, writing to cpuset.cpus will 
only fail if the cpu list is invalid like containing CPUs outside of the 
valid cpu range. What I mean by "never-fail" is that if the cpu list is 
valid, the write action should not fail. The rule is not explicitly 
stated in the documentation, but it is a pre-existing behavior which we 
should try to keep to avoid breaking existing applications.

The exclusive CPU constraint does not apply to cpuset.cpus. It only 
applies when setting cpuset.cpus.exclusive wrt to other 
cpuset.cpus.exclusive* in sibling cpusets. So I will not say one has 
higher priority than the other.

Cheers,
Longman


