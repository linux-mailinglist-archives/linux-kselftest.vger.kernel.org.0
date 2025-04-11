Return-Path: <linux-kselftest+bounces-30625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C9A867F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 23:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9445A466348
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EBE29614A;
	Fri, 11 Apr 2025 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1nxHaVh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BA293B4F
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405987; cv=none; b=HCJtxD9N3NxBwjLzPQ3KHqkU3LzGpBewHG/fyLoIH1Ti+4PAUl47ybFldWSXn2aorFq3Q9KA7l9pTrrs2pq7M5DIjuXSqM1mEP7F6vT7VhVQv7+QAlh1R/Ib31RPTgBTcMvNyQRG9sWh4wZVb9F+dKur9ohW7JcWDI5o5tEh1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405987; c=relaxed/simple;
	bh=fYOEeiYfqi1o9P3a08i57YyitXfcls9ovxTN53IQBvY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ns5nR+nWj3QHHqi+M0OQBjZ24h5n4xzZc3Ry2ceuP7gHObYhwgAKoEO1UIJhhEFRwDXnp58rT5jV14QwZNHqQ34Tbh3Yhz5QnzzR/exEqgwH126Vgp8r3cYnpyTU/ENy2sEukZRzrHjLB6nbgr1U+WuAazzPt6p1xuPuVkxAg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1nxHaVh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744405985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2KJ3vbhhei7UlaB6YBbaCcfWrpCjfMnuhrykVfj6hA=;
	b=E1nxHaVhrWILeDrNRjc1fQyZlEV3ykA+i5cpwJP4IVm7bPg2cbVTqq/osVVc2UvdWFodM8
	p98rb+ihYO8+V0qpPTWPtCZa9ymyUfIlVyaLcNPHz4TybWoEFlaQxOQIyiLq7oNpJWdKFX
	W3vpbCKXIEfxjT0aG7sAIKpAZ5YmkuQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-AxG7RkXtPCaoIE87dkAWDA-1; Fri, 11 Apr 2025 17:13:03 -0400
X-MC-Unique: AxG7RkXtPCaoIE87dkAWDA-1
X-Mimecast-MFC-AGG-ID: AxG7RkXtPCaoIE87dkAWDA_1744405983
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c760637fe5so460539685a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 14:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744405982; x=1745010782;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2KJ3vbhhei7UlaB6YBbaCcfWrpCjfMnuhrykVfj6hA=;
        b=aiZV/ybnAC4r6/biUI5jHmpeY5tHEEkn1AHtc49uW5mVyPVpfmGs/kFtcaRlsnhlvo
         qVq5oWs9Jkh01s9wAeVPzET1mgf01lr+8YG87hRAwoUU8XpIviD+Ej4RMmHwxQ/DtA9m
         BEcQMa/tGPKTn2nDriFM1YmDYnBB96geYX51/LLgPLzAFjgvdXWYiOaezVLnXuy01ZfY
         I6/zpvjaTkC8x39rdd3iMMsIBDQ/gwgDze6aIbYQE8K5Ul0ZwYW7D5LWWEbqjEMjmMyl
         SBNwbnBnH0N/t5Y5SOLG7AV4cDt+r3PixepZ/3f6s7lvplW8Dp8/q0Q5j6FIQrFCG1jP
         zGqw==
X-Forwarded-Encrypted: i=1; AJvYcCXQSmDE8xATSZPX6fJCicsxx4lYd+NFW5A+SVsQ+f4KZSHs4+msMG+3toE9U0ZwnbTyoHBObmHi3RDiUVOtbdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGRALa7MtNC0vqsq+W28f4Sj0bLXMGw4Q/UNPkWm0hdrWg1BQ
	T8uVD5tt2Pk+P8Lc+b+YWWH7db0GRODe9BAyrPP3G0St1z9gvQ+tNiIx0QMSFo1zgYEkzH3OqTx
	j2FDcgmLFOJh16QrHDvo7cI/07IDoteF40pLWbssO0cHCIKx+97pP4FgIRe8yimV8j+oGhry/YA
	==
