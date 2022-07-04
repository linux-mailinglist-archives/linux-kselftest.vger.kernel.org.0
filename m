Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB29565C3A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiGDQfx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiGDQfw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 12:35:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353DB1E8;
        Mon,  4 Jul 2022 09:35:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c13so5212322pla.6;
        Mon, 04 Jul 2022 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AD8ixGZqjFTlOvCOe5PAX+9HYaFuEMKi02Io7Jcboxc=;
        b=CO47x+R8nIkHofzEqj9jWOupJ4v74bNGiFHPr/Q0/hR+xeJYGpemeTX337v8knXTgk
         n2hT1hJ0g4ViGLzfibuyDNf8pltl6Sd7oQLhfM7AqHqIq7ymQzXKeX9WqY+s0v02GeEa
         BnP11c9GW5fDa1AO3v8TZx819xSRJ+Jc7+E93kBUQ7PaVsviXAJTlZglNRFa+aa1WXL4
         A9GQYwh2jHnzCC5kKJVQcZbmoxsgrVqKDuKdUn0nWArTTEXTu1yOjFN0Sch1goZZAwDV
         12aYa4fWdOzqpvOi6dD1Bg/fjq+48pbzOhEx81r48pNSoJjETjBrDEfB5EaBG9ctGaK1
         Z88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AD8ixGZqjFTlOvCOe5PAX+9HYaFuEMKi02Io7Jcboxc=;
        b=Mpduuq51y4wbjgiqIvDcQ95vkj3EqP2hJr9JAp8JD16bwBkCV4Iv5QHD5R8PwFKpV9
         kK46Bem3jlhhyk/28unyvMxKzAGsODnL/93wHpJ92d5HJNaFZS6rLpxb4qvGNvvjcJwR
         3+SaTparSRqycZWbrGPvr2bAnZsNEq1W5K5zed3cVejZ8IlQfZ3eW1aL5ghrLkczI1Lp
         MFzFvosscBh/dv100ngwPiDfh0fLxm7Z80OvmDAscNzMj42v5jQ5KH9QkWSJTCRyKZrT
         Lp+EYoxlbxUlc/gOGCuuR+sJDBoaMLHg6tMAtQURmYk8UggZmdFEq2CM1/F2sZwqLNmY
         No5A==
X-Gm-Message-State: AJIora8sZBfFwSeiB+zV6I1XlQZ/IGKxQJudAsW1P4XIEHzm6UZhgICk
        zo5GylidJcNrxzHBsf7aCuk=
X-Google-Smtp-Source: AGRyM1vp6jxwjFO/ukE3G90lZHLBQly3vuRUIt+Vbcrbc7YWkdfq1bXMkO1ECjbiaAQ0619Bkz4Amw==
X-Received: by 2002:a17:90a:e98d:b0:1ef:7863:b7d2 with SMTP id v13-20020a17090ae98d00b001ef7863b7d2mr14717536pjy.101.1656952551715;
        Mon, 04 Jul 2022 09:35:51 -0700 (PDT)
Received: from fedora.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id m6-20020a635806000000b0040c9213a414sm20457775pgb.46.2022.07.04.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:35:51 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        yang.zhong@intel.com, jmattson@google.com, peterx@redhat.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, dmatlack@google.com,
        vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/kvm: Add error messages before skipping tests in vm_xsave_req_perm()
Date:   Mon,  4 Jul 2022 22:05:38 +0530
Message-Id: <20220704163538.31165-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add messages in the checks that are performed before making a request
with ARCH_REQ_XCOMP_GUEST_PERM.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ead7011ee8f6..c74e846661b7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -643,11 +643,15 @@ void vm_xsave_req_perm(int bit)
 	if (rc == -1 && (errno == ENXIO || errno == EINVAL))
 		exit(KSFT_SKIP);
 	TEST_ASSERT(rc == 0, "KVM_GET_DEVICE_ATTR(0, KVM_X86_XCOMP_GUEST_SUPP) error: %ld", rc);
-	if (!(bitmask & (1ULL << bit)))
+	if (!(bitmask & (1ULL << bit))) {
+		print_skip("Userspace address of attr data is blank");
 		exit(KSFT_SKIP);
+	}
 
-	if (!is_xfd_supported())
+	if (!is_xfd_supported()) {
+		print_skip("XFD is not supported");
 		exit(KSFT_SKIP);
+	}
 
 	rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_GUEST_PERM, bit);
 
-- 
2.36.1

