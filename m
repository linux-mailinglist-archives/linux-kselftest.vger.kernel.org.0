Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7365EE854
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 23:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiI1VfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 17:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiI1VfD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 17:35:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711FE70E53;
        Wed, 28 Sep 2022 14:35:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n10so21657808wrw.12;
        Wed, 28 Sep 2022 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3onp3j8O2xht1Mn4NDZtmGhylm5ZELoh+VBn79WckKM=;
        b=hdoMugaoQMvP1hdqmaZ0Nt4Bj8W9qu3RhmgcUzMzot1DmZLmoqa2+vZoylgk3mggYB
         52onF5RKkVEmlVS+fUI6pa/3r82rnngpQZCIHUFPNgmsQ5UJXzO1ejBCYSR6gTNMpavZ
         LVFz6ejUPP+PxuON2zSrL0P1nWJPO1lCIV6XU+3nXxyXbgoJB8szOpRHZJES0nN7qrih
         3yjPTFj3bTPAJASYUxZsuW4GH39GS0dh+YHhs3vTyeUF6Sxzr7bL9ta0xHQ9PhUqUeb5
         kSnCqswb/ZUnfsDA9Y9G4BEcFyYnjo963DvhXTkHjCsLIrHigEZvWHZWsXBVudNJ8JqN
         dD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3onp3j8O2xht1Mn4NDZtmGhylm5ZELoh+VBn79WckKM=;
        b=JCx4V1jJG3i/QcCEbLnwC/IAY1VczGgowRnxTQDq/VUhXYfKz3hl7SdHSXESKTwJvv
         ZTd2wV76wefRri7VIlxIJGU2Dh8jSKvIg+BL2pi8xfLTXerXnnyk6XuD6j6tCpQNwQ0m
         jRgUB04YPku+SS1fzc80Y/Uz5jOk8Pu6/ZgRb8c73EQtqpnlUZQ/hsHvZXzy4H4cVcTt
         g1qi4le5GAv/Dt047xdtXbgDzMFo9h0xPT5Ngvh3NOtPwS4t5siMD+U74lhTLx9Rw3jZ
         gIfZ6ZzaNsUjSxDkEcK6p02uqti7E4DappdURWm3ePno4lpshqzd92qr/FmJPy0BrgMJ
         rP+Q==
X-Gm-Message-State: ACrzQf16Sx1n7LM5zyJYAK3y5KhloLjmyLRp8+WfzgLE4ix6/teWBRYJ
        ZYdiu5ouxdRbmKDkydI6k/s=
X-Google-Smtp-Source: AMsMyM7J1n538cpmBb5QEIDVGw+kZAFUdOZB41vWk5QER5yj5NJSPlHhJSWjHcx3bokkGA1GkoA9QQ==
X-Received: by 2002:a05:6000:1546:b0:22a:b31f:6c8d with SMTP id 6-20020a056000154600b0022ab31f6c8dmr23846315wry.275.1664400899966;
        Wed, 28 Sep 2022 14:34:59 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p16-20020adfe610000000b00225239d9265sm5269517wrm.74.2022.09.28.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:34:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix spelling mistake "begining" -> "beginning"
Date:   Wed, 28 Sep 2022 22:34:58 +0100
Message-Id: <20220928213458.64089-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in an asset message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/lib/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index 9f54c098d9d0..d71a9a5974de 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -138,7 +138,7 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 		offset = hdr.e_phoff + (n1 * hdr.e_phentsize);
 		offset_rv = lseek(fd, offset, SEEK_SET);
 		TEST_ASSERT(offset_rv == offset,
-			"Failed to seek to begining of program header %u,\n"
+			"Failed to seek to beginning of program header %u,\n"
 			"  filename: %s\n"
 			"  rv: %jd errno: %i",
 			n1, filename, (intmax_t) offset_rv, errno);
-- 
2.37.1

