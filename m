Return-Path: <linux-kselftest+bounces-14222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7FE93C01C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D181F211B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DFB1990CC;
	Thu, 25 Jul 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1dESBVT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F71990A7;
	Thu, 25 Jul 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903978; cv=none; b=QjioE/mOOk7RSWT0Al0J1Yc5DKf6Hyu8Xe7Y57RJy1Y1mOMYDvFW1s9mgrvr90zw4PhVGqhxxb+0wJhP1+ae6MvWOO3jzpPqCx6QlcYpOmp8uBsXoydnnBGwslLy83O+xUXxSdsfLKT/Om9wzDwBC/jzU6HAtOLtq+5oVopvul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903978; c=relaxed/simple;
	bh=GZ5RRY21h24jL/MH55jDljpE7BmhCJG7SyVeynN+I+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcpziIAAnrNsLMh9/0+/o6pYo8DOemGcw7ztrSwwZ95tco9aT9NNKlxpQzMPAGsWYqaqcNdNvuIPEktkq6h9oPh8t/RS4UyUr8r3RH1htFf7LVHUnq+aehW3GEqh0MYQAydizGN/xQ8L8+6DOeB0lQcGiBmytNzD7GchH287R9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1dESBVT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd78c165eeso6672315ad.2;
        Thu, 25 Jul 2024 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903976; x=1722508776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ccqQjN7NhIQMSexCsKHuErOhtfNopH+5UHx/am59M=;
        b=f1dESBVTL0SWUn9fswlnmuylzLK2ozlFh+jebnsK1Nf+wKx8LqHF3zVrFClgoYNZLn
         YuAYRVAgcbzNYF5cdrfzXjlrYBqLx8tJvti9i8MwXI1vbHDdW7erDMOfaqP4qLkofC0Q
         CuDhpL/8T0u5iwW79dcoY6ya2PvdlNzMXnuqH2tqM4/Fbp3bH6SVtT0PJTmQCkPrDz4F
         nVflU0NjHMqs+UjGAn7Z9k0XjCueWSRVNi9ZtTwnquL2r+1ZbJ1GEL95TzlUzIsCZUPU
         FiPtxpBRl3CzUu0soq1JeiSOfwr/PmLQuFJLVvIAOovSBLxVddaQ6T3P7zqdJbwkabYF
         W6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903976; x=1722508776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4ccqQjN7NhIQMSexCsKHuErOhtfNopH+5UHx/am59M=;
        b=peS2b5JlGT14u4QpowWuABHnERUKZnO1Z8zEy1/1Kg9E3r5HxkmtF6AU9fDvCwoOct
         ib+5+TpWMm9pHUnhJRfk3AnbZGu1yLZLza9IbxPfH+8xEeEmlYjH/NQwHaSgiheEBZWm
         yCR7bdTik/+SGj3atTl/lzopFkXVPUojOS4JxKq+Dm2IYVoKG38hJUe9DI1f32pZaaxD
         Licn1mtXNTkhv+G+iAYy5lpem2GCDc7o95sAqeew6aztYG7SoAUkFJw706q7nN+fKzI4
         tbppdmkfoRdJIwxYZQ8nHN4s9FqiH72hhNHfjiaTR1YzaPylIbRjw5UDwB0RtzI+NKOw
         Ueag==
X-Forwarded-Encrypted: i=1; AJvYcCUwYWazY43p2cOUNz5sO6jamWi8UlJ+L2+kxLHWeufbvhPvEnNwvAIN2p2f1AIXalmKAHEyndFBnkSL4U34U5Y5hCj5AVWpOh5F5cLOa2E7shQ7yhjOYkXlR69PBKQQ3lVkYG4Tzgzh
X-Gm-Message-State: AOJu0YyXEs6pz85cyU6wJpJb5J5P/GVVLtoa3fq9AmfBgaxF9JgYlDsI
	mWIRhoi3ssZ8zBZrjJ63n12MgaeW1DU89kMduscDKlwseVMoz2u42jvkLO0g
X-Google-Smtp-Source: AGHT+IHlJ6dcJBHqoftYkUAqPskxOGx1GUaYoF3yx4XSuHLU/eCcWaGWQJAko0Oi9DsIMm2rcE81cw==
X-Received: by 2002:a17:902:e84f:b0:1fd:8c25:4145 with SMTP id d9443c01a7336-1fed91d95acmr18470625ad.17.1721903975722;
        Thu, 25 Jul 2024 03:39:35 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:35 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v1 7/8] selftests/bpf: Fix using stdout, stderr as struct field names
