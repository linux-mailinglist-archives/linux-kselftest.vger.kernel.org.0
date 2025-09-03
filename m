Return-Path: <linux-kselftest+bounces-40672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C0B4116D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 02:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AD71884A51
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BF1C7015;
	Wed,  3 Sep 2025 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXroOjNX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CC20EB;
	Wed,  3 Sep 2025 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860288; cv=none; b=oJTBOyJmInH4b6QQFQVYDZbxhmYuql5lfTxUD9H6NLS1AYA+HTA+7RAeKeZ58Ih5thNqp+43LSsILvZe74rxNZjD83hR+RUwLCluxjOzOT3pd11JjmgbNI0VoATjYklczIRZBBcD+0GpCBxjYsyTPS/G8+5BEOtnt91+YUwj0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860288; c=relaxed/simple;
	bh=NccB3h/Et98EAas0rh6/+OuzQlgUYYvExszhgL4SOw0=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=U17dIEjngiaDvVGObBhibvxFZp+uBvfOlYCSeJfsiXDgEVMjoYRZpYRO1NkaY/34b1kSMmCKMk+0q5tZdyaHKzNjX9G1nXpzalkdtnSF4PCLHuoQJrfwEoUBrbBfKMvJPtouqvK+scq/uDiWSnmRYY930SuO452dXD1AmKjkpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXroOjNX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24c863e852aso3858955ad.1;
        Tue, 02 Sep 2025 17:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756860285; x=1757465085; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+jJHEXUqKZxNCmW90fN8yoWhef+e9CtSLJLwD2hj/A=;
        b=AXroOjNXC5Z2TfKe4cZI6l5/c8gVLuX+lNaaDyZZg1NuslSgsMsT8rHuNpYStU41SD
         1FO0ESQmBmNzESuPyzHcXFdIf0+Blei307OX3JDrknwAP8n4Rp2k+2kAoLFyWQQiF7wo
         oxS+zHP8yVAysjYzzUc5H50CvTCF77aKv6TdnlXKqH2scPwW7kfndgM3UF9a6AW8pXFQ
         siSJPm+t9eju/Yr+RsicZM+iW39u3hNiKcVeZ6bTDlL9JYDPV2KuJHodGjoJhdVP8CI7
         EjREXEjRePpSuMVzwuUKfnKAaNbm63MqL9501h5xbfqr+71ZAVZPznZjbawM5XjRksXO
         ZgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756860285; x=1757465085;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+jJHEXUqKZxNCmW90fN8yoWhef+e9CtSLJLwD2hj/A=;
        b=aDGiJJCxKE9NzLUy1LkjcHJ5I7DVvSAaEq/K40ExLMjVpPrsdApxBXQK05Q5R9eCod
         PeqZOCdfUEpFfgD2hHBQja55BSIScs3P0/P9pp0pTRAdnifZNYnIay5yIaOUSjtR5tcv
         MdZ+dODMNGvdjCU0rR0L9uBVIN1nxDqrRkzFg8pt8NICjmYGUzKWdEA6tUVaVZSQ0htX
         rg+hL8FlQdO795j9k/d0UC3tWpkyraatKBKmXH9Oe4vtvZk6uRUXKKYMm6GJfs/HjEzL
         E/twSXJqXShSMcWhZ/woQsnKRwV87ZdtvQbgC6jqjDQDSgTvdy+bzp5JLDRiEU66P6lb
         sk4w==
X-Forwarded-Encrypted: i=1; AJvYcCVNHHEXckPVvoua2NYdLyfrWl2vtzIj0oKKyAPdmT7WwxPhpTP3PUmWzra97Eao3xgzzwH4ajuK/eJEe49m@vger.kernel.org, AJvYcCWbCax8pFZXy7zjHYQ42O2Cg1l1TQ0UTTHF2UlX361Kn3HUmLULBh3RS/nI4JID9oV6sOApmiI7K4VHHDGT94s=@vger.kernel.org, AJvYcCXXsnn3XOUGz55IIyOhSGkP9h/1reQYzQKacHQItfdJ7Nznw/VGNroayBNbdF+dS6UlkY4VGx+M50UA/IUuSRKK@vger.kernel.org
X-Gm-Message-State: AOJu0YxeDaB++BWb8rxDkX9eqhswcJK3H5fqlOt77azcWqo1ST/l9r1I
	XmQ4xfacog4zifyEFzfehIK/myGYZ93oxqJxNJAhXG+NAoIUWt59Jm17QFojrh0F
