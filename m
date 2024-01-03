Return-Path: <linux-kselftest+bounces-2624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 534BB82363B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 21:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD62AB21D73
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508881CFB7;
	Wed,  3 Jan 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3nz3Bu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BF1CF94
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jan 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704312919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MjXIKqvmrB+NT0qusC8GfWEtJexw+hWCpiVhSPvJDRk=;
	b=g3nz3Bu9ObqFVKPdjIqD+ZJkhmE3sco4JWeCGU7ZREGWPQQ2TNbX3hgSWFkdbkLwQI6FKC
	AqorApIfSr0/qXf4RPYwR78N0oFrXGI1WhhqIuGQ/W4bzcRgRHFheFkV8NErvs/HWL71SE
	J2K+b8YzPpNgG8CFQh85Y+BLRin5EjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-FH2xjfZfO3OnJBefldRnWA-1; Wed, 03 Jan 2024 15:15:17 -0500
X-MC-Unique: FH2xjfZfO3OnJBefldRnWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99AD7185A785;
	Wed,  3 Jan 2024 20:15:16 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.153])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CD6141121306;
	Wed,  3 Jan 2024 20:15:15 +0000 (UTC)
Date: Wed, 3 Jan 2024 15:15:14 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/3] livepatch: Move modules to selftests and
 add a new test
Message-ID: <ZZXAUr3uH/iSTb/p@redhat.com>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, Dec 20, 2023 at 01:53:11PM -0300, Marcos Paulo de Souza wrote:
> Changes in v4:
> * Documented how to compile the livepatch selftests without running the
>   tests (Joe)
> * Removed the mention to lib/livepatch on MAINTAINERS file, reported by
>   checkpatch.
> 
> Changes in v3:
> * Rebased on top of v6.6-rc5
> * The commits messages were improved (Thanks Petr!)
> * Created TEST_GEN_MODS_DIR variable to point to a directly that contains kernel
>   modules, and adapt selftests to build it before running the test.
> * Moved test_klp-call_getpid out of test_programs, since the gen_tar
>   would just copy the generated test programs to the livepatches dir,
>   and so scripts relying on test_programs/test_klp-call_getpid will fail.
> * Added a module_param for klp_pids, describing it's usage.
> * Simplified the call_getpid program to ignore the return of getpid syscall,
>   since we only want to make sure the process transitions correctly to the
>   patched stated
> * The test-syscall.sh not prints a log message showing the number of remaining
>   processes to transition into to livepatched state, and check_output expects it
>   to be 0.
> * Added MODULE_AUTHOR and MODULE_DESCRIPTION to test_klp_syscall.c
> 
> - Link to v3: https://lore.kernel.org/r/20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com
> - Link to v2: https://lore.kernel.org/linux-kselftest/20220630141226.2802-1-mpdesouza@suse.com/
> 
> This patchset moves the current kernel testing livepatch modules from
> lib/livepatches to tools/testing/selftest/livepatch/test_modules, and compiles
> them as out-of-tree modules before testing.
> 
> There is also a new test being added. This new test exercises multiple processes
> calling a syscall, while a livepatch patched the syscall.
> 
> Why this move is an improvement:
> * The modules are now compiled as out-of-tree modules against the current
>   running kernel, making them capable of being tested on different systems with
>   newer or older kernels.
> * Such approach now needs kernel-devel package to be installed, since they are
>   out-of-tree modules. These can be generated by running "make rpm-pkg" in the
>   kernel source.
> 
> What needs to be solved:
> * Currently gen_tar only packages the resulting binaries of the tests, and not
>   the sources. For the current approach, the newly added modules would be
>   compiled and then packaged. It works when testing on a system with the same
>   kernel version. But it will fail when running on a machine with different kernel
>   version, since module was compiled against the kernel currently running.
> 
>   This is not a new problem, just aligning the expectations. For the current
>   approach to be truly system agnostic gen_tar would need to include the module
>   and program sources to be compiled in the target systems.
> 
> Thanks in advance!
>   Marcos
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Marcos Paulo de Souza (3):
>       kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
>       livepatch: Move tests from lib/livepatch to selftests/livepatch
>       selftests: livepatch: Test livepatching a heavily called syscall
> 
>  Documentation/dev-tools/kselftest.rst              |   4 +
>  MAINTAINERS                                        |   1 -
>  arch/s390/configs/debug_defconfig                  |   1 -
>  arch/s390/configs/defconfig                        |   1 -
>  lib/Kconfig.debug                                  |  22 ----
>  lib/Makefile                                       |   2 -
>  lib/livepatch/Makefile                             |  14 ---
>  tools/testing/selftests/lib.mk                     |  20 +++-
>  tools/testing/selftests/livepatch/Makefile         |   5 +-
>  tools/testing/selftests/livepatch/README           |  25 +++--
>  tools/testing/selftests/livepatch/config           |   1 -
>  tools/testing/selftests/livepatch/functions.sh     |  34 +++---
>  .../testing/selftests/livepatch/test-callbacks.sh  |  50 ++++-----
>  tools/testing/selftests/livepatch/test-ftrace.sh   |   6 +-
>  .../testing/selftests/livepatch/test-livepatch.sh  |  10 +-
>  .../selftests/livepatch/test-shadow-vars.sh        |   2 +-
>  tools/testing/selftests/livepatch/test-state.sh    |  18 ++--
>  tools/testing/selftests/livepatch/test-syscall.sh  |  53 ++++++++++
>  tools/testing/selftests/livepatch/test-sysfs.sh    |   6 +-
>  .../selftests/livepatch/test_klp-call_getpid.c     |  44 ++++++++
>  .../selftests/livepatch/test_modules/Makefile      |  20 ++++
>  .../test_modules}/test_klp_atomic_replace.c        |   0
>  .../test_modules}/test_klp_callbacks_busy.c        |   0
>  .../test_modules}/test_klp_callbacks_demo.c        |   0
>  .../test_modules}/test_klp_callbacks_demo2.c       |   0
>  .../test_modules}/test_klp_callbacks_mod.c         |   0
>  .../livepatch/test_modules}/test_klp_livepatch.c   |   0
>  .../livepatch/test_modules}/test_klp_shadow_vars.c |   0
>  .../livepatch/test_modules}/test_klp_state.c       |   0
>  .../livepatch/test_modules}/test_klp_state2.c      |   0
>  .../livepatch/test_modules}/test_klp_state3.c      |   0
>  .../livepatch/test_modules/test_klp_syscall.c      | 116 +++++++++++++++++++++
>  32 files changed, 334 insertions(+), 121 deletions(-)
> ---
> base-commit: 206ed72d6b33f53b2a8bf043f54ed6734121d26b
> change-id: 20231031-send-lp-kselftests-4c917dcd4565
> 
> Best regards,
> -- 
> Marcos Paulo de Souza <mpdesouza@suse.com>
> 

Hi Marcos,

I made it through retrofitting [1] to our current packaging scheme on
top of the patchset, no big surprises found.

With that, I'm happy to ack this version, unless you want to modify the
TEST_GEN_MODS_DIR / rsync behavior as I reported in my reply yesterday.
(Not a show stopper IMHO, but I'll leave that up to kselftest folks.)

Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>

[1] https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2844/commits

--
Joe


