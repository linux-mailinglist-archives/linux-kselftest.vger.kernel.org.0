Return-Path: <linux-kselftest+bounces-43401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F3ABEB2CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D6E1AE2BB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038E32F759;
	Fri, 17 Oct 2025 18:17:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D132C955
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725024; cv=none; b=ZYwczzLt/ck8TYVw04BXtD/1w+DFrBMk6z8+LghHAgQGHnA3IuSc/BvPMCl+OUZRAr1xXXszUtGC3k0Bk+hLRg24UTQIVyocr0fKRfFbl9rYgklYDspmOURIj1jszyIJWtSjpbN9Y7aNOrlBaDJn1uaBhCGBeX6OvgJXa6I20mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725024; c=relaxed/simple;
	bh=rJvNrY02s+ZucFNBz2Jl9T4sf21+yp9XMDRTutLQMTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8Hu5CsQ/zdzLJfNeAjyxcGpMSVZrHzOjev9jUFO0qGC7DQdK8cE1KLSsULphSaPnqOc1I3Y3vrZ8nPTsg626yQMZ6ur4rpnx8eGJPdjS11L8nIMl/fx9lWSSRqE0Sjbm/nlJEIC9/Lk4K+CsU05kw2nbMz0rou1a8B+U6t5Mik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-651ccdf5d0eso328460eaf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 11:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725022; x=1761329822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cINqQqiT3g7xyevR8+vmcEschd9JtkqaiiAdm399BSs=;
        b=bboeyCghrkyGMYSqUOpNsOHFtj8m22HC+Dc1KBWTg298ncKHUBkLLbseMwgn2JgkCy
         /VY9pzoKUNF4zejb8jNqbj18UNMUN+SFKrqeiXWf3tBj7VRYIi17w6ELjufgnYT+51FD
         fu+5t+Im1GmblpaWqTYIO+yB6W8Od6DSgwE0X/luBFS3FIwExEX1REY5iPkzEciMnvaO
         QseqHFWKsn2r9geH9ydUPH7VO9jVYYgEdaozY18QW8AQX3RAn80CVjAPmVI+V0juIxsC
         0VIq0ngZYklOIRsGIUSbLhRZHmLa7+DU7SsdAveXbzm2RSRwNTwNP8fEPiZ4tt3rQgYs
         6BUw==
X-Forwarded-Encrypted: i=1; AJvYcCXBqJ0shC8Ig5TXGwJfP0WXLE3zrX/WHGWDaM/eZ5Ih1vvUVySlCBG2QlRWMFfI0IaJoCRAXkiP36Ww6JHL9zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16WYIdhwEyOhefdplZK7YzjvjDvnGhJ3k5RWEzbKmIccxr51a
	69R3BoC30JMUfxNeLY9pKxh0OBprjr97B+rR4Hf9SKK6PanJoz3qCjMD
X-Gm-Gg: ASbGncuxwji3CB4W5IzderI6+A7sgGh9qNEYjlS+K3amw6JrTZW5sxBBfqQ9xcxiX+a
	UOv08HGMYWQYMChdvluqohCdbdUi02BAZkHLpq1aZb+4SmgckcJYL4k0/dJeiR1QSklZZh7TOQN
	VbYlb0lLGwKI7rK2ptf5Gzs5v3rW2XKrwYKAP8IE+KfVC6RMCYqm8iJ9NUga0zDGZYTa1+9z3j4
	mWORXi56EmdgV4rm41TjbIp+Xf9pPsPxtipQOwthNdebyJVZ2r4iDy7okf/R/1C2K/YsllmA717
	rM7tOvs5pnjCijoTAeCe1lZ1gk7hZ56aeDnSYISysIFhLWDFso1bMC0NOnxt67hJ95sCR2up4Vt
	c+5uVZZRgnMS05ZbKycxAmHxBC07gig3OGcvC2J3GyfYpjU8OgTc6KLJDlUFARRiDFln1q4ch2o
	VB6Ja0m8VRvIC6BUa1DMxgqdqfp3WNMhvXTrwI9BaB8Bx5dELEpphQQ5NbfKxV15AOL9c=
X-Google-Smtp-Source: AGHT+IEkYynijOfioNXgVBL/J+ORYFf4SqheuHgsScwjHWbPv0aCz+9813qwbla3Zfgt+qTr9snjaA==
X-Received: by 2002:a05:6870:71ce:b0:332:3a47:9a05 with SMTP id 586e51a60fabf-3c98d0ac503mr2005539fac.26.1760725021852;
        Fri, 17 Oct 2025 11:17:01 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c9aefc4f9esm75178fac.7.2025.10.17.11.17.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Oct 2025 11:17:01 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: tony.luck@intel.com
Cc: yonch@yonch.com,
	corbet@lwn.net,
	james.morse@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	reinette.chatre@intel.com,
	romeusmeister@gmail.com
Subject: RE: [PATCH 0/8] resctrl: Add perf PMU for resctrl monitoring
Date: Fri, 17 Oct 2025 13:17:00 -0500
Message-ID: <20251017181700.62980-1-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <SJ1PR11MB60837F4BB475207D990C8293FCE9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB60837F4BB475207D990C8293FCE9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > Motivation: perf support enables measuring cache occupancy and memory
> > > bandwidth metrics on hrtimer (high resolution timer) interrupts via eBPF.
> > > Compared with polling from userspace, hrtimer-based reads remove
> > > scheduling jitter and context switch overhead. Further, PMU reads can be
> > > parallel, since the PMU read path need not lock resctrl's rdtgroup_mutex.
> > > Parallelization and reduced jitter enable more accurate snapshots of
> > > cache occupancy and memory bandwidth. [1] has more details on the
> > > motivation and design.
> >
> > This parallel read without rdtgroup_mutex looks worrying.
> >
> > The h/w counters have limited width (24-bits on older Intel CPUs,
> > 32-bits on AMD and Intel >= Icelake). So resctrl takes the raw
> > value and in get_corrected_val() figures the increment since the
> > previous read of the MSR to figure out how much to add to the
> > running per-RMID count of "chunks".
> >
> > That's all inherently full of races. If perf does this at the
> > same time that resctrl does, then things will be corrupted
> > sooner or later.
> >
> > You might fix it with a per-RMID spinlock in "struct arch_mbm_state"?
> 
> That might be too fine a locking granularity. You'd probably be fine
> with little contention with a lock in "struct rdt_mon_domain".

Good catch. Thank you Tony!

We might be able to solve the issue similarly to what adding a per-RMID 
spinlock in "struct arch_mbm_state" would do, but with only a memory 
barrier (no spinlock). I'll look further into it.

-Jonathan

