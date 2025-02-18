Return-Path: <linux-kselftest+bounces-26844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18834A3963E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83B27A161A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F322DFBD;
	Tue, 18 Feb 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUkJ67Mh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjnGMBZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78422DFAF;
	Tue, 18 Feb 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869061; cv=none; b=QFEQye5w/PPua2tZ6BRJan26VlBy+h00IjZzsLMbVpy0B4lKkEBeolmeGemVIPSVUo7hE6CmR78i0p+hkYZ/d7hh8gf0wcsZvztbW3bi7eLTc28pDXZoqq8oAghDdAQdob7DplXgDm7TbygYml88uP6ZesITLXE8Rf9cWG+tEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869061; c=relaxed/simple;
	bh=7n8w+ERA8pojz2++WaPBKwjwqZFE9/DbJNIdVjRs0gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGgrrFsaPnrCLikJXf5WdIK/TpWK2pL2A92db4qa9nOxbVBm0c2bgaATgshiYnZYP6KQqg49pgw/R4s+9XW585YFQC2ljAJ3jI3ATqCnTPuFjkLw6aYsZrSCnGwC3SsRasUw5VONDpxIARhPD1TQMrrhlcaZ7ZwN54G8/t55sMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUkJ67Mh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjnGMBZ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:57:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739869057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qi00sFeb7intGV58iU7h9IRHzK7AVG7qi/qdH2z0KQQ=;
	b=FUkJ67MhPasq8kvXjD/bsAI2FDmaN5qca6uZhURZGkoRKaE3rjjTB+2G+9MQipu9bP24rH
	5zraI2X4z3gbbV5AAMS28pCNApEGpUEMQKh3amivMb+6PfKkkuSETG9N1g+QoY9T5K6sjL
	U0pHyPkodErZ7cWF8fcQtolIY5tGm1smQJ8UlhgYv0M5/xroFcGaUFQ7yKNY7N/XHvLGaf
	UkkgvtX9f6QKIiONuXuY6tf/zB+jYtoPT+aUK2xv4UdkWsOLC/qYoXOsVWPFtR03b7awWD
	rZmU3F3stUIZKF7OQy1NOf38b9tbtbuP+gOmUHnjxENq6RHDbvjS74K76MC+2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739869057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qi00sFeb7intGV58iU7h9IRHzK7AVG7qi/qdH2z0KQQ=;
	b=IjnGMBZ17v3aCASnhhz+y8ps26+DBt8gRKH6JNDsUUZehTAkI0aiHpImiua79+zsGbKPT+
	BiXUzimJpXTAQrBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Gow <davidgow@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/12] kunit: Introduce UAPI testing framework
Message-ID: <20250218093333-04552bed-4a2e-445d-9966-e1732a1f8b21@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
 <CABVgOSn5tGDj5rnR=a133ntv3GeoXQLnHRBg9HRf86hWve7T1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSn5tGDj5rnR=a133ntv3GeoXQLnHRBg9HRf86hWve7T1w@mail.gmail.com>

