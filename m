Return-Path: <linux-kselftest+bounces-48749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C22DBD136D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA4633096333
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75E2DC77B;
	Mon, 12 Jan 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJsYSamz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1hFfSdX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379492DB7AE
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229503; cv=none; b=LO+CAIOR5VmILxDVKLmsxO8qACXOAN1qdJO8gI6IB7ydhb3/ADb0TDEg5CTUVYaNT/Us88wKba7zFtRsC1f95MIorZyLIv8dwJ9dW1x2HnPf4R5MBobqD02457HGyGB0WkrxWwfn/kgKDFSIPNmf5RP+f4vZYXwn/4ar/0qpeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229503; c=relaxed/simple;
	bh=KfleazqhiYVtUyRFQa0Rnp9RAnsfoqSNonzAP4I3m2w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hnfMEA0VAMlmu3JKFFu8eb6Bnsp78f5uyyElHJQ1b8rddTuKw/tPD7ev41obEzSc3d/lon2NwWBEcZsD5OmrdpTtZEQv6qiAkm8s0Sg5lgp3Ric1xrnsmo8h3P00x96+JtHKEhsR80FIRJwWmf7IdDOP8jkSMD1nlGhf/Xj8Djc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJsYSamz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1hFfSdX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sA5gJz/+vgMSarS6A+nPZ5R89JHYOj2EYgVc9sCvFKA=;
	b=XJsYSamzJ+LdbfbQCGL245v2z4Cx9n7Tt19ybskCH9Dh7O6vmvKltnWbnx1HKpiB/8Myd/
	AAmloBPMPVD6ckytGLWzcQkITuibaMV2b1tQWFtaMkw5Mdku8u8pVVbRCFeoyyIek0AbUe
	UIhprmVR4Q7X1DHtNm98VpnwVgyIzSY=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-YT9HHDpfMGy0F8I1eA48Qg-1; Mon, 12 Jan 2026 09:51:37 -0500
X-MC-Unique: YT9HHDpfMGy0F8I1eA48Qg-1
X-Mimecast-MFC-AGG-ID: YT9HHDpfMGy0F8I1eA48Qg_1768229497
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5634f73edc2so4249859e0c.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229496; x=1768834296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sA5gJz/+vgMSarS6A+nPZ5R89JHYOj2EYgVc9sCvFKA=;
        b=H1hFfSdX03LD81cp6Q7aFhUHsu77TxhwUI5hoyrzyrVKVw+wB8s3rkOaK6ruiAIwnj
         qrZSzjguhTTCIAVqRkDCF8OEd6lIuJ9cZTjrK9UNmxI1IwBE/wNDhNid1cz6oyajh2AS
         dAEEzO98unRnWCI4ynw2PHooBoFR+1NZ8OgYkolGhPMpMKAJ39OyxMgR8giluj4F0nZu
         yzF4EamLTF5Le8GD5Bc02fvPk1E9fostNDqawdGLk10+wk7be0NPmW4Kx7ZXC04gXzio
         BoMDgWMnNjU4hp0QeyuhZ1o/zUQGBRL9FumPOwU0WxJgsvDSLTtvWnfl1ZUn/rU4dalc
         /C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229496; x=1768834296;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA5gJz/+vgMSarS6A+nPZ5R89JHYOj2EYgVc9sCvFKA=;
        b=C7KKdpiNYWWX10zmhtRZ1s76L6V7wYna+pNZUvUDLC3cnC/fOsCplDUDXamhuOQDy5
         ljldehWMkK5JAmBhazW3tQy0IaOnmNuGdJg/t+JKHhn/+0mIr7Ihl2/K6cGYh7uPk+jk
         yMX2xQbE5NQspq1UsmUqlahQcGgyrg5QnJbyDvZ6qE+HRXGpjxmyomXKhGI4kOasg11o
         YTNXiGVU8TXCove1tVGND9b0bHGA74WlawaT0KHcEL2/fazE0fRMmgOvSnAVd7lhJ0Bm
         PGxJhUIU9xVr1xNsXB9ilx2vOi1Pnqg+LbeP118UeiLOTqQ/Cs/pZxzfhaximl0HPBh6
         P+eg==
