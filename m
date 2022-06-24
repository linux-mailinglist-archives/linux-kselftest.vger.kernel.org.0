Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4440155A229
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiFXTxA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiFXTw7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 15:52:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1F5B85;
        Fri, 24 Jun 2022 12:52:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so2955892plc.8;
        Fri, 24 Jun 2022 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F64miWX8OIqGg7SQtGzniGR3amqV7Fg7vGx9jO7hUCs=;
        b=KG3QkLlWUxzLyv8sJMKH921oVvgVk521YHQekwTUWlGSfDMB9pqY0/y10mxQ5RC/sE
         RACAUQBOb9GFJAD0pNe7zYYb0zT6qdwrMkun4xBAmlAVFUVejeIgPtfkImyTxDcK9joG
         WIyobwYTQFAzSCctv50iKXFyYvsWZ2NtQoaZp2XypkYmBi9vCH3bCMzGO1zf9oFrsiaA
         m0sLaImwJ8X3u0ZEBoVB33JOBGWULVChZZaKNosHVhxAR7tgzzxUQiCZEi2cfOGxe8Og
         JDxEJb/8Q/5s9D41e0wWDLUquxLYba8LZ/0lPR1GoAoRRWGvZ2yuwD1MOHsJbJVbszia
         ueKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F64miWX8OIqGg7SQtGzniGR3amqV7Fg7vGx9jO7hUCs=;
        b=G2nsA2DYsiTZ2DX4tPnZEQZLmXhafHW+4EqLGhiaOINCr6L1LC18OKbdl3fgy4S6CY
         NJE/t7mluWCxbjHqUSyohirdZvXDfZZgE1yV0jHSmp5n7ofgthT2qUtKyWAszXjC4zi7
         BWPmX1jtZt0o8K+vrDHDz7SKKSvG1oULqaPugigVhHc6RVtSM3xdSzPIwCEkG5MP9f2L
         iN+A1pVXGshs7JegaTtTHXNAqYQn+Nt8yuAI8zO0sLTE7UHzf94stbRXh/EgHU0a8MMP
         7+c4UJXe1rdyBV9BsY68hiAyH1iD1HBtmsrtnT+LphsqowO1n0A5i6cVYs2aZd5S++L8
         cH4w==
X-Gm-Message-State: AJIora/oMMZFtiKlW2Yb2xklQXu5oEvARrnSxrs2kMWb+EoTM4S1gZlU
        2Bs4JYKJrRB2pPue4YNgEHw=
X-Google-Smtp-Source: AGRyM1u5oABiaQ4N9vv8eRRoGYjSna+gp2MU2xgiqmbWPGR0eG0IzoEqq8qbimjBVbruzHb8HViHyQ==
X-Received: by 2002:a17:90a:8041:b0:1ec:9f10:3c4e with SMTP id e1-20020a17090a804100b001ec9f103c4emr614193pjw.148.1656100377092;
        Fri, 24 Jun 2022 12:52:57 -0700 (PDT)
Received: from fedora.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f70900b001663cf001besm2186069plo.174.2022.06.24.12.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 12:52:56 -0700 (PDT)
From:   Gautam <gautammenghani201@gmail.com>
To:     sj@kernel.org, shuah@kernel.org
Cc:     Gautam <gautammenghani201@gmail.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kselftests/damon: add support for checking secureboot status
Date:   Sat, 25 Jun 2022 01:22:39 +0530
Message-Id: <20220624195239.7293-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel is in lockdown mode when secureboot is enabled and hence
debugfs cannot be used. But the error printed after running tests does
not indicate this currently:

>TAP version 13
>1..6
># selftests: damon: debugfs_attrs.sh
># cat: /sys/kernel/debug/damon/monitor_on: Operation not permitted
># _debugfs_common.sh: line 48: [: =: unary operator expected
># cat: /sys/kernel/debug/damon/attrs: Operation not permitted
># _debugfs_common.sh: line 11: /sys/kernel/debug/damon/attrs: Operation 
> not permitted
># writing 1 2 3 4 5 to /sys/kernel/debug/damon/attrs doesn't return 0
># expected because: valid input
># _debugfs_common.sh: line 16: /sys/kernel/debug/damon/attrs: Operation 
> not permitted
>not ok 1 selftests: damon: debugfs_attrs.sh # exit=1


After adding the check for secureboot, the output is as follows:

>TAP version 13
>1..6
># selftests: damon: debugfs_attrs.sh
># debugfs cannot work with secureboot enabled
>not ok 1 selftests: damon: debugfs_attrs.sh # exit=1


Signed-off-by: Gautam <gautammenghani201@gmail.com>
---
 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
index 0189db81550b..6e45c1fe230e
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -26,3 +26,13 @@ do
 		exit 1
 	fi
 done
+
+secureboot_error="Operation not permitted"
+for f in attrs target_ids monitor_on
+do
+	status=$( cat "$DBGFS/$f" 2>&1 )
+	if [ "${status#*$secureboot_error}" != "$status" ]; then
+		echo "debugfs cannot work with secureboot enabled"
+		exit 1
+	fi
+done
-- 
2.36.1

