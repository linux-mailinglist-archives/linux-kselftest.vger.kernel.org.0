Return-Path: <linux-kselftest+bounces-48147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E58CF1698
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 23:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB164300F9D5
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA313161A2;
	Sun,  4 Jan 2026 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwIIUkdd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLdtya1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE227BF6C
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767565586; cv=none; b=hlaWd+gk7FQrSbPTrsGhNyq9unByhYBpRDc6mSLLDRTkzOudd+3mEZVFvMjO4v9Z/FBJ2tMYXXGjYyjvdjArWUSwFNwut9r4/VmHD5nEKFoVW39cgFW+kdlgbhD0EIugGXrFPYxsIcMldbPaUz+tSTaQ0dsovdHIBhNIJwYdkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767565586; c=relaxed/simple;
	bh=18zqbZPHCZfC4IECcFh5Oo9n88sS/9RdXF1BYxgm8CY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OLYcp5S1XQqFQLt8ElJVNxcVIes2eKxWe725L9+suDNQOhdFT8+tpj6rP1d4qJ1069xO3iDgNRzp/lMWHR/daVnIYe3EZ6KL/g9QB3mwR8SVf8A4//k+vA7/ej8ZjqIRzpSYGgrmQIxZZv83J92JCaqN8hKb/Wtyl3LO/H0Cf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwIIUkdd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLdtya1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767565584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MX6wynQZFsiu7Tz4PLzaszcf/RQEoHul08Z9Zkyf+Is=;
	b=BwIIUkddCDr5hUFJ2Wsua8AhMHRNdpvCU5+ETBb+P2Jd5ccUNlSLjH9dSv5Mh1X4Kq+nLN
	xMe7W6FrLv+v+s4/Mot6l0OiSPs3JVqZWDrpwpBlHQx6tsFyRtPFI9OrdggKhmhj6Cn8ew
	wbmEdj2ftNw7i+av4wEIgVDKtzjOB3k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-O4R1o8JGNFG0S0DAMCMekw-1; Sun, 04 Jan 2026 17:26:21 -0500
X-MC-Unique: O4R1o8JGNFG0S0DAMCMekw-1
X-Mimecast-MFC-AGG-ID: O4R1o8JGNFG0S0DAMCMekw_1767565580
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bbe16e0a34so463711385a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767565580; x=1768170380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MX6wynQZFsiu7Tz4PLzaszcf/RQEoHul08Z9Zkyf+Is=;
        b=aLdtya1F1GDOdz1hTflB7L6wy3yPREOMaiqfJ5Ck8NYpDiRd8ZcLsqYNfzaQTMMJiL
         ribdYnwTe2ri594qkNwlKANnEOWOFOoj9y52PShxpd0Ey7Dz9U7F4s782NF90lQGx3mw
         KR8hqu0dEgW+etnTcevicCcqJVt9id8KN0ev38lFm4SlsZ1aKWVbTcKCWeLl7CgVm+tm
         4zk8woOBUidyyBd9xHBvy5KGYGw06LrrIE7Ts6CG/yT7+2jtkU9yaZeUaY4pSa+TBFjK
         09ajFFCoMgs2FAJ1+IlFjfHoJ4eyVAqjM0M26K4d5Ozc6noYunHULfApOySPqcLp6+iL
         BrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767565580; x=1768170380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX6wynQZFsiu7Tz4PLzaszcf/RQEoHul08Z9Zkyf+Is=;
        b=cUhlR/w62DKR0yMTo/ATb8nIFHl/c5I//lrpIuD8o9Ft9kLMfQeTyVXBlnhIX5UeLZ
         x8AI47ANC7CPwz2fWweDJosEXSHylX4DG9sjmFdrAp2kLw5hGv55fr4tkcrwOI2oxJWG
         UtLMX5ooy2V2NR4ZBrGZoujT0oPxxRBt+dEJPJsBIJvs0YKhUnqpTRIK6jsYZOBci7cd
         ZDRYopHXsfQ9f4CJ0xyyTyWOENHKL4731XliyLWt/ZWaRSIsf6j9tJxWMjtmcq/zR3gO
         eGRH1IuquUMrcodMosVHgCUN424wRCkGJok8KIpIV0zpgBUpTnWuTRea5ocs3ceNJ2LL
         flag==
