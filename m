Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5F64478F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 16:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiLFPHe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 10:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiLFPGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9E2AC5C
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 07:02:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y4so14181851plb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6szhuV271WBRooPiUYxdjBS9FRctTnZzx3+BuNL+4Q4=;
        b=Z8e7g8VSkg7JqHkBqAjKdN+QFOCeoevDFoGXwOSAd/ee3qA5UWiZXi7Xby+6W+6LXD
         4TIjYL9Ufdb4C2aZ3GsGXLaCICrkTQOgEsQ2gEIiM1EBmjFWB5wpWVyVQ/1/7i661MBg
         rsyxjrSh1hIQJGUbYpSgIhT2a55Msluvqmhps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6szhuV271WBRooPiUYxdjBS9FRctTnZzx3+BuNL+4Q4=;
        b=BYSV94FK8rprIE0Y0U9ahGKMdwAk8X1Hj+bjqcJVI45zbOhko22eGabt/s+1aPLssY
         MuqltVcoPP0RzHze/X4qQikKUNi4YzalP6R9zUMWwNuLwNziN02/WhVdGC37rbK0eBrW
         V6hJq5Pud7gaYAfiSuEcqUOcd1IolFGZaYEg/g5bruRDYZHRCIx5L9dz739Vzd9XUPDu
         A28Akvl9EWmt3AFgXNwAuWc2apX4EhDjxQzIRrvdkvIcbGGBC4gpDgtjlz0RwVw7T8mt
         P6mkXT2J/SI7kkVe0HOt1H1YXzVam5RxjG6ow2AUJQFbI07MBwAkQocd3FM1bxDcV5nt
         bS6g==
X-Gm-Message-State: ANoB5pkqRWpka85+uDg6i4qgG88XAZEJEe1fzpzE3x7qzbRqdYjxIiyc
        5Tc81L/Sel7KL7nGa1kd9gFBpg==
X-Google-Smtp-Source: AA0mqf73o+/ioSQzoTjsLzlyHEzPeoFPnI5gs96npnnroF1tNidRpEvUBkwQWbI4ZJLPCmhoyBrZqg==
X-Received: by 2002:a17:90a:1bc2:b0:218:8bdb:de3f with SMTP id r2-20020a17090a1bc200b002188bdbde3fmr85820069pjr.225.1670338975208;
        Tue, 06 Dec 2022 07:02:55 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3343019pfu.61.2022.12.06.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:02:54 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Tue,  6 Dec 2022 15:02:31 +0000
Message-Id: <20221206150233.1963717-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206150233.1963717-1-jeffxu@google.com>
References: <20221206150233.1963717-1-jeffxu@google.com>
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

From: Jeff Xu <jeffxu@chromium.org>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application won't be able to modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example: 3> shall be right after 2> in steps below.
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.


Signed-off-by: Jeff Xu <jeffxu@chromium.org>
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

