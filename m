Return-Path: <linux-kselftest+bounces-9892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48718C1766
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B11F221F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2886244;
	Thu,  9 May 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HPZWOmhn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F580BE5;
	Thu,  9 May 2024 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285773; cv=none; b=nwncLGbTUR9isNlfkxTEv/YqXC46G+RejkoV+juMAHKJzOhJcWDQpnMJhW7SDxFsb2dneYUJIDfk/WqB0y5vuVsx+Q/x5/qlbDA9FJVOWILCW9wBAxf52T5IvO0tzs1UMWPgz0u4Y0oB1BTW8G7xhUFdu0ha/U0W/pR3t/bYtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285773; c=relaxed/simple;
	bh=cMWw8x/P40/KMWgVweNbntQjYA+K9n2XKgcRYU9QC9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWj7pCbiJUYOoNITLg2fMvzibWkoG5woXPyoKyZ3FDQs3ED0W7yHe8FzClP3TJTL8Ft4SjxLzJMcbaZfN8CbmxM47sRBdjF+slL2QBRCWFtTpPmpnmvL5GIU6enZ98pvfds0yFpulvt6Zb/MV5kIJgrWbkayjnvSwEqejzhcek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HPZWOmhn; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1715285763;
	bh=cMWw8x/P40/KMWgVweNbntQjYA+K9n2XKgcRYU9QC9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HPZWOmhnoRkqipHqnwg6g545VwMlsV8zx/BSHSoFPE4eWw/mPW4cf0jmeu422Z636
	 jLntHYOgVNutEjpLrWE9rP1+MPli0NS8sJtlLTVtYguaOTUm+CI3HmXiFtMYktT8Ql
	 FX7RzuXYLAAEEvihpE/pWrH7pdCmnGMkPWZh//qC1SMDLhRv9YnaftIhQfQitZZkKa
	 RamXBJLbx3DsqqXTvrWF2nqFsEHQH+JMe/Okl/wi7F4CIjX7ap+LzVAwX78Jj8CHfN
	 IFkpFCckFqnrzKm/TaiKH4FX05dPGhNGc4WCKG05ghyQKfvelcPFGNsUruPcwx/gTc
	 /zFV5k2dA0e8g==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vb3Df5nW8zyZy;
	Thu,  9 May 2024 16:16:02 -0400 (EDT)
Message-ID: <638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com>
Date: Thu, 9 May 2024 16:16:20 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 54/68] selftests/rseq: Drop define _GNU_SOURCE
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
References: <20240509200022.253089-1-edliaw@google.com>
 <20240509200022.253089-55-edliaw@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240509200022.253089-55-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-09 15:58, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")

The patch per se looks fine, except for the "Fixes" tag.

Commit 809216233555 introduces use of asprintf in kselftest_harness.h
which is used by (all ?) selftests, including the rseq ones. However,
the rseq selftests each have the #define _GNU_SOURCE, which would have
been OK without those further changes.

So this patch is more about consolidating where the _GNU_SOURCE is
defined, which is OK with me, but not so much about "fixing" an
issue with commit 809216233555.

A "Fix" is something to be backported to stable kernels, and I
don't think this patch reaches that threshold.

If anything, this patch removes a warning that gets added by
https://lore.kernel.org/lkml/20240509200022.253089-1-edliaw@google.com/T/#mf8438d03de6e2b613da4f86d4f60c5fe1c5f8483
within the same series.

Arguably, each #define _GNU_SOURCE could have been first protected
by a #ifndef guard to eliminate this transient warning, and there
would be nothing to "fix" in this consolidation series.

Thoughts ?

Thanks,

Mathieu

> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
>   tools/testing/selftests/rseq/basic_test.c            | 2 --
>   tools/testing/selftests/rseq/param_test.c            | 1 -
>   tools/testing/selftests/rseq/rseq.c                  | 2 --
>   4 files changed, 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> index 2348d2c20d0a..5961c24ee1ae 100644
> --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> @@ -1,5 +1,4 @@
>   // SPDX-License-Identifier: LGPL-2.1
> -#define _GNU_SOURCE
>   #include <assert.h>
>   #include <pthread.h>
>   #include <sched.h>
> diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
> index 295eea16466f..1fed749b4bd7 100644
> --- a/tools/testing/selftests/rseq/basic_test.c
> +++ b/tools/testing/selftests/rseq/basic_test.c
> @@ -2,8 +2,6 @@
>   /*
>    * Basic test coverage for critical regions and rseq_current_cpu().
>    */
> -
> -#define _GNU_SOURCE
>   #include <assert.h>
>   #include <sched.h>
>   #include <signal.h>
> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
> index 2f37961240ca..48a55d94eb72 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -1,5 +1,4 @@
>   // SPDX-License-Identifier: LGPL-2.1
> -#define _GNU_SOURCE
>   #include <assert.h>
>   #include <linux/membarrier.h>
>   #include <pthread.h>
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index 96e812bdf8a4..88602889414c 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -14,8 +14,6 @@
>    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>    * Lesser General Public License for more details.
>    */
> -
> -#define _GNU_SOURCE
>   #include <errno.h>
>   #include <sched.h>
>   #include <stdio.h>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