X-Forwarded-Encrypted: i=1; AJvYcCWHYrTJS85AqHV2a2R9lTENmlKDWEIPkTQd3tL8bsK8D+ZiSmLr56MgegcTmmytaN0tgGEKg4lGzTl3FH0sYlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eOhphN+3lpomm3deCjS2V3LLI8ibE2N9VW2roIcSXmuCAZ3n
	7q0P9LgFFjcPdCgIDynvXOpk3oXjdXRUv0RKfstc3TV0Jhxxk3oLTH2cZ8XfFU/uLksHpGCixqN
	17jeSJ7DL6LjaaVVJj6Ipv8OJD96q8dhS+0vBcmT1vwEdBrI2LYNan8YxxGffSGE/maTk4Q==
X-Gm-Gg: AY/fxX7BOj4VfCWjYJfPTfEeW5F/lxsAxd1hFsy5/gl33RIkwqlt64b6/k9TQBFJdKW
	8UMlxwEILsAbmkk/q04d/CnN96iKcGukFcMbfl131i4TzatyTuHXEgS3mIaVDYvUSivlE87CyVv
	MqwhyBxO2LLNtxc0Yh3zctY6vqngP1uSqKJFOLpCn+XfK+1aBHA8xIwbG761XmcnGTNm+eyGAaH
	LaQ2HA45eZrdLxkuNsxsKx17vgGWymG5QZU1q2vYZ0U0oAT7CXBsSyF5IubH1IxdQy33zGkQW/+
	puzdDUJJBCuhfoze90Bwkf/kcC2mvMCrybaqivU08tFVLLjTZpNUc3QDF7hgNxw+KoEU8kV0aJf
	aYCzD3vQpxkByFSSC7Myk/U3cdeuFX0Q4rQkB+lyx2mzNl8Z5RlPszAKT
X-Received: by 2002:a05:620a:2993:b0:88e:1be9:cf65 with SMTP id af79cd13be357-8c356f610f2mr826663285a.39.1767565580429;
        Sun, 04 Jan 2026 14:26:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1alN5adMavXwg0qoPb9OAbKBalJiqdid2PFcZ88dBnIGljKevyz4sWtBubRBFhtfzz1Bexw==
X-Received: by 2002:a05:620a:2993:b0:88e:1be9:cf65 with SMTP id af79cd13be357-8c356f610f2mr826661785a.39.1767565580057;
        Sun, 04 Jan 2026 14:26:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa363e3sm337038506d6.57.2026.01.04.14.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 14:26:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5ed163d8-c229-4aed-bc8a-ae9cba9b78ec@redhat.com>
Date: Sun, 4 Jan 2026 17:26:18 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-5-longman@redhat.com>
 <f561b413-7fdc-45d9-9d89-8bd55e960d51@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <f561b413-7fdc-45d9-9d89-8bd55e960d51@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/26 2:53 AM, Chen Ridong wrote:
>
> On 2026/1/2 3:15, Waiman Long wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with the cpuset.cpus/cpuset.cpus.exclusive of a sibling partition,
>> the sibling's partition state becomes invalid. This is overly harsh and
>> is probably not necessary.
>>
>> The cpuset.cpus.exclusive control file, if set, will override the
>> cpuset.cpus of the same cpuset when creating a cpuset partition.
>> So cpuset.cpus has less priority than cpuset.cpus.exclusive in setting up
>> a partition.  However, it cannot override a conflicting cpuset.cpus file
>> in a sibling cpuset and the partition creation process will fail. This
>> is inconsistent.  That will also make using cpuset.cpus.exclusive less
>> valuable as a tool to set up cpuset partitions as the users have to
>> check if such a cpuset.cpus conflict exists or not.
>>
>> Fix these problems by strictly adhering to the setting of the
>> following control files in descending order of priority when setting
>> up a partition.
>>
>>   1. cpuset.cpus.exclusive.effective of a valid partition
>>   2. cpuset.cpus.exclusive
>>   3. cpuset.cpus
>>
> Hi, Longman,
>
> This description is a bit confusing to me. cpuset.cpus.exclusive and cpuset.cpus are user-settable
> control files, while cpuset.cpus.exclusive.effective is a read-only file that reflects the result of
> applying cpuset.cpus.exclusive and cpuset.cpus after conflict resolution.
>
> A partition can be established as long as cpuset.cpus.exclusive.effective is not empty. I believe
> cpuset.cpus.exclusive.effective represents the final effective CPU mask used for the partition, so
> it shouldn't be compared in priority with cpuset.cpus.exclusive or cpuset.cpus. Rather, the latter
> two are inputs that determine the former.

Yes, that priority list can be somewhat confusing. I will take out this 
paragraph. The next 2 paragraphs in the commit log should be good enough.

Thanks,
Longman


