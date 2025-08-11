Return-Path: <linux-kselftest+bounces-38732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D604B21976
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574E7621429
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD112153D4;
	Mon, 11 Aug 2025 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNQdLPcr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F4158DAC
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955575; cv=none; b=tqgzKzcWwdKN3KBE/GSncvDHPt4XAJP/UYdSFBzB5f/+wARQihIW5TpmXHkSAd+js8ovIYEuOeCvuFtq12e3hQIIIkMWNo9lLaimExyUiJW3PqdrK+Sjd/CO01CvsYVe/Bj/DGtmOPY++rkCIHFjWG9hL7iXRJ/t3AQYL5DU7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955575; c=relaxed/simple;
	bh=CgsHhYKuzt2u/unQTOKXZO6yYr3HlUlJ26LVRKOATkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyTHnCQkX+U0WPeaRranKalUebiLFNx9ZYl6wjaCphmzoiuCbo/E0qlTvS76GCj8tRQsqHU24p+jcDAncXMMPlMkhuHQSum3dXQcwhx3NB6nDMjyGuC0375XHem6dzAv9APT1Z6Zf2zZ7YRtmUrh6hgAhCLObj72YD2I/O2AUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNQdLPcr; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e5328231e6so13265525ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754955572; x=1755560372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8lKenfnjZgeAQPLlLmbgh5W75Wb8BtdzZVIVKBkQ4ic=;
        b=CNQdLPcryBXMnf7F15ZQRLaBh+AgRgrch2JnTIpkYxHmhNgEhrdEGubehakXbJGCjM
         nJ0mqF7TguAXdqoxGytg+Tmd3ycv6kWIQ9hj5Wh1uKC2+PcEvYdrDnhcJ4eRFbYIbjMc
         BIobw5VGjI8feXld6JwCCfftr/VFdE0H1FrPgxts58T3xqkgLySnsqwL1RQu3aebRlCO
         hdkE8gUl3JQAnomZIk9aHY5Ug8qW35SDI8s7HgTxEVcdr79Roim+G6ve1NxawJkD7pqN
         N5zULoq7PF+PN20cTwu0o/eMzO+Nk294r18jPPF2lRN5L7WHrEmvHcs3E3UBQxH8pRDZ
         JcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754955572; x=1755560372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lKenfnjZgeAQPLlLmbgh5W75Wb8BtdzZVIVKBkQ4ic=;
        b=N7z0sjgDJ0fxsapTe9RHXcIRFokREIXc0BgqugNpAqI0Nu5Q4E4RZQfBM/TnJVN6QU
         u1UqFcIemDqSf97pIZ0BrYeJdPAU6r8TfFTdGnHxdKPoMjtMrhQbDo6/ZkjUItm+X31h
         tfSqjV1bHJjtnTljCyroRjizzlkjhJyy95aoG3bn4kGAv7WHHlOieewYy5dqaGROYoJD
         vFFy948J3COU3zwUzwligzPjSgQJiEnPkhqAf9uzmzv/oWVeHsbGBUmPdz9Y8U0Qu8Dl
         UVagDHwB+SGEQEznpFm8u0aOks48gAER1gA3q3yWD+H6hQVBpuCEYlylke/CGtefMpla
         Ld2g==
X-Forwarded-Encrypted: i=1; AJvYcCU+CM71saPlA7DsdzPmoiTU8Sa0m2l7dlJlt05Cbvb+aiN4dah8VyFBHfUDLGw3QY5YcpkYEpOEMvQxGcsphok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMP0hSMkyp86MlkXp7AWHtWBlY5oOKEeSDW2R5QXhmpUTrMWxp
	IZk7TmenThZENWFEJxF8v14vZH49fqAtIEtBpNPatGnxe4MJPNALhc2b0APz05MduA==