X-Forwarded-Encrypted: i=1; AJvYcCXF37ZiVm39iJ501FORCXmeyHmMQ41fFni6MkcOYv5EItx8PIgcUnb+T7pKWxEbErgD7SALygFe/fxHFIZOs3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKVQqvL3E7bhe+Vr7sjhwImmdwl3WTiuNtr3j0sdPh7K75Ufu
	n8JpDiD4KG/KqiVqNsMQKm+kYecNzzFxsWEzKCbnSEv42xxg9HbwDsLKOiBFikerHAQxisFQCpK
	1NvHP8eswR3ZgZC0Ui8UB03taBuk412gEAV4iRrSGOCffrmB+NITIUmwWSaCCXWWEbZWRWUzSkU
	McTQ==
X-Gm-Gg: AY/fxX66PSU2uSjRX4wdVkxOhc3/6WU8lRRuC2WNEQm1FwBmb9xuJFFpGlAtTLXdgF9
	GRqaFO2CU//CFLRef4jApy3CFdHiHtuO6yj/UKLwE2WAu0hDNjNV+7H98T1nBFbyPgfuRCdj1hL
	fgzvn3JCDSx0Vq1jCOkdLKyRTuoWNVY9dsWs41a2Syp1R2M3gJ6sxo3iqEu3e+smgGjfDY0YSGK
	UFSpQOSmKtmn+wvpIk93MZlD5TMxVo+uIbQ1KFwSoaTdF69n0zFMutncbmuuzOJ71pAb+exSVRE
	0r4YeqD4lL91d/pjD8ALGpJD7cFE4U+GIZtUNpFWHDRFb5H3Vt+PlkYVEkWyDYNtKU7iOwsX4Z0
	2cIizTcG4Dce7VxpG3Yc5okQ+ZlQBS/sJ98QWKWTJSeiRAYg4A0xBcEOV
X-Received: by 2002:a05:6122:8b8d:b0:55b:7494:1737 with SMTP id 71dfb90a1353d-56347fd2b6bmr4913663e0c.15.1768229496021;
        Mon, 12 Jan 2026 06:51:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMkEp2BHK2L7pl73R9OM4XWJTWqWIN5qUtiLpa/I4atEkU0kDVexMtW/lTi8Ub6jSdOpy+uw==
X-Received: by 2002:a05:6122:8b8d:b0:55b:7494:1737 with SMTP id 71dfb90a1353d-56347fd2b6bmr4913647e0c.15.1768229495568;
        Mon, 12 Jan 2026 06:51:35 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124c452asm16438567241.13.2026.01.12.06.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 06:51:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>
Date: Mon, 12 Jan 2026 09:51:28 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong
 <chenridong@huaweicloud.com>, Chen Ridong <chenridong@huawei.com>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
 <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
Content-Language: en-US
In-Reply-To: <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 5:51 AM, Michal Koutný wrote:
> On Sun, Jan 11, 2026 at 11:08:55PM -0500, Waiman Long <longman@redhat.com> wrote:
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> ...
>> @@ -2632,6 +2641,9 @@ Cpuset Interface Files
>>   
>>   	The root cgroup is always a partition root and its state cannot
>>   	be changed.  All other non-root cgroups start out as "member".
>> +	Even though the "cpuset.cpus.exclusive*" control files are not
>> +	present in the root cgroup, they are implicitly the same as
>> +	"cpuset.cpus".
> cpuset.cpus.effective (that one is on root cpuset cg)
>
> (This was likely lost among my v2 comments.)

Sorry, I might have missed this comment of yours. The 
"cpuset.cpus.exclusive" file lists all the CPUs that can be granted to 
its children as exclusive CPUs. The cgroup root is an implicit partition 
root where all its CPUs can be granted to its children whether they are 
online or offline. "cpuset.cpus.effective" OTOH ignores the offline CPUs 
as well as exclusive CPUs that have been passed down to existing 
descendant partition roots so it may differ from the implicit 
"cpuset.cpus.exclusive".

Cheers,
Longman


