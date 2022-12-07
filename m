Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F55645DEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLGPt4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 10:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiLGPtt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E33AC14
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 07:49:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2054201pjh.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68tZIB+0aYpPIylSIqK6cc/meXXHAi0u5AcBKUyeGcY=;
        b=Pgcz8EqFIllSIrbiyT8+zFROC9GpuYiPrYWAWuws/ZAml4A7Ugasa59H8dzt4twoB4
         O0cAxxO9Mke403E/Mj+rjoT+GeN92NHh57bpsegW33gdWlb7tQAmt+ewJoJYOEJvEyeH
         jGBefsgqUB3ZHzuky+3uRwszEnFjlO/ZS+68A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68tZIB+0aYpPIylSIqK6cc/meXXHAi0u5AcBKUyeGcY=;
        b=t7ywA0603ugzk9Wg7WMmwYIb0dzXlK/ML9sHSpnmmcEmCg/02blkwnxuzKNlIvh1HH
         AN5LXfg/2JgVUwz97JWzDZOn9+69L8y67hKME3IIQZrgPc484SQhITyRMlocAGlgWlyN
         /NMvfYv17XSRNAm4JoOJPAYr3qWI09rD8jx6Do7rt80+dbr/bGlabDyskIMP9Bp6UPZw
         pe1PrFXm6FC8sHTMEWx0lG07XHnaPhOktsWWKj1p66beD/AAcfviYQSvPXaSbO2m2gXl
         THC8vWf+f3SkCEZ0HxNpXJVQGExDT8cJ5uzVoZSsBzFNLGhjeXnUbIHPT1kAwWdcBDRv
         aSjQ==
X-Gm-Message-State: ANoB5pmBjyfvwxW8yWrRvI1NqcE/S5Fsxdk/XyNzfvFQOZ692SE2Hx3D
        quy4ZwAtTMhN3u3qzK4zEn5NVa1VtHv+/xc0
X-Google-Smtp-Source: AA0mqf6RkUVGcJjeQXvXQRSUZJARW3Rj32QYHY9STgcjYfWrJ0sPoKsrx/6HB7CijCJ1h5EjJkg5dg==
X-Received: by 2002:a05:6a21:9991:b0:a4:5f8d:805a with SMTP id ve17-20020a056a21999100b000a45f8d805amr1331414pzb.53.1670428188610;
        Wed, 07 Dec 2022 07:49:48 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017f7628cbddsm14920934plh.30.2022.12.07.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:49:47 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org
Subject: [PATCH v6 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Wed,  7 Dec 2022 15:49:37 +0000
Message-Id: <20221207154939.2532830-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221207154939.2532830-1-jeffxu@google.com>
References: <20221207154939.2532830-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.39.0.rc0.267.gcb52ba06e7-goog

