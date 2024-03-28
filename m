Return-Path: <linux-kselftest+bounces-6762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E196489070D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 18:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B3D1C26952
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757C5A780;
	Thu, 28 Mar 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKf6inN+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAC1EA6E;
	Thu, 28 Mar 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646529; cv=none; b=AFH25Fscp9VGig1Gx2XgwrwQSarjjVg/Z5LyBRpjd6+Hr8DyI7AaQH+74XTqRsI8YO/7wkjJMeVZwQ32HKiBFYFHZ78ESD4chF+eldF9pchOo3oJfMs2DjqRQbw2uNMm2TYO9hdWQnJIgZmWg2QoNaEBCrpfLIlyMfxrAiWYzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646529; c=relaxed/simple;
	bh=rTVGMrfwkd+NlU1R9C/m47OpxkWT83eOW/pXXryVqcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn1D9TmIHPigIqj7jeFQTHTsyDewiFVSX8Pbo64Q7ueSUc+0FtCPyub0W1tMwGMLxOED0wfqXpIoG9sp8nYgylzwdvUCW402yUNqZUgyM1anZCAyD/iCSxjY2ShwJHyKuBXYQG2rQ0wxxQuWuotgzloFiYTVbA57u4AjVqXENXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKf6inN+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so989242b3a.2;
        Thu, 28 Mar 2024 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711646528; x=1712251328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJTs2T19ZBiaUU6XEnV+BuULbMh1YwOJefd/Q2W0TsI=;
        b=VKf6inN+ywJknsS50jG5870ZVt4uTBvXS/YhJyDKGoRxb+cTmts+c1EChjZ7LUhC/a
         zmREgWU4OwDxm+NMG7HMPS18CGK2v/KxxSG3LyEiIqCChWFFsdMXPKl0rgufFVmWR6AO
         3H8jVYKeZeISLiUR4KLIqw5NNk/DYt1oA41RjU3Q4eVRSTLReLoGtDp7/vsbMTKmTwAP
         etycr06zN/jR2XX9aK0K88BbndPVBvYpmxQMxhD60poZs7O+raLG65zJ6dKYL1bR0G5R
         VoDfufXBogD2h1nQxHlXOrHpVGHgRu12dGfZzsQANl/pvOkdrb/V2pj/JEoJlpt0tklK
         xFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711646528; x=1712251328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJTs2T19ZBiaUU6XEnV+BuULbMh1YwOJefd/Q2W0TsI=;
        b=OcwKIC0YMI/ocLQtGKL+/2pBIlo3z1WNB9URjWt51mjYZS3j5MB+ahiqzRIR9HtFQx
         1K3kFQ71MuiutBSYhIenPBjYotAnPga8PXSuE0ZxSvKpvVORC5wEFVbTyJ5ZxC1Jc+PL
         +Dz1ACp8LunyAnnDjJb9kIhEpQGgyBBVBFbHhoBXuD8qvSVNzvTorNOsPRYeLgYvaRTq
         lPJTvrXRFREN+wiMs2okT66a+3a7nqMihEGqV6MTdXSmO7jf2cm8Py1grB7IlvfXpwjL
         abxjNHIYp4utYfmqU+XCdAngzpNMQ9RQY6aHtohX4LO4JYC3BaxSyY4U8xwsp7a6o8L3
         4WoA==
X-Forwarded-Encrypted: i=1; AJvYcCUBSGh/uVwvzYqW7br/GecEyF1ZDcnskdTx9Ia5S3oCd+SAJl7bzAavJ3EEYi3FbvulAzabF41qIHWBv/MrOw3i6UGrbWRVqaPyhsyEFUxCfVkciDeXL+ES9k2Jji6EvRH/ugLoLWHL1vHJ1TR9dxN5ceSTsEw4kquhH3oK5gxkWddIiDkC5y3cPwPy+pbzZbWeLBCmoj6WZEKu6g==
X-Gm-Message-State: AOJu0Yy8mGhM1Vp9bXI1qhyQyOIVpmJ0mV/2imvHfaxjI/nnwinEKb5F
	42E/yAGQgAqNXUcPD1J4X72Qai8wbehtsrA12IVLH5SzV3qw7G4W
X-Google-Smtp-Source: AGHT+IEQw6JvwbE25jnXK5NyR/sgTVhJaXMx83kTTEkRAeXjs5/u197o7f4DiVoEvkuWqC97fCG8OA==
X-Received: by 2002:aa7:8893:0:b0:6ea:c4f4:13cc with SMTP id z19-20020aa78893000000b006eac4f413ccmr4333915pfe.26.1711646527638;
        Thu, 28 Mar 2024 10:22:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4d4e])
        by smtp.gmail.com with ESMTPSA id gu5-20020a056a004e4500b006ead4eb1b09sm1619509pfb.124.2024.03.28.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:22:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 07:22:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Message-ID: <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327225334.58474-1-tixxdz@gmail.com>

Hello, Djalal.

On Wed, Mar 27, 2024 at 11:53:22PM +0100, Djalal Harouni wrote:
> This patch series adds support to freeze the task cgroup hierarchy
> that is on a default cgroup v2 without going through kernfs interface.
> 
> For some cases we want to freeze the cgroup of a task based on some
> signals, doing so from bpf is better than user space which could be
> too late.
> 
> Planned users of this feature are: tetragon and systemd when freezing
> a cgroup hierarchy that could be a K8s pod, container, system service
> or a user session.
> 
> Patch 1: cgroup: add cgroup_freeze_no_kn() to freeze a cgroup from bpf
> Patch 2: bpf: add bpf_task_freeze_cgroup() to freeze the cgroup of a task
> Patch 3: selftests/bpf: add selftest for bpf_task_freeze_cgroup

It bothers me a bit that it's adding a dedicated interface for something
which already has a defined userspace interface. Would it be better to have
kfunc wrappers for kernel_read() and kernel_write()?

Thanks.

-- 
tejun