Date: Thu, 25 Jul 2024 03:35:59 -0700
Message-Id: <847a5b798f24e81b9dec4e8d9eb3eb1e602a909e.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Typically stdin, stdout, stderr are treated as reserved identifiers under
ISO/ANSI C, and a libc implementation is free to define these as macros.
This is the case in musl libc and results in compile errors when these
names are reused as struct fields, as with 'struct test_env' and related
usage in test_progs.[ch] and reg_bounds.c.

Rename the fields to _stdout and _stderr to avoid many errors seen building
against musl, e.g.:

  In file included from test_progs.h:6,
                   from test_progs.c:5:
  test_progs.c: In function 'print_test_result':
  test_progs.c:237:21: error: expected identifier before '(' token
    237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
        |                     ^~~~~~
  test_progs.c:237:9: error: too few arguments to function 'fprintf'
    237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
        |         ^~~~~~~

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
 tools/testing/selftests/bpf/test_progs.c      | 66 +++++++++----------
 tools/testing/selftests/bpf/test_progs.h      |  8 +--
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 0da4225749bd..ff4ebc9eaf3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1487,7 +1487,7 @@ static int verify_case_opt(struct ctx *ctx, enum num_t init_t, enum num_t cond_t
 			u64 elapsed_ns = get_time_ns() - ctx->start_ns;
 			double remain_ns = elapsed_ns / progress * (1 - progress);
 
-			fprintf(env.stderr, "PROGRESS (%s): %d/%d (%.2lf%%), "
+			fprintf(env._stderr, "PROGRESS (%s): %d/%d (%.2lf%%), "
 					    "elapsed %llu mins (%.2lf hrs), "
 					    "ETA %.0lf mins (%.2lf hrs)\n",
 				ctx->progress_ctx,
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index f6cfc6a8e8f0..091b49bf671a 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -44,15 +44,15 @@ static void stdio_hijack_init(char **log_buf, size_t *log_cnt)
 
 	stdout = open_memstream(log_buf, log_cnt);
 	if (!stdout) {
-		stdout = env.stdout;
+		stdout = env._stdout;
 		perror("open_memstream");
 		return;
 	}
 
 	if (env.subtest_state)
-		env.subtest_state->stdout = stdout;
+		env.subtest_state->_stdout = stdout;
 	else
-		env.test_state->stdout = stdout;
+		env.test_state->_stdout = stdout;
 
 	stderr = stdout;
 #endif
@@ -66,8 +66,8 @@ static void stdio_hijack(char **log_buf, size_t *log_cnt)
 		return;
 	}
 
-	env.stdout = stdout;
-	env.stderr = stderr;
+	env._stdout = stdout;
+	env._stderr = stderr;
 
 	stdio_hijack_init(log_buf, log_cnt);
 #endif
@@ -84,13 +84,13 @@ static void stdio_restore_cleanup(void)
 	fflush(stdout);
 
 	if (env.subtest_state) {
-		fclose(env.subtest_state->stdout);
-		env.subtest_state->stdout = NULL;
-		stdout = env.test_state->stdout;
-		stderr = env.test_state->stdout;
+		fclose(env.subtest_state->_stdout);
+		env.subtest_state->_stdout = NULL;
+		stdout = env.test_state->_stdout;
+		stderr = env.test_state->_stdout;
 	} else {
-		fclose(env.test_state->stdout);
-		env.test_state->stdout = NULL;
+		fclose(env.test_state->_stdout);
+		env.test_state->_stdout = NULL;
 	}
 #endif
 }
@@ -103,13 +103,13 @@ static void stdio_restore(void)
 		return;
 	}
 
-	if (stdout == env.stdout)
+	if (stdout == env._stdout)
 		return;
 
 	stdio_restore_cleanup();
 
-	stdout = env.stdout;
-	stderr = env.stderr;
+	stdout = env._stdout;
+	stderr = env._stderr;
 #endif
 }
 
