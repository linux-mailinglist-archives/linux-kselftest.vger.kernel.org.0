Return-Path: <linux-kselftest+bounces-38604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E84B1ED00
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 18:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A23F18C8050
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA22874EB;
	Fri,  8 Aug 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaSXXSwZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49B0287271
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670454; cv=none; b=mjU6I9ttBZ/VNsoF7VhVsqnx/XDtcP0exYMxLT2xxHjXbdHPixXRja7pXsSpvQz7SZU3V9ZpBdX5XkKfKuSBz3rlTCWoJYrSzDwmt3j26AzRML6cYU+lT0wr3XwCtmnOYKnJku4BpGa5iqIPJNAt1q+/gCqfY6RSvpFMqXXaDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670454; c=relaxed/simple;
	bh=35xdwsaBTJ1Y4skh6luh1NYwYaL7lznfoO0s3HYedOc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Yw+htq1N6RhcaW8c7d5fEp0PxtPQ9jwOeV4pp08XWRchgEdFMb++1wTYPQfTQSdinQVRpuOCjBoABicJPsVAC0KCK4y6ojcfYtNMN5ZHKD4uB94m6iij6zDW9XPsJ7QWTwBda8t+pBr4QsGaUBTjvWaGynP1dnxa+QyCDb5iPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaSXXSwZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754670451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2n2d3+1CIGjf3VybsTqnnNSZHlfvXlp65LE1VoA9y8=;
	b=SaSXXSwZyLtw7C22Uqk63mPoahvYCDr9NqQS2KHO5sthemoqIp0UJL9XQw+F2/XKLBKqvx
	ZUS32854N/PnCBMSJU3ig38CfCJi06KZkfCTPD60K6Qm9mQOipEV0BmZB8FC8A4FxZDTjc
	j5JGWfmzi67Ws4/GsA6e01dLpfY/4Yg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-ycA-a-nfNQ6Fa-FZ71RwYQ-1; Fri, 08 Aug 2025 12:27:29 -0400
X-MC-Unique: ycA-a-nfNQ6Fa-FZ71RwYQ-1
X-Mimecast-MFC-AGG-ID: ycA-a-nfNQ6Fa-FZ71RwYQ_1754670449
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71b58de76caso32041597b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 09:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670449; x=1755275249;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2n2d3+1CIGjf3VybsTqnnNSZHlfvXlp65LE1VoA9y8=;
        b=SHN3xDf980vApfDx/87Nlm0WAp3J+5f4joUibNQdZc5BYXI/KK8C7FUnSKBWgy9SV3
         mC4UM/1JvqCKeDIE/U7K3IS/il4qYrE7vipH7Zq54XwzY/E+fsjSI/Kd1qJCOd7Ulb5a
         da79R0u21/rIpuUAL9+gfouQqFtGSEYLdI2lZ111ILQ0+b6/5kIUH4AksPgsn+ukZ0yx
         agK093bXU9WzK40q+I9+oIzhIKUv0rXRFzfPrFR0n7n82zS3gl8h38aDsYIbaFa1spSO
         HFyONBb8KgVD5crYqEIvwFuGZASBM5a1x/N94e5kIupDJ4o0xQvrIl4deGM3XYL7M9+X
         7JwA==
X-Forwarded-Encrypted: i=1; AJvYcCW7pseNmMoGUCzpL/fcchWBu/65n5YQ6LTRXpPY0aRqxpup+M5nAPRmzbDgiZTZBVtbADeRR2i8dIY1Ux1WOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWOsN6Rx3UykvqW6D4zBsuLF1dzoKLgymGxy7DY4iTDjH2cns
	CX1KAPBR4MgpxMDkANXw8eO/oaUnuVXw4EZ6aL/UR++VKFcV8YScQNzlICtrJi5SJRQhcBjra0A
	p6lLfer/dz3f6YPUQH7yvXtTubQ6ay6scff2/uOWjUbgAnxWvaoKNzOE6GiLHe9l6Gje2iA==
