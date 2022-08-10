Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996C058F2AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiHJTBe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHJTBc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 15:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4D242BFC
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660158085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/YE2gAhu9EL4OOArvFqPm/HOL4GSK6UAfvkJ6RahODA=;
        b=UcYMGtEgxWg5Kc+cJB0zgnC/XFd3WsFc7yPWPLuaRDbqxRRjVurRwNTphavsT3BDRk11fN
        h+58ZtnoIztVbMCRXyBYMekcBRQbbvFkPRDvi77fKaHjJGRhoHVmrB5VrmSMb2VNrIHI/U
        q51GgMZi2ak1ZHO7qWVj7V1ILv6Gy20=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-DovLTZR2NACIJfOxs8NVJw-1; Wed, 10 Aug 2022 15:01:22 -0400
X-MC-Unique: DovLTZR2NACIJfOxs8NVJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5FD7804191;
        Wed, 10 Aug 2022 19:01:21 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 922F92026D4C;
        Wed, 10 Aug 2022 19:01:21 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: kvm: fix compilation
Date:   Wed, 10 Aug 2022 15:01:21 -0400
Message-Id: <20220810190121.94084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit  49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target")
dropped from tools/testing/selftests/lib.mk the code related to KSFT_KHDR_INSTALL,
but in doing so it also dropped the definition of the ARCH variable.  The ARCH
variable is used in several subdirectories, but kvm/ is the only one of these
that was using KSFT_KHDR_INSTALL.

As a result, kvm selftests cannot be built anymore:

In file included from include/x86_64/vmx.h:12,
                 from x86_64/vmx_pmu_caps_test.c:18:
include/x86_64/processor.h:15:10: fatal error: asm/msr-index.h: No such file or directory
   15 | #include <asm/msr-index.h>
      |          ^~~~~~~~~~~~~~~~~

In file included from ../../../../tools/include/asm/atomic.h:6,
                 from ../../../../tools/include/linux/atomic.h:5,
                 from rseq_test.c:15:
../../../../tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10: fatal error: asm/cmpxchg.h: No such file or directory
   11 | #include <asm/cmpxchg.h>
      |          ^~~~~~~~~~~~~~~

Fix it by including the definition that was present in lib.mk.

Fixes: 49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target")
Cc: Guillaume Tucker <guillaume.tucker@collabora.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 89c9a8c52c5f..4c122f1b1737 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -4,6 +4,8 @@ include ../../../build/Build.include
 all:
 
 top_srcdir = ../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH            ?= $(SUBARCH)
 
 # For cross-builds to work, UNAME_M has to map to ARCH and arch specific
 # directories and targets in this Makefile. "uname -m" doesn't map to
-- 
2.31.1