X-Gm-Gg: ASbGncv4f1YoUpjfzFySyrGaikk8N/iUV6PfxfAT0pkwhoJiKZ6J6KfDAemUIWM4iOb
	Ce6SKseWj31siKMCFLugWGP/NxOTEQv8iaYHxeEasbYBYBQNnbitQdsJmh76nnn50msOimmHFFW
	0q/krmBosx2eriH7PGlM/uc9vUVq8TiTmXU1Lw+L/DTsW4Aen2nYpEFOupgmdKNy1gUwxOiRver
	gGLwCVRAcEzQIZyzlhTBJA5XF5N/Q3vyjemSsMv4u/hk2Q6M7sBhOjUko+g7CSXaqVAjnfSi0L0
	Tox6xccqvJtWVEJqTRVvOA+t/oaIriHj6oBAjcKMuOz/moNrgoa+FCHFqkBoJEn2dYxPAcUCpMm
	kInRkr5DL9U8e+A1LRHYn8JJFMYGLA3hbP0WPjGYkZs8foos3OSfno+wqPONh5huBBBE=
X-Google-Smtp-Source: AGHT+IEqxzGHtVJxoiq1h2xC6cI4AXui0X5as8mt43CBZ5R7sj8uOt7w5q5EAKKhBnmgylY8YfNfZw==
X-Received: by 2002:a05:6e02:b28:b0:3e5:5357:6df3 with SMTP id e9e14a558f8ab-3e55af21d10mr25814135ab.8.1754955572046;
        Mon, 11 Aug 2025 16:39:32 -0700 (PDT)
Received: from google.com (39.173.198.104.bc.googleusercontent.com. [104.198.173.39])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e5536236eesm11555385ab.21.2025.08.11.16.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:39:31 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:39:27 -0700
From: Justin Stitt <justinstitt@google.com>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] selftests/tty: add TIOCSTI test suite
Message-ID: <ytndgs2vwkhijeuruejvk55geqouuditkjpge6u7gb6qt6hxqa@uh2wnuapkb5f>
References: <20250730-toicsti-bug-v3-1-dd2dac97f27a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730-toicsti-bug-v3-1-dd2dac97f27a@gmail.com>

Hi,

On Wed, Jul 30, 2025 at 06:14:43PM -0600, Abhinav Saxena wrote:

<snip>

> ---
>  tools/testing/selftests/tty/Makefile           |   6 +-
>  tools/testing/selftests/tty/config             |   1 +
>  tools/testing/selftests/tty/tty_tiocsti_test.c | 650 +++++++++++++++++++++++++
>  3 files changed, 656 insertions(+), 1 deletion(-)
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

Is it necessary to append -lcap to LDLIBS twice? Once globally and once
for that TU?

