Return-Path: <linux-kselftest+bounces-14377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C559893F103
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469341F21E89
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084C13FD8C;
	Mon, 29 Jul 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvFwHYWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6E13E41D;
	Mon, 29 Jul 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245130; cv=none; b=G2EAjic4OkOOqhI4bJrR2vnMo3gFyJapuG3nT+FmJcBIJAZqiQQAdHlcz2ZH26jfHTqumgj1ceG5KxKdf+YpjrugZk6fS2EL7/JIdDxZqayADYQmc40Rcef1bW5d5JIUmKPNTXPIp+Zr+fs536qItfKQKlkENJGtTBB7CvXJEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245130; c=relaxed/simple;
	bh=a4rVH09KS5AcB6gKjH/TsV/iGRHYsyJRdLeEhzYEkRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+o1oacNSJ6bL48wWf6ROpgiUr0/utW7F+yBTqhVIOWtXDRn4q0x/x2uIOzmawfxxPJftNJygpoasW1ln19HVmnh8j7chrG3/HoIiHQ0LqiIkGgQedzlhtCiP4DoSZwB6/ZrrQsz914aF+bblOAJO0rRht5hZG6XLAi/GyyxC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvFwHYWc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd78c165eeso23991345ad.2;
        Mon, 29 Jul 2024 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245128; x=1722849928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5OcL9wh7BbULCDEEEFB1/1k389rERhjFZGL7w2BMEU=;
        b=fvFwHYWc3tY+ilChcl4GUvGCWOnhGelHjUBnmc8tdx6j05xZdvWPBDYKvP9bi6YnNK
         AsQrqiA3zppNAbi8zRSQfmhZHwpBABodts0yxpDiHcgC0SNXsqxMc/PkfrNsnmfS6GRf
         Zl0VhFGzONZ2wSZK73qJru7S7iGd1SJagG3IdK6R+clPdtNUuPakigLmXmeukDIFZfXo
         FohoixA7R3Rkd63ex6E1PtqTVvUEeF5EkEa7DHDetUQmBKxMd9sASZ4iEC3cFvSNflDU
         uxjHHZ9f1UTkNpiERwNJfnBRpBVQtuIDSAPjHV4Z1m+1GDq5GkFKfRbk/61pw2aY/ULy
         Pplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245128; x=1722849928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5OcL9wh7BbULCDEEEFB1/1k389rERhjFZGL7w2BMEU=;
        b=G0R1TPzkYJzAUXdTylEScWss5ZHl+kVAyRKMR9hlLGa5or1+bsMJQmAfZRR/rk7Plw
         ba36DWYKycI/xK3o5G6Hg4f4+CWlkCIDULflU4BMkyGegpY0um7CTIAuurQVcTinBigS
         ZaYQ2e9Wu7jDWUpMIk6Mr55QqnfxDR7sWmstiLdZxWvkzftcEW5N2Wk95oWCY2OOHeTl
         E2se0MsOXqSrOMvp0inWrQw8BoiF5uljxcUBI9x0LLGgfdBgjN3hlWtMndLcFAhwSzC6
         5DoDcO8KGGG1s1nTYOLXK1jkdEaFL/G4hjAif7U+7RPzCje/xYHXTZn6WyY++1uI9uPQ
         nEnw==
X-Forwarded-Encrypted: i=1; AJvYcCUFs2qgi2d/n9fX1jT6bI2i9jr4qIcr/yl2/BxIcVhCRQF89+fsVrNewjdG/88tVzeqOb1st61xTMMT0LA+WxZfzrVON3a0WAKfb7xPtvGLD8nDI9WHVLemRNE3pTZutPYKdSoYxWqP
X-Gm-Message-State: AOJu0Yz2nZuRrG1+iOuQSCLUJK/T7yFHhLh6bhhTnXPIPktDfZiFvn+L
	SErcCmP0eXlQ+LGIzeVTqI28/bBqZDCIHDbPe0GnmeroJD6u2xdHncoSP4BF
X-Google-Smtp-Source: AGHT+IFA/f/KYUIVsqZx7eEo2TXW49TP3+d4xeQX9e3B0VckaNJ3Z1UHQypEhgCVuehYY//K5HAhQA==
X-Received: by 2002:a17:902:da92:b0:1fc:5820:8940 with SMTP id d9443c01a7336-1ff0481138fmr89707995ad.20.1722245127985;
        Mon, 29 Jul 2024 02:25:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:25:27 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
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
Subject: [PATCH bpf-next v2 7/8] selftests/bpf: Fix using stdout, stderr as struct field names
Date: Mon, 29 Jul 2024 02:24:23 -0700
Message-Id: <684ea17548e237f39dfb3f7a3d33450069015b21.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722244708.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com> <cover.1722244708.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typically stdin, stdout, stderr are treated as reserved identifiers under
ISO/ANSI C and libc implementations further define these as macros, both in
glibc and musl <stdio.h>.

