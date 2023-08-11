Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22A077988C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjHKU2T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjHKU2S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:28:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76718E;
        Fri, 11 Aug 2023 13:28:17 -0700 (PDT)
X-QQ-mid: bizesmtp75t1691785691t4yqicvr
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:28:10 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: znfcQSa1hKbJ9heHmmVzurJmSlJJLoeDwqs0FEaF3zhu869c7ogKiel1aVx+X
        Kv+pwbFmZDvH0FSS9ijtxRM7IAWCdtyurnTuBb3lN033Z3QL4VtR0tqXqIclwSM0fX/3w9a
        N0t3GxnssBOW0NugqPIo+KahA8ePl/ObcHMx9ZmrS4annemGnwR1xFeOJrigsBEn3EuD+J/
        dKW/i7CFRP+lNxzRfpODQhLnRe2pRUBQn62JrIufoGtGeqX+2ee/8zcQ8ELY+IhizaouPRP
        DmplbYpZ4Bh6I7pSABB3oQGuTa6nfJ0itfpigF+w2qHZzm1IOBUjfhr5wg4EVM+XA1Z8gTT
        VlQNQPbriL6c4ZA7YU1Dct30ciRce0GYcZOIE4km3Q7xMfFUxD0T8aLVBl69g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2177922128315101133
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 1/7] selftests/nolibc: allow use x86_64 toolchain for i386
Date:   Sat, 12 Aug 2023 04:28:09 +0800
Message-Id: <d4127ef6f629d48928ea0bf60a131b3c09f5909a.1691783604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691783604.git.falcon@tinylab.org>
References: <cover.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows to share the same x86_64 toolchain for i386 architecture.

Pass '-m32' CFLAGS to tell x86_64 toolchains to generate i386 executable.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 76c387a20811..98d0a619d49d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -125,6 +125,7 @@ else
 Q=@
 endif
 
+CFLAGS_i386 = -m32
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
-- 
2.25.1

