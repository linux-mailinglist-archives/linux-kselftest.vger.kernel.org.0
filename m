Return-Path: <linux-kselftest+bounces-49013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FAD24363
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431F93010762
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E617736D513;
	Thu, 15 Jan 2026 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="bqp9qSsu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306936999D;
	Thu, 15 Jan 2026 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477060; cv=none; b=r2EoS3oZl25n2U5LVyrXkxZNf4q8G+r8DBCL73D9a8yuORNIGUTAj3YcFdPWWOAbB0zZKYDTILGJrKjp89okBwpQ38ddp8SUfT5FpaEaZYccstmzf/gT1wknETrCma7OaGm8ctFUHXyhzgs/dA+vBrShjG/bb+gOV6/KOfYqbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477060; c=relaxed/simple;
	bh=LzYkiAiHm2RTvAHf0+8Q0jiN2uvdAkqjU+2nYgkemDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiXDlyP5GhIL/i4WH5l1JFabd/PtTpwiO4Wr3zMu2mFYUUfxLCmB9unPbIDoMsZkG4mwGwFqYmRsFbenUL+VR2wNy2l8y0zgz6EtY/Wn4ORACoF8Yxojq9JGhpngW+136v6sX3loalqZFPOiWP4vQFq1Gv4FVRwtgHRgNkK5j6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=bqp9qSsu; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (unknown [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4dsLS45Wlnz7l;
	Thu, 15 Jan 2026 11:32:20 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4dsLS33HddzJY;
	Thu, 15 Jan 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=bqp9qSsu;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1768476740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fo1J6VIOw2l0PBUx+EPJKeFOUsGUJgTJRnUZ4CGCFEQ=;
	b=bqp9qSsuxvvlv32hrEd0Qjt761RLN9ZkqD1xVTSumfncDplv5GljLxrqLK/vXrvO2SkhCX
	bAgX2++LKshjsvDPjBpLtlNAwjJScB64VeT4eRbHdkBuQU8CeVEP+OtcYm6hYslDKcIcxF
	zMTwSrcPDdsNs7ktVVrNt22CrRG0l9AMAJijYPEmynQMnBQbORWC9aUbx8rDlo3PDlHpOM
	7tFEUM28vl92bV1aT/3Hhg935LS1bqBrewH7QkcIzQUtRcPb6XMdOja6BPVmFWmpytmDQt
	IJW0QlheHD7KjGpNTAwsGTbCGFNYmVuj4Y5SqgAZz7hb4vhXdK8kQt4JarXB9w==
X-CMAE-Score: 0
X-CM-Analysis: v=2.4 cv=I7afRMgg c=1 sm=1 tr=0 ts=6968d044 a=vzOQIoBu8N4nb49veeH0EQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=P-IC7800AAAA:8 a=qk-g_RkzIGHoAvPcOGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-CM-Envelope: MS4xfBRHhQ7cUS/zpecA4Zxp28BAvEwbeuZeY4HGFIEfROgse3ULlRQxNpv0iEdHBibdXHvltzIBD4KDmzODXCnLgUxHeFhqI+sBSKySHxvo3jmKssytMvz5 HbE1vvrHxM3xyf88UpNIiBP3zIP74xI3djara4OeVe5D46eRaCBHhR6Ilfjou2HK1zX14hR8jZ82RGQf76NVAkDwDRagvfc7b92wompGIA43RoA5bYmCZTQb jxgdSeamYiW9NnVLdn+6zN7feWvRnwOLPy8Zd9+e0MTLk97KL7uN1BQrKL94OquxbtVYcaibCMhrnNMuyFYTw136Syobv4hqkmTmCht96ZiYuyuVVxnIJ1Eb UirI/88hA5rmTkzaPMD5BehZNsm7GTJDfnOs0cQspeLkHDP5j6Q8PrtV6JXdr2CbuxDoRiyPqoLA6uQrvrPEgajEWKmA9hBRhQ7U8YwmWfa+piWM0mXyBcrm c31qr1LlI+osU9s/1KgLo9vbjLLmxv5XEMc7+2lj+WlWWu8WqiqHe6i1eKzHfV+aegemMCBAf2NkD1mJO0XZyAbnUcBe2hqz/gHg/yxtG+LJjjWmE4DNglje c/TK8xo//LYDTAayfVSJlPmz/KR1Vl+isBSENCiUWzieegganbbpceBHjPiwUKDYYQVZJO67VjniE+E/LgGehOdgZMDu7ItwgoEx691ahSPj2ZQWh4xzs4Sy vpDVTqwDhJzIZhXOfkfYdaPF+2y9cYhZb5iayWU3z4l5Ahru3vC8omOzHBJYJG59C96sQf0EBTaVzU3jNIPy7cOSd7VQWlMYZVGiN9Krmt9IWdMywfmv8+WK We8TT4rGP7UoVDdh9zkSwlGIpO4yFAC9n4gWoBIpE2B98/88RMgts1jKrVj4cwsbTHO9s8Ocr28Qm4drtCl9A0F5//izD7gVIjb6Ohzf
X-Soverin-Id: 019bc16d-89a0-703b-a8ee-d67e122d7b2f
Message-ID: <d927b00a-68ef-4ff0-b655-7f45b6d5764d@qmon.net>
Date: Thu, 15 Jan 2026 11:32:18 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf/selftests: introduce bptool test runner
 and a first test
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <20260114-bpftool-tests-v1-2-cfab1cc9beaf@bootlin.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20260114-bpftool-tests-v1-2-cfab1cc9beaf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham

2026-01-14 09:59 UTC+0100 ~ "Alexis Lothoré (eBPF Foundation)"
<alexis.lothore@bootlin.com>
> The tools/testing/selftests/bpf directory contains multiple scripts
> (shell, python, c code, etc) that aim to test some specific features
> from bpftool. Those isolated tests are currently not executed by any CI
> automation. Create a dedicated runner for any bpftool-related test that
> can then be added to the list of executed runners in bpf CI automation.
> This new runner (and the corresponding Makefile tooling) is highly
> inspired from test_progs, but kept a bit simpler. This version supports
> the following features:
> 
> - autodetection of bpftool test stored in the in bpftool_tests


(Typo: "in the in")


>   directory
> - bpftool binary under test is passed as runner argument
> - a few helpers to allow to easily run abpftool commands while possibly


(Typo: abpftool)


>   collecting the output
> - usage of assert macros shared with test_progs
> - basic sub-tests management
> - logs collection, logs being dumped only for failed tests
> - exit code reflecting whether all tests have passed or not
> 
> As this runner needs at least one test to be implemented to properly
> compile, also bring bpftool_metadata, which is the conversion of
> test_bpftool_metadata.sh: this test validates that the output of some
> basic prog/map listings done with bpftool properly returns the metadata
> collected from the .rodata section of eBPF programs.
> 
> This new runner gives an output similar to the one generated by
> test_progs:
> 
>   #2/1	metadata/metadata_unused: OK
>   #2/2	metadata/metadata_used: OK
>   #2	metadata: OK
>   Summary: 1 PASSED, 0 FAILED
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>


Thanks a lot for this! It looks good, I only have a few minor comments.


> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 +
>  tools/testing/selftests/bpf/Makefile               |  14 ++-
>  tools/testing/selftests/bpf/bpftool_helpers.c      | 114 ++++++++++++++++++
>  tools/testing/selftests/bpf/bpftool_helpers.h      |  19 +++
>  .../testing/selftests/bpf/bpftool_tests/.gitignore |   2 +
>  .../selftests/bpf/bpftool_tests/bpftool_metadata.c | 128 +++++++++++++++++++++
>  tools/testing/selftests/bpf/test_bpftool.c         | 126 ++++++++++++++++++++
>  tools/testing/selftests/bpf/test_bpftool.h         |  36 ++++++
>  8 files changed, 439 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index b8bf51b7a0b0..9498cc11de97 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -2,6 +2,7 @@
>  bpftool
>  bpf-helpers*
>  bpf-syscall*
> +test_bpftool
>  test_verifier
>  test_maps
>  test_lru_map
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index fd42b7193d4e..a1fe94efa53c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -76,7 +76,8 @@ endif
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
>  	test_sockmap \
>  	test_tcpnotify_user \
> -	test_progs-no_alu32
> +	test_progs-no_alu32 \
> +	test_bpftool
>  TEST_INST_SUBDIRS := no_alu32
>  
>  # Also test bpf-gcc, if present
> @@ -791,6 +792,17 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
>  TRUNNER_BPF_CFLAGS :=
>  $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>  
> +# Define bpftool test runner.
> +TRUNNER_TESTS_DIR := bpftool_tests
> +TRUNNER_BPF_PROGS_DIR := progs
> +TRUNNER_EXTRA_SOURCES := test_bpftool.c \
> +			 bpftool_helpers.c
> +TRUNNER_LIB_SOURCES :=
> +TRUNNER_EXTRA_FILES :=
> +TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> +TRUNNER_BPF_CFLAGS :=
> +$(eval $(call DEFINE_TEST_RUNNER,test_bpftool))
> +
>  # Define test_verifier test runner.
>  # It is much simpler than test_maps/test_progs and sufficiently different from
>  # them (e.g., test.h is using completely pattern), that it's worth just
> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
> new file mode 100644
> index 000000000000..ff8084d9a121
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "bpftool_helpers.h"
> +#include "test_bpftool.h"
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdbool.h>
> +
> +#define BPFTOOL_PATH		"./tools/sbin/bpftool"
> +#define BPFTOOL_CMD_MAX_LEN	256
> +
> +static int run_command(char *command, bool get_output, char *output_buf, size_t output_max_len)
> +{
> +	FILE *f;
> +	int ret;
> +
> +	f = popen(command, "r");
> +	if (!f)
> +		return 1;
> +
> +	if (get_output)
> +		fread(output_buf, 1, output_max_len, f);
> +	ret = pclose(f);
> +
> +	return ret;
> +}
> +
> +int run_bpftool_command(char *args)
> +{
> +	char cmd[BPFTOOL_CMD_MAX_LEN];
> +	int ret;
> +
> +	ret = snprintf(cmd, BPFTOOL_CMD_MAX_LEN, "%s %s > /dev/null 2>&1",
> +		       env.bpftool_path, args);
> +	if (ret !=
> +	    strlen(env.bpftool_path) + 1 + strlen(args) + strlen(" > /dev/null 2>&1")) {
> +		fprintf(stderr, "Failed to generate bpftool command\n");
> +		return 1;
> +	}
> +
> +	return run_command(cmd, false, NULL, 0);
> +}
> +
> +int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_len)
> +{
> +	int ret;
> +	char cmd[BPFTOOL_CMD_MAX_LEN];
> +
> +	ret = snprintf(cmd, BPFTOOL_CMD_MAX_LEN, "%s %s", env.bpftool_path,
> +		       args);
> +	if (ret != strlen(args) + strlen(env.bpftool_path) + 1) {
> +		fprintf(stderr, "Failed to generate bpftool command");
> +		return 1;
> +	}
> +
> +	return run_command(cmd, true, output_buf, output_max_len);
> +}
> +
> +void hijack_stdio(void)
> +{
> +	fflush(stdout);
> +	fflush(stderr);
> +	if (env.current_subtest) {
> +		env.current_test->saved_stdout = stdout;
> +		env.current_test->saved_stderr = stderr;
> +		stdout = open_memstream(&env.current_subtest->log,
> +					&env.current_subtest->log_size);


Missing check on open_memstream() return value? Same below.


> +


Nit: blank line


> +	} else {
> +		env.saved_stdout = stdout;
> +		env.saved_stderr = stderr;
> +		stdout = open_memstream(&env.current_test->log,
> +					&env.current_test->log_size);
> +	}
> +	stderr = stdout;
> +}
> +
> +void restore_stdio(void)
> +{
> +	fclose(stdout);
> +	if (env.current_subtest) {
> +		stdout = env.current_test->saved_stdout;
> +		stderr = env.current_test->saved_stderr;
> +


Nit: blank line


> +	} else {
> +		stdout = env.saved_stdout;
> +		stderr = env.saved_stderr;
> +	}
> +


Nit: blank line again


> +}
> +
> +void test__start_subtest(const char *subtest_name)
> +{
> +	test__end_subtest();
> +	env.current_test->subtests_count++;
> +	env.subtest_states = realloc(env.subtest_states,
> +				     env.current_test->subtests_count *
> +					     sizeof(struct subtest_state));


Missing check on realloc()'s return value?


> +	env.current_subtest =
> +		&env.subtest_states[env.current_test->subtests_count - 1];
> +	memset(env.current_subtest, 0, sizeof(struct subtest_state));
> +	env.current_subtest->name = strdup(subtest_name);
> +
> +	hijack_stdio();
> +}
> +
> +void test__end_subtest(void)
> +{
> +	if (env.current_subtest) {
> +		restore_stdio();
> +		env.current_subtest = NULL;
> +	}
> +}
> +
> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.h b/tools/testing/selftests/bpf/bpftool_helpers.h
> new file mode 100644
> index 000000000000..1eacec7936ba
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#pragma once
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdbool.h>
> +
> +#define MAX_BPFTOOL_CMD_LEN	(256)
> +
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +#endif
> +
> +int run_bpftool_command(char *args);
> +int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_len);
> +void test__start_subtest(const char *subtests_name);
> +void test__end_subtest(void);
> +void hijack_stdio(void);
> +void restore_stdio(void);
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/.gitignore b/tools/testing/selftests/bpf/bpftool_tests/.gitignore
> new file mode 100644
> index 000000000000..89c4a3d37544
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +tests.h
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/bpftool_metadata.c b/tools/testing/selftests/bpf/bpftool_tests/bpftool_metadata.c
> new file mode 100644
> index 000000000000..e7146b26f298
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/bpftool_metadata.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <bpftool_helpers.h>
> +#include <test_bpftool.h>
> +#include <assert_helpers.h>
> +#include <linux/bpf.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include <stdbool.h>
> +
> +#define BPFFS_DIR	"/sys/fs/bpf/test_metadata"
> +#define BPFFS_USED	BPFFS_DIR "/used"
> +#define BPFFS_UNUSED	BPFFS_DIR "/unused"
> +
> +#define BPF_FILE_USED	"metadata_used.bpf.o"
> +#define BPF_FILE_UNUSED "metadata_unused.bpf.o"
> +
> +#define MAX_BPFTOOL_OUTPUT_LEN	(100*1000)


