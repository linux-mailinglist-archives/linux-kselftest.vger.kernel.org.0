Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7D67E732
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjA0N6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjA0N6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:07 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4AB40ED;
        Fri, 27 Jan 2023 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827881;
        bh=ZcCKW7xHONk6lQkmDiIQ6FF58ak31qhSFzWiuXDr2hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQl6h6ajedQaMhcvhGLSEeGTiB+LP244YHTUh0QwRPLf/lQeqdklGNFmgnU1+7Tab
         EX+MEIw7zp/t8lW2Uw/XOFoWqmPWBK8KKnYYXrEM7UEFpD4uud1/JGO1dR+eZhyGKb
         e2TPY+m8ZRZxOqgGoEggAWS9yp+IRySGPDEYznCAKaLl/A5e7miInF/FLDEv3lNoh4
         IXq744ROYHlE4+xeyYveQdLCrdnU9V5UwToAXNWEhrkU72VlUJ7Ptdq+iRCaBxP90v
         1aZ14YkS3crvxCt1zJ+zM8FTfGYuyttIkBkyCKgOEKkM2I0IU48U1cyrE49aSKLxV4
         CVlScCdUtk7Ag==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0T5NPszhnn;
        Fri, 27 Jan 2023 08:58:01 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        stable@vger.kernel.org
Subject: [PATCH 03/34] selftests: clone3: Fix incorrect kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:24 -0500
Message-Id: <20230127135755.79929-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
building against kernel headers from the build environment in scenarios
where kernel headers are installed into a specific output directory
(O=...).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <stable@vger.kernel.org>    [5.18+]
---
 tools/testing/selftests/clone3/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index 79b19a2863a0..84832c369a2e 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -g -std=gnu99 -I../../../../usr/include/
+CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
-- 
2.25.1

