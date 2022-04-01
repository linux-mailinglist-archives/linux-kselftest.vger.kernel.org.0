Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917524EFC9F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Apr 2022 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353239AbiDAWKp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 18:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353231AbiDAWKo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 18:10:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A244D36E07
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Apr 2022 15:08:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so6409243pjb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Apr 2022 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGy12Ftw4loYyE/TAP1mAYq+WnfJrqLYyR2nxuIM2Fs=;
        b=SL+SlsZQoHtn/QL8/tkQm0FjSPuHuOxWUbuUxvj8p1fi5KcysZoVhJslgdNUIpCfdx
         xMaLuCHkzzhLEtjWry6xZ18Kd8ePrZ0yDFhYQrDIwtgMlcC0xLi8wlA+UmB3/v01zVJM
         6kkF19DbqpacsUKj/Tf9vROFF0KI1KSVapvFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGy12Ftw4loYyE/TAP1mAYq+WnfJrqLYyR2nxuIM2Fs=;
        b=jRQO/4nyyKcRc0OkkozHi1r/DFdCjn8MAMU4jggQ6ASu3miLBHlqbnlq8F/gwYRJFh
         E73Wqsf7l0xIAzpj39FX39QwAqA5/zagCXtlYptLYg4csP81fdwlB30iS0ikCDCqZbf6
         HUO6yG9yioRYE+2/djRrgY0d636jzB6U/Pg8QgXsf1Q2xWlEqXo7q2UVwS/AEgod4Z7P
         TjQ3lD7POY7mik+uRTYosSaI0+cloShtG/FMS82lX9l7e0yBqWDRTA2H/bM3QCNODVa7
         Alx/tk7o2cQKT0m1zCSgnee6FECvrOkxWkIincheISc49kPXQ9kQWvPStBjhCATS+usU
         i2dg==
X-Gm-Message-State: AOAM531H5mGhKFOkdifynjWZ/qJ3wUH4tftHPVC/qfxRTmoOocN9Ny9A
        P0GqTakhqoQZBCicZ/ea7SPkuQ==
X-Google-Smtp-Source: ABdhPJxNkBtR9kNWdwRtqqtUAaRI/gzMa1PZ+fRs6SHZlkmeP7URvCbay+i9SC3t8N/U0ppDaev6ew==
X-Received: by 2002:a17:902:db0f:b0:154:665e:af75 with SMTP id m15-20020a170902db0f00b00154665eaf75mr48318074plx.147.1648850932149;
        Fri, 01 Apr 2022 15:08:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:72c9:527e:d936:c24b])
        by smtp.gmail.com with UTF8SMTPSA id k18-20020a056a00135200b004fb18fc6c78sm4219370pfu.31.2022.04.01.15.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 15:08:51 -0700 (PDT)
From:   Daniel Verkamp <dverkamp@chromium.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH 2/4] mm/memfd: add MFD_NOEXEC flag to memfd_create
Date:   Fri,  1 Apr 2022 15:08:32 -0700
Message-Id: <20220401220834.307660-3-dverkamp@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220401220834.307660-1-dverkamp@chromium.org>
References: <20220401220834.307660-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The new MFD_NOEXEC flag allows the creation of a permanently
non-executable memfd. This is accomplished by creating it with a
different set of file mode bits (0666) than the default (0777) and
applying the F_SEAL_EXEC seal at creation time, so there is no window
between memfd creation and seal application.

Unfortunately, the default for memfd must remain executable, since
changing this would be an API break, and some programs depend on being
able to exec code from a memfd directly. However, this new flag will
allow programs to create non-executable memfds, and a distribution may
choose to enforce use of this flag in memfd_create calls via other
security mechanisms.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..140e125c9f65 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,7 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+#define MFD_NOEXEC              0x0008U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index 4ebeab94aa74..b841514eb0fd 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -263,7 +263,7 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -333,6 +333,14 @@ SYSCALL_DEFINE2(memfd_create,
 		*file_seals &= ~F_SEAL_SEAL;
 	}
 
+	if (flags & MFD_NOEXEC) {
+		struct inode *inode = file_inode(file);
+
+		inode->i_mode &= ~0111;
+		file_seals = memfd_file_seals_ptr(file);
+		*file_seals |= F_SEAL_EXEC;
+	}
+
 	fd_install(fd, file);
 	kfree(name);
 	return fd;
-- 
2.35.1.1094.g7c7d902a7c-goog

