Return-Path: <linux-kselftest+bounces-44803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF280C36064
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCA91A21A70
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679D32548F;
	Wed,  5 Nov 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NU7mxiqQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPgO2B92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2A313E2F
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352461; cv=none; b=VH+xssiYm1S5yM5vVXmqmN6ssK5bg9Y+iWtFMS4X0Hwpw9ey5ciUNFPMx0Nwuyl4dXiKYiEOcmBLdCBk/wUsKauogJfSymypjhrmSO93CGyASqsPVS1W9UDnhnaUJuXX4vgMLjRsUK/WVfE5IBTk+U5At+5l0TYold1LlAaKk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352461; c=relaxed/simple;
	bh=nu4doHrXZq6HHEdqAu78Ax8NqoZY5xgxh+gqivufsTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7feWI0kbR2jfZlHcNkdLMup3Yq3pLzKEvllZT/e3G2z8fW7MDd7yV87pj2ImdKIc3fqC8z0BW3cOsdJgxDxjcvtUj9CgDW0gRXR0OYEB4jukBsF1hnnv+QZD+bnF9ohfUc2e6XYqrdizxbpJeCoIB4edtuw8S+UixaGD2bvPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NU7mxiqQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPgO2B92; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762352458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2VtDGz1DOqvvFYKW79um0LglA9g/B0whzTAe9JWcYQ=;
	b=NU7mxiqQcXyBnGoaX5WCABybY6WqOeolDkcRxgTH8zdNb7VpNlLF7awrzy9hn1FgMUM8q5
	IZQPD5R6H28PsP4OI6nFPDI+I6ZQCHJHX51sCjN+DuSdIhjOAtygVA53muTQTRGhWSFSWp
	yy3HxMIvrK/VEm3H2XNhNZBDQpFpuJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-SkMASTnWM9SpQVAYrC0Slw-1; Wed, 05 Nov 2025 09:20:55 -0500
X-MC-Unique: SkMASTnWM9SpQVAYrC0Slw-1
X-Mimecast-MFC-AGG-ID: SkMASTnWM9SpQVAYrC0Slw_1762352454
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775f888bedso6464155e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 06:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762352454; x=1762957254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2VtDGz1DOqvvFYKW79um0LglA9g/B0whzTAe9JWcYQ=;
        b=mPgO2B92PDF3lGPa8LyEyyaVsD+fIfj/ambGFrS5+OiomVH0r6DnpLautu/XMNsS6P
         NamliZgSdh/2iNrBtpHuFxKhvXF/tK4+vhP3WaPReCOLZ2etDYJTg8fNhykWWSZyvuLG
         j0TkCcLAYvQyhUSS5/Pqa2qeOe01ObSLwhOrmXXDtDtBpvZSFB0ifF2LX0QANiL6WpwM
         O+3gkmZafh+uWAsIwl5BwkYvuZs1HSmvtq4MU3tE7lrRsruQ3bytxSP7npPB2JBWWS+8
         28eic8gYh1NWOLkfErKUL2QI1AzYr3/cT9mVXecmZpxEJCVfc55rZh96+Zwajq0CuILv
         yIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352454; x=1762957254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2VtDGz1DOqvvFYKW79um0LglA9g/B0whzTAe9JWcYQ=;
        b=pfTH+YlyaY84Mr1C5S8X3D5mtoGP3eHEaE0jwKGPzevyBJUKKyAKDYOx6wW/T88dJP
         dfuwnadYRCFTXGWF3tZUemT9w+GxoRJM4dyOwIe8qHYzGSnlkKQEbuOGlwiGNnACYTQu
         GrKM82hnFYe/rawwFCfQjrGJnt4WXxbs7BU3/JeUiZdTkopexBkFW9H2RqWQSmCJmkMK
         oUiRNYjycx4m+rY0x28X9/HSY8AicQ5loPbHngU9Z0CAvpM0vk5lF0HLc7+sXeM+hKha
         NXhtlbwG3w0r0U4MyR0JVTf1P2BvdCMNdFiJqyzrNOu5wwk4B03cu6RIkrCX+V/J6Uab
         Ug3A==
X-Forwarded-Encrypted: i=1; AJvYcCW6p4GqwUOrLI1TPV1dChY+L5GZYQ0s0Cd8t6ceB7bE2/MwbOHl6v/OU3jgkOdnJe9ZeNQhiIcVZPf+B7BHyvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoleMzL/t7q8o0ddncsc+e/GDiOO/cM09lo5jjomNLaIHsy2VK
	CZQhlDLVvHHpZ1HbJh8UzuoC1bv84mfxJ5RJ3QrzPuanW663RHF/aaTqgeNQm288A1e6vcYnwHS
	83qZ6fgSJ2ovsp/yOLeaEFMce0x3CLpF2punjo5MC3p9bXrqo8OKUHExbNlC2IdMxDg8Ohw==
