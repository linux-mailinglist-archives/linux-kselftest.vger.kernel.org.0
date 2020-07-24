Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B6022D0BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGXVhG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgGXVg5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85AEC08C5C0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so6147798pgk.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snum0LDOOmwoCERcfxqLkgilyaEMJiIllHC/Y59Q/IE=;
        b=T2ncoDQLQlOZzMXhnR0wFJRriW5h7nmKcGWHusRRfC7lI6yGOzgH/DtKKi67QbPNfy
         mdxfj7DWeUjM2aNaUl5ZK4KoGKdFIO/PdlpbUzEaOHCqTWOHepJ0oX+ezARdf2+ejrjx
         BlfJZMuYgHFWSDVX+oY1w6U5ZgZe3dU7X2z14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snum0LDOOmwoCERcfxqLkgilyaEMJiIllHC/Y59Q/IE=;
        b=lAe/hdd4Sr/J937+1kDvZeVAtHlyJm8+MC4a/qI7k5/p/pOf1LB5BuzXni7bcCOw45
         f+Llwf8hUrwCadURjc9QzeL8nv+F+etQOzXi3yyKBEf59Z/2BDaShEvPhSXhykaxjXBN
         GODo2862ZRt9FRjdm5tsAFISVIiAofSIDlxwKtZRk/u4+Iw63CQJgbUCpZYWP6XxaiVe
         2tYOPyXcvqRceaKUfW1aGTzkpfOH9DhLLsLr5x9zO1+J2O6srh74VzFYKG7SJySuxLCJ
         0ZGUtxp/FDxdjwKmu0qgJMH8HtfWeJ00tBt67eYcbZHNRdBIEvkiPzK1l6ezwZ9Daz4r
         tPVQ==
X-Gm-Message-State: AOAM531LGNZVF+earNqneQq52l1YZGBqqtsvpvRStucqalJbL8hI6hY7
        rbzTtY+iVwZP+/D0crZlJJ+6Vw==
X-Google-Smtp-Source: ABdhPJy/mBvMTAyBEtuwHpXZDJfy+zSTFKZxLLmkzpdRD0qHuJg0JD8KD2Ox+IopIRqKgX0Tqr1jhw==
X-Received: by 2002:a62:1494:: with SMTP id 142mr10148083pfu.216.1595626614442;
        Fri, 24 Jul 2020 14:36:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id br9sm6384670pjb.56.2020.07.24.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/19] module: Call security_kernel_post_load_data()
Date:   Fri, 24 Jul 2020 14:36:34 -0700
Message-Id: <20200724213640.389191-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that there is an API for checking loaded contents for modules
loaded without a file, call into the LSM hooks.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d56cb34d9a2f..90a4788dff9d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2967,7 +2967,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE, false);
+	err = security_kernel_load_data(LOADING_MODULE, true);
 	if (err)
 		return err;
 
@@ -2977,11 +2977,17 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -ENOMEM;
 
 	if (copy_chunked_from_user(info->hdr, umod, info->len) != 0) {
-		vfree(info->hdr);
-		return -EFAULT;
+		err = -EFAULT;
+		goto out;
 	}
 
-	return 0;
+	err = security_kernel_post_load_data((char *)info->hdr, info->len,
+					     LOADING_MODULE);
+out:
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

