Return-Path: <linux-kselftest+bounces-45091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED9C40331
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B55C188DFF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D831B118;
	Fri,  7 Nov 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFms1geu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJEWhZf1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713022423A
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523590; cv=none; b=rYtAtXhKBGLsSVxMsk4HYueeAeEzhu9xwSbMSmLj4XvKbw4EYvx3ztNIQH0r5PGgYiIYsgxyCuexmqu+zvGdazCKuqNJltijT2LQhaalaSj4CTlUU6s6aQEiRI9z44LGX7WC5MOtA8v0OwcIbkXT9FiU5/gEW/4/TSqXUOKq8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523590; c=relaxed/simple;
	bh=kxMIDSfnPpf8djuYkxMRQ5vJUJ7jfPruX9KKD/WvQKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvcWuuaPba45CBVqobv2sR4dieWfWoBSpwS1KNRhgnknaJysKmGAZJTURpZb5wUBaxVWjKvSill+6S6A0Jy/8PXpnnAgcJTMzZtk+TF1Ptc9JxjqXyysduKws9DfG8SeH4GyGA5EbCQ+JzuJur65WyiTbT8qkeHxbA5HGNZhfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFms1geu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJEWhZf1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762523587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9/c4QtcuY4C0Ku7AdMAA0akvvVLyJC2D5AYMWNX6jI=;
	b=RFms1geuhihosBv/1rmmXnIZfDKYWEtnOXw/m+AdF5EC9xAiUm6sTgOAQU/H8Do7uxJh//
	mLmmk0kwSXmgpNnSREdyxIyd9qfZVI7xmNA5kR2xAA8VZfPbrv9kIRXTjhZyxqb4hS7KxQ
	jUgIKMTFoWWR3n54920bZNCCZVslUCQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-9dOKCpfVN0S7HQVIgt26OA-1; Fri, 07 Nov 2025 08:53:06 -0500
X-MC-Unique: 9dOKCpfVN0S7HQVIgt26OA-1
X-Mimecast-MFC-AGG-ID: 9dOKCpfVN0S7HQVIgt26OA_1762523585
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477632ef599so3867595e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 05:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762523585; x=1763128385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9/c4QtcuY4C0Ku7AdMAA0akvvVLyJC2D5AYMWNX6jI=;
        b=HJEWhZf1mrcBFmIn/IGmw/7+PGd9SJPHatOOh8iTLUNs42StTD3mOnU1mDa8hObqso
         pigOhfyUjkJtSmemaBuouxGNUohWpb/iw0L5ENjM6mIcsRLjfC3sHCM5XchLSSfED/Bi
         7V00aCz4vIp0GAcyCI5s5LPWHnKrt9gkBBE6ejtLyvOrwq8qUwPMf9fvsg6g+Ci7IZTQ
         KdnIjbMx9zcDI8k0zOd86q/vHD/COhEhxW/NUsjoTRcv77MAx3bfXR066F24aHyKmgqD
         2TJyUR5hx6FTiKvhneHtcpbn2on9tb5XmWDo4SGBjiauz70qtGje5FtSRhvfIaFm0DHl
         vkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523585; x=1763128385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9/c4QtcuY4C0Ku7AdMAA0akvvVLyJC2D5AYMWNX6jI=;
        b=OgranSJzTLT6Z+uW8VQRZuH7do6I6XoDWvaBq55ynjDVO+sFEaH+zr2yqS+9TQuI8M
         oRuSTbnMwnyAQAUELaUWChB4Zxx6u32ss+XmApwxkkr0Gvm8EwQFv9dCSlpsnH+9QEXA
         exp4Ip8hXmgLMhiB39PF81n1cMbPkJ8+/gSMoIV8+S7Agxj+++uweaz7ADgiNU/olb9X
         DM4LecAhYxRYJY5pYcrmmACN0/cnL24IjWpB/Go/eI/6HnaKp6Z8EFPWCsPSN7lGQMOG
         rJ+aE/uwziD+ulcN+6JimQsHOfTDRSEEeStR7bFlABoWY/5hRqUHdh57I/zhMn3Gx2br
         qKCg==
X-Forwarded-Encrypted: i=1; AJvYcCV0lXfw9z6Broq4/SIMlPTLL2Woezuy2BG341s5Smk01rF2Urpu0vbvS3aL481GI96umwV+7YoqV6kE6GJkrzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbwaCgWO2YOSEmcTe8DB2GG85+dn962LSnn+MlAxPtr8ehV2+
	mX1CZsQ2Vp0VajinU/FGiyFNSzQfn3cBpHTkcse195W7f9oo9jbKYHKLBR/Dr9HS+g6vNiiRHQs
	bc6Wf83/xYSqHcY2Mb0v0zVg657HyI+DOxt6BB7tVW6sTSgeBozfMHjElG9SlDc6HbzTZyw==