> diff --git a/tools/testing/selftests/tty/config b/tools/testing/selftests/tty/config
> new file mode 100644
> index 000000000000..c6373aba6636
> --- /dev/null
> +++ b/tools/testing/selftests/tty/config
> @@ -0,0 +1 @@
> +CONFIG_LEGACY_TIOCSTI=y
> diff --git a/tools/testing/selftests/tty/tty_tiocsti_test.c b/tools/testing/selftests/tty/tty_tiocsti_test.c
> new file mode 100644
> index 000000000000..1eafef6e36fa
> --- /dev/null
> +++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
> @@ -0,0 +1,650 @@
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
> +#include <pty.h>
> +#include <utmp.h>
> +
> +#include "../kselftest_harness.h"
> +
> +enum test_type {
> +	TEST_PTY_TIOCSTI_BASIC,
> +	TEST_PTY_TIOCSTI_FD_PASSING,
> +	/* other tests cases such as serial may be added. */
> +};
> +
> +/*
> + * Test Strategy:
> + * - Basic tests: Use PTY with/without TIOCSCTTY (controlling terminal for
> + *   current process)
> + * - FD passing tests: Child creates PTY, parent receives FD (demonstrates
> + *   security issue)
> + *
> + * SECURITY VULNERABILITY DEMONSTRATION:
> + * FD passing tests show that TIOCSTI uses CURRENT process credentials, not
> + * opener credentials. This means privileged processes can be given FDs from
> + * unprivileged processes and successfully perform TIOCSTI operations that the
> + * unprivileged process couldn't do directly.
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
> + * 2. if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
> + *        return -EPERM;
> + * Note: Both checks use capable() on CURRENT process, not FD opener!
> + *
> + * If the file credentials were also checked along with the capable() checks
> + * then the results for FD pass tests would be consistent with the basic tests.
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
> +	const bool controlling_tty; /* true=current->signal->tty == tty */
> +	const int legacy_tiocsti; /* 0=restricted, 1=permissive */
> +	const bool requires_cap; /* true=with CAP_SYS_ADMIN, false=without */
> +	const int expected_success; /* 0=success, -EIO/-EPERM=specific error */
> +};
> +
> +/*
> + * Tests Controlling Terminal Variants (current->signal->tty == tty)
> + *
> + * TIOCSTI Test Matrix:
> + *
> + * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
> + * |----------------|---------------|-----------------|-------|
> + * | 1 (permissive) | true          | SUCCESS         | -     |
> + * | 1 (permissive) | false         | SUCCESS         | -     |
> + * | 0 (restricted) | true          | SUCCESS         | -     |
> + * | 0 (restricted) | false         | FAILURE         | -EIO  |
> + */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_permissive_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = false,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_pty_restricted_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = false,
> +	.expected_success = -EIO, /* FAILURE: legacy restriction */
> +}; /* clang-format on */
> +
> +/*
> + * Note for FD Passing Test Variants
> + * Since we're testing the scenario where an unprivileged process pass an FD
> + * to a privileged one, .requires_cap here means the caps of the child process.
> + * Not the parent; parent would always be privileged.
> + */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_permissive_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = false,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_pty_restricted_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = true,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = false,
> +	.expected_success = -EIO,
> +}; /* clang-format on */
> +
> +/*
> + * Non-Controlling Terminal Variants (current->signal->tty != tty)
> + *
> + * TIOCSTI Test Matrix:
> + *
> + * | legacy_tiocsti | CAP_SYS_ADMIN | Expected Result | Error |
> + * |----------------|---------------|-----------------|-------|
> + * | 1 (permissive) | true          | SUCCESS         | -     |
> + * | 1 (permissive) | false         | FAILURE         | -EPERM|
> + * | 0 (restricted) | true          | SUCCESS         | -     |
> + * | 0 (restricted) | false         | FAILURE         | -EIO  |
> + */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_permissive_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = false,
> +	.expected_success = -EPERM,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, basic_nopty_restricted_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_BASIC,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = false,
> +	.expected_success = -EIO,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_permissive_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 1,
> +	.requires_cap = false,
> +	.expected_success = -EPERM,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_withcap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = true,
> +	.expected_success = 0,
> +};
> +
> +FIXTURE_VARIANT_ADD(tiocsti, fdpass_nopty_restricted_nocap) {
> +	.test_type = TEST_PTY_TIOCSTI_FD_PASSING,
> +	.controlling_tty = false,
> +	.legacy_tiocsti = 0,
> +	.requires_cap = false,
> +	.expected_success = -EIO,
> +}; /* clang-format on */
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
> + * Drop to nobody user (uid/gid 65534) to lose all capabilities
> + */
> +static inline bool drop_to_nobody(struct __test_metadata *_metadata)
> +{

Maybe we can retrieve the uid/gid from getpwnam(3) with:
  const struct passwd *pw = getpwnam("nobody");

... then use pw->pw_{uid,gid}. I suggest this because there might be
portability issues with the hardcoded 65534 -- not 100% sure though.

> +	ASSERT_EQ(setgroups(0, NULL), 0);
> +	ASSERT_EQ(setgid(65534), 0);
> +	ASSERT_EQ(setuid(65534), 0);
> +
> +	ASSERT_FALSE(has_cap_sys_admin());
> +	return true;
> +}
> +
> +static inline int get_legacy_tiocsti_setting(struct __test_metadata *_metadata)
> +{
> +	FILE *fp;
> +	int value = -1;
> +
> +	fp = fopen("/proc/sys/dev/tty/legacy_tiocsti", "r");
> +	if (!fp) {
> +		/* legacy_tiocsti sysctl not available (kernel < 6.2) */
> +		return -1;
> +	}
> +
> +	if (fscanf(fp, "%d", &value) == 1) {
> +		if (value < 0 || value > 1)
> +			value = -1; /* Invalid value */
> +	} else {
> +		value = -1; /* Failed to parse */
> +	}
> +
> +	fclose(fp);
> +	return value;
> +}
> +

<snip>

> ---
> base-commit: 283564a43383d6f26a55546fe9ae345b5fa95e66
> change-id: 20250618-toicsti-bug-7822b8e94a32
> 
> Best regards,
> -- 
> Abhinav Saxena <xandfury@gmail.com>
> 
>

Justin

