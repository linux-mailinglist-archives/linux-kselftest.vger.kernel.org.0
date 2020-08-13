Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F824402E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHMU5e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgHMU5e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 16:57:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C5C061383;
        Thu, 13 Aug 2020 13:57:34 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b17so8745681ion.7;
        Thu, 13 Aug 2020 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/ASPTS2Ee55jSURHALLk5ixEglfeB12zyqYUwDPixY=;
        b=FicCNtgk9br8P0aDJP+IkrIIj/ykK3OW4UarPWg55HNmL6X0l4yBUJeGk+5s3Acj5d
         /xRUYLZSs5YL86NqzVWmlKfhtw3TzJ5+236ebO+fozx06CDEO0MIV08O7RUizOHUazCY
         MbBKO0npIVzb3CQszRycq83Vv1N1vBIAE/Xm9xmqaWVkdRAbHVYnM+bxCLtB1wEZKkUz
         UlfzR/D1uzy58h7cSgxQmc+CcOpZSD+BbStz8gjuySxnvN3M6czi+8PCHq3k7LHLv4yM
         ShuPAOw2rot3GIGJMkIT2ucJQqBOcdAkznSiXbcen4JMbvL+nVL8dJdo380wjEJf+kFn
         4NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/ASPTS2Ee55jSURHALLk5ixEglfeB12zyqYUwDPixY=;
        b=dWRcTY+rMXTvsM4JU+OAVPFdVQUwV9RqLDRib4+mYHf3Rj09iL0VO1GgK2U0XNgJsR
         vsvsxuVdhfQHP0S0djbypFdVa5fWB4/RRH2M6Ekw71n7nBZEQ6EVdHWTvG4bXcOzlPcD
         nGrJ/LeM2wU42qXa+Dp1frd1GGLFcrhJBUMxIaoU3zyQMCvPuU17E66E5e5WMRYUJawH
         T8bFUMcxuiw321dYPDaCbQ1arjjlKz046yfnRcgx8olMQUCHoqMhd/5fGbt58sYkH+sh
         oQbCUely01Pph+YsiDa/g0jSFGypr9TAPNsUCEHWOLBqZDw1+QcnC5v+ZAzJ0I1ovI52
         D4/Q==
X-Gm-Message-State: AOAM533Wr2M7LAGeVTzeUvkwVOJ87OlwaTA+QD/dLkuuKuLEPbOInoU+
        3EnKq8s+3ZQipuNUMZn8bHA=
X-Google-Smtp-Source: ABdhPJwQTeRwrYnJMO8lXxIeQcSevKEfdwVrHpBE4+C5UU9Incq/oGqGH0rhsgSy0tEvO7Ia+E5FhQ==
X-Received: by 2002:a02:8384:: with SMTP id z4mr7069563jag.121.1597352253446;
        Thu, 13 Aug 2020 13:57:33 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s3sm3148603iol.49.2020.08.13.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 13:57:33 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     urielguajardo@google.com, akpm@linux-foundation.org,
        keescook@chromium.org, rdunlap@infradead.org,
        herbert@gondor.apana.org.au, christian.brauner@ubuntu.com,
        peterz@infradead.org, ardb@kernel.og, arnd@arndb.de,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Uriel Guajardo <urielguajardojr@gmail.com>
Subject: [PATCH 2/2] kunit: ubsan integration
Date:   Thu, 13 Aug 2020 20:57:22 +0000
Message-Id: <20200813205722.1384108-2-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200813205722.1384108-1-urielguajardojr@gmail.com>
References: <20200813205722.1384108-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
whenever it reports undefined behavior.

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 lib/ubsan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index cb9af3f6b77e..1460e2c828c8 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <kunit/test.h>
 
 #include "ubsan.h"
 
@@ -137,6 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 {
 	current->in_ubsan++;
 
+	kunit_fail_current_test();
 	pr_err("========================================"
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
-- 
2.28.0.163.g6104cc2f0b6-goog

