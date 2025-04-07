Return-Path: <linux-kselftest+bounces-30261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D852A7E2E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EA53A8856
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38581E8351;
	Mon,  7 Apr 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfP1XjBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442C1E47DD
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036579; cv=none; b=EFGg8wKj/NtaHj9n4wG7HtmbO4CGbAYDTdOGRkK3tjd13J9hN5Z42Q0tSNtv+fhFnYK2LGQAVrqfwpHMwh17Y6a8wl/zf0lXQis/C9t0qgYUkC9Cvk+f4G1C65nwCaoChQmNxpcxFN+m8BWlnlw8WYqlxCZLe34QhHSUCODMnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036579; c=relaxed/simple;
	bh=cGNyz+WOFZZfNQEOkJkIG2uYIRO4WjMsJbUDGsYid5o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U36MMPIYfOLu2kkPMw/c3mMQYTsmTP/an4oaV8D1mZJmfgZ4F1Pd4XtKd7oeGpwtO9pdTvfVPMr0I5MLaUfMnva3i/fx68yjue+cX/OGai1NbTDJLgCw5Nny/Ox2X6tQENMN04spktCM+PJgCDvIpCf7n1f4IGSQbHfSEPV1DKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfP1XjBK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744036576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5DJg/Yndiod0rCSXdIIJltN9dcYDMLjV18CCekaRB0=;
	b=DfP1XjBKjibOQhBlRQ9+sFl/o4KhVDBXC/4NjKN2R3YLuFII7E158YolfE61J4jTa/q5P+
	V1NUdiXiaw+J9IhfS2lHS+NETs9EuPtWq8Ab+88JYMHzkCRlAgnqM2S4ld1w+ifU6pAaHL
	0knsYQNgSG0YsUC/pSo8U/+8gG0vkwg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-GHxvG5dIOny1_2q8Fdo7Bw-1; Mon, 07 Apr 2025 10:36:11 -0400
X-MC-Unique: GHxvG5dIOny1_2q8Fdo7Bw-1
X-Mimecast-MFC-AGG-ID: GHxvG5dIOny1_2q8Fdo7Bw_1744036571
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f184b916so114733616d6.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 07:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036571; x=1744641371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5DJg/Yndiod0rCSXdIIJltN9dcYDMLjV18CCekaRB0=;
        b=gzEExBslN2E+BFzKtGcJIIMEBZZDB7xHTWVfWOjfKatkF1Ocj81VzGas+iY3tlwR3t
         tkWAU/LbRcklj9lhPlFENmtWXA7KIdnIixXpMOegOI/7D5TKGExQbI5Eul6phc8gUanX
         UUncpQyDAp5X/wR8zrxB5bsb7XIlatSBRkIgch+TlU/3pxJAWyk7ffyMLjNraz7357x5
         8NkxRD0+ASTS6SlexDmpwdg/aOCwEDzb50kwXLYL2Y26EDj/Cg3S+5UbI8ieIEs2G2e9
         RyieZ3vMRqTnHwS2woYd5FwD0m893R/vHV7jBiiBxIKZ3w8JrWeatB6veAaLI504pgP5
         +WFw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Tt3zuPu26T3OGC3wq/gg+0dM59Zs+BSH4uptb+aPYKITeOUxl4ZSUocbTwcvUasakcdJ/pzDlCRatplGM+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzesOrCozlK81a0G9DSrvclXGiXmtHhB93kgie4+mrOfJF46La+
	60ySQJEDLmmh9BqfVxQDEnPtg6tlAdYPQjXtwBBFKfHQMDNZdt1zZAXDBz4O0RT0qMZKzVhze19
	RM6fz2qcv++mu7p2/yj3n0QVXv4EkFgGjlsoXhEIVNs6LGswyo2YLAoMx9pR55aaq8w==
X-Gm-Gg: ASbGnctlRn0XRLrSUhBuRpyV+Wzcg1/ONlF4wGMjoFwps3Gbkj3+dsaovb8xfasc326
	NIKw7bUEFaA59NpiI7ZJfPfu0HoP93FO4uVmJVdF+aJBnxt0AxtKXc3C5yIEYDZCxbkYY8oIFfb
	d/XtQ0gz+GyNjcNM5IfWV5ysRvYfPMqnijoTLSfAGwqzGAF4Df4yEIRKK7WqsyGixUAdH2czUbD
	u+95FfjsPHqYGVxBmt1G6Fv5M7wi0YbO2AwKrawcYhnrD12/jX739CliUHQBC4neS2XwsQq8Rz/
	EXB2xyG2E2syP7SrDHZhx1fLBInp0Dt3sYxG9VXKGp55p1LaTTsVp1jS+BJSSg==
