Return-Path: <linux-kselftest+bounces-35018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F753AD9E64
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 19:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D98188DFA1
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878941D63C0;
	Sat, 14 Jun 2025 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aESQ9WaQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59161192D87;
	Sat, 14 Jun 2025 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749920940; cv=none; b=unu8eNhr4vWlKPCAk+g0yqRJoWo5FH8VtK+2mZwsCS92Uzw1TC8zwNKdcQyiyuHIF3Goud1XjtchgeYm+Axa3hB3V01e4k327p3+OgmRd8LKYlEs2Tl0ggB6yGUYBAPJcv6i1qhTqilSB6mflp2QtV8N4eVVdktj2OEcZ0IunGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749920940; c=relaxed/simple;
	bh=QqmB2XOqS0gn474jgB0ddFBNckL0U6p5fwOxoQfHEuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsuAn2/bvVpOO0HBO/jgIjLt1CoI7IMu2NsBW9Bgk5vphiXY7Vv0FQCaA2wzOORXQUBB2XKzm0GrfpbqX6ltuhJ3NuKnur74r+qmfdG0qJeiqrgEX9fUf+DYWIiBUZkZtamXFx4Ni7IRvU6XfHAwU00yORoWdpqHga/OdV6cRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aESQ9WaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63568C4CEEB;
	Sat, 14 Jun 2025 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749920939;
	bh=QqmB2XOqS0gn474jgB0ddFBNckL0U6p5fwOxoQfHEuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aESQ9WaQz1Cwb8dCYpUl7Sk+a39B6iR6H+kjkEEenqngynvwvR2Z2Yg4Gk0+Jmvdq
	 8p4HcjtOjLSXbPpQzzUD/SVHYg3iBVqKDNGSyiy+jgPZnVN0LkrEJ2StlKDdc4Ug/6
	 VupwBlOmjSN20+R9fCD+erQfXTZPoSOo0rqjRPc5xhu/MtDwhLyI/0F+bL9oCDTBl/
	 jZYwRCLjKoyPVjsQBDm6EKV9/NY5n/3As+XMSsHfMSFiyMXo6wj531+KP3fVG+6rNW
	 6wOyObZDMROBJPVor7P/GYnc8qrUJKk/1KKhkpv7yFNk7bzOl2f2+TenzXz6bGeye1
	 DMD71PyuWN3DA==
Date: Sat, 14 Jun 2025 10:08:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?=
 =?UTF-8?B?bg==?=" <toke@toke.dk>