X-Gm-Gg: ASbGncvk8z4e1FHXMooBxCY0rw/sgmELT+lbfIiJxkBE5tSIZSvF8owyKdl058nIhgw
	MfqfDS7QSrAF+hOrCBqqxVLhPusfG8eYtJUkpaWgR12ng0KetD2rTpDwKCkXGcH/JRdxH+W+G0e
	OmS7oDRNK7l7n27eT4OIVa0P9LBNgpEqqUo5KqbYzNFhzOlAmPC/2LzCM/PGUqtDgBCNyd09CYC
	Nhi9FGv1HdCFDhSEar7pMUs2apR4weeOOUSTqmw8/TamJLFHkxO4P+rdnhdsFEpQ/pOu02D/eeW
	3hu89m9/i8IPdW12IS5Uo8LeE3VVOmxGZU0Nq6eYcbozy6TO1zMMaTLS4Q==
X-Received: by 2002:a05:620a:bce:b0:7c5:6ba5:dd65 with SMTP id af79cd13be357-7c7af20dfccmr702417185a.55.1744405982626;
        Fri, 11 Apr 2025 14:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEleT+JnQIZjjY1BnHjF+zn74YxSy7C0p+IDn0drbShDJE5Rd9yuVCeBx0//zZEmHI9Zxuqfw==
X-Received: by 2002:a05:620a:bce:b0:7c5:6ba5:dd65 with SMTP id af79cd13be357-7c7af20dfccmr702413785a.55.1744405982228;
        Fri, 11 Apr 2025 14:13:02 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89f9639sm313660585a.78.2025.04.11.14.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:13:01 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0158e459-c205-4a88-9711-3dea2bca71ae@redhat.com>
Date: Fri, 11 Apr 2025 17:13:00 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250407162316.1434714-1-longman@redhat.com>
 <20250407162316.1434714-2-longman@redhat.com>
 <wc2pf5r5j4s7rpk7yfgltudj7kz2datcsmljmoacp6wyhwuimq@hgeey77uv5oq>
Content-Language: en-US
In-Reply-To: <wc2pf5r5j4s7rpk7yfgltudj7kz2datcsmljmoacp6wyhwuimq@hgeey77uv5oq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/11/25 1:11 PM, Michal Koutný wrote:
> Hello.
>
> On Mon, Apr 07, 2025 at 12:23:15PM -0400, Waiman Long <longman@redhat.com> wrote:
>> --- a/mm/memcontrol-v1.h
>> +++ b/mm/memcontrol-v1.h
>> @@ -22,8 +22,6 @@
>>   	     iter != NULL;				\
>>   	     iter = mem_cgroup_iter(NULL, iter, NULL))
>>   
>> -unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>> -
> Hm, maybe keep it for v1 only where mem_cgroup_usage has meaning for
> memsw (i.e. do the opposite and move the function definition to -v1.c).
memcontrol-v1.c also include mm/internal.h. That is the reason why I can 
remove it from here.
>>   void drain_all_stock(struct mem_cgroup *root_memcg);
>>   
>>   unsigned long memcg_events(struct mem_cgroup *memcg, int event);
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index b620d74b0f66..a771a0145a12 100644
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
> (Not only for v2), there is mem_cgroup_size() for this purpose (already
> used in mm/vmscan.c).
My understanding is that mem_cgroup_usage() is for both v1 and v2, while 
mem_cgroup_size() is for v2 only.
>
>>   		if (mem_cgroup_below_min(target_memcg, memcg)) {
>>   			/*
>>   			 * Hard protection.
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index 16f5d74ae762..bab826b6b7b0 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -525,8 +525,13 @@ static int test_memcg_protection(const char *root, bool min)
>>   		goto cleanup;
>>   	}
>>   
>> +	/*
>> +	 * Child 2 has memory.low=0, but some low protection is still being
>> +	 * distributed down from its parent with memory.low=50M. So the low
>> +	 * event count will be non-zero.
>> +	 */
>>   	for (i = 0; i < ARRAY_SIZE(children); i++) {
>> -		int no_low_events_index = 1;
>> +		int no_low_events_index = 2;
> See suggestion in
> https://lore.kernel.org/lkml/awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2w2ke@xc3sv43elkz5/

I have just replied on your suggestion.

Cheers,
Longman

>
> HTH,
> Michal


