Return-Path: <linux-kselftest+bounces-30160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34BA7CB94
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 20:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4C17A6C63
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3299A1A3029;
	Sat,  5 Apr 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3fGF0oz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411FD27456
	for <linux-kselftest@vger.kernel.org>; Sat,  5 Apr 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743879131; cv=none; b=ZcCE6046NvD3pcwC7oGlpbH5uMicMDc5jXb/wD1cGhkW+U11C397jflNUGeDEu9NqN8xMQKWhIO3D7f8WwOsPUkfnUeautYaLN5Tuu2bL0yVn46IL6GKvyU+dXtA7FmR19feMAdUqZIqJhFpiiy55MPoj5IHwEZZmWm/ZzDCDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743879131; c=relaxed/simple;
	bh=yglMeQsz123gDcvxpHoJHPRefkgMmB+L1OHo5trNH0k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SwcONrkKJ7fRLuh2ZDz/YT8qaBvZrzXtC+1KLojbObbQO4Qig4pxf1fY03oFpGi3MmVtmgipWgfySaCwza0hFz/3Eh6tdlgXpVRRDPAq1cJ3bE64ioi+rJ4N1bZSp9kH+5R66JsMpRnIQuqpDGgmznz593NfX8RNJK/kHf5FAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3fGF0oz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743879128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zl94fjucYs05RLWzioyJn3c96IDAkKlAGNSFTZYapG4=;
	b=G3fGF0ozT/FWNAW+zopoKvo0I9LuGbv1RDewLsh4DTaMxkflO5wqJEDtUAubyYeSZiD1uK
	EgEKztJP/y/i+kbacCb0STTglwZt3c89LesWtG7XLFhVsDGgN0q2/r0MI1Ye6dAvPeY1bm
	gsrTKLgCh22HK2Gwlo1JPdKW7mKehfg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-tolhg1mROY68EPqVpryarQ-1; Sat, 05 Apr 2025 14:52:06 -0400
X-MC-Unique: tolhg1mROY68EPqVpryarQ-1
X-Mimecast-MFC-AGG-ID: tolhg1mROY68EPqVpryarQ_1743879126
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5d9d8890fso788697185a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Apr 2025 11:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743879126; x=1744483926;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl94fjucYs05RLWzioyJn3c96IDAkKlAGNSFTZYapG4=;
        b=emBEifSaS2CgwcO7R6mp3Rt/DPWylNECKrVbXErLD2inrZAlzL+6ilCYGUbPaaod1G
         UQ9Yx34vuG9XrVBr6g6sYDVUsH6Z+diF4I5s1ZPxRvLA6Moh/nLBfVhesCKCF5vMMg7s
         zRMi5yO0PUd2MHwZJNZioPEdNBy4wvncX8nX0HzpktV8LrvyIXc2f7Y61prItSGgJCfQ
         x/UYs2yTv5CPrKag22gZDCnTMck4V52E9R7SS8NFxq6xqLUnBT2i88C0QYSuBQDs2MHb
         mOgQSx+yTq1trq0TQRW9hpmDkcNfVaNbvRLF4BZzvVST19hvSLPNL1cCf0Jra3T+Wlb0
         1/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXDb3my02V0dTi5TyPUpSXQppr6ppgZPvg1h1vUIi6kpESAxJZp1P5sV4g8gIxQkJbummglg2svxjQ5sHIiHgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsUePkVUmCtShbbkx16AwSnsmfhHuni/azI/BdTjZ6amnjmFb
	gaSjYvrBCJ83r7kcHTd+GrwyU8c8JB77gA+rwkf8m85AJ04BAGjFVZhxHKRrJnALxwMhsbSPpeZ
	LqpPxz4esqeAC6tImqIu0Sx9dmU7CKJWv3vXbdmA9Kfm/MgpauxSYHD2Qji/AT/g1RQ==
