Return-Path: <linux-kselftest+bounces-42562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4CBA79D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 02:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A327A6E6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E04A07;
	Mon, 29 Sep 2025 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqXF2gmt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F383FF1
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759104385; cv=none; b=qaKC+rAZ/cEecC/WqdTiP9U9DxjXUepgvBwnVJJhFaf59Wnq1Fpm/qckVG0L1mU6rL8RFsWBA3nWN9zAsAkwuKQRWRqEWLti4o3mjEuuguHnG4OEqBxs3cz4CUZUIR7uF5eSTlTLk5D7B44dfKU3GDSZuY03dUOxLHPU7sRng2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759104385; c=relaxed/simple;
	bh=d2QvFCSUfe+Fp+M6nQLGLPWHY2SCA5gNT2dUY1nN8nk=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=cxi3WhabKgqFLmT8P2npxWCmiVSSSF3/TrWYaMDFumm5FDL0557FOpSzBU9nDgane4LWtkIl1uuV7owA/px6/IEXtzFs8+9FX3UpXWr2YUrwfVFD978JK9uXYnSVquxUQHLsEYE33mWqJjoKt04tla9/L940PDODdv3wkvfnGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqXF2gmt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so559366a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Sep 2025 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759104382; x=1759709182; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9d16OjcTsBmIwTgXwPK+sgRWZxZSJXVdCuiKPgCoeY=;
        b=AqXF2gmta+fa4a2MKBYxATiB0ypNBOdeGYxiPPQ+0GfYQIfGvf9LtaIuvj5LI28iP7
         iSIwzK8nl3Pq+HY8uPnNdOnjapZaGXxNfcPzP9us5yos6/b2M+TQMkTtqvyUNyqoSb7T
         fhQXRLXroaXA/hYkl7d4I4W1edAUGVTNG89UnayQMiGAhL17KtRhYg2XqpH/LNRi3i8w
         4l17kajx7AHZMBKqty/qwzVGke8OEauTk4bLq+luJefAosySe5nBfIn2oQsgnuG+LsAM
         CIG4ajv1sy5eeaGFRccO5lGghzuQGLUgHYjws9Ao+ycilH1yFtKJLW/NVM+mwo9bSgVe
         DXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759104382; x=1759709182;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9d16OjcTsBmIwTgXwPK+sgRWZxZSJXVdCuiKPgCoeY=;
        b=otU7Yppm2aQ1XrbPgy+9myA4DdRgOHU+2l07KoIB9ZO6DBNoyHRtX81yi34VvcXP2h
         7qDRvK2jEL1n0x6dEwRHXHEH0AOWEKz6o9PhrQfi/YeygcYIql09B55UU1vaRtqRpmkJ
         n3NCB5t5GAJyW6nEWIv7uOOlvJ+zeMuG9XbF+Sw+CWgUdvuZJIJPa67LbS2cYrKELo/E
         qn3a3cOqSWgCqDTO28NEHbtmsiLMYCck3JFYMXaae+INmtwd+flnsZNzvW6RHfuFdMWr
         Jlq4JdOTzMMN8MDeAc9Kjs684aCIQcb29p7VkIKSL1jYxkbV0fJotZ8Pu9Elrp/WxK8a
         QBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiOi1rg+gLorUtxrS+TjALsayivoy0kYBB5jWdW+eaD4MCIemzRiiOl0NAWCydyvyYZdGzflfkO0WZIqJlqGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMa4acLtHotM8SaZnIlnjHisPWjsySaeLhCzEFLGOst2hFPPok
	YodhAPybmxjyNwXGI5kXU1GNlGN6vNjYLVpspnY1Jb/PdCqNrcuaeFA2
X-Gm-Gg: ASbGnct0lzngE0iNVSCaoT79MMdGdw+9VV/v9XFhHRkRF5Q1nfVUGeqiJpmaIcgtWE4
	HGZjohb+/UEWlPWFsmsZ68CQZDH1J8vU4BVn92ZXxCt5saVbAglpsek9kykXRAI8ya3tK0rjsl5
	2sU8Zvrlo/y7KMpDGiIL1D36aBTlNiX1TLw5tU99kcLfzclCTW1rEMreyc8EMbLMan6xFhIioWb
	Z1I6pqLC7Bpv8UYctn9ga+FT7eDXvm+Y6fM8bgjwdRdNqY3CjPYEokjxvtEaMI6uAuKQqD1L9/j
	ZnMps6iZIIihtMFddL/kgBywGU6ww5+N6f5bxU1MJVkxhv8cjGW9M/VFLt0keWry8mQrioQzCAM
	tj0gDzSY2Y+KIL8aHv+vdvejTftVHo+T8Dw==
