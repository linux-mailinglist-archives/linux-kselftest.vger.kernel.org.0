Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5A1645DE8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 16:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGPtv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 10:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLGPtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:46 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040134B777
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 07:49:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p24so17413883plw.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71ca0yPxFF6EaiLKMWlrSqitNHDHlqW3RCkGeX1vy+A=;
        b=PhU557wYsKo/iDLZ/eBYG10j3SUNufkud5V4AzaP2ICyOtQc995aeL12t/n/DCDOjS
         NMogyAHS/VfnZLMBDSu6Di4KmFIVVQ0uOhTFzgcacngKlg82FwY5QBCqc7jvGtP83Lsg
         0oNoHBlwcyoa3/tfXpapegc2TgwcvzzxnMc4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71ca0yPxFF6EaiLKMWlrSqitNHDHlqW3RCkGeX1vy+A=;
        b=p6pYHtHY87DyIb/qp6Dc8/mBldmFIedR/y+AEtk5oV9oEvrExBC0hi017Lz5O/cdco
         jrW3D07iu4a+dHlaGB67YbpYbABnybX9PZbAeKfqBSNHY+Dlz1QiUm6ybUQEMGPpeVbD
         9lVrW58E1MGDeB9TX4OSgLmpM1tDFwpYIkpCl69eJpnzk+ypeH06OvizV9qejYeUy827
         zd3rjKoAav1OmA06ytuTHFAPV9y7qlEe7oYlEsHMfGPvX0braIlGwh0dOMvlvvuuTnxZ
         5zvfwHZ2hiSN7lebZpjWeJteQ3kR+i49gWI7P1iftAVe3UuOCWatZWnzmA40lJAujSTR
         awhw==
X-Gm-Message-State: ANoB5pm2rEjtmbvZIAQ/SPieVeaJdlUXK6oFaZjIl1eBgnXYWaTVNx0P
        djlSEK/47JK+OQ7J9+0+KZiwfQ==
X-Google-Smtp-Source: AA0mqf6LlztV8oc9Di/UeVnMjrwTxAuHnQqhNmrhBv6DODQ39jcxdztg/nAsot9XSmGNU3B9Sjff5Q==
X-Received: by 2002:a17:902:8343:b0:187:1f0:4579 with SMTP id z3-20020a170902834300b0018701f04579mr748942pln.61.1670428185700;
        Wed, 07 Dec 2022 07:49:45 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017f7628cbddsm14920934plh.30.2022.12.07.07.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:49:44 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org
Subject: [PATCH v6 1/6] mm/memfd: add F_SEAL_EXEC
Date:   Wed,  7 Dec 2022 15:49:34 +0000
Message-Id: <20221207154939.2532830-2-jeffxu@google.com>
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

From: Daniel Verkamp <dverkamp@chromium.org>

The new F_SEAL_EXEC flag will prevent modification of the exec bits:
written as traditional octal mask, 0111, or as named flags, S_IXUSR |
S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
any of these bits after the seal is applied will fail with errno EPERM.

This will preserve the execute bits as they are at the time of sealing,
so the memfd will become either permanently executable or permanently
un-executable.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 2 ++
 mm/shmem.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..e8c07da58c9f 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 08f5f8304746..4ebeab94aa74 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -147,6 +147,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
 		     F_SEAL_WRITE | \
@@ -175,6 +176,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	 *   SEAL_SHRINK: Prevent the file from shrinking
 	 *   SEAL_GROW: Prevent the file from growing
 	 *   SEAL_WRITE: Prevent write access to the file
+	 *   SEAL_EXEC: Prevent modification of the exec bits in the file mode
 	 *
 	 * As we don't require any trust relationship between two parties, we
 	 * must prevent seals from being removed. Therefore, sealing a file
diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..e18a9cf9d937 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1085,6 +1085,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		return error;
 
+	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
+		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
+			return -EPERM;
+		}
+	}
+
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