Maybe a power of 2 instead, 64k?


> +
> +#define MAX_TOKENS_TO_CHECK	3
> +static char output[MAX_BPFTOOL_OUTPUT_LEN];
> +
> +struct test_desc {
> +	char *name;
> +	char *bpf_prog;
> +	char *bpffs_path;
> +	char *expected_output[MAX_TOKENS_TO_CHECK];
> +	char *expected_output_json[MAX_TOKENS_TO_CHECK];
> +};
> +
> +static int setup(struct test_desc *test)
> +{
> +	return mkdir(BPFFS_DIR, 0700);
> +}
> +
> +static void cleanup(struct test_desc *test)
> +{
> +	unlink(test->bpffs_path);
> +	rmdir(BPFFS_DIR);
> +}
> +
> +static int check_metadata(char *buf, char * const *tokens, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count && tokens[i]; i++)
> +		if (!strstr(buf, tokens[i]))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +static void run_test(struct test_desc *test)
> +{
> +	int ret;
> +	char cmd[MAX_BPFTOOL_CMD_LEN];
> +
> +	snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "prog load %s %s",
> +			test->bpf_prog, test->bpffs_path);
> +	ret = run_bpftool_command(cmd);
> +	if (!ASSERT_OK(ret, "load program"))
> +		return;
> +
> +	/* Check output with default format */
> +	ret = get_bpftool_command_output("prog show name prog", output,


I'd probably use "pinned" + pinned path rather than "name prog",
especially because the name for the program does not otherwise appear in
this file (and same below).


> +			MAX_BPFTOOL_OUTPUT_LEN);
> +	if (ASSERT_OK(ret, "get program info")) {
> +		ret = check_metadata(output, test->expected_output,
> +				ARRAY_SIZE(test->expected_output));
> +		ASSERT_OK(ret, "find metadata");
> +	}
> +
> +	/* Check output with json format */
> +	ret = get_bpftool_command_output("prog -j show name prog", output,
> +					 MAX_BPFTOOL_OUTPUT_LEN);
> +	if (ASSERT_OK(ret, "get program info in json")) {
> +		ret = check_metadata(output, test->expected_output_json,
> +				ARRAY_SIZE(test->expected_output_json));
> +		ASSERT_OK(ret, "find metadata in json");
> +	}
> +


