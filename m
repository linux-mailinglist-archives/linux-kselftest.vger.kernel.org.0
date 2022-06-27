Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2BE55CC83
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiF0IOo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiF0IOl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 04:14:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C82626A;
        Mon, 27 Jun 2022 01:14:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so2561626wmi.0;
        Mon, 27 Jun 2022 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WyN53yBSmQaV4TeUGBbUPb+3S/pfbZP5il80wSTCxhM=;
        b=c+gNmopgqqlXia7kaKocEy4i9B2JPmOowTmB2blMf2xrRncGGgUl8gpCeBf0H40Oz7
         +QHISV7kgnDatz4jww2TjO0zaODQGGrqkhuXjSLcKRMYasEIElykfijvIMc/gYGsHaC6
         IecFOHQqcpNEWQOHndfnNf4TBik1nBl6wd12fAH3EupB425kxQZP4I/JvYwL6NII11oa
         l0psqXDa/PKcS7tj5LpRNDl2Paa5p+yatSZGjHJTSrXlV7T5SFnrpddlSGCUFH7MUGhH
         47cLSdhb8/7s/11xDOVl9v3nC1s/lpPSPUSGlCxwfxXq/f8M/VNX0BEgogrO39rmDbTu
         MyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WyN53yBSmQaV4TeUGBbUPb+3S/pfbZP5il80wSTCxhM=;
        b=UEvKK42+cTWblQ84GZbNZ0+LNednnaA/zq7eFwBbZI3a0sidYkA0X4oQGVEz2C7y8N
         rE3fqpS/aNahj3cY8onnOVNoKQOWtv9Ef7iU0q0xPeFRHdgjUS8Oh2G2yNxmDPMjwgSi
         WbtH4Wgy9Y2dqGruHzNpXQmMLKI3V4xLWC/Jw0wDd61MsT0IQSYiZlTFeI+Tzw8UG+p8
         k4r64hQ57fCu4Ftq9GkcXsPknVe1aNf/NhYaWbM9gzivKwIqxckpRHeaqGL+XPUIObSx
         Mtrw7GX60YiYcF6WDzkThHbU9ua6Hm2/qhpvFFux40nAJaRGHKJy11SXunI5+9pSn+6X
         ZhRA==
X-Gm-Message-State: AJIora84qIHoXZsK5O++ucr/zt9EKd7PFWamh6k6J/BgYye0hwj+YZi1
        euTBVd2WsMAuka0067D7oZE=
X-Google-Smtp-Source: AGRyM1sceMx/DaP27aAYpPGx8T4w604aPmcuj3WhO/jldAzYHXK1NMmX4D+KDMta7QlEXFljLyTfhA==
X-Received: by 2002:a05:600c:2e14:b0:3a0:3ba0:143c with SMTP id o20-20020a05600c2e1400b003a03ba0143cmr17497223wmf.99.1656317678991;
        Mon, 27 Jun 2022 01:14:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm11569623wrr.63.2022.06.27.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:14:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "miliseconds" -> "milliseconds"
Date:   Mon, 27 Jun 2022 09:14:37 +0100
Message-Id: <20220627081437.45732-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

There is a spelling mistake in the -p option help text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index cc6421716400..58876ec4ee51 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -218,7 +218,7 @@ static void help(char *name)
 	puts("");
 	printf("usage: %s [-h] [-p period_ms] [-t token]\n", name);
 	puts("");
-	printf(" -p: The NX reclaim period in miliseconds.\n");
+	printf(" -p: The NX reclaim period in milliseconds.\n");
 	printf(" -t: The magic token to indicate environment setup is done.\n");
 	printf(" -r: The test has reboot permissions and can disable NX huge pages.\n");
 	puts("");
-- 
2.35.3

