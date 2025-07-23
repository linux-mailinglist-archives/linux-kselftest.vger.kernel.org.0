Return-Path: <linux-kselftest+bounces-37865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AEB0EB2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 09:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C08E580B46
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF5272E55;
	Wed, 23 Jul 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBJ7RkYL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5726C3A5;
	Wed, 23 Jul 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254133; cv=none; b=NEUhAA2kzf47xGET/uxiIumx2jIzo1zoGgGE3xGBsoWAdoD0Q4dlmKuEjqhZEvaByrrKtiX4f3VPnBc7Zi9PfagpXqeljPrgoaRW1c1wEHmHp87S6bxFkLBJa4DEs9tTOuL47jklOKScyIiNQk04oARDxxiD2FWlHZeuXWkRKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254133; c=relaxed/simple;
	bh=tkl4gPER+y4+Akg5DZMGXLfG2YKaqFBo2J9vprBL+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVfP7ZEJu+CcwzWtGxTm+2oNDAqZodqAhUiZk9yoqX9THQHoBjtUDuia1GHmWil8X1IAk0mQ88HwmTGJ1eiv2Yc90Jg/0ROol/0AIv442jW3qNeTiIbT11HuQZ6GLEI15qM2jteHLBd+h3ftIcNGZH7+obJ4BXfhsp2I21e/TuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBJ7RkYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C047C4CEE7;
	Wed, 23 Jul 2025 07:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753254133;
	bh=tkl4gPER+y4+Akg5DZMGXLfG2YKaqFBo2J9vprBL+YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBJ7RkYLPMWM3MezXPPQfLIO2Ywhs2B03q5bLIn6J1R4duLR5PA4UmKbRjY4Pwa2w
	 A/5hCZ8T7d7x0NzgqedBaeGy1tNhTLivvXqa45P/+ZynXQ1EZQFXQlaxUW/GpVtZN0
	 tzQ3GdbYLRDdVPFUTVN03OV+oYVUHx1rnr+7b0XKS1M082o5lh7bcQhM1yNVSZBzPs
	 sUYGGy4Xyts8WV2LVeySFKhSEe+cxmkcDtgiAwLXDTcBbNT3iT/KuDQ46907NZjnc/
	 QSStfe8a1DKwFh11oxoNtFVrPI0fi+53sD4fUX7XL0cfYqDVP9ASsIuwjBjVojAwbH
	 2klGo14SBPtnQ==
Date: Wed, 23 Jul 2025 00:02:12 -0700
From: Kees Cook <kees@kernel.org>
To: xandfury@gmail.com
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/tty: add TIOCSTI test suite
Message-ID: <202507222329.D44E6AC@keescook>
References: <20250713-toicsti-bug-v2-1-b183787eea29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250713-toicsti-bug-v2-1-b183787eea29@gmail.com>

On Sun, Jul 13, 2025 at 06:38:55PM -0600, Abhinav Saxena via B4 Relay wrote:
> From: Abhinav Saxena <xandfury@gmail.com>
> 
> TIOCSTI is a TTY ioctl command that allows inserting characters into
> the terminal input queue, making it appear as if the user typed those
> characters.
> 
> Add a test suite with four tests to verify TIOCSTI behaviour in
> different scenarios when dev.tty.legacy_tiocsti is both enabled and
> disabled:
> 
> - Test TIOCSTI functionality when legacy support is enabled
> - Test TIOCSTI rejection when legacy support is disabled
> - Test capability requirements for TIOCSTI usage
> - Test TIOCSTI security with file descriptor passing
> 
> The tests validate proper enforcement of the legacy_tiocsti sysctl
> introduced in commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled").
> See tty_ioctl(4) for details on TIOCSTI behavior and security
> requirements.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
> This patch adds comprehensive selftests for the TIOCSTI ioctl to validate
> proper behaviour under different system configurations.

Much of the text under the --- line is useful details; I would merge it
with the short commit log above to make a comprehensive commit message.

