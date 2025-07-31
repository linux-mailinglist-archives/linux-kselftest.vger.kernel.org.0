Return-Path: <linux-kselftest+bounces-38091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE890B16B2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 06:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA7B1AA41FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 04:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01339239E85;
	Thu, 31 Jul 2025 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/pMaIrY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2359A921;
	Thu, 31 Jul 2025 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936089; cv=none; b=KF5h7hC216wXN/AEKwHfORQ2YUEVLrhpjBgkoXhDEyo7VzKf7zapbyQNZVD2jFOemfnZuHQpZs04CcKD/XFEJfPGVkTnoi8g4Rc9MiGKAfcn3/kaGqwkOm4UU6op1OOiSiNCfaocbWwRmbZbK7NrK23c1xLO94/UgwOAjcn5HUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936089; c=relaxed/simple;
	bh=RQJrQB/Gd8zLxFCrhlVRfiHc3ylBMeiJR630lNaJmgs=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=UeMPTJ6wNIi9b0o8Uls/eQru0cu5bkwGLFDnuWcKXotfBnj63H5AVyzzNmXESB18D+1hMgG4D7e0+19ECI18iF4uSaQZYgCmbZasWKUWAtyHXOXSZVSFQ8rkwfvT2aMyTGZ+q34RO1FEAUTWK6xkcW2kn+yLIdWHBGdfOdj5Sng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/pMaIrY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bc61152d8so465088b3a.2;
        Wed, 30 Jul 2025 21:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753936087; x=1754540887; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ye1NKHYHVhq23a5pyaazSPrRqN9L72M3LfD4z9NUTIk=;
        b=X/pMaIrYXq4wjnRO1sHM+ir4q7uczk550Q4Ua4axLuVQd1BnyGSpAsnIa60HQ6203M
         QWjFXyKgRY5PBAfB5kR/qoco8Am1Zji3pObKQYIFc1huGKsLBf0HCRDMf0+U2tS4Fh4E
         gXeziG8CbvnnEz6g9R9l6kgenu1lrvIvIKXFzICOi+0vcbLHGYpLsoNTKkctTYoHJsFM
         9OkOQ8+/XvmU6elDbIJj4RoNoNRexlggaREAr1or6caDimuXXGkETR5hHGiMhrNtdMfy
         p5fxsseUHLPK9VqiQmKWvxia3puXApr7b62OP+hi8Ey62+uXXlg8bavPxJn8AHRMIrYe
         QVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753936087; x=1754540887;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye1NKHYHVhq23a5pyaazSPrRqN9L72M3LfD4z9NUTIk=;
        b=MJUlQOzYzpIRWD2DIbVqZFeqDzP0GwOfxdkU4EWYLK7eHS2LBMfeBzfGgJFA9NwOss
         vkMUCYHBeAVE43yI4PnN+GMTl4qci5o4OTIRpNFZg5ntmweBC/4qyV2Szpaa6wOtSz3Y
         s/3U9uVUs1R9JsGHvzq12vrqFWbguAZEjg+o7qfW4nu+xLdz0BAimVmqAwoTRWy/TXkZ
         BPf9PsV7UThTzSZGbWy6q2qNyShiLLRKwJ5fArjAVYmYL06w8hRteDXH00kx0NkRNik4
         rBPFMSCNgcXUiTIJfwtqw8H0xxCFmLCHN1c+l2TsdC82oCFarfmTKo7BeViYYakrK36i
         SVOw==
X-Forwarded-Encrypted: i=1; AJvYcCX8/9U7wgPPE8F+KceSjPqU8Mx171twq8xqbBReFZHBCgoHw8uJ0x2xMndR66+QnqBWPeOfrqNHcYUMPWw=@vger.kernel.org, AJvYcCXN51FUydoHEC1nrYFCaCam7DLDCDDa/ljj+wAzUALMUkJ3LUOrdnXca64wbKl/PhqfOW+X0LvfNuibacgjwCIG@vger.kernel.org
X-Gm-Message-State: AOJu0YwBm51zsPVOqNbr9fzNU0cckOuLRg7FjFwnrxXKkM8BL+EhZlkB
	G+hLgCanyDcjXpVDx29S4Wp7fpSZfCUXCYOSgLyoU28EVr7TpKdzT+rO
