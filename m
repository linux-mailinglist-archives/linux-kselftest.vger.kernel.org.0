Return-Path: <linux-kselftest+bounces-30703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5374A8817E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7F01889198
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14425D550;
	Mon, 14 Apr 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0ijxEke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833F280CEA
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636565; cv=none; b=aSGhIqTm7r/5JZKKE6B8qObWCeZr6RUvW+NpX8OGfbDBFMVSRfOb1zCQ3wFUfgBBJJQahEKDAqMr+vJQIcdib69em1KvWCf+f0rL4GkidG599gxEG520x1gElNEHG5ZiRBRaSorSqHUGzr7OTxmH4HYWsM8Zp4eGlttoznIFQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636565; c=relaxed/simple;
	bh=lxd1ChqF718weWD+hNXDxRZqp4DmKNuj/omQ+yf+A9I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fiyc1Rj8nU342rDL9d/tX9V/Y+GDI3ISFqBoSnXDMl7+kfmGn6ytaKLoQhjmosaHlV+1S+RkVW45hI97Dl9bjCAfqj37wZqG2u38ov0vgKasSppIcbBZDlTD+KhZfGXC/MXR1Dre7RPfWQbgCFs1M69ZoTvTybbGrq5ONZ4AydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0ijxEke; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744636562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRlj2XiJciKq03l66vQT5GTuJKT9oCmFfbWUfZiluAk=;
	b=F0ijxEkeX2SkVd/3qst8spYRLRnF8fxS77P6NKFx0G5OllcemNgQEOgHu1vdli4z5mpmdV
	6zeip2PAG2gW4YGsT1HeMKGYd13tYCCNk2d/atiHOLDrUhsPx1211uVddjhL1CyrQiLGjg
	/LJwDDOnVuuk0382+3tAi8jVqzEJg0w=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-qpxqdGBUOveyH6ESYDxuOg-1; Mon, 14 Apr 2025 09:16:01 -0400
X-MC-Unique: qpxqdGBUOveyH6ESYDxuOg-1
X-Mimecast-MFC-AGG-ID: qpxqdGBUOveyH6ESYDxuOg_1744636561
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so51754685ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 06:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744636560; x=1745241360;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRlj2XiJciKq03l66vQT5GTuJKT9oCmFfbWUfZiluAk=;
        b=SAlNheby+f9R9iqM7uAzCMO82v0EKl1jxlImswXwRIxF1bmc5FaNJBGBAXeClsMfWv
         pftiA8LzS9Z2AOdUTQ7toxUt28TFtKVToaTVe9ZlFcPnfFZI1fQ0SmW2NyiedQzqyJ7j
         uuT59FGmZCB4TPHm1pOwRtpArNt7CZJyrgMc/ZlfXChTvRRDytD6TYOD97aerHLWui3e
         fS83v3MpOrL9NHN4FVu1QNDGaJM8O5+ZZD+KQQO/wuAYInJQP1ZZmDzTDeuWoBfSg/tc
         nmgmznR7aSgwNh6kkdIQFrn5p3p+kz7eoB/MfwNDKGEQJUu5NG0sKptodOa33CJGHPtV
         l5NA==
X-Forwarded-Encrypted: i=1; AJvYcCWy4o9zhNbG9BmUxr78rqGcAJnM8ayHYxdgS7gpc0dBtwGZ74Xq9oBHTzilIx8uxrUuI1iBJR4kjRQ6iXJWmmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0nbQLjoINOI3nbVHlnhiWX7xfLIXKrtXCHNH5eoNIaxanxTa
	0xgKmeVRq6GMopgwbj8OhZQ5xuxX//9o3AsDVgHoxMgOMJ494J+/knP2qTYsHrbmP79uo/c++VI
	C8ZysA76rmpk7DIy5A0vx9+AIQ+INbv5asztv+IeaUMQcb3IMPurwm59F6x7hkO3aQQ==
