Return-Path: <linux-kselftest+bounces-40013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B25B37582
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29006683BC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3515305E31;
	Tue, 26 Aug 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiiwNQrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B01F2382;
	Tue, 26 Aug 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250841; cv=none; b=s4nl8uX3ZJe62PD3BJtSaXfB8DCLlKLsvQtx2xHQstmznobb5UZgDGYqkSvpALcm46t8oj6Z1YzbMjvBn43Pc97iHe3GijBTgxMwnFL4DdNhpCK6UdlMCBKOKJQnGOEueP2btrHX/R/f2W4qAubF8m++NaUCqvKz9tKSkFddbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250841; c=relaxed/simple;
	bh=YqpZF0H5BKgoOr4E+576H5jlNQDB9O+lyTKYsc74AhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTB6G3KC677dSNc/rwENRIjP7jX5AXC+yf4mzNnvnMrmDA7Q89zXzmB+LoN+wA+yI4lkwnHS7OS6AKVDn5yzZPgPlZllcBm+kFVJFkn8O+NczXdMhKxb0Xo68UZFrGLUP57Cf9C8IwSQbdzylnJTRmp3wWvhS5zeB941yzHesB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiiwNQrG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603cebd9so67372477b3.1;
        Tue, 26 Aug 2025 16:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756250839; x=1756855639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRxd/UONu/TxowmunJ9/kcrGECFWZAfk75E2ggirveM=;
        b=RiiwNQrGA/QVTvKI1Wgd2ECZK5sxyxKBgXqyshOB2Tge2TItgwL6krT3nsPhubIslP
         lgQ7qLnr4FHkQvS9q/WPF+zoCyqTFKZmhlHFL2yOX6ovGKP2Vq+BzaAOVfwz5gG1kCdx
         LohUg4AQD3dasM2D6zkGKVWsABhk3kbJPF1N5q+LEwjEbSC+SI2piYLdOX22ys3+NV7Y
         kdzdXgCEsMwlgFBPdbXFTA1Us0o/8BJfxydtdol4OKA5lJ1Ijvd99XRVivOknoI0OuWL
         TFekJlrRhomQwRn0H5hE+2KjfKJpVm68jsd2B/gbLUPv+dNgYm8dY+n+gjd4p78k4JZF
         aFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756250839; x=1756855639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRxd/UONu/TxowmunJ9/kcrGECFWZAfk75E2ggirveM=;
        b=VoEs/5E7UBXd4MsWukQsBiUHoJRyT518cGcQmEDz1RO1y4YeqSarJJ3hjOWsSDXCIx
         KKXl1FYzwnsJ1n3GAeU/wS9d+4jQd3UJ+VWYv/q0rL6MoOLB/houK9nL9XAU3nk82Ul2
         uMPjhZU9Zgwebq/sibrQ7aBpPsGjT0H/KMYDm098ozLoVp0apZGOBG7cfv9jStiEQCx+
         xr1S2WUKJFWgiso3MtnenbC3thjodM8AKJrwnvitTBQDyZ8xAZDq2H7K9vBwIs6Qku4K
         TV+tFvyJXZQNera3ST6ttfPBZTrwGJd1AnEgRCG+hkH4kDYAMSd64LpxNLDIOF5Y2iZb
         wKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjp5w9yHtVDgN9uc7S/KzBNK8gzqCVS0lhlAErUiGapSGvkbwCQHeXM3QVlQymJVrQvZ0=@vger.kernel.org, AJvYcCWSKMg8Rqt2w726L3pF1ML12TO5bzcKwik1fvSaiun6rmXSJHPpdU6QmekO6yP97pbfMcaALvLr30ywU6/gW2kc@vger.kernel.org, AJvYcCXGFPjodoc6/aXrSwRPSKD93vmHhH+fCO1DTFiuAmTs3zfrj3Pr5SBRCVdBlgjkMMnSijzMeNS+ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYI5xvWWOXd7htGPOYWQDMo+bDfuVE7wlIFVtCwpTCJO7+x3xP
	VlFKz4nz1QkTHCACJMEa/4aZiZFmL/OcKHgW0aH8WI3md5UvonM9hDMh
