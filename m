Return-Path: <linux-kselftest+bounces-888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F193C7FF061
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C06BB20E6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B902482CD;
	Thu, 30 Nov 2023 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zB/NxqsP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHGLE5R1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBCC4;
	Thu, 30 Nov 2023 05:42:11 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 206B621AF5;
	Thu, 30 Nov 2023 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701351730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ3BtxLgzZnCHwvpf+aHvGP/K4km0dFJAmq9DtIgU2w=;
	b=zB/NxqsPb4FQwxJjJxl1MOOsAOHDie8kumUb37ozEpCxvbiQyCs8AaoYRXX5KMAr9ssmvG
	NbEKge5awP7RKy0jl2G7OKty/LjAgMQUNmejbkXnqqtRyozSa7pxcICZfFIhHG0PlvaaY9
	9hxUHU3+JKtu6OsvujHcCitwHYIaA4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701351730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ3BtxLgzZnCHwvpf+aHvGP/K4km0dFJAmq9DtIgU2w=;
	b=GHGLE5R1J+bN9OgPKX0++/Rn+Js2t1WeDVOQLVXTaxAD6jkQDbCYmPiasshjPrXlEJTs+I
	FdILPnoKk9pcvcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95E3913AB1;
	Thu, 30 Nov 2023 13:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8DAfGDGRaGXJQwAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Thu, 30 Nov 2023 13:42:09 +0000
Date: Thu, 30 Nov 2023 10:42:06 -0300
From: Marcos Paulo de Souza <mpdesouza@suse.de>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 0/3] livepatch: Move modules to selftests and add a
 new test
Message-ID: <idd6uyqhlx42pteruavjyviyhdy63q47bjes3zwgfdsndxofgp@jhfwrvktpkv4>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.20
X-Spamd-Result: default: False [-3.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[99.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FORGED_SENDER(0.30)[mpdesouza@suse.de,mpdesouza@suse.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FROM_NEQ_ENVFROM(0.10)[mpdesouza@suse.de,mpdesouza@suse.com];
	 RCVD_TLS_ALL(0.00)[]

Humble ping :)

On Tue, Oct 31, 2023 at 06:10:50PM -0300, Marcos Paulo de Souza wrote:
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
> I'm sending the patches now so it can be discussed before Plumbers.
> 
> Thanks in advance!
>   Marcos
> 
> To: Shuah Khan <shuah@kernel.org>
> To: Jonathan Corbet <corbet@lwn.net>
> To: Heiko Carstens <hca@linux.ibm.com>
> To: Vasily Gorbik <gor@linux.ibm.com>
> To: Alexander Gordeev <agordeev@linux.ibm.com>
> To: Christian Borntraeger <borntraeger@linux.ibm.com>
> To: Sven Schnelle <svens@linux.ibm.com>
> To: Josh Poimboeuf <jpoimboe@kernel.org>
> To: Jiri Kosina <jikos@kernel.org>
> To: Miroslav Benes <mbenes@suse.cz>
> To: Petr Mladek <pmladek@suse.com>
> To: Joe Lawrence <joe.lawrence@redhat.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: live-patching@vger.kernel.org
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
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
> The v2 can be seen here:
> https://lore.kernel.org/linux-kselftest/20220630141226.2802-1-mpdesouza@suse.com/
> 
> ---
> Marcos Paulo de Souza (3):
>       kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
>       livepatch: Move tests from lib/livepatch to selftests/livepatch
>       selftests: livepatch: Test livepatching a heavily called syscall
> 
>  Documentation/dev-tools/kselftest.rst              |   4 +
>  arch/s390/configs/debug_defconfig                  |   1 -
>  arch/s390/configs/defconfig                        |   1 -
>  lib/Kconfig.debug                                  |  22 ----
>  lib/Makefile                                       |   2 -
>  lib/livepatch/Makefile                             |  14 ---
>  tools/testing/selftests/lib.mk                     |  20 +++-
>  tools/testing/selftests/livepatch/Makefile         |   5 +-
>  tools/testing/selftests/livepatch/README           |  17 +--
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
>  31 files changed, 325 insertions(+), 121 deletions(-)
> ---
> base-commit: 6489bf2e1df1c84e9bcd4694029ff35b39fd3397
> change-id: 20231031-send-lp-kselftests-4c917dcd4565
> 
> Best regards,
> -- 
> Marcos Paulo de Souza <mpdesouza@suse.com>
> 

