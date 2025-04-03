Return-Path: <linux-kselftest+bounces-30065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D2A7A44F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413247A4965
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F524DFF6;
	Thu,  3 Apr 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJ7AACbe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE16199FC9
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688196; cv=none; b=qbiI5Q3ptVV+Tb7YYJrlwKw9Ya/D53rcNWmNBLxKeBE0mJHBHQ7vciH92VBxV5idYEAHa6y+LPVMMB6jXAi/YYw9BMClfFtgKNYUnr0AeqcC2f9w0nKxno/nBrc3HJyulAATCJ15A7lSQVBQucrhT5ffvRV1FHlcLHemGSlTvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688196; c=relaxed/simple;
	bh=8wd++/QS/xpM3EXXxc69GzFn6SgURG8H5mMkQefQd1M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFqB0WU40IOt21IR2V5+YrJwsdJBV22WiVGyhhPnLGsSaMUsXmmtvhV6Eucdh9YqvSqDIujC18XtH1u00tlkhAIdBzOqGjgZOPkaAsu0aWtXcXpK9NkbOsChEZmyaaLWrlKR0IyL24WeHw1wU8ayJ5MYhp6T7BabHd46tMiR7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJ7AACbe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743688193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eAoy1aQ30yuScjB2LdD2aKFWnFzP7D/Q7jd8pjdm/k=;
	b=GJ7AACbe0556dd5ZwbXBQFypSgm+WYsPu20YuBRaNtlcHp4cDKBl+iVeuIkyV1wbYYUo8g
	TQCPOrgnQS8tu0VsxCsQInvaCTdSHTAcvaeZVsTw7Xln6/drjgSI9KYY3XELdZtkif8Jay
	Bs/GicHcFq5fwbe4vMx4nxeFSc4pUho=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-r4HccxFNPF6fsm_uuMeiPA-1; Thu, 03 Apr 2025 09:49:51 -0400
X-MC-Unique: r4HccxFNPF6fsm_uuMeiPA-1
X-Mimecast-MFC-AGG-ID: r4HccxFNPF6fsm_uuMeiPA_1743688191
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8fae3e448so19564966d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Apr 2025 06:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688191; x=1744292991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eAoy1aQ30yuScjB2LdD2aKFWnFzP7D/Q7jd8pjdm/k=;
        b=s5zM3wkJ1NZ7lv/omJZlka/ijUcXevab8pumHVXbNb5Ym8DhJN1dy3H0QpSr8gIU/5
         EfKmmAsc7Lft9qX1pOEQ5yOGNTXhjHqjdboJimByYkrAjMSY8PPpQaj9lVZ5OZ7VGw69
         p2UHk239rPAf29okps5MRqGRJM0C2RjXJhX+uqZj7M/ZCo2UzvLVjH3SzoFcgnOVGxMF
         LL7VX+h1PJkvb8wMj7TZZ4SZjJKajqc8XcART4L+pDxobQrFuw1xBSRlL464SWxzWF9D
         THjZP6+CsDL0OcgRuIIgwj2I0FmWsektEbwkDAOpm9EMMOD+yvAErRdzfLLbGu5zlPyJ
         wexA==
X-Forwarded-Encrypted: i=1; AJvYcCXl2dgOjl4pZanwnoJoiUUXpweDN014O0vV2+JKA2X8JuFaPpS1zThQe57dMAdieVSQgeqhxuIfF9VY1TkH0f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8KVIk3K7ag2oY/Jhe0zynX7i3h5zA4T0ND6fosfDmBtgHJjay
	9bxDgT9kYB8rWDkjt+whC2YTjDW8SM7yLTSJwxWcO5uFFm4r5aGKEKPNGecTpg9xlX7Fv2brMke
	YJ851kbzlwEt+P632GM4xAEdu/vmF+aw6KLol+6284TzGgBfqdUtZj026jdbGFhHLFA==
X-Gm-Gg: ASbGncvY3mxhauAk7AF2zaV8jV9Qg/N0Fq1DlXR/5A4njehZe1WMw7DU7f50rLcL/jv
	kCVRn5eFWcqU9uTz9/C8gcIDc+hdDHKyF3r7lGwUdfcDq+Rv1vsHVEV6Z1Pq7HZHUgnU8kdV+1L
	4R8EFSuNMAsopBmE70hXMXhMfpSn1S6fDHTRsdsJi8hemZSDCSa0dj8nLxef51JGVle83pnT+8Z
	97J1RqjfH0WdGKsrJaXFxgcSp3QHc+E/6PD14BF9HtXvEBuHXjdF844d3GZkJ2ytMJE6bONFMzJ
	xETbs5UJcHOFTcIIsJ5Qr/NprmPNp45jiHvGDPmaHk9hg4j5jhQ4ksQPibek5A==
X-Received: by 2002:a05:6214:d45:b0:6ea:d604:9e59 with SMTP id 6a1803df08f44-6ef02b7fe83mr105374946d6.9.1743688191331;
        Thu, 03 Apr 2025 06:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbzjYUkcoGjF250F0Pl2Phd2PHHM5mJucKy2fKCWScw+uUZHWYUOwP0vKoI8Pljh7xHfeTTw==
X-Received: by 2002:a05:6214:d45:b0:6ea:d604:9e59 with SMTP id 6a1803df08f44-6ef02b7fe83mr105374666d6.9.1743688190985;
        Thu, 03 Apr 2025 06:49:50 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14cf41sm7678356d6.105.2025.04.03.06.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 06:49:50 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2fa642e3-4ee9-497f-8c3c-49abb712a679@redhat.com>
Date: Thu, 3 Apr 2025 09:49:49 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] cgroup/cpuset: Remove unneeded goto in
 sched_partition_write() and rename it
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-8-longman@redhat.com>
 <t5gojwcnwdb36ppkhq6hpujmyatckg5wd5eigsnmt2kndfofe7@ymc7tiury62o>
Content-Language: en-US
In-Reply-To: <t5gojwcnwdb36ppkhq6hpujmyatckg5wd5eigsnmt2kndfofe7@ymc7tiury62o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/3/25 9:33 AM, Michal Koutný wrote:
> On Sun, Mar 30, 2025 at 05:52:45PM -0400, Waiman Long <longman@redhat.com> wrote:
>> The goto statement in sched_partition_write() is not needed. Remove
>> it and rename sched_partition_write()/sched_partition_show() to
>> cpuset_partition_write()/cpuset_partition_show().
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
> ...
>
> Also noticed (here or for the preceding comments&cleanup patch):
>
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3525,8 +3525,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>    * in the default hierarchy where only changes in partition
>    * will cause repartitioning.
>    *
> - * If the cpuset has the 'sched.partition' flag enabled, simulate
> - * turning 'sched.partition" off.
> + * If the cpuset has the 'cpus.partition' flag enabled, simulate
> + * turning 'cpus.partition" off.
>    */
>
>   static void cpuset_css_offline(struct cgroup_subsys_state *css)
>
>
> Next time...

Thanks for catching that. Will fix in a follow up commit.

Cheers,
Longman