Subject: Re: [PATCH net-next v3] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <20250614100853.3f2372f2@kernel.org>
In-Reply-To: <20250613234420.1613060-1-almasrymina@google.com>
References: <20250613234420.1613060-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2025 23:44:20 +0000 Mina Almasry wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
>=20
> We frequently consult with Jesper's out-of-tree page_pool benchmark to
> evaluate page_pool changes.
>=20
> Import the benchmark into the upstream linux kernel tree so that (a)
> we're all running the same version, (b) pave the way for shared
> improvements, and (c) maybe one day integrate it with nipa, if possible.
>=20
> Import bench_page_pool_simple from commit 35b1716d0c30 ("Add
> page_bench06_walk_all"), from this repository:
> https://github.com/netoptimizer/prototype-kernel.git
>=20
> Changes done during upstreaming:
> - Fix checkpatch issues.

There is more:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#81:=20
new file mode 100644

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#122: FILE: tools/testing/selftests/net/bench/page_pool/bench_page_pool_sim=
ple.c:1:
+/*

CHECK: Please use a blank line after function/struct/union/enum declarations
#163: FILE: tools/testing/selftests/net/bench/page_pool/bench_page_pool_sim=
ple.c:42:
+};
+#define bit(b)		(1 << (b))

WARNING: Block comments use a trailing */ on a separate line
#172: FILE: tools/testing/selftests/net/bench/page_pool/bench_page_pool_sim=
ple.c:51:
+ * introduced by the for loop itself */

WARNING: Prefer kcalloc over kzalloc with multiply
#238: FILE: tools/testing/selftests/net/bench/page_pool/bench_page_pool_sim=
ple.c:117:
+	array =3D kzalloc(sizeof(struct page *) * elems, gfp_mask);

WARNING: braces {} are not necessary for single statement blocks
#240: FILE: tools/testing/selftests/net/bench/page_pool/bench_page_pool_sim=
ple.c:119:
+	for (i =3D 0; i < elems; i++) {
+		array[i] =3D page_pool_alloc_pages(pp, gfp_mask);
+	}

WARNING: braces {} are not necessary for single statement blocks
#243: FILE: tools/testing/selftests/net/bench/page_pool/bench_page_pool_sim=
ple.c:122:
+	for (i =3D 0; i < elems; i++) {
+		_page_pool_put_page(pp, array[i], false);
+	}

WARNING: line length of 81 exceeds 80 columns
#288: FILE: tools/testing/selftests/net/bench/page_pool/bench_page_pool_sim=
ple.c:167:
+		/* Common fast-path alloc, that depend on in_serving_softirq() */

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#402: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:1:
+/*

WARNING: line length of 81 exceeds 80 columns
#451: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:50:
+ * Architectures Software Developer=E2=80=99s Manual Volume 3: System Prog=
ramming Guide

CHECK: Alignment should match open parenthesis
#491: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:90:
+		perf_event =3D perf_event_create_kernel_counter(&perf_conf, cpu,
+						 NULL /* task */,

CHECK: spaces preferred around that '|' (ctx:VxV)
#626: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:225:
+	rec.flags       =3D (TIME_BENCH_LOOP|TIME_BENCH_TSC|TIME_BENCH_WALLCLOCK);
 	                                  ^

CHECK: spaces preferred around that '|' (ctx:VxV)
#626: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:225:
+	rec.flags       =3D (TIME_BENCH_LOOP|TIME_BENCH_TSC|TIME_BENCH_WALLCLOCK);
 	                                                 ^

CHECK: Lines should not end with a '('
#743: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:342:
+void time_bench_run_concurrent(

CHECK: spaces preferred around that '|' (ctx:VxV)
#772: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:371:
+		c->rec.flags       =3D (TIME_BENCH_LOOP|TIME_BENCH_TSC|
 		                                     ^

CHECK: space preferred before that '|' (ctx:VxE)
#772: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:371:
+		c->rec.flags       =3D (TIME_BENCH_LOOP|TIME_BENCH_TSC|
 		                                                    ^

WARNING: Missing a blank line after declarations
#801: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.c:400:
+		struct time_bench_cpu *c =3D &cpu_tasks[cpu];
+		kthread_stop(c->task);

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#814: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:1:
+/*

WARNING: please, no space before tabs
#829: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:16:
+^Iuint32_t flags; ^I/* Measurements types enabled */$

CHECK: spaces preferred around that '<<' (ctx:VxV)
#830: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:17:
+#define TIME_BENCH_LOOP		(1<<0)
                        		  ^

CHECK: Prefer using the BIT macro
#830: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:17:
+#define TIME_BENCH_LOOP		(1<<0)

CHECK: spaces preferred around that '<<' (ctx:VxV)
#831: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:18:
+#define TIME_BENCH_TSC		(1<<1)
                       		  ^

CHECK: Prefer using the BIT macro
#831: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:18:
+#define TIME_BENCH_TSC		(1<<1)

CHECK: spaces preferred around that '<<' (ctx:VxV)
#832: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:19:
+#define TIME_BENCH_WALLCLOCK	(1<<2)
                             	  ^

CHECK: Prefer using the BIT macro
#832: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:19:
+#define TIME_BENCH_WALLCLOCK	(1<<2)

CHECK: spaces preferred around that '<<' (ctx:VxV)
#833: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:20:
+#define TIME_BENCH_PMU		(1<<3)
                       		  ^

CHECK: Prefer using the BIT macro
#833: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:20:
+#define TIME_BENCH_PMU		(1<<3)

WARNING: please, no space before tabs
#838: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:25:
+^Iuint64_t invoked_cnt; ^I/* Returned actual invocations */$

WARNING: Block comments use a trailing */ on a separate line
#844: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:31:
+	 * instructions counter including pipelined instructions */

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#917: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:104:
+	unsigned hi, lo;

WARNING: Missing a blank line after declarations
#918: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:105:
+	unsigned hi, lo;
+	asm volatile("CPUID\n\t"

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#930: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:117:
+	unsigned hi, lo;

WARNING: Missing a blank line after declarations
#931: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:118:
+	unsigned hi, lo;
+	asm volatile("RDTSCP\n\t"

WARNING: Block comments use * on subsequent lines
#955: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:142:
+/*
+inline uint64_t rdtsc(void)

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#997: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:184:
+static __always_inline unsigned long long p_rdpmc(unsigned in)

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#999: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:186:
+	unsigned d, a;

CHECK: Lines should not end with a '('
#1038: FILE: tools/testing/selftests/net/bench/page_pool/time_bench.h:225:
+void time_bench_run_concurrent(

WARNING: line length of 113 exceeds 80 columns
#1097: FILE: tools/testing/selftests/net/bench/test_bench_page_pool.sh:19:
+	echo ${result} | grep -o -E "no-softirq-page_pool01 Per elem: ([0-9]+) cy=
cles\(tsc\) ([0-9]+\.[0-9]+) ns"

WARNING: line length of 113 exceeds 80 columns
#1101: FILE: tools/testing/selftests/net/bench/test_bench_page_pool.sh:23:
+	echo ${result} | grep -o -E "no-softirq-page_pool02 Per elem: ([0-9]+) cy=
cles\(tsc\) ([0-9]+\.[0-9]+) ns"

WARNING: line length of 113 exceeds 80 columns
#1105: FILE: tools/testing/selftests/net/bench/test_bench_page_pool.sh:27:
+	echo ${result} | grep -o -E "no-softirq-page_pool03 Per elem: ([0-9]+) cy=
cles\(tsc\) ([0-9]+\.[0-9]+) ns"

total: 0 errors, 33 warnings, 17 checks, 995 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

Commit 12b4bc1bc38a ("page_pool: import Jesper's page_pool benchmark") has =
style problems, please review.

NOTE: Ignored message types: ALLOC_SIZEOF_STRUCT BAD_REPORTED_BY_LINK CAMEL=
CASE COMMIT_LOG_LONG_LINE GIT_COMMIT_ID MACRO_ARG_REUSE NO_AUTHOR_SIGN_OFF

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
total: 0 errors, 33 warnings, 17 checks, 995 lines checked

> diff --git a/tools/testing/selftests/net/bench/page_pool/time_bench.c b/t=
ools/testing/selftests/net/bench/page_pool/time_bench.c
> new file mode 100644
> index 000000000000..257b1515c64e
> --- /dev/null
> +++ b/tools/testing/selftests/net/bench/page_pool/time_bench.c
> @@ -0,0 +1,406 @@
> +/*
> + * Benchmarking code execution time inside the kernel
> + *
> + * Copyright (C) 2014, Red Hat, Inc., Jesper Dangaard Brouer
> + *  for licensing details see kernel-base/COPYING

don't think kernel-base/COPYING exists

coccicheck also says:

testing/tools/testing/selftests/net/bench/page_pool/time_bench.c:57:36-37: =
WARNING: Use ARRAY_SIZE
testing/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.=
c:223:5-17: Unneeded variable: "passed_count". Return "0" on line 245

IIUC the former is in user space code, but maybe we can add a define
for ARRAY_SIZE and use it? It's pretty trivial.
--=20
pw-bot: cr

