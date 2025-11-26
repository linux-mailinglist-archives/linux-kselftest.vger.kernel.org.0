Return-Path: <linux-kselftest+bounces-46564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42699C8BAE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 355194E7D7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6FD340279;
	Wed, 26 Nov 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNwtqBGr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mGhvOINZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5233FE07
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186242; cv=none; b=sBihx2GneAEH2EDlu7fyDidvxOMQTfI7WVy7xcbSjZJvPIFzAe9XYJPThQivs7jt4nWYnLVh5ImaCLmxHabtsipkajQfrwx3OdNCNGQhtAwsIClmrMwI608PK8Ydrwx/AzuPezNBe19lCzVaGRW8Al0sM2e5R3DbUriVR3QQvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186242; c=relaxed/simple;
	bh=NC8uKdTuxmAzM0uXWA/yZNtxUA9kOoI7KiiXmK0aHrc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mqfJqS0+f+fc00CQ8hiW3lNeK6WIvkSau0m75nqGNU5QOy2G9DeM0TMpvA+/xOarYB3bDvTjMOiKn+8JifFWzEfftjICTOxDuwZTB+AmVyo7Xrah3VqQgr+JIB5nu7wwGJBrGwhneGqSgVMJAicrK1Pm5Kp+NbqDlmVh65FDCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNwtqBGr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mGhvOINZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764186234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeZXWPLM54Q9N0rdYJuLz0ImVGpJaWiBgkXc8jfBMqs=;
	b=BNwtqBGrXUl+QYZy4ZraOwoZe11timEILgfGSyQw+PK3jFuXCBfflIkyrzzwHO8ogpE8kM
	k/tkrlZJ9yLKQwXTi4ep9M4fSQVq/ZK4xMQcibMCtmQPVERKa2MZiIgv3Ux+oaUTt9binI
	Aeca5JvJCGf5geYoZ/LdMUDrv+Fhf5Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-1OmwB3UqPsay5uTq-OmNAg-1; Wed, 26 Nov 2025 14:43:53 -0500
X-MC-Unique: 1OmwB3UqPsay5uTq-OmNAg-1
X-Mimecast-MFC-AGG-ID: 1OmwB3UqPsay5uTq-OmNAg_1764186232
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b22ab98226so21185485a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764186232; x=1764791032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zeZXWPLM54Q9N0rdYJuLz0ImVGpJaWiBgkXc8jfBMqs=;
        b=mGhvOINZ9GfjmxtGrg8fMoGG3rkYdO2h0t/G8/3GXIaHu5iBGUxG2OPsABvSP8J+Jp
         SPRJSFOpFagGfSnnCRXgSUkGbeeLFL9LehcegNOQj69XWaVUDghMQ5PjjVJhxibSXH+k
         mjU05p62aiV0VcNayOicdeKktrgxBzuXQtGQG0seULeeO98xg0svqEQq1UAdK/AM3Sd3
         LjnTwTGEHN21uAn+GQaTU22rtppyp1MI61VvDa7eYosc+BkvQhLzM4zvj3pEL98ASHcU
         3hCu9bV9TVPeRgAIKUDeUbAKBoLWM0A2EBgChv1VQCU0CB+sRx4TbFpbVbqpBMSoBaPq
         SzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186232; x=1764791032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeZXWPLM54Q9N0rdYJuLz0ImVGpJaWiBgkXc8jfBMqs=;
        b=fjTjp8L7i/2qp1a2yUi1JfWv29PuUaBlxPz76ibooIfBw/hf0L+ShlyONG+Ip32zZ4
         73V/0gpMMfxXRbXS9jBWO6QAcjR7Nm+j3qt+BcbIONNaFfo3LKhUSv/YtGf7ujMEe/GH
         VZnOj/6GmSDI1XvTk0wlQ9WNApVDGwPEpYCQN0HI36VnjkwmU8H1bt30CuCue56SAXRq
         2SkGcJf3nCRfSOxyLxEVI3mY2UnCM77kUr/XoIN9mA8zrgsm2AEEr9RuM9B6qtIwKrDM
         3W0IsXwJyH9y0JIolnQZBgBQmtCibPt53+D8NfMlncqdnc2QhDBe0JmF5NiD/M2QqFRM
         x0IA==