X-Google-Smtp-Source: AGHT+IE/D0XyEIZodoNhI7sLk75vJYfy3zHDsDKPd1gidLDEqKMqJvyxvqI9UN2FdcdnKRfXCUCUxg==
X-Received: by 2002:a17:903:5c6:b0:27c:3b07:5812 with SMTP id d9443c01a7336-27ed4a31712mr108415345ad.36.1759104382210;
        Sun, 28 Sep 2025 17:06:22 -0700 (PDT)
Received: from 1337 ([136.159.213.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27eed0961b1sm82000685ad.50.2025.09.28.17.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 17:06:21 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Paul Moore
 <paul@paul-moore.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH RESEND v4] selftests/tty: add TIOCSTI test suite
Date: Sun, 28 Sep 2025 18:00:19 -0600
References: <20250903-toicsti-bug-v4-1-4894b6649ef8@gmail.com>
User-agent: mu4e 1.10.8; emacs 30.2
In-reply-to: <20250903-toicsti-bug-v4-1-4894b6649ef8@gmail.com>
Message-ID: <877bxi2kcj.fsf@gmail.com>
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

Abhinav Saxena <xandfury@gmail.com> writes:

> TIOCSTI is a TTY ioctl command that allows inserting characters into
> the terminal input queue, making it appear as if the user typed those
> characters. This functionality has behavior that varies based on system
> configuration and process credentials.
>
> The dev.tty.legacy_tiocsti sysctl introduced in commit 83efeeeb3d04
> (=E2=80=9Ctty: Allow TIOCSTI to be disabled=E2=80=9D) controls TIOCSTI us=
age. When
> disabled, TIOCSTI requires CAP_SYS_ADMIN capability.
>
> The current implementation checks the current process=E2=80=99s credentia=
ls via
> capable(CAP_SYS_ADMIN), but does not validate against the file opener=E2=
=80=99s
> credentials stored in file->f_cred. This creates different behavior when
> file descriptors are passed between processes via SCM_RIGHTS.
>
> Add a test suite with 16 test variants using fixture variants to verify
> TIOCSTI behavior when dev.tty.legacy_tiocsti is enabled/disabled:
>
> - Basic TIOCSTI tests (8 variants): Direct testing with different
>   capability and controlling terminal combinations
> - FD passing tests (8 variants): Test behavior when file descriptors
>   are passed between processes with different capabilities
>
> The FD passing tests document this behavior - some tests show different
> results than expected based on file opener credentials, demonstrating
> that TIOCSTI uses current process credentials rather than file opener
> credentials.
>
> The tests validate proper enforcement of the legacy_tiocsti sysctl. Test
> implementation uses openpty(3) with TIOCSCTTY for isolated PTY
> environments. See tty_ioctl(4) for details on TIOCSTI behavior and
> security requirements.
>
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> =E2=80=94
> RESEND: add TTY/serial maintainers and linux-serial CCs. No code changes.
> - Link to orignal v4: <https://lore.kernel.org/r/20250902-toicsti-bug-v4-=
1-e5c960e0b3d6@gmail.com>
>
> Changes in v4:
> - Moved skip conditions and sysctl setup from TEST_F to FIXTURE_SETUP (Ke=
es Cook)
> - Fixed fclose() error handling in set_legacy_tiocsti_setting (Kees Cook)
> - Extracted run_basic_tiocsti_test() and run_fdpass_tiocsti_test function=
s (Kees Cook)
> - Removed redundant sysctl restore logic from TEST_F (Kees Cook)
> - Simplified FIXTURE_TEARDOWN (Kees Cook)
> - Replace drop_to_nobody() to drop_all_privs() which should be more porta=
ble (Justin Stitt)
> - Link to v3: <https://lore.kernel.org/r/20250730-toicsti-bug-v3-1-dd2dac=
97f27a@gmail.com>
>
> Add selftests for TIOCSTI ioctl
>
> To run all tests:
> $ sudo ./tools/testing/selftests/tty/tty_tiocsti_test
>
> Test Results:
> - PASSED: 13/16 tests
> - Different behavior: 3/16 tests (documenting credential checking behavio=
r)
>
> All tests validated using:
> - scripts/checkpatch.pl =E2=80=93strict (clean output)
> - Functional testing on kernel v6.16-rc2
>
> Changes in v3:
> - Replaced all printf() calls with TH_LOG() for proper test logging (Kees=
 Cook)
> - Added struct __test_metadata parameter to helper functions
> - Moved common legacy_tiocsti availability check to FIXTURE_SETUP()
> - Implemented sysctl modification/restoration in FIXTURE_SETUP/TEARDOWN
> - Used openpty() with TIOCSCTTY for reliable PTY testing environment
> - Fixed child/parent synchronization in FD passing tests
> - Replaced manual _exit(1) handling with proper ASSERT statements
> - Switched // comments to /* */ format throughout
> - Expanded to 16 test variants using fixture variants
> - Enhanced error handling and test reliability
> - Link to v2: <https://lore.kernel.org/r/20250713-toicsti-bug-v2-1-b18378=
7eea29@gmail.com>
> - Link to v1: <https://lore.kernel.org/r/20250622-toicsti-bug-v1-0-f37437=
3b04b2@gmail.com>
>
> References:
> - tty_ioctl(4) - documents TIOCSTI ioctl and capability requirements
> - openpty(3) - pseudo-terminal creation and management
> - commit 83efeeeb3d04 (=E2=80=9Ctty: Allow TIOCSTI to be disabled=E2=80=
=9D)
> - Documentation/security/credentials.rst
> - <https://github.com/KSPP/linux/issues/156>
> - <https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad/>
> - drivers/tty/Kconfig
> - Documentation/driver-api/tty/
> =E2=80=94
>  tools/testing/selftests/tty/Makefile           |   6 +-
>  tools/testing/selftests/tty/config             |   1 +
>  tools/testing/selftests/tty/tty_tiocsti_test.c | 650 +++++++++++++++++++=
++++++
>  3 files changed, 656 insertions(+), 1 deletion(-)
>
> diff =E2=80=93git a/tools/testing/selftests/tty/Makefile b/tools/testing/=
selftests/tty/Makefile
> index 50d7027b2ae3fb495dd1c0684363fa8f426be42c..7f6fbe5a0cd5663310e334d9d=
068b21dab9136ec 100644
> =E2=80=94 a/tools/testing/selftests/tty/Makefile
> +++ b/tools/testing/selftests/tty/Makefile
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS =3D -O2 -Wall
> -TEST_GEN_PROGS :=3D tty_tstamp_update
> +TEST_GEN_PROGS :=3D tty_tstamp_update tty_tiocsti_test
> +LDLIBS +=3D -lcap
>=20=20
>  include ../lib.mk
> +
> +# Add libcap for TIOCSTI test
> +$(OUTPUT)/tty_tiocsti_test: LDLIBS +=3D -lcap
> diff =E2=80=93git a/tools/testing/selftests/tty/config b/tools/testing/se=
lftests/tty/config
> new file mode 100644
> index 0000000000000000000000000000000000000000..c6373aba66366c82435bb26c0=
19eb360eb6310eb
> =E2=80=94 /dev/null
> +++ b/tools/testing/selftests/tty/config
> @@ -0,0 +1 @@
> +CONFIG_LEGACY_TIOCSTI=3Dy
> diff =E2=80=93git a/tools/testing/selftests/tty/tty_tiocsti_test.c b/tool=
s/testing/selftests/tty/tty_tiocsti_test.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..5e767e6cb3ef8f05c5430eb0f=
cc792064c446c03
> =E2=80=94 /dev/null
> +++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TTY Tests - TIOCSTI
> + *
> + * Copyright =C2=A9 2025 Abhinav Saxena <xandfury@gmail.com>
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <sys/wait.h>
> +#include <pwd.h>
> +#include <termios.h>
> +#include <grp.h>
> +#include <sys/capability.h>
> +#include <sys/prctl.h>
> +#include <pty.h>
> +#include <utmp.h>
> +
> +#include =E2=80=9C../kselftest_harness.h=E2=80=9D
> +
> +enum test_type {
> +	TEST_PTY_TIOCSTI_BASIC,
> +	TEST_PTY_TIOCSTI_FD_PASSING,
> +	/* other tests cases such as serial may be added. */
> +};
> +
> +/*
> + * Test Strategy:
> + * - Basic tests: Use PTY with/without TIOCSCTTY (controlling terminal f=
or
> + *   current process)
> + * - FD passing tests: Child creates PTY, parent receives FD (demonstrat=
es
> + *   security issue)
> + *
> + * SECURITY VULNERABILITY DEMONSTRATION:
> + * FD passing tests show that TIOCSTI uses CURRENT process credentials, =
not
> + * opener credentials. This means privileged processes can be given FDs =
from
> + * unprivileged processes and successfully perform TIOCSTI operations th=
at the
> + * unprivileged process couldn=E2=80=99t do directly.
> + *
> + * Attack scenario:
> + * 1. Unprivileged process opens TTY (direct TIOCSTI fails due to lack of
> + *    privileges)
> + * 2. Unprivileged process passes FD to privileged process via SCM_RIGHTS
> + * 3. Privileged process can use TIOCSTI on the FD (succeeds due to its
> + *    privileges)
> + * 4. Result: Effective privilege escalation via file descriptor passing
> + *
> + * This matches the kernel logic in tiocsti():
> + * 1. if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN)) return -EIO;
> + * 2. if ((current->signal->tty !=3D tty) && !capable(CAP_SYS_ADMIN))
> + *        return -EPERM;
> + * Note: Both checks use capable() on CURRENT process, not FD opener!
> + *
> + * If the file credentials were also checked along with the capable() ch=
ecks
> + * then the results for FD pass tests would be consistent with the basic=
 tests.
> + */
> +
> +FIXTURE(tiocsti)
> +{
> +	int pty_master_fd; /* PTY - for basic tests */
> +	int pty_slave_fd;
> +	bool has_pty;
> +	bool initial_cap_sys_admin;
> +	int original_legacy_tiocsti_setting;
> +	bool can_modify_sysctl;
> +};
> +
> +FIXTURE_VARIANT(tiocsti)
> +{
> +	const enum test_type test_type;
> +	const bool controlling_tty; /* true=3Dcurrent->signal->tty `=3D tty */
> +	const int legacy_tiocsti; /* 0=3Drestricted, 1=3Dpermissive */
> +	const bool requires_cap; /* true=3Dwith CAP_SYS_ADMIN, false=3Dwithout =
*/
> +	const int expected_success; /* 0=3Dsuccess, -EIO/-EPERM=3Dspecific erro=
r */
> +};
> +
> +/*
> + * Tests Controlling Terminal Variants (current->signal->tty =3D' tty)
> + *
> + * TIOCSTI Test Matrix:
> + *
> + * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
> + * |=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-|=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94|=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=93|=E2=80=94=E2=80=94-|
> + * | 1 (permissive) | true          | SUCCESS         | -     |
> + * | 1 (permissive) | false         | SUCCESS         | -     |
> + * | 0 (restricted) | true          | SUCCESS         | -     |
> + * | 0 (restricted) | false         | FAILURE         | -EIO  |
> + */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D false,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D false,
> +	.expected_success =3D -EIO, /* FAILURE: legacy restriction */
> +}; /* clang-format on */
> +
> +/*
> + * Note for FD Passing Test Variants
> + * Since we=E2=80=99re testing the scenario where an unprivileged proces=
s pass an FD
> + * to a privileged one, .requires_cap here means the caps of the child p=
rocess.
> + * Not the parent; parent would always be privileged.
> + */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D false,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D true,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D false,
> +	.expected_success =3D -EIO,
> +}; /* clang-format on */
> +
> +/*
> + * Non-Controlling Terminal Variants (current->signal->tty !=3D tty)
> + *
> + * TIOCSTI Test Matrix:
> + *
> + * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
> + * |=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-|=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94|=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=93|=E2=80=94=E2=80=94-|
> + * | 1 (permissive) | true          | SUCCESS         | -     |
> + * | 1 (permissive) | false         | FAILURE         | -EPERM|
> + * | 0 (restricted) | true          | SUCCESS         | -     |
> + * | 0 (restricted) | false         | FAILURE         | -EIO  |
> + */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D false,
> +	.expected_success =3D -EPERM,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D false,
> +	.expected_success =3D -EIO,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 1,
> +	.requires_cap =3D false,
> +	.expected_success =3D -EPERM,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_withcap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D true,
> +	.expected_success =3D 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_nocap) {
> +	.test_type =3D TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty =3D false,
> +	.legacy_tiocsti =3D 0,
> +	.requires_cap =3D false,
> +	.expected_success =3D -EIO,
> +}; /* clang-format on */
> +
> +/* Helper function to send FD via SCM_RIGHTS */
> +static int send_fd_via_socket(int socket_fd, int fd_to_send)
> +{
> +	struct msghdr msg =3D { 0 };
> +	struct cmsghdr *cmsg;
> +	char cmsg_buf[CMSG_SPACE(sizeof(int))];
> +	char dummy_data =3D =E2=80=99F=E2=80=99;
> +	struct iovec iov =3D { .iov_base =3D &dummy_data, .iov_len =3D 1 };
> +
> +	msg.msg_iov =3D &iov;
> +	msg.msg_iovlen =3D 1;
> +	msg.msg_control =3D cmsg_buf;
> +	msg.msg_controllen =3D sizeof(cmsg_buf);
> +
> +	cmsg =3D CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level =3D SOL_SOCKET;
> +	cmsg->cmsg_type =3D SCM_RIGHTS;
> +	cmsg->cmsg_len =3D CMSG_LEN(sizeof(int));
> +
> +	memcpy(CMSG_DATA(cmsg), &fd_to_send, sizeof(int));
> +
> +	return sendmsg(socket_fd, &msg, 0) < 0 ? -1 : 0;
> +}
> +
> +/* Helper function to receive FD via SCM_RIGHTS */
> +static int recv_fd_via_socket(int socket_fd)
> +{
> +	struct msghdr msg =3D { 0 };
> +	struct cmsghdr *cmsg;
> +	char cmsg_buf[CMSG_SPACE(sizeof(int))];
> +	char dummy_data;
> +	struct iovec iov =3D { .iov_base =3D &dummy_data, .iov_len =3D 1 };
> +	int received_fd =3D -1;
> +
> +	msg.msg_iov =3D &iov;
> +	msg.msg_iovlen =3D 1;
> +	msg.msg_control =3D cmsg_buf;
> +	msg.msg_controllen =3D sizeof(cmsg_buf);
> +
> +	if (recvmsg(socket_fd, &msg, 0) < 0)
> +		return -1;
> +
> +	for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg, cms=
g)) {
> +		if (cmsg->cmsg_level `=3D SOL_SOCKET &&
> +		    cmsg->cmsg_type =3D' SCM_RIGHTS) {
> +			memcpy(&received_fd, CMSG_DATA(cmsg), sizeof(int));
> +			break;
> +		}
> +	}
> +
> +	return received_fd;
> +}
> +
> +static inline bool has_cap_sys_admin(void)
> +{
> +	cap_t caps =3D cap_get_proc();
> +
> +	if (!caps)
> +		return false;
> +
> +	cap_flag_value_t cap_val;
> +	bool has_cap =3D (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE,
> +				     &cap_val) `=3D 0) &&
> +		       (cap_val =3D' CAP_SET);
> +
> +	cap_free(caps);
> +	return has_cap;
> +}
> +
> +/*
> + * Switch to non-root user and clear all capabilities
> + */
> +static inline bool drop_all_privs(struct __test_metadata *_metadata)
> +{
> +	/* Drop supplementary groups */
> +	ASSERT_EQ(setgroups(0, NULL), 0);
> +
> +	/* Switch to non-root user */
> +	ASSERT_EQ(setgid(1000), 0);
> +	ASSERT_EQ(setuid(1000), 0);
> +
> +	/* Clear all capabilities */
> +	cap_t empty =3D cap_init();
> +
> +	ASSERT_NE(empty, NULL);
> +	ASSERT_EQ(cap_set_proc(empty), 0);
> +	cap_free(empty);
> +
> +	/* Prevent privilege regain */
> +	ASSERT_EQ(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0), 0);
> +
> +	/* Verify privilege drop */
> +	ASSERT_FALSE(has_cap_sys_admin());
> +	return true;
> +}
> +
> +static inline int get_legacy_tiocsti_setting(struct __test_metadata *_me=
tadata)
> +{
> +	FILE *fp;
> +	int value =3D -1;
> +
> +	fp =3D fopen(=E2=80=9C/proc/sys/dev/tty/legacy_tiocsti=E2=80=9D, =E2=80=
=9Cr=E2=80=9D);
> +	if (!fp) {
> +		/* legacy_tiocsti sysctl not available (kernel < 6.2) */
> +		return -1;
> +	}
> +
> +	if (fscanf(fp, =E2=80=9C%d=E2=80=9D, &value) `=3D 1 && fclose(fp) =3D' =
0) {
> +		if (value < 0 || value > 1)
> +			value =3D -1; /* Invalid value */
> +	} else {
> +		value =3D -1; /* Failed to parse */
> +	}
> +
> +	return value;
> +}
> +
> +static inline bool set_legacy_tiocsti_setting(struct __test_metadata *_m=
etadata,
> +					      int value)
> +{
> +	FILE *fp;
> +	bool success =3D false;
> +
> +	/* Sanity-check the value */
> +	ASSERT_GE(value, 0);
> +	ASSERT_LE(value, 1);
> +
> +	/*
> +	 * Try to open for writing; if we lack permission, return false so
> +	 * the test harness will skip variants that need to change it
> +	 */
> +	fp =3D fopen(=E2=80=9C/proc/sys/dev/tty/legacy_tiocsti=E2=80=9D, =E2=80=
=9Cw=E2=80=9D);
> +	if (!fp)
> +		return false;
> +
> +	/* Write the new setting */
> +	if (fprintf(fp, =E2=80=9C%d\n=E2=80=9D, value) > 0 && fclose(fp) =3D=3D=
 0)
> +		success =3D true;
> +	else
> +		TH_LOG(=E2=80=9CFailed to write legacy_tiocsti: %s=E2=80=9D, strerror(=
errno));
> +
> +	return success;
> +}
> +
> +/*
> + * TIOCSTI injection test function
> + * @tty_fd: TTY slave file descriptor to test TIOCSTI on
> + * Returns: 0 on success, -errno on failure
> + */
> +static inline int test_tiocsti_injection(struct __test_metadata *_metada=
ta,
> +					 int tty_fd)
> +{
> +	int ret;
> +	char inject_char =3D =E2=80=99V=E2=80=99;
> +
> +	errno =3D 0;
> +	ret =3D ioctl(tty_fd, TIOCSTI, &inject_char);
> +	return ret =3D=3D 0 ? 0 : -errno;
> +}
> +
> +/*
> + * Child process: test TIOCSTI directly with capability/controlling
> + * terminal setup
> + */
> +static void run_basic_tiocsti_test(struct __test_metadata *_metadata,
> +				   FIXTURE_DATA(tiocsti) * self,
> +				   const FIXTURE_VARIANT(tiocsti) * variant)
> +{
> +	/* Handle capability requirements */
> +	if (self->initial_cap_sys_admin && !variant->requires_cap)
> +		ASSERT_TRUE(drop_all_privs(_metadata));
> +
> +	if (variant->controlling_tty) {
> +		/*
> +		 * Create new session and set PTY as
> +		 * controlling terminal
> +		 */
> +		pid_t sid =3D setsid();
> +
> +		ASSERT_GE(sid, 0);
> +		ASSERT_EQ(ioctl(self->pty_slave_fd, TIOCSCTTY, 0), 0);
> +	}
> +
> +	/*
> +	 * Validate test environment setup and verify final
> +	 * capability state matches expectation
> +	 * after potential drop.
> +	 */
> +	ASSERT_TRUE(self->has_pty);
> +	ASSERT_EQ(has_cap_sys_admin(), variant->requires_cap);
> +
> +	/* Test TIOCSTI and validate result */
> +	int result =3D test_tiocsti_injection(_metadata, self->pty_slave_fd);
> +
> +	/* Check against expected result from variant */
> +	EXPECT_EQ(result, variant->expected_success);
> +	_exit(0);
> +}
> +
> +/*
> + * Child process: create PTY and then pass FD to parent via SCM_RIGHTS
> + */
> +static void run_fdpass_tiocsti_test(struct __test_metadata *_metadata,
> +				    const FIXTURE_VARIANT(tiocsti) * variant,
> +				    int sockfd)
> +{
> +	signal(SIGHUP, SIG_IGN);
> +
> +	/* Handle privilege dropping */
> +	if (!variant->requires_cap && has_cap_sys_admin())
> +		ASSERT_TRUE(drop_all_privs(_metadata));
> +
> +	/* Create child=E2=80=99s PTY */
> +	int child_master_fd, child_slave_fd;
> +
> +	ASSERT_EQ(openpty(&child_master_fd, &child_slave_fd, NULL, NULL, NULL),
> +		  0);
> +
> +	if (variant->controlling_tty) {
> +		pid_t sid =3D setsid();
> +
> +		ASSERT_GE(sid, 0);
> +		ASSERT_EQ(ioctl(child_slave_fd, TIOCSCTTY, 0), 0);
> +	}
> +
> +	/* Test child=E2=80=99s direct TIOCSTI for reference */
> +	int direct_result =3D test_tiocsti_injection(_metadata, child_slave_fd);
> +
> +	EXPECT_EQ(direct_result, variant->expected_success);
> +
> +	/* Send FD to parent */
> +	ASSERT_EQ(send_fd_via_socket(sockfd, child_slave_fd), 0);
> +
> +	/* Wait for parent completion signal */
> +	char sync_byte;
> +	ssize_t bytes_read =3D read(sockfd, &sync_byte, 1);
> +
> +	ASSERT_EQ(bytes_read, 1);
> +
> +	close(child_master_fd);
> +	close(child_slave_fd);
> +	close(sockfd);
> +	_exit(0);
> +}
> +
> +FIXTURE_SETUP(tiocsti)
> +{
> +	/* Create PTY pair for basic tests */
> +	self->has_pty =3D (openpty(&self->pty_master_fd, &self->pty_slave_fd,
> +				 NULL, NULL, NULL) =3D=3D 0);
> +	if (!self->has_pty) {
> +		self->pty_master_fd =3D -1;
> +		self->pty_slave_fd =3D -1;
> +	}
> +
> +	self->initial_cap_sys_admin =3D has_cap_sys_admin();
> +	self->original_legacy_tiocsti_setting =3D
> +		get_legacy_tiocsti_setting(_metadata);
> +
> +	if (self->original_legacy_tiocsti_setting < 0)
> +		SKIP(return,
> +			   =E2=80=9Clegacy_tiocsti sysctl not available (kernel < 6.2)=E2=80=
=9D);
> +
> +	/* Common skip conditions */
> +	if (variant->test_type `=3D TEST_PTY_TIOCSTI_BASIC && !self->has_pty)
> +		SKIP(return, "PTY not available for controlling terminal test");
> +
> +	if (variant->test_type =3D' TEST_PTY_TIOCSTI_FD_PASSING &&
> +	    !self->initial_cap_sys_admin)
> +		SKIP(return, =E2=80=9CFD Pass tests require CAP_SYS_ADMIN=E2=80=9D);
> +
> +	if (variant->requires_cap && !self->initial_cap_sys_admin)
> +		SKIP(return, =E2=80=9CTest requires initial CAP_SYS_ADMIN=E2=80=9D);
> +
> +	/* Test if we can modify the sysctl (requires appropriate privileges) */
> +	self->can_modify_sysctl =3D set_legacy_tiocsti_setting(
> +		_metadata, self->original_legacy_tiocsti_setting);
> +
> +	/* Sysctl setup based on variant */
> +	if (self->can_modify_sysctl &&
> +	    self->original_legacy_tiocsti_setting !=3D variant->legacy_tiocsti)=
 {
> +		if (!set_legacy_tiocsti_setting(_metadata,
> +						variant->legacy_tiocsti))
> +			SKIP(return, =E2=80=9CFailed to set legacy_tiocsti sysctl=E2=80=9D);
> +
> +	} else if (!self->can_modify_sysctl &&
> +		   self->original_legacy_tiocsti_setting !=3D
> +			   variant->legacy_tiocsti)
> +		SKIP(return, =E2=80=9Clegacy_tiocsti setting mismatch=E2=80=9D);
> +}
> +
> +FIXTURE_TEARDOWN(tiocsti)
> +{
> +	/*
> +	 * Backup restoration -
> +	 * each test should restore its own sysctl changes
> +	 */
> +	if (self->can_modify_sysctl) {
> +		int current_value =3D get_legacy_tiocsti_setting(_metadata);
> +
> +		if (current_value !=3D self->original_legacy_tiocsti_setting) {
> +			TH_LOG(=E2=80=9CBackup: Restoring legacy_tiocsti from %d to %d=E2=80=
=9D,
> +			       current_value,
> +			       self->original_legacy_tiocsti_setting);
> +			set_legacy_tiocsti_setting(
> +				_metadata,
> +				self->original_legacy_tiocsti_setting);
> +		}
> +	}
> +
> +	if (self->has_pty) {
> +		if (self->pty_master_fd >=3D 0)
> +			close(self->pty_master_fd);
> +		if (self->pty_slave_fd >=3D 0)
> +			close(self->pty_slave_fd);
> +	}
> +}
> +
> +TEST_F(tiocsti, test)
> +{
> +	int status;
> +	pid_t child_pid;
> +
> +	if (variant->test_type =3D=3D TEST_PTY_TIOCSTI_BASIC) {
> +		/* `=3D=3D=3D' BASIC TIOCSTI TEST `=3D=3D=3D' */
> +		child_pid =3D fork();
> +		ASSERT_GE(child_pid, 0);
> +
> +		/* Perform the actual test in the child process */
> +		if (child_pid =3D=3D 0)
> +			run_basic_tiocsti_test(_metadata, self, variant);
> +
> +	} else {
> +		/* `=3D=3D=3D' FD PASSING SECURITY TEST `=3D=3D=3D' */
> +		int sockpair[2];
> +
> +		ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sockpair), 0);
> +
> +		child_pid =3D fork();
> +		ASSERT_GE(child_pid, 0);
> +
> +		if (child_pid =3D=3D 0) {
> +			/* Child process - create PTY and send FD */
> +			close(sockpair[0]);
> +			run_fdpass_tiocsti_test(_metadata, variant,
> +						sockpair[1]);
> +		}
> +
> +		/* Parent process - receive FD and test TIOCSTI */
> +		close(sockpair[1]);
> +
> +		int received_fd =3D recv_fd_via_socket(sockpair[0]);
> +
> +		ASSERT_GE(received_fd, 0);
> +
> +		bool parent_has_cap =3D self->initial_cap_sys_admin;
> +
> +		TH_LOG(=E2=80=9C`=3D' TIOCSTI FD Passing Test Context `=3D'=E2=80=9D);
> +		TH_LOG(=E2=80=9Clegacy_tiocsti: %d, Parent CAP_SYS_ADMIN: %s, Child: %=
s=E2=80=9D,
> +		       variant->legacy_tiocsti, parent_has_cap ? =E2=80=9Cyes=E2=80=9D=
 : =E2=80=9Cno=E2=80=9D,
> +		       variant->requires_cap ? =E2=80=9Ckept=E2=80=9D : =E2=80=9Cdropp=
ed=E2=80=9D);
> +
> +		/* SECURITY TEST: Try TIOCSTI with FD opened by child */
> +		int result =3D test_tiocsti_injection(_metadata, received_fd);
> +
> +		/* Log security concern if demonstrated */
> +		if (result =3D=3D 0 && !variant->requires_cap) {
> +			TH_LOG("*** SECURITY CONCERN DEMONSTRATED ***=E2=80=9C);
> +			TH_LOG(=E2=80=9DPrivileged parent can use TIOCSTI on FD from unprivil=
eged child=E2=80=9C);
> +			TH_LOG(=E2=80=9DThis shows current process credentials are used, not =
opener credentials=E2=80=9C);
> +		}
> +
> +		EXPECT_EQ(result, variant->expected_success)
> +		{
> +			TH_LOG(=E2=80=9DFD passing: expected error %d, got %d=E2=80=9C,
> +			       variant->expected_success, result);
> +		}
> +
> +		/* Signal child completion */
> +		char sync_byte =3D =E2=80=98D=E2=80=99;
> +		ssize_t bytes_written =3D write(sockpair[0], &sync_byte, 1);
> +
> +		ASSERT_EQ(bytes_written, 1);
> +
> +		close(received_fd);
> +		close(sockpair[0]);
> +	}
> +
> +	/* Common child process cleanup for both test types */
> +	ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
> +
> +	if (WIFSIGNALED(status)) {
> +		TH_LOG(=E2=80=9DChild terminated by signal %d=E2=80=9C, WTERMSIG(statu=
s));
> +		ASSERT_FALSE(WIFSIGNALED(status))
> +		{
> +			TH_LOG(=E2=80=9DChild process failed assertion");
> +		}
> +	} else {
> +		EXPECT_EQ(WEXITSTATUS(status), 0);
> +	}
> +}
> +
> +TEST_HARNESS_MAIN
>
> =E2=80=94
> base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
> change-id: 20250618-toicsti-bug-7822b8e94a32
>
> Best regards,


Hi TTY Maintainers,

I had submitted this patch series a couple of weeks ago and wanted to
gently ping to see if you=E2=80=99ve had a chance to review it.

Also, if you have any other concerns or questions, I would be happy to
address them.


Best,
Abhinav

--=-=-=--

