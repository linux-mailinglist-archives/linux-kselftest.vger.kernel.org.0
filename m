Return-Path: <linux-kselftest+bounces-48635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3166D0C8C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3703D300EBAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA43016F1;
	Fri,  9 Jan 2026 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW0XvGgz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0C21C9EA
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001524; cv=none; b=NAMosBb24m6m1RA7aOpb2AZrXg1Ou0KkLs9qMXGURAFMf4KrSjfXDM14E0YzaOqRFS2X78RFUrY6vDAWOLLztEDb/38XGAfhS94M+udy42mkYUeYhgJFinK39PulJ+0MAOuhlNMBbXbGRp8Suu5AU1PkybhVCUHLzW5TBtl0z+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001524; c=relaxed/simple;
	bh=He6cMspbDe4vjqLXhDSMizafMm6lpbRUnv5H+UvUv6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOJjsBEE+nyRIZxLIdntP7uaO9oJjkqiGnrgfNyAOXGPsap109MNL9s1n++OJf50D08q9M8hKVZ9VAmUjp/hT8fM1BU5tuDZVlCMj3Tzvi+c7+l2RymPy1H+v2bgzC2ppsQ064PmioWmmyqO8qyWVGuOhqBTPd7aqH4txao69+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW0XvGgz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so2990191a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001522; x=1768606322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6NNpJHWLgYxaJF514Aiineqr1BMcmvgNog3zSYfgdw=;
        b=NW0XvGgzy2v7mByvcJCv1X7zuYY55jpCAkQtdpSPR+twadfgmQorSqf+WGQDHSk5ty
         dZ/3Nsmqw8lbxAOB+GYg3pg6O2cvebxoegHJRee4Q967PFvuzchEwWR62oUYwidzsUoq
         /aSz7owIme034WS0F/28oVqTqrp1glC1whnHDlEsc5bnrHNWIjJHvaOLjfMMSOfPMoER
         RCX9SdffiOreYfiNn2sv/FqnqmHfFffl/Y/I8FBp9CBtly/cEWaQJpp//oiCD45ZPSF9
         vpjv+vwqu4jlSBlzHIB2DfKJbQtyF3BBYAvwMwSNyQnmvzE6ZgHixAp+DUcUgfaHNnyj
         ru5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001522; x=1768606322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6NNpJHWLgYxaJF514Aiineqr1BMcmvgNog3zSYfgdw=;
        b=Q/uXtvD8fVMG4fingdqHE5Bj547gqBqIj/iCCOoEiKSlZyRWrRTykz+S0OOLI26Rzz
         8B0el0C9DldTUCEKVQ6DM6rRuQuueflkw/q6RsWTRKAUXGzOGuF3pXU1/dmwdgEH49RG
         jd7kgVdU6zMTMMJqrzdBljRjrSRpfEVLvPjhVqc6mEKNhO+7CVVOBazt8GYzUwyQnJto
         sMKhbrjlmZTRyj2COJLT+jV11cXvKms4EOwWXEOJL7W0oxkAgk2GNQGuywtncbIy+dJx
         vnbxMwP0TkQvO2JtPjrkftrSSlKUZyaDjpBKF6fnPmEiXWM7loy73cVGQAgdi/DR74cl
         +cdw==
X-Forwarded-Encrypted: i=1; AJvYcCXKts+dKbbiyxpfZbfxUkH4wEk568g15TcJkSCavxrsVLXUTnwrv756qjlsV9HY9LzOzCCohhqd9Hd+3PMC2ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgwMXKq4mMQYY5X+a7d4pDT+soS24bMdSuPmJQzXbX/9PLzbpu
	p29x7C1tm6xgeiZqWKMIIhtTKNmz5ozEKW3NP7jZDshsZGE1iTAkA4YOD79t4HQq3pll4SUzfZf
	c5dMDQPhyDuUtRSw9UUXmBS4UPXCHuEc=
