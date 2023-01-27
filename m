Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3A67E776
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjA0N6j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjA0N61 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:27 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6C23308;
        Fri, 27 Jan 2023 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827888;
        bh=qyXkvYUwyIa3WaXYDPo/AGluylZ3rgz4mbOR6T5kRy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fx7Ccsg1l4/bIlGKAci/UtOvrAJQFUWqzzn492GzbHcL4h1usGWczP/8oHFZbF5xo
         8qfAjhTZ7Sa+22OS2kqcZWJIXdvqlo4M+/VOcV0BXZow1FkdctwFwLgW9ANI/IyZJS
         Zi+JLh0AQI6oJZslJIrl2/N6xATYSAuEsdq6WjD0Y1EcgeqqsbgbZ3TzqdJ8i4zESh
         so0TvFfUgEUkHw9oJL7Iv8DDfB+Po3DAJaX7UY9r7ZwC4/PEEsJIZ/s/4jFdTKjkU9
         lPunRDoIzEN2mh+wPQL0bfWoF+gztAjdvSmLCVwIeuIjGKDQogXgs30C/aHRIGIfcv
         G4/tkHIXBe8OA==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0c0JvFzhd3;
        Fri, 27 Jan 2023 08:58:08 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 33/34] selftests: ptrace: Use installed kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:54 -0500
Message-Id: <20230127135755.79929-34-mathieu.desnoyers@efficios.com>
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

Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
than using kernel headers in include/uapi from the source kernel tree
kernel headers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
---
 tools/testing/selftests/ptrace/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 2f1f532c39db..96ffa94afb91 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -std=c99 -pthread -iquote../../../../include/uapi -Wall
+CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
 
-- 
2.25.1

