Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC802B7096
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKQVBJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQVBJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:01:09 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A1C0617A6
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 13:01:09 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h16so12781407pgb.7
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AGpDbeOLIQYmDecfUyHhqhfmNTQyLQY1DSvv/8hSQSY=;
        b=LZZ72TSctc9SPaHEneVA0C8y9Do+GmeSSzCzpVAoV6LoS3pSkZ+6wLlWZ84VwB+6Vj
         SFKAYixXtdL931CiM3bCEacnRru2VZ7Nym0sHol4DIKXVffLRTm7IcgVsA59QvtSFGBb
         h+jEVAYEw7/2w/CGhFNoxWlpdpEWu6Zm23EyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AGpDbeOLIQYmDecfUyHhqhfmNTQyLQY1DSvv/8hSQSY=;
        b=I0/yxOhJRqjWw25+Une+/ZrmANCue9mDuqjkL2eX9EzTD4ea14JJF8v95RZTVm4htD
         ttx2HICxbEGqcryO1gMefilIQog1Wa/+mukSrQWj9mRb01HDwQuCRnjrIC5gyRxY6Z2W
         kIg88aNaXZ4KMQoOdVPE72dheVzK/g5dnbQWPUo50JHEr2xepp6QcawYjJsEzY5Kk4ep
         6wtTUEStwmmmjx65vrKQLsLqXVR4D1FAq7VuBPakJf7Mn+x7NhYUVuBnSDIpmOyoc/uI
         MxE4BAnDl+fWiayIqR0oSoUmOcGpYDBGjmW8Awv4a5bP5Jmuls8+8gVQLKjffyOLWZGc
         +YHA==
X-Gm-Message-State: AOAM530dXuxizVPE5CeRWVZjM6+CrnaE80ULltMUumbNcswdhjPmmKUf
        VkUF7xOT7ZnX7usdpDLVYffnsA==
X-Google-Smtp-Source: ABdhPJyf/AKFS14sUQ6AHtjxlqAaFb5lczA1nMZh7LMW08O/410rO9l4mbPTPxGg7on/J8wkmrvTJQ==
X-Received: by 2002:a62:1506:0:b029:18b:44dd:6325 with SMTP id 6-20020a6215060000b029018b44dd6325mr1462999pfv.30.1605646868521;
        Tue, 17 Nov 2020 13:01:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t36sm19772615pfg.55.2020.11.17.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:01:07 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/seccomp: powerpc: Fix typo in macro variable name
Date:   Tue, 17 Nov 2020 13:01:04 -0800
Message-Id: <20201117210104.1000661-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A typo sneaked into the powerpc selftest. Fix the name so it builds again.

Fixes: 46138329faea ("selftests/seccomp: powerpc: Fix seccomp return value testing")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 76c458055c54..26c72f2b61b1 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1758,10 +1758,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 		 * and the code is stored as a positive value.	\
 		 */						\
 		if (_result < 0) {				\
-			SYSCALL_RET(_regs) = -result;		\
+			SYSCALL_RET(_regs) = -_result;		\
 			(_regs).ccr |= 0x10000000;		\
 		} else {					\
-			SYSCALL_RET(_regs) = result;		\
+			SYSCALL_RET(_regs) = _result;		\
 			(_regs).ccr &= ~0x10000000;		\
 		}						\
 	} while (0)
-- 
2.25.1

