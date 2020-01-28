Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1514B03A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2020 08:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgA1HUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jan 2020 02:20:21 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:35169 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgA1HUV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jan 2020 02:20:21 -0500
Received: by mail-pj1-f74.google.com with SMTP id d3so969219pjl.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2020 23:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GWHGFk+tfCHvu/qeG8h3yhiMIdqay1deL3woZTxVWJc=;
        b=Fmsd/wxUUyxkz1Z6qM0r0RkypL0fOEHozNsNaZpYgWUn5bll19sW638dyuJWud6WFE
         mkQXUTsINjW8p/0aIJ9Px3JJnE0tLlxui4Ay2uXa4EAnUjgJqyXJ127ebWMJgyugOwUe
         HKaz+i/1o7x2R3F/+KoD3rZft6qDJ7sJpzE73MrvYoPk/YEIDLLtHA2H1V46OZKf5JFE
         D8+CUicqNyWC1f7beM4bEicUD2XIYC0yfRKT/4fkVQc1NuINeHE+s+lbvUL3Fc5UiIny
         AxqghwkUQciLsKR60QKfaPCbCi3/uhAClhQMgjbMIMVgXtFJ/XcE4Ub26q4LhGU7qOcE
         fPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GWHGFk+tfCHvu/qeG8h3yhiMIdqay1deL3woZTxVWJc=;
        b=eopuVIZn4KYDq+hu08eKw3LPlAJyxgniwIUe10/lm7e8XUuI9rFDo34fwSL7Hj3jYV
         aNEMG1t6fKuUernIg/ivKx6scVUT10JdWD3XfLUSC1+xEkhYXA3MtdJRbyEtUACCFgut
         wSL5mQw9jRMmYtt7zuVvjMcAYqk+W/lnXKXetGefKWYP/nPp+W9XZTcm03H3EqKsvVbe
         mIFjVcupmsm0bKSBSKD2GVtlvL/WriGshWM4QCJNQ83vvBKdaDXnQd2GfQO/v3YQN6Mv
         bBnUd01YrgljgS9EIayMmS0eWdZHi573I7LrNfkhC1gR4XmSE/GrFs1pYVe8vyh7XKjA
         Ppkw==
X-Gm-Message-State: APjAAAWSzhQw5dK3FztI+tO0y21Hr6XD49g3iHlQw5AQ4gs/198E3JF5
        JOycw+Vhgg2RpAzdhaU4LgwUAsxEAysQnHBnk5qSrA==
X-Google-Smtp-Source: APXvYqypywQG2gYZge4fgQ89ZnPWWXjpZ4aK4qljq8Qu2reaQNXfA+YsY3M5yDRXuo44nsf6Cp429z3ZpkmkTuhetTXF2A==
X-Received: by 2002:a63:2cd6:: with SMTP id s205mr18113288pgs.258.1580196020528;
 Mon, 27 Jan 2020 23:20:20 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:19:57 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 2/7] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 7145ce6999822..eab9ceb450efd 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.25.0.341.g760bfbb309-goog