X-Gm-Gg: ASbGnctYzfuf3TR3PLTBwIYMrs9zxq3BHHOq9w+TNs736/RPvU7UKrGqduTHoVMhH/s
	6r7iOKkyG2+hls3sUcNN5nmYCVERk4LvuWcBb/BD7+0yqdCOEFnWtJ0jjUcvqXOR4D2J+FBuKQy
	LukTOS+mX44oQ+/LbA1HztUR/QiTmY/UZ8MWeoMg4+APiR6bCvsGm7A+/cGFD2FDeY7gkQSH2u0
	8pbHDgJnNSyOLUE8DewT7QzeXy1X8VZaySPIbTxBDTYS5yG5+xyRCokc1FOWSG+wPtATQnl0NWj
	zLe7hx4A/j5BTPpeJ6d7OBE2uJKgr5+e0/Y5MRCdBCmxagmOYbaYk5FCA4XTIjr/JPTSFxOJ3ow
	tJ2eZaMeYxhpDQ3zJqN79
X-Google-Smtp-Source: AGHT+IG1sphc/Jyn8rrGnPRBrMBLQ7rwgWj8DOwUaNgbc67izX1W+D2GfPx/ZBGsFqn1I/MJxZiY6Q==
X-Received: by 2002:a05:6a20:12c7:b0:239:c7c:8e05 with SMTP id adf61e73a8af0-23dc0e59b80mr9740715637.34.1753936086654;
        Wed, 30 Jul 2025 21:28:06 -0700 (PDT)