On Tue, Feb 18, 2025 at 04:20:06PM +0800, David Gow wrote:
> On Mon, 17 Feb 2025 at 19:00, Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Currently testing of userspace and in-kernel API use two different
> > frameworks. kselftests for the userspace ones and Kunit for the
> > in-kernel ones. Besides their different scopes, both have different
> > strengths and limitations:
> >
> > Kunit:
> > * Tests are normal kernel code.
> > * They use the regular kernel toolchain.
> > * They can be packaged and distributed as modules conveniently.
> >
> > Kselftests:
> > * Tests are normal userspace code
> > * They need a userspace toolchain.
> >   A kernel cross toolchain is likely not enough.
> > * A fair amout of userland is required to run the tests,
> >   which means a full distro or handcrafted rootfs.
> > * There is no way to conveniently package and run kselftests with a
> >   given kernel image.
> > * The kselftests makefiles are not as powerful as regular kbuild.
> >   For example they are missing proper header dependency tracking or more
> >   complex compiler option modifications.
> >
> > Therefore kunit is much easier to run against different kernel
> > configurations and architectures.
> > This series aims to combine kselftests and kunit, avoiding both their
> > limitations. It works by compiling the userspace kselftests as part of
> > the regular kernel build, embedding them into the kunit kernel or module
> > and executing them from there. If the kernel toolchain is not fit to
> > produce userspace because of a missing libc, the kernel's own nolibc can
> > be used instead.
> > The structured TAP output from the kselftest is integrated into the
> > kunit KTAP output transparently, the kunit parser can parse the combined
> > logs together.
> 
> Wow -- this is really neat! Thanks for putting this together.
> 
> I haven't had a chance to play with it in detail yet, but here are a
> few initial / random thoughts:
> - Having support for running things from userspace within a KUnit test
> seems like it's something that could be really useful for testing
> syscalls (and maybe other mm / exec code as well).

That's the target :-)

I'm also looking for more descriptive naming ideas.

> - I don't think we can totally combine kselftests and KUnit for all
> tests (some of the selftests definitely require more complicated
> dependencies than I think KUnit would want to reasonably support or
> require).

Agreed, though I somewhat expect that some complex selftests would be
simplified to work with this scheme as it should improve test coverage
from the bots.

> - The in-kernel KUnit framework doesn't have any knowledge of the
> structure or results of a uapi test. It'd be nice to at least be able
> to get the process exit status, and bubble up a basic
> 'passed'/'skipped'/'failed' so that we're not reporting success for
> failed tests (and so that simple test executables could run without
> needing to output their own KTAP if they only run one test).

Currently any exitcode != 0 fails the test.
I'll add some proper handling for exit(KSFT_SKIP).

> - Equally, for some selftests, it's probably a pain to have to write a
> kernel module if there's nothing that needs to be done in the kernel.
> Maybe such tests could still be built with nolibc and a kernel
> toolchain, but be triggered directly from the python tooling (e.g. as
> the 'init' process).

Some autodiscovery based on linker sections could be done.
However that would not yet define how to group them into suites.
Having one explicit reference in a module makes everything easier
to understand. What about a helper macro for the test case definition:
KUNIT_CASE_UAPI(symbol)?

All UAPI tests of a subsystem can share the same module,
so the overhead should be limited.
I'd like to keep it usable without needing the python tooling.

Note in case it was not clear:
All test executables are available as normal files in the build directory
and can also be executed from there.

> - There still seems to be some increased requirements over plain KUnit
> at the moment: I'm definitely seeing issues from not having the right
> libgcc installed for all architectures. (Though it's working for most
> of them, which is very neat!)

I'll look into that.

> - This is a great example of how having standardised result formats is useful!

Indeed, it was surprisingly compatible.

> - If this is going to change or blur the boundary between "this is a
> ksefltest" and "this is a kunit test", we probably will need to update
> Documentation/dev-tools/testing-overview.rst -- it probably needs some
> clarifications there _anyway_, so this is probably a good point to
> ensure everyone's on the same page.

Agreed.

> Do you have a particular non-example test you'd like to either write
> or port to use this? I think it'd be great to see some real-world
> examples of where this'd be most useful.

I want to use it for the vDSO selftests.
To be usable for that another series is necessary[0].
I tested the whole thing locally with one selftest and promptly found
a bug in the selftests [1].

> Either way, I'll keep playing with this a bit over the next few days.
> I'd love to hear what Shuah and Rae think, as well, as this involves
> kselftest and KTAP a lot.

Thanks!
I'm also looking forward to their feedback.


Thomas

<snip>

[0] https://lore.kernel.org/lkml/20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de/
[1] https://lore.kernel.org/lkml/20250217-selftests-vdso-s390-gnu-hash-v2-1-f6c2532ffe2a@linutronix.de/