X-Gm-Gg: AY/fxX7KkFxM4ygcUli1a3dpdfr3RyMhxp6rP5+ARBt3+fZBStNcWVudM97aS0A0xEK
	MOxURzDIO4B5098UbLPax72MREa1/hQDT+2LPtgt5sCb/T/XgpqVd0cnS/S3wKY7In0LGRZljni
	SB9T0lp8B8oCDiie4uvydmxukAL+Bfm8qilCcO5C8ojXwiaMpQL+qLhp5sOBlxAzbFRwFDWZ2ID
	JXrnrwscOxxu0dw7AJQgAnKFi03rH0EQQ304D0MCTjG1TYREmXTEIrMLnYAIT1jtg6KOb+mGC7I
	L+OApilH
X-Google-Smtp-Source: AGHT+IHl0CLpLg3JnIJAJ9MuirwJX75pOUI0sCmCKCTUAknikhs/R8GjFexAUnAb9IQJmgp/zUMfG0Gin+8yeX0W17c=
X-Received: by 2002:a17:90b:4a07:b0:339:ec9c:b275 with SMTP id
 98e67ed59e1d1-34f68c308camr11697464a91.6.1768001522146; Fri, 09 Jan 2026
 15:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com> <20260108225523.3268383-4-wusamuel@google.com>
