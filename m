Return-Path: <linux-kselftest+bounces-4674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FE855371
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 20:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D6DB2563F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCED13DB9D;
	Wed, 14 Feb 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TC4Vh5o2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677D13DB83
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940005; cv=none; b=ux9ssXYGBJ1TSo8XTalQa9Hxe/ZZf6G58yvrl6DM4yw0JjjcCUqbfilMTchQJwL6vz5jzPr0PWrMX/daxcRvxh5q7BtnLGL62q2qksqCUfiSlBfaLFoI3ePjPLIVXqJjqy10PLI7bQ30Ayncmleegi2eQsy42VZqTlJ3+N9r9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940005; c=relaxed/simple;
	bh=8JANgonbhxeKKW+uDQio029nIJhsiCtPP+8BxgNgaqA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=YBNnXhIrhroy/4U+/UB1Osq7jjrZFXy3Gq6Mk1uVlTjBdCAFHm/hYNRzVdzQduvfv031o77fVv3/rU7mD4MrCcZwbkbU5LCynVYnY1HnJxxyJCtQcXQ1ANA8ajlSeJ3y5A3xUPX+u1OHd0thv7HKVZCkgskM+Y6oW/NrVxVnwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TC4Vh5o2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51182ece518so58236e87.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707940001; x=1708544801; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=winRWyZ6BCVdhQy1fH4iOgSBQ13zKw7iL7yywIIe8RM=;
        b=TC4Vh5o2ipdYYhiVIo0VFwbMCkrojjOgHEGWOyV5k2xl9uFraXrY6yRKkXyFHJduGA
         seHjJelGx+0NJ1D0rH91Rs65BLALU8OBHEeyZs8oTDCgLre1vemJZunECl8qN+3WCFO7
         KMPgs7yZ9gVw+OFYp1PHDNhACHTo5k4aMMs/Viuxb/kkGfkfvAgK3bNJiFaHMsqg6FtI
         3Wt6izpSMxC2IvYDWQf9ynrKvg6aH7WMQGvKBkP0pUUifvWE3kKI12r1LiYR7RbvkuYO
         UrCm/msYLXSBE2IUhIqGFRKRaAspBHmh+/pTx3+Qmif+puYmoy/bIPFY1m24utgw1mwk
         Esjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707940001; x=1708544801;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=winRWyZ6BCVdhQy1fH4iOgSBQ13zKw7iL7yywIIe8RM=;
        b=NSuaoOwwRvpDxG2Vs9zQnYfWTRXSfUEixBH59Wa8b3QnJurVSw4JCY8OysMGKKtx8C
         bl7yArYAlluOvHbiaL5tAf+xnVNr1SJ3ydhpS8qC7WeJFXOcQTTQfTrwr3wFyxGW9vRo
         hEGYfqOs06BUuvwv8dr6N5IqGjA2Ad35a6FqA5sxR5BVTdnkRBUkBQtof3DUOzCDqi2R
         4e9MyvxtTaQCtpQAt5PURcXXpjN4n6M/AXwOc6L7W1OoPMkgVkxATsIzddLV4hVfpXUh
         64HdrIkC/xXekIGuMxEUUFQtkopDb/+761Zm1RXDkEAW9kHh2/s6Y8fuhXEeLzyaAmMW
         fBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWg6OxXRHm61jajzkaauw8W7hGRlvk85/wPNdi9gtrkniRELDl5xtH7x/0Dtz0aBj0jJMWAXhWf1S0JaUISDu9DKrccHAfJtQKqSmWY4Va
X-Gm-Message-State: AOJu0YwcFb9prbz+AEzutW/L4bWIKx1T56RnjbJT1fTLK3wxvmyQWE+c
	Rg6JScZvhh2A6nJPKBux8q8ccNO8sRlwQ8an/rGXz7nqkV1YAwqJkCacvXO1Gp4=
X-Google-Smtp-Source: AGHT+IGWermj9iVugSzWhtIFX8NBulc1XSNjHnrLZ7WhZ7HXabcKCDnvgoLRTVngyqH/61APFx2j5w==
X-Received: by 2002:ac2:4a9a:0:b0:511:850b:3665 with SMTP id l26-20020ac24a9a000000b00511850b3665mr2289521lfp.64.1707940001157;
        Wed, 14 Feb 2024 11:46:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoQpOe4pUjNikhk9lzdssveN4E5ukf1phZAwk7gzSwX3oNszJej4o+tpxLn4S4Uh3qs0yHNxeivHgLFAHvHVYtYL2cOyW3CVRdSasaiRFuskvr3IXoiW0K2M/pvnT/2jBZiaB7E363CHlqRMKXsc/MsvBl/sYSqnX2Gj2R4GQ=
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1f2])
        by smtp.gmail.com with ESMTPSA id vv3-20020a170907a68300b00a3d29f0afeasm1266079ejc.2.2024.02.14.11.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:46:40 -0800 (PST)
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-4-kuba@kernel.org>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, keescook@chromium.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests: kselftest_harness: support
 using xfail