> 
> ===============
> 
> The TIOCSTI ioctl allows inserting characters into the terminal input
> queue, making it appear as if the user typed those characters. This
> functionality has security implications and behaviour that varies based
> on system configuration.
> 
> Background
> ==========
> 
> CONFIG_LEGACY_TIOCSTI controls the default value for the dev.tty.legacy_tiocsti
> sysctl, which remains runtime-configurable. The dev.tty.legacy_tiocsti sysctl
> was introduced in commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> to provide administrators control over TIOCSTI usage.
> 
> When legacy_tiocsti is disabled, TIOCSTI requires CAP_SYS_ADMIN capability.
> However, the current implementation only checks the current process's
> credentials via capable(CAP_SYS_ADMIN), which doesn't validate against
> the file opener's credentials stored in file->f_cred.
> 
> This creates a potential security scenario where an unprivileged process
> can open a TTY fd and pass it to a privileged process via SCM_RIGHTS.
> 
> Testing
> =======
> 
> The test suite includes four comprehensive tests:
> - Test TIOCSTI functionality when legacy support is enabled
> - Test TIOCSTI rejection when legacy support is disabled  
> - Test capability requirements for TIOCSTI usage
> - Test TIOCSTI security with file descriptor passing
> 
> All patches have been validated using:
> - scripts/checkpatch.pl --strict (0 errors, 0 warnings)
> - Functional testing on kernel v6.16-rc2
> - File descriptor passing security test scenarios
> 
> The fd_passing_security test demonstrates the security concern.
> To verify, disable legacy TIOCSTI and run the test:
> 
> $ echo "0" | sudo tee /proc/sys/dev/tty/legacy_tiocsti
> $ sudo ./tools/testing/selftests/tty/tty_tiocsti_test -t fd_passing_security
> 
> Patch Overview
> ==============
> 
> PATCH 1/1: selftests/tty: add TIOCSTI test suite
> Comprehensive test suite demonstrating the issue and fix validation
> 
> References
> ==========
> 
> - tty_ioctl(4) - documents TIOCSTI ioctl and capability requirements
> - commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> - Documentation/security/credentials.rst
> - https://github.com/KSPP/linux/issues/156
> - https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad/
> - drivers/tty/Kconfig
> 
> Configuration References:
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/Kconfig#n149
> [2] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/Kconfig#n162
> [3] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/Kconfig#n188
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> 
> Changes in v2:
> - Focused series on selftests only
> - Removed SELinux capability checking patch for separate submission
> - Link to v1: https://lore.kernel.org/r/20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com
> ---
>  tools/testing/selftests/tty/Makefile           |   6 +-
>  tools/testing/selftests/tty/config             |   1 +
>  tools/testing/selftests/tty/tty_tiocsti_test.c | 421 +++++++++++++++++++++++++
>  3 files changed, 427 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftests/tty/Makefile
> index 50d7027b2ae3..7f6fbe5a0cd5 100644
> --- a/tools/testing/selftests/tty/Makefile
> +++ b/tools/testing/selftests/tty/Makefile
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS = -O2 -Wall
> -TEST_GEN_PROGS := tty_tstamp_update
> +TEST_GEN_PROGS := tty_tstamp_update tty_tiocsti_test
> +LDLIBS += -lcap
>  
>  include ../lib.mk
> +
> +# Add libcap for TIOCSTI test
> +$(OUTPUT)/tty_tiocsti_test: LDLIBS += -lcap
> diff --git a/tools/testing/selftests/tty/config b/tools/testing/selftests/tty/config
> new file mode 100644
> index 000000000000..c6373aba6636
> --- /dev/null
> +++ b/tools/testing/selftests/tty/config
> @@ -0,0 +1 @@
> +CONFIG_LEGACY_TIOCSTI=y
> diff --git a/tools/testing/selftests/tty/tty_tiocsti_test.c b/tools/testing/selftests/tty/tty_tiocsti_test.c
> new file mode 100644
> index 000000000000..6a4b497078b0
> --- /dev/null
> +++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TTY Tests - TIOCSTI
> + *
> + * Copyright © 2025 Abhinav Saxena <xandfury@gmail.com>
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
> +
> +#include "../kselftest_harness.h"
> +
> +/* Helper function to send FD via SCM_RIGHTS */
> +static int send_fd_via_socket(int socket_fd, int fd_to_send)
> +{
> +	struct msghdr msg = { 0 };
> +	struct cmsghdr *cmsg;
> +	char cmsg_buf[CMSG_SPACE(sizeof(int))];
> +	char dummy_data = 'F';
> +	struct iovec iov = { .iov_base = &dummy_data, .iov_len = 1 };
> +
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_control = cmsg_buf;
> +	msg.msg_controllen = sizeof(cmsg_buf);
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level = SOL_SOCKET;
> +	cmsg->cmsg_type = SCM_RIGHTS;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
> +
> +	memcpy(CMSG_DATA(cmsg), &fd_to_send, sizeof(int));
> +
> +	return sendmsg(socket_fd, &msg, 0) < 0 ? -1 : 0;
> +}
> +
> +/* Helper function to receive FD via SCM_RIGHTS */
> +static int recv_fd_via_socket(int socket_fd)
> +{
> +	struct msghdr msg = { 0 };
> +	struct cmsghdr *cmsg;
> +	char cmsg_buf[CMSG_SPACE(sizeof(int))];
> +	char dummy_data;
> +	struct iovec iov = { .iov_base = &dummy_data, .iov_len = 1 };
> +	int received_fd = -1;
> +
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_control = cmsg_buf;
> +	msg.msg_controllen = sizeof(cmsg_buf);
> +
> +	if (recvmsg(socket_fd, &msg, 0) < 0)
> +		return -1;
> +
> +	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +		if (cmsg->cmsg_level == SOL_SOCKET &&
> +		    cmsg->cmsg_type == SCM_RIGHTS) {
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
> +	cap_t caps = cap_get_proc();
> +
> +	if (!caps)
> +		return false;
> +
> +	cap_flag_value_t cap_val;
> +	bool has_cap = (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE,
> +				     &cap_val) == 0) &&
> +		       (cap_val == CAP_SET);
> +
> +	cap_free(caps);
> +	return has_cap;
> +}
> +
> +/*
> + * Simple privilege drop that just changes uid/gid in current process
> + * and also capabilities like CAP_SYS_ADMIN
> + */
> +static inline bool drop_to_nobody(void)
> +{
> +	/* Drop supplementary groups */
> +	if (setgroups(0, NULL) != 0) {
> +		printf("setgroups failed: %s", strerror(errno));
> +		return false;
> +	}
> +
> +	/* Change group to nobody */
> +	if (setgid(65534) != 0) {
> +		printf("setgid failed: %s", strerror(errno));
> +		return false;
> +	}
> +
> +	/* Change user to nobody (this drops capabilities) */
> +	if (setuid(65534) != 0) {
> +		printf("setuid failed: %s", strerror(errno));
> +		return false;
> +	}
> +
> +	/* Verify we no longer have CAP_SYS_ADMIN */
> +	if (has_cap_sys_admin()) {
> +		printf("ERROR: Still have CAP_SYS_ADMIN after changing to nobody");
> +		return false;
> +	}
> +
> +	printf("Successfully changed to nobody (uid:%d gid:%d)\n", getuid(),
> +	       getgid());
> +	return true;
> +}

