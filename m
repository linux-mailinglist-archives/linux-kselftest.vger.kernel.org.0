Return-Path: <linux-kselftest+bounces-44162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA986C12244
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F2524FC117
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD64C6D;
	Tue, 28 Oct 2025 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5gXBluP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA139FD9
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609807; cv=none; b=UNSWYgAdTS/rn/j21MivM27rtOEf1elsOawq6p1udFBzpx7NBiQQoOqtZkPC6QyjAoE1D+vg1tXr9QNl/RJ3t0kbrH8hxLnCWLBcdr7ybMM8Abbc1+z8DcMZgHtkwnVcGxROJS5pcvR0AronSwASe79vNRcYLxehay23cw16/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609807; c=relaxed/simple;
	bh=DGzwRf2p2CJrnI+oJoN9BENUr9V7Zm9MR+Xl8q5suy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRyQO96uXZFrd6NISlPJu+HG8MbtEbdJKL6UtpVH/aC/en+anjx8iYRr4s+SWm+bMrqO43tDAhIfKWON1Bt8O0KYOSFNFqRCaENyxfWynh6JFy0t8Ppguq24+TQJmO7NU3TpD0VZpIgvhZ4qbOm1zhaCYJ+5kvNdlZIDxKiPxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5gXBluP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ab379d48so49233725ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761609804; x=1762214604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZCum+r0j7+sL2asWoXg6O4fgM2HSIbUoaPZ22uOf/Q=;
        b=k5gXBluPBBgI8Nzb0kAHiJzconhjzLe/2NNaeG2yMSaEbLdc5iCDll49MAy5DHJUtQ
         g7ctzdZEnn5hhCLWPJ4q1B9Gzl+XleGFMm4BfkjjdpXntnqfLVo2OkGCQaYdsZukadQ6
         sfg4gh+vw4GXyRP4aHgBVGlHvIm8iQGs5Pak6bwwfi596gT7zNeU6BQ723cuwaevRu9Q
         1agzLenJbBrNo8LovLiavwNZov2mLf+ANUtRaNrQ7G+fL8tVNSIRYc3jal6DCDYqF+6P
         3QH8Lm/Xcb45uZcvDB6TtErFB1Vtvye+xf76S4yMpVMN47pp+1azsSMbowKoiB2+FhSU
         rBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609804; x=1762214604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZCum+r0j7+sL2asWoXg6O4fgM2HSIbUoaPZ22uOf/Q=;
        b=t026Mt6Yii5DNGokML7vh9fqBK9khL+NFAtoJ70j3nRrP9G8bi5CnRFGwUQCJLLWgw
         wll6a4KrezTQQm09e0iPP5Bl63Tp+dNPN2uaPMQM5UaECO/daVreS/utcL7Qk2AmH+yx
         aWfvUZYpkj3+7ZXtn2hmFByBJDp59jFTzA6n7Amec8eq4+BLpZopLM9saH4oUgTPTowU
         5HtSB4jL52EM/x8yAFDg3VevPORRLBCri20psOCdYg6N/n4MJpLfg6kEjS9mSLQxNWz2
         RLqwK5APKao16kuUiiNZQxVFiNtdEIvOBbVu6VpZzV4cemo0Go2LEz/RDCccVqE72/8I
         g9mg==
X-Forwarded-Encrypted: i=1; AJvYcCWTlXKd2ggalLd9jJo5gz2a2Uv70ftoZbsZjDXx3tniokST9j20OVPZ0+pG49FZwocmq9MG4V3rnVaL7xH499E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjz6jwEJsGQM4olAcR7B4UiyW7eX+4jdkU+zjGuivdbPFgBX6V
	WMixW29bfnQ9zdXXoVNF10XiHarHxOYIJxQ6lm5wFHiaFb2FlgIVQokfd/Yu3FKn8GD0oW7viaG
	1Z3NKh+43LPwDVaob9V+kpCXgq8mg6qx7MaBczViP