X-Gm-Gg: ASbGncuCmQbJzmRMBIK+Fp68J9EYm8HBR9eZ37RRNRp+Rwe4UBaPTHYxpJfSf4WIbyY
	SxecYfSsDZND0Y6+b5lwnvGDT3b0H3sU6eUaExfqV/oUK3aTFowy0G2SZgAYkLVfwDQmHRGrJfY
	Dr0rN77kqYJbofHtl/y2G5E31mYyCANgMk4RjisfBtQ1oECklKT03oy3FP8XzNb/HdPHTTOMnxQ
	ZEUJI2GabDi5IPoDQEsKlv+WVqzrBqG4D5QUFCfz6Wnz4GepO007dZPJAfPhfJr+DURt68YVFT6
	06E2cZmWD02Et12fVJASUn1ZIZ9sOikIdby/zC8Is+hS3zZIhiMtxgS7/riNIvpDrvwvHSMYlB0
	vFOwLn92jpu5trO20z7l02usE2OJnCZn5tg==
X-Google-Smtp-Source: AGHT+IEj1mh9iwON3JN1bm2ubUrrqAKd7AKOw1vxWK61dVS+UZon9FMiFI7SrcHklV+nl/Mb4YDw/A==
X-Received: by 2002:a17:902:e749:b0:24b:15b3:223d with SMTP id d9443c01a7336-24b15b34ad6mr50640105ad.16.1756860284196;
        Tue, 02 Sep 2025 17:44:44 -0700 (PDT)