All of the bare printfs above should use TH_LOG()

> +
> +static inline int get_legacy_tiocsti_setting(void)
> +{
> +	FILE *fp;
> +	int value = -1;
> +
> +	fp = fopen("/proc/sys/dev/tty/legacy_tiocsti", "r");
> +	if (!fp) {
> +		if (errno == ENOENT) {
> +			printf("legacy_tiocsti sysctl not available (kernel < 6.2)\n");
> +		} else {
> +			printf("Cannot read legacy_tiocsti: %s\n",
> +			       strerror(errno));
> +		}
> +		return -1;
> +	}
> +
> +	if (fscanf(fp, "%d", &value) == 1) {
> +		printf("legacy_tiocsti setting=%d\n", value);
> +
> +		if (value < 0 || value > 1) {
> +			printf("legacy_tiocsti unexpected value %d\n", value);
> +			value = -1;
> +		} else {
> +			printf("legacy_tiocsti=%d (%s mode)\n", value,
> +			       value == 0 ? "restricted" : "permissive");
> +		}
> +	} else {
> +		printf("Failed to parse legacy_tiocsti value");
> +		value = -1;
> +	}
> +
> +	fclose(fp);
> +	return value;
> +}

Same observation as above that reporting should go through the kselftest
harness APIs.

> +
> +static inline int test_tiocsti_injection(int fd)
> +{
> +	int ret;
> +	char test_char = 'X';
> +
> +	ret = ioctl(fd, TIOCSTI, &test_char);
> +	if (ret == 0) {
> +		/* Clear the injected character */
> +		printf("TIOCSTI injection succeeded\n");
> +	} else {
> +		printf("TIOCSTI injection failed: %s (errno=%d)\n",
> +		       strerror(errno), errno);
> +	}
> +	return ret == 0 ? 0 : -1;
> +}