X-Gm-Gg: ASbGncsL6nKQCPEHekkHqxU/uYUOzQBexUiKwFOyWtJBcdScPSXPzDvYRmnsedpQ0dP
	gzNvvsDAcgXYF19efSeH7r6ofgpvstf/bnGcaLveu9cmOpoZWmL3wI98jFmWLArGo0Kq9VCNmX3
	gRRE07HfoNEn2065et/Gh9rLtp2445XBfEupCilMULYOCypLYodZFHpm9xUC+EQ+EItkd7ZR7QD
	3BWD3bK6baJ+vkeEaIsIWpm1Cwy4w5DBcFFq1TZlt8dnzppqncveWVNvpKmb/RmlaDBsFgSUYZJ
	Ld3wCLqDHWM7CRnJh51AujIndQ==
X-Google-Smtp-Source: AGHT+IGosO0DB75sp17nvkEDYd/Wy2DtUxZe4rLRVEWjcse9yLuHPdHK7ziTM/n0Jb6YCHadMQQ4YLjeCyabW6il9to=
X-Received: by 2002:a17:903:2341:b0:27c:56af:88ea with SMTP id
 d9443c01a7336-294cb528652mr14950775ad.60.1761609803251; Mon, 27 Oct 2025
 17:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017084022.3721950-1-kuniyu@google.com>
In-Reply-To: <20251017084022.3721950-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 17:03:11 -0700
X-Gm-Features: AWmQ_bnGZJq2m6XHoaCj_R-NKH1weodCxI22JTZqCmn3ZkUAjZpJLiAk3ts4yPA
Message-ID: <CAAVpQUCVoisHxqYU=iQAmjeer+Ys0CgE852YkK6POe_+xi7LFg@mail.gmail.com>
Subject: Re: [PATCH] selftests: harness: Support KCOV.
To: Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

Could you take a look at this patch?

Thanks!

