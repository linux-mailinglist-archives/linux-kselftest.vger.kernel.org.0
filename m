Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663EF6E459E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDQKuX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 06:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQKuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E33A82;
        Mon, 17 Apr 2023 03:49:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so834728f8f.3;
        Mon, 17 Apr 2023 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681728465; x=1684320465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aObB3gJrc6daE2Ub3D70WFvZc+MAMO7dkXaerkKuI3s=;
        b=RXtnXeZZXh+VYZJiHO88aK0CSgdCnLOoMdEuRCkY9HvdqoQOpy2yOdn2VbYysVhQEo
         Qp3qQWty1Awi//NPEO2vjwxvnTunFZEh9JGMiPRZUbbo91duK52ft167gIsvd4SoSAZP
         g2+UMw+9aEMMIuHjthxFdI4y/ffXjJtbbCHQaycZsrxO9XubnFo5FXbb92ZqW85yXFzT
         XYIZd0AAJkP+bCshzIFAZ5k0U5ek3spTLDa26+TcErtP1d2/KveQe5VcKXD4YClmjZpe
         CBhTG0XqkXen+uqzAifVeYjxEFJxVEVJ5f6nVylsLEJXv6u2KQehZmTwTVN7yC0Ayy3s
         cAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681728465; x=1684320465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aObB3gJrc6daE2Ub3D70WFvZc+MAMO7dkXaerkKuI3s=;
        b=elJqsQ0SpPyuu0zpbttoYly9NrPpRK8SzOJh9SU/pWth8FJELhnLGIn4qGmfK39+zm
         oy1CE1qIbb4vnH6ZrzWhFPdhZGwsacgBm/MNUDhRsOmm81yZPK+t6T9hHWfjp0JfXm7p
         wf6N4NuyfdkjufUkByFQIDsDb7YygVHUE7KwhO12QAM2E/EYvEQ9cw109I+KqUb62Lkm
         VUHqA8odmP+FnhBw0lXdBfXeb80l8owNPqIiOuU/YhhLh98ColNOvKDXUnhhN0wXluY7
         3iM/kJofcflwsZn0EXs4mDwUtNN7PQfuyosD7uzDd2jEsnH7m0tUsKOKVrUktm1MqHPO
         lCSQ==
X-Gm-Message-State: AAQBX9eA6lbuctPyrlcjybttNpmg/l9cbQyjSU2BBsfr3q4vwDSUib6R
        fehvYlDdXMJUPZ8lSbIQeug=
X-Google-Smtp-Source: AKy350Z7+uQlEP1XtKOD7AoJ+k93bSPkZQhD/9C7egiwqE5TiutJFDy9XPkoBQK2c265G8aUDx1Rbw==
X-Received: by 2002:adf:ce12:0:b0:2ef:b137:37fe with SMTP id p18-20020adfce12000000b002efb13737femr4862686wrn.0.1681728464622;
        Mon, 17 Apr 2023 03:47:44 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d43cb000000b002f490a0cd1asm10138510wrr.92.2023.04.17.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:47:44 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined
Date:   Mon, 17 Apr 2023 11:47:43 +0100
Message-Id: <20230417104743.30018-1-colin.i.king@gmail.com>
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

In the unlikely case that CLOCK_REALTIME is not defined, variable ret is
not initialized and further accumulation of return values to ret can leave
ret in an undefined state. Fix this by initialized ret to zero and changing
the assignment of ret to an accumulation for the CLOCK_REALTIME case.

Fixes: 03f55c7952c9 ("kselftest: Extend vDSO selftest to clock_getres")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 15dcee16ff72..38d46a8bf7cb 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -84,12 +84,12 @@ static inline int vdso_test_clock(unsigned int clock_id)
 
 int main(int argc, char **argv)
 {
-	int ret;
+	int ret = 0;
 
 #if _POSIX_TIMERS > 0
 
 #ifdef CLOCK_REALTIME
-	ret = vdso_test_clock(CLOCK_REALTIME);
+	ret += vdso_test_clock(CLOCK_REALTIME);
 #endif
 
 #ifdef CLOCK_BOOTTIME
-- 
2.30.2

