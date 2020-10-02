Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3C281984
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgJBRiy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388440AbgJBRip (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE4C0613B6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so1739384pfa.10
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRNkvGI2Ff9BjWU3dffE18oblDO1Opoo7ReByCIGKwI=;
        b=Mfumh5tRxy4skOQP6OGVehMnWKDcGfbBGXiWQ720eRb5OVAh6dC5RBijHQgpZPj/Y4
         YQXKfqFXUF679RfBa37dgjcpUP7MkM6k3757Sg6ZOw3gczyWHedDnJ9IiYxY6rw+0L2I
         WiL4xchzU3Ld30sxaoGGExLRw2vgpeVSEkQCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRNkvGI2Ff9BjWU3dffE18oblDO1Opoo7ReByCIGKwI=;
        b=R594WKMql6oOcpi0GQuK/Yfqi/kRCYGt+67ppt2c/xijvrS27tAPAcwN7glIBoGsLH
         RPOym6JR9tEsU+K5lXnAYm+6gJKAUdVXqTX42j9trMW0JFLfi1cHRA+GoXbukH64urS1
         6psexY7v95qLvL8kwNnJ6LQd3uW/RJMg+w371BrFdkNyv0ksPBLeLW5wZJwOTq9bA4GZ
         vuNb1Nb9OoWNTt105OHSn4XJ7PMnBrX6LUwpNu502xolxZ9mM1GWJWMzMJRnjdcgA2AS
         yW0oBTWl53fHWaGTUYB/8MTZ5y+n3aLDdDUCxPPvCT0sHYPGVrLyfXPm6WkK/H1Tmg+1
         dzNg==
X-Gm-Message-State: AOAM5305jE9FScCt7u3/w83XlJ3bClixeNER7n5nVMfd+bXVp5FfHtAY
        wHOEJtlmE5F9XzToUZcKGpskOA==
X-Google-Smtp-Source: ABdhPJwwS7Nbs517CZEc++bRCN5UnGB0D5kqLBspE9m/jC8b6k7oNPzx/9EjCuSoJzqxzl4G5yJT6A==
X-Received: by 2002:a63:c547:: with SMTP id g7mr3156527pgd.234.1601660321870;
        Fri, 02 Oct 2020 10:38:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g1sm2650900pfm.124.2020.10.02.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/16] module: Call security_kernel_post_load_data()
Date:   Fri,  2 Oct 2020 10:38:22 -0700
Message-Id: <20201002173828.2099543-11-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that there is an API for checking loaded contents for modules
loaded without a file, call into the LSM hooks.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: KP Singh <kpsingh@google.com>
Acked-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index f47209e0fde6..adfa21dd3842 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3014,7 +3014,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE, false);
+	err = security_kernel_load_data(LOADING_MODULE, true);
 	if (err)
 		return err;
 
@@ -3024,11 +3024,17 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -ENOMEM;
 
 	if (copy_chunked_from_user(info->hdr, umod, info->len) != 0) {
-		vfree(info->hdr);
-		return -EFAULT;
+		err = -EFAULT;
+		goto out;
 	}
 
-	return 0;
+	err = security_kernel_post_load_data((char *)info->hdr, info->len,
+					     LOADING_MODULE, "init_module");
+out:
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

