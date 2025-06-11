Return-Path: <linux-kselftest+bounces-34660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92CAD4DD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37EA1797F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3431EBA09;
	Wed, 11 Jun 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/2HXK8q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="con6Hdug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235222D79B;
	Wed, 11 Jun 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629080; cv=none; b=SYWGV52stetCzBMZw8qZ37UHwlZZ2vIC+vMn4lJIitpypvz5OfuCrUelomycuBQalu+9r2hVqjlq05f6orBypyqgdo8HHUo86Ekz/9IIFeACx/vAtchx2XEM49LwOUzrfDih+ULsLh0AQoRGAGRCPkg3xt5jd1xtBLqsWUpvChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629080; c=relaxed/simple;
	bh=3/Efkva65yPVo5qOxC3lVrHAJLXm7UCzGtHmQ4KXEhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7A8TsEah4GZqMFBgEqGq/NyGqM6d+PdlfyHDIrZLBP5zTByucmJbL1Eo64o5by4lcVpCwYN8e0VBlTZxmO5Gp3aZCwAkVQ3i2/vBh1NplYG9S6UcmI+kggPLKuxsgEHddD9W5Hdqa5VXeSg/flaEBF2vo6em/LIbi7KMpDHWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/2HXK8q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=con6Hdug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 10:04:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749629076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2SKKUdPrZUXJA24/Q7m79DvirdquN66Z/YUL7hCSVY=;
	b=Z/2HXK8qrXAErz0whT4G+v7b2AsxF/jbF8ZBGwtAPR4Rtvzj5bOKkweFBwqzhuXYe1DfyC
	xR19ojZixIsNy/XrvoL8TT03yW1j/mFdnODEfWqxovfQz+5G3qgY61p4r39mHs6j+kWTpq
	t3ylT38Yv6G4sC5z0jIB2+Q68cSFCa7afcm/uKANd7kVgY40iidiPp38XdcV0R0D9msY/x
	FFA2xu3uOp4KAx5BkCMPkzblM3oC6sWQPc2kEYg1T5VTq5t6Dg2MbwbwevTFoA2CH/WlSN
	fYNXAIc5yFzd35KxpWdJ/EmDIWMD7CxT240hIoIZUtdzmAYsrskcyfkqZ4fjWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749629076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2SKKUdPrZUXJA24/Q7m79DvirdquN66Z/YUL7hCSVY=;
	b=con6HdugG6CXlKqO4IUFGqu2feEReKr7XM9huuYhJk3Oo8kGoFjmhuc8hZVrP7ssTLu6/d
	jQ/rTkKMZ0A+s4Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEkqtfcOJDrxAAcs@nvidia.com>

