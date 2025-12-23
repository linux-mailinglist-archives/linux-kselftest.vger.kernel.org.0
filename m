Return-Path: <linux-kselftest+bounces-47913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9ECD83BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 07:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C54A300BFF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317C2F747D;
	Tue, 23 Dec 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1Qc8C7Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tsd/VeyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951E17A303
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766469993; cv=none; b=ZOZPd/CtTJFtt4sKi+WAO8zBOJv3aGSBcTosQqfnn3bTfOrmRmSZ6MwPwrw+57HqXnYcretMC8LSR17PjimBt4srR7/LbIAeyMg/+DSOYjO/8GAAwG3nW01GiTGy6qqliAK/LOIGMDp6//1eP2yoSmcRDZehy9KGXDNYlgoEXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766469993; c=relaxed/simple;
	bh=sl4V/2oRNdodTxAs9PY8rQJ9ubzl71UrJgKTFRdnGMA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nz8RLeYh9FbOKcUCo0j7wNAtQUO4CTDDBaxXjYI3AYmNP1hWgZdA65L0q9tBXmJLq1yVaU74iWkN2fd+uKvU6jOqFoDubNzoDGBzX3OqQCXKdobqNbu2ng0DbkWiWtPLOKwTSF2hdguxQp53ipWKJdcZxxPeV2ql5wY1cCutn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1Qc8C7Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tsd/VeyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766469990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVGvbZ5j1OxNqws5ggwS2VhooZHiFDZC9rqYB5ZeCxw=;
	b=U1Qc8C7QtDbr7l33/0WY/Wenoke850eiHLaLO8QXyPx0LP8+KuWY1qF9jLRg+lYlrGn8r6
	QUAmeyDZkRaqHJ4Iq/01AXnTRz2s/ytWtTbOsh96G+EeqXEPrpuKpT919p1ll7dZTuy8iz
	i+yz31lCLzf1Ja9PkYBwcrz8hdBxeog=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-jBf9G5-KM_uwZt4gRPjEWQ-1; Tue, 23 Dec 2025 01:06:27 -0500
X-MC-Unique: jBf9G5-KM_uwZt4gRPjEWQ-1
X-Mimecast-MFC-AGG-ID: jBf9G5-KM_uwZt4gRPjEWQ_1766469987
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee21a0d326so18800091cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 22:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766469987; x=1767074787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVGvbZ5j1OxNqws5ggwS2VhooZHiFDZC9rqYB5ZeCxw=;
        b=Tsd/VeyIs1J1Z9SK1xppPeJ0+1LQ6LehqUtMOsyUrZ21gK1jxeGAxmKjDbO8e2tI09
         j3v4XPNFrWD347vLrHR3EEXpaj8vP/p4xuEb3TVz7nLpk75AU8v1aEcAK0aO11FjyGhk
         B/SpSD2XJ72L3RNW4sL7eug4SBcfEsHfSFCB6IlAI04JeCOnfeLK20ecHqKTgkyyrl5Q
         XWt5YQOmxVF/2YS5aSNjxFv90b+M+r08+1f4tPvEx5jL46837p3q2SKg/Rzv1+jP3Y0R
         NwzWxrSBgbBQwc4/ncH4WcY3SBWo7xzITpjsu6qI57y99JLQPm777yncYdbmvWKXIVr4
         NIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766469987; x=1767074787;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVGvbZ5j1OxNqws5ggwS2VhooZHiFDZC9rqYB5ZeCxw=;
        b=a6Gsbh9V4mVFxJp5mRUGWIvSy4R1RHbBu91WTMfyagNfQyMqW69vZsG/+K/vBVVgSd
         fY44uZEITFRihtRBdfxpmCtUiWWdVSVIk3BFoJcwh8vTo6l0IB7QieGQIqhQecGMgM6Q
         JtpeyA11nEtDZTIh+2gaVgJJZ25XZJNJPeIS/K/FNVfEXxQjQtKo+0m4zZIa0VcLXA1f
         8PkMtX46K+ZU30P3FTQohS6SCUYW/s1/ETJJ9Jzdf08uSj8vBi59sHOs44Rflz86wNZb
         iLFmTFMotUGZhV47g5W8A/YXdYmn5qzZA1kwRNSl9XoIlrhmru5/Y9Z7HaNVZyaDu1xH
         B9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJLHThbXgwNE3ErZh98u4Ft/PVW+1i/pA4RxzgSv3NuBAbyrNIQhzee0kAREUdWrJD4QH5Mo2YcYDBzNBUWvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTy5Y0tVAGEn3sbIcTYnhtPHXw8G5zjkmPU0uutqHsMxAXdZB
	Zo8mUESx2HJ/jokjkvZ9ugACNHqGHmt+Zd+NiTStGtDW3uOl+vV6HP43PcZe9zPabm/FOhMNuQM
	jsjM8otZ/TLXf/ofR9MpY/KVZPP6TJDutqCuuTWwRfAf8qENPKQqCBH/aOqzGdE+G6M4adw==
