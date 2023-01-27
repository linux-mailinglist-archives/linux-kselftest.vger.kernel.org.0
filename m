Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F167E77E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjA0N6q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjA0N62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:28 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954A22A3B;
        Fri, 27 Jan 2023 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827887;
        bh=hrehtAX3imUhugArusDqj/IhIz0SGwkElj5egzGruEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0DLJhDGVpXa4+wan766F8yUwg+B3BGzYcLfXu6Mqi07WJVDi4uiGz6caLG9OGKk6
         D8+4nU1CGAOUIEEbz3VmrOjJKUHVqXnlJi0TDA3YWqfPWvOWbtkYMbKxBkV6Vk0+FY
         Yf5c4phci9EENQXEqQXWDEK4PvjDHpxaoCpG/g65arCNeXSIbwyTL8H6NirI/ctoCe
         pjrUKFyOusxmUMLt2gy2ukJDn9fE3//u5R1Ic0UbOHLFR4hEIa/1SSMZeYcpg3HdCK
         56kM0PCv5Tl4B6bPUz94f4yaaPUyW+q25gfiHtY9fQ+kieMq5eyPE2U2rsY+j8Q8t1
         /5rc45MbZdKbQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0b63kVzhd2;
        Fri, 27 Jan 2023 08:58:07 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 32/34] selftests: memfd: Use installed kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:53 -0500
Message-Id: <20230127135755.79929-33-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
than using kernel headers in include/uapi from the source kernel tree
kernel headers.

Remove bogus ../../../../include/ from the search path, because
kernel source headers are not needed by those user-space selftests, and
it causes issues because -I paths are searched before -isystem paths,
and conflicts for files appearing both in kernel sources and in uapi
headers with incompatible semantics (e.g. types.h).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
---
 tools/testing/selftests/memfd/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 4da8b565fa32..163b6f68631c 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -D_FILE_OFFSET_BITS=64
-CFLAGS += -I../../../../include/uapi/
-CFLAGS += -I../../../../include/
-CFLAGS += -I../../../../usr/include/
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := memfd_test
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
-- 
2.25.1

