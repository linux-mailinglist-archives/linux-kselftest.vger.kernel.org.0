Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AA01A006B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Apr 2020 23:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDFVln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 17:41:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40918 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFVln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 17:41:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id s8so1327513wrt.7
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Apr 2020 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilGxnVodtVtLU817wnANQiwj9/w+YdwIbOSYK+2/y6I=;
        b=X1ag0VG+/UYX8gsBzBK+4NwZYGaeMwVtH/+jFyix8J44fPaPHlbV63AdZs9rvO2UjG
         lzrkyBOIzLTMd669+tbwiM75LKz6vDg4Il3f0aq6HwE7PfN5j1cfdq5arnAqSLdO4Lkf
         XPYHg6OT6GPfqKJozHY8HLpAdH+J5v7BKTuNMv+OxRC1/BRDKkTgE1Z/AioA6v08OBD6
         XlPjXNResmUAY5H/W2U1LkVeLQxNpy1rTr1Asj4pI7eSkgyIKvIhwJ2uyl900I/4DaX5
         7NKhYe37JKsCi7I8BL1uw1zxPu/QO5dLmHbjtuNFn5l2cT9naRwAe3FKACcBoM9ehWD4
         SIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilGxnVodtVtLU817wnANQiwj9/w+YdwIbOSYK+2/y6I=;
        b=ATCc1RM3M+NQG0vs3dqIydqB+KF9gCkpDx2XL7O0U0HBM3/tugo27z6cdo8eQAV6wx
         AmSSIRCCp28AEqbvHZr0psUztS3IDmNqjPH5nRlrT9/dH1IAWvMmireZs0UFBr2jpOFk
         IVdZbXvkWfWOcFPRJkyYKxsnSTKAojPlhhCMBrflvKbB7HjpcVFCwmAJYV1mr7h6pIRh
         h187Va5AlrX8fOSP0Rv1tY0EMkkuVOXGJ+CAKzAV2tvHBHecP6h0fAiJD2symPfjDBu8
         FgwMxUid3BBVGQWtGRXbw776yJDFbP5ngv3H11AwG6DXSq/ExW+l1se3cVGi20tpUCVJ
         ysDg==
X-Gm-Message-State: AGi0PuZsugcK+nQnoWgzNe882Bv2rZXSCgSk2bSGXN8/L67rnG40RKal
        trpMQdq11aQESHB9mvy5CnU=
X-Google-Smtp-Source: APiQypLbk6B47CmsGUJn7Yp7dKMmHj6KKgAwJoCBtFXYrg2F+8HS6e5KoJXSBqNZhytgY04d/Dc1HQ==
X-Received: by 2002:adf:f4cc:: with SMTP id h12mr1278846wrp.171.1586209301445;
        Mon, 06 Apr 2020 14:41:41 -0700 (PDT)
Received: from de0709bef958.v.cablecom.net ([185.104.184.118])
        by smtp.gmail.com with ESMTPSA id j10sm11115813wru.85.2020.04.06.14.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:41:41 -0700 (PDT)
From:   Lothar Rubusch <l.rubusch@gmail.com>
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH] Documentation: test.h - fix warnings
Date:   Mon,  6 Apr 2020 21:41:30 +0000
Message-Id: <20200406214130.21224-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix several sphinx warnings at 'make htmldocs'
- privately declared members not correctly declared as such
- 'suits' actually is not a function parameter, change declaration to fix
  warning but keep information in comment

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 include/kunit/test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9b0c46a6ca1f..fe4ea388528b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -175,7 +175,7 @@ struct kunit_suite {
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
 
-	/* private - internal use only */
+	/* private: internal use only. */
 	struct dentry *debugfs;
 	char *log;
 };
@@ -232,7 +232,7 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * suites - a statically allocated list of &struct kunit_suite.
  *
  * Registers @suites with the test framework. See &struct kunit_suite for
  * more information.
-- 
2.20.1