@@ -237,25 +237,25 @@ static void print_test_result(const struct prog_test_def *test, const struct tes
 	int skipped_cnt = test_state->skip_cnt;
 	int subtests_cnt = test_state->subtest_num;
 
-	fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
+	fprintf(env._stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
 	if (test_state->error_cnt)
-		fprintf(env.stdout, "FAIL");
+		fprintf(env._stdout, "FAIL");
 	else if (!skipped_cnt)
-		fprintf(env.stdout, "OK");
+		fprintf(env._stdout, "OK");
 	else if (skipped_cnt == subtests_cnt || !subtests_cnt)
-		fprintf(env.stdout, "SKIP");
+		fprintf(env._stdout, "SKIP");
 	else
-		fprintf(env.stdout, "OK (SKIP: %d/%d)", skipped_cnt, subtests_cnt);
+		fprintf(env._stdout, "OK (SKIP: %d/%d)", skipped_cnt, subtests_cnt);
 
-	fprintf(env.stdout, "\n");
+	fprintf(env._stdout, "\n");
 }
 
 static void print_test_log(char *log_buf, size_t log_cnt)
 {
 	log_buf[log_cnt] = '\0';
-	fprintf(env.stdout, "%s", log_buf);
+	fprintf(env._stdout, "%s", log_buf);
 	if (log_buf[log_cnt - 1] != '\n')
-		fprintf(env.stdout, "\n");
+		fprintf(env._stdout, "\n");
 }
 
 static void print_subtest_name(int test_num, int subtest_num,
@@ -266,14 +266,14 @@ static void print_subtest_name(int test_num, int subtest_num,
 
 	snprintf(test_num_str, sizeof(test_num_str), "%d/%d", test_num, subtest_num);
 
-	fprintf(env.stdout, "#%-*s %s/%s",
+	fprintf(env._stdout, "#%-*s %s/%s",
 		TEST_NUM_WIDTH, test_num_str,
 		test_name, subtest_name);
 
 	if (result)
-		fprintf(env.stdout, ":%s", result);
+		fprintf(env._stdout, ":%s", result);
 
-	fprintf(env.stdout, "\n");
+	fprintf(env._stdout, "\n");
 }
 
 static void jsonw_write_log_message(json_writer_t *w, char *log_buf, size_t log_cnt)
@@ -458,7 +458,7 @@ bool test__start_subtest(const char *subtest_name)
 	memset(subtest_state, 0, sub_state_size);
 
 	if (!subtest_name || !subtest_name[0]) {
-		fprintf(env.stderr,
+		fprintf(env._stderr,
 			"Subtest #%d didn't provide sub-test name!\n",
 			state->subtest_num);
 		return false;
@@ -466,7 +466,7 @@ bool test__start_subtest(const char *subtest_name)
 
 	subtest_state->name = strdup(subtest_name);
 	if (!subtest_state->name) {
-		fprintf(env.stderr,
+		fprintf(env._stderr,
 			"Subtest #%d: failed to copy subtest name!\n",
 			state->subtest_num);
 		return false;
@@ -1036,7 +1036,7 @@ void crash_handler(int signum)
 
 	sz = backtrace(bt, ARRAY_SIZE(bt));
 
-	if (env.stdout)
+	if (env._stdout)
 		stdio_restore();
 	if (env.test) {
 		env.test_state->error_cnt++;
@@ -1352,7 +1352,7 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 	if (env->json) {
 		w = jsonw_new(env->json);
 		if (!w)
-			fprintf(env->stderr, "Failed to create new JSON stream.");
+			fprintf(env->_stderr, "Failed to create new JSON stream.");
 	}
 
 	if (w) {
@@ -1701,8 +1701,8 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	env.stdout = stdout;
-	env.stderr = stderr;
+	env._stdout = stdout;
+	env._stderr = stderr;
 
 	env.has_testmod = true;
 	if (!env.list_test_names) {
@@ -1710,7 +1710,7 @@ int main(int argc, char **argv)
 		unload_bpf_testmod(verbose());
 
 		if (load_bpf_testmod(verbose())) {
-			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
+			fprintf(env._stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
 			env.has_testmod = false;
 		}
 	}
@@ -1788,7 +1788,7 @@ int main(int argc, char **argv)
 		}
 
 		if (env.list_test_names) {
-			fprintf(env.stdout, "%s\n", test->test_name);
+			fprintf(env._stdout, "%s\n", test->test_name);
 			env.succ_cnt++;
 			continue;
 		}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index b1e949fb16cf..f42f1ae59c6e 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -75,7 +75,7 @@ struct subtest_state {
 	bool skipped;
 	bool filtered;
 
-	FILE *stdout;
+	FILE *_stdout;
 };
 
 struct test_state {
@@ -92,7 +92,7 @@ struct test_state {
 	size_t log_cnt;
 	char *log_buf;
 
-	FILE *stdout;
+	FILE *_stdout;
 };
 
 struct test_env {
@@ -111,8 +111,8 @@ struct test_env {
 	struct test_state *test_state; /* current running test state */
 	struct subtest_state *subtest_state; /* current running subtest state */
 
-	FILE *stdout;
-	FILE *stderr;
+	FILE *_stdout;
+	FILE *_stderr;
 	int nr_cpus;
 	FILE *json;
 
-- 
2.34.1


