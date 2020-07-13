Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799AE21E07A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGMTIK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 15:08:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18864 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 15:08:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0cb10c0000>; Mon, 13 Jul 2020 12:07:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 12:08:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 12:08:09 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 19:08:09 +0000
Subject: Re: [PATCH v2 6/8] selftests/harness: Refactor XFAIL into SKIP
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
CC:     Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
 <20200622181651.2795217-7-keescook@chromium.org>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <90fa90dc-7155-6096-678d-b6c103c1b0a6@nvidia.com>
Date:   Mon, 13 Jul 2020 12:08:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200622181651.2795217-7-keescook@chromium.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594667277; bh=k8Rx8egc4VWrtLEdkdOsk8Genda7v6yEkwOh6bRFBeU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CAQlkaRyw9RfvrZEDo595b5cxQE0RQu7d6lFMphiZdNTTnI/7zwFPomTWJnRuq6Pd
         HqectkwD+USkWatPxIA/A06z6M6ZNhk8HM4UcswNdQnTK+BAXVcrRCTaWoOia12vj5
         LKB+ZNevNpbyGtUt0qFrHkLlmtDLKnzryiscEKSaSevw5x6wgt9dXD7CsU35vwxj/+
         eYhSwC1ucJhtekwhUmH4MhKzWqdEskeyQboj2Pq0JxTSLIdsUpfDMd1UTstll2oTon
         715Y1ewcO81T+4cKPBJ11NePym2rCUQo56LhofLziIS0V75Mfz1bOrgTeWeaRcUbA2
         llFHbjzt5Tzwg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/22/20 11:16 AM, Kees Cook wrote:
