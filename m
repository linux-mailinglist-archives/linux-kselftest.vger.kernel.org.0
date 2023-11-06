Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A504A7E2BAA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 19:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjKFSKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 13:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjKFSKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 13:10:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF4C6;
        Mon,  6 Nov 2023 10:10:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so4513192a91.3;
        Mon, 06 Nov 2023 10:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294213; x=1699899013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0hyNCGm882vleV6fWFop1iVQRBn8+2rPGqpsVkRuaVQ=;
        b=gIsMGq3KqpLPL8Ne025dIwQpRLdKZsyitsCFuDhGmeMGZWsTeB4N10+pclgwQtgi2T
         mR6vpDRwTnkPh/9g++PqhZquNRz6vqcyP4+QaZ46K+ZiEqcpRZm+s+yvx++xNyeVQ70Q
         0fO3sIGkmJXsu2CPsyiDBtexsRmeWDr31TqBdYTeLVF4Mms2OoAXCEnl/SbkUysSg84v
         96jjRXZJ4jjlIS8EdybRjNNsqc5Tt+4K0FrMKjyisd1lAE9/a0KTVELsSVKX7lWVCqtt
         Re5s4dH7meJgCINlosNQMZGMVgtNX5rRjs3I/ePAIkrEkeyi4yVmqgLzTuMBbuvqmUat
         zobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294213; x=1699899013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hyNCGm882vleV6fWFop1iVQRBn8+2rPGqpsVkRuaVQ=;
        b=OwILsIVgV8tSHjg3r71Bt+Q3X+m8bw1UVSQBOMNa/DiOyol6oHKqJesLV69v4KHlt8
         1TEcwjr5J/fs0HgEADmbePquHI+/xZ3mjnQD4gOT/uYDysXy7LNNAPaRBI3Yn7nkjth1
         8M2fe7kZXmGBJmSAYrGEudmrXoKxpnGWol359aDWe2z18qbRK4w2ys2frHPOGKIQfpsD
         zNMur9YPR3hp6F4SywUio6W9vxxXIFlPhTOOb9zvCj1xX8s8kGUvHgb84b9fd+yGPEAr
         xPh4M9pBUtpsNT1DzWW9LrHfVaT4ZsBBzJrFbv6bJ6N9+0yp2OY+qMZSwhbL//JJ15nj
         fA4g==
X-Gm-Message-State: AOJu0YxuW4d4eWWigG6w7u13cc/odRJX4AAgt2Zih6XJrGY1gEk5MGze
        3S/wKnxzzgKQeAAGmoZUW5Y=
X-Google-Smtp-Source: AGHT+IECzAVRoFqj+aM7dGWG6MXzjLS8pOw2hWIkBeO4fZkYJ4qIco06AySXEb71YwHchZqvAKnymA==
X-Received: by 2002:a17:90a:bf04:b0:27f:f9e5:b8d6 with SMTP id c4-20020a17090abf0400b0027ff9e5b8d6mr27911613pjs.41.1699294213263;
        Mon, 06 Nov 2023 10:10:13 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6815:d829:2ad7:8520:6556:6c40])
        by smtp.gmail.com with ESMTPSA id ge13-20020a17090b0e0d00b0026801e06ac1sm5754949pjb.30.2023.11.06.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:10:12 -0800 (PST)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     shuah@kernel.org, ivan.orlov0322@gmail.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] selftests: sched: Remove initialization to 0 for a static variable
Date:   Mon,  6 Nov 2023 23:40:05 +0530
Message-Id: <20231106181005.117062-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes following checkpatch.pl issue:
ERROR: do not initialise statics to 0

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 3e1619b6bf2d..7ba057154343 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -72,7 +72,7 @@ struct child_args {
 
 static struct child_args procs[MAX_PROCESSES];
 static int num_processes = 2;
-static int need_cleanup = 0;
+static int need_cleanup;
 
 static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4,
 		  unsigned long arg5)
-- 
2.25.1

