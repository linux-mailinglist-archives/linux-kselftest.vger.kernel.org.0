Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3367E772
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjA0N6i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjA0N61 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:27 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C971622DEA;
        Fri, 27 Jan 2023 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827887;
        bh=A2b8o6oty9GzpUi8zjhclZWoYQFpT6qjrpjYSARikkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nADncNqO72Pn1/py5FqzMU1ONtDv0Gri7IE2mo+VJzkkPO2S8tRlNSeSyf2qu4mjF
         px+5NyL8XWOeGearzT52XYVz1dIqjcvn2qyJQWoHeCXMeETDJQUuKlnmLOmNCPVr8q
         TuUUJinRk1T8jYIW2J5q9IIXhN+3sH+OCrrapr4oHHB6Wy5lGdPOHn2cBuDDBe4nrI
         nnSG1+GwoJyChQKoo2NW366BUhawaizfNr46+U4iD937YdfKX3vjFmi/4K7b7PUMn3
         57e+g7rEaxjUo3uCYH6psRVc3b5Ud+SWmj95bxNOEn0JFCY8Q+LOKLj3xdV4mgcX4h
         mdw6q/tR0j1Aw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0b4lCwzhd1;
        Fri, 27 Jan 2023 08:58:07 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 31/34] selftests: iommu: Use installed kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:52 -0500
Message-Id: <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
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
 tools/testing/selftests/iommu/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 7cb74d26f141..32c5fdfd0eef 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -I../../../../include/uapi/
-CFLAGS += -I../../../../include/
+CFLAGS += $(KHDR_INCLUDES)
 
 CFLAGS += -D_GNU_SOURCE
 
-- 
2.25.1

