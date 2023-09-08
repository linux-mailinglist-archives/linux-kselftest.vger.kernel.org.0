Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD779929E
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 01:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjIHXDa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343600AbjIHXD3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 19:03:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E411FED
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 16:03:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec9300c51so2500047276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694214204; x=1694819004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b98aA5lsSwU0e6a2QD0NPfrvu8IBYbkSu4DS3ojXLjM=;
        b=7SPxUPktNb5j/Gb6kGYrDBl2U5ySeIZ4p0JB3UbScmcFwRpKbt4NGKG3ZjjJlxpReN
         Us2BaxwVFTTQ0tfaIDXpuRcMeaVxLaXMWj6YuZN6wLnuNLmycNJTSNYOB5LkpNQciGlK
         sNHMCJxvw4B9Dpjx2OzjQctzL3TFQf8DuH8WnOvcftGxhVorFVJJ8Lf8I78azJ4aN/4+
         gB5w1HgXfyyQLVTeo0e/+KJCZuWfzOe79JRJgGvc+RZI0pgxrcsdVsosPrbH4qUoRdcK
         H8udI/kWi8VF39vGstsheVn2dXqyrva4444I4r/X9bmj5jzg54sdOU/G7DXvs/ooNa2D
         6jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694214204; x=1694819004;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b98aA5lsSwU0e6a2QD0NPfrvu8IBYbkSu4DS3ojXLjM=;
        b=niI1BMBlxI1a99b3SGb5cGbE7Y+/5qYqpP0P0rYmq1em69s71A10o3avcQalBQDsfO
         DAtalSK/i9hY977ps2drRlRAbagM7d6np9SkPtQNA8uuprwXTq1hoN42KVsARcuUvJRZ
         e85Y3gceqwf8dR0Tnu4zyjv88CfdD4X93ChqP6jaHM0ohjIDEEmu6vnpgve3yUEKPLXq
         ES+6u+PAVSahoJTP28LGDL2UcunTlBSESSiVO1bV2TzKjw41UzNYngBkPn/M4Bklh37q
         DIRIuv226aQNnOGdN1us5KGp664Ocn7iOoOGeH4cFfrfRhw9AEd1QnDyt3r5LhFUsj2m
         zAAw==
X-Gm-Message-State: AOJu0Yxhn9es+DSA/Zc/ue6ctL3nmtzIXFdJn7TMKcp7B+7fHKShoyjC
        cD6GDQqITVrAgh6KX7FdRJRChtIBTgA4nO5AAg==
X-Google-Smtp-Source: AGHT+IH7+IGP4N+5rjSjCLLdCVJhYLHEeHbwhPidz47HX5WWuR/DTQJlAG4w6KEvm7q3PZZODEduULaPwxf1R/NQyw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1682:b0:d7b:8d0c:43f1 with
 SMTP id bx2-20020a056902168200b00d7b8d0c43f1mr92700ybb.9.1694214204562; Fri,
 08 Sep 2023 16:03:24 -0700 (PDT)
Date:   Fri, 08 Sep 2023 23:03:23 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADqo+2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSwML3ezi1Jy0ktTiEt2CxKLE3HgwM1nX0NzMOMnMKNXczChNCai5oCg 1LbMCbHC0UpCbs1JsbS0A5OV5420AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694214203; l=2948;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=U7toQp9XYVwiQw1flxIcg0RQUw/WUAt8uuyO5vIs0cs=; b=m6DVoM2aKvthnKkhJ2kEFW+8y3zfXgXLKKjGBV5dz10ltPeArywKoK91of1kYJaKM4dIIj+L1
 7a9X6VMUvMWD0OcAOciXLUli+xa7n05MUMrwODU7CmSEplQPe9zvpz6
X-Mailer: b4 0.12.3
Message-ID: <20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com>
Subject: [PATCH RFC] selftests/rseq: fix kselftest Clang build warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I am experiencing many warnings when trying to build tools/testing/selftests.

Here's one such example from rseq tree:
|  param_test.c:1234:10: error: address argument to atomic operation must be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
|   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
|        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
|  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/lib/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_load'
|    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC_SEQ_CST)
|        |                             ^                 ~~~~~~

I added the _Atomic type in various locations to silence _all_ (10) of these
warnings. I'm wondering, though, perhaps the absence of these _Atomic
types in the first place is on purpose? Am I on the right track to fix
these warnings without damaging the legitimacy of the tests at hand?

I'd like some feedback about where to go from here and if others are
experiencing the same issues. Thanks!

FWIW here's my specific build incantation on Clang-18 (49d41de57896e935cd5726719c5208bce22694ae):
$ make LLVM=1 -j128 ARCH=x86_64 mrproper headers defconfig kselftest-merge
$ make LLVM=1 ARCH=x86_64 -C tools/testing/selftests

Link: https://github.com/ClangBuiltLinux/linux/issues/1698
Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 tools/testing/selftests/rseq/param_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index bf951a490bb4..94802aeed2c6 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -356,7 +356,7 @@ struct inc_thread_test_data {
 };
 
 struct percpu_list_node {
-	intptr_t data;
+	_Atomic intptr_t data;
 	struct percpu_list_node *next;
 };
 
@@ -1212,8 +1212,8 @@ static int set_signal_handler(void)
 /* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
 #ifdef TEST_MEMBARRIER
 struct test_membarrier_thread_args {
-	int stop;
-	intptr_t percpu_list_ptr;
+	_Atomic int stop;
+	_Atomic intptr_t percpu_list_ptr;
 };
 
 /* Worker threads modify data in their "active" percpu lists. */
@@ -1240,7 +1240,7 @@ void *test_membarrier_worker_thread(void *arg)
 			int cpu = get_current_cpu_id();
 
 			ret = rseq_offset_deref_addv(RSEQ_MO_RELAXED, RSEQ_PERCPU,
-				&args->percpu_list_ptr,
+				(intptr_t*)&args->percpu_list_ptr,
 				sizeof(struct percpu_list_entry) * cpu, 1, cpu);
 		} while (rseq_unlikely(ret));
 	}

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230908-kselftest-param_test-c-1763b62e762f

Best regards,
--
Justin Stitt <justinstitt@google.com>

