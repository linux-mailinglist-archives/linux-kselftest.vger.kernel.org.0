Return-Path: <linux-kselftest+bounces-30127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB50A7C35F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB753B289A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056C17A318;
	Fri,  4 Apr 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWM0A95p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C51624DD
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793276; cv=none; b=Fa9GW9lXh1Bs/slECRFSGrqqL36CIxgk+gzilFb6ZXJA3XUan61g76gEw9jvagd+EsSGlB8nQ5UGlPEMjdQtWbbuIbbk14+Ov+21tm07i0Wo0rN9XLzZJluqZdjLCaXeIX2sQt69OxMbS0fGw9pzkyZTLoTE7NO1Ljzsg7y7Mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793276; c=relaxed/simple;
	bh=1pLMCas5pwDT0a+/nUAiGb02bobVqC03NTC9w4ajQfM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UgtAgzldRcfB2pbxJi0GyLeZcpoNXvEHJehnogKQdrMczaBQQnbSZZnMR0pJzzv+LsVdad0CbsKsVuibNGhtsyupztHxTse47kDv/m710n6mkByxCrCMFuYTahU9MUBbVq91Zm5miS9EIsJDJsdFbNuZjrNRqhCc0mEe4//nlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWM0A95p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743793273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1MMtNiDnolUZJhUSU3/9gDr+oQodav3erGGx1lsb/g=;
	b=jWM0A95pR0JmHQg9BVGRDbjVJhXtsf2LRWMDVumAaVvCwLpJjBbUyfCadaUVuo4TfkPovT
	NaI/D31prQHDWRrQLLL9csbka1O4X0oy0oE/dd3u7Wzi6rTZjoh4RKkTgu3jPCyiOuCbEI
	TzCnDSNNAYuXDuMRF0saxIy207AL4Vg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-SoEZMNkFNl-ya1fzOU2euQ-1; Fri, 04 Apr 2025 15:01:11 -0400
X-MC-Unique: SoEZMNkFNl-ya1fzOU2euQ-1
X-Mimecast-MFC-AGG-ID: SoEZMNkFNl-ya1fzOU2euQ_1743793271
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5c77aff55so551379885a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Apr 2025 12:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743793270; x=1744398070;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1MMtNiDnolUZJhUSU3/9gDr+oQodav3erGGx1lsb/g=;
        b=IHeAaDe7B1XEdE9T/iRPRxA0D3ouIw6EYzEhygYlCwj1wM544cup7aETn5KIsKI3Je
         YOL/ebVfS9U1xTEOcTHIYXjgfpIB7b7Skhn1+qI3nW1jYxdcG3xcNd9CO5el8xvmPoH+
         3YAVnDUQOC4Jl7N+nL8MMP8MNdpT/+Za+WsN5ZJcIfK0OSICBMPYz7Rlu8xNnGBIQxUF
         PRA4Rdz99OQGtq6ecp5OWYCoHTCw6pbxPwA9kfdjb3BKHtyL8gLarrbKfwzMrrSxcPOG
         TdLCXvWprM4Nl97KEMHMmDpXhufQa/gA4uZVGaqbKzq0bV7/+hiCP34E1IC2Kf+28jG7
         peOg==
X-Forwarded-Encrypted: i=1; AJvYcCVxxWnDlUaGESsXI4P2lruXC8j3yg0nwWzZAosG2R2RWb+9qS8jRYetfuJdPx6bfW8VjSqJ6KyxFkHTKobi/tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+A+M7Va41P8bfVLYkBALCyRCYyVIMNUnNgjhGh9yNkPUMFGYx
	FS0uEPkveczMxrnhNZ3Zpr99AmFhL1oDsO/n2C8XnGDTyzoZ2jTvD83XDRXl1B3wOvO3xSIGAwF
	GSagnt8+uMwGm/45aK3DQAKnlRtYsf9muDq3hhhRla45RqJ97STh/B+IPHAtP1f02XA==
