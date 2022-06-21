Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7099F552C86
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbiFUIDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346733AbiFUIDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 04:03:14 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B2E3615F;
        Tue, 21 Jun 2022 01:03:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 428D71E80D50;
        Tue, 21 Jun 2022 16:03:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qIN_2rhMcT5i; Tue, 21 Jun 2022 16:03:08 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.97])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 565A71E80D2D;
        Tue, 21 Jun 2022 16:03:08 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] KVM: Fix a typo
Date:   Tue, 21 Jun 2022 16:01:28 +0800
Message-Id: <20220621080128.49513-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a typo in kvm_vm_elf_load. Change 'begining' to 'beginning'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 tools/testing/selftests/kvm/lib/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index 13e8e3dcf984..272ea7d39fb4 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -139,7 +139,7 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 		offset = hdr.e_phoff + (n1 * hdr.e_phentsize);
 		offset_rv = lseek(fd, offset, SEEK_SET);
 		TEST_ASSERT(offset_rv == offset,
-			"Failed to seek to begining of program header %u,\n"
+			"Failed to seek to beginning of program header %u,\n"
 			"  filename: %s\n"
 			"  rv: %jd errno: %i",
 			n1, filename, (intmax_t) offset_rv, errno);
-- 
2.25.1

