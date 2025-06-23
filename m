Return-Path: <linux-kselftest+bounces-35618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338AEAE40E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A53A5275
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A3246BCF;
	Mon, 23 Jun 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI2qJtQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA724293F;
	Mon, 23 Jun 2025 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682591; cv=none; b=NrRnE9QmgK8whwazmNQ+uBseu3GE9iAUj5VydMh7iG+UaHFKPQ182MzwinYMtuMHym6Fc8T6kxWC11NO7YaZDcP43Iyu8+3k/4t/uco6u47UC/78pei9/JkkGoX9dnMMHD27EiuCj7RMbIrC3YZ+x9BxanMbYGszINGu9XvMIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682591; c=relaxed/simple;
	bh=PB0HEPfkucRrxQtxIW4pW7KCu6BeVNdgu0MhdMBEdl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5RZABgVtIMaKhmGl7j0D9Q3nDiuHLDKjO8EmK77QAB9TF1MABNbVdNovzoCOg0yzfE7HrZHDaOPeUV1iGctz1Z9v7oGRSitepCVOjhSVcfwyE5UQZ+cj/0CdgpZHcrOJxZTjns87wk6p951zXibMnktKrGSc6fGZFlgZZL+wlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI2qJtQB; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso4832734a12.0;
        Mon, 23 Jun 2025 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750682589; x=1751287389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf1OGgbtzTJzV1PRfiAJELF6SYkpk/RT7K6+y4139X0=;
        b=CI2qJtQBaFa4p+FoTEzW5Rte5a06rsWZrGbd1ZgtgLDO1RC7AM+lWLvH9Ux/LQqsQp
         B4sLA5QU2B/kzNeK+/nQ69nV3hsCS0eI6NG1Weeu28idMIxxzz+IauIJGpV7VCoEEytE
         PQP3K9sxwW5FL3dgs07dUWWxXmC5pbHYNUa8mcMfsTaW03sywF5FX9oS6ddDEUe37TYU
         kI5NCSycLW5WsjppWsBku+XupA6ZF5bctSj6gqyWJGmyFC7tKuRKcgO5Jb/ox5hCfVwS
         GIuNh5rG5ngd7HTJT7rDHveX2kylfvZEKfewqk4VcvWnb1khcTieaQu6XIKr655LUxJQ
         RwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750682589; x=1751287389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf1OGgbtzTJzV1PRfiAJELF6SYkpk/RT7K6+y4139X0=;
        b=qNsTtkyKoJBSysxUvPb5zt6n0t6SEOrUOyu61+8SNHLRU/87YxCG0C/eJJFZa6Li41
         uCxiAQNNWSYlUpE3MsdYhSMKk379ov8MKuZkdbhOtJgMem3WC/xK4ndK0bCc7aXLhRST
         REPxu659kjnJ94VsjVOfQKSsD4agZhVcQXwsabAl1fycurjvzYHE5MmxKYAYJFX/8yFL
         fGCrYZ2T2XZ/abPcj+9osX5pBoGRfMOVcCNoi8Sg8h4X+CqOv1HyF48+bQDP59tZ9wiN
         XhZvOyTOa4tgd1oUVbnGhoCEnz7FnwQKxuhmzNkcWLa0KV2FgNNnRcdYDfVhXLGQTUgK
         5EsA==
X-Forwarded-Encrypted: i=1; AJvYcCU1DaOYZNc4xlq81NRXgZoZC3CNjASBlKLxL8Us/U4TVhd2KXBtzxdA7Fc1o8mhja7vNQtsZnrTHRN5b4ft@vger.kernel.org, AJvYcCVYtZi2h3Dhl97MsWXY+cHzTg6Fy6+MWwbQwY0DaXGcrBQBPSmJkFKFoUKxgn3Mqjlf5sYHyHGgWUTfgBVeu2Pz@vger.kernel.org, AJvYcCWWqoXb7bPeV145SfpRG4GRpUvbBaG2Q0NutuPeuDxKK5Njz5qp+rH7QFJqGJBKuZP4apPeKKR86w==@vger.kernel.org, AJvYcCX9thDvQxYyCZ2k7GWjtmSLttKK+T7tKRP4stQZ9Gs2PqRKneuUQH5XYJ3yxu+MKFHclCWcn0XSZUXx9WorHUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdZgOuUr3NqJ7HUTVldsZ3iB5zxuQBkIDkALj4zmhcT6ZPTcj
	j7OB7XzTM6GGDAaSojgR38RHxyvyuZriD6gVxcD4kYBD2f8rVn/d1w2wt+/rxwWkjscmrRK107C
	7ztZBoZk3tQhZIMhQtiIYYhjvLDTf5t0=
