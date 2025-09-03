Return-Path: <linux-kselftest+bounces-40673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72238B4117E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 02:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B847A4D8C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878E1917FB;
	Wed,  3 Sep 2025 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjTCV1BO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE272618;
	Wed,  3 Sep 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860851; cv=none; b=pjRhr4xsJiTrcplgjTpehN3pnpWiuO272Mv1Rt6HqHWnI6nurmYtyh8d1CR4e2BmjS2gG+pcPBkl7ZbtPPt6K6YmSp0JDko0zCHL5J4NyxW1sdw8Xm0yED2ASrTugl2q592qYlvyXQubfQ7PszLEGXq4nhYVwnJoWKPxfE7X9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860851; c=relaxed/simple;
	bh=kcNwJOzkqoX9rSeUpLch61HWAKlvtsQHVFyVO47m5F4=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Hkzqdm2nN8USLldO7ivg7Sp6Spek7MDmaozqnUTM2otpz2759gXsd89YivjAmfS2cJ0lv04xDNXRApQSprDJ4CtDvN2Tvwxfr83+50rN/4bkdBT2q43UvRj4wBkU/d3l1Q3+4PVzHMDMVx4ZvPU7S6Cn9U8+s+0CwWwKvxmfmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjTCV1BO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e8005bso5972372a91.3;
        Tue, 02 Sep 2025 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756860849; x=1757465649; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzJEWr0hHSTCHLW2ZPbPTexdMSB3GHBPnCsDiiEa0CE=;
        b=SjTCV1BO2WllFNxIiSpTP31Hiot+2eWcwRbhOJ0zC4eVJh+bZ/7JlRIK5WiZRFUDVe
         /aFi+zNT3LAW4u6Uz4Tk2iwolar1ptvo07P9zhvLUmfb2TPzPXbL76VnkQ+leRI2/JYn
         FZ7zUC1hnGqlJcVIyr6YW505a/6UWMWa9Pv1A/Gphh/2hsICS6+MinD0cAnh9N9PWuia
         dit2moQhqXwIeH+cqq3o1Kbk46nsj13/mEWDCtEFRZQXYb37DG0WQo7Kp9wlZtt8cfaq
         TDgemLMc/ZGPpTD3mnkCa6Te2GwgxW38KEkgsgTyFx5RH/lvTH2vZfdU1dqlnvdruqKU
         +0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756860849; x=1757465649;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzJEWr0hHSTCHLW2ZPbPTexdMSB3GHBPnCsDiiEa0CE=;
        b=av320V5ItACEZdPiASAHwCZvAiWI/qaZ2pLfzN5NdtvIJsbW819Kaylz+HkJDUt9ot
         YQ9oYfmSI+31hQ6ph4zDU7q6QyK1KJ8Tah5fxxjYnNEMBlRasD8UR4IVdwkj+DmXaVFR
         JVj3Lydao+9VijsZVut+HOLcirTsFILiO18tohgz2gGdf5R0uWlG99R6DWhOUXNjUWwk
         D2FDR2cwqMtTUKDs7g68k8IAzcC00wMUi5qt939W+KbUcs6t9WzI1f8LWuZsrtMO/Aq4
         wSeOo+1sUVduX2X5HS4OYKOEMxLgL/8qDQlJfu3NsywRPvlViUX0lU6e1OrybZ9xyNEf
         1h1A==
X-Forwarded-Encrypted: i=1; AJvYcCUAbj6ptgF6o7Z6j0xGBKT6aNxW4IFVWNurcqLSEzQzAiKEsYOGVunS3W/yZy1BcOJ6Q4hzHD5MesV60ZOQKmZ4@vger.kernel.org, AJvYcCUm3bLuMs0qjhwtYrl5/9rpR7T4xcgpqk8IyJ84Bl8KBJYcrjb54jrLuJGEH0dAY47Q+2ZvjAnZuKVFjjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qcpaU7mJSndMNnltwiFjbsAW29i39Nz3gAKJvKH4LjscvdQ+
	qq8Jc4GOFQdj/X6zXcQJM6bjunq7cqlNGQL5q6i2Sp3UzWYSiOstJwzZ