X-Received: by 2002:a05:6214:5189:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6f012e1adf0mr219540276d6.25.1744036571314;
        Mon, 07 Apr 2025 07:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBjeFW6/Zy3PCGjK+e4ng1QFrOqWTfMoNnO69ymICNu5TBJyk/4flMbpzGbuBr1A3OzyWJBA==
X-Received: by 2002:a05:6214:5189:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6f012e1adf0mr219539506d6.25.1744036570672;
        Mon, 07 Apr 2025 07:36:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14cf41sm58909196d6.105.2025.04.07.07.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:36:10 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2d50bccb-9cb9-4f28-a8a6-116b2003acd2@redhat.com>
Date: Mon, 7 Apr 2025 10:36:09 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250407014159.1291785-1-longman@redhat.com>
 <20250407014159.1291785-2-longman@redhat.com>
 <20250407142455.GA827@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <20250407142455.GA827@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 10:24 AM, Johannes Weiner wrote:
> On Sun, Apr 06, 2025 at 09:41:58PM -0400, Waiman Long wrote:
>> The test_memcontrol selftest consistently fails its test_memcg_low
>> sub-test due to the fact that two of its test child cgroups which
>> have a memmory.low of 0 or an effective memory.low of 0 still have low
>> events generated for them since mem_cgroup_below_low() use the ">="
>> operator when comparing to elow.
>>
>> The two failed use cases are as follows:
>>
>> 1) memory.low is set to 0, but low events can still be triggered and
>>     so the cgroup may have a non-zero low event count. I doubt users are
>>     looking for that as they didn't set memory.low at all.
>>
>> 2) memory.low is set to a non-zero value but the cgroup has no task in
>>     it so that it has an effective low value of 0. Again it may have a
>>     non-zero low event count if memory reclaim happens. This is probably
>>     not a result expected by the users and it is really doubtful that
>>     users will check an empty cgroup with no task in it and expecting
>>     some non-zero event counts.
>>
>> In the first case, even though memory.low isn't set, it may still have
>> some low protection if memory.low is set in the parent. So low event may
>> still be recorded. The test_memcontrol.c test has to be modified to
>> account for that.
>>
>> For the second case, it really doesn't make sense to have non-zero
>> low event if the cgroup has 0 usage. So we need to skip this corner
>> case in shrink_node_memcgs() by skipping the !usage case. The
>> "#ifdef CONFIG_MEMCG" directive is added to avoid problem with the
>> non-CONFIG_MEMCG case.
>>
>> With this patch applied, the test_memcg_low sub-test finishes
>> successfully without failure in most cases. Though both test_memcg_low
>> and test_memcg_min sub-tests may still fail occasionally if the
>> memory.current values fall outside of the expected ranges.
>>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/vmscan.c                                      | 10 ++++++++++
>>   tools/testing/selftests/cgroup/test_memcontrol.c |  7 ++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index b620d74b0f66..65dee0ad6627 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5926,6 +5926,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>>   	return inactive_lru_pages > pages_for_compaction;
>>   }
>>   
>> +#ifdef CONFIG_MEMCG
>>   static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   {
>>   	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
>> @@ -5963,6 +5964,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   
>>   		mem_cgroup_calculate_protection(target_memcg, memcg);
>>   
>> +		/* Skip memcg with no usage */
>> +		if (!page_counter_read(&memcg->memory))
>> +			continue;
> Please use mem_cgroup_usage() like I had originally suggested.
>
> The !CONFIG_MEMCG case can be done like its root cgroup branch.
Will do that.
>
>>   		if (mem_cgroup_below_min(target_memcg, memcg)) {
>>   			/*
>>   			 * Hard protection.
>> @@ -6004,6 +6009,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   		}
>>   	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
>>   }
>> +#else
>> +static inline void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>> +{
>> +}
>> +#endif /* CONFIG_MEMCG */
> You made the entire reclaim path a nop for !CONFIG_MEMCG.

Yes, that is probably not right. Will fix that.

Cheers,
Longman


