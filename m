Return-Path: <linux-kselftest+bounces-48442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF957D00611
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 00:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594EA302F816
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3387D2EA473;
	Wed,  7 Jan 2026 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qP9qwocK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44492609E3
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767827993; cv=none; b=fqWT638uL0fSI+EQFvAJ6sA7V9am9YbbRFMuAnLTvjW1sR5PFvhFshOPst9xz5yymQwQSSNr4IQy4BasjyQd/TAHrAxu8QePJfdNR67Q4w5WNv9vjkLd0JBH+T/Swky2mRSN43F5Fkq7UZ6cZ8+hw9wwze1hm+FOCOFGdQ0GYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767827993; c=relaxed/simple;
	bh=VBVlmTyDsmFzPanb+UWhVbw316hjKaMVO3k3rPdnwsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAHjXsaBB+VY4KSBCzGu2qUehKNaBGkhgKDw7rdk8B4MakMM1Eyk9yZ8C3TSXwBjrLMJIqiEn4GdUW+uyZhgliJBpXdomlrqy9e9TbQ7ux8RLGXRAVFKoGzxGVPosc2YGIuqduAAB0g22QW9ND5dgE3SpqZVdyQY0LcqrRKXtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qP9qwocK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29f02651fccso130675ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 15:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767827990; x=1768432790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrTegim1IGH1EM+qnfVQluY5KhY2cqE1cUaOvjCI5uc=;
        b=qP9qwocKAK4V2EVXeoEr+Oc0dN8UYLKTSoDrnT9rke/iv669fzeObH5EB7bKDdsEP2
         4HTpJCP+4HF0fXhWLLM3jUNVpr9RJFN2bO8LEDKjZ6/XXJzOfaJEDrgvggkztGjFhcZR
         6eHhk6BCF6B7rj6Sl88YF4ffjAmBm2Xt00ya4JKA095+VL0RkObThgspUQVC7Q9sS7Uv
         8BypPv45wjYedirNqZKfk8AuLnsyHvs0pwBsQ6Cs8WQli/kmecJ+JcIx55tCPEdGh0om
         KqEELbRLoz7q3B4Wf3xeNBqeS20Vho6DudTBUxHGjL/mCC5vm9KfJXcI/APIMIfYKVaO
         oaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767827990; x=1768432790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrTegim1IGH1EM+qnfVQluY5KhY2cqE1cUaOvjCI5uc=;
        b=KwTQHTTiCdqIN7gug2D4kuhcjDvVxFMJ6xlzfpnzMObB47iQTXlBDL4w5kIiQCQHpN
         GizvMD0R2i1aJaCiK5RGClQXIWEtbp24BhZEDd5IcOkCyhLMruBXmpoij0S9IMPG1ttp
         6J/jrhMradf1gR3OcWubIHwJh9Rn2fGcQewUtNK/y/l268c8mRwUY+xpuGmmDFTcsbqX
         2w1rlfc7zpLZTEuubWdvApmOzGNMBaOCZ4vAi00RRgKLX4wwfBp3CMrjubn6lDlNEX1V
         f6dA2I+O2UyzH2ILhf/t82uRiX2oBXtnrMXRE12vCUz+vm/nbwAXOBtPpI752dspnxKH
         cBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6MR3PvOJJCwqlOu0bPMZ3ZDEZDsU5R+SyFvVouBEuI8Xj/7SLmteKXL864mUvCfk0+lhKXu/mO7vfbBbU/js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSBEVk8gX1h1oNtD3AqeU3LWczSQocItz8Tk5FSE3dTT4o514
	4bVRVMvh1Ioh9Xg0/ri/PSOKgvG6+oe2fLHXpQTED0IH0W0/PUDo8cBYcEpiIX8rHA==
