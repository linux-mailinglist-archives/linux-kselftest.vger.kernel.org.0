Return-Path: <linux-kselftest+bounces-30627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77058A8686F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 23:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C998C5E60
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A929CB52;
	Fri, 11 Apr 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbV7eFWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52F29C345
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407742; cv=none; b=Wf2q4GMp6FjbFeHfKjNtKbyBvV2rKMuQzqzRC/TPRpKSH6cMQpzh8XeAy+KvTRghXJtn5SVaE92d1LTtkk3uErj3BGqOnQlZw9PZUQKlKvRr6cu/q54kgsyKlFGLsU74fVVDzWKR9WeV8C0d5aHz74KMs8v8kB93j30D+d97RHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407742; c=relaxed/simple;
	bh=VGgUuxdv1xzGXXZSD6ZHULfD1Juf1McLzuRi+iTVC90=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jrCu5/YsTmcz1h1risbQK73GVS6vMfhUMEkGeu36gKpk/hTXBsPqs2c1XYYvDuZATHbyoMtRrOH1reuDNhMDtMvGqFCcFPEl/h+pqxM8Jebc3xBfwSVrrkqGUnjmvN+GDVV+58h5U7DBftBXaBz5ugNlqPxWScwFO/Allmgw1XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbV7eFWT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744407738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gi9jx3ynN0Fvs6xU8s9qk3uwTlKkqCTwIN8L/fT3WM=;
	b=NbV7eFWT+KABGSNX73uO9DMjAN0lmdnoRLVweh+zxWqyl3xhm6gx43Px2OHiuDy8hnQsZV
	kfwbOxBa0vUaTht8AxPOIe5xw+jEZKdpTkx158yAn2u9ZOWonkJJv3abf+cH5jTYPCTGjH
	7kKMNR8swI3lNQBKHyz8eWTJZAx9U3I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-z7tr-sgOPaqhaWd04nGfUw-1; Fri, 11 Apr 2025 17:42:15 -0400
X-MC-Unique: z7tr-sgOPaqhaWd04nGfUw-1
X-Mimecast-MFC-AGG-ID: z7tr-sgOPaqhaWd04nGfUw_1744407734
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5f3b94827so439713985a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 14:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407734; x=1745012534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gi9jx3ynN0Fvs6xU8s9qk3uwTlKkqCTwIN8L/fT3WM=;
        b=IcNL/hdwVylDpN5KafEd/RdZln5vT8CwzqXU2nWhIE4Kawcrz/Uf3ygr7RyVpd0Qbn
         wKzuBarZENfjJGGpUuzy/JaJ5TO7+oW3sZ+fehV4OYGn/DqpBiqjZhttCMzWLJsh4hZT
         E9Tb7KDXUWER+AlteLPnM+mBqTBocv2NItSOniAHPU73XWpMWwbX3eSL8w29EWlsPrjf
         LQsBhvXROfsXVlLE8hZPdZMgWMckhnXnrhS+WlT+BGdgEwPzJKl2bK4j44ylbb4P1uO+
         Ju6bM5kw401HebIxoAbvedYtoPd9qLxXz+sxuh7NrqXR/2rk5DuT08dtKKZcXBTAvKZE
         Drjg==
X-Forwarded-Encrypted: i=1; AJvYcCUzzYx2kNEkbJQP24gF8ek2jGMGtwCghCqnF+xOUd/XotLBBy0fONL0H75NMG4L+5YX1UXnqFYSLex57ZQw1w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukaC9NAModcouasKKzX9EBAURqioiO3S01zLU9Qdw59G3EwVC
	7KLM5/un5jN2pmA2zdd5NlpzFLOEE3ropQLXn2Hnfx28btnSPxTdDFgScsh7fXlu/pbN1hkOFDD
	z32a2fPZHLpZHOD9dW3+buve7EMUJ+rVQLJ3NxFRWsqj2c2Vz9c0tqKY8sOh1KT2N6g==
