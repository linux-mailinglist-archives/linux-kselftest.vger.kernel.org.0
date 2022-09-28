Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F675EE93A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiI1WQW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 18:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiI1WQQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 18:16:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA017D4AB5;
        Wed, 28 Sep 2022 15:15:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so21846925wrm.2;
        Wed, 28 Sep 2022 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=U9aShu+m2MRsPTWfeAMtyQ2IfmOIFxH+yNvPPleyJls=;
        b=QrcFqFCRw9zrU+/jdWYAAqrhLVq69yOmne/q+IW3rYLpaFop7ONsaNtFbzBPs3l6Wc
         eXAZ9/+Fkn02CCM8AuAr7c9V8N5gVsu4ekthQoKv/Efo4lKsNYJusSFEYd7GqcnkC1dn
         JEL27tpL3r4ffeG0T59tnnGrclZAoNLixaswfdxDtkcLPdVgmofUu9bRVZ8ogLUYSkbe
         W2rhZAObDjHSSCIgGDa0vZfI7gLBdyisiZCtWgDJGCRfD45wNz18TJ6waXr9vbVSyfqE
         ceJXcjUYj8LNt5eiWGMUhedxIvtg40H2FcAxrTT+ciI/FEdi09hHSoWcZEK5Hk1EHvch
         RQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=U9aShu+m2MRsPTWfeAMtyQ2IfmOIFxH+yNvPPleyJls=;
        b=0ftFQZHi3b4JAVvMaqqZmEfgQuYBOxembWj9OcRsmSjiNy1ejzNZ8M9r2wdnXEQ92w
         yehSi+C89xnJ7foQKRjsQ82koBbelOSgeopY5IUsjYV9ZlU5U4B5GGNM8J9vKiNVKJRa
         DzoEkE9rvlMNtmk8TfJB2EkiVc8cAnesJyuDzESLj0ULNlnBwuhEYtKB8n4ZRM0hUPdJ
         MJeeKe5YNVU0YHfiKGvLRnjNlMOEJm/VU1LnrDYm/FPIytP9PMI+nKGZtTJ4ekLsD0BW
         KCPjsXt7tdVwgKHXucxC32iph2v7ZxKyAhV51MFJc4+O4Qga3RAOovveABqQnC44tRD8
         ZfIQ==
X-Gm-Message-State: ACrzQf1tzO1/qvcVbahVFg/0J+ewpSzDJBIT4Mv3nASaTGW+2PGi8f9d
        Sou9jzW+FKfF5wWi75W/E/I=
X-Google-Smtp-Source: AMsMyM53D9mi6CzqXvMaxFAEJ4Eva0FdvbIlbs5bc8zHxOnAFrFuumfZ+OIrGPeDWzWOGfIwhcnNNg==
X-Received: by 2002:a5d:6544:0:b0:22a:cc7d:56d0 with SMTP id z4-20020a5d6544000000b0022acc7d56d0mr6003wrv.331.1664403356904;
        Wed, 28 Sep 2022 15:15:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c2d0c00b003b51369fbbbsm2981079wmf.4.2022.09.28.15.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:15:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix spelling mistake "unpriviledged" -> "unprivileged"
Date:   Wed, 28 Sep 2022 23:15:55 +0100
Message-Id: <20220928221555.67873-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There a couple of spelling mistakes, one in a literal string and one
in a comment. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/verifier/calls.c   | 2 +-
 tools/testing/selftests/bpf/verifier/var_off.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 3fb4f69b1962..e1a937277b54 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -284,7 +284,7 @@
 	.result = ACCEPT,
 },
 {
-	"calls: not on unpriviledged",
+	"calls: not on unprivileged",
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 187c6f6e32bc..d37f512fad16 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -121,7 +121,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 1 },
-	/* The unpriviledged case is not too interesting; variable
+	/* The unprivileged case is not too interesting; variable
 	 * stack access is rejected.
 	 */
 	.errstr_unpriv = "R2 variable stack access prohibited for !root",
-- 
2.37.1