In-Reply-To: <20260108225523.3268383-4-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:31:49 -0800
X-Gm-Features: AQt7F2q2G-OX-Uh1RPThv9thAQVRiIg5fIQubxSEMQmGx2ViPTlEZ7Lel1rZTOE
Message-ID: <CAEf4BzaE2WGW3bB_ZsCZsjNLV8bczopH8w89FUaAZH7Qa6G-JA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add tests for wakeup_sources
To: Samuel Wu <wusamuel@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:56=E2=80=AFPM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> Sets up the framework to test wakeup_sources iterators using BPF, and
> adds a few basic tests.
>
> Adds several helper functions that for grabbing and releasing a
> wakelock, abstracting out key functions to setup a framework for testing
> wakeup_sources.
>
> Additionally, adds 3 tests:
> 1. check_active_count: Checks that stats related to active_count are
>    properly set after several lock/unlock cycles
> 2. check_sleep_times: Checks that time accounting related to sleep are
>    properly calculated
> 3. check_no_infinite_reads: Checks that the iterator traversal returns
>    NULL at the end
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  tools/testing/selftests/bpf/config            |   1 +
>  .../bpf/prog_tests/wakeup_source_iter.c       | 281 ++++++++++++++++++
>  .../selftests/bpf/progs/wakeup_source_iter.c  |  70 +++++
>  3 files changed, 352 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_=
iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.=
c
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index 558839e3c185..c12c5e04b81f 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -111,6 +111,7 @@ CONFIG_IP6_NF_IPTABLES=3Dy
>  CONFIG_IP6_NF_FILTER=3Dy
>  CONFIG_NF_NAT=3Dy
>  CONFIG_PACKET=3Dy
> +CONFIG_PM_WAKELOCKS=3Dy
>  CONFIG_RC_CORE=3Dy
>  CONFIG_SAMPLES=3Dy
>  CONFIG_SAMPLE_LIVEPATCH=3Dm
> diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c =
b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
> new file mode 100644
> index 000000000000..31729f11585e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Google LLC */
> +
> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +#include "wakeup_source_iter.skel.h"
> +
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +
> +/* Sleep for 10ms to ensure active time is > 0 after converting ns to ms=
*/
> +#define TEST_SLEEP_US 10000
> +#define TEST_SLEEP_MS (TEST_SLEEP_US / 1000)
> +#define WAKEUP_SOURCE_NAME_LEN 32
> +
> +static const char test_ws_name[] =3D "bpf_selftest_ws";
> +static bool test_ws_created;
> +
> +/*
> + * Creates a new wakeup source by writing to /sys/power/wake_lock.
> + * This lock persists until explicitly unlocked.
> + */
> +static int lock_ws(const char *name)
> +{
> +       int fd;
> +       ssize_t bytes;
> +
> +       fd =3D open("/sys/power/wake_lock", O_WRONLY);
> +       if (!ASSERT_OK_FD(fd, "open /sys/power/wake_lock"))
> +               return -1;
> +
> +       bytes =3D write(fd, name, strlen(name));
> +       close(fd);
> +       if (!ASSERT_EQ(bytes, strlen(name), "write to wake_lock"))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +/*
> + * Destroys the ws by writing the same name to /sys/power/wake_unlock.
> + */
> +static void unlock_ws(const char *name)
> +{
> +       int fd;
> +
> +       fd =3D open("/sys/power/wake_unlock", O_WRONLY);
> +       if (!ASSERT_OK_FD(fd, "open /sys/power/wake_unlock"))
> +               goto cleanup;
> +
> +       write(fd, name, strlen(name));
> +
> +cleanup:
> +       if (fd)
> +               close(fd);
> +}
> +
> +/*
> + * Setups for testing ws iterators. Will run once prior to suite of test=
s.
> + */
> +static int setup_test_ws(void)
> +{
> +       if (lock_ws(test_ws_name))
> +               return -1;
> +       test_ws_created =3D true;
> +
> +       return 0;
> +}
> +
> +/*
> + * Tears down and cleanups testing ws iterators. WIll run once after the=
 suite
> + * of tests.
> + */
> +static void teardown_test_ws(void)
> +{
> +       if (!test_ws_created)
> +               return;
> +       unlock_ws(test_ws_name);
> +       test_ws_created =3D false;
> +}
> +
> +struct WakeupSourceInfo {
> +       char name[WAKEUP_SOURCE_NAME_LEN];
> +       unsigned long active_count;
> +       long active_time_ms;
> +       unsigned long event_count;
> +       unsigned long expire_count;
> +       long last_change_ms;
> +       long max_time_ms;
> +       long prevent_sleep_time_ms;
> +       long total_time_ms;
> +       unsigned long wakeup_count;
> +};
> +
> +/*
> + * Reads and parses one wakeup_source record from the iterator file.
> + * A record is a single space-delimited line.
> + * Returns true on success, false on EOF. Asserts internally on errors.
> + */
> +static bool read_ws_info(FILE *iter_file, struct WakeupSourceInfo *ws_in=
fo,
> +                        char **line)
> +{
> +       size_t linesize;
> +       int items;
> +
> +       if (getline(line, &linesize, iter_file) =3D=3D -1)
> +               return false;
> +
> +       (*line)[strcspn(*line, "\n")] =3D 0;
> +
> +       items =3D sscanf(*line, "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu",
> +                      ws_info->name, &ws_info->active_count,
> +                      &ws_info->active_time_ms, &ws_info->event_count,
> +                      &ws_info->expire_count, &ws_info->last_change_ms,
> +                      &ws_info->max_time_ms, &ws_info->prevent_sleep_tim=
e_ms,
> +                      &ws_info->total_time_ms, &ws_info->wakeup_count);
> +
> +       if (!ASSERT_EQ(items, 10, "read wakeup source info"))
> +               return false;
> +
> +       if (!ASSERT_LT(strlen(ws_info->name), WAKEUP_SOURCE_NAME_LEN,
> +                      "name length"))
> +               return false;
> +
> +       return true;
> +}
> +
> +static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *iter=
_fd,
> +                             FILE **iter_file)
> +{
> +       *iter_fd =3D bpf_iter_create(
> +                       bpf_link__fd(skel->links.wakeup_source_collector)=
);
> +       if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
> +               return -1;
> +
> +       *iter_file =3D fdopen(*iter_fd, "r");
> +       if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static void subtest_ws_iter_check_active_count(struct wakeup_source_iter=
 *skel)
> +{
> +       static const char subtest_ws_name[] =3D "bpf_selftest_ws_active_c=
ount";
> +       const int lock_unlock_cycles =3D 5;
> +       struct WakeupSourceInfo ws_info;
> +       char *line =3D NULL;
> +       bool found_ws =3D false;
> +       FILE *iter_file =3D NULL;
> +       int iter_fd =3D -1;
> +       int i;
> +
> +       for (i =3D 0; i < lock_unlock_cycles; i++) {
> +               if (!ASSERT_OK(lock_ws(subtest_ws_name), "lock_ws"))
> +                       goto cleanup;
> +               unlock_ws(subtest_ws_name);
> +       }
> +
> +       if (!get_ws_iter_stream(skel, &iter_fd, &iter_file))
> +               goto cleanup;
> +
> +       while (read_ws_info(iter_file, &ws_info, &line)) {
> +               if (strcmp(ws_info.name, subtest_ws_name) =3D=3D 0) {
> +                       found_ws =3D true;
> +                       ASSERT_EQ(ws_info.active_count, lock_unlock_cycle=
s,
> +                                 "active_count check");
> +                       ASSERT_EQ(ws_info.wakeup_count, lock_unlock_cycle=
s,
> +                                 "wakeup_count check");
> +                       break;
> +               }
> +       }
> +
> +       ASSERT_TRUE(found_ws, "found active_count test ws");
> +
> +       free(line);
> +cleanup:
> +       if (iter_file)
> +               fclose(iter_file);
> +       else if (iter_fd >=3D 0)
> +               close(iter_fd);
> +}
> +
> +static void subtest_ws_iter_check_sleep_times(struct wakeup_source_iter =
*skel)
> +{
> +       bool found_test_ws =3D false;
> +       struct WakeupSourceInfo ws_info;
> +       char *line =3D NULL;
> +       FILE *iter_file;
> +       int iter_fd;
> +
> +       if (!get_ws_iter_stream(skel, &iter_fd, &iter_file))
> +               goto cleanup;
> +
> +       while (read_ws_info(iter_file, &ws_info, &line)) {
> +               if (strcmp(ws_info.name, test_ws_name) =3D=3D 0) {
> +                       found_test_ws =3D true;
> +                       ASSERT_GT(ws_info.last_change_ms, 0,
> +                                 "Expected non-zero last change");
> +                       ASSERT_GE(ws_info.active_time_ms, TEST_SLEEP_MS,
> +                                 "Expected active time >=3D TEST_SLEEP_M=
S");
> +                       ASSERT_GE(ws_info.max_time_ms, TEST_SLEEP_MS,
> +                                 "Expected max time >=3D TEST_SLEEP_MS")=
;
> +                       ASSERT_GE(ws_info.total_time_ms, TEST_SLEEP_MS,
> +                                 "Expected total time >=3D TEST_SLEEP_MS=
");
> +                       break;
> +               }
> +       }
> +
> +       ASSERT_TRUE(found_test_ws, "found_test_ws");
> +
> +       free(line);
> +cleanup:
> +       if (iter_file)
> +               fclose(iter_file);
> +       else if (iter_fd >=3D 0)
> +               close(iter_fd);
> +}
> +
> +static void subtest_ws_iter_check_no_infinite_reads(
> +               struct wakeup_source_iter *skel)
> +{
> +       int iter_fd;
> +       char buf[256];
> +
> +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.wakeup_sourc=
e_collector));
> +       if (!ASSERT_OK_FD(iter_fd, "iter_create"))
> +               return;
> +
> +       while (read(iter_fd, buf, sizeof(buf)) > 0)
> +               ;
> +
> +       /* Final read should return 0 */
> +       ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
> +
> +       close(iter_fd);
> +}
> +
> +void test_wakeup_source_iter(void)
> +{
> +       struct wakeup_source_iter *skel =3D NULL;
> +
> +       if (geteuid() !=3D 0) {
> +               fprintf(stderr,
> +                       "Skipping wakeup_source_iter test, requires root\=
n");
> +               test__skip();
> +               return;
> +       }
> +
> +       skel =3D wakeup_source_iter__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "wakeup_source_iter__open_and_load"))
> +               return;
> +
> +       if (!ASSERT_OK(setup_test_ws(), "setup_test_ws"))
> +               goto destroy;
> +
> +       if (!ASSERT_OK(wakeup_source_iter__attach(skel), "skel_attach"))
> +               goto destroy;
> +
> +       /*
> +        * Sleep on O(ms) to ensure that time stats' resolution isn't los=
t when
> +        * converting from ns to ms
> +        */
> +       usleep(TEST_SLEEP_US);
> +
> +       if (test__start_subtest("active_count"))
> +               subtest_ws_iter_check_active_count(skel);
> +       if (test__start_subtest("sleep_times"))
> +               subtest_ws_iter_check_sleep_times(skel);
> +       if (test__start_subtest("no_infinite_reads"))
> +               subtest_ws_iter_check_no_infinite_reads(skel);
> +
> +destroy:
> +       teardown_test_ws();
> +       wakeup_source_iter__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c b/too=
ls/testing/selftests/bpf/progs/wakeup_source_iter.c
> new file mode 100644
> index 000000000000..9a377fd28f4e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Google LLC */
> +#include <vmlinux.h>
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define NSEC_PER_MS 1000000UL
> +#define WAKEUP_SOURCE_NAME_LEN 32
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("iter/wakeup_source")
> +int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
> +{
> +       const struct wakeup_source *ws =3D ctx->wakeup_source;
> +       struct seq_file *seq =3D ctx->meta->seq;
> +       char name[WAKEUP_SOURCE_NAME_LEN] =3D {'\0'};
> +       const char *pname;
> +       bool active, autosleep_enable;
> +       u64 active_count, event_count, expire_count, wakeup_count;
> +       s64 active_time, curr_time, last_change_time, max_time,
> +           prevent_sleep_time, start_prevent_time, total_time;
> +
> +       if (!ws)
> +               return 0;
> +
> +       active =3D BPF_CORE_READ_BITFIELD_PROBED(ws, active);
> +       autosleep_enable =3D BPF_CORE_READ_BITFIELD_PROBED(ws, autosleep_=
enabled);
> +       if (bpf_core_read(&pname, sizeof(pname), &ws->name) ||
> +           bpf_probe_read_kernel_str(name, sizeof(name), pname) < 0 ||
> +           bpf_core_read(&active_count, sizeof(active_count), &ws->activ=
e_count) ||
> +           bpf_core_read(&event_count, sizeof(event_count), &ws->event_c=
ount) ||
> +           bpf_core_read(&expire_count, sizeof(expire_count), &ws->expir=
e_count) ||
> +           bpf_core_read(&last_change_time, sizeof(last_change_time), &w=
s->last_time) ||
> +           bpf_core_read(&max_time, sizeof(max_time), &ws->max_time) ||
> +           bpf_core_read(
> +               &prevent_sleep_time, sizeof(prevent_sleep_time), &ws->pre=
vent_sleep_time) ||
> +           bpf_core_read(
> +               &start_prevent_time, sizeof(start_prevent_time), &ws->sta=
rt_prevent_time) ||
> +           bpf_core_read(&total_time, sizeof(total_time), &ws->total_tim=
e) ||
> +           bpf_core_read(&wakeup_count, sizeof(wakeup_count), &ws->wakeu=
p_count))
> +               return 0;

you really don't need to do this for types returned from iterators,
try just accessing ws->start_prevent_time (and any other field)
directly

> +
> +
> +       curr_time =3D bpf_ktime_get_ns();
> +       active_time =3D 0;
> +       if (active) {
> +               active_time =3D curr_time - last_change_time;
> +               total_time +=3D active_time;
> +               if (active_time > max_time)
> +                       max_time =3D active_time;
> +               if (autosleep_enable)
> +                       prevent_sleep_time +=3D curr_time - start_prevent=
_time;
> +
> +       }
> +
> +       BPF_SEQ_PRINTF(seq,
> +                      "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu\n",
> +                      name,
> +                      active_count,
> +                      active_time / NSEC_PER_MS,
> +                      event_count,
> +                      expire_count,
> +                      last_change_time / NSEC_PER_MS,
> +                      max_time / NSEC_PER_MS,
> +                      prevent_sleep_time / NSEC_PER_MS,
> +                      total_time / NSEC_PER_MS,
> +                      wakeup_count);
> +       return 0;
> +}
> --
> 2.52.0.457.g6b5491de43-goog
>

