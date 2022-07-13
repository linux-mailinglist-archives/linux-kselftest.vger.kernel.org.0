Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBDE573E01
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiGMUqi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiGMUqh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:37 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AD431374
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=ETa1R8snflFHVr
        rpwnW5JCL7u57vMzoNpLWO6TprPB8=; b=ttU4wW3wc+S/vURqy04+exCzIE4hL5
        C0DHgMdxPx4jXC7h9XHez1Kf7XygHq2ibcz3GxLrtP8tkK3cOcMZlyStkDN9NN6d
        lkglwMhYLoAh2QDoclASPPk0uovORMNiwkL2lOU4pt+NY4W7UhkDUNjHxXQv2iwo
        knuP2Sp0Z2K3k=
Received: (qmail 305636 invoked from network); 13 Jul 2022 22:46:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:34 +0200
X-UD-Smtp-Session: l3s3148p1@kPNn4bXjlqYgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/9] selftests: timers: fix declarations of main()
Date:   Wed, 13 Jul 2022 22:46:14 +0200
Message-Id: <20220713204623.5443-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mixing up argc/argv went unnoticed because they were not used. Still,
this is worth fixing.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/testing/selftests/timers/adjtick.c          | 2 +-
 tools/testing/selftests/timers/change_skew.c      | 2 +-
 tools/testing/selftests/timers/raw_skew.c         | 2 +-
 tools/testing/selftests/timers/skew_consistency.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 54d8d87f36b3..47e05fdc32c5 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -165,7 +165,7 @@ int check_tick_adj(long tickval)
 	return  0;
 }
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timespec raw;
 	long tick, max, interval, err;
diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
index c4eab7124990..992a77f2a74c 100644
--- a/tools/testing/selftests/timers/change_skew.c
+++ b/tools/testing/selftests/timers/change_skew.c
@@ -55,7 +55,7 @@ int change_skew_test(int ppm)
 }
 
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timex tx;
 	int i, ret;
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index b41d8dd0c40c..5beceeed0d11 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -89,7 +89,7 @@ void get_monotonic_and_raw(struct timespec *mon, struct timespec *raw)
 	}
 }
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timespec mon, raw, start, end;
 	long long delta1, delta2, interval, eppm, ppm;
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 8066be9aff11..63913f75b384 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -38,7 +38,7 @@
 
 #define NSEC_PER_SEC 1000000000LL
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timex tx;
 	int ret, ppm;
-- 
2.35.1

