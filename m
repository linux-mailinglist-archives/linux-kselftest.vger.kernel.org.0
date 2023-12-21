Return-Path: <linux-kselftest+bounces-2298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967881B59E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 13:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3046328556E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1666EB4D;
	Thu, 21 Dec 2023 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2hXv4Fa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BF6E2C2
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c31f18274so8897665e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 04:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703161035; x=1703765835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wo4F4JANDOClYN3jxQcqNRyTGhNp1nyKO/PKQRBOOYU=;
        b=b2hXv4FadH3SMVjwstOXXV9hqWfCEQEkIAG9p9uCUHspvvLECNXeI6Shq/25ftaElw
         LVbMmNxz5DEzQvw2xDVnlb0C+IqOAjlJtiLIVeZxcY6ydOsWqXlFsg3rGBNIqN+9FCfY
         gdoIq1EXuwZAT8DYfTIMqje087V/5fg3ZbrAADs+rRVxArl/++NI6xJiLW6Q8zXmqGEi
         dqFqfHydBHvAVdjQsZUg/XmfHaH/tMU1XDBBuoPH1YAI5cQ+jpJMJbsBajj1CzZeBbv8
         SNVL+OvcIRD8o0M93z3yw6kBzRkIZb8+fO9xZGGJNDxQO25V4q0zWhV0g9K2xBg+W7nu
         zrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703161035; x=1703765835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wo4F4JANDOClYN3jxQcqNRyTGhNp1nyKO/PKQRBOOYU=;
        b=XDclq7/yerUEP9FH6WJ7x1SpkSD8X+QcmC5lfcihzxz5Mtl+Dtbb1yJ9QxScRceeM5
         ossRPOf+7K8egJ8moX81ocIqLO9bYxMWXYSauSHMgjlEYWKJFdTjQnHedGIFOgLLJfIp
         VPxLRICEF5k9Uo/YbvqoPiUOQcrOoROkNt5NNg9cwokrZ8a2ldMUw3/JDozpAJqyO5l0
         nc6/k+UyohTz2gDl8uB0GWIrRS1bxaGgAdz4Sp/4gC6tJ0NzEjJs8Ihf31AgwjZZmacu
         OnpxZv5z39rtIIouaARPoyUD1/1/q4FeUMkfGsGlqfdFm+vI/LtxTPFDkyZO497T6sFo
         KnmA==
X-Gm-Message-State: AOJu0YxLjBcjauhHQsF5q5B7HpjMvCFXDCX7dNPdAEmvSBLYq2XtzaKo
	yTvvKYSmh1LIo5ysYBGDcHQNIA==
X-Google-Smtp-Source: AGHT+IFihwiQ9oiYKP5ukG9du9pUTnhTefLm+hmzcqxCv27XCcqGJ9+vh83Neir6CDrML5VfrH6irQ==
X-Received: by 2002:a7b:ce87:0:b0:40d:38df:5802 with SMTP id q7-20020a7bce87000000b0040d38df5802mr705115wmj.165.1703161035199;
        Thu, 21 Dec 2023 04:17:15 -0800 (PST)
Received: from ?IPv6:2804:30c:1668:b300:8fcd:588d:fb77:ed04? ([2804:30c:1668:b300:8fcd:588d:fb77:ed04])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d560f000000b0033609584b9dsm1909827wrv.74.2023.12.21.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 04:17:14 -0800 (PST)
Message-ID: <55b717dba239f3bedf0da7e25925e390a63459f5.camel@suse.com>
Subject: Re: [PATCH RESEND v4 0/3] livepatch: Move modules to selftests and
 add a new test
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Miroslav
 Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
 <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	live-patching@vger.kernel.org
Date: Thu, 21 Dec 2023 09:17:04 -0300
In-Reply-To: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 13:53 -0300, Marcos Paulo de Souza wrote:
> Changes in v4:
> * Documented how to compile the livepatch selftests without running
> the
> =C2=A0 tests (Joe)
> * Removed the mention to lib/livepatch on MAINTAINERS file, reported
> by
> =C2=A0 checkpatch.
>=20

To clarify: this is not a resend, this is the v4 that people were
waiting for. I made a mistake with b4 tool, that first I sent the email
just to myself, for testing, and it bumped the version to v5, but I
asked it to "resend" the v4, but it ended up adding the "RESEND" to the
series.

Please review this patchset and ignore the RESEND word.

Thanks to Petr Mladek for spotting my mistake.

	Marcos