Received: from 1337 ([136.159.213.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b21e9a251sm25480815ad.88.2025.09.02.17.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 17:44:42 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Paul Moore
 <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] selftests/tty: add TIOCSTI test suite
Date: Tue, 02 Sep 2025 18:30:28 -0600
References: <20250730-toicsti-bug-v3-1-dd2dac97f27a@gmail.com>
 <202508061135.00D9366F@keescook>
User-agent: mu4e 1.10.8; emacs 30.2
In-reply-to: <202508061135.00D9366F@keescook>
Message-ID: <87o6rsjreu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kees Cook <kees@kernel.org> writes:

> On Wed, Jul 30, 2025 at 06:14:43PM -0600, Abhinav Saxena wrote:
>> TIOCSTI is a TTY ioctl command that allows inserting characters into
>> the terminal input queue, making it appear as if the user typed those
>> characters. This functionality has behavior that varies based on system
>> configuration and process credentials.
>>=20
>> The dev.tty.legacy_tiocsti sysctl introduced in commit 83efeeeb3d04
>> (=E2=80=9Ctty: Allow TIOCSTI to be disabled=E2=80=9D) controls TIOCSTI u=
sage. When
>> disabled, TIOCSTI requires CAP_SYS_ADMIN capability.
>>=20
>> The current implementation checks the current process=E2=80=99s credenti=
als via
>> capable(CAP_SYS_ADMIN), but does not validate against the file opener=E2=
=80=99s
>> credentials stored in file->f_cred. This creates different behavior when
>> file descriptors are passed between processes via SCM_RIGHTS.
>>=20
>> Add a test suite with 16 test variants using fixture variants to verify
>> TIOCSTI behavior when dev.tty.legacy_tiocsti is enabled/disabled:
>>=20
>> - Basic TIOCSTI tests (8 variants): Direct testing with different
>>   capability and controlling terminal combinations
>> - FD passing tests (8 variants): Test behavior when file descriptors
>>   are passed between processes with different capabilities
>>=20
>> The FD passing tests document this behavior - some tests show different
>> results than expected based on file opener credentials, demonstrating
>> that TIOCSTI uses current process credentials rather than file opener
>> credentials.
>>=20
>> The tests validate proper enforcement of the legacy_tiocsti sysctl. Test
>> implementation uses openpty(3) with TIOCSCTTY for isolated PTY
>> environments. See tty_ioctl(4) for details on TIOCSTI behavior and
>> security requirements.
>
> This is looking really nice! Notes below=E2=80=A6
>
>>=20
>> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
>> =E2=80=94
>> To run all tests:
>> $ sudo ./tools/testing/selftests/tty/tty_tiocsti_test
>>=20
>> Test Results:
>> - PASSED: 13/16 tests
>> - Different behavior: 3/16 tests (documenting credential checking behavi=
or)
>>=20
>> All tests validated using:
>> - scripts/checkpatch.pl =E2=80=93strict (clean output)
>> - Functional testing on kernel v6.16-rc2
>>=20
>> Changes in v3:
>> - Replaced all printf() calls with TH_LOG() for proper test logging (Kee=
s Cook)
>> - Added struct __test_metadata parameter to helper functions
>> - Moved common legacy_tiocsti availability check to FIXTURE_SETUP()
>> - Implemented sysctl modification/restoration in FIXTURE_SETUP/TEARDOWN
>> - Used openpty() with TIOCSCTTY for reliable PTY testing environment
>> - Fixed child/parent synchronization in FD passing tests
>> - Replaced manual _exit(1) handling with proper ASSERT statements
>> - Switched // comments to /* */ format throughout
>> - Expanded to 16 test variants using fixture variants
>> - Enhanced error handling and test reliability
>> - Link to v2: <https://lore.kernel.org/r/20250713-toicsti-bug-v2-1-b1837=
87eea29@gmail.com>
>> - Link to v1: <https://lore.kernel.org/r/20250622-toicsti-bug-v1-0-f3743=
73b04b2@gmail.com>
>>=20
>> References:
>> - tty_ioctl(4) - documents TIOCSTI ioctl and capability requirements
>> - openpty(3) - pseudo-terminal creation and management
>> - commit 83efeeeb3d04 (=E2=80=9Ctty: Allow TIOCSTI to be disabled=E2=80=
=9D)
>> - Documentation/security/credentials.rst
>> - <https://github.com/KSPP/linux/issues/156>
>> - <https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad/>
>> - drivers/tty/Kconfig
>> - Documentation/driver-api/tty/
>> =E2=80=94
>>  tools/testing/selftests/tty/Makefile           |   6 +-
>>  tools/testing/selftests/tty/config             |   1 +
>>  tools/testing/selftests/tty/tty_tiocsti_test.c | 650 ++++++++++++++++++=
+++++++
>>  3 files changed, 656 insertions(+), 1 deletion(-)
>>=20
>> diff =E2=80=93git a/tools/testing/selftests/tty/Makefile b/tools/testing=
/selftests/tty/Makefile
>> index 50d7027b2ae3..7f6fbe5a0cd5 100644
>> =E2=80=94 a/tools/testing/selftests/tty/Makefile
>> +++ b/tools/testing/selftests/tty/Makefile
>> @@ -1,5 +1,9 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  CFLAGS =3D -O2 -Wall
>> -TEST_GEN_PROGS :=3D tty_tstamp_update
>> +TEST_GEN_PROGS :=3D tty_tstamp_update tty_tiocsti_test
>> +LDLIBS +=3D -lcap
>>=20=20
>>  include ../lib.mk
>> +
>> +# Add libcap for TIOCSTI test
>> +$(OUTPUT)/tty_tiocsti_test: LDLIBS +=3D -lcap
>> diff =E2=80=93git a/tools/testing/selftests/tty/config b/tools/testing/s=
elftests/tty/config
>> new file mode 100644
>> index 000000000000..c6373aba6636
>> =E2=80=94 /dev/null
>> +++ b/tools/testing/selftests/tty/config
>> @@ -0,0 +1 @@
>> +CONFIG_LEGACY_TIOCSTI=3Dy
>> diff =E2=80=93git a/tools/testing/selftests/tty/tty_tiocsti_test.c b/too=
ls/testing/selftests/tty/tty_tiocsti_test.c
>> new file mode 100644
>> index 000000000000..1eafef6e36fa
>> =E2=80=94 /dev/null
>> +++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
>> @@ -0,0 +1,650 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * TTY Tests - TIOCSTI
>> + *
>> + * Copyright =C2=A9 2025 Abhinav Saxena <xandfury@gmail.com>
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <sys/ioctl.h>
>> +#include <errno.h>
>> +#include <stdbool.h>
>> +#include <string.h>
>> +#include <sys/socket.h>
>> +#include <sys/wait.h>
>> +#include <pwd.h>
>> +#include <termios.h>
>> +#include <grp.h>
>> +#include <sys/capability.h>
>> +#include <sys/prctl.h>
>> +#include <pty.h>
>> +#include <utmp.h>
>> +
>> +#include =E2=80=9C../kselftest_harness.h=E2=80=9D
>> +
>> +enum test_type {
>> +	TEST_PTY_TIOCSTI_BASIC,
>> +	TEST_PTY_TIOCSTI_FD_PASSING,
>> +	/* other tests cases such as serial may be added. */
>> +};
>> +
>> +/*
>> + * Test Strategy:
>> + * - Basic tests: Use PTY with/without TIOCSCTTY (controlling terminal =
for
>> + *   current process)
>> + * - FD passing tests: Child creates PTY, parent receives FD (demonstra=
tes
>> + *   security issue)
>> + *
>> + * SECURITY VULNERABILITY DEMONSTRATION:
>> + * FD passing tests show that TIOCSTI uses CURRENT process credentials,=
 not
>> + * opener credentials. This means privileged processes can be given FDs=
 from
>> + * unprivileged processes and successfully perform TIOCSTI operations t=
hat the
>> + * unprivileged process couldn=E2=80=99t do directly.
>> + *
>> + * Attack scenario:
>> + * 1. Unprivileged process opens TTY (direct TIOCSTI fails due to lack =
of
>> + *    privileges)
>> + * 2. Unprivileged process passes FD to privileged process via SCM_RIGH=
TS
>> + * 3. Privileged process can use TIOCSTI on the FD (succeeds due to its
>> + *    privileges)
>> + * 4. Result: Effective privilege escalation via file descriptor passing
>> + *
>> + * This matches the kernel logic in tiocsti():
>> + * 1. if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN)) return -EIO;
>> + * 2. if ((current->signal->tty !=3D tty) && !capable(CAP_SYS_ADMIN))
>> + *        return -EPERM;
>> + * Note: Both checks use capable() on CURRENT process, not FD opener!
>> + *
>> + * If the file credentials were also checked along with the capable() c=
hecks
>> + * then the results for FD pass tests would be consistent with the basi=
c tests.
>> + */
>> +
>> +FIXTURE(tiocsti)
>> +{
>> +	int pty_master_fd; /* PTY - for basic tests */
>> +	int pty_slave_fd;
>> +	bool has_pty;
>> +	bool initial_cap_sys_admin;
>> +	int original_legacy_tiocsti_setting;
>> +	bool can_modify_sysctl;
>> +};
>> +
>> +FIXTURE_VARIANT(tiocsti)
>> +{
>> +	const enum test_type test_type;
>> +	const bool controlling_tty; /* true=3Dcurrent->signal->tty `=3D tty */
>> +	const int legacy_tiocsti; /* 0=3Drestricted, 1=3Dpermissive */
>> +	const bool requires_cap; /* true=3Dwith CAP_SYS_ADMIN, false=3Dwithout=
 */
>> +	const int expected_success; /* 0=3Dsuccess, -EIO/-EPERM=3Dspecific err=
or */
>> +};
>> +
>> +/*
>> + * Tests Controlling Terminal Variants (current->signal->tty =3D' tty)
>> + *
>> + * TIOCSTI Test Matrix:
>> + *
>> + * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
>> + * |=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-|=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94|=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=93|=E2=80=94=E2=80=94-|
>> + * | 1 (permissive) | true          | SUCCESS         | -     |
>> + * | 1 (permissive) | false         | SUCCESS         | -     |
>> + * | 0 (restricted) | true          | SUCCESS         | -     |
>> + * | 0 (restricted) | false         | FAILURE         | -EIO  |
>> + */
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D -EIO, /* FAILURE: legacy restriction */
>> +}; /* clang-format on */
>> +
>> +/*
>> + * Note for FD Passing Test Variants
>> + * Since we=E2=80=99re testing the scenario where an unprivileged proce=
ss pass an FD
>> + * to a privileged one, .requires_cap here means the caps of the child =
process.
>> + * Not the parent; parent would always be privileged.
>> + */
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D true,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D -EIO,
>> +}; /* clang-format on */
>> +
>> +/*
>> + * Non-Controlling Terminal Variants (current->signal->tty !=3D tty)
>> + *
>> + * TIOCSTI Test Matrix:
>> + *
>> + * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
>> + * |=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-|=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94|=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=93|=E2=80=94=E2=80=94-|
>> + * | 1 (permissive) | true          | SUCCESS         | -     |
>> + * | 1 (permissive) | false         | FAILURE         | -EPERM|
>> + * | 0 (restricted) | true          | SUCCESS         | -     |
>> + * | 0 (restricted) | false         | FAILURE         | -EIO  |
>> + */
>> +
>> +/* clang-format off */
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D -EPERM,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D -EIO,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 1,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D -EPERM,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_withcap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D true,
>> +	.expected_success =3D 0,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_nocap) {
>> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
>> +	.controlling_tty =3D false,
>> +	.legacy_tiocsti =3D 0,
>> +	.requires_cap =3D false,
>> +	.expected_success =3D -EIO,
>> +}; /* clang-format on */
>> +
>> +/* Helper function to send FD via SCM_RIGHTS */
>> +static int send_fd_via_socket(int socket_fd, int fd_to_send)
>> +{
>> +	struct msghdr msg =3D { 0 };
>> +	struct cmsghdr *cmsg;
>> +	char cmsg_buf[CMSG_SPACE(sizeof(int))];
>> +	char dummy_data =3D =E2=80=99F=E2=80=99;
>> +	struct iovec iov =3D { .iov_base =3D &dummy_data, .iov_len =3D 1 };
>> +
>> +	msg.msg_iov =3D &iov;
>> +	msg.msg_iovlen =3D 1;
>> +	msg.msg_control =3D cmsg_buf;
>> +	msg.msg_controllen =3D sizeof(cmsg_buf);
>> +
>> +	cmsg =3D CMSG_FIRSTHDR(&msg);
>> +	cmsg->cmsg_level =3D SOL_SOCKET;
>> +	cmsg->cmsg_type =3D SCM_RIGHTS;
>> +	cmsg->cmsg_len =3D CMSG_LEN(sizeof(int));
>> +
>> +	memcpy(CMSG_DATA(cmsg), &fd_to_send, sizeof(int));
>> +
>> +	return sendmsg(socket_fd, &msg, 0) < 0 ? -1 : 0;
>> +}
>> +
>> +/* Helper function to receive FD via SCM_RIGHTS */
>> +static int recv_fd_via_socket(int socket_fd)
>> +{
>> +	struct msghdr msg =3D { 0 };
>> +	struct cmsghdr *cmsg;
>> +	char cmsg_buf[CMSG_SPACE(sizeof(int))];
>> +	char dummy_data;
>> +	struct iovec iov =3D { .iov_base =3D &dummy_data, .iov_len =3D 1 };
>> +	int received_fd =3D -1;
>> +
>> +	msg.msg_iov =3D &iov;
>> +	msg.msg_iovlen =3D 1;
>> +	msg.msg_control =3D cmsg_buf;
>> +	msg.msg_controllen =3D sizeof(cmsg_buf);
>> +
>> +	if (recvmsg(socket_fd, &msg, 0) < 0)
>> +		return -1;
>> +
>> +	for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg, cm=
sg)) {
>> +		if (cmsg->cmsg_level `=3D SOL_SOCKET &&
>> +		    cmsg->cmsg_type =3D' SCM_RIGHTS) {
>> +			memcpy(&received_fd, CMSG_DATA(cmsg), sizeof(int));
>> +			break;
>> +		}
>> +	}
>> +
>> +	return received_fd;
>> +}
>> +
>> +static inline bool has_cap_sys_admin(void)
>> +{
>> +	cap_t caps =3D cap_get_proc();
>> +
>> +	if (!caps)
>> +		return false;
>> +
>> +	cap_flag_value_t cap_val;
>> +	bool has_cap =3D (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE,
>> +				     &cap_val) `=3D 0) &&
>> +		       (cap_val =3D' CAP_SET);
>> +
>> +	cap_free(caps);
>> +	return has_cap;
>> +}
>> +
>> +/*
>> + * Drop to nobody user (uid/gid 65534) to lose all capabilities
>> + */
>> +static inline bool drop_to_nobody(struct __test_metadata *_metadata)
>> +{
>> +	ASSERT_EQ(setgroups(0, NULL), 0);
>> +	ASSERT_EQ(setgid(65534), 0);
>> +	ASSERT_EQ(setuid(65534), 0);
>> +
>> +	ASSERT_FALSE(has_cap_sys_admin());
>> +	return true;
>> +}
>> +
>> +static inline int get_legacy_tiocsti_setting(struct __test_metadata *_m=
etadata)
>> +{
>> +	FILE *fp;
>> +	int value =3D -1;
>> +
>> +	fp =3D fopen(=E2=80=9C/proc/sys/dev/tty/legacy_tiocsti=E2=80=9D, =E2=
=80=9Cr=E2=80=9D);
>> +	if (!fp) {
>> +		/* legacy_tiocsti sysctl not available (kernel < 6.2) */
>> +		return -1;
>> +	}
>> +
>> +	if (fscanf(fp, =E2=80=9C%d=E2=80=9D, &value) =3D=3D 1) {
>> +		if (value < 0 || value > 1)
>> +			value =3D -1; /* Invalid value */
>> +	} else {
>> +		value =3D -1; /* Failed to parse */
>> +	}
>> +
>> +	fclose(fp);
>> +	return value;
>> +}
>> +
>> +static inline bool set_legacy_tiocsti_setting(struct __test_metadata *_=
metadata,
>> +					      int value)
>> +{
>> +	FILE *fp;
>> +	bool success =3D false;
>> +
>> +	/* Sanity-check the value */
>> +	ASSERT_GE(value, 0);
>> +	ASSERT_LE(value, 1);
>> +
>> +	/*
>> +	 * Try to open for writing; if we lack permission, return false so
>> +	 * the test harness will skip variants that need to change it
>> +	 */
>> +	fp =3D fopen(=E2=80=9C/proc/sys/dev/tty/legacy_tiocsti=E2=80=9D, =E2=
=80=9Cw=E2=80=9D);
>> +	if (!fp)
>> +		return false;
>> +
>> +	/* Write the new setting */
>> +	if (fprintf(fp, =E2=80=9C%d\n=E2=80=9D, value) > 0)
>> +		success =3D true;
>> +	else
>> +		TH_LOG(=E2=80=9CFailed to write legacy_tiocsti: %s=E2=80=9D, strerror=
(errno));
>> +
>> +	fclose(fp);
>> +	return success;
>
> It=E2=80=99s not very obvious, but actually some write failures are delay=
ed
> until the close. From the man page:
>
> ERRORS
>     =E2=80=A6
>     The fclose() function may also fail and set errno for any of the
>     errors specified for the routines close(2), write(2), or fflush(3).
>
> You=E2=80=99ll need to check both the fprintf and the fclose. Probably as:
>
> 	if (fprintf(fp, =E2=80=9C%d\n=E2=80=9D, value) > 0 && fclose(fp))
> 		success =3D true;
> 	else
> 		TH_LOG(=E2=80=9CFailed to write legacy_tiocsti: %s=E2=80=9D, strerror(e=
rrno));
> 	return success;
>
>> +}
>> +
>> +/*
>> + * TIOCSTI injection test function
>> + * @tty_fd: TTY slave file descriptor to test TIOCSTI on
>> + * Returns: 0 on success, -errno on failure
>> + */
>> +static inline int test_tiocsti_injection(struct __test_metadata *_metad=
ata,
>> +					 int tty_fd)
>> +{
>> +	int ret;
>> +	char inject_char =3D =E2=80=99V=E2=80=99;
>> +
>> +	errno =3D 0;
>> +	ret =3D ioctl(tty_fd, TIOCSTI, &inject_char);
>> +	return ret =3D=3D 0 ? 0 : -errno;
>> +}
>> +
>> +FIXTURE_SETUP(tiocsti)
>> +{
>> +	/* Create PTY pair for basic tests */
>> +	self->has_pty =3D (openpty(&self->pty_master_fd, &self->pty_slave_fd,
>> +				 NULL, NULL, NULL) =3D=3D 0);
>> +	if (!self->has_pty) {
>> +		self->pty_master_fd =3D -1;
>> +		self->pty_slave_fd =3D -1;
>> +	}
>> +
>> +	self->initial_cap_sys_admin =3D has_cap_sys_admin();
>> +	self->original_legacy_tiocsti_setting =3D
>> +		get_legacy_tiocsti_setting(_metadata);
>> +
>> +	if (self->original_legacy_tiocsti_setting < 0)
>> +		SKIP(return, =E2=80=9Clegacy_tiocsti sysctl not available (kernel < 6=
.2)=E2=80=9D);
>> +
>> +	/* Test if we can modify the sysctl (requires appropriate privileges) =
*/
>> +	self->can_modify_sysctl =3D set_legacy_tiocsti_setting(_metadata,
>> +							     self->original_legacy_tiocsti_setting);
>> +	if (!self->can_modify_sysctl)
>> +		TH_LOG(=E2=80=9CWarning: Cannot modify legacy_tiocsti sysctl - will s=
kip mismatched variants=E2=80=9D);
>> +}
>> +
>> +FIXTURE_TEARDOWN(tiocsti)
>> +{
>> +	/*
>> +	 * Backup restoration -
>> +	 * each test should restore its own sysctl changes
>> +	 */
>> +	if (self->can_modify_sysctl &&
>> +	    self->original_legacy_tiocsti_setting >=3D 0) {
>> +		int current_value =3D get_legacy_tiocsti_setting(_metadata);
>> +
>> +		if (current_value !=3D self->original_legacy_tiocsti_setting) {
>> +			TH_LOG(=E2=80=9CBackup: Restoring legacy_tiocsti from %d to %d=E2=80=
=9D,
>> +			       current_value,
>> +			       self->original_legacy_tiocsti_setting);
>> +			set_legacy_tiocsti_setting(_metadata,
>> +				self->original_legacy_tiocsti_setting);
>> +		}
>
> This =E2=80=9Cset the value if it=E2=80=99s different=E2=80=9D logic here=
 is mostly duplicated
> below; probably better to have a helper for doing this. It can also be
> aware of the value (since you read it during SETUP), so you may not need
> the triple read (once in SETUP, once in test, once in TEARDOWN). Though
> it doesn=E2=80=99t really hurt anything to do the read/check/write cycle =
here
> either. Up to you!
>
>> +	}
>> +
>> +	if (self->has_pty) {
>> +		if (self->pty_master_fd >=3D 0)
>> +			close(self->pty_master_fd);
>> +		if (self->pty_slave_fd >=3D 0)
>> +			close(self->pty_slave_fd);
>> +	}
>> +}
>> +
>> +TEST_F(tiocsti, test)
>> +{
>> +	int saved_legacy_tiocsti =3D get_legacy_tiocsti_setting(_metadata);
>> +	bool need_restore =3D false;
>> +	int status;
>> +	pid_t child_pid;
>> +
>> +	/* Set legacy_tiocsti sysctl to match variant requirement */
>> +	if (self->can_modify_sysctl) {
>> +		if (saved_legacy_tiocsti !=3D variant->legacy_tiocsti) {
>> +			if (!set_legacy_tiocsti_setting(_metadata,
>> +					variant->legacy_tiocsti)) {
>> +				SKIP(return,
>> +				     =E2=80=9CFailed to set legacy_tiocsti sysctl=E2=80=9D);
>> +			}
>> +			need_restore =3D true;
>
> You don=E2=80=99t need to handle the restore since TEARDOWN will do it, y=
es?
>
>> +		}
>> +	} else {
>> +		/*
>> +		 * Can=E2=80=99t modify sysctl
>> +		 * - check if current value matches variant
>> +		 */
>> +		if (self->original_legacy_tiocsti_setting !=3D
>> +		    variant->legacy_tiocsti) {
>> +			SKIP(return,
>> +			    =E2=80=9Clegacy_tiocsti setting mismatch and cannot modify sysct=
l=E2=80=9D);
>> +		}
>
> I feel like both the set and this check should be part of SETUP instead?
> All variants have a legacy_tiocsti setting, so better to put common
> setup code in the SETUP.
>
>> +	}
>> +
>> +	/* Common skip conditions */
>> +	if (variant->test_type `=3D TEST_PTY_TIOCSTI_BASIC && !self->has_pty) {
>> +		SKIP(goto restore_sysctl,
>> +		     "PTY not available for controlling terminal test");
>> +	}
>> +
>> +	if (variant->test_type =3D' TEST_PTY_TIOCSTI_FD_PASSING &&
>> +	    !self->initial_cap_sys_admin) {
>> +		SKIP(goto restore_sysctl,
>> +		     =E2=80=9CFD Pass tests require CAP_SYS_ADMIN=E2=80=9D);
>> +	}
>> +
>> +	if (variant->requires_cap && !self->initial_cap_sys_admin) {
>> +		SKIP(goto restore_sysctl,
>> +		     =E2=80=9CTest requires initial CAP_SYS_ADMIN=E2=80=9D);
>> +	}
>
> Same for all of these: they do a skip, which should work from SETUP. And
> they can be done before sysctl changing, so they can just do a return.
> (A skipped SETUP will, I think, still call TEARDOWN.)
>
>> +	if (variant->test_type =3D=3D TEST_PTY_TIOCSTI_BASIC) {
>
> variants within variants. ;)
>
> I would lift the fork logic out of the if/else, and then put the bodies
> of each in a separate function (pass in the metadata and the pid).
> That=E2=80=99ll make these more readable instead of be heavily indented.
>
>
>> +		/* `=3D=3D=3D' BASIC TIOCSTI TEST `=3D=3D=3D' */
>> +		child_pid =3D fork();
>> +		ASSERT_GE(child_pid, 0);
>> +
>> +		if (child_pid =3D=3D 0) {
>> +			/* Child process - perform the actual test */
>> +
>> +			/* Handle capability requirements */
>> +			if (self->initial_cap_sys_admin &&
>> +			    !variant->requires_cap)
>> +				ASSERT_TRUE(drop_to_nobody(_metadata));
>> +
>> +			if (variant->controlling_tty) {
>> +				/*
>> +				 * Create new session and set PTY as
>> +				 * controlling terminal
>> +				 */
>> +				pid_t sid =3D setsid();
>> +
>> +				ASSERT_GE(sid, 0);
>> +				ASSERT_EQ(ioctl(self->pty_slave_fd, TIOCSCTTY,
>> +						0),
>> +					  0);
>
> which avoids this kind of weird =E2=80=9Coh no I=E2=80=99m almost at 80 c=
haracters=E2=80=9D
> stuff above.
>
>> +			}
>> +
>> +			/*
>> +			 * Validate test environment setup and verify final
>> +			 * capability state matches expectation
>> +			 * after potential drop.
>> +			 *
>> +			 */
>> +			ASSERT_TRUE(self->has_pty);
>> +			ASSERT_EQ(has_cap_sys_admin(), variant->requires_cap);
>> +
>> +			/* Test TIOCSTI and validate result */
>> +			int result =3D test_tiocsti_injection(_metadata,
>> +							    self->pty_slave_fd);
>> +
>> +			/* Check against expected result from variant */
>> +			EXPECT_EQ(result, variant->expected_success);
>> +			_exit(0);
>> +		}
>> +
>> +	} else {
>> +		/* `=3D=3D=3D' FD PASSING SECURITY TEST `=3D=3D=3D' */
>> +		int sockpair[2];
>> +
>> +		ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sockpair), 0);
>> +
>> +		child_pid =3D fork();
>> +		ASSERT_GE(child_pid, 0);
>> +
>> +		if (child_pid =3D=3D 0) {
>> +			/* Child process - create PTY and send FD */
>> +			close(sockpair[0]);
>> +			signal(SIGHUP, SIG_IGN);
>> +
>> +			/* Handle privilege dropping */
>> +			if (!variant->requires_cap && has_cap_sys_admin())
>> +				ASSERT_TRUE(drop_to_nobody(_metadata));
>> +
>> +			/* Create child=E2=80=99s PTY */
>> +			int child_master_fd, child_slave_fd;
>> +
>> +			ASSERT_EQ(openpty(&child_master_fd, &child_slave_fd,
>> +					  NULL, NULL, NULL),
>> +				  0);
>> +
>> +			if (variant->controlling_tty) {
>> +				pid_t sid =3D setsid();
>> +
>> +				ASSERT_GE(sid, 0);
>> +				ASSERT_EQ(ioctl(child_slave_fd, TIOCSCTTY, 0),
>> +					  0);
>> +			}
>> +
>> +			/* Test child=E2=80=99s direct TIOCSTI for reference */
>> +			int direct_result =3D test_tiocsti_injection(_metadata,
>> +								   child_slave_fd);
>> +			EXPECT_EQ(direct_result, variant->expected_success);
>> +
>> +			/* Send FD to parent */
>> +			ASSERT_EQ(send_fd_via_socket(sockpair[1],
>> +						     child_slave_fd),
>> +				  0);
>> +
>> +			/* Wait for parent completion signal */
>> +			char sync_byte;
>> +			ssize_t bytes_read =3D read(sockpair[1], &sync_byte, 1);
>> +
>> +			ASSERT_EQ(bytes_read, 1);
>> +
>> +			close(child_master_fd);
>> +			close(child_slave_fd);
>> +			close(sockpair[1]);
>> +			_exit(0);
>> +		}
>> +
>> +		/* Parent process - receive FD and test TIOCSTI */
>> +		close(sockpair[1]);
>> +
>> +		int received_fd =3D recv_fd_via_socket(sockpair[0]);
>> +
>> +		ASSERT_GE(received_fd, 0);
>> +
>> +		bool parent_has_cap =3D self->initial_cap_sys_admin;
>> +
>> +		TH_LOG(=E2=80=9C`=3D' TIOCSTI FD Passing Test Context `=3D'=E2=80=9D);
>> +		TH_LOG(=E2=80=9Clegacy_tiocsti: %d, Parent CAP_SYS_ADMIN: %s, Child: =
%s=E2=80=9D,
>> +		       variant->legacy_tiocsti, parent_has_cap ? =E2=80=9Cyes=E2=80=
=9D : =E2=80=9Cno=E2=80=9D,
>> +		       variant->requires_cap ? =E2=80=9Ckept=E2=80=9D : =E2=80=9Cdrop=
ped=E2=80=9D);
>> +
>> +		/* SECURITY TEST: Try TIOCSTI with FD opened by child */
>> +		int result =3D test_tiocsti_injection(_metadata, received_fd);
>> +
>> +		/* Log security concern if demonstrated */
>> +		if (result =3D=3D 0 && !variant->requires_cap) {
>> +			TH_LOG("*** SECURITY CONCERN DEMONSTRATED ***=E2=80=9C);
>> +			TH_LOG(=E2=80=9DPrivileged parent can use TIOCSTI on FD from unprivi=
leged child=E2=80=9C);
>> +			TH_LOG(=E2=80=9DThis shows current process credentials are used, not=
 opener credentials=E2=80=9C);
>> +		}
>> +
>> +		EXPECT_EQ(result, variant->expected_success)
>> +		{
>> +			TH_LOG(=E2=80=9DFD passing: expected error %d, got %d=E2=80=9C,
>> +			       variant->expected_success, result);
>> +		}
>> +
>> +		/* Signal child completion */
>> +		char sync_byte =3D =E2=80=98D=E2=80=99;
>> +		ssize_t bytes_written =3D write(sockpair[0], &sync_byte, 1);
>> +
>> +		ASSERT_EQ(bytes_written, 1);
>> +
>> +		close(received_fd);
>> +		close(sockpair[0]);
>> +	}
>> +
>> +	/* Common child process cleanup for both test types */
>> +	ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
>> +
>> +	if (WIFSIGNALED(status)) {
>> +		TH_LOG(=E2=80=9DChild terminated by signal %d=E2=80=9C, WTERMSIG(stat=
us));
>> +		ASSERT_FALSE(WIFSIGNALED(status))
>> +		{
>> +			TH_LOG(=E2=80=9DChild process failed assertion");
>> +		}
>> +	} else {
>> +		EXPECT_EQ(WEXITSTATUS(status), 0);
>> +	}
>> +
>> +restore_sysctl:
>> +	if (need_restore)
>> +		set_legacy_tiocsti_setting(_metadata, saved_legacy_tiocsti);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>
> Thanks for chipping away at this! :)
>
> -Kees

Thanks for the feedback!

I wasn=E2=80=99t sure if you could use fixture data inside setup and teardo=
wn.
But apparently we can[1]. I have addressed the fclose() error handling,
moved setup skip logic to FIXTURE_SETUP() and addressed all other
changes in v4.

-Abhinav

[1] - tools/testing/selftests/kselftest_harness/harness-selftest.c

--=-=-=--