However, while glibc defines:
    ...
    /* Standard streams.  */
    extern FILE *stdin;             /* Standard input stream.  */
    extern FILE *stdout;            /* Standard output stream.  */
    extern FILE *stderr;            /* Standard error output stream.  */
    /* C89/C99 say they're macros.  Make them happy.  */
    #define stdin stdin
    #define stdout stdout
    #define stderr stderr
    ...

musl instead uses (legally):
    ...
    extern FILE *const stdin;
    extern FILE *const stdout;
    extern FILE *const stderr;

    #define stdin  (stdin)
    #define stdout (stdout)
    #define stderr (stderr)
    ...

The latter results in compile errors when the names are reused as fields of
'struct test_env' and elsewhere in test_progs.[ch] and reg_bounds.c.

Rename the fields to stdout_saved and stderr_saved to avoid many errors
seen building against musl, e.g.:

  In file included from test_progs.h:6,
                   from test_progs.c:5:
  test_progs.c: In function 'print_test_result':
  test_progs.c:237:21: error: expected identifier before '(' token
    237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
        |                     ^~~~~~
  test_progs.c:237:9: error: too few arguments to function 'fprintf'
    237 |         fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
        |         ^~~~~~~

Link: https://lore.kernel.org/bpf/ZqR2DuHdBXPX%2Fyx8@kodidev-ubuntu/
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
 tools/testing/selftests/bpf/test_progs.c      | 66 +++++++++----------
 tools/testing/selftests/bpf/test_progs.h      |  8 +--
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 0da4225749bd..467027236d30 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1487,7 +1487,7 @@ static int verify_case_opt(struct ctx *ctx, enum num_t init_t, enum num_t cond_t
 			u64 elapsed_ns = get_time_ns() - ctx->start_ns;
 			double remain_ns = elapsed_ns / progress * (1 - progress);
 
-			fprintf(env.stderr, "PROGRESS (%s): %d/%d (%.2lf%%), "
+			fprintf(env.stderr_saved, "PROGRESS (%s): %d/%d (%.2lf%%), "
 					    "elapsed %llu mins (%.2lf hrs), "
 					    "ETA %.0lf mins (%.2lf hrs)\n",
 				ctx->progress_ctx,
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index d5d0cb4eb197..60fafa2f1ed7 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -51,15 +51,15 @@ static void stdio_hijack_init(char **log_buf, size_t *log_cnt)
 
 	stdout = open_memstream(log_buf, log_cnt);
 	if (!stdout) {
-		stdout = env.stdout;
+		stdout = env.stdout_saved;
 		perror("open_memstream");
 		return;
 	}
 
 	if (env.subtest_state)
-		env.subtest_state->stdout = stdout;
+		env.subtest_state->stdout_saved = stdout;
 	else
-		env.test_state->stdout = stdout;
+		env.test_state->stdout_saved = stdout;
 
 	stderr = stdout;
 #endif
@@ -73,8 +73,8 @@ static void stdio_hijack(char **log_buf, size_t *log_cnt)
 		return;
 	}
 
-	env.stdout = stdout;
-	env.stderr = stderr;
+	env.stdout_saved = stdout;
+	env.stderr_saved = stderr;
 
 	stdio_hijack_init(log_buf, log_cnt);
 #endif
@@ -91,13 +91,13 @@ static void stdio_restore_cleanup(void)
 	fflush(stdout);
 
 	if (env.subtest_state) {
-		fclose(env.subtest_state->stdout);
-		env.subtest_state->stdout = NULL;
-		stdout = env.test_state->stdout;
-		stderr = env.test_state->stdout;
+		fclose(env.subtest_state->stdout_saved);
+		env.subtest_state->stdout_saved = NULL;
+		stdout = env.test_state->stdout_saved;
+		stderr = env.test_state->stdout_saved;
 	} else {
-		fclose(env.test_state->stdout);
-		env.test_state->stdout = NULL;
+		fclose(env.test_state->stdout_saved);
+		env.test_state->stdout_saved = NULL;
 	}
 #endif
 }
@@ -110,13 +110,13 @@ static void stdio_restore(void)
 		return;
 	}
 
-	if (stdout == env.stdout)
+	if (stdout == env.stdout_saved)
 		return;
 
 	stdio_restore_cleanup();
 
-	stdout = env.stdout;
-	stderr = env.stderr;
+	stdout = env.stdout_saved;
+	stderr = env.stderr_saved;
 #endif
 }
 