Same. Note for each of these you'll need to pass in the test metadata
(struct __test_metadata *_metadata). See helper examples that do this
in tools/testing/selftests/seccomp/seccomp_bpf.c like tracer_poke(),
get_syscall(), etc.

> +
> +FIXTURE(tty_tiocsti)
> +{
> +	int tty_fd;
> +	char *tty_name;
> +	bool has_tty;
> +	bool initial_cap_sys_admin;
> +	int legacy_tiocsti_setting;
> +};
> +
> +FIXTURE_SETUP(tty_tiocsti)
> +{
> +	TH_LOG("Running as UID: %d with effective UID: %d", getuid(),
> +	       geteuid());
> +
> +	self->tty_fd = open("/dev/tty", O_RDWR);
> +	self->has_tty = (self->tty_fd >= 0);
> +
> +	if (self->tty_fd < 0)
> +		TH_LOG("Cannot open /dev/tty: %s", strerror(errno));

I would expect this to be:

	ASSERT_GE(self->tty_fd, 0) {
		TH_LOG("Cannot open /dev/tty: %s", strerror(errno));
	}

> +
> +	self->tty_name = ttyname(STDIN_FILENO);
> +	TH_LOG("Current TTY: %s", self->tty_name ? self->tty_name : "none");
> +
> +	self->initial_cap_sys_admin = has_cap_sys_admin();
> +	TH_LOG("Initial CAP_SYS_ADMIN: %s",
> +	       self->initial_cap_sys_admin ? "yes" : "no");
> +
> +	self->legacy_tiocsti_setting = get_legacy_tiocsti_setting();
> +}
> +
> +FIXTURE_TEARDOWN(tty_tiocsti)
> +{
> +	if (self->has_tty && self->tty_fd >= 0)
> +		close(self->tty_fd);
> +}
> +
> +/* Test case 1: legacy_tiocsti != 0 (permissive mode) */
> +TEST_F(tty_tiocsti, permissive_mode)
> +{
> +	// clang-format off

While there are instances in the tree of "//" please use /* */ for
comments, even these format pragmas.

> +	if (self->legacy_tiocsti_setting < 0)
> +		SKIP(return,
> +		     "legacy_tiocsti sysctl not available (kernel < 6.2)");

I notice this check is in every test. I think it'd be cleaner to put it
into FIXTURE_SETUP() instead.

> +
> +	if (self->legacy_tiocsti_setting == 0)
> +		SKIP(return,
> +		     "Test requires permissive mode (legacy_tiocsti=1)");

What about changing this value during FIXTURE_SETUP() and restoring it
in FIXTURE_TEARDOWN()?

> +	// clang-format on
> +
> +	ASSERT_TRUE(self->has_tty);

Can opening a pty (i.e. openpty(3)) be used to always have a tty
available?

> +
> +	if (self->initial_cap_sys_admin) {
> +		ASSERT_TRUE(drop_to_nobody());
> +		ASSERT_FALSE(has_cap_sys_admin());
> +	}
> +
> +	/* In permissive mode, TIOCSTI should work without CAP_SYS_ADMIN */
> +	EXPECT_EQ(test_tiocsti_injection(self->tty_fd), 0)

With openpty() I think it would also mean you can trivially throw
away injected characters instead of having them actually end up on the
real tty? But it's been a while since I did tty work, so maybe I'm
confusing myself about what openpty() gets you.

> +	{
> +		TH_LOG("TIOCSTI should succeed in permissive mode without CAP_SYS_ADMIN");
> +	}
> +}
> +
> +/* Test case 2: legacy_tiocsti == 0, without CAP_SYS_ADMIN (should fail) */
> +TEST_F(tty_tiocsti, restricted_mode_nopriv)
> +{
> +	// clang-format off
> +	if (self->legacy_tiocsti_setting < 0)
> +		SKIP(return,
> +		     "legacy_tiocsti sysctl not available (kernel < 6.2)");
> +
> +	if (self->legacy_tiocsti_setting != 0)
> +		SKIP(return,
> +		     "Test requires restricted mode (legacy_tiocsti=0)");

I think it should be possible to _set_ the state you want (if running as
root) and if not settable, then do the SKIP.

> +	// clang-format on
> +
> +	ASSERT_TRUE(self->has_tty);
> +
> +	if (self->initial_cap_sys_admin) {
> +		ASSERT_TRUE(drop_to_nobody());
> +		ASSERT_FALSE(has_cap_sys_admin());
> +	}
> +	/* In restricted mode, TIOCSTI should fail without CAP_SYS_ADMIN */
> +	EXPECT_EQ(test_tiocsti_injection(self->tty_fd), -1);
> +
> +	/*
> +	 * it might fail with either EPERM or EIO
> +	 * EXPECT_TRUE(errno == EPERM || errno == EIO)
> +	 * {
> +	 *      TH_LOG("Expected EPERM, got: %s", strerror(errno));
> +	 * }
> +	 */

Why are these commented out?

> +}
> +
> +/* Test case 3: legacy_tiocsti == 0, with CAP_SYS_ADMIN (should succeed) */
> +TEST_F(tty_tiocsti, restricted_mode_priv)
> +{
> +	// clang-format off
> +	if (self->legacy_tiocsti_setting < 0)
> +		SKIP(return,
> +		     "legacy_tiocsti sysctl not available (kernel < 6.2)");
> +
> +	if (self->legacy_tiocsti_setting != 0)
> +		SKIP(return,
> +		     "Test requires restricted mode (legacy_tiocsti=0)");
> +	// clang-format on
> +
> +	/* Must have CAP_SYS_ADMIN for this test */
> +	if (!self->initial_cap_sys_admin)
> +		SKIP(return, "Test requires CAP_SYS_ADMIN");
> +
> +	ASSERT_TRUE(self->has_tty);
> +	ASSERT_TRUE(has_cap_sys_admin());
> +
> +	/* In restricted mode, TIOCSTI should succeed with CAP_SYS_ADMIN */
> +	EXPECT_EQ(test_tiocsti_injection(self->tty_fd), 0)
> +	{
> +		TH_LOG("TIOCSTI should succeed in restricted mode with CAP_SYS_ADMIN");
> +	}
> +}
> +
> +/* Test TIOCSTI security with file descriptor passing */
> +TEST_F(tty_tiocsti, fd_passing_security)
> +{
> +	// clang-format off
> +	if (self->legacy_tiocsti_setting < 0)
> +		SKIP(return,
> +		     "legacy_tiocsti sysctl not available (kernel < 6.2)");
> +
> +	if (self->legacy_tiocsti_setting != 0)
> +		SKIP(return,
> +		     "Test requires restricted mode (legacy_tiocsti=0)");
> +	// clang-format on
> +
> +	/* Must start with CAP_SYS_ADMIN */
> +	if (!self->initial_cap_sys_admin)
> +		SKIP(return, "Test requires initial CAP_SYS_ADMIN");
> +
> +	int sockpair[2];
> +	pid_t child_pid;
> +
> +	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sockpair), 0);
> +
> +	child_pid = fork();
> +	ASSERT_GE(child_pid, 0)
> +	TH_LOG("Fork failed: %s", strerror(errno));
> +
> +	if (child_pid == 0) {
> +		/* Child process - become unprivileged, open TTY, send FD to parent */
> +		close(sockpair[0]);
> +
> +		TH_LOG("Child: Dropping privileges...");
> +
> +		/* Drop to nobody user (loses all capabilities) */
> +		drop_to_nobody();
> +
> +		/* Verify we no longer have CAP_SYS_ADMIN */
> +		if (has_cap_sys_admin()) {
> +			TH_LOG("Child: Failed to drop CAP_SYS_ADMIN");
> +			_exit(1);
> +		}

Please double check the behavior but I think you can use ASSERTs in the
child and you don't need the "_exit(1)" stuff.

> +
> +		TH_LOG("Child: Opening TTY as unprivileged user...");
> +
> +		int unprivileged_tty_fd = open("/dev/tty", O_RDWR);
> +
> +		if (unprivileged_tty_fd < 0) {
> +			TH_LOG("Child: Cannot open TTY: %s", strerror(errno));
> +			_exit(1);
> +		}
> +
> +		/* Test that we can't use TIOCSTI directly (should fail) */
> +
> +		char test_char = 'X';
> +
> +		if (ioctl(unprivileged_tty_fd, TIOCSTI, &test_char) == 0) {
> +			TH_LOG("Child: ERROR - Direct TIOCSTI succeeded unexpectedly!");
> +			close(unprivileged_tty_fd);
> +			_exit(1);
> +		}
> +		TH_LOG("Child: Good - Direct TIOCSTI failed as expected: %s",
> +		       strerror(errno));
> +
> +		/* Send the TTY FD to privileged parent via SCM_RIGHTS */
> +		TH_LOG("Child: Sending TTY FD to privileged parent...");
> +		if (send_fd_via_socket(sockpair[1], unprivileged_tty_fd) != 0) {
> +			TH_LOG("Child: Failed to send FD");
> +			close(unprivileged_tty_fd);
> +			_exit(1);
> +		}
> +
> +		close(unprivileged_tty_fd);
> +		close(sockpair[1]);
> +		_exit(0); /* Child success */
> +
> +	} else {

This doesn't need an else nor indenting: it is the parent no matter what
due to the _exit above.

> +		/* Parent process - keep CAP_SYS_ADMIN, receive FD, test TIOCSTI */
> +		close(sockpair[1]);
> +
> +		TH_LOG("Parent: Waiting for TTY FD from unprivileged child...");
> +
> +		/* Verify we still have CAP_SYS_ADMIN */
> +		ASSERT_TRUE(has_cap_sys_admin());
> +
> +		/* Receive the TTY FD from unprivileged child */
> +		int received_fd = recv_fd_via_socket(sockpair[0]);
> +
> +		ASSERT_GE(received_fd, 0)
> +		TH_LOG("Parent: Received FD %d (opened by unprivileged process)",
> +		       received_fd);
> +
> +		/*
> +		 * VULNERABILITY TEST: Try TIOCSTI with FD opened by unprivileged process
> +		 * This should FAIL even though parent has CAP_SYS_ADMIN
> +		 * because the FD was opened by unprivileged process
> +		 */
> +		char attack_char = 'V'; /* V for Vulnerability */
> +		int ret = ioctl(received_fd, TIOCSTI, &attack_char);

Doesn't the child need to stay alive long enough to receive the
character? i.e. is it a problem that the child immediately exits 0 after
sending the fd to the parent?

> +
> +		TH_LOG("Parent: Testing TIOCSTI on FD from unprivileged process...");
> +		if (ret == 0) {
> +			TH_LOG("*** VULNERABILITY DETECTED ***");
> +			TH_LOG("Privileged process can use TIOCSTI on unprivileged FD");
> +		} else {
> +			TH_LOG("TIOCSTI failed on unprivileged FD: %s",
> +			       strerror(errno));
> +			EXPECT_EQ(errno, EPERM);
> +		}

Shouldn't this be arranged with an expect on ret == 0 ?


> +		close(received_fd);
> +		close(sockpair[0]);
> +
> +		/* Wait for child */
> +		int status;
> +
> +		ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
> +		EXPECT_EQ(WEXITSTATUS(status), 0);
> +		ASSERT_NE(ret, 0);
> +	}
> +}
> +
> +TEST_HARNESS_MAIN

Looks like you're on the right track!

-Kees

-- 
Kees Cook