X-Forwarded-Encrypted: i=1; AJvYcCWR+BsdNNMDhUefscolgWivmbR5J8AT8uWO4fgLrpv1ktB40E59ly4EigpOQtgSRL/Kd6MFOEXE/vEl0WlUS+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdyY8X/O3OYIiYlFpxxcP6kZzVh/G0x43h6cVWz7HwcMl8K7c
	CcQCArF3WbIcCWc2NTgz69cqh97KJf9eryCQ7ZHHZGuy59zXIs3XNuTbCMAQ2v5br5VzTrtJbWx
	SJjEBwTxbabeWYk7jplSTyy1rU/wLceW4Bgv8fIvoQXdKEGSapRBl58da+8CuUs8nxJLNlg==
X-Gm-Gg: ASbGncuZwGLuMdmAWIT1Se9SuhI9nAbK4AnqzOfdDbvxGdvr5uQDI4N+acvzcDyrNae
	QaNdRcm5sHCDyhrp0w5Ry9Nrlc5E0AuNlngRXThBEpc8Z7mCUUY19gztK3sxFnaNXZvmz2X6IKF
	i/yGY4fhyMYr5wKSl9SWHhGlEQiDqn2J8M2gkwbaA4zMzuXjwsunm0pq3biJLyIDV8vlfqus+2u
	wzWX8vOS+XRGijgnZcjJ0vJymkRLXGnxY7HCNfy/1LYbisPVLd62r1tOs/WTr1nGEycQcslt4Nk
	jeV7bLy/N2s7INion7fO6Na6247lh3qJaguQSbiwkZ4GFFGCXl+9WYAg/jRfCxq6CaOOF6vAqd3
	E8MwbIReZUX+T4xlMYcrKisGSoNqKTCl40D0uAyxcv6pbzdJ3GxyFn8kE
X-Received: by 2002:a05:620a:1786:b0:8b2:d30c:a30d with SMTP id af79cd13be357-8b33d1dd234mr2486905185a.13.1764186232563;
        Wed, 26 Nov 2025 11:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvM8RJdQKemYz8tabC1M/q2/hFazMCd8hSekJljf5/VfwsxdywRUQN6M+fkgNnaPbolxQTQg==
X-Received: by 2002:a05:620a:1786:b0:8b2:d30c:a30d with SMTP id af79cd13be357-8b33d1dd234mr2486902285a.13.1764186232157;
        Wed, 26 Nov 2025 11:43:52 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm1436745785a.24.2025.11.26.11.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:43:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>
Date: Wed, 26 Nov 2025 14:43:50 -0500
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
Content-Language: en-US
In-Reply-To: <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/25 9:13 AM, Michal Koutný wrote:
> On Mon, Nov 24, 2025 at 05:30:47PM -0500, Waiman Long <llong@redhat.com> wrote:
>> In the example above, the final configuration is A1:0-1 & B1:1-2. As the cpu
>> lists overlap, we can't have both of them as valid partition roots. So
>> either one of A1 or B1 is valid or they are both invalid. The current code
>> makes them both invalid no matter the operation ordering.  This patch will
>> make one of them valid given the operation ordering above. To minimize
>> partition invalidation, we will have to live with the fact that it will be
>> first-come first-serve as noted by Michal. I am not against this, we just
>> have to document it. However, the following operation order will still make
>> both of them invalid:
> I'm skeptical of the FCFS behavior since I'm afraid it may be subject to
> race conditions in practice.
> BTW should cpuset.cpus and cpuset.cpus.exclusive have different behavior
> in this regard?

Modification to cpumasks are all serialized by the cpuset_mutex. If you 
are referring to 2 or more tasks doing parallel updates to various 
cpuset control files of sibling cpusets, the results can actually vary 
depending on the actual serialization results of those operations.

One difference between cpuset.cpus and cpuset.cpus.exclusive is the fact 
that operations on cpuset.cpus.exclusive can fail if the result is not 
exclusive WRT sibling cpusets, but becoming a valid partition is 
guaranteed unless none of the exclusive CPUs are passed down from the 
parent. The use of cpuset.cpus.exclusive is required for creating remote 
partition.

OTOH, changes to cpuset.cpus will never fail, but becoming a valid 
partition root is not guaranteed and is limited to the creation of local 
partition only.

Does that answer your question?

Cheers,
Longman


