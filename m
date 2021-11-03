Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9493744491C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 20:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKCTmF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 15:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhKCTmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 15:42:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82747C061714
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 12:39:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i3so7344813lfu.4
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xiozs0LD/qCiuH2g73QvKrjdH/BKsUzCKCin0QnJksg=;
        b=yQoEgMpSMf/aD308JQxNV2TSpcdZ2eyGfazGExV5JJD22owh3+wplOV9roslUnr/U/
         qAtH/xqGvWj9rZdmpOfh9qxolr/gvDgvipZTU1tKfMNMy3n8PgqeGGOC3xlHO6YpQfe+
         ceHE6XgzMAV3Oj5bcXisPW4ufSE31kStQ7pk7R3Pop+7564SikViYZlWWfa+zJL4JFse
         hqvdbWiu5I/yM6EYhwyUxQ1zd2gKXMOIRzFMU7YbKsn+A6VbMrPQyqtANTBTDnSRuFuQ
         3P3Z7mJxPdcActQxk6KBokHsGIJDvbICkwyfMdg3gIREpruxytTuEjDUnNe915x7S9ti
         Hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xiozs0LD/qCiuH2g73QvKrjdH/BKsUzCKCin0QnJksg=;
        b=lI5Gc84gfJLA1x6gRkoSXemW5MTlm5XzMc3Ffx2Ivz+hxtHz2TkvucOTq7+Pq/9AQi
         oDXORvf8uzPqT7jEr3VONm4MbQREwKZs9ucDBvb9YIrMFADH3VBkVVYPbkdJJhPke1HW
         ZcLhpEuLobKrtOD9beJDjStdmhINmf1sTBO3k7mdhHW/CENP4SO9h+h8AX/jR6RX9IrX
         g2SaRUtREB+hePml1+p+H+7gaI+NtOb74L8CWOVcQgQkan1obWc1iqhMrnhue8lFrN8d
         HtEh18Gs7QsO/m/JlGEZyhSE2tYcWXWgP2sty8Sn+Tb5fdRXWt2b45eL25n5vVHKEmul
         OdpQ==
X-Gm-Message-State: AOAM533x0D+Xxilos428ADvrupdcN5nOPIc9q5hwjAT4LOwQZoKSjxkP
        coGBQvPoJQxgV40U6+6HRNLNlg==
X-Google-Smtp-Source: ABdhPJxNUwP/1QQ0wCtd7iQ2XVGvcervJ2nt/JeNr/HOI1oo1drI2yLew/dUwVURjwfyuDyDTYzgow==
X-Received: by 2002:a05:6512:39c1:: with SMTP id k1mr43551899lfu.673.1635968364891;
        Wed, 03 Nov 2021 12:39:24 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id l26sm254559lfh.247.2021.11.03.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:39:24 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] selftests: exec: unused command-line-argument '-pie'
Date:   Wed,  3 Nov 2021 20:39:09 +0100
Message-Id: <20211103193909.3756095-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building selftests/exec with clang, makes clang warn about the
following:

clang -Wall -Wno-nonnull -D_GNU_SOURCE  -Wl,-z,max-page-size=0x200000 -pie -static load_address.c -o kselftest/exec/load_address_2097152
clang: warning: argument unused during compilation: '-pie' [-Wunused-command-line-argument]

Commit 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
tried to solve the issue, but when fixing the link error by adding '-static', the effect was that no pie binary was created, which makes the test case comletely pointless.
The gcc documentation states:

'-pie'
     Produce a dynamically linked position independent executable on
     targets that support it.  For predictable results, you must also
     specify the same set of options used for compilation ('-fpie',
     '-fPIE', or model suboptions) when you specify this linker option.

Add '-fPIE' to CFLAGS.

Cc: stable@vger.kernel.org # v5.10+
Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/exec/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index dd61118df66e..ed2c171ac083 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS = -Wall
+CFLAGS = -fPIE
+CFLAGS += -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
@@ -28,8 +29,8 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
 $(OUTPUT)/load_address_4096: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie $< -o $@
 $(OUTPUT)/load_address_2097152: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie $< -o $@
 $(OUTPUT)/load_address_16777216: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie $< -o $@
-- 
2.33.0