X-Gm-Gg: ASbGncv+tSatY8svqJMhIlwFp79HVMcZIpPMfLkpnlVULqCfP0D++nNsyPaHA7Y46HB
	V5fd26nEWRb26YeQl3xJaNy4fM4sTudrr4yo9zd2aMZB7kspWQRABa5s8MffbokFvQ2XzfxyhrF
	xImOssizWCdjV1ACHZNjYbJY2rK38kzSU7mOg525Swce2FePHgE4XpYXK3Xc1N/cGzlkyzov6DW
	ygZ1FcskfwMP0uYm+ZRjpCSRkjWSJYnD2VDXNTZZ0R6aI+7fFhE2dWd0XZnvncH5yyoduhxnNyz
	s/jlFvf9yROJ/yfcMS6Y3pU6b+rFxq3FRGx0jlBI42CO7ZH7JcyX/IvtiuDNbQ==
X-Received: by 2002:a05:620a:2846:b0:7c5:3b8d:9f34 with SMTP id af79cd13be357-7c774d71e83mr623397885a.34.1743793270588;
        Fri, 04 Apr 2025 12:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2pRizqiBzi0bsE2Dny26nsl1JiAGoprEnqGYgEVCSGkEWDheGOUcCAScM0Ciy8R9ST8/yug==
X-Received: by 2002:a05:620a:2846:b0:7c5:3b8d:9f34 with SMTP id af79cd13be357-7c774d71e83mr623393285a.34.1743793270255;
        Fri, 04 Apr 2025 12:01:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e5dc169sm255423485a.0.2025.04.04.12.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 12:01:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <89775280-c702-48cf-b430-07231759a8b7@redhat.com>
Date: Fri, 4 Apr 2025 15:01:08 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <aopkqb4bd6sag5mgvnvmoojlsz47lxrgxav7lsywkzeqtb5pco@ptxoqnloplzi>
Content-Language: en-US
In-Reply-To: <aopkqb4bd6sag5mgvnvmoojlsz47lxrgxav7lsywkzeqtb5pco@ptxoqnloplzi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/4/25 2:26 PM, Michal Koutný wrote:
> Hello Waiman.
>
> On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long <longman@redhat.com> wrote:
>> 1) memory.low is set to 0, but low events can still be triggered and
>>     so the cgroup may have a non-zero low event count. I doubt users are
>>     looking for that as they didn't set memory.low at all.
> I agree with this reasoning, been there [1] but fix ain't easy (also
> consensus of whether such an event should count or not and whether
> reclaim should happen or not). (See also [2] where I had tried other
> approaches that _didn't_ work.)
>
>> 2) memory.low is set to a non-zero value but the cgroup has no task in
>>     it so that it has an effective low value of 0.
> There maybe page cache remaining in the cgroup even with not present
> task inside it.

For the test_memcontrol case, a cgroup is created but no task has 
already been moved into it. So the memory usage is 0. I agree that if a 
task has ever lived in the cgroup, the usage will not be 0. In that case 
memory reclaim is certainly justified.


>>     Again it may have a non-zero low event count if memory reclaim
>>     happens. This is probably not a result expected by the users and it
>>     is really doubtful that users will check an empty cgroup with no
>>     task in it and expecting some non-zero event counts.
> Well, if memory.current > 0, some reclaim events can be justified and
> thus expected (e.g. by me).
>
>> The simple and naive fix of changing the operator to ">", however,
>> changes the memory reclaim behavior which can lead to other failures
>> as low events are needed to facilitate memory reclaim.  So we can't do
>> that without some relatively riskier changes in memory reclaim.
>>
>> Another simpler alternative is to avoid reporting below_low failure
>> if either memory.low or its effective equivalent is 0 which is done
>> by this patch specifically for the two failed use cases above.
> Admittedly, I haven't seen any complaints from real world about these
> events except for this test (which was ported from selftests to LTP
> too).
>
>> With this patch applied, the test_memcg_low sub-test finishes
>> successfully without failure in most cases.
> I'd say the simplest solution to make the test pass without figuring out
> what semantics of low events should be correct is not to check the
> memory.events:low at all with memory_recursiveprot (this is what was
> done in the cloned LTP test).

Another alternative is to modify the test to allow non-zero event count 
even if low is not set.

Cheers,
Longman

>
> Michal
>
> [1] https://lore.kernel.org/all/20220322182248.29121-1-mkoutny@suse.com/
> [2] https://bugzilla.suse.com/show_bug.cgi?id=1196298


