Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9764574B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 11:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiLGKOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 05:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiLGKOM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 05:14:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6F2714D;
        Wed,  7 Dec 2022 02:14:10 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so713032wms.0;
        Wed, 07 Dec 2022 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxmfktVo1c7I9TfGKhpFnuMsTMZSubcGd4XXjSjhiS8=;
        b=HDDkcehqX+6CTSSx6ZcH7IBcmqUljP/LUYffmQaakWZHMVdRndoDLP98evMboJIONF
         5Vyux7uiI28FUdq6tXvYHm004tuWiAofkFLtqmUd80yG9fA9v0zCneL55yeotADd3POK
         J7dm28C79KXN5VKrAbzVu1T5FtcyCUlzKvqOKACxQzH1B48r0fogJJFeUWkv9aIb59eQ
         tDdzBTlN9yXjxEduJUTHNwz5b+oLCO66HACgqVWN8rN7J4HiUt657QeJK0oJJUyabU/h
         rLvUy8Av/S8xgi9HMpgIqq+SUzl8PdAINLfgS2TpN8gjf02X1APolkjhCQ7KPpct/7a7
         9Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxmfktVo1c7I9TfGKhpFnuMsTMZSubcGd4XXjSjhiS8=;
        b=hSEwFW26hJVehMXPev07t7gcbd+2tdaHLJfGD97KykoeG1vFUmsVDZ1iKsfbCpZt/+
         grrA9sQgathw5ZwVYFpvbrzqItJxyiVKJqZuJhs+0Y3sgIoPEtXQZHB+FuMkOe3hAWRz
         haGHvi4ROp7OojQKyCA3uhSUaiAh5C3DVYY3+9zpGNNTYKHdUNHjJFrJaap8gQM2vbIE
         LRJEeV43ClykilBHnTrbQYxl+9BcDndV5lJDMYhr+nQr9nQfuxDoUkYMFLwCzkyyPvXf
         QIctcWbx9JMHYebZanuh3byeSKvKIGCNaksWByhEId1CtYC4cnIalPYqLt86JxvgvXlp
         89kQ==
X-Gm-Message-State: ANoB5pmSvWNZB+JKcJ7Bpmy6ljIxHRxLCWyS8RSe9HDPqjAhmyek0c6o
        L20VIVodofPp9xmP2K7/YhF8pTBAtfgXxTcl
X-Google-Smtp-Source: AA0mqf64RWzzi27+MgKKIt62u31McnZURFRGUmm0JvtRaf3tquhSgS8+d00TBNGsFF+MM7vHX4Y45A==
X-Received: by 2002:a05:600c:314f:b0:3cf:9efc:a9b7 with SMTP id h15-20020a05600c314f00b003cf9efca9b7mr66575359wmo.10.1670408049403;
        Wed, 07 Dec 2022 02:14:09 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x11-20020adfec0b000000b00241f029e672sm18763941wrn.107.2022.12.07.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:14:08 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Fix spelling mistake "allright" -> "alright"
Date:   Wed,  7 Dec 2022 10:14:07 +0000
Message-Id: <20221207101407.2285701-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are spelling mistakes in messages in the prctl tests. Fix these.
Note: One can use "all right", or "alright", I'm fixing this to use
the slightly more informal and more modern form of the spelling for
the fix.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c | 2 +-
 tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c b/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c
index 62a93cc61b7c..868f37fd1d5e 100644
--- a/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c
+++ b/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c
@@ -79,7 +79,7 @@ int main(void)
 {
 	int n_tasks = 100, i;
 
-	fprintf(stderr, "[No further output means we're allright]\n");
+	fprintf(stderr, "[No further output means we're alright]\n");
 
 	for (i=0; i<n_tasks; i++)
 		if (fork() == 0)
diff --git a/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c b/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c
index 79950f9a26fd..3822532fc0c6 100644
--- a/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c
+++ b/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c
@@ -83,7 +83,7 @@ int main(void)
 {
 	int n_tasks = 100, i;
 
-	fprintf(stderr, "[No further output means we're allright]\n");
+	fprintf(stderr, "[No further output means we're alright]\n");
 
 	for (i=0; i<n_tasks; i++)
 		if (fork() == 0)
-- 
2.38.1