Received: from 1337 ([136.159.213.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa33sm416448b3a.43.2025.07.30.21.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 21:28:05 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Paul Moore
 <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/tty: add TIOCSTI test suite
Date: Wed, 30 Jul 2025 21:55:45 -0600
References: <20250713-toicsti-bug-v2-1-b183787eea29@gmail.com>
 <202507222329.D44E6AC@keescook>
User-agent: mu4e 1.10.8; emacs 30.1
In-reply-to: <202507222329.D44E6AC@keescook>
Message-ID: <87qzxxt25n.fsf@gmail.com>
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

Hi!

Thank you so much for the detailed review! Based on the feedback, I
have updated v3 [1]. In v3, we also add additional tests using
the FIXTURE_ADD_VARIANT feature to test the matrix of possibilities.

The central idea is that FD passing tests would behave the same way as
the regular tests if the file credentials were also checked.


Kees Cook <kees@kernel.org> writes:

> On Sun, Jul 13, 2025 at 06:38:55PM -0600, Abhinav Saxena via B4 Relay wro=
te:
>> From: Abhinav Saxena <xandfury@gmail.com>
>>
>> TIOCSTI is a TTY ioctl command that allows inserting characters into
>> the terminal input queue, making it appear as if the user typed those
>> characters.
>>
>> Add a test suite with four tests to verify TIOCSTI behaviour in
>> different scenarios when dev.tty.legacy_tiocsti is both enabled and
>> disabled:
>>
>> - Test TIOCSTI functionality when legacy support is enabled
>> - Test TIOCSTI rejection when legacy support is disabled
>> - Test capability requirements for TIOCSTI usage
>> - Test TIOCSTI security with file descriptor passing
>>
>> The tests validate proper enforcement of the legacy_tiocsti sysctl
>> introduced in commit 83efeeeb3d04 (=E2=80=9Ctty: Allow TIOCSTI to be dis=
abled=E2=80=9D).
>> See tty_ioctl(4) for details on TIOCSTI behavior and security
>> requirements.
>>
>> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
>> =E2=80=94
>> This patch adds comprehensive selftests for the TIOCSTI ioctl to validate
>> proper behaviour under different system configurations.
>
> Much of the text under the =E2=80=94 line is useful details; I would merg=
e it
> with the short commit log above to make a comprehensive commit message.
>

Thanks! I added more details to the commit message in v3.

>>=20
>> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>>
>> The TIOCSTI ioctl allows inserting characters into the terminal input
>> queue, making it appear as if the user typed those characters. This
>> functionality has security implications and behaviour that varies based
>> on system configuration.
>>
>> Background
>> `=3D=3D=3D=3D=3D=3D=3D=3D'
>>
>> CONFIG_LEGACY_TIOCSTI controls the default value for the dev.tty.legacy_=
tiocsti
>> sysctl, which remains runtime-configurable. The dev.tty.legacy_tiocsti s=
ysctl
>> was introduced in commit 83efeeeb3d04 (=E2=80=9Ctty: Allow TIOCSTI to be=
 disabled=E2=80=9D)
>> to provide administrators control over TIOCSTI usage.
>>
>> When legacy_tiocsti is disabled, TIOCSTI requires CAP_SYS_ADMIN capabili=
ty.
>> However, the current implementation only checks the current process=E2=
=80=99s
>> credentials via capable(CAP_SYS_ADMIN), which doesn=E2=80=99t validate a=
gainst
>> the file opener=E2=80=99s credentials stored in file->f_cred.
>>
>> This creates a potential security scenario where an unprivileged process
>> can open a TTY fd and pass it to a privileged process via SCM_RIGHTS.
>>
>> Testing
>> `=3D=3D=3D=3D=3D'
>>
>> The test suite includes four comprehensive tests:
>> - Test TIOCSTI functionality when legacy support is enabled
>> - Test TIOCSTI rejection when legacy support is disabled
>> - Test capability requirements for TIOCSTI usage
>> - Test TIOCSTI security with file descriptor passing
>>
>> All patches have been validated using:
>> - scripts/checkpatch.pl =E2=80=93strict (0 errors, 0 warnings)
>> - Functional testing on kernel v6.16-rc2
>> - File descriptor passing security test scenarios
>>
>> The fd_passing_security test demonstrates the security concern.
>> To verify, disable legacy TIOCSTI and run the test:
>>
>> $ echo =E2=80=9C0=E2=80=9D | sudo tee /proc/sys/dev/tty/legacy_tiocsti
>> $ sudo ./tools/testing/selftests/tty/tty_tiocsti_test -t fd_passing_secu=
rity
>>
>> Patch Overview
>> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>>
>> PATCH 1/1: selftests/tty: add TIOCSTI test suite
>> Comprehensive test suite demonstrating the issue and fix validation
>>
>> References
>> `=3D=3D=3D=3D=3D=3D=3D=3D'
>>
>> - tty_ioctl(4) - documents TIOCSTI ioctl and capability requirements
>> - commit 83efeeeb3d04 (=E2=80=9Ctty: Allow TIOCSTI to be disabled=E2=80=
=9D)
>> - Documentation/security/credentials.rst
>> - <https://github.com/KSPP/linux/issues/156>
>> - <https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad>/
>> - drivers/tty/Kconfig
>>
>> Configuration References:
>> [1] - <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/tty/Kconfig#n149>
>> [2] - <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/tty/Kconfig#n162>
>> [3] - <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/tty/Kconfig#n188>
>>
>> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
>>
>> Changes in v2:
>> - Focused series on selftests only
>> - Removed SELinux capability checking patch for separate submission
>> - Link to v1: <https://lore.kernel.org/r/20250622-toicsti-bug-v1-0-f3743=
73b04b2@gmail.com>
>> =E2=80=94
>>  tools/testing/selftests/tty/Makefile           |   6 +-
>>  tools/testing/selftests/tty/config             |   1 +
>>  tools/testing/selftests/tty/tty_tiocsti_test.c | 421 ++++++++++++++++++=
+++++++
>>  3 files changed, 427 insertions(+), 1 deletion(-)
>>
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
>>
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
>> index 000000000000..6a4b497078b0
>> =E2=80=94 /dev/null
>> +++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
>> @@ -0,0 +1,421 @@
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
>> +
>> +#include =E2=80=9C../kselftest_harness.h=E2=80=9D
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
>> + * Simple privilege drop that just changes uid/gid in current process
>> + * and also capabilities like CAP_SYS_ADMIN
>> + */
>> +static inline bool drop_to_nobody(void)
>> +{
>> +	/* Drop supplementary groups */
>> +	if (setgroups(0, NULL) !=3D 0) {
>> +		printf(=E2=80=9Csetgroups failed: %s=E2=80=9D, strerror(errno));
>> +		return false;
>> +	}
>> +
>> +	/* Change group to nobody */
>> +	if (setgid(65534) !=3D 0) {
>> +		printf(=E2=80=9Csetgid failed: %s=E2=80=9D, strerror(errno));
>> +		return false;
>> +	}
>> +
>> +	/* Change user to nobody (this drops capabilities) */
>> +	if (setuid(65534) !=3D 0) {
>> +		printf(=E2=80=9Csetuid failed: %s=E2=80=9D, strerror(errno));
>> +		return false;
>> +	}
>> +
>> +	/* Verify we no longer have CAP_SYS_ADMIN */
>> +	if (has_cap_sys_admin()) {
>> +		printf(=E2=80=9CERROR: Still have CAP_SYS_ADMIN after changing to nob=
ody=E2=80=9D);
>> +		return false;
>> +	}
>> +
>> +	printf(=E2=80=9CSuccessfully changed to nobody (uid:%d gid:%d)\n=E2=80=
=9D, getuid(),
>> +	       getgid());
>> +	return true;
>> +}
>
> All of the bare printfs above should use TH_LOG()
>

Done! I=E2=80=99ve updated all instances to use TH_LOG().

>> +
>> +static inline int get_legacy_tiocsti_setting(void)
>> +{
>> +	FILE *fp;
>> +	int value =3D -1;
>> +
>> +	fp =3D fopen(=E2=80=9C/proc/sys/dev/tty/legacy_tiocsti=E2=80=9D, =E2=
=80=9Cr=E2=80=9D);
>> +	if (!fp) {
>> +		if (errno `=3D ENOENT) {
>> +			printf("legacy_tiocsti sysctl not available (kernel < 6.2)\n");
>> +		} else {
>> +			printf("Cannot read legacy_tiocsti: %s\n",
>> +			       strerror(errno));
>> +		}
>> +		return -1;
>> +	}
>> +
>> +	if (fscanf(fp, "%d", &value) =3D' 1) {
>> +		printf(=E2=80=9Clegacy_tiocsti setting=3D%d\n=E2=80=9D, value);
>> +
>> +		if (value < 0 || value > 1) {
>> +			printf(=E2=80=9Clegacy_tiocsti unexpected value %d\n=E2=80=9D, value=
);
>> +			value =3D -1;
>> +		} else {
>> +			printf(=E2=80=9Clegacy_tiocsti=3D%d (%s mode)\n=E2=80=9D, value,
>> +			       value =3D=3D 0 ? =E2=80=9Crestricted=E2=80=9D : =E2=80=9Cperm=
issive=E2=80=9D);
>> +		}
>> +	} else {
>> +		printf(=E2=80=9CFailed to parse legacy_tiocsti value=E2=80=9D);
>> +		value =3D -1;
>> +	}
>> +
>> +	fclose(fp);
>> +	return value;
>> +}
>
> Same observation as above that reporting should go through the kselftest
> harness APIs.
>

