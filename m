Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06346456C0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhKSJGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 04:06:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53964 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhKSJGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 04:06:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B667F212C9;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637312608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDsgLT8c9xMnLP5HTg9s3ku1Ze0kqVMgaNncakOaoJY=;
        b=iDCOuYb7bzBWVqw0KvfB3O4cMj8fmBcUrzghBbDhwmIxGHlXPIlPQRsW4MSzpl9Z4cibGP
        33CYMsEzsQ4DRpU/RngmgOVNB5Ia4hz+bVhT1iuWo9OX53EUw0pQBR00oVJfouUbZhTFPX
        vaF/MI4SbMpIZN46XHM5yhb4AOJhkaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637312608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDsgLT8c9xMnLP5HTg9s3ku1Ze0kqVMgaNncakOaoJY=;
        b=n5Ai3hYM80qTZ6YTkz20lrVnxDxXFanrbaoeLOmceCQaBkbcJHoWvA18K7NTyVi/+QkIZa
        UruNQOyqxvuQB6CQ==
Received: from san.suse.cz (san.suse.cz [10.100.12.79])
        by relay2.suse.de (Postfix) with ESMTP id 9E936A3B83;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 1/3] livepatch: Move the initialization of old_func to a new function
Date:   Fri, 19 Nov 2021 10:03:25 +0100
Message-Id: <20211119090327.12811-2-mbenes@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119090327.12811-1-mbenes@suse.cz>
References: <20211119090327.12811-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct klp_func will be used not only for functions to be patched but
also for functions which must not be found on a stack. Move the
initialization of needed struct members to a separate function, so the
code can be reused.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 335d988bd811..3d8e3caf9f92 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -767,6 +767,28 @@ static int klp_apply_object_relocs(struct klp_patch *patch,
 	return 0;
 }
 
+static int klp_init_old_func(struct klp_object *obj,
+			     struct klp_func *func)
+{
+	int ret;
+
+	ret = klp_find_object_symbol(obj->name, func->old_name,
+				     func->old_sympos,
+				     (unsigned long *)&func->old_func);
+	if (ret)
+		return ret;
+
+	ret = kallsyms_lookup_size_offset((unsigned long)func->old_func,
+					  &func->old_size, NULL);
+	if (!ret) {
+		pr_err("kallsyms size lookup failed for '%s'\n",
+		       func->old_name);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 /* parts of the initialization that is done only when the object is loaded */
 static int klp_init_object_loaded(struct klp_patch *patch,
 				  struct klp_object *obj)
@@ -787,20 +809,10 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 	}
 
 	klp_for_each_func(obj, func) {
-		ret = klp_find_object_symbol(obj->name, func->old_name,
-					     func->old_sympos,
-					     (unsigned long *)&func->old_func);
+		ret = klp_init_old_func(obj, func);
 		if (ret)
 			return ret;
 
-		ret = kallsyms_lookup_size_offset((unsigned long)func->old_func,
-						  &func->old_size, NULL);
-		if (!ret) {
-			pr_err("kallsyms size lookup failed for '%s'\n",
-			       func->old_name);
-			return -ENOENT;
-		}
-
 		if (func->nop)
 			func->new_func = func->old_func;
 
-- 
2.33.1

