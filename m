Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6CE713052
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 01:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjEZXVr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZXVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 19:21:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6248313D;
        Fri, 26 May 2023 16:21:46 -0700 (PDT)
Received: from AZSP-HARGAR-02.corp.microsoft.com (unknown [131.107.147.31])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5AE120FBE82;
        Fri, 26 May 2023 16:21:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5AE120FBE82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685143305;
        bh=KeAv1SsqvhLKQ2kZnNqph3bIRr9A1qo0PI6I0BS1voc=;
        h=From:To:Cc:Subject:Date:From;
        b=PxtxmllNN4RsQNyL/pejoVLcQDB1rdI//xsA0z8SvBioWh2WnmI/z8alJJ56JveH2
         gjen/ISdEsErk5VlcSU4u+q6tTwx2Bm5jhy+krQgX5EnsSdYPeO/GsMF67cjPKz7Ey
         OLY8dWEf7iJVb65CNeVSiX0Oqwg71TpEvLxDz4cc=
From:   Hardik Garg <hargar@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     shuah@kernel.org, jeffxu@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        code@tyhicks.com, niyelchu@linux.microsoft.com
Subject: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown type name build failure
Date:   Fri, 26 May 2023 16:21:36 -0700
Message-Id: <20230526232136.255244-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Partially backport v6.3 commit 11f75a01448f ("selftests/memfd: add
tests for MFD_NOEXEC_SEAL MFD_EXEC") to fix an unknown type name 
build error.
In some systems, the __u64 typedef is not present due to differences
in system headers, causing compilation errors like this one:

fuse_test.c:64:8: error: unknown type name '__u64'
   64 | static __u64 mfd_assert_get_seals(int fd)

This header includes the  __u64 typedef which increases the
likelihood of successful compilation on a wider variety of systems.

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
 tools/testing/selftests/memfd/fuse_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index be675002f918..93798c8c5d54 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -22,6 +22,7 @@
 #include <linux/falloc.h>
 #include <fcntl.h>
 #include <linux/memfd.h>
+#include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.25.1