X-Gm-Gg: ASbGncuvG/jgANc/c3J1F1iFugxZm2XCh/AHlINVUu4pvIBaBMjEMW74MV+WW83jZfe
	KW+OkvS4DGpSMfh8jXgvWzz5kYkPrIU7d6TBGbxOJoB+IXjgJL5C9ol9szHRYLukNmmqyynWjGF
	T7lHlEFgDxkeifBtAx0bRDq7wj0Bl5zWYsAPPOH5+gxXWSq6aZKztKSUv2GmbvuhH5wm1pM4Yno
	BaxLuGwwv6/nYQfktU6sgJs88xOIu2KQgV7q94MCkIg2a/NFJwpZ2f7bcZAfI4mQZs6kcKQJJpr
	D9nz3nOm7ljL8h5cf+7ygFFBH3DZKt0X13p2Y07/rbegnvtxeNGGDyitcRo+2xvtzTawztb52Fa
	lLo6YLmpOQ6VV13e4skJ325vKYg==
X-Google-Smtp-Source: AGHT+IFw3BlR2Hf8WSyUz5irV6lWRXvSHxBFpWDj313UXZZMH8r/Cja7Q5XA12Zq/MQgR04f9fhENg==
X-Received: by 2002:a05:690c:368d:b0:71c:1754:26a5 with SMTP id 00721157ae682-71fdc52ffb2mr205251567b3.30.1756250839051;
        Tue, 26 Aug 2025 16:27:19 -0700 (PDT)
Received: from [10.2.0.2] ([146.70.98.190])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7212005f70dsm11426677b3.40.2025.08.26.16.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 16:27:18 -0700 (PDT)
Message-ID: <0e78be6f-ef48-4fcc-b0c7-48bc14fdfc7f@gmail.com>
Date: Wed, 27 Aug 2025 00:27:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tixxdz@opendz.org
References: <20250818090424.90458-1-tixxdz@gmail.com>
 <356xekrj6vqsmtcvbd3rnh7vg6ey7l6sd6f4v3dv4jxidxfd6m@cepwozvwucda>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <356xekrj6vqsmtcvbd3rnh7vg6ey7l6sd6f4v3dv4jxidxfd6m@cepwozvwucda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michal,

On 8/26/25 15:18, Michal Koutný wrote:
> Hi Djalal.
> 
> On Mon, Aug 18, 2025 at 10:04:21AM +0100, Djalal Harouni <tixxdz@gmail.com> wrote:
>> This patch series add support to write cgroup interfaces from BPF.
>>
>> It is useful to freeze a cgroup hierarchy on suspicious activity for
>> a more thorough analysis before killing it. Planned users of this
>> feature are: systemd and BPF tools where the cgroup hierarchy could
>> be a system service, user session, k8s pod or a container.
> 
> Could you please give more specific example of the "suspicious
> activity"? The last time (v1) it was referring to LSM hooks where such
> asynchronous approach wasn't ideal.

It solves the case perfectly, you detect something you fail the
security hook return -EPERM and optionally freeze the cgroup,
snapshot the runtime state.

Oh I thought the attached example is an obvious one, customers want to
restrict bpf() usage per cgroup specific container/pod, so when
we detect bpf() that's not per allowed cgroup we fail it and freeze
it.

Take this and build on top, detect bash/shell exec or any other new
dropped binaries, fail and freeze the exec early at linux_bprm object
checks.


> Also why couldn't all these tools execute the cgroup actions themselves
> through traditional userspace API?

- Freezing at BPF is obviously better, less race since you don't need
   access to the corresponding cgroup fs and namespace. Not all tools run
   as supervisor/container manager.
- The bpf_send_signal in some cases is not enough, what if you race with
   a task clone as an example? however freezing the cgroup hierarchy or
   the one above is a catch all...


> One more point (for possible interference with lifecycles) -- what is
> the relation between cgroup in which the BPF code "runs" and cgroup
> that's target of the operation? (I hope this isn't supposed to run from
> BPF without process context.)

The feature is supposed to be used by sleepable BPF programs, I don't
think we need extra checks here?

It could be that this BPF code runs in a process that is under
pod-x/container-y/cgroup-z/  and maybe you want to freeze "cgroup-z"
or "container-y" and so on... or in case of delegated hierarchies,
freezing the parent is a catch all.


>   
>> Todo:
>> * Limit size of data to be written.
>> * Further tests.
>> * Add cgroup kill support.
> 
> I'm missing the retrieval of freeze result in this plan :) cgroup kill

Indeed you are right a small kfunc to read back, yes ;) !

> would be simpler for PoC (and maybe even sufficient for your use case?).
> 

I think both are useful cases.

Thank you!


> Regards,
> Michal