X-Gm-Gg: ASbGncsz4CYT7a4gMR3RUcYQ0mtgXyjOqTyV+H42SFhrwFUC1ehW0k9+aN2fntcolom
	8k7amZ2slp2xAxhnWWzPvGkj03Pit5LvUZW4QSZSN41B+FnsBBnUMjVHeh4u+saM5sj7cVetJLW
	k1R0U0WimT2VmUqXS0cOUg2YJFbV/qdB9K79uEhsvIqWvQSV/K02+Nm3zkYiFHAwvwjqMUmiEml
	RDax0A4492fI/T0lcKoBUetkT/WSwowAsXR42BBtH/61cMnnrbOPOGdsvs0icxdVPfCmye8VXsl
	8P/Qh0KN2AkJhkDcjUc+AzNhhgU/s/q2mssh5NlhpxXQxZHmVXt3utqskOAHTw==
X-Received: by 2002:a05:620a:2891:b0:7c3:dd2d:c0e2 with SMTP id af79cd13be357-7c76c98f69dmr1949212285a.13.1743879126143;
        Sat, 05 Apr 2025 11:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkQV+pEi+TmbqcIT9YnR48A7CUH0qtIrkXsV397pZvj687wq1qfmiwok5il5SMAFPR0p8RYA==
X-Received: by 2002:a05:620a:2891:b0:7c3:dd2d:c0e2 with SMTP id af79cd13be357-7c76c98f69dmr1949210485a.13.1743879125856;
        Sat, 05 Apr 2025 11:52:05 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e968c1fsm371472485a.52.2025.04.05.11.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 11:52:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6712624c-c798-4ccf-afc1-6dfc9efc4b5e@redhat.com>
Date: Sat, 5 Apr 2025 14:52:04 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
 <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
 <20250404181308.GA300138@cmpxchg.org>
 <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>
 <20250404193802.GA373778@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <20250404193802.GA373778@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/4/25 3:38 PM, Johannes Weiner wrote:
> On Fri, Apr 04, 2025 at 02:55:35PM -0400, Waiman Long wrote:
>> On 4/4/25 2:13 PM, Johannes Weiner wrote:
>>> * Waiman points out that the weirdness is seeing low events without
>>>     having a low configured. Eh, this isn't really true with recursive
>>>     propagation; you may or may not have an elow depending on parental
>>>     configuration and sibling behavior.
>>>
>> Do you mind if we just don't update the low event count if low isn't
>> set, but leave the rest the same like
> What's the motivation for doing anything beyond the skip-on-!usage?
It is to avoid making further change. I am fine with modifying the test 
to allow low event even when low isn't set.
>> @@ -659,21 +659,25 @@ static inline bool mem_cgroup_unprotected(struct
>> mem_cgro>
>>    static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
>>                                           struct mem_cgroup *memcg)
>>    {
>> +       unsigned long elow;
>> +
>>           if (mem_cgroup_unprotected(target, memcg))
>>                   return false;
>>
>> -       return READ_ONCE(memcg->memory.elow) >=
>> -               page_counter_read(&memcg->memory);
>> +       elow = READ_ONCE(memcg->memory.elow);
>> +       return elow && (page_counter_read(&memcg->memory) <= elow);
>>    }
>>
>>    static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
>>                                           struct mem_cgroup *memcg)
>>    {
>> +       unsigned long emin;
>> +
>>           if (mem_cgroup_unprotected(target, memcg))
>>                   return false;
>>
>> -       return READ_ONCE(memcg->memory.emin) >=
>> -               page_counter_read(&memcg->memory);
>> +       emin = READ_ONCE(memcg->memory.emin);
>> +       return emin && (page_counter_read(&memcg->memory) <= emin);
>>    }
> This still redefines the empty case to mean excess. That's a quirk I
> would have liked to avoid. I don't see why you would need it?
OK, I will drop that.
>
>> @@ -5919,7 +5923,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat,
>> struct s>
>>                                   sc->memcg_low_skipped = 1;
>>                                   continue;
>>                           }
>> -                       memcg_memory_event(memcg, MEMCG_LOW);
>> +                       if (memcg->memory.low)
>> +                               memcg_memory_event(memcg, MEMCG_LOW);
> That's not right. In setups where protection comes from the parent, no
> breaches would ever be counted.

OK. Will post a v3 to incorporate your suggestion.

Thanks,
Longman


