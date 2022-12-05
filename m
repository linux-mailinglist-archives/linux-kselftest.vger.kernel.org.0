Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD386424EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 09:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiLEIpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 03:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiLEIon (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 03:44:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F42101D6;
        Mon,  5 Dec 2022 00:44:42 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 140so10683475pfz.6;
        Mon, 05 Dec 2022 00:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfpI91j/Y0e7n9kSIKkB1eB3wJUrqLVm9u9ZvFip/8I=;
        b=VHG9BGw4G2xPBjZhyKDaIVmzz/QAFQ7pTzfNThhC9EAw3R6E9hL+pCGISJoH7Kz7eC
         2I2RPf1nH8+0duwh0RdsypagnCjxw+XFIlVu8cuxAS16n71Yr8pETszT7ulv9XX1I5qD
         IZiGDrk4Ldmb1G3zJQyFsOH90LoVGs0uFAaeq81cAWyZ92RZ0Ki6ECCkXprPRRIx0qwa
         pGkWE5f+CtAxa18zPZS4Vbgtz2rVfYJYPUdCiDr+CYR9lN1icqOJtb+x6u2RFibOhpXr
         PImnH+5qkcnb/ZAm7Is56SmkXjSvOVmnEFo8L/k6ECSo8hCm1nXmuQej0DhyHV/T19KG
         VPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfpI91j/Y0e7n9kSIKkB1eB3wJUrqLVm9u9ZvFip/8I=;
        b=0UQ71PIqg9MpHcry28Ksi9bNF32kpSKXx4xT+4y7Ob3LICTzurAIUzzZ5ri9+W3mJh
         /Oaj7wzXWRZ9JTOAXcX38xUD3fC2vblGE7aOP28UJDency1iTkCbTyH9J5pqM+2LI/h1
         1Ifajr0GFbVb3NOpNyCZhYvj7I6OVANpw9H5r3mzBeKbzoeCWDEOtk82afFJhHVnawP4
         o3kqm1KjU2NrAHKgyDuqE79PxPaYHOXTK8aO216tT2rLDgoZdavX0hETjNAnH3fJUSK/
         nNWdR0mOp2MYlCvUStoaXWG3m/HcvQeXe8uvvnEdw/IgBkADrERFuXaDavgJfplkrF7G
         RiAg==
X-Gm-Message-State: ANoB5pl12BdZPRNxrfyXqDMnm4vCM9sZGNNbQAOlyIMQyoA/04xWzeV+
        bB0m6zsL3LrYeNvmCGQrJmg=
X-Google-Smtp-Source: AA0mqf4c9Aw2+V+i2qnJjaDCHslItpgdR1g1SCuzHmCPiG/NYtL3k6ZxQnBTweH92Q4OiFFuyJIKfA==
X-Received: by 2002:a63:941:0:b0:478:a350:77ed with SMTP id 62-20020a630941000000b00478a35077edmr7255134pgj.417.1670229882404;
        Mon, 05 Dec 2022 00:44:42 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u11-20020a170902e80b00b0018996404dd5sm10045370plg.109.2022.12.05.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:44:41 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shuah Khan <shuah@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: Fix resource leaks
Date:   Mon,  5 Dec 2022 12:44:27 +0400
Message-Id: <20221205084429.570654-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In check_all_cpu_dscr_defaults, opendir() opens the directory stream.
Add missing closedir() in the error path to release it.

In check_cpu_dscr_default, open() creates an open file descriptor.
Add missing close() in the error path to release it.

Fixes: ebd5858c904b ("selftests/powerpc: Add test for all DSCR sysfs interfaces")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
index fbbdffdb2e5d..f20d1c166d1e 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
@@ -24,6 +24,7 @@ static int check_cpu_dscr_default(char *file, unsigned long val)
 	rc = read(fd, buf, sizeof(buf));
 	if (rc == -1) {
 		perror("read() failed");
+		close(fd);
 		return 1;
 	}
 	close(fd);
@@ -65,8 +66,10 @@ static int check_all_cpu_dscr_defaults(unsigned long val)
 		if (access(file, F_OK))
 			continue;
 
-		if (check_cpu_dscr_default(file, val))
+		if (check_cpu_dscr_default(file, val)) {
+			closedir(sysfs);
 			return 1;
+		}
 	}
 	closedir(sysfs);
 	return 0;
-- 
2.25.1

