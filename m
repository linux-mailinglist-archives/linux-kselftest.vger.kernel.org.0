Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2413F47073D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbhLJRhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhLJRhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:06 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269DC061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:31 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so10308256otg.4
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uh/Z9FDGr3qAAzEx+UXrnnj7QMHTF1v60adwa/WDWsE=;
        b=QvxE5B8BPn73UwnQSq14JPyQUVNaNUdzJIk09czGGhqGyoNq67Gtxk3CzYxR01hbht
         xtbSOHY32W87o9On8opuVK6zWIF+ANh7V/TPVN/bXzmOht/nwv8Fe+7n2kGi6lBbGAX0
         4aIaRtWSG8tsp1iF8NMv6Vq3Ozl9ooZRMar7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uh/Z9FDGr3qAAzEx+UXrnnj7QMHTF1v60adwa/WDWsE=;
        b=kVKVSLp+s6LuH04L5JMp/X/NeFSp+xyfFFzWUn5Nrcnxr2txSOJOHxKzgpAhm79elJ
         FPNR5DVAMOFIxiChLQGpn/zewXRLU7Z3UHSMeKssoDL1G8eCsDN7lNgJ7acfvc7FV2L0
         Mch2PyV3Xeq4AHupBdrpYzwhkBIW3tNgLCNuSQZ1IJ4W13f/69oCGzT0fHrPWUZPxMgN
         rR9me7Psn3rueo+aLLxhXdc8OGofJ6TNiKQXCR/CoFSjnrAfuBQBLhnXqoyXNrewGKZa
         pB1CT//ApVQsq0qGCw54f8tlLscfVnIVzKpP8dLZtdhn9385Ws3WRytDSV3TQ2J6xxaM
         513A==
X-Gm-Message-State: AOAM533U1W/o562XSBO/oRXP3EILGmCcMq0kGF7orSv6Fzx7x+x7vw86
        0C6Olwg6GtOI23jVF/5ydKUL2A==
X-Google-Smtp-Source: ABdhPJx4YSaRrvZVxbri/pWyy+QD/g1KBhe+XS0kuK/s8ZRC/VWuwyewAD6/3CwmIMT4Ovj4Oe4jIQ==
X-Received: by 2002:a9d:8c2:: with SMTP id 60mr12177010otf.174.1639157610565;
        Fri, 10 Dec 2021 09:33:30 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:30 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 05/12] selftests/ir: remove ARRAY_SIZE define from ir_loopback.c
Date:   Fri, 10 Dec 2021 10:33:15 -0700
Message-Id: <019379a12759bf5b3f14cf66c5e8742cc71bced3.1639156389.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1639156389.git.skhan@linuxfoundation.org>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ARRAY_SIZE is defined in several selftests. Remove definitions from
individual test files and include header file for the define instead.
ARRAY_SIZE define is added in a separate patch to prepare for this
change.

Remove ARRAY_SIZE from ir_loopback.c and pickup the one defined
in kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/ir/ir_loopback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index af7f9c7d59bc..06256c96df12 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -26,7 +26,6 @@
 #include "../kselftest.h"
 
 #define TEST_SCANCODES	10
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define SYSFS_PATH_MAX 256
 #define DNAME_PATH_MAX 256
 
-- 
2.32.0

