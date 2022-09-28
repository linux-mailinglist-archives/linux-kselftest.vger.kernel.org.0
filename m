Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC2B5EE8AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiI1VvE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiI1Vuz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 17:50:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A68C010;
        Wed, 28 Sep 2022 14:50:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id iv17so9302407wmb.4;
        Wed, 28 Sep 2022 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zB9rqqvbjvVxpdcrL93MXJfKb/J0urKxQpQUWhHbEsc=;
        b=RNJzT7yVog3c8NvQJjfHBUbtrSy3WqfQCFoK5OjQ3C27DSH2m1sX9TOwybT2krTWCC
         pPl2oa29GVrL4XAXf9FubvdnmsfzTBW5mSZcOuYAjkqz1sNxEmKkn0AxxsIpDTtpZjfd
         Xv5IW3UD2vqw+9GF6jF6I9kFc3RUzI467D3Cr1hrHnlh8XvOV6F0SzGqUvoQ2dK1g+po
         6+kLpZr6G3Tf7xDV8zLVI61dUaPyqWePTM/sRyAuNcZ4Q751UnVK1+Nv9dVRUX780NyK
         3p91Saj4/nR+yUKUO86EZJX8b5ctvZk4YgVuzrJG1zv9pbYAN7bb1Zix7LYE0yx5TKK8
         UFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zB9rqqvbjvVxpdcrL93MXJfKb/J0urKxQpQUWhHbEsc=;
        b=B0PkUciUfBYSmA5pGJwym9Z8S5bVvwjYFaekWuhlStmM54hp5/VFZuSw2NAzFKyQQY
         3rmqdkzYSv8/8k5EdUP8yV15h/OtfINNGhy1GtiTFKImpPXl2Dg/CGjHPqjDrrzjXzsw
         pcd09htXGGRDV5Ceh9FkTIK3eI0JjGvLcbeYUTDA43u0uYNV3u85qlK4t744QsifgIhC
         oF0nX0pw+ouCrt0UlRK52qFMrWlD7pcvg9BqwCk8DmYDFKb5e30Wehp8g62QAbmDjZQD
         Qd9l8GU975ayZcoaOrqv7FgW7DpQrzN3kxKVdKkNGRPz5NCayZN4rvqCdYGm8TYGDuBZ
         Ewtw==
X-Gm-Message-State: ACrzQf1jUboq4CoEgDxIfEF6hEMjzoURCFp+kFUeXYu41+tqX8sNAY5G
        MziEH0hlBgwHxtSwhlu8LAE=
X-Google-Smtp-Source: AMsMyM6j5QBbGC2iAuhe51N1wLpquPlgnW5/oXFPFauihkffWdlUV2BgwefBIs/W/0nlGYvFIk4FtQ==
X-Received: by 2002:a05:600c:4352:b0:3b4:84c0:2006 with SMTP id r18-20020a05600c435200b003b484c02006mr34776wme.205.1664401852657;
        Wed, 28 Sep 2022 14:50:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c42c100b003b3401f1e24sm2579686wme.28.2022.09.28.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:50:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        David Matlack <dmatlack@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix spelling mistake "miliseconds" -> "milliseconds"
Date:   Wed, 28 Sep 2022 22:50:51 +0100
Message-Id: <20220928215051.65632-1-colin.i.king@gmail.com>
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

There is a spelling mistake in some help text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index e19933ea34ca..62827d121c4f 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -211,7 +211,7 @@ static void help(char *name)
 	puts("");
 	printf("usage: %s [-h] [-p period_ms] [-t token]\n", name);
 	puts("");
-	printf(" -p: The NX reclaim period in miliseconds.\n");
+	printf(" -p: The NX reclaim period in milliseconds.\n");
 	printf(" -t: The magic token to indicate environment setup is done.\n");
 	printf(" -r: The test has reboot permissions and can disable NX huge pages.\n");
 	puts("");
-- 
2.37.1

