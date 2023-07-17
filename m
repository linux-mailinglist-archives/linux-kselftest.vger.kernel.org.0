Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A1755D97
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGQH4y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGQH4x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 03:56:53 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076911C
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 00:56:51 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4Dtl4bMTzBQt1h
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 15:56:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689580607; x=1692172608; bh=mVoTickR5fGpVpXegoqwlUNIHFM
        +DiJrOa8mmExth/4=; b=OHB0mQ2zc22xUd6JyriOsKvGKxDJlemy5WtPHkx/5t/
        K25Jz36ruhhZQftzHIIuokaleGQAh4N4Y+mtWkN4jcG/Wdae98q9bhnjaG5FJrxD
        Q7WSEyzOXKL1Cz/ISG8mZ+LVsWLKsbcDXeHsAg9UQM7Y/+4D98mIfu6MR/+Z2RUu
        3YityKMp+e/6RpNPYxkpxdVVd1J1+qgZBlBm7sjBUFukvW/mPQ8z7n16FT3cazcT
        MunXyhFRxegAB9hj7fI1ZEvEFaevAHELnXzKg6rvScJLuDb7JYmqcgDgWKsa8riy
        HBFyKKRXrGiMOEXUz8pc7hM5zqOMpNByQmBRSlwlqCw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id omfqBLsXbL8p for <linux-kselftest@vger.kernel.org>;
        Mon, 17 Jul 2023 15:56:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4Dtl1n0fzBHXgm;
        Mon, 17 Jul 2023 15:56:47 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:56:47 +0800
From:   shijie001@208suo.com
To:     andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix errors in log_fixup.c
In-Reply-To: <tencent_E184AD3DB9CAB3F8C7DCDE620D5C2218F90A@qq.com>
References: <tencent_E184AD3DB9CAB3F8C7DCDE620D5C2218F90A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <2dc1d837343d3880057aee05dd047a57@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following checkpatch errors are removed:
ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  tools/testing/selftests/bpf/prog_tests/log_fixup.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c 
b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index dba71d98a227..69959748d466 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -14,7 +14,7 @@ enum trunc_type {
  static void bad_core_relo(size_t log_buf_size, enum trunc_type 
trunc_type)
  {
      char log_buf[8 * 1024];
-    struct test_log_fixup* skel;
+    struct test_log_fixup *skel;
      int err;

      skel = test_log_fixup__open();
@@ -72,7 +72,7 @@ static void bad_core_relo(size_t log_buf_size, enum 
trunc_type trunc_type)
  static void bad_core_relo_subprog(void)
  {
      char log_buf[8 * 1024];
-    struct test_log_fixup* skel;
+    struct test_log_fixup *skel;
      int err;

      skel = test_log_fixup__open();
@@ -104,7 +104,7 @@ static void bad_core_relo_subprog(void)
  static void missing_map(void)
  {
      char log_buf[8 * 1024];
-    struct test_log_fixup* skel;
+    struct test_log_fixup *skel;
      int err;

      skel = test_log_fixup__open();
@@ -138,7 +138,7 @@ static void missing_map(void)
  static void missing_kfunc(void)
  {
      char log_buf[8 * 1024];
-    struct test_log_fixup* skel;
+    struct test_log_fixup *skel;
      int err;

      skel = test_log_fixup__open();