On Wed, Jun 11, 2025 at 12:05:25AM -0700, Nicolin Chen wrote:
> On Tue, Jun 10, 2025 at 08:46:57PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 11:48:44AM -0700, Nicolin Chen wrote:
> > > On Tue, Jun 10, 2025 at 09:09:02AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Jun 10, 2025 at 01:38:22PM +0200, Thomas Weißschuh wrote:
> > > > > > ------------------------------------------------------------------
> > > > > > #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> > > > > > # enforce_dirty: Test terminated unexpectedly by signal 11
> > > > 
> > > > Sig 11 is weird..
> > > 
> > > > > On another note, the selftest should use the kselftest_harness' ASSERT_*()
> > > > > macros instead of plain assert().
> > > > 
> > > > IIRC the kselftest stuff explodes if you try to use it's assert
> > > > functions within a fixture setup/teardown context.
> > > > 
> > > > I also wasn't able to reproduce this (x86 ubuntu 24 LTS OS) Maybe
> > > > it is ARM specific, I think Nicolin is running on ARM..
> > > 
> > > Yes. And I was running with 64KB page size. I just quickly retried
> > > with 4KB page size (matching x86), and all failed tests pass now.
> > 
> > That's a weird thing to be sensitive too. Can you get a backtrace from
> > the crash, what function/line is crashing?
> 
> I think I am getting what's going on. Here the harness code has a
> parent process and a child process:
> 
> --------------------------------------------------------------
> 428-            /* _metadata and potentially self are shared with all forks. */ \
> 429:            child = fork(); \
> 430:            if (child == 0) { \
> 431-                    fixture_name##_setup(_metadata, self, variant->data); \
> 432-                    /* Let setup failure terminate early. */ \
> 433-                    if (_metadata->exit_code) \
> 434-                            _exit(0); \
> 435-                    *_metadata->no_teardown = false; \
> 436-                    fixture_name##_##test_name(_metadata, self, variant->data); \
> 437-                    _metadata->teardown_fn(false, _metadata, self, variant->data); \
> 438-                    _exit(0); \
> 439:            } else if (child < 0 || child != waitpid(child, &status, 0)) { \
> 440-                    ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
> 441-                    _metadata->exit_code = KSFT_FAIL; \
> 442-            } \
> 443-            _metadata->teardown_fn(true, _metadata, self, variant->data); \
> 444-            munmap(_metadata->no_teardown, sizeof(*_metadata->no_teardown)); \
> 445-            _metadata->no_teardown = NULL; \
> 446-            if (self && fixture_name##_teardown_parent) \
> 447-                    munmap(self, sizeof(*self)); \
> 448-            if (WIFEXITED(status)) { \
> 449-                    if (WEXITSTATUS(status)) \
> 450-                            _metadata->exit_code = WEXITSTATUS(status); \
> 451-            } else if (WIFSIGNALED(status)) { \
> 452-                    /* Forward signal to __wait_for_test(). */ \
> 453-                    kill(getpid(), WTERMSIG(status)); \
> 454-            } \
> ....
> 456-    static void wrapper_##fixture_name##_##test_name##_teardown( \
> 457-            bool in_parent, struct __test_metadata *_metadata, \
> 458-            void *self, const void *variant) \
> 459-    { \
> 460-            if (fixture_name##_teardown_parent == in_parent && \
> 461-                            !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
> 462-                    fixture_name##_teardown(_metadata, self, variant); \
> 463-    } \
> --------------------------------------------------------------
> 
> I found there is a race between those two processes, resulting in
> the teardown() not getting invoked: I added some ksft_print_msg()
> calls in-between the lines to debug, those tests can pass mostly,
> as teardown() got invoked.
> 
> I think the reason why those huge page cases fail is just because 
> the huge version of setup() takes longer time..

Can you try to recreate this issue with changes to
tools/testing/selftests/kselftest_harness/harness-selftest.c ?

> I haven't figured out a proper fix yet, but something smells bad:
> 1) *no_teardown is set non-atomically, while both processes calls
>    __atomic_test_and_set()

Does this make a difference?

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..89fb37a21d9d 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -410,7 +410,7 @@
                /* Makes sure there is only one teardown, even when child forks again. */ \
                _metadata->no_teardown = mmap(NULL, sizeof(*_metadata->no_teardown), \
                        PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
-               *_metadata->no_teardown = true; \
+               __atomic_store_n(_metadata->no_teardown, true, __ATOMIC_SEQ_CST); \
                if (sizeof(*self) > 0) { \
                        if (fixture_name##_teardown_parent) { \
                                self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
@@ -429,7 +429,7 @@
                        /* Let setup failure terminate early. */ \
                        if (_metadata->exit_code) \
                                _exit(0); \
-                       *_metadata->no_teardown = false; \
+                       __atomic_store_n(_metadata->no_teardown, false, __ATOMIC_SEQ_CST); \
                        fixture_name##_##test_name(_metadata, self, variant->data); \
                        _metadata->teardown_fn(false, _metadata, self, variant->data); \
                        _exit(0); \
@@ -455,7 +455,7 @@
                void *self, const void *variant) \
        { \
                if (fixture_name##_teardown_parent == in_parent && \
-                               !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
+                               !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_SEQ_CST)) \
                        fixture_name##_teardown(_metadata, self, variant); \
        } \
        static struct __test_metadata *_##fixture_name##_##test_name##_object; \

> 2) parent doesn't seem to wait for the setup() to complete..

setup() is called in the child (L431) right before the testcase itself is
called (L436). The parent waits for the child to exit (L439) before unmapping.

> 3) when parent runs faster than the child that is still running
>    setup(), the parent unmaps the no_teardown and set it to NULL,
>    then UAF in the child, i.e. signal 11?

That should never happen as the waitpid() will block until the child running
setup() and the testcase itself have exited.

Does the issue also happen when you only execute a single testcase?
$ ./iommufd -r iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty


Thomas