@@ -244,25 +244,25 @@ static void print_test_result(const struct prog_test_def *test, const struct tes
 	int skipped_cnt = test_state->skip_cnt;
 	int subtests_cnt = test_state->subtest_num;
 
-	fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
+	fprintf(env.stdout_saved, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
 	if (test_state->error_cnt)
-		fprintf(env.stdout, "FAIL");
+		fprintf(env.stdout_saved, "FAIL");
 	else if (!skipped_cnt)
-		fprintf(env.stdout, "OK");
+		fprintf(env.stdout_saved, "OK");
 	else if (skipped_cnt == subtests_cnt || !subtests_cnt)
-		fprintf(env.stdout, "SKIP");
+		fprintf(env.stdout_saved, "SKIP");
 	else
-		fprintf(env.stdout, "OK (SKIP: %d/%d)", skipped_cnt, subtests_cnt);
+		fprintf(env.stdout_saved, "OK (SKIP: %d/%d)", skipped_cnt, subtests_cnt);
 
-	fprintf(env.stdout, "\n");
+	fprintf(env.stdout_saved, "\n");
 }
 
 static void print_test_log(char *log_buf, size_t log_cnt)
 {
 	log_buf[log_cnt] = '\0';
-	fprintf(env.stdout, "%s", log_buf);
+	fprintf(env.stdout_saved, "%s", log_buf);
 	if (log_buf[log_cnt - 1] != '\n')
-		fprintf(env.stdout, "\n");
+		fprintf(env.stdout_saved, "\n");
 }
 
 static void print_subtest_name(int test_num, int subtest_num,
@@ -273,14 +273,14 @@ static void print_subtest_name(int test_num, int subtest_num,
 
 	snprintf(test_num_str, sizeof(test_num_str), "%d/%d", test_num, subtest_num);
 
-	fprintf(env.stdout, "#%-*s %s/%s",
+	fprintf(env.stdout_saved, "#%-*s %s/%s",
 		TEST_NUM_WIDTH, test_num_str,
 		test_name, subtest_name);
 
 	if (result)
-		fprintf(env.stdout, ":%s", result);
+		fprintf(env.stdout_saved, ":%s", result);
 
-	fprintf(env.stdout, "\n");
+	fprintf(env.stdout_saved, "\n");
 }
 
 static void jsonw_write_log_message(json_writer_t *w, char *log_buf, size_t log_cnt)
@@ -465,7 +465,7 @@ bool test__start_subtest(const char *subtest_name)
 	memset(subtest_state, 0, sub_state_size);
 
 	if (!subtest_name || !subtest_name[0]) {
-		fprintf(env.stderr,
+		fprintf(env.stderr_saved,
 			"Subtest #%d didn't provide sub-test name!\n",
 			state->subtest_num);
 		return false;
@@ -473,7 +473,7 @@ bool test__start_subtest(const char *subtest_name)
 
 	subtest_state->name = strdup(subtest_name);
 	if (!subtest_state->name) {
-		fprintf(env.stderr,
+		fprintf(env.stderr_saved,
 			"Subtest #%d: failed to copy subtest name!\n",
 			state->subtest_num);
 		return false;
@@ -1043,7 +1043,7 @@ void crash_handler(int signum)
 
 	sz = backtrace(bt, ARRAY_SIZE(bt));
 
-	if (env.stdout)
+	if (env.stdout_saved)
 		stdio_restore();
 	if (env.test) {
 		env.test_state->error_cnt++;
@@ -1359,7 +1359,7 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 	if (env->json) {
 		w = jsonw_new(env->json);
 		if (!w)
-			fprintf(env->stderr, "Failed to create new JSON stream.");
+			fprintf(env->stderr_saved, "Failed to create new JSON stream.");
 	}
 
 	if (w) {
@@ -1708,8 +1708,8 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	env.stdout = stdout;
-	env.stderr = stderr;
+	env.stdout_saved = stdout;
+	env.stderr_saved = stderr;
 
 	env.has_testmod = true;
 	if (!env.list_test_names) {
@@ -1717,7 +1717,7 @@ int main(int argc, char **argv)
 		unload_bpf_testmod(verbose());
 
 		if (load_bpf_testmod(verbose())) {
-			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
+			fprintf(env.stderr_saved, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
 			env.has_testmod = false;
 		}
 	}
@@ -1795,7 +1795,7 @@ int main(int argc, char **argv)
 		}
 
 		if (env.list_test_names) {
-			fprintf(env.stdout, "%s\n", test->test_name);
+			fprintf(env.stdout_saved, "%s\n", test->test_name);
 			env.succ_cnt++;
 			continue;
 		}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index b1e949fb16cf..cb9d6d46826b 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -75,7 +75,7 @@ struct subtest_state {
 	bool skipped;
 	bool filtered;
 
-	FILE *stdout;
+	FILE *stdout_saved;
 };
 
 struct test_state {
@@ -92,7 +92,7 @@ struct test_state {
 	size_t log_cnt;
 	char *log_buf;
 
-	FILE *stdout;
+	FILE *stdout_saved;
 };
 
 struct test_env {
@@ -111,8 +111,8 @@ struct test_env {
 	struct test_state *test_state; /* current running test state */
 	struct subtest_state *subtest_state; /* current running subtest state */
 
-	FILE *stdout;
-	FILE *stderr;
+	FILE *stdout_saved;
+	FILE *stderr_saved;
 	int nr_cpus;
 	FILE *json;
 
-- 
2.34.1


