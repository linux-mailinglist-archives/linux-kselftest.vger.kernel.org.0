Return-Path: <linux-kselftest+bounces-29879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DC4A7485B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 11:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D621C1899B5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C954A35;
	Fri, 28 Mar 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="d4rrCeae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC1156230
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158015; cv=none; b=NKgbRdGXRLezjXGWngYErT3/X1R1x3mzJAQvhs/CwGWbzbRFCOrtsjfpHkzZ5/YxZivAopf7x/ZEK/s+XgtCrKzhHa4WEkG1u247bUmeKFW00GFFFJVPz7htjygbTuBypEqUWNYklSa4tzkEiRwnESzxhvh+FxcaxWf8XV/QkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158015; c=relaxed/simple;
	bh=x2e4qnIWrwIBG0j4W+5WT1W+v5MPlz50IWf7emFarRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2qmgyFFv1VUHqIlASCAqkXjWVIS+5p3llkBWt/oZEZqKQCuZoKM2wK5b3nhzjIJ6yBgrEwfvh+FP9UEp7a5yA4VqakAJ+J4Rx0T086+wwGLsiqK7UW+aX/gesucNsOaJIm2e4z3NvdPLuOEX/L0SeDCfJ1mFZkZ55n/Cf3AM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=d4rrCeae; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZPH1H2NqFzVfJ;
	Fri, 28 Mar 2025 11:33:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1743158003;
	bh=ZRMeNlcXNIbn1nJwecKQQoqD89P0pz802GFL11P7xo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4rrCeaeECs4meKGwPt7Wp3nMmR1RwXM+Vy+28uAjIlMObqbr/+B5EwjVDAfb6dy0
	 o4C2LVSasTtrBPaaQszpmUtor98nBKIuG7IhZdYOvYHOYTkPFRBSM9r6mvXnKvxjtb
	 yCypmxnt6aRKFmnB296GOlblJVEby4rR7RMiJJok=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZPH1G0ZHMzJhb;
	Fri, 28 Mar 2025 11:33:21 +0100 (CET)
Date: Fri, 28 Mar 2025 11:33:21 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Alessandro Carminati <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v7 09/28] landlock: Add AUDIT_LANDLOCK_ACCESS and log
 ptrace denials
Message-ID: <20250328.Ahc0thi6CaiJ@digikod.net>
References: <20250320190717.2287696-10-mic@digikod.net>
 <20250327213807.12964-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250327213807.12964-1-m@maowtm.org>
X-Infomaniak-Routing: alpha

On Thu, Mar 27, 2025 at 09:38:05PM +0000, Tingmao Wang wrote:
> Hi Mickaël,

Hi, thanks for the report.

> 
> On 3/20/25 19:06, Mickaël Salaün wrote:
> [...]
> > +static struct landlock_hierarchy *
> > +get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
> > +{
> > +	struct landlock_hierarchy *hierarchy = domain->hierarchy;
> > +	ssize_t i;
> > +
> > +	if (WARN_ON_ONCE(layer >= domain->num_layers))
> > +		return hierarchy;
> > +
> > +	for (i = domain->num_layers - 1; i > layer; i--) {
> > +		if (WARN_ON_ONCE(!hierarchy->parent))
> > +			break;
> > +
> > +		hierarchy = hierarchy->parent;
> > +	}
> > +
> > +	return hierarchy;
> > +}
> > +
> > +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> > +
> > +static void test_get_hierarchy(struct kunit *const test)
> > +{
> > +	struct landlock_hierarchy dom0_hierarchy = {
> > +		.id = 10,
> > +	};
> > +	struct landlock_hierarchy dom1_hierarchy = {
> > +		.parent = &dom0_hierarchy,
> > +		.id = 20,
> > +	};
> > +	struct landlock_hierarchy dom2_hierarchy = {
> > +		.parent = &dom1_hierarchy,
> > +		.id = 30,
> > +	};
> > +	struct landlock_ruleset dom2 = {
> > +		.hierarchy = &dom2_hierarchy,
> > +		.num_layers = 3,
> > +	};
> > +
> > +	KUNIT_EXPECT_EQ(test, 10, get_hierarchy(&dom2, 0)->id);
> > +	KUNIT_EXPECT_EQ(test, 20, get_hierarchy(&dom2, 1)->id);
> > +	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, 2)->id);
> > +	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, -1)->id);
> 
> This causes a warning from WARN_ON_ONCE(layer >= domain->num_layers)
> when running this test, I guess because layer is unsigned.

Interestingly this doesn't make the test to fail (because the result is
still correct), nor to show up when using tools/testing/kunit/kunit.py,
which is why I didn't see that.

> Should it
> be ssize_t, if this is an expected usage?

The get_hierarchy() code is correct, and the KUnit test is correct too.
Using a ssize_t would introduce a bug.

The issue is that I wanted to test a case that should never happen,
hence the WARN_ON_ONCE().

I guess the best "fix" for now would be to remove the KUnit test with
-1, but there is a new KUnit feature to hide this kind of warning:
https://lore.kernel.org/linux-kselftest/20250313114329.284104-1-acarmina@redhat.com/
It is currently in linux-next, but I'm not sure it will be merged in
Linux 6.15 .

For now I'll keep this commit but I'll send a fix/update to either
remove the test or use the new DEFINE_SUPPRESSED_WARNING macros
depending on its merge status.

> 
> ------------[ cut here ]------------
> WARNING: CPU: 7 PID: 145 at security/landlock/audit.c:142 get_hierarchy (security/landlock/audit.c:142)
> Modules linked in:
> CPU: 7 UID: 0 PID: 145 Comm: kunit_try_catch Tainted: G                 N  6.14.0-next-20250326-dev-00004-g4e57edc3e062-dirty #5 PREEMPT(undef)
> Tainted: [N]=TEST
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:get_hierarchy (security/landlock/audit.c:142)
> Code: 83 e8 02 e8 18 00 84 c0 75 02 0f 0b 48 83 c4 08 48 89 d8 5b 41 5c 41 5e 5d c3 48 c7 c7 00 f3 21 83 e8 e2 e7 18 00 84 c0 75 e2 <0f> 0b eb de 48 89 75 e0 e8 a1 a9 a7 ff 48 8b 75 e0 e9 76 ff ff ff
> // snip //
> Call Trace:
>  <TASK>
> test_get_hierarchy (security/landlock/audit.c:178 (discriminator 5))
> ? test_get_denied_layer (security/landlock/audit.c:158)
> ? lock_repin_lock (kernel/locking/lockdep.c:5649 kernel/locking/lockdep.c:5978)
> ? __lock_acquire (kernel/locking/lockdep.c:4675 kernel/locking/lockdep.c:5189)
> ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
> ? find_held_lock (kernel/locking/lockdep.c:5348)
> ? trace_irq_enable (./include/trace/events/preemptirq.h:40 (discriminator 17))
> ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
> ? kvm_clock_get_cycles (./arch/x86/include/asm/preempt.h:95 arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86)
> ? ktime_get_ts64 (kernel/time/timekeeping.c:318 (discriminator 4) kernel/time/timekeeping.c:335 (discriminator 4) kernel/time/timekeeping.c:907 (discriminator 4))
> kunit_try_run_case (lib/kunit/test.c:400 lib/kunit/test.c:443)
> ? kunit_try_run_case_cleanup (lib/kunit/test.c:430)
> 
> 

