Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6D564D46F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 01:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiLOAOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 19:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLOANp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60786532F8
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:18 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d7so5118759pll.9
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=Mar/wnyOMbOk1+C6Q5uXoFrUdKfYUVRbk56ST4Cdpt8bBvB6kbwiHHlmlZHyoJqUXq
         0bC2mxcb4Aba4AQ7l5WLkMe1+FiheB82JTvBZg70Btv3MIEnYkyusR0jImZrs5zZt2R4
         WYPS2HBzWXj5LCp/LfNQb6K4VUdeyB2KhB+/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=Z/iR42dycRNaArpCX033rlT4QWm7qkcaK7tY8lqiqrC/jbXKeCW2fyTDS7N37Z0eqf
         p66khDtnq4jt8Uc+CjX80xkbhYVilzOL5SrRK4vyBdmnf74Gzo7M9HJuz/CvEh5jx61W
         dVMwiURJCKgsK+/zsmW98J7Rv8eHfrsm0ip8SzwuGlZptd/OwuX+nklyRDIOG2J1rx7h
         njcqUs2wRAZxIDddx9jrt0fOCBmdZTaUYsGHhEvQqzWlC+eBHOOzIgC80PisMMcV65bL
         1OMyEtdcNy+0DcsGN1/5vPCClhA5yYGZ+zLyVqu+HcGt5jV2nl7bE1FCL2UA65WYpEib
         hA7w==
X-Gm-Message-State: ANoB5pmAZ9IWhEe14Dywwp4UoJZLjjzkPEaj2ZX1r7Ev2Rzp2ikqkNQP
        wohoxbmwZ+UrkUxYY4rfPaEf3A==
X-Google-Smtp-Source: AA0mqf6GJzrv+PwU1r/NMlYDtOak9TKNkI9c0zXY6nAVkp4XlqigEungkSMJ1qEv73IT1BAvIE/pQw==
X-Received: by 2002:a17:90a:7890:b0:221:4338:a6ae with SMTP id x16-20020a17090a789000b002214338a6aemr17461030pjk.33.1671063137955;
        Wed, 14 Dec 2022 16:12:17 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:17 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 4/5] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Thu, 15 Dec 2022 00:12:04 +0000
Message-Id: <20221215001205.51969-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221215001205.51969-1-jeffxu@google.com>
References: <20221215001205.51969-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application can no longer modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example:
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index ec70675a7069..92f0a5765f7c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	/*
+	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