X-Gm-Gg: ASbGnctOXT0svtKin1O4T6d9NEKjxM49kZsJwjC9DK0YHDAB98fkh8NFiarL2oBwZyE
	phVO72jtVhq2RqzHySAIZ6u5P/7qm62ezctiBbpg4t3q/3CApn8WL6Vk0//Lng19sHgm16E1izu
	XtBMUFQjlgccinKTABULkV7YYYT6X9F9Pv1B0KnDqnpJ9DRBJLIlDTpLQoaJ5ggkuOqQSXX7OAN
	afSRRx4i0gRuini0sroURHfx0TzZMnCbD5sPRTh4i5qhGhZet9xXOVpcPpSMGtwMcr2Bp7unU0D
	lr9gd1YRp6KPJEsarQZSHfrJobUinAZ2YPxHmxPU1d2Pi21rBACMCzU/lG+TgGU604zFizIpNfL
	TN10GPotlYw==
X-Received: by 2002:a05:690c:368d:b0:71b:fa69:1a82 with SMTP id 00721157ae682-71bfa692661mr24301077b3.33.1754670448720;
        Fri, 08 Aug 2025 09:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlW/SK2xqpPPbu5o35295axqLAQOkQhIqoyd+MS4mQP3LIL8+WZc9zZEAAqzqpjzlffRpZ3w==
X-Received: by 2002:a05:690c:368d:b0:71b:fa69:1a82 with SMTP id 00721157ae682-71bfa692661mr24300697b3.33.1754670448271;
        Fri, 08 Aug 2025 09:27:28 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71c058d6bf3sm398587b3.22.2025.08.08.09.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 09:27:27 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <43af3cb0-3a8d-4ed4-9007-992475ba2844@redhat.com>
Date: Fri, 8 Aug 2025 12:27:25 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] cgroup/cpuset: Enable runtime modification of
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Phil Auld <pauld@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>, Gabriele Monaco
 <gmonaco@redhat.com>, Cestmir Kalina <ckalina@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
 <aJYcsXEiFmCmDAjz@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aJYcsXEiFmCmDAjz@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/25 11:50 AM, Frederic Weisbecker wrote:
> Le Fri, Aug 08, 2025 at 11:10:44AM -0400, Waiman Long a écrit :
>> The "nohz_full" and "rcu_nocbs" boot command parameters can be used to
>> remove a lot of kernel overhead on a specific set of isolated CPUs which
>> can be used to run some latency/bandwidth sensitive workloads with as
>> little kernel disturbance/noise as possible. The problem with this mode
>> of operation is the fact that it is a static configuration which cannot
>> be changed after boot to adjust for changes in application loading.
>>
>> There is always a desire to enable runtime modification of the number
>> of isolated CPUs that can be dedicated to this type of demanding
>> workloads. This patchset is an attempt to do just that with an amount of
>> CPU isolation close to what can be done with the nohz_full and rcu_nocbs
>> boot kernel parameters.
>>
>> This patch series provides the ability to change the set of housekeeping
>> CPUs at run time via the cpuset isolated partition functionality.
>> Currently, the cpuset isolated partition is able to disable scheduler
>> load balancing and the CPU affinity of the unbound workqueue to avoid the
>> isolated CPUs. This patch series will extend that with other kernel noises
>> associated with the nohz_full boot command line parameter which has the
>> following sub-categories:
>>    - tick
>>    - timer
>>    - RCU
>>    - MISC
>>    - WQ
>>    - kthread
> Thanks for working on that, I'm about to leave for 2 weeks vacation so I
> won't have the time to check this until I'm back.
>
> However this series is highly conflicting with mine (cpuset/isolation: Honour
> kthreads preferred affinity). Your patchset even redoes things I'm doing
> (housekeeping cpumask update, RCU synchronization, HK_TYPE_DOMAIN to include
> cpusets, etc...)
>
> I have a v2 that is almost ready to post.
>
> Wouldn't it be better to wait for it and its infrastructure changes before
> proceeding with nohz_full?

Sure. I am just posting this RFC patch series to show my current idea 
that I have. I will wait for your v2 and integrate on top.

Looking forward to your upcoming v2 patch.

Cheers,
Longman