Nit: blank line


> +}
> +
> +struct test_desc tests[] = {
> +	{
> +		.name = "metadata_unused",
> +		.bpf_prog = BPF_FILE_UNUSED,
> +		.bpffs_path = BPFFS_UNUSED,
> +		.expected_output = {
> +			"a = \"foo\"",
> +			"b = 1"
> +		},
> +		.expected_output_json = {
> +			"\"metadata\":{\"a\":\"foo\",\"b\":1}"
> +		}
> +	},
> +	{
> +		.name = "metadata_used",
> +		.bpf_prog = BPF_FILE_USED,
> +		.bpffs_path = BPFFS_USED,
> +		.expected_output = {
> +			"a = \"bar\"",
> +			"b = 2"
> +		},
> +		.expected_output_json = {
> +			"\"metadata\":{\"a\":\"bar\",\"b\":2}"
> +		}
> +	}
> +};
> +
> +static const int tests_count = ARRAY_SIZE(tests);
> +
> +void test_metadata(void)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < tests_count; i++) {
> +		test__start_subtest(tests[i].name);
> +		ret = setup(&tests[i]);
> +		if (!ASSERT_OK(ret, "setup bpffs pin dir"))
> +			continue;
> +		run_test(&tests[i]);
> +		cleanup(&tests[i]);
> +	}
> +