X-Gm-Gg: ASbGncuAU51Gz9JUWyKYAhJ/iQEvStUQhqLTDW9hNOPB/NYJFcqot+0B2987/oCFoZf
	kxIolitNsiET/rpreG5XL/4VLuXI+QGm+/fofTOo2siskuTsOHjhihURhEVzeA7nbFrlo8LnFiL
	c8G9pt+jQi1UdgJFR4X0+Zuz1yRgxNpf0Z/cFM38yC7he936lNwLbyinNcMbSoLA8C3DnZ7tv3C
	rpAWFGyrwPsl3bple5n4VoKEtt3maQRC/jnB5g5MG3686sX+A8NNZ51pB0LB1pxH8M8mX2KBB02
	D/rkSf6pHL1PkJzf5v1G+5ZAnJqWRDQXRIyGqdgfXJI99KYs+ygoZWxIgw==
X-Received: by 2002:a05:620a:4608:b0:7c7:70dc:e921 with SMTP id af79cd13be357-7c7af12df3emr861620485a.36.1744407734614;
        Fri, 11 Apr 2025 14:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrW3e7AIHhIu7AXBF5LC5KsZhgZcA6ahLpM5fFHEpeXmV2PCGX62skPo0rxtAIqHbrxnoQTQ==
X-Received: by 2002:a05:620a:4608:b0:7c7:70dc:e921 with SMTP id af79cd13be357-7c7af12df3emr861618085a.36.1744407734327;
        Fri, 11 Apr 2025 14:42:14 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a895163asm317581185a.27.2025.04.11.14.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:42:13 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <22368dc1-e026-4e9d-bb65-6df62f960a15@redhat.com>
Date: Fri, 11 Apr 2025 17:42:12 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] selftests: memcg: Increase error tolerance of
 child memory.current check in test_memcg_protection()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250407162316.1434714-1-longman@redhat.com>
 <20250407162316.1434714-3-longman@redhat.com>
 <pcxsack4hwio6ydm6r3e36bkwt6fg5i7vvarqs3fvuslswealj@bk2xi55vrdsn>
Content-Language: en-US
In-Reply-To: <pcxsack4hwio6ydm6r3e36bkwt6fg5i7vvarqs3fvuslswealj@bk2xi55vrdsn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/11/25 1:22 PM, Michal Koutný wrote:
> On Mon, Apr 07, 2025 at 12:23:16PM -0400, Waiman Long <longman@redhat.com> wrote:
>>    Child   Actual usage    Expected usage    %err
>>    -----   ------------    --------------    ----
>>      1       16990208         22020096      -12.9%
>>      1       17252352         22020096      -12.1%
>>      0       37699584         30408704      +10.7%
>>      1       14368768         22020096      -21.0%
>>      1       16871424         22020096      -13.2%
>>
>> The current 10% error tolerenace might be right at the time
>> test_memcontrol.c was first introduced in v4.18 kernel, but memory
>> reclaim have certainly evolved quite a bit since then which may result
>> in a bit more run-to-run variation than previously expected.
> I like Roman's suggestion of nr_cpus dependence but I assume your
> variations were still on the same system, weren't they?
> Is it fair to say that reclaim is chaotic [1]? I wonder what may cause
> variations between separate runs of the test.
Yes, the variation I saw was on the same system with multiple runs. The 
memory.current values are read by the time the parent cgroup memory 
usage reaches near the target 50M, but how much memory are remaining in 
each child varies from run-to-run. You can say that it is somewhat chaotic.
>
> Would it help to `echo 3 >drop_caches` before each run to have more
> stable initial conditions? (Not sure if it's OK in selftests.)

I don't know, we may have to try it out. However, I doubt it will have 
an effect.


>
> <del>Or sleep 0.5s to settle rstat flushing?</del> No, page_counter's
> don't suffer that but stock MEMCG_CHARGE_BATCH in percpu stocks.
> So maybe drain the stock so that counters are precise after the test?
> (Either by executing a dummy memcg on each CPU or via some debugging
> API.)

The test itself is already sleeping up to 5 times in 1s interval to wait 
until the parent memory usage is settled down.

Cheers,
Longman


