Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A76E1DD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 10:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDNIIV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDNIIU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 04:08:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3411FF5;
        Fri, 14 Apr 2023 01:08:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e16so3343009wra.6;
        Fri, 14 Apr 2023 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681459693; x=1684051693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDBBNQ9/LR6u7uLMX4fVcZ0wYs0Li+YPOJWE6r0SuhM=;
        b=UQkO8HakYq+zhijR1gMsYIE01N5NNjSTU801UOBrKrV2fAp6uWsDCUE+Lu4XMOgquF
         pq7M76XfFoPBCfYpMOM5ktmkNQGFc2vz6l5NudFBysI6FK+5nZ1o35MY59vpW8Jk9NbT
         m9oKWXBhSGHLlDDaOnoKFVJq1zG7aI8ZktTNXdajJ7zJvnqfPqO7CFrxyjK25Y+uCL4e
         ofaBHa/icPZsDyrXrWDeU0t8mprQiSfQduwO7AWHtSdQ5qqpUscCH3OXGLdoYAnXaNLF
         SKlfmAZc0ySWPzrRra6IJdRNCI3TigexPAkSXiDPzth+FRN/e5rPceBNcYlbOZ/9d9bl
         P5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681459693; x=1684051693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDBBNQ9/LR6u7uLMX4fVcZ0wYs0Li+YPOJWE6r0SuhM=;
        b=YEWUX/4ftWuUall6i/5hotz1cSW7nwqTR6bQUDiTjAAhcBjs7ccI8DKwT/A/ffeKvL
         ZQMawNzoXlbO/3VWREpnnC2SMdnfEFHZXcfbGqTA9t0Rk4xIry8VYlep27tnwzWS9OOj
         mREGEdCjpYk8TidWzWxc0OZRqbW7La2lIvF/01xWknu0URroNASnqFPoQYlTbuqY33a6
         X+hWUi3wTXpCw1OSgJ40xCvC0yShef0XUBo6VdBvDyv1+tIPsgtmB8IowJgXTTbihons
         97PtOlalOrpF3fRdjowfFA2SHmh1DlOaMjBFfA6IJyGaFaRpX5MvvaEgeEzLnYOkjf7G
         nAyg==
X-Gm-Message-State: AAQBX9ej2K0q2EnyBEkgxKGVQaVETux5U2hTsxghzbLwtM47TqX44uvr
        HazMAkQXrePJtNP9QYGG2UXxR+z4iynEag==
X-Google-Smtp-Source: AKy350aAiBwRVGpNbd3P1Nn464f/JuJojSUOsLGSQlPtJVW+n+Xc/uj9d7y2jARJ5icJwx2jCse7/w==
X-Received: by 2002:a5d:69c2:0:b0:2f4:9004:e5d1 with SMTP id s2-20020a5d69c2000000b002f49004e5d1mr3332275wrw.67.1681459691088;
        Fri, 14 Apr 2023 01:08:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d60cd000000b002c54c9bd71fsm2937002wrt.93.2023.04.14.01.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 01:08:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "perrmited" -> "permitted"
Date:   Fri, 14 Apr 2023 09:08:09 +0100
Message-Id: <20230414080809.1678603-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a test report message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 898b30096c80..d4a0b504b1e0 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -731,7 +731,7 @@ void __vm_xsave_require_permission(uint64_t xfeature, const char *name)
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_GUEST_PERM, &bitmask);
 	TEST_ASSERT(rc == 0, "prctl(ARCH_GET_XCOMP_GUEST_PERM) error: %ld", rc);
 	TEST_ASSERT(bitmask & xfeature,
-		    "'%s' (0x%lx) not permitted after prctl(ARCH_REQ_XCOMP_GUEST_PERM) perrmited=0x%lx",
+		    "'%s' (0x%lx) not permitted after prctl(ARCH_REQ_XCOMP_GUEST_PERM) permitted=0x%lx",
 		    name, xfeature, bitmask);
 }
 
-- 
2.30.2

