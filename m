Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D184423E75F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Aug 2020 08:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHGGfu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Aug 2020 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGGft (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Aug 2020 02:35:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472CC061575
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Aug 2020 23:35:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so434706pgb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Aug 2020 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lbtTVfS19M9EircaMcGgloMEE/grVbAoUbgj1gpJXrg=;
        b=oYb3Id1Vy5jcC87/K7XVZbIUdogBy8rqpbrYWfAis26tXnMx+qzw81kg4Zx1gYap1k
         hiHxefnWRbv5s/Je/DBNO+4/C+kVHuRkurqczsPzam4fZ3TcKXfPxtgvXQvxqu3CVF6j
         ejySUVgMHfvjnwW7P9taUczH+H/AdV7FbpY4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbtTVfS19M9EircaMcGgloMEE/grVbAoUbgj1gpJXrg=;
        b=ghYd29voquDEajxEjh/FM2zWQRwWCZfQGkIiRTtuBBq4jbqjQsISQpz/BxcWUwtJsd
         h8U/rE3vcsMLxmkdilmZXdgVwXVswZIVG6PGsB0MdDIUjzuRxsFx3PUVLDkmAZD8BhXz
         MLXtG8C4h6JQig+2vvqxUVief4ApBkdcAbb6QPSYI0uXlMRLH4jPuXMwLdPKzRdKp4GF
         tRWlQTJq7Vh+SwYjlEdOm3cDFI943XdYKsZKMuywa4GSZLH+Hlpix6xWAI/8+SDZM56f
         wb8EKSL2KL16woKzfQrn6+8kjtgHPhClYtApX9xCqMebXSvbSPmijv2IaTVduqrWoORb
         qozw==
X-Gm-Message-State: AOAM5339W46X/SRb8XbXKkoSoVq+SE3VT6R1PjTxL7W8no5bHNiBb8oh
        cD1nJ2hq4HQcCWaPc0vZOHyucw==
X-Google-Smtp-Source: ABdhPJwAp6eTnZSJvt3uZQk6PAO4KETgli+5BFbz7Euml8v36poCp5QpJfq/cQM2TB7Jrnr5SofgFQ==
X-Received: by 2002:a62:8cd3:: with SMTP id m202mr11272808pfd.184.1596782149105;
        Thu, 06 Aug 2020 23:35:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm10812966pfr.172.2020.08.06.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 23:35:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] module: Correctly truncate sysfs sections output
Date:   Thu,  6 Aug 2020 23:35:38 -0700
Message-Id: <20200807063539.2620154-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807063539.2620154-1-keescook@chromium.org>
References: <20200807063539.2620154-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The only-root-readable /sys/module/$module/sections/$section files
did not truncate their output to the available buffer size. While most
paths into the kernfs read handlers end up using PAGE_SIZE buffers,
it's possible to get there through other paths (e.g. splice, sendfile).
Actually limit the output to the "count" passed into the read function,
and report it back correctly. *sigh*

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/20200805002015.GE23458@shao2-debian
Fixes: ed66f991bb19 ("module: Refactor section attr into bin attribute")
Cc: stable@vger.kernel.org
Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index aa183c9ac0a2..08c46084d8cc 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1520,18 +1520,34 @@ struct module_sect_attrs {
 	struct module_sect_attr attrs[];
 };
 
+#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
 static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 				struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
 {
 	struct module_sect_attr *sattr =
 		container_of(battr, struct module_sect_attr, battr);
+	char bounce[MODULE_SECT_READ_SIZE + 1];
+	size_t wrote;
 
 	if (pos != 0)
 		return -EINVAL;
 
-	return sprintf(buf, "0x%px\n",
-		       kallsyms_show_value(file->f_cred) ? (void *)sattr->address : NULL);
+	/*
+	 * Since we're a binary read handler, we must account for the
+	 * trailing NUL byte that sprintf will write: if "buf" is
+	 * too small to hold the NUL, or the NUL is exactly the last
+	 * byte, the read will look like it got truncated by one byte.
+	 * Since there is no way to ask sprintf nicely to not write
+	 * the NUL, we have to use a bounce buffer.
+	 */
+	wrote = scnprintf(bounce, sizeof(bounce), "0x%px\n",
+			 kallsyms_show_value(file->f_cred)
+				? (void *)sattr->address : NULL);
+	count = min(count, wrote);
+	memcpy(buf, bounce, count);
+
+	return count;
 }
 
 static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
@@ -1580,7 +1596,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 			goto out;
 		sect_attrs->nsections++;
 		sattr->battr.read = module_sect_read;
-		sattr->battr.size = 3 /* "0x", "\n" */ + (BITS_PER_LONG / 4);
+		sattr->battr.size = MODULE_SECT_READ_SIZE;
 		sattr->battr.attr.mode = 0400;
 		*(gattr++) = &(sattr++)->battr;
 	}
-- 
2.25.1