X-Gm-Gg: ASbGncvNHwV1xfZGgcs3M0KmqohG9NNtXMT+9rXwnw9/jRezWroMzekYU4WynRaWhrt
	HtLQjFhL/zjsrvwoRE/mhCyCVhX0yklHejQL2Z1jc3r6rrCEsoH1zKarDbYGwwTgkQtBOn3mNME
	nh1FfCz4K00J6D2MYPzGSNsZFcVtPRgobPW7Fbs2t7GqINqamUyOzs/7PFfEPDxzjqaiXwJABcW
	O2xUyGOhBboiLEsk5oCbKRJzlVVM2f27lTQjgA4jVktgDejoDfug135vmxw/NvsnZ33qWsGpTJO
	K9pl9/51C8edU6FQTCKeCdGAnVsDifggdCmPtRxJzU4ZfIcyAtKqyHFCb1S19/5qqVWdR+TZ0M9
	PBowAVz5xm5fmj5y6EEyM9ZiUZu9uQg==
X-Received: by 2002:a05:600c:4251:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-4776dcd61dfmr10468955e9.17.1762523585202;
        Fri, 07 Nov 2025 05:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENPFcHgZiedoxSNj/gTHG7HP1mQbGAIXAVzUnhmQo6HdEVRWpGRzBdctMGVXrL+4rI+OT13Q==
X-Received: by 2002:a05:600c:4251:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-4776dcd61dfmr10468765e9.17.1762523584724;
        Fri, 07 Nov 2025 05:53:04 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd51dfsm49260135e9.5.2025.11.07.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:53:03 -0800 (PST)
Date: Fri, 7 Nov 2025 14:53:01 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH 04/11] sched/deadline: Add support to initialize and
 remove dl_server bandwidth
Message-ID: <aQ35vUAOD6CflvCA@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-5-arighi@nvidia.com>
 <aQxvIBIwOCDDu60b@jlelli-thinkpadt14gen4.remote.csb>
 <aQzWM4vv30etfhok@gpd4>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzWM4vv30etfhok@gpd4>

On 06/11/25 18:09, Andrea Righi wrote:
> On Thu, Nov 06, 2025 at 10:49:20AM +0100, Juri Lelli wrote:
> > Hi,
> > 
> > On 29/10/25 20:08, Andrea Righi wrote:
> > > During switching from sched_ext to fair tasks and vice-versa, we need
> > > support for intializing and removing the bandwidth contribution of
> > > either DL server.
> > 
> > My first and more general/design question is do we strictly need this
> > automagic bandwidth management. We seem to agree [1] that we want to
> > move towards explicit dl-server(s) and tasks bandwidth handling, so we
> > might want to consider leaving the burden completely to whomever might
> > be configuring the system.
> 
> I think we decided to take this approach because, once a sched_ext
> scheduler is loaded and all tasks are moved to the ext class, the fair
> class becomes "empty", but the fair dl-server would still keep its
> bandwidth reserved, so somehow we need to release that reservation,
> right?

Right. I was just alluding to the fact that keeping the "empty"
fair_server reservations is not wrong, but indeed sub-optimal. I didn't
want to block this series if we don't get the automagical removal right,
so wondered if it could be left for later (as we will still have a
manual way to remove the empty reservations anyway :).

...

> > > +
> > > +		hrtimer_cancel(&dl_se->inactive_timer);
> > 
> > I am not sure we actually need to force cancel the timer (but still
> > contradicting myself every time I go back at staring at code :). The way
> > I believe this should work 'in theory' is
> > 
> >  - we remove a server (either automagic or user sets runtime to 0 -
> >    which is probably to fix/look at in current implementation as well
> >    btw)
> >  - current bandwidth is retained and only freed (and server reset) at
> >    0-lag (when inactive_timer fires)
> >  - if server is activated back before 0-lag it will use it's current
> >    parameters
> >  - after 0-lag it's a new instance with new parameters
> 
> Hm... that means just setting the runtime to 0 IIUC. I think I tried that
> approach in the past, but I was seeing some inconsistencies with the
> total_bw kselftest, starting/stopping an scx scheduler multiple times
> seemed to gradually consume all the available bandwidth.
> 
> But I can give it another try, maybe that behavior was caused by other
> issues, since we've fixed quite a few things since then.

Or maybe it could be inactive_timer/dl_non_contending handling that
still has some problems.

Anyway, I noticed that it is still possible to write runtime values of
fair_server while/after scx_server took over. Those values get
overridden when scx_server switches off. Guess we want to prevent writes
while scx_server has full control?