X-Gm-Gg: AY/fxX7SOVDWP1BhIT+3FmWMd6TkzwdaOq10xRDq3HR5te7Lc5KrmyWnl+Ut/fTgUQW
	YoYESM5n/vOhevR0u/8vKBb107SxKTAbif2Ob+TGoshDlzzNzFMq3tQdmyhd2l2C8eab0bIXI6h
	VJST+JXK1vQZth72NwsJTfjgqpCIlyAOJDi+ORmBfiikfXjIbpU0pX0nrNpgf3XZSak4kilSy5n
	z0D+flM9mtwMi9ao/EMHi4kX/CL9AuebTTjQpwvr4q8zLO54dVblR3zTddzzdQZeSipRhDz862w
	4QWRLwmZ7O9SyWbSS16Y+sHJWXx9y8CquLTB2tzG6W2djGEDW8XeQ9Sms0N/Wf3MocBM6/sIuaL
	1/FvOzT815Or0vlkUwWb2qEb64lkiC3mAE7h/cmXpMYehkYdanA4GB1OzLl4cXBWyw0kkMyD/8u
	YD/nawqEra9pPbeFoWqxqVng0t3q6LSv+NuXhM6mC0sPN9P8piNA==
X-Received: by 2002:a17:902:e786:b0:2a0:89b0:71d7 with SMTP id d9443c01a7336-2a3ff095070mr392195ad.13.1767827989556;
        Wed, 07 Jan 2026 15:19:49 -0800 (PST)
Received: from google.com (210.53.125.34.bc.googleusercontent.com. [34.125.53.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc05cd9d9sm6402603a12.16.2026.01.07.15.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:19:48 -0800 (PST)
Date: Wed, 7 Jan 2026 23:19:44 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wake Liu <wakel@google.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] selftests/timers: Consolidate and fix 32-bit overflow
 in timespec_sub
Message-ID: <aV7qEM3nkcupAC2N@google.com>
References: <fbb55063-ab03-40a9-80f4-4315d12239ba@t-8ch.de>
 <20250915191944.9779-1-wakel@google.com>
 <87qzw06y8t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzw06y8t.ffs@tglx>

On Sun, Sep 21, 2025 at 09:49:54AM +0200, Thomas Gleixner wrote:
> On Tue, Sep 16 2025 at 03:19, Wake Liu wrote:
> > The timespec_sub function, as implemented in several timer
> 
> timespec_sub()
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs
> 
> > selftests, is prone to integer overflow on 32-bit systems.
> >
> > The calculation `NSEC_PER_SEC * b.tv_sec` is performed using
> > 32-bit arithmetic, and the result overflows before being
> > stored in the 64-bit `ret` variable. This leads to incorrect
> > time delta calculations and test failures.
> >
> > As suggested by tglx, this patch fixes the issue by:
> 
> s/this patch fixes/fix/
> 
> 
> 
> > 1. Creating a new `static inline` helper function,
> >    `timespec_to_ns`, which safely converts a `timespec` to
> >    nanoseconds by casting `tv_sec` to `long long` before
> >    multiplying with `NSEC_PER_SEC`.
> >
> > 2. Placing the new helper and a rewritten `timespec_sub` into
> >    a common header: tools/testing/selftests/timers/helpers.h.
> >
> > 3. Removing the duplicated, buggy implementations from all
> >    timer selftests and replacing them with an #include of the
> >    new header.
> >
> > This consolidates the code and ensures the calculation is
> > correctly performed using 64-bit arithmetic across all tests.
> 
> This lacks a Signed-off-by.
> 
> > Changes in v2:
> >   - Per tglx's feedback, instead of changing NSEC_PER_SEC globally,
> >     this version consolidates the buggy timespec_sub() implementations
> >     into a new 32-bit safe inline function in a shared header.
> >   - Amended the commit message to be more descriptive.
> 
> change logs go behind the '---' separator as they are not part of the
> commit message. It's documented how to format a change log properly.
> 
> > -#define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 secs */
> > +#define UNREASONABLE_LAT (NSEC_PER_SEC * 5LL) /* hopefully we resume in 5 secs */
> 
> How is this change and the pile of similar ones related to $subject and
> why are they required in the first place?
>   
> > index 000000000000..652f20247091
> > --- /dev/null
> > +++ b/tools/testing/selftests/timers/helpers.h
> > @@ -0,0 +1,31 @@
> 
> Lacks a SPDX identifier.
> 
> scripts/checkpatch.pl exists for a reason.
> 
> Thanks,
> 
>         tglx

I also just stumbled into this. However, doing a little bit of research
it seems this was introduced by commit 80fa614e2fbc ("selftests: timers:
Remove local NSEC_PER_SEC and USEC_PER_SEC defines"), which explicitly
changes the local definitions in favor of the internal kernel header,
but that doesn't seem right.

I think we should probably revert that commit instead?

--
Carlos Llamas

