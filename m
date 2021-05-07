Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7150D376BCA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhEGVcg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 17:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhEGVcf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 17:32:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE475C06138A
        for <linux-kselftest@vger.kernel.org>; Fri,  7 May 2021 14:31:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v12-20020a25848c0000b02904f30b36aebfso11761027ybk.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 14:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5DPa33njFGODM0r0Dg+qyIbU0G92fi0irgnyucST/O4=;
        b=X9GN13+e2x8JDM2Z8/OuYhtw6AZDa/2+z3UYVYKOex9Oq5P6lyxFPwmq56cGN/soSO
         TzxS20QVcICzokHIaDlDnTPCPnKHFNTPEZzsxdCiBxAEY4wFolADbDSidnb+yqkPvS2U
         8VewV0fPRb1EJfxFKljC0J1zFI2tXMI0DIPc5EZy/CCovI9hYqUq6qchTQF8PRbOaiuT
         GQnbaLFRo2uYeWfGR3N8RIz+9rIarDNy4xdXaTvQq2NYbNV1fx0ciTawlzsDDyybzfdf
         4gRJCBvqtILP4tK93XxwOIr5svr5qQfUyUGuTVDJmjRHzBcskFMMGg+c67da0EsynLWx
         UxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5DPa33njFGODM0r0Dg+qyIbU0G92fi0irgnyucST/O4=;
        b=nEdVihnOhb4UOrGNmvKdk2Sdy8Oje4ZwWk3ukNn1PU2/Qu9DUloSBYNXGDUr96SAhR
         foWqqEqpC4hEVg7I0aytnwyBNXIC5Fdg2vXerzYgd7pUUZTOZLr0ED6835xYXO+m4dpn
         s7wKqICUYi7yQuT4Ts3jS9KCItumTihlZYylzM57O0CUMoMJRyzj6H2hhdGs9x9fCdlG
         svfUTnnpWLqqeG6Y4su1QXyRnL8RknBOGOK6w8CDJ01GiOF0AGv7HTNqQRBuI9R3hgk5
         tiO0zeFbOOtFIg5DVeSNVtnjAGtvQXwvKL0RqJ46lo8fIpU16Z/Y2KkdT9USf9l/gn+E
         hqOA==
X-Gm-Message-State: AOAM5325JN/Dv0dDEptpEo70arzEnPbprdKK8V2sgHXGn0QLE194nuk6
        6B6icaK/nb/MN7BK3sxwq7obP6dEFn3a2CjcOqosqQ==
X-Google-Smtp-Source: ABdhPJx6Z8Ge8VRoJW/bhowXGEkHF0Cr4aM1Ja19SHqjWGD4GaN5mxGEfcxngeGHUuDfKWsyzQwmPU/eKBQNfCEGDHdduw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:8b7:10d:a11b:ba0c])
 (user=brendanhiggins job=sendgmr) by 2002:a25:4014:: with SMTP id
 n20mr17009092yba.357.1620423093933; Fri, 07 May 2021 14:31:33 -0700 (PDT)
Date:   Fri,  7 May 2021 14:31:08 -0700
In-Reply-To: <20210507213110.155492-1-brendanhiggins@google.com>
Message-Id: <20210507213110.155492-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v1 2/4] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5bcc229d31e24..bfd64c01698ba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2244,6 +2244,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.31.1.607.g51e8a6a459-goog

