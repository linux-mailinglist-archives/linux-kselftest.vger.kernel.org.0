Return-Path: <linux-kselftest+bounces-7322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD04D89A77F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 01:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B0C281F60
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9972E84E;
	Fri,  5 Apr 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMoJt3Np"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7A19BA3
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358077; cv=none; b=nld7WfEk+rvuOYb0NCjA222nuqW9Mt9PdwKkhAUhd81ucALBjXApBa8QP8oLEpMkcP2DK07Mb+Zq5tx37VgKefFXfnIJWxASotrh7BYOBl0zxVi0gRLt0OLcyT0BtAywek3zGEBuHVrdlR2GP5MiIQgSTrVPEhkWogTw4ljKsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358077; c=relaxed/simple;
	bh=vpyLulb0cbEWPZIm2RbGs/BJ85Xm3dVsvtdL4Qm45tA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RZixpPXXPYJLoJEOkuKgbn88DnSRE6KNlvoqRkqrk+NCOnZcBVWKW459eozGZriNQ2GKEq/4pzsv8isUzRt67N4pQH3RZs3qwzpaBq92zN1icbIIpCjHBZPGyT9XH3nzSW4/WRSr3m5/eHC2bT95Pw6LZ1WcpHR7CtuZsJ326ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMoJt3Np; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so4560999276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712358075; x=1712962875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zfG9IfZBbUxYxhjFKINYSmP1ysXJ3ABcVl7iYfbfY2A=;
        b=fMoJt3NptUL12YWDlIbhLyGLpQ6aZPdD5YIaHlldjzaZQKd7aOxUPaz8/VAPsQ3TW0
         dBcKDeIiFOHYumvDrwRe2FptvImEqO1dUqEBHgyOnyGAfg/eskJXbrrQQHNwf4IoRfYl
         Bkma8cb3euD3GduEEw5X8KnkPOOstbmRFyOlgpIIrdtnIu3IC3mHbVemdh5na+uiAdrb
         uBhkV2NX7LBIjR7Oundl/stNP2B26iTCtlRIHAYnBPvBNAO5HTC37NpadkvmeD1WK/wh
         9duagW6Zuv2EPRNv/6WMOwFwz03ibj8wF+EtxZd2977TYd8do4g3S2rBDvp6X0c8UquD
         QfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712358075; x=1712962875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfG9IfZBbUxYxhjFKINYSmP1ysXJ3ABcVl7iYfbfY2A=;
        b=QPBhdg09VTrEZFekPn9sPn/rMhkva0q//Vgqzh4vA3SHsI7NBw+/e2tH2gcVxUz1gO
         GI3AylWCBkmlF8SG5lxByyCzMMUozAas73PVbB+ruY+wiwul/Il9YT4FIA58dt5EYhVo
         dqA2dQKhy+5htkfwo1S6AQvqOl/mQxFFImIdAilC1ooZvnQMnlFmUqa5daeBew7zloOd
         0ezYmJXKO39ap5f84PG8fe6s7GbCscTK7py/cK8dzdHj49LnyljG4fHwmxlg2w51LJeA
         r5JYVUCYEzthy9JMDidAaVVGtjhmu30yGKvcjPHIhuRFtdIubK+Wa/JxT8kJOcNfhf0F
         sKhw==
X-Gm-Message-State: AOJu0YyBbSs7L4USZeLf1ZEy9suad488QT/4u9ne+fxinKwWqpBRI/ZR
	EqGqz9+d7Nf/+hLchF7m/OS0LypABZ5Y9fEDWoXOW0pyXsKqBZUjjGzJ1/I73QztyhI+NaFVdbz
	GAg==
X-Google-Smtp-Source: AGHT+IHQONwOAXZUuQpKEzHzWJjAcRoq3GLnMYLuEfuPWU/vYM/gSAw8M9A6w+X4FnHoW3md4eNi3rzAK50=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:20c9:b0:dd9:312c:83c8 with SMTP id
 dj9-20020a05690220c900b00dd9312c83c8mr167750ybb.10.1712358075290; Fri, 05 Apr
 2024 16:01:15 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:01:13 -0700
In-Reply-To: <20240322163351.150673-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322163351.150673-1-zide.chen@intel.com>
Message-ID: <ZhCCub4ajIvpvrBk@google.com>
Subject: Re: [PATCH] selftests/rseq: take large C-state exit latency into consideration
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 22, 2024, Zide Chen wrote:
> Currently, the migration worker delays 1-10 us, assuming that one
> KVM_RUN iteration only takes a few microseconds.  But if C-state exit
> latencies are large enough, for example, hundreds or even thousands
> of microseconds on server CPUs, it may happen that it's not able to
> bring the target CPU out of C-state before the migration worker starts
> to migrate it to the next CPU.
> 
> If the system workload is light, most CPUs could be at a certain level
> of C-state, and the vCPU thread may waste milliseconds before it can
> actually migrate to a new CPU.

Well fudge.  That's definitely not on my bingo sheet.

> Thus, the tests may be inefficient in such systems, and in some cases
> it may fail the migration/KVM_RUN ratio sanity check.
> 
> Since we are not able to turn off the cpuidle sub-system in run time,
> this patch creates an idle thread on every CPU to prevent them from
> entering C-states.

First off, huge thanks for debugging this!  That must have been quite the task
(no pun intended).

While spinning up threads on every CPU is a clever way to ensure they don't go
into a deep sleep state, I'm not exactly excited about the idea of putting every
reachable CPU into a busy loop.  And while this doesn't add _that_ much complexity,
I'm not sure the benefit (preserving the assert for all systems) is worth it.  I
also don't want to arbitrarily prevent idle task (as in, the kernel's idle task)
interactions.  E.g. it's highly (highly) unlikely, but not impossible for there
to be a bug that's unique to idle tasks, or C-states, or other edge case.

Are there any metrics/stats that can be (easily) checked to grant an exception
to the sanity check?  That's a very hand-wavy question, as I'm not even sure what
type of stat we'd want to look at.  Actual runtime of a task, maybe?

If that's not easy, what if we add an off-by-default command line option to skip
the sanity check?  I was resistant to simply deleting the assert in the past, but
that was mainly because I didn't want to delete it without understanding what was
causing problems.  That would allow CI environments to opt-out as needed, while
still keeping the sanity check alive for enough systems to make it useful.