> Changes in v3:
> * Rebased on top of v6.6-rc5
> * The commits messages were improved (Thanks Petr!)
> * Created TEST_GEN_MODS_DIR variable to point to a directly that
> contains kernel
> =C2=A0 modules, and adapt selftests to build it before running the test.
> * Moved test_klp-call_getpid out of test_programs, since the gen_tar
> =C2=A0 would just copy the generated test programs to the livepatches dir=
,
> =C2=A0 and so scripts relying on test_programs/test_klp-call_getpid will
> fail.
> * Added a module_param for klp_pids, describing it's usage.
> * Simplified the call_getpid program to ignore the return of getpid
> syscall,
> =C2=A0 since we only want to make sure the process transitions correctly
> to the
> =C2=A0 patched stated
> * The test-syscall.sh not prints a log message showing the number of
> remaining
> =C2=A0 processes to transition into to livepatched state, and check_outpu=
t
> expects it
> =C2=A0 to be 0.
> * Added MODULE_AUTHOR and MODULE_DESCRIPTION to test_klp_syscall.c
>=20
> - Link to v3:
> https://lore.kernel.org/r/20231031-send-lp-kselftests-v3-0-2b1655c2605f@s=
use.com
> - Link to v2:
> https://lore.kernel.org/linux-kselftest/20220630141226.2802-1-mpdesouza@s=
use.com/
>=20
> This patchset moves the current kernel testing livepatch modules from
> lib/livepatches to tools/testing/selftest/livepatch/test_modules, and
> compiles
> them as out-of-tree modules before testing.
>=20
> There is also a new test being added. This new test exercises
> multiple processes
> calling a syscall, while a livepatch patched the syscall.
>=20
> Why this move is an improvement:
> * The modules are now compiled as out-of-tree modules against the
> current
> =C2=A0 running kernel, making them capable of being tested on different
> systems with
> =C2=A0 newer or older kernels.
> * Such approach now needs kernel-devel package to be installed, since
> they are
> =C2=A0 out-of-tree modules. These can be generated by running "make rpm-
> pkg" in the
> =C2=A0 kernel source.
>=20
> What needs to be solved:
> * Currently gen_tar only packages the resulting binaries of the
> tests, and not
> =C2=A0 the sources. For the current approach, the newly added modules
> would be
> =C2=A0 compiled and then packaged. It works when testing on a system with
> the same
> =C2=A0 kernel version. But it will fail when running on a machine with
> different kernel
> =C2=A0 version, since module was compiled against the kernel currently
> running.
>=20
> =C2=A0 This is not a new problem, just aligning the expectations. For the
> current
> =C2=A0 approach to be truly system agnostic gen_tar would need to include
> the module
> =C2=A0 and program sources to be compiled in the target systems.
>=20
> Thanks in advance!
> =C2=A0 Marcos
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Marcos Paulo de Souza (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kselftests: lib.mk: Add TEST_GEN_MODS_DIR =
variable
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 livepatch: Move tests from lib/livepatch t=
o selftests/livepatch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selftests: livepatch: Test livepatching a =
heavily called
> syscall
>=20
> =C2=A0Documentation/dev-tools/kselftest.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0arch/s390/configs/debug_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 -
> =C2=A0arch/s390/configs/defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0lib/Kconfig.debug=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 22 ----
> =C2=A0lib/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 -
> =C2=A0lib/livepatch/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 ---
> =C2=A0tools/testing/selftests/lib.mk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 20 +++-
> =C2=A0tools/testing/selftests/livepatch/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0tools/testing/selftests/livepatch/README=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 +++--
> =C2=A0tools/testing/selftests/livepatch/config=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0tools/testing/selftests/livepatch/functions.sh=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 34 +++---
> =C2=A0.../testing/selftests/livepatch/test-callbacks.sh=C2=A0 |=C2=A0 50 =
++++-----
> =C2=A0tools/testing/selftests/livepatch/test-ftrace.sh=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +-
> =C2=A0.../testing/selftests/livepatch/test-livepatch.sh=C2=A0 |=C2=A0 10 =
+-
> =C2=A0.../selftests/livepatch/test-shadow-vars.sh=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0tools/testing/selftests/livepatch/test-state.sh=C2=A0=C2=A0=C2=A0 |=
=C2=A0 18 ++--
> =C2=A0tools/testing/selftests/livepatch/test-syscall.sh=C2=A0 |=C2=A0 53 =
++++++++++
> =C2=A0tools/testing/selftests/livepatch/test-sysfs.sh=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +-
> =C2=A0.../selftests/livepatch/test_klp-call_getpid.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 44 ++++++++
> =C2=A0.../selftests/livepatch/test_modules/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 20 ++++
> =C2=A0.../test_modules}/test_klp_atomic_replace.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../test_modules}/test_klp_callbacks_busy.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../test_modules}/test_klp_callbacks_demo.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../test_modules}/test_klp_callbacks_demo2.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../test_modules}/test_klp_callbacks_mod.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../livepatch/test_modules}/test_klp_livepatch.c=C2=A0=C2=A0 |=C2=
=A0=C2=A0 0
> =C2=A0.../livepatch/test_modules}/test_klp_shadow_vars.c |=C2=A0=C2=A0 0
> =C2=A0.../livepatch/test_modules}/test_klp_state.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../livepatch/test_modules}/test_klp_state2.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../livepatch/test_modules}/test_klp_state3.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../livepatch/test_modules/test_klp_syscall.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 116
> +++++++++++++++++++++
> =C2=A032 files changed, 334 insertions(+), 121 deletions(-)
> ---
> base-commit: 206ed72d6b33f53b2a8bf043f54ed6734121d26b
> change-id: 20231031-send-lp-kselftests-4c917dcd4565
>=20
> Best regards,


