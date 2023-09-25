Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6FC7AE286
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 01:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjIYXh6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjIYXh5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 19:37:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924F116;
        Mon, 25 Sep 2023 16:37:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5bbb205e3so68392315ad.0;
        Mon, 25 Sep 2023 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695685070; x=1696289870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cv0O21j6tEHRD16fyNBggI9xx4lBjDTEd1wZVJg2WZM=;
        b=L5Q1e5V3Hp6CeJGnvsJTqn+neavdsMYT/SKh08CqD/fl/gIjwiBFpN8sm+LH3Td9dX
         dEw4T9qJ7oC+KK9FPDDlw7h90kg3wZhruVNqfFvNNanGHrZ/y8ZRZKPqm3gjqUAaF9yz
         oMeSkUGtJ1kjITdQbF7NayVFRTxFvCYVay9DxrRN85ygPoy9I/lmX+ANGJItoY546mjM
         iYO7tzlfs/3n+Jbrtb5WxEfvtQvmpOM6yBcGRXgoEq0Tf3xd9sj8CUsFDvYtjYH4N1fj
         12LB/3H79wR74pjvR0bDVnrSd6SySAwC9jQRH+rB/XVwin6sQKoV0a3HSiMh3zIeCQkX
         0MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695685070; x=1696289870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cv0O21j6tEHRD16fyNBggI9xx4lBjDTEd1wZVJg2WZM=;
        b=fuASLi/iXRCQfU2GgZi5yOnGnxDMgfRsNlYGU4x/N3kUWboYJIKA4Pl/lLsSV1svng
         0bQcc4M5P1pQWKqSWf+hF4YTz2pDg6V989eEi1FLiEZbFuXujvGMh6dYk5TEfpKhQgRc
         xk6AqlONCtOoi70nvb3V9dCOliOsYRs5YLCPJcNyAYLJlF7yX3v7A3+gpUTrZQexcpWE
         5z7wc7FhtUpycqRwdGQY+R683AJs16qkqFPqxrQj8vVjuH4uU9ynDdULPao367a6KCsn
         yoPZPAG+fLIEgVipeQZquPt3KNG7jlaVp4ec0z682ztRWu2Z8GDSRUsmdPKYzvBMelbh
         +5cQ==
X-Gm-Message-State: AOJu0YyDlTHkVty0wp/pLXykg8UQetxUvRiTTj/a2sJ9CDy1zuhiQHJO
        LKKkdlq3LzN/dgheQrttDpOs7UygpY8=
X-Google-Smtp-Source: AGHT+IHa9xV1TKFdilYUVAPeFnWWJh1C/MYUePTZ2gl31uYYa2T6D1VFtSEKy2FCVy/eEPcCeHbNhw==
X-Received: by 2002:a17:903:32ce:b0:1c4:3cd5:4298 with SMTP id i14-20020a17090332ce00b001c43cd54298mr11647351plr.18.1695685070177;
        Mon, 25 Sep 2023 16:37:50 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-53.cable.teksavvy.com. [69.172.146.53])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b001b9d7c8f44dsm291286plb.182.2023.09.25.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 16:37:49 -0700 (PDT)
From:   Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Tony Ambardar <Tony.Ambardar@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v1] bpf/selftests: improve arg parsing in test_verifier
Date:   Mon, 25 Sep 2023 16:37:02 -0700
Message-Id: <20230925233702.19466-1-Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Current test_verifier provides little feedback or argument validation,
instead silently falling back to running all tests in case of user error
or even expected use cases. Trying to do manual exploratory testing,
switching between kernel versions (e.g. with varying tests), or working
around problematic tests (e.g. kernel hangs/crashes) can be a frustrating
experience.

Rework argument parsing to be more robust and strict, and provide basic
help on errors. Clamp test ranges to valid values and add an option to
list available built-in tests ("-l"). Default "test_verifier" behaviour
(run all tests) is unchanged and backwards-compatible. Updated examples:

     $ test_verifier die die die     # previously ran all tests
     Usage: test_verifier -l | [-v|-vv] [<tst_lo> [<tst_hi>]]

     $ test_verifier 700 9999        # runs test subset from 700 to end

Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 54 ++++++++++++---------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 98107e0452d3..3712b5363f60 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -10,9 +10,11 @@
 #include <endian.h>
 #include <asm/types.h>
 #include <linux/types.h>
+#include <linux/minmax.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <ctype.h>
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
@@ -1848,36 +1850,40 @@ int main(int argc, char **argv)
 {
 	unsigned int from = 0, to = ARRAY_SIZE(tests);
 	bool unpriv = !is_admin();
-	int arg = 1;
-
-	if (argc > 1 && strcmp(argv[1], "-v") == 0) {
+	int i, arg = 1;
+
+	while (argc > 1 && *argv[arg] == '-') {
+		if (strcmp(argv[arg], "-l") == 0) {
+			for (i = from; i < to; i++)
+				printf("#%d %s\n", i, tests[i].descr);
+			return EXIT_SUCCESS;
+		} else if (strcmp(argv[arg], "-v") == 0) {
+			verbose = true;
+			verif_log_level = 1;
+		} else if (strcmp(argv[arg], "-vv") == 0) {
+			verbose = true;
+			verif_log_level = 2;
+		} else
+			goto out_help;
 		arg++;
-		verbose = true;
-		verif_log_level = 1;
 		argc--;
 	}
-	if (argc > 1 && strcmp(argv[1], "-vv") == 0) {
-		arg++;
-		verbose = true;
-		verif_log_level = 2;
-		argc--;
-	}
-
-	if (argc == 3) {
-		unsigned int l = atoi(argv[arg]);
-		unsigned int u = atoi(argv[arg + 1]);
 
-		if (l < to && u < to) {
-			from = l;
-			to   = u + 1;
-		}
-	} else if (argc == 2) {
-		unsigned int t = atoi(argv[arg]);
+	for (i = 1; i <= 2 && argc > 1; i++, arg++, argc--) {
+		unsigned int t = min(atoi(argv[arg]), ARRAY_SIZE(tests) - 1);
 
-		if (t < to) {
+		if (!isdigit(*argv[arg]))
+			goto out_help;
+		if (i == 1)
 			from = t;
-			to   = t + 1;
-		}
+		to = t + 1;
+	}
+
+	if (argc > 1) {
+out_help:
+		printf("Usage: %s -l | [-v|-vv] [<tst_lo> [<tst_hi>]]\n",
+		       argv[0]);
+		return EXIT_FAILURE;
 	}
 
 	unpriv_disabled = get_unpriv_disabled();
-- 
2.34.1