Nit: blank line


> +}
> +
> diff --git a/tools/testing/selftests/bpf/test_bpftool.c b/tools/testing/selftests/bpf/test_bpftool.c
> new file mode 100644
> index 000000000000..b5fb17d5ea2d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_bpftool.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <test_bpftool.h>
> +#include <bpftool_helpers.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +struct bpftool_runner_env env = {0};
> +
> +#define DEFINE_TEST(name) extern void test_##name(void);
> +#include <bpftool_tests/tests.h>
> +#undef DEFINE_TEST
> +
> +struct prog_test_def {
> +	char *test_name;
> +	void (*run_test)(void);
> +};
> +
> +static struct prog_test_def prog_test_defs[] = {
> +#define DEFINE_TEST(name) {			\
> +	.test_name = #name,			\
> +	.run_test = &test_##name,		\
> +},
> +#include <bpftool_tests/tests.h>
> +#undef DEFINE_TEST
> +};
> +
> +
> +static const int tests_count = ARRAY_SIZE(prog_test_defs);
> +
> +/* Needed method for the assert macros exposed by assert_helpers.h */
> +void test__fail(void)
> +{
> +	if (env.current_subtest)
> +		env.current_subtest->failed = true;
> +	if (!env.current_test->failed)
> +		env.failure_cnt++;
> +	env.current_test->failed = true;
> +}
> +
> +static void test_setup(struct test_state *test, char *name)
> +{
> +	env.current_test = test;
> +	env.current_test->name = strdup(name);
> +}
> +
> +static void dump_results(struct test_state *test, int test_index)