> Plumb the old XFAIL result into a TAP SKIP.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   tools/testing/selftests/kselftest_harness.h   | 64 ++++++++++++++-----
>   tools/testing/selftests/seccomp/seccomp_bpf.c |  8 +--
>   2 files changed, 52 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index f8f7e47c739a..b519765904a6 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -112,22 +112,22 @@
>   			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
>   
>   /**
> - * XFAIL(statement, fmt, ...)
> + * SKIP(statement, fmt, ...)
>    *
> - * @statement: statement to run after reporting XFAIL
> + * @statement: statement to run after reporting SKIP
>    * @fmt: format string
>    * @...: optional arguments
>    *
> - * This forces a "pass" after reporting a failure with an XFAIL prefix,
> + * This forces a "pass" after reporting why something is being skipped
>    * and runs "statement", which is usually "return" or "goto skip".
>    */
> -#define XFAIL(statement, fmt, ...) do { \
> +#define SKIP(statement, fmt, ...) do { \
>   	if (TH_LOG_ENABLED) { \
> -		fprintf(TH_LOG_STREAM, "#      XFAIL     " fmt "\n", \
> +		fprintf(TH_LOG_STREAM, "#      SKIP     " fmt "\n", \
>   			##__VA_ARGS__); \
>   	} \
> -	/* TODO: find a way to pass xfail to test runner process. */ \
>   	_metadata->passed = 1; \
> +	_metadata->skip = 1; \
>   	_metadata->trigger = 0; \
>   	statement; \
>   } while (0)
> @@ -777,6 +777,7 @@ struct __test_metadata {
>   	struct __fixture_metadata *fixture;
>   	int termsig;
>   	int passed;
> +	int skip;	/* did SKIP get used? */
>   	int trigger; /* extra handler after the evaluation */
>   	int timeout;	/* seconds to wait for test timeout */
>   	bool timed_out;	/* did this test timeout instead of exiting? */
> @@ -866,17 +867,31 @@ void __wait_for_test(struct __test_metadata *t)
>   		fprintf(TH_LOG_STREAM,
>   			"# %s: Test terminated by timeout\n", t->name);
>   	} else if (WIFEXITED(status)) {
> -		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
>   		if (t->termsig != -1) {
> +			t->passed = 0;
>   			fprintf(TH_LOG_STREAM,
>   				"# %s: Test exited normally instead of by signal (code: %d)\n",
>   				t->name,
>   				WEXITSTATUS(status));
> -		} else if (!t->passed) {
> -			fprintf(TH_LOG_STREAM,
> -				"# %s: Test failed at step #%d\n",
> -				t->name,
> -				WEXITSTATUS(status));
> +		} else {
> +			switch (WEXITSTATUS(status)) {
> +			/* Success */
> +			case 0:
> +				t->passed = 1;
> +				break;
> +			/* SKIP */
> +			case 255:
> +				t->passed = 1;
> +				t->skip = 1;
> +				break;
> +			/* Other failure, assume step report. */
> +			default:
> +				t->passed = 0;
> +				fprintf(TH_LOG_STREAM,
> +					"# %s: Test failed at step #%d\n",
> +					t->name,
> +					WEXITSTATUS(status));
> +			}
>   		}
>   	} else if (WIFSIGNALED(status)) {
>   		t->passed = 0;
> @@ -906,6 +921,7 @@ void __run_test(struct __fixture_metadata *f,
>   {
>   	/* reset test struct */
>   	t->passed = 1;
> +	t->skip = 0;
>   	t->trigger = 0;
>   	t->step = 0;
>   	t->no_print = 0;
> @@ -918,15 +934,31 @@ void __run_test(struct __fixture_metadata *f,
>   		t->passed = 0;
>   	} else if (t->pid == 0) {
>   		t->fn(t, variant);
> -		/* return the step that failed or 0 */
> -		_exit(t->passed ? 0 : t->step);
> +		/* Make sure step doesn't get lost in reporting */
> +		if (t->step >= 255) {
> +			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
> +			t->step = 254;
> +		}

I noticed that this message is now appearing in the HMM self tests.
I haven't quite tracked down why ->steps should be 255 after running
the first test. I did notice that ASSERT*() calls __INC_STEP() but
that doesn't explain it.
Separately, maybe __INC_STEP() should check for < 254 instead of < 255?

     Set CONFIG_HMM_TESTS=m, build and install kernel and modules.
     cd tools/testing/selftests/vm
     make
     ./test_hmm.sh smoke
     Running smoke test. Note, this test provides basic coverage.
     [  106.803476] memmap_init_zone_device initialised 65536 pages in 7ms
     [  106.810141] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3ffff0000 0x400000000)
     [  106.823703] memmap_init_zone_device initialised 65536 pages in 4ms
     [  106.829968] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3fffe0000 0x3ffff0000)
     [  106.838655] HMM test module loaded. This is only for testing HMM.
     TAP version 13
     1..20
     # Starting 20 tests from 3 test cases.
     #  RUN           hmm.open_close ...
     #            OK  hmm.open_close
     ok 1 hmm.open_close
     #  RUN           hmm.anon_read ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_read
     ok 2 hmm.anon_read
     #  RUN           hmm.anon_read_prot ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_read_prot
     ok 3 hmm.anon_read_prot
     #  RUN           hmm.anon_write ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_write
     ok 4 hmm.anon_write
     #  RUN           hmm.anon_write_prot ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_write_prot
     ok 5 hmm.anon_write_prot
     #  RUN           hmm.anon_write_child ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_write_child
     ok 6 hmm.anon_write_child
     #  RUN           hmm.anon_write_child_shared ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_write_child_shared
     ok 7 hmm.anon_write_child_shared
     #  RUN           hmm.anon_write_huge ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_write_huge
     ok 8 hmm.anon_write_huge
     #  RUN           hmm.anon_write_hugetlbfs ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_write_hugetlbfs
     ok 9 hmm.anon_write_hugetlbfs
     #  RUN           hmm.file_read ...
     # Too many test steps (255)!?
     #            OK  hmm.file_read
     ok 10 hmm.file_read
     #  RUN           hmm.file_write ...
     # Too many test steps (255)!?
     #            OK  hmm.file_write
     ok 11 hmm.file_write
     #  RUN           hmm.migrate ...
     # Too many test steps (255)!?
     #            OK  hmm.migrate
     ok 12 hmm.migrate
     #  RUN           hmm.migrate_fault ...
     # Too many test steps (255)!?
     #            OK  hmm.migrate_fault
     ok 13 hmm.migrate_fault
     #  RUN           hmm.migrate_shared ...
     #            OK  hmm.migrate_shared
     ok 14 hmm.migrate_shared
     #  RUN           hmm.migrate_multiple ...
     # Too many test steps (255)!?
     #            OK  hmm.migrate_multiple
     ok 15 hmm.migrate_multiple
     #  RUN           hmm.anon_read_multiple ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_read_multiple
     ok 16 hmm.anon_read_multiple
     #  RUN           hmm.anon_teardown ...
     # Too many test steps (255)!?
     #            OK  hmm.anon_teardown
     ok 17 hmm.anon_teardown
     #  RUN           hmm2.migrate_mixed ...
     #            OK  hmm2.migrate_mixed
     ok 18 hmm2.migrate_mixed
     #  RUN           hmm2.snapshot ...
     #            OK  hmm2.snapshot
     ok 19 hmm2.snapshot
     #  RUN           hmm2.double_map ...
     # Too many test steps (255)!?
     #            OK  hmm2.double_map
     ok 20 hmm2.double_map
     # PASSED: 20 / 20 tests passed.
     # Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

> +		/* Use 255 for SKIP */
> +		if (t->skip)
> +			_exit(255);
> +		/* Pass is exit 0 */
> +		if (t->passed)
> +			_exit(0);
> +		/* Something else happened, report the step. */
> +		_exit(t->step);
>   	} else {
>   		__wait_for_test(t);
>   	}
>   	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
>   	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
> -	ksft_test_result(t->passed, "%s%s%s.%s\n",
> -	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
> +
> +	if (t->skip)
> +		ksft_test_result_skip("%s%s%s.%s\n",
> +			f->name, variant->name[0] ? "." : "", variant->name, t->name);
> +	else
> +		ksft_test_result(t->passed, "%s%s%s.%s\n",
> +			f->name, variant->name[0] ? "." : "", variant->name, t->name);
>   }
>   
>   static int test_harness_run(int __attribute__((unused)) argc,
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 252140a52553..8c1cc8033c09 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -3069,7 +3069,7 @@ TEST(get_metadata)
>   
>   	/* Only real root can get metadata. */
>   	if (geteuid()) {
> -		XFAIL(return, "get_metadata requires real root");
> +		SKIP(return, "get_metadata requires real root");
>   		return;
>   	}
>   
> @@ -3112,7 +3112,7 @@ TEST(get_metadata)
>   	ret = ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
>   	EXPECT_EQ(sizeof(md), ret) {
>   		if (errno == EINVAL)
> -			XFAIL(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
> +			SKIP(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
>   	}
>   
>   	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
> @@ -3673,7 +3673,7 @@ TEST(user_notification_continue)
>   	resp.val = 0;
>   	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0) {
>   		if (errno == EINVAL)
> -			XFAIL(goto skip, "Kernel does not support SECCOMP_USER_NOTIF_FLAG_CONTINUE");
> +			SKIP(goto skip, "Kernel does not support SECCOMP_USER_NOTIF_FLAG_CONTINUE");
>   	}
>   
>   skip:
> @@ -3681,7 +3681,7 @@ TEST(user_notification_continue)
>   	EXPECT_EQ(true, WIFEXITED(status));
>   	EXPECT_EQ(0, WEXITSTATUS(status)) {
>   		if (WEXITSTATUS(status) == 2) {
> -			XFAIL(return, "Kernel does not support kcmp() syscall");
> +			SKIP(return, "Kernel does not support kcmp() syscall");
>   			return;
>   		}
>   	}
> 