On Fri, Oct 17, 2025 at 1:40=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> While writing a selftest with kselftest_harness.h, I often want to
> check which paths are actually exercised.
>
> Let's support generating KCOV coverage data.
>
> We can specify the output directory via the KCOV_OUTPUT environment
> variable, and the number of instructions to collect via the KCOV_SLOTS
> environment variable.
>
>   # KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 2)) \
>     ./tools/testing/selftests/net/af_unix/scm_inq
>
> Both variables can also be specified as the make variable.
>
>   # make -C tools/testing/selftests/ \
>     KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 4)) \
>     kselftest_override_timeout=3D60 TARGETS=3Dnet/af_unix run_tests
>
> The coverage data can be simply decoded with addr2line:
>
>   $ cat kcov/* | sort | uniq | addr2line -e vmlinux | grep unix
>   net/unix/af_unix.c:1056
>   net/unix/af_unix.c:3138
>   net/unix/af_unix.c:3834
>   net/unix/af_unix.c:3838
>   net/unix/af_unix.c:311 (discriminator 2)
>   ...
>
> or more nicely with a script embedded in vock [0]:
>
>   $ cat kcov/* | sort | uniq > local.log
>   $ python3 ~/kernel/tools/vock/report.py \
>     --kernel-src ./ --vmlinux ./vmlinux \
>     --mode local --local-log local.log --filter unix
>   ...
>   ------------------------------- Coverage Report -----------------------=
---------
>   =F0=9F=93=84 net/unix/af_unix.c (276 lines)
>    ...
>   942 | static int unix_setsockopt(struct socket *sock, int level, int op=
tname,
>   943 |                            sockptr_t optval, unsigned int optlen)
>   944 | {
>    ...
>   961 |         switch (optname) {
>   962 |         case SO_INQ:
>   963 >                 if (sk->sk_type !=3D SOCK_STREAM)
>   964 |                         return -EINVAL;
>   965 |
>   966 >                 if (val > 1 || val < 0)
>   967 |                         return -EINVAL;
>   968 |
>   969 >                 WRITE_ONCE(u->recvmsg_inq, val);
>   970 |                 break;
>
> Link: https://github.com/kzall0c/vock/blob/f3d97de9954f9df758c0ab287ca7e2=
4e654288c7/report.py #[0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  Documentation/dev-tools/kselftest.rst       |  41 +++++++
>  tools/testing/selftests/Makefile            |  14 ++-
>  tools/testing/selftests/kselftest_harness.h | 128 +++++++++++++++++++-
>  3 files changed, 174 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-to=
ols/kselftest.rst
> index 18c2da67fae42..5c2b92ac4a300 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -200,6 +200,47 @@ You can look at the TAP output to see if you ran int=
o the timeout. Test
>  runners which know a test must run under a specific time can then option=
ally
>  treat these timeouts then as fatal.
>
> +KCOV for selftests
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Selftests built with `kselftest_harness.h` natively support generating
> +KCOV coverage data.  See :doc:`KCOV: code coverage for fuzzing </dev-too=
ls/kcov>`
> +for prerequisites.
> +
> +You can specify the output directory with the `KCOV_OUTPUT` environment
> +variable.  Additionally, you can specify the number of instructions to
> +collect with the `KCOV_SLOTS` environment variable ::
> +
> +  # KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 2)) \
> +        ./tools/testing/selftests/net/af_unix/scm_inq
> +
> +In the output directory, a coverage file is generated for each test
> +case in the selftest ::
> +
> +  $ ls kcov/
> +  scm_inq.dgram.basic  scm_inq.seqpacket.basic  scm_inq.stream.basic
> +
> +The default value of `KCOV_SLOTS` is `4096`, and `KCOV_SLOTS` multiplied
> +by `sizeof(unsigned long)` must be multiple of `4096`, so the smallest
> +value is `512`.
> +
> +Both `KCOV_OUTPUT` and `KCOV_SLOTS` can be specified as the variables
> +on the `make` command line ::
> +
> +  # make -C tools/testing/selftests/ \
> +        kselftest_override_timeout=3D60 \
> +        KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 4)) \
> +        TARGETS=3Dnet/af_unix run_tests
> +
> +The collected data can be decoded with `addr2line` ::
> +
> +  $ cat kcov/* | sort | uniq | addr2line -e vmlinux | grep unix
> +  net/unix/af_unix.c:1056
> +  net/unix/af_unix.c:3138
> +  net/unix/af_unix.c:3834
> +  net/unix/af_unix.c:3838
> +  ...
> +
>  Packaging selftests
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index c46ebdb9b8ef7..40e70fb1a3478 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -218,12 +218,14 @@ all:
>         done; exit $$ret;
>
>  run_tests: all
> -       @for TARGET in $(TARGETS); do \
> -               BUILD_TARGET=3D$$BUILD/$$TARGET;  \
> -               $(MAKE) OUTPUT=3D$$BUILD_TARGET -C $$TARGET run_tests \
> -                               SRC_PATH=3D$(shell readlink -e $$(pwd)) \
> -                               OBJ_PATH=3D$(BUILD)                   \
> -                               O=3D$(abs_objtree);                   \
> +       @for TARGET in $(TARGETS); do                           \
> +               BUILD_TARGET=3D$$BUILD/$$TARGET;                  \
> +               $(MAKE) OUTPUT=3D$$BUILD_TARGET                   \
> +                       KCOV_OUTPUT=3D$(abspath $(KCOV_OUTPUT))   \
> +                       -C $$TARGET run_tests                   \
> +                       SRC_PATH=3D$(shell readlink -e $$(pwd))   \
> +                       OBJ_PATH=3D$(BUILD)                       \
> +                       O=3D$(abs_objtree);                       \
>         done;
>
>  hotplug:
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/=
selftests/kselftest_harness.h
> index 3f66e862e83eb..cba8020853b5d 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -56,6 +56,8 @@
>  #include <asm/types.h>
>  #include <ctype.h>
>  #include <errno.h>
> +#include <fcntl.h>
> +#include <linux/kcov.h>
>  #include <linux/unistd.h>
>  #include <poll.h>
>  #include <stdbool.h>
> @@ -63,7 +65,9 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <sys/ioctl.h>
>  #include <sys/mman.h>
> +#include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> @@ -401,7 +405,8 @@
>                 const FIXTURE_VARIANT(fixture_name) *variant); \
>         static void wrapper_##fixture_name##_##test_name( \
>                 struct __test_metadata *_metadata, \
> -               struct __fixture_variant_metadata *variant) \
> +               struct __fixture_variant_metadata *variant, \
> +               char *test_full_name) \
>         { \
>                 /* fixture data is alloced, setup, and torn down per call=
. */ \
>                 FIXTURE_DATA(fixture_name) self_private, *self =3D NULL; =
\
> @@ -430,7 +435,9 @@
>                         if (_metadata->exit_code) \
>                                 _exit(0); \
>                         *_metadata->no_teardown =3D false; \
> +                       enable_kcov(_metadata); \
>                         fixture_name##_##test_name(_metadata, self, varia=
nt->data); \
> +                       disable_kcov(_metadata, test_full_name); \
>                         _metadata->teardown_fn(false, _metadata, self, va=
riant->data); \
>                         _exit(0); \
>                 } else if (child < 0 || child !=3D waitpid(child, &status=
, 0)) { \
> @@ -470,6 +477,8 @@
>                 object->teardown_fn =3D &wrapper_##fixture_name##_##test_=
name##_teardown; \
>                 object->termsig =3D signal; \
>                 object->timeout =3D tmout; \
> +               object->kcov_fd =3D -1; \
> +               object->kcov_slots =3D -1; \
>                 _##fixture_name##_##test_name##_object =3D object; \
>                 __register_test(object); \
>         } \
> @@ -908,7 +917,8 @@ __register_fixture_variant(struct __fixture_metadata =
*f,
>  struct __test_metadata {
>         const char *name;
>         void (*fn)(struct __test_metadata *,
> -                  struct __fixture_variant_metadata *);
> +                  struct __fixture_variant_metadata *,
> +                  char *test_name);
>         pid_t pid;      /* pid of test when being run */
>         struct __fixture_metadata *fixture;
>         void (*teardown_fn)(bool in_parent, struct __test_metadata *_meta=
data,
> @@ -923,6 +933,10 @@ struct __test_metadata {
>         const void *variant;
>         struct __test_results *results;
>         struct __test_metadata *prev, *next;
> +       int kcov_fd;
> +       int kcov_slots;
> +       char *kcov_dir;
> +       unsigned long *kcov_mem;
>  };
>
>  static inline bool __test_passed(struct __test_metadata *metadata)
> @@ -1185,6 +1199,114 @@ static bool test_enabled(int argc, char **argv,
>         return !has_positive;
>  }
>
> +#define KCOV_SLOTS 4096
> +
> +static void enable_kcov(struct __test_metadata *t)
> +{
> +       char *slots;
> +       int err;
> +
> +       t->kcov_dir =3D getenv("KCOV_OUTPUT");
> +       if (!t->kcov_dir || *t->kcov_dir =3D=3D '\0')
> +               return;
> +
> +       slots =3D getenv("KCOV_SLOTS");
> +       if (slots && *slots !=3D '\0')
> +               sscanf(slots, "%d", &t->kcov_slots);
> +       if (t->kcov_slots <=3D 0)
> +               t->kcov_slots =3D KCOV_SLOTS;
> +
> +       t->kcov_fd =3D open("/sys/kernel/debug/kcov", O_RDWR);
> +       if (t->kcov_fd < 0) {
> +               ksft_print_msg("ERROR OPENING KCOV FD\n");
> +               goto err;
> +       }
> +
> +       err =3D ioctl(t->kcov_fd, KCOV_INIT_TRACE, t->kcov_slots);
> +       if (err) {
> +               ksft_print_msg("ERROR INITIALISING KCOV\n");
> +               goto err;
> +       }
> +
> +       t->kcov_mem =3D mmap(NULL, sizeof(unsigned long) * t->kcov_slots,
> +                          PROT_READ | PROT_WRITE, MAP_SHARED, t->kcov_fd=
, 0);
> +       if ((void *)t->kcov_mem =3D=3D MAP_FAILED) {
> +               ksft_print_msg("ERROR ALLOCATING MEMORY FOR KCOV\n");
> +               goto err;
> +       }
> +
> +       err =3D ioctl(t->kcov_fd, KCOV_ENABLE, KCOV_TRACE_PC);
> +       if (err) {
> +               ksft_print_msg("ERROR ENABLING KCOV\n");
> +               goto err;
> +       }
> +
> +       __atomic_store_n(&t->kcov_mem[0], 0, __ATOMIC_RELAXED);
> +       return;
> +err:
> +       t->exit_code =3D KSFT_FAIL;
> +       _exit(KSFT_FAIL);
> +}
> +
> +static void disable_kcov(struct __test_metadata *t, char *test_name)
> +{
> +       int slots, err, dir, fd, i;
> +
> +       if (t->kcov_fd =3D=3D -1)
> +               return;
> +
> +       slots =3D __atomic_load_n(&t->kcov_mem[0], __ATOMIC_RELAXED);
> +       if (slots =3D=3D t->kcov_slots - 1)
> +               ksft_print_msg("Set KCOV_SLOTS to a value greater than %d=
\n", t->kcov_slots);
> +
> +       err =3D ioctl(t->kcov_fd, KCOV_DISABLE, 0);
> +       if (err) {
> +               ksft_print_msg("ERROR DISABLING KCOV\n");
> +               goto out;
> +       }
> +
> +       err =3D mkdir(t->kcov_dir, 0755);
> +       if (err =3D=3D -1 && errno !=3D EEXIST) {
> +               ksft_print_msg("ERROR CREATING '%s'\n", t->kcov_dir);
> +               goto out;
> +       }
> +       err =3D 0;
> +
> +       dir =3D open(t->kcov_dir, O_DIRECTORY);
> +       if (dir < 0) {
> +               ksft_print_msg("ERROR OPENING %s\n", t->kcov_dir);
> +               err =3D dir;
> +               goto out;
> +       }
> +
> +       fd =3D openat(dir, test_name, O_RDWR | O_CREAT | O_TRUNC);
> +
> +       close(dir);
> +
> +       if (fd =3D=3D -1) {
> +               ksft_print_msg("ERROR CREATING '%s' at '%s'\n", test_name=
, t->kcov_dir);
> +               err =3D fd;
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < slots; i++) {
> +               char buf[64];
> +               int size;
> +
> +               size =3D snprintf(buf, 64, "0x%lx\n", t->kcov_mem[i + 1])=
;
> +               write(fd, buf, size);
> +       }
> +
> +out:
> +       munmap(t->kcov_mem, sizeof(t->kcov_mem[0]) * t->kcov_slots);
> +       close(t->kcov_fd);
> +
> +       if (err) {
> +               t->exit_code =3D KSFT_FAIL;
> +               _exit(KSFT_FAIL);
> +       }
> +}
> +
>  static void __run_test(struct __fixture_metadata *f,
>                        struct __fixture_variant_metadata *variant,
>                        struct __test_metadata *t)
> @@ -1216,7 +1338,7 @@ static void __run_test(struct __fixture_metadata *f=
,
>                 t->exit_code =3D KSFT_FAIL;
>         } else if (child =3D=3D 0) {
>                 setpgrp();
> -               t->fn(t, variant);
> +               t->fn(t, variant, test_name);
>                 _exit(t->exit_code);
>         } else {
>                 t->pid =3D child;
> --
> 2.51.0.858.gf9c4a03a3a-goog
>

