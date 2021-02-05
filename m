Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904163118E8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhBFCtf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhBFCnX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:43:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDC9C08EDA0
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:53:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u14so5261782plf.4
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=t77+PuCigeZOcF53sLtwu0Du9UKFrCGhrRKsmy3L6C4=;
        b=oiw8Q6GYyKteToglNy7gdpC0BukBR+3yrtUTagUwTRT+aluXP2YhlzxIytogmMfWMz
         pzArK1ylL5HXFjdTLFlotXqZY3ynows31B902aEnpyEPk+H08PGdPDxET+4iFl+lt0/s
         TswcIShTwC3LkJzv1KNMd2STFuQp4+YYC0KoI9L6zuSbPypmTs6v1JzKbPPvkGWgm2J9
         rS8fVrV4dFfiEXSN0d3Hr7JafjATZru6O+grs5EgBOALzgNj6xF/Qh71AsH+bDSjgIUy
         WVm4fNEMn5LLeEEXwRU7lFKAIT9l0DY7LDVGP3DdhhUoIEpP4Xn8Cke/s+2x4kStFA/s
         LvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t77+PuCigeZOcF53sLtwu0Du9UKFrCGhrRKsmy3L6C4=;
        b=PnA/w9QGy85dBNI0fcYl40VAc7wDj6lqma/3+8JRILZ58ddV0FFGMrsuReaQFd9Pya
         uCL/f6qS0Zuf8pRP/PYUXAD7PGwSM52sgPv2ufnFtr99prZ3BcQdaDmOYeJfbUreGY06
         98Z4AuJNNlfy1oASoTer1OCd9ksKYI3O9viSeiYkm6cbolOnJGoeGU8xDWOnRXhiPQcY
         ttDkqAdtmeudtGPMINxOrhMBon//LLxZ+PVYzb3hfPwTsu1SUhVg/FbtV+kEX3W/lJMI
         mA3pel+5YYOt2lTN+22tJ95W5htZhNb7mH96L/GtRzC560q4ZghHAL1b4r8q5HwGiipZ
         Dj+Q==
X-Gm-Message-State: AOAM530R5JhEh9RQII3G5bvve3CyQVuK8BRmt44nOiFCbuX6Z2JYPYGx
        HLB7AQleHC0ixN5onYeohphsxyvTMeqQ5w==
X-Google-Smtp-Source: ABdhPJwUXTrySp7ZE4Eqsd+iiglqdwGlkHvNviLq7t8BzZfzBm3E2RtqKaaxIevIdIwPBBzGPCL9xi3H7rs3+g==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a17:902:52a:b029:da:989f:6c01 with SMTP
 id 39-20020a170902052ab02900da989f6c01mr5920868plf.45.1612569192975; Fri, 05
 Feb 2021 15:53:12 -0800 (PST)
Date:   Fri,  5 Feb 2021 15:53:02 -0800
In-Reply-To: <20210205235302.2022784-1-dlatypov@google.com>
Message-Id: <20210205235302.2022784-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210205235302.2022784-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 2/2] kunit: ubsan integration
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org,
        Uriel Guajardo <urielguajardo@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
whenever it reports undefined behavior.

When CONFIG_KUNIT=n, nothing is printed or even formatted, so this has
no behavioral impact outside of tests.

kunit_fail_current_test() effectively does a pr_err() as well, so
there's some slight duplication, but it also ensures an error is
recorded in the debugfs entry for the running KUnit test.

Print a shorter version of the message to make it less spammy.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/ubsan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index bec38c64d6a6..1ec7d6f1fe63 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <kunit/test-bug.h>
 
 #include "ubsan.h"
 
@@ -141,6 +142,8 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
 		loc->line & LINE_MASK, loc->column & COLUMN_MASK);
+
+	kunit_fail_current_test("%s in %s", reason, loc->file_name);
 }
 
 static void ubsan_epilogue(void)
-- 
2.30.0.478.g8a0d178c01-goog