X-Gm-Gg: ASbGncvd1gnQDlH16f6ic7DvJcGLDqP1AP3JKDyzaTgxh6EbPsLbenG2mog2aCMZST3
	lGjqg7RliTttUCjALDjgQxvRHdOXk+8Q8Th7zmYDVBKp9byO4Hde/6vNs82VFH1/Noeo9I3SQ3g
	OTcDLuLe30nGhicDnjdkgxnS9saLC/RCcw1gWtIL4vrnik5vNcRkjBH1kQGbOz9Ibg8I5ZgQzgC
	80c9EgyKAYYBGZyD7YJujyfKmJeuPHScg9yUeLTyMI8iUIR9rlBrlP7AQFFHKgFm+5w2fNrakwo
	cx7JDPjOYOGL2REuDS8qB9XCzsLE4ot/E7a2cvzwFKJYAJrm3y/OpUOqMg==
X-Received: by 2002:a05:6e02:3e03:b0:3d3:fbf9:194b with SMTP id e9e14a558f8ab-3d7ec0e19e8mr104215115ab.0.1744636560589;
        Mon, 14 Apr 2025 06:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExgHhxXQS+UkS433TZApZsN2X07PGZoXRirGDSpfOpQyLI61v16Ezptx5B12okrDFUSAgvBg==
X-Received: by 2002:a05:6e02:3e03:b0:3d3:fbf9:194b with SMTP id e9e14a558f8ab-3d7ec0e19e8mr104214525ab.0.1744636560045;
        Mon, 14 Apr 2025 06:16:00 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc5826f5sm27429815ab.49.2025.04.14.06.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 06:15:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>
Date: Mon, 14 Apr 2025 09:15:57 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
 <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
Content-Language: en-US
In-Reply-To: <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/14/25 8:42 AM, Michal Koutný wrote:
> On Sun, Apr 13, 2025 at 10:12:48PM -0400, Waiman Long <longman@redhat.com> wrote:
>> 2) memory.low is set to a non-zero value but the cgroup has no task in
>>     it so that it has an effective low value of 0. Again it may have a
>>     non-zero low event count if memory reclaim happens. This is probably
>>     not a result expected by the users and it is really doubtful that
>>     users will check an empty cgroup with no task in it and expecting
>>     some non-zero event counts.
> I think you want to distinguish "no tasks" vs "no usage" in this
> paragraph.

Good point. Will update it if I need to send a new version.


>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5963,6 +5963,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>   
>>   		mem_cgroup_calculate_protection(target_memcg, memcg);
>>   
>> +		/* Skip memcg with no usage */
>> +		if (!mem_cgroup_usage(memcg, false))
>> +			continue;
>> +
>>   		if (mem_cgroup_below_min(target_memcg, memcg)) {
> As I think more about this -- the idea expressed by the diff makes
> sense. But is it really a change?
> For non-root memcgs, they'll be skipped because 0 >= 0 (in
> mem_cgroup_below_min()) and root memcg would hardly be skipped.

I did see some low event in the no usage case because of the ">=" 
comparison used in mem_cgroup_below_min(). I originally planning to 
guard against the elow == 0 case but Johannes advised against it.


>
>
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -380,10 +380,10 @@ static bool reclaim_until(const char *memcg, long goal);
>>    *
>>    * Then it checks actual memory usages and expects that:
>>    * A/B    memory.current ~= 50M
>> - * A/B/C  memory.current ~= 29M
>> - * A/B/D  memory.current ~= 21M
>> - * A/B/E  memory.current ~= 0
>> - * A/B/F  memory.current  = 0
>> + * A/B/C  memory.current ~= 29M [memory.events:low > 0]
>> + * A/B/D  memory.current ~= 21M [memory.events:low > 0]
>> + * A/B/E  memory.current ~= 0   [memory.events:low == 0 if !memory_recursiveprot, > 0 otherwise]
> Please note the subtlety in my suggestion -- I want the test with
> memory_recursiveprot _not_ to check events count at all. Because:
> 	a) it forces single interpretation of low events wrt effective
> 	   low limit
> 	b) effective low limit should still be 0 in E in this testcase
> 	   (there should be no unclaimed protection of C and D).

Yes, low event count for E is 0 in the !memory_recursiveprot case, but 
C/D still have low events and setting no_low_events_index to -1 will 
fail the test and it is not the same as not checking low event counts at 
all.

Cheers,
Longman