Fixed.

>> +
>> +static inline int test_tiocsti_injection(int fd)
>> +{
>> +	int ret;
>> +	char test_char =3D =E2=80=99X=E2=80=99;
>> +
>> +	ret =3D ioctl(fd, TIOCSTI, &test_char);
>> +	if (ret `=3D 0) {
>> +		/* Clear the injected character */
>> +		printf("TIOCSTI injection succeeded\n");
>> +	} else {
>> +		printf("TIOCSTI injection failed: %s (errno=3D%d)\n",
>> +		       strerror(errno), errno);
>> +	}
>> +	return ret =3D' 0 ? 0 : -1;
>> +}
>
> Same. Note for each of these you=E2=80=99ll need to pass in the test meta=
data
> (struct __test_metadata *_metadata). See helper examples that do this
> in tools/testing/selftests/seccomp/seccomp_bpf.c like tracer_poke(),
> get_syscall(), etc.
>

Yep. Done! I added metadata as an argument to helper functions in v3.

>> +
>> +FIXTURE(tty_tiocsti)
>> +{
>> +	int tty_fd;
>> +	char *tty_name;
>> +	bool has_tty;
>> +	bool initial_cap_sys_admin;
>> +	int legacy_tiocsti_setting;
>> +};
>> +
>> +FIXTURE_SETUP(tty_tiocsti)
>> +{
>> +	TH_LOG(=E2=80=9CRunning as UID: %d with effective UID: %d=E2=80=9D, ge=
tuid(),
>> +	       geteuid());
>> +
>> +	self->tty_fd =3D open(=E2=80=9C/dev/tty=E2=80=9D, O_RDWR);
>> +	self->has_tty =3D (self->tty_fd >=3D 0);
>> +
>> +	if (self->tty_fd < 0)
>> +		TH_LOG(=E2=80=9CCannot open /dev/tty: %s=E2=80=9D, strerror(errno));
>
> I would expect this to be:
>
> 	ASSERT_GE(self->tty_fd, 0) {
> 		TH_LOG(=E2=80=9CCannot open /dev/tty: %s=E2=80=9D, strerror(errno));
> 	}
>

You are right. I fixed this everywhere.

>> +
>> +	self->tty_name =3D ttyname(STDIN_FILENO);
>> +	TH_LOG(=E2=80=9CCurrent TTY: %s=E2=80=9D, self->tty_name ? self->tty_n=
ame : =E2=80=9Cnone=E2=80=9D);
>> +
>> +	self->initial_cap_sys_admin =3D has_cap_sys_admin();
>> +	TH_LOG(=E2=80=9CInitial CAP_SYS_ADMIN: %s=E2=80=9D,
>> +	       self->initial_cap_sys_admin ? =E2=80=9Cyes=E2=80=9D : =E2=80=9C=
no=E2=80=9D);
>> +
>> +	self->legacy_tiocsti_setting =3D get_legacy_tiocsti_setting();
>> +}
>> +
>> +FIXTURE_TEARDOWN(tty_tiocsti)
>> +{
>> +	if (self->has_tty && self->tty_fd >=3D 0)
>> +		close(self->tty_fd);
>> +}
>> +
>> +/* Test case 1: legacy_tiocsti !=3D 0 (permissive mode) */
>> +TEST_F(tty_tiocsti, permissive_mode)
>> +{
>> +	// clang-format off
>
> While there are instances in the tree of "//" please use /* */ for
> comments, even these format pragmas.
>

I fixed "//" comments to use /* */ everywhere.

>> +	if (self->legacy_tiocsti_setting < 0)
>> +		SKIP(return,
>> +		     =E2=80=9Clegacy_tiocsti sysctl not available (kernel < 6.2)=E2=
=80=9D);
>
> I notice this check is in every test. I think it=E2=80=99d be cleaner to =
put it
> into FIXTURE_SETUP() instead.
>

Yes, I added a system-wide skip for cases such as when the
legacy_tiocsti option is not available, which I placed in FIXTURE_SETUP.

>> +
>> +	if (self->legacy_tiocsti_setting =3D=3D 0)
>> +		SKIP(return,
>> +		     =E2=80=9CTest requires permissive mode (legacy_tiocsti=3D1)=E2=
=80=9D);
>
> What about changing this value during FIXTURE_SETUP() and restoring it
> in FIXTURE_TEARDOWN()?

Yes, that makes more sense. In v3 we change values during setup and
teardown based on the requirements of the test.

>
>> +	// clang-format on
>> +
>> +	ASSERT_TRUE(self->has_tty);
>
> Can opening a pty (i.e. openpty(3)) be used to always have a tty
> available?
>

Potentially, yes. Initially, I ran the tests on both pty and tty. But
running on pty makes more sense for the reason you highlighted below.

>> +
>> +	if (self->initial_cap_sys_admin) {
>> +		ASSERT_TRUE(drop_to_nobody());
>> +		ASSERT_FALSE(has_cap_sys_admin());
>> +	}
>> +
>> +	/* In permissive mode, TIOCSTI should work without CAP_SYS_ADMIN */
>> +	EXPECT_EQ(test_tiocsti_injection(self->tty_fd), 0)
>
> With openpty() I think it would also mean you can trivially throw
> away injected characters instead of having them actually end up on the
> real tty? But it=E2=80=99s been a while since I did tty work, so maybe I=
=E2=80=99m
> confusing myself about what openpty() gets you.
>

That=E2=80=99s true. I use openpty(3) in v3, and then in a child process and
then run the TIOCSCTTY ioctl call to set it as the controlling terminal
of the child. This allowed us to write even more comprehensive tests
without having injected characters on the real tty.

>> +	{
>> +		TH_LOG(=E2=80=9CTIOCSTI should succeed in permissive mode without CAP=
_SYS_ADMIN=E2=80=9D);
>> +	}
>> +}
>> +
>> +/* Test case 2: legacy_tiocsti `=3D 0, without CAP_SYS_ADMIN (should fa=
il) */
>> +TEST_F(tty_tiocsti, restricted_mode_nopriv)
>> +{
>> +	// clang-format off
>> +	if (self->legacy_tiocsti_setting < 0)
>> +		SKIP(return,
>> +		     "legacy_tiocsti sysctl not available (kernel < 6.2)");
>> +
>> +	if (self->legacy_tiocsti_setting !' 0)
>> +		SKIP(return,
>> +		     =E2=80=9CTest requires restricted mode (legacy_tiocsti=3D0)=E2=
=80=9D);
>
> I think it should be possible to _set_ the state you want (if running as
> root) and if not settable, then do the SKIP.
>

Yes, we do this in v3.

>> +	// clang-format on
>> +
>> +	ASSERT_TRUE(self->has_tty);
>> +
>> +	if (self->initial_cap_sys_admin) {
>> +		ASSERT_TRUE(drop_to_nobody());
>> +		ASSERT_FALSE(has_cap_sys_admin());
>> +	}
>> +	/* In restricted mode, TIOCSTI should fail without CAP_SYS_ADMIN */
>> +	EXPECT_EQ(test_tiocsti_injection(self->tty_fd), -1);
>> +
>> +	/*
>> +	 * it might fail with either EPERM or EIO
>> +	 * EXPECT_TRUE(errno `=3D EPERM || errno =3D' EIO)
>> +	 * {
>> +	 *      TH_LOG(=E2=80=9CExpected EPERM, got: %s=E2=80=9D, strerror(err=
no));
>> +	 * }
>> +	 */
>
> Why are these commented out?
>

I think this is from v1 where I also had added SELinux-related return
as a potential fix. Since that is no longer the case, v3 verifies the
error codes correctly.

>> +}
>> +
>> +/* Test case 3: legacy_tiocsti `=3D 0, with CAP_SYS_ADMIN (should succe=
ed) */
>> +TEST_F(tty_tiocsti, restricted_mode_priv)
>> +{
>> +	// clang-format off
>> +	if (self->legacy_tiocsti_setting < 0)
>> +		SKIP(return,
>> +		     "legacy_tiocsti sysctl not available (kernel < 6.2)");
>> +
>> +	if (self->legacy_tiocsti_setting !' 0)
>> +		SKIP(return,
>> +		     =E2=80=9CTest requires restricted mode (legacy_tiocsti=3D0)=E2=
=80=9D);
>> +	// clang-format on
>> +
>> +	/* Must have CAP_SYS_ADMIN for this test */
>> +	if (!self->initial_cap_sys_admin)
>> +		SKIP(return, =E2=80=9CTest requires CAP_SYS_ADMIN=E2=80=9D);
>> +
>> +	ASSERT_TRUE(self->has_tty);
>> +	ASSERT_TRUE(has_cap_sys_admin());
>> +
>> +	/* In restricted mode, TIOCSTI should succeed with CAP_SYS_ADMIN */
>> +	EXPECT_EQ(test_tiocsti_injection(self->tty_fd), 0)
>> +	{
>> +		TH_LOG(=E2=80=9CTIOCSTI should succeed in restricted mode with CAP_SY=
S_ADMIN=E2=80=9D);
>> +	}
>> +}
>> +
>> +/* Test TIOCSTI security with file descriptor passing */
>> +TEST_F(tty_tiocsti, fd_passing_security)
>> +{
>> +	// clang-format off
>> +	if (self->legacy_tiocsti_setting < 0)
>> +		SKIP(return,
>> +		     =E2=80=9Clegacy_tiocsti sysctl not available (kernel < 6.2)=E2=
=80=9D);
>> +
>> +	if (self->legacy_tiocsti_setting !=3D 0)
>> +		SKIP(return,
>> +		     =E2=80=9CTest requires restricted mode (legacy_tiocsti=3D0)=E2=
=80=9D);
>> +	// clang-format on
>> +
>> +	/* Must start with CAP_SYS_ADMIN */
>> +	if (!self->initial_cap_sys_admin)
>> +		SKIP(return, =E2=80=9CTest requires initial CAP_SYS_ADMIN=E2=80=9D);
>> +
>> +	int sockpair[2];
>> +	pid_t child_pid;
>> +
>> +	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sockpair), 0);
>> +
>> +	child_pid =3D fork();
>> +	ASSERT_GE(child_pid, 0)
>> +	TH_LOG(=E2=80=9CFork failed: %s=E2=80=9D, strerror(errno));
>> +
>> +	if (child_pid =3D=3D 0) {
>> +		/* Child process - become unprivileged, open TTY, send FD to parent */
>> +		close(sockpair[0]);
>> +
>> +		TH_LOG(=E2=80=9CChild: Dropping privileges=E2=80=A6=E2=80=9D);
>> +
>> +		/* Drop to nobody user (loses all capabilities) */
>> +		drop_to_nobody();
>> +
>> +		/* Verify we no longer have CAP_SYS_ADMIN */
>> +		if (has_cap_sys_admin()) {
>> +			TH_LOG(=E2=80=9CChild: Failed to drop CAP_SYS_ADMIN=E2=80=9D);
>> +			_exit(1);
>> +		}
>
> Please double check the behavior but I think you can use ASSERTs in the
> child and you don=E2=80=99t need the =E2=80=9C_exit(1)=E2=80=9D stuff.
>
>> +
>> +		TH_LOG(=E2=80=9CChild: Opening TTY as unprivileged user=E2=80=A6=E2=
=80=9D);
>> +
>> +		int unprivileged_tty_fd =3D open(=E2=80=9C/dev/tty=E2=80=9D, O_RDWR);
>> +
>> +		if (unprivileged_tty_fd < 0) {
>> +			TH_LOG(=E2=80=9CChild: Cannot open TTY: %s=E2=80=9D, strerror(errno)=
);
>> +			_exit(1);
>> +		}
>> +
>> +		/* Test that we can=E2=80=99t use TIOCSTI directly (should fail) */
>> +
>> +		char test_char =3D =E2=80=99X=E2=80=99;
>> +
>> +		if (ioctl(unprivileged_tty_fd, TIOCSTI, &test_char) =3D=3D 0) {
>> +			TH_LOG(=E2=80=9CChild: ERROR - Direct TIOCSTI succeeded unexpectedly=
!=E2=80=9D);
>> +			close(unprivileged_tty_fd);
>> +			_exit(1);
>> +		}
>> +		TH_LOG(=E2=80=9CChild: Good - Direct TIOCSTI failed as expected: %s=
=E2=80=9D,
>> +		       strerror(errno));
>> +
>> +		/* Send the TTY FD to privileged parent via SCM_RIGHTS */
>> +		TH_LOG(=E2=80=9CChild: Sending TTY FD to privileged parent=E2=80=A6=
=E2=80=9D);
>> +		if (send_fd_via_socket(sockpair[1], unprivileged_tty_fd) !=3D 0) {
>> +			TH_LOG(=E2=80=9CChild: Failed to send FD=E2=80=9D);
>> +			close(unprivileged_tty_fd);
>> +			_exit(1);
>> +		}
>> +
>> +		close(unprivileged_tty_fd);
>> +		close(sockpair[1]);
>> +		_exit(0); /* Child success */
>> +
>> +	} else {
>
> This doesn=E2=80=99t need an else nor indenting: it is the parent no matt=
er what
> due to the _exit above.
>
>> +		/* Parent process - keep CAP_SYS_ADMIN, receive FD, test TIOCSTI */
>> +		close(sockpair[1]);
>> +
>> +		TH_LOG(=E2=80=9CParent: Waiting for TTY FD from unprivileged child=E2=
=80=A6=E2=80=9D);
>> +
>> +		/* Verify we still have CAP_SYS_ADMIN */
>> +		ASSERT_TRUE(has_cap_sys_admin());
>> +
>> +		/* Receive the TTY FD from unprivileged child */
>> +		int received_fd =3D recv_fd_via_socket(sockpair[0]);
>> +
>> +		ASSERT_GE(received_fd, 0)
>> +		TH_LOG(=E2=80=9CParent: Received FD %d (opened by unprivileged proces=
s)=E2=80=9D,
>> +		       received_fd);
>> +
>> +		/*
>> +		 * VULNERABILITY TEST: Try TIOCSTI with FD opened by unprivileged pro=
cess
>> +		 * This should FAIL even though parent has CAP_SYS_ADMIN
>> +		 * because the FD was opened by unprivileged process
>> +		 */
>> +		char attack_char =3D =E2=80=99V=E2=80=99; /* V for Vulnerability */
>> +		int ret =3D ioctl(received_fd, TIOCSTI, &attack_char);
>
> Doesn=E2=80=99t the child need to stay alive long enough to receive the
> character? i.e. is it a problem that the child immediately exits 0 after
> sending the fd to the parent?
>

Yep. In v3, we have the child wait for a character to be received from
the parent confirming that the fd has been received.

>> +
>> +		TH_LOG(=E2=80=9CParent: Testing TIOCSTI on FD from unprivileged proce=
ss=E2=80=A6=E2=80=9D);
>> +		if (ret `=3D 0) {
>> +			TH_LOG("*** VULNERABILITY DETECTED ***");
>> +			TH_LOG("Privileged process can use TIOCSTI on unprivileged FD");
>> +		} else {
>> +			TH_LOG("TIOCSTI failed on unprivileged FD: %s",
>> +			       strerror(errno));
>> +			EXPECT_EQ(errno, EPERM);
>> +		}
>
> Shouldn't this be arranged with an expect on ret =3D' 0 ?
>
>
>> +		close(received_fd);
>> +		close(sockpair[0]);
>> +
>> +		/* Wait for child */
>> +		int status;
>> +
>> +		ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
>> +		EXPECT_EQ(WEXITSTATUS(status), 0);
>> +		ASSERT_NE(ret, 0);
>> +	}
>> +}
>> +
>> +TEST_HARNESS_MAIN
>
> Looks like you=E2=80=99re on the right track!
>
> -Kees

Thanks!

I look forward to your comments and feedback on v3.

Best,
Abhinav

=E2=80=A2 Link to v3:
<https://lore.kernel.org/all/20250730-toicsti-bug-v3-1-dd2dac97f27a@gmail.c=
om/>

--=-=-=--