X-Gm-Gg: ASbGncv5EPqwGfmudAcUnS6CseTBAxU5YpZj3ND9fOiCL9C1iFMihQ07ZTsMDmvoJQw
	7MLmBkFc8m8VRtrQ2vFL2tls+GMybv2Bu6Bj7y8Gc1f4hfpXcGXHKzLQ6AicCcF4H+mKWjNxywL
	0pr/b60WrKmwgsczxp/yWBCnDnb0zkkkvYEo/VZ/uBNb6AuiUc1LYhC19+/OBeMaH386P4Gj/Lb
	9RpJKOQkQCWsKlLusdaBLxj+zYAct1cRZ+rccfJWNV2SXMzNcv7xd+Sm4TWJHiqFYVGF9+T9xZ2
	41z3L/mFgkEUoBTNbxvuTUPlpJJ24+A6wDsZRNHNbMWzcGq+e6iV679qa5H5SWdoOtQwNCOQvQQ
	aKeh7bwBbI6vlKQnYuFOWPEHNfQvqhg==
X-Received: by 2002:a05:600d:8312:b0:475:de55:9304 with SMTP id 5b1f17b1804b1-4775ce9bc9amr22409095e9.19.1762352454079;
        Wed, 05 Nov 2025 06:20:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD225S8D0eAzSRqCZNY8jiiXPUZkIB3X3AaRb7e9hIqiHytYJtBJefyIehRQDx2ycUxkcH5w==
X-Received: by 2002:a05:600d:8312:b0:475:de55:9304 with SMTP id 5b1f17b1804b1-4775ce9bc9amr22408905e9.19.1762352453617;
        Wed, 05 Nov 2025 06:20:53 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc192a96sm11270694f8f.13.2025.11.05.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:20:53 -0800 (PST)
Date: Wed, 5 Nov 2025 15:20:50 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v10 sched_ext/for-6.19] Add a deadline server for
 sched_ext tasks
Message-ID: <aQtdQnLxnh7z7a0w@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <aQtVe9LKuQ_W3qwY@gpd4>
 <20251105135911.GQ4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105135911.GQ4067720@noisy.programming.kicks-ass.net>

On 05/11/25 14:59, Peter Zijlstra wrote:
> On Wed, Nov 05, 2025 at 02:47:39PM +0100, Andrea Righi wrote:
> > On Wed, Oct 29, 2025 at 08:08:37PM +0100, Andrea Righi wrote:
> > > sched_ext tasks can be starved by long-running RT tasks, especially since
> > > RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
> > > tasks.
> > > 
> > > Several users in the community have reported issues with RT stalling
> > > sched_ext tasks. This is fairly common on distributions or environments
> > > where applications like video compositors, audio services, etc. run as RT
> > > tasks by default.
> > > 
> > > Example trace (showing a per-CPU kthread stalled due to the sway Wayland
> > > compositor running as an RT task):
> > > 
> > >  runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
> > >  ...
> > >  CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
> > >            curr=sway[994] class=rt_sched_class
> > >    R kworker/0:0[106377] -5043ms
> > >        scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
> > >        sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
> > >        cpus=01
> > > 
> > > This is often perceived as a bug in the BPF schedulers, but in reality
> > > schedulers can't do much: RT tasks run outside their control and can
> > > potentially consume 100% of the CPU bandwidth.
> > > 
> > > Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
> > > also boosted and do not suffer starvation.
> > > 
> > > Two kselftests are also provided to verify the starvation fixes and
> > > bandwidth allocation is correct.
> > 
> > Peter, Juri, this has now been tested quite extensively on our side and
> > we're considering applying these patches to Tejun's sched_ext branch.
> > 
> > Do you have any objections or concerns?
> 
> Yeah, I want to finish this first:
> 
>   https://lkml.kernel.org/r/20251101000057.GA2184199@noisy.programming.kicks-ass.net
> 
> Because as is, the whole dl_server stuff isn't quite right.
> 

And I'm spending time on "[PATCH 04/11] sched/deadline: Add support to
initialize and remove dl_server bandwidth" which I am still not 100%
sure is correct (or that is correct how we handle setting runtime to 0
for fair_server today). Apologies, had some travelling and pto, but
should be able to write something more about it in the next few days.

Thanks,
Juri