Date: Wed, 14 Feb 2024 20:40:59 +0100
In-reply-to: <20240213154416.422739-4-kuba@kernel.org>
Message-ID: <87o7ciltgh.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 13, 2024 at 07:44 AM -08, Jakub Kicinski wrote:
> Selftest summary includes XFAIL but there's no way to use
> it from within the harness. Support it in a similar way to skip.
>
> Currently tests report skip for things they expect to fail
> e.g. when given combination of parameters is known to be unsupported.
> This is confusing because in an ideal environment and fully featured
> kernel no tests should be skipped.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 618b41eac749..561a817117f9 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -141,6 +141,33 @@
>  	statement; \
>  } while (0)
>  
> +/**
> + * XFAIL()
> + *
> + * @statement: statement to run after reporting XFAIL
> + * @fmt: format string
> + * @...: optional arguments
> + *
> + * .. code-block:: c
> + *
> + *     XFAIL(statement, fmt, ...);
> + *
> + * This forces a "pass" after reporting why something is expected to fail,
> + * and runs "statement", which is usually "return" or "goto skip".
> + */
> +#define XFAIL(statement, fmt, ...) do { \
> +	snprintf(_metadata->results->reason, \
> +		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
> +	if (TH_LOG_ENABLED) { \
> +		fprintf(TH_LOG_STREAM, "#      XFAIL      %s\n", \
> +			_metadata->results->reason); \
> +	} \
> +	_metadata->passed = 1; \
> +	_metadata->xfail = 1; \
> +	_metadata->trigger = 0; \
> +	statement; \
> +} while (0)
> +
>  /**
>   * TEST() - Defines the test function and creates the registration
>   * stub
> @@ -834,6 +861,7 @@ struct __test_metadata {
>  	int termsig;
>  	int passed;
>  	int skip;	/* did SKIP get used? */
> +	int xfail;	/* did XFAIL get used? */
>  	int trigger; /* extra handler after the evaluation */
>  	int timeout;	/* seconds to wait for test timeout */
>  	bool timed_out;	/* did this test timeout instead of exiting? */
> @@ -941,6 +969,9 @@ void __wait_for_test(struct __test_metadata *t)
>  			/* SKIP */
>  			t->passed = 1;
>  			t->skip = 1;
> +		} else if (WEXITSTATUS(status) == KSFT_XFAIL) {
> +			t->passed = 1;
> +			t->xfail = 1;
>  		} else if (t->termsig != -1) {
>  			t->passed = 0;
>  			fprintf(TH_LOG_STREAM,
> @@ -1112,6 +1143,7 @@ void __run_test(struct __fixture_metadata *f,
>  	/* reset test struct */
>  	t->passed = 1;
>  	t->skip = 0;
> +	t->xfail = 0;
>  	t->trigger = 0;
>  	t->no_print = 0;
>  	memset(t->results->reason, 0, sizeof(t->results->reason));
> @@ -1133,6 +1165,8 @@ void __run_test(struct __fixture_metadata *f,
>  		t->fn(t, variant);
>  		if (t->skip)
>  			_exit(KSFT_SKIP);
> +		if (t->xfail)
> +			_exit(KSFT_XFAIL);
>  		if (t->passed)
>  			_exit(KSFT_PASS);
>  		/* Something else happened. */
> @@ -1146,6 +1180,9 @@ void __run_test(struct __fixture_metadata *f,
>  	if (t->skip)
>  		ksft_test_result_skip("%s\n", t->results->reason[0] ?
>  					t->results->reason : "unknown");
> +	else if (t->xfail)
> +		ksft_test_result_xfail("%s\n", t->results->reason[0] ?
> +				       t->results->reason : "unknown");
>  	else
>  		ksft_test_result(t->passed, "%s%s%s.%s\n",
>  			f->name, variant->name[0] ? "." : "", variant->name, t->name);

On second thought, if I can suggest a follow up change so this:

ok 17 # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT

... becomes this

ok 17 ip_local_port_range.ip4_stcp.late_bind # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT

You see, we parse test results if they are in TAP format. Lack of test
name for xfail'ed and skip'ed tests makes it difficult to report in CI
which subtest was it. Happy to contribute it, once this series gets
applied.

A quick 'n dirty change could look like below. Open to better ideas.

---8<---

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index a781e6311810..b73985df9cb9 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -211,7 +211,8 @@ static inline __printf(1, 2) void ksft_test_result_fail(const char *msg, ...)
 		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
 	} while (0)
 
-static inline __printf(1, 2) void ksft_test_result_xfail(const char *msg, ...)
+static inline __printf(2, 3) void ksft_test_result_xfail(const char *test_name,
+							 const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -219,7 +220,7 @@ static inline __printf(1, 2) void ksft_test_result_xfail(const char *msg, ...)
 	ksft_cnt.ksft_xfail++;
 
 	va_start(args, msg);
-	printf("ok %u # XFAIL ", ksft_test_num());
+	printf("ok %u %s # XFAIL ", ksft_test_num(), test_name);
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 561a817117f9..2db647f98abc 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,7 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -1140,6 +1141,8 @@ void __run_test(struct __fixture_metadata *f,
 		struct __fixture_variant_metadata *variant,
 		struct __test_metadata *t)
 {
+	char test_name[LINE_MAX];
+
 	/* reset test struct */
 	t->passed = 1;
 	t->skip = 0;
@@ -1149,8 +1152,9 @@ void __run_test(struct __fixture_metadata *f,
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 	t->results->step = 1;
 
-	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",
+		 f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	ksft_print_msg(" RUN           %s ...\n", test_name);
 
 	/* Make sure output buffers are flushed before fork */
 	fflush(stdout);
@@ -1174,18 +1178,16 @@ void __run_test(struct __fixture_metadata *f,
 	} else {
 		__wait_for_test(t);
 	}
-	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	ksft_print_msg("         %4s  %s\n", t->passed ? "OK" : "FAIL", test_name);
 
 	if (t->skip)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
 					t->results->reason : "unknown");
 	else if (t->xfail)
-		ksft_test_result_xfail("%s\n", t->results->reason[0] ?
+		ksft_test_result_xfail(test_name, "%s\n", t->results->reason[0] ?
 				       t->results->reason : "unknown");
 	else
-		ksft_test_result(t->passed, "%s%s%s.%s\n",
-			f->name, variant->name[0] ? "." : "", variant->name, t->name);
+		ksft_test_result(t->passed, "%s\n", test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 2f8b991f78cb..0abab3b32c88 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -575,8 +575,7 @@ static void run_mremap_test_case(struct test test_case, int *failures,
 
 	if (remap_time < 0) {
 		if (test_case.expect_failure)
-			ksft_test_result_xfail("%s\n\tExpected mremap failure\n",
-					      test_case.name);
+			ksft_test_result_xfail(test_case.name, "\n\tExpected mremap failure\n");
 		else {
 			ksft_test_result_fail("%s\n", test_case.name);
 			*failures += 1;
diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index 24e62120b792..928f067513da 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -123,8 +123,8 @@ static void try_delete_key(char *tst_name, int sk, uint8_t sndid, uint8_t rcvid,
 		return;
 	}
 	if (err && fault(FIXME)) {
-		test_xfail("%s: failed to delete the key %u:%u %d",
-			   tst_name, sndid, rcvid, err);
+		test_xfail(tst_name, "failed to delete the key %u:%u %d",
+			   sndid, rcvid, err);
 		return;
 	}
 	if (!err) {
@@ -283,8 +283,7 @@ static void assert_no_current_rnext(const char *tst_msg, int sk)
 
 	errno = 0;
 	if (ao_info.set_current || ao_info.set_rnext) {
-		test_xfail("%s: the socket has current/rnext keys: %d:%d",
-			   tst_msg,
+		test_xfail(tst_msg, "the socket has current/rnext keys: %d:%d",
 			   (ao_info.set_current) ? ao_info.current_key : -1,
 			   (ao_info.set_rnext) ? ao_info.rnext : -1);
 	} else {
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index fbc7f6111815..0d6f33b51758 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -59,8 +59,8 @@ static inline void __test_print(void (*fn)(const char *), const char *fmt, ...)
 	__test_print(__test_ok, fmt "\n", ##__VA_ARGS__)
 #define test_skip(fmt, ...)						\
 	__test_print(__test_skip, fmt "\n", ##__VA_ARGS__)
-#define test_xfail(fmt, ...)						\
-	__test_print(__test_xfail, fmt "\n", ##__VA_ARGS__)
+#define test_xfail(test_name, fmt, ...)					\
+	__test_print(__test_xfail, test_name, fmt "\n", ##__VA_ARGS__)
 
 #define test_fail(fmt, ...)						\
 do {									\