X-Gm-Gg: ASbGncvfqR1AovFVbT2oQiKzQrQAPQyNOut+6CFsKh6+JWEA4dJBWB+t+uEX0YInizn
	k3ouQ4uGK/nX3d+WYPKpnqy27J4gKS2XB5LFyVSvA6BmgOaZTMPZ6NYRaT/bvtRONzHKxhW8W4o
	2fojLnNlgnmOBKuX+fY9MLInpz6VtZQADVLJM5zYcCFYz/ewcz9tafFA==
X-Google-Smtp-Source: AGHT+IHD04zsHMQglVVk1mw6sOCnfsSjI2CxwtgAaVZjgobUOYE8HgQ1kWCSQuD2Dpq750fJJ2B5d1fs22kVV02ejSI=
X-Received: by 2002:a17:90b:5588:b0:312:db8:dbdc with SMTP id
 98e67ed59e1d1-3159d7c8e8amr19059026a91.20.1750682588936; Mon, 23 Jun 2025
 05:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com> <20250622-toicsti-bug-v1-1-f374373b04b2@gmail.com>
In-Reply-To: <20250622-toicsti-bug-v1-1-f374373b04b2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Jun 2025 08:42:57 -0400
X-Gm-Features: AX0GCFs0N2WKza8RBtyKQDk3a1xKhoq9hVaO4dDlQvMBWvfk6GDAm0ZPQCtwLGY
Message-ID: <CAEjxPJ4KEWcFEcrFu6wqVu=JDnCVZzGRO71wOUxUxjn1-WYi-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/tty: add TIOCSTI test suite
To: xandfury@gmail.com
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	selinux@vger.kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 9:41=E2=80=AFPM Abhinav Saxena via B4 Relay
<devnull+xandfury.gmail.com@kernel.org> wrote:
>
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

SELinux has its own testsuite at [1] since not everyone enables
SELinux, which is where any tests specific to SELinux functionality
should be added.

[1] https://github.com/selinuxproject/selinux-testsuite

> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  tools/testing/selftests/tty/Makefile           |   6 +-
>  tools/testing/selftests/tty/config             |   1 +
>  tools/testing/selftests/tty/tty_tiocsti_test.c | 421 +++++++++++++++++++=
++++++
>  3 files changed, 427 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftes=
ts/tty/Makefile
> index 50d7027b2ae3..7f6fbe5a0cd5 100644
> --- a/tools/testing/selftests/tty/Makefile
> +++ b/tools/testing/selftests/tty/Makefile
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS =3D -O2 -Wall
> -TEST_GEN_PROGS :=3D tty_tstamp_update
> +TEST_GEN_PROGS :=3D tty_tstamp_update tty_tiocsti_test
> +LDLIBS +=3D -lcap
>
>  include ../lib.mk
> +
> +# Add libcap for TIOCSTI test
> +$(OUTPUT)/tty_tiocsti_test: LDLIBS +=3D -lcap
> diff --git a/tools/testing/selftests/tty/config b/tools/testing/selftests=
/tty/config
> new file mode 100644
> index 000000000000..c6373aba6636
> --- /dev/null
> +++ b/tools/testing/selftests/tty/config
> @@ -0,0 +1 @@
> +CONFIG_LEGACY_TIOCSTI=3Dy
> diff --git a/tools/testing/selftests/tty/tty_tiocsti_test.c b/tools/testi=
ng/selftests/tty/tty_tiocsti_test.c
> new file mode 100644
> index 000000000000..6a4b497078b0
> --- /dev/null
> +++ b/tools/testing/selftests/tty/tty_tiocsti_test.c
> @@ -0,0 +1,421 @@
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
> +
> +#include "../kselftest_harness.h"
> +
> +/* Helper function to send FD via SCM_RIGHTS */
> +static int send_fd_via_socket(int socket_fd, int fd_to_send)
> +{
> +       struct msghdr msg =3D { 0 };
> +       struct cmsghdr *cmsg;
> +       char cmsg_buf[CMSG_SPACE(sizeof(int))];
> +       char dummy_data =3D 'F';
> +       struct iovec iov =3D { .iov_base =3D &dummy_data, .iov_len =3D 1 =
};
> +
> +       msg.msg_iov =3D &iov;
> +       msg.msg_iovlen =3D 1;
> +       msg.msg_control =3D cmsg_buf;
> +       msg.msg_controllen =3D sizeof(cmsg_buf);
> +
> +       cmsg =3D CMSG_FIRSTHDR(&msg);
> +       cmsg->cmsg_level =3D SOL_SOCKET;
> +       cmsg->cmsg_type =3D SCM_RIGHTS;
> +       cmsg->cmsg_len =3D CMSG_LEN(sizeof(int));
> +
> +       memcpy(CMSG_DATA(cmsg), &fd_to_send, sizeof(int));
> +
> +       return sendmsg(socket_fd, &msg, 0) < 0 ? -1 : 0;
> +}
> +
> +/* Helper function to receive FD via SCM_RIGHTS */
> +static int recv_fd_via_socket(int socket_fd)
> +{
> +       struct msghdr msg =3D { 0 };
> +       struct cmsghdr *cmsg;
> +       char cmsg_buf[CMSG_SPACE(sizeof(int))];
> +       char dummy_data;
> +       struct iovec iov =3D { .iov_base =3D &dummy_data, .iov_len =3D 1 =
};
> +       int received_fd =3D -1;
> +
> +       msg.msg_iov =3D &iov;
> +       msg.msg_iovlen =3D 1;
> +       msg.msg_control =3D cmsg_buf;
> +       msg.msg_controllen =3D sizeof(cmsg_buf);
> +
> +       if (recvmsg(socket_fd, &msg, 0) < 0)
> +               return -1;
> +
> +       for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&ms=
g, cmsg)) {
> +               if (cmsg->cmsg_level =3D=3D SOL_SOCKET &&
> +                   cmsg->cmsg_type =3D=3D SCM_RIGHTS) {
> +                       memcpy(&received_fd, CMSG_DATA(cmsg), sizeof(int)=
);
> +                       break;
> +               }
> +       }
> +
> +       return received_fd;
> +}
> +
> +static inline bool has_cap_sys_admin(void)
> +{
> +       cap_t caps =3D cap_get_proc();
> +
> +       if (!caps)
> +               return false;
> +
> +       cap_flag_value_t cap_val;
> +       bool has_cap =3D (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE=
,
> +                                    &cap_val) =3D=3D 0) &&
> +                      (cap_val =3D=3D CAP_SET);
> +
> +       cap_free(caps);
> +       return has_cap;
> +}
> +
> +/*
> + * Simple privilege drop that just changes uid/gid in current process
> + * and also capabilities like CAP_SYS_ADMIN
> + */
> +static inline bool drop_to_nobody(void)
> +{
> +       /* Drop supplementary groups */
> +       if (setgroups(0, NULL) !=3D 0) {
> +               printf("setgroups failed: %s", strerror(errno));
> +               return false;
> +       }
> +
> +       /* Change group to nobody */
> +       if (setgid(65534) !=3D 0) {
> +               printf("setgid failed: %s", strerror(errno));
> +               return false;
> +       }
> +
> +       /* Change user to nobody (this drops capabilities) */
> +       if (setuid(65534) !=3D 0) {
> +               printf("setuid failed: %s", strerror(errno));
> +               return false;
> +       }
> +
> +       /* Verify we no longer have CAP_SYS_ADMIN */
> +       if (has_cap_sys_admin()) {
> +               printf("ERROR: Still have CAP_SYS_ADMIN after changing to=
 nobody");
> +               return false;
> +       }
> +
> +       printf("Successfully changed to nobody (uid:%d gid:%d)\n", getuid=
(),
> +              getgid());
> +       return true;
> +}
> +
> +static inline int get_legacy_tiocsti_setting(void)
> +{
> +       FILE *fp;
> +       int value =3D -1;
> +
> +       fp =3D fopen("/proc/sys/dev/tty/legacy_tiocsti", "r");
> +       if (!fp) {
> +               if (errno =3D=3D ENOENT) {
> +                       printf("legacy_tiocsti sysctl not available (kern=
el < 6.2)\n");
> +               } else {
> +                       printf("Cannot read legacy_tiocsti: %s\n",
> +                              strerror(errno));
> +               }
> +               return -1;
> +       }
> +
> +       if (fscanf(fp, "%d", &value) =3D=3D 1) {
> +               printf("legacy_tiocsti setting=3D%d\n", value);
> +
> +               if (value < 0 || value > 1) {
> +                       printf("legacy_tiocsti unexpected value %d\n", va=
lue);
> +                       value =3D -1;
> +               } else {
> +                       printf("legacy_tiocsti=3D%d (%s mode)\n", value,
> +                              value =3D=3D 0 ? "restricted" : "permissiv=
e");
> +               }
> +       } else {
> +               printf("Failed to parse legacy_tiocsti value");
> +               value =3D -1;
> +       }
> +
> +       fclose(fp);
> +       return value;
> +}
> +
> +static inline int test_tiocsti_injection(int fd)
> +{
> +       int ret;
> +       char test_char =3D 'X';
> +
> +       ret =3D ioctl(fd, TIOCSTI, &test_char);
> +       if (ret =3D=3D 0) {
> +               /* Clear the injected character */
> +               printf("TIOCSTI injection succeeded\n");
> +       } else {
> +               printf("TIOCSTI injection failed: %s (errno=3D%d)\n",
> +                      strerror(errno), errno);
> +       }
> +       return ret =3D=3D 0 ? 0 : -1;
> +}
> +
> +FIXTURE(tty_tiocsti)
> +{
> +       int tty_fd;
> +       char *tty_name;
> +       bool has_tty;
> +       bool initial_cap_sys_admin;
> +       int legacy_tiocsti_setting;
> +};
> +
> +FIXTURE_SETUP(tty_tiocsti)
> +{
> +       TH_LOG("Running as UID: %d with effective UID: %d", getuid(),
> +              geteuid());
> +
> +       self->tty_fd =3D open("/dev/tty", O_RDWR);
> +       self->has_tty =3D (self->tty_fd >=3D 0);
> +
> +       if (self->tty_fd < 0)
> +               TH_LOG("Cannot open /dev/tty: %s", strerror(errno));
> +
> +       self->tty_name =3D ttyname(STDIN_FILENO);
> +       TH_LOG("Current TTY: %s", self->tty_name ? self->tty_name : "none=
");
> +
> +       self->initial_cap_sys_admin =3D has_cap_sys_admin();
> +       TH_LOG("Initial CAP_SYS_ADMIN: %s",
> +              self->initial_cap_sys_admin ? "yes" : "no");
> +
> +       self->legacy_tiocsti_setting =3D get_legacy_tiocsti_setting();
> +}
> +
> +FIXTURE_TEARDOWN(tty_tiocsti)
> +{
> +       if (self->has_tty && self->tty_fd >=3D 0)
> +               close(self->tty_fd);
> +}
> +
> +/* Test case 1: legacy_tiocsti !=3D 0 (permissive mode) */
> +TEST_F(tty_tiocsti, permissive_mode)
> +{
> +       // clang-format off
> +       if (self->legacy_tiocsti_setting < 0)
> +               SKIP(return,
> +                    "legacy_tiocsti sysctl not available (kernel < 6.2)"=
);
> +
> +       if (self->legacy_tiocsti_setting =3D=3D 0)
> +               SKIP(return,
> +                    "Test requires permissive mode (legacy_tiocsti=3D1)"=
);
> +       // clang-format on
> +
> +       ASSERT_TRUE(self->has_tty);
> +
> +       if (self->initial_cap_sys_admin) {
> +               ASSERT_TRUE(drop_to_nobody());
> +               ASSERT_FALSE(has_cap_sys_admin());
> +       }
> +
> +       /* In permissive mode, TIOCSTI should work without CAP_SYS_ADMIN =
*/
> +       EXPECT_EQ(test_tiocsti_injection(self->tty_fd), 0)
> +       {
> +               TH_LOG("TIOCSTI should succeed in permissive mode without=
 CAP_SYS_ADMIN");
> +       }
> +}
> +
> +/* Test case 2: legacy_tiocsti =3D=3D 0, without CAP_SYS_ADMIN (should f=
ail) */
> +TEST_F(tty_tiocsti, restricted_mode_nopriv)
> +{
> +       // clang-format off
> +       if (self->legacy_tiocsti_setting < 0)
> +               SKIP(return,
> +                    "legacy_tiocsti sysctl not available (kernel < 6.2)"=
);
> +
> +       if (self->legacy_tiocsti_setting !=3D 0)
> +               SKIP(return,
> +                    "Test requires restricted mode (legacy_tiocsti=3D0)"=
);
> +       // clang-format on
> +
> +       ASSERT_TRUE(self->has_tty);
> +
> +       if (self->initial_cap_sys_admin) {
> +               ASSERT_TRUE(drop_to_nobody());
> +               ASSERT_FALSE(has_cap_sys_admin());
> +       }
> +       /* In restricted mode, TIOCSTI should fail without CAP_SYS_ADMIN =
*/
> +       EXPECT_EQ(test_tiocsti_injection(self->tty_fd), -1);
> +
> +       /*
> +        * it might fail with either EPERM or EIO
> +        * EXPECT_TRUE(errno =3D=3D EPERM || errno =3D=3D EIO)
> +        * {
> +        *      TH_LOG("Expected EPERM, got: %s", strerror(errno));
> +        * }
> +        */
> +}
> +
> +/* Test case 3: legacy_tiocsti =3D=3D 0, with CAP_SYS_ADMIN (should succ=
eed) */
> +TEST_F(tty_tiocsti, restricted_mode_priv)
> +{
> +       // clang-format off
> +       if (self->legacy_tiocsti_setting < 0)
> +               SKIP(return,
> +                    "legacy_tiocsti sysctl not available (kernel < 6.2)"=
);
> +
> +       if (self->legacy_tiocsti_setting !=3D 0)
> +               SKIP(return,
> +                    "Test requires restricted mode (legacy_tiocsti=3D0)"=
);
> +       // clang-format on
> +
> +       /* Must have CAP_SYS_ADMIN for this test */
> +       if (!self->initial_cap_sys_admin)
> +               SKIP(return, "Test requires CAP_SYS_ADMIN");
> +
> +       ASSERT_TRUE(self->has_tty);
> +       ASSERT_TRUE(has_cap_sys_admin());
> +
> +       /* In restricted mode, TIOCSTI should succeed with CAP_SYS_ADMIN =
*/
> +       EXPECT_EQ(test_tiocsti_injection(self->tty_fd), 0)
> +       {
> +               TH_LOG("TIOCSTI should succeed in restricted mode with CA=
P_SYS_ADMIN");
> +       }
> +}
> +
> +/* Test TIOCSTI security with file descriptor passing */
> +TEST_F(tty_tiocsti, fd_passing_security)
> +{
> +       // clang-format off
> +       if (self->legacy_tiocsti_setting < 0)
> +               SKIP(return,
> +                    "legacy_tiocsti sysctl not available (kernel < 6.2)"=
);
> +
> +       if (self->legacy_tiocsti_setting !=3D 0)
> +               SKIP(return,
> +                    "Test requires restricted mode (legacy_tiocsti=3D0)"=
);
> +       // clang-format on
> +
> +       /* Must start with CAP_SYS_ADMIN */
> +       if (!self->initial_cap_sys_admin)
> +               SKIP(return, "Test requires initial CAP_SYS_ADMIN");
> +
> +       int sockpair[2];
> +       pid_t child_pid;
> +
> +       ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sockpair), 0);
> +
> +       child_pid =3D fork();
> +       ASSERT_GE(child_pid, 0)
> +       TH_LOG("Fork failed: %s", strerror(errno));
> +
> +       if (child_pid =3D=3D 0) {
> +               /* Child process - become unprivileged, open TTY, send FD=
 to parent */
> +               close(sockpair[0]);
> +
> +               TH_LOG("Child: Dropping privileges...");
> +
> +               /* Drop to nobody user (loses all capabilities) */
> +               drop_to_nobody();
> +
> +               /* Verify we no longer have CAP_SYS_ADMIN */
> +               if (has_cap_sys_admin()) {
> +                       TH_LOG("Child: Failed to drop CAP_SYS_ADMIN");
> +                       _exit(1);
> +               }
> +
> +               TH_LOG("Child: Opening TTY as unprivileged user...");
> +
> +               int unprivileged_tty_fd =3D open("/dev/tty", O_RDWR);
> +
> +               if (unprivileged_tty_fd < 0) {
> +                       TH_LOG("Child: Cannot open TTY: %s", strerror(err=
no));
> +                       _exit(1);
> +               }
> +
> +               /* Test that we can't use TIOCSTI directly (should fail) =
*/
> +
> +               char test_char =3D 'X';
> +
> +               if (ioctl(unprivileged_tty_fd, TIOCSTI, &test_char) =3D=
=3D 0) {
> +                       TH_LOG("Child: ERROR - Direct TIOCSTI succeeded u=
nexpectedly!");
> +                       close(unprivileged_tty_fd);
> +                       _exit(1);
> +               }
> +               TH_LOG("Child: Good - Direct TIOCSTI failed as expected: =
%s",
> +                      strerror(errno));
> +
> +               /* Send the TTY FD to privileged parent via SCM_RIGHTS */
> +               TH_LOG("Child: Sending TTY FD to privileged parent...");
> +               if (send_fd_via_socket(sockpair[1], unprivileged_tty_fd) =
!=3D 0) {
> +                       TH_LOG("Child: Failed to send FD");
> +                       close(unprivileged_tty_fd);
> +                       _exit(1);
> +               }
> +
> +               close(unprivileged_tty_fd);
> +               close(sockpair[1]);
> +               _exit(0); /* Child success */
> +
> +       } else {
> +               /* Parent process - keep CAP_SYS_ADMIN, receive FD, test =
TIOCSTI */
> +               close(sockpair[1]);
> +
> +               TH_LOG("Parent: Waiting for TTY FD from unprivileged chil=
d...");
> +
> +               /* Verify we still have CAP_SYS_ADMIN */
> +               ASSERT_TRUE(has_cap_sys_admin());
> +
> +               /* Receive the TTY FD from unprivileged child */
> +               int received_fd =3D recv_fd_via_socket(sockpair[0]);
> +
> +               ASSERT_GE(received_fd, 0)
> +               TH_LOG("Parent: Received FD %d (opened by unprivileged pr=
ocess)",
> +                      received_fd);
> +
> +               /*
> +                * VULNERABILITY TEST: Try TIOCSTI with FD opened by unpr=
ivileged process
> +                * This should FAIL even though parent has CAP_SYS_ADMIN
> +                * because the FD was opened by unprivileged process
> +                */
> +               char attack_char =3D 'V'; /* V for Vulnerability */
> +               int ret =3D ioctl(received_fd, TIOCSTI, &attack_char);
> +
> +               TH_LOG("Parent: Testing TIOCSTI on FD from unprivileged p=
rocess...");
> +               if (ret =3D=3D 0) {
> +                       TH_LOG("*** VULNERABILITY DETECTED ***");
> +                       TH_LOG("Privileged process can use TIOCSTI on unp=
rivileged FD");
> +               } else {
> +                       TH_LOG("TIOCSTI failed on unprivileged FD: %s",
> +                              strerror(errno));
> +                       EXPECT_EQ(errno, EPERM);
> +               }
> +               close(received_fd);
> +               close(sockpair[0]);
> +
> +               /* Wait for child */
> +               int status;
> +
> +               ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
> +               EXPECT_EQ(WEXITSTATUS(status), 0);
> +               ASSERT_NE(ret, 0);
> +       }
> +}
> +
> +TEST_HARNESS_MAIN
>
> --
> 2.43.0
>
>

