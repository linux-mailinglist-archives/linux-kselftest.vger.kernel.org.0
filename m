Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16714E603
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 00:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgA3XIu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 18:08:50 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43172 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgA3XIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 18:08:47 -0500
Received: by mail-pl1-f201.google.com with SMTP id n17so2613664plp.10
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2020 15:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dCX2LQDaoIcwFmYSq3cgmAkx+Exp0YNCPmOsw4OCxis=;
        b=Cea+74kKLR/GteXq64Op60MuNDLPdMizqbgVfNpoWkuF8hmEB2KWidlL87tYLsXrua
         8Xzbo2dCO77srQ679vBOopPPaT5k/SDDfLFgk2PVYP32VYXEliWcHSPQQvW7RJouxHAe
         hc+sUOuQ6TRmwjFRtbnmDP2UOQJ2LzmbdTH38wKl5fTpIu7RcFxSIOf2vAfgqu8CZAVW
         GLEzOaHOLVt2EVc2azlbEU9baY7XraTtjjWlZ/jKsLTm/MLozD7uXkqirkr8AYc/6GXF
         us3u/wuW2oRnrheLqJLro/pS7keuZISgD+5hxQQ9fLdo+8fcCY/HdMmki7Y+kyw+/l1K
         d+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dCX2LQDaoIcwFmYSq3cgmAkx+Exp0YNCPmOsw4OCxis=;
        b=ZN9odSi/enVegQjA1TVvENe1QEooePK6JtiJPV8tNqMj9kpEOD4ugF4ldawpzD0IIK
         05785VCJ4ORUgGRQ1CnieQMdfGBERMbdlpv9P6UnfpNIn08aRtgp4FQADBNB7aw6XZPi
         soE8cnqe5HPxGd+VQ/lhUdujNH+MOV8w/bIIse4hHiFzkB4a2AwVMIk3T8o6IplKzGnH
         ulYBtEsouSpgFvTxm4BVNb9SuZKvS4SSzVp8IuC10p7Kv4PEt62k9bg7arediyZ6jWoC
         T+lZKKcTJZqwecIGURsuFmXaHCbagl07ZamcigL0JdLK3xuzTppvwURt4ZX/j+pqRh32
         iumA==
X-Gm-Message-State: APjAAAWpiUmKCRTu1ApijasA/R2xr+VCUIx9Tqr+bG3Tjg/0KXxEqwLO
        h0dUTsfRIMpiisZ8FYEmKTgd6ilIgNqXNu7PAP7BSw==
X-Google-Smtp-Source: APXvYqx+2ri6MUmVYy6ptSJgWKOGMVZfjLQX0JTmgMuADBux9koL0KUnaGALzsStF3tXii//z0M3FTNmV1ggHaNXMBaSXw==
X-Received: by 2002:a63:78cf:: with SMTP id t198mr6898466pgc.287.1580425727146;
 Thu, 30 Jan 2020 15:08:47 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:12 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
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

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e03..522fd8bdec949 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2054,6 +2054,13 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running tests.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.25.0.341.g760bfbb309-goog

