Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AFE67E779
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjA0N6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjA0N62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:28 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94BF22A2D;
        Fri, 27 Jan 2023 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827887;
        bh=6EmQnswFj6lYa3iuQ9jXx4tuzOMzQcsG7VTPpMJ0uK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egGwYK11B2go2UrPsxHEmiyF+t/D82frZQ0me91eIRFDS45amBgD1+KWoOW6mCkcs
         DNcv3CHhYXh8e2yjKbr+CX5xhIMYMic6+lz0/6ulUAwBhrPoAUjg4ZdeDXXznD4glL
         FWl3u7+JEdDRIAx+dkuNgS9CyzUbyQAkG7gfPHai+OGAe6zk7eRDEmQHbyRzBVciTu
         It14tq5mEu4BbS3qJ/HNJbkQCgllavQMPnCaXseiV4rx/CoKHI+CgVqJVBTDF79LFk
         mvE9p3DFKANvMbcdmQ076hfMjDm3vu3kPQSEqBk/VJttmGpz7Y2qXDuLugqtYlNMAT
         WBaCIbLFkibjA==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0b3PlGzhd0;
        Fri, 27 Jan 2023 08:58:07 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 30/34] selftests: bpf docs: Use installed kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:51 -0500
Message-Id: <20230127135755.79929-31-mathieu.desnoyers@efficios.com>
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
 tools/testing/selftests/bpf/Makefile.docs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
index eb6a4fea8c79..0a538d873def 100644
--- a/tools/testing/selftests/bpf/Makefile.docs
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -44,7 +44,7 @@ RST2MAN_DEP := $(shell command -v rst2man 2>/dev/null)
 # $1 - target for scripts/bpf_doc.py
 # $2 - man page section to generate the troff file
 define DOCS_RULES =
-$(OUTPUT)bpf-$1.rst: ../../../../include/uapi/linux/bpf.h
+$(OUTPUT)bpf-$1.rst: $(KHDR_INCLUDES)/linux/bpf.h
 	$$(QUIET_GEN)../../../../scripts/bpf_doc.py $1 \
 		--filename $$< > $$@
 
-- 
2.25.1