Would you mind renaming this function? It also frees the logs and names
and subtests states. Maybe "dump_results_and_cleanup"? Or move the all
the clean-up to test_teardown(). Even if we loop again over the
subtests, the overhead should be minimal, and I'd find it easier to follow.


> +{
> +	int j;


Let's use "i" rather than "j"


> +
> +	if (test->failed)
> +		fprintf(stdout, "%s\n", test->log);
> +	free(test->log);
> +	for (j = 0; j < test->subtests_count; j++) {
> +		if (env.subtest_states[j].failed)
> +			fprintf(stdout, "%s\n", env.subtest_states[j].log);
> +		free(env.subtest_states[j].log);
> +		fprintf(stdout, "#%d/%d\t%s/%s: %s\n", test_index+1, j+1,
> +				env.current_test->name,
> +				env.subtest_states[j].name,
> +				env.subtest_states[j].failed ? "KO" : "OK");
> +		free(env.subtest_states[j].name);
> +	}
> +	if (env.current_test->subtests_count) {
> +		free(env.subtest_states);
> +		env.subtest_states = NULL;
> +	}
> +	fprintf(stdout, "#%d\t%s: %s\n", test_index + 1, test->name,
> +		test->failed ? "KO" : "OK");
> +}
> +
> +static void test_teardown(struct test_state *test, int test_index)
> +{
> +	dump_results(test, test_index);
> +	free(env.current_test->name);
> +	env.current_test = NULL;
> +}
> +
> +static int parse_args(int argc, char *argv[])
> +{
> +	if (argc != 2)
> +		return 1;
> +	if (access(argv[1], R_OK|X_OK))
> +		return 1;
> +	env.bpftool_path = argv[1];
> +
> +	return 0;
> +}
> +
> +static void usage(char *prog)
> +{
> +	fprintf(stdout, "Usage: %s <bpftool_path>\n", prog);
> +	fprintf(stdout, "\t<bpftool_path>: path to the bpftool binary to test\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct test_state *ctx = NULL;
> +	int i;
> +
> +	if (parse_args(argc, argv)) {
> +		fprintf(stderr, "Invalid arguments\n");
> +		usage(argv[0]);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	ctx = calloc(tests_count, sizeof(struct test_state));
> +	if (!ctx)
> +		exit(EXIT_FAILURE);
> +
> +	for (i = 0; i < tests_count; i++) {
> +		test_setup(&ctx[i], prog_test_defs[i].test_name);
> +		hijack_stdio();


Nit: Move hijack_stdio()/restore_stdio() to test_setup()/test_teardown()?


> +		prog_test_defs[i].run_test();
> +		test__end_subtest();
> +		restore_stdio();
> +		test_teardown(&ctx[i], i);
> +	}
> +
> +	fprintf(stdout, "Summary: %d PASSED, %d FAILED\n",
> +		tests_count - env.failure_cnt, env.failure_cnt);
> +	free(ctx);
> +	return env.failure_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
> +}
> diff --git a/tools/testing/selftests/bpf/test_bpftool.h b/tools/testing/selftests/bpf/test_bpftool.h
> new file mode 100644
> index 000000000000..a78659eeaf2b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_bpftool.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#pragma once
> +
> +#include <stdio.h>
> +#include <stdbool.h>
> +
> +extern struct bpftool_runner_env env;
> +
> +void test__fail(void);
> +
> +struct test_state {
> +	char *name;
> +	char *log;
> +	size_t log_size;
> +	bool failed;
> +	int subtests_count;
> +	int subtests_failures;
> +	FILE *saved_stdout;
> +	FILE *saved_stderr;
> +};
> +
> +struct subtest_state {
> +	char *name;
> +	char *log;
> +	size_t log_size;
> +	bool failed;
> +};
> +struct bpftool_runner_env {
> +	char *bpftool_path;
> +	int failure_cnt;
> +	FILE *saved_stdout;
> +	FILE *saved_stderr;
> +	struct test_state *current_test;
> +	struct subtest_state *current_subtest;
> +	struct subtest_state *subtest_states;
> +};
> 