X-Gm-Gg: ASbGncubbeOlN8/k9rMNBxshPyYqDSTmXXa/uW+1fO4LfkhMD1U408Bsa4K01VbJdIq
	JjZwwXoYC9TYai+OsYjP+AXGxUqo1mMlk70AFfXc6RbgTpGtVgEPpN/8KX8bwwWD09ANMpgyKsr
	yS+o+cdE5E3t6Ui9qMlSq9Zsp4IcPbiL5tXVbPCJ0U47C0iR1DdioN48NEIZUW3qsF1IfvgD7PW
	MKW6ihOGs6OxKp6oyUyZeAl+KzMX7shaHBcAzAuA2+nheWqklXJqtd3Rjjx7mrnXi3zCMa02qgS
	3xw3t3jXntsUzEka74wDCfaH9VSXiqXiVNMHn4xDaPlLbSX5/OesBc19XeWgO3tUxxrsk3a4HuH
	YcJyRKKIYS33S
X-Google-Smtp-Source: AGHT+IHdJRbu698YeETZFzXq2+vUi4ALBmmNCdIrvup3Pn4gbUSIokcsFYQ5ZINuGQZKealxpkFTXg==
X-Received: by 2002:a17:90b:582b:b0:328:acc:da37 with SMTP id 98e67ed59e1d1-32815414342mr12323150a91.5.1756860848466;
        Tue, 02 Sep 2025 17:54:08 -0700 (PDT)
Received: from 1337 ([136.159.213.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d93317f0sm15280215a91.6.2025.09.02.17.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 17:54:07 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Paul Moore <paul@paul-moore.com>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] selftests/tty: add TIOCSTI test suite
Date: Tue, 02 Sep 2025 18:44:55 -0600
References: <20250730-toicsti-bug-v3-1-dd2dac97f27a@gmail.com>
 <ytndgs2vwkhijeuruejvk55geqouuditkjpge6u7gb6qt6hxqa@uh2wnuapkb5f>
User-agent: mu4e 1.10.8; emacs 30.2
In-reply-to: <ytndgs2vwkhijeuruejvk55geqouuditkjpge6u7gb6qt6hxqa@uh2wnuapkb5f>
Message-ID: <87ms7cjqz5.fsf@gmail.com>
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

Justin Stitt <justinstitt@google.com> writes:

Hi,

> Hi,
>
> On Wed, Jul 30, 2025 at 06:14:43PM -0600, Abhinav Saxena wrote:
>
> <snip>
>
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
>
> Is it necessary to append -lcap to LDLIBS twice? Once globally and once
> for that TU?
>

So I built the tests in two ways:

1. Building all targets with `make -C tools/testing/selftests/tty/`
2. Building a specific target which is tty_tiocsti_test in this case.
   I do this with `make -C tools/testing/selftests/tty/ tty_tiocsti_test`

I may be completely wrong here, but I think I need the global for (1)
and TU specific append for (2). There may better ways to do this,
however. Open to ideas :)

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
>
> Maybe we can retrieve the uid/gid from getpwnam(3) with:
>   const struct passwd *pw =3D getpwnam(=E2=80=9Cnobody=E2=80=9D);
>
> =E2=80=A6 then use pw->pw_{uid,gid}. I suggest this because there might be
> portability issues with the hardcoded 65534 =E2=80=93 not 100% sure thoug=
h.
>

Thanks! Yep, I guess it is better to get rid of `nobody` logic
completely for better portability. I replaced it with `drop_all_privs`
in v4 [1].

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
>
> <snip>
>
>> =E2=80=94
>> base-commit: 283564a43383d6f26a55546fe9ae345b5fa95e66
>> change-id: 20250618-toicsti-bug-7822b8e94a32
>>=20
>> Best regards,
>> =E2=80=93=20
>> Abhinav Saxena <xandfury@gmail.com>
>>=20
>>
>
> Justin

Thanks for the feedback!

=E2=80=A2 Abhinav

[1] - Link to v4:
<https://lore.kernel.org/all/20250902-toicsti-bug-v4-1-e5c960e0b3d6@gmail.c=
om/>

--=-=-=--