X-Gm-Gg: AY/fxX6ldZ2V9tLksbjHKJD96hDZCIR9Wdxdof7WmbRmlgcXdjEYMGjuC88Y6vr6vNh
	t7HemmeQLdlhHxc/Q2o1LG2bf7v+FmyiEhfurKFMnq3uZtUff44OyAaRMVt5uSojm/4wuHLLPZ3
	M7g9L3bEn9xaQsr0PVXcumUoJiK1vDy2QP0cs9GZR6QgDY318DZKaGzjBC2PiIh/ezFBpbMi1HB
	ezKgI6Q6R8r8BvB2iqUg7VRrlOQ9k70Elb6ZkI9zmHM82yiOHNg48QvKJsoZrLTR2U0/OnSCRMD
	Cjl/UzrW3JF9nUxYQy7C/sZAKG0WxMXDmxkHto8fMf3B4p5j+xarnGLVmoejN4lYIOzyV292sIY
	juwSqYMLE3dZ71fVkgn2zL2mouylsDZx7EViSX8lmKeDmMWzxmw6QxSSI
X-Received: by 2002:a05:622a:a0f:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-4f4abcf745fmr198847681cf.13.1766469987024;
        Mon, 22 Dec 2025 22:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCMfOsKUa5N018MI5LZZx8dMOGlI0cQB0E2XsbXSJT4z6FAwrnsjhkILQxH+78hEJJC6ntow==
X-Received: by 2002:a05:622a:a0f:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-4f4abcf745fmr198847521cf.13.1766469986697;
        Mon, 22 Dec 2025 22:06:26 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997ae49esm104579866d6.28.2025.12.22.22.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:06:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <52b109f4-18b1-48ae-97ff-795328bfa5a0@redhat.com>
Date: Tue, 23 Dec 2025 01:06:24 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING][PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mkoutny@suse.com, shuah@kernel.org, tj@kernel.org
References: <20251201093806.107157-1-sunshaojie@kylinos.cn>
 <20251217094530.1448665-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251217094530.1448665-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 4:45 AM, Sun Shaojie wrote:
> Hi, Longman,
>   
> Just a friendly ping regarding the patch "[PATCH v6] cpuset: Avoid
> invalidating sibling partitions on cpuset.cpus conflict" sent on
> [Mon,  1 Dec 2025 17:38:06 +0800].
> Link: https://lore.kernel.org/cgroups/20251201093806.107157-1-sunshaojie@kylinos.cn/
>
> Could you please take a look when you have a moment? We'd appreciate any
> initial feedback or suggestions you might have.
>
> Thank you again for your time and consideration.

I am sorry that I am late in reviewing your patch. I was busy in the 
last few weeks. Now I will try to review your patch later this week.

Cheers,
Longman


