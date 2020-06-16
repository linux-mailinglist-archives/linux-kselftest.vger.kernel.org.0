Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863191FA6CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 05:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFPD0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 23:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgFPDZz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 23:25:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814CBC0085C8
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 20:25:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so8602965pgm.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgXZgAefh49mTlceIe2gMjyNtNfme1hD6/ROx37cyNY=;
        b=S1Ljgo8zfvhVzanePE7S94hAQri20mgqdjLW6ZcKLS6mTkJUfcTmnH4BEuciFBypo5
         yLWzTGO7qRQ8fikTyxEylXhFYKidtnuktnSCAyG9hUsTVHRIs7tKGNPxSrXIQPwYPsOY
         BRevYE/VxN46fKeOiOKqs7U325LSQxVUFKdvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgXZgAefh49mTlceIe2gMjyNtNfme1hD6/ROx37cyNY=;
        b=EXbx4+1S/Ybtsx5kzJ6/QoSi47f5b+/zNdYT8HVZm/2h8Pb1lXBYwym7LAfisBxH5W
         qFQiYmmzOnWF8lxMs3cglBxPOVzBsTLL2zsxe4EnQq9k8aXzYadSSSrd0V2XFl3tUbz8
         dSHO3f61Bv7M45Ncx46bwu7zezqo29Z9JpqMKky6dDVRGrU2WatY62NHBZ0z5mcEMCKW
         +YWExQuy7LOFgzdCYx1AUdBcUkxT3XrNNLrUoxdUZR4plzbKnY/DgtD8ApQWapyOgWWR
         ItJCsTm/pIOwshXLJseRslArF7EPbcnkeJUKIlPB5GCPU77TuEMMcX0ffY4U4CpngmeO
         QfMQ==
X-Gm-Message-State: AOAM533Q3/Zx/2dQyyCEblunhVhsudivWJhSoKh9QHns5tr9ClLiIT2L
        IqxBB0+NdHsLosscwcYDmr1bIg==
X-Google-Smtp-Source: ABdhPJz8g8MvECoY+P37sOjiU/K6JaO1aTPm3WR2ovoaD+ETVPlO0tQ326sVmyypOrheNxONtOEH1g==
X-Received: by 2002:a62:178b:: with SMTP id 133mr272094pfx.238.1592277938070;
        Mon, 15 Jun 2020 20:25:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7sm13160189pgh.84.2020.06.15.20.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 20:25:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 11/11] seccomp: Fix ioctl number for SECCOMP_IOCTL_NOTIF_ID_VALID
Date:   Mon, 15 Jun 2020 20:25:24 -0700
Message-Id: <20200616032524.460144-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616032524.460144-1-keescook@chromium.org>
References: <20200616032524.460144-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When SECCOMP_IOCTL_NOTIF_ID_VALID was first introduced it had the wrong
direction flag set. While this isn't a big deal as nothing currently
enforces these bits in the kernel, it should be defined correctly. Fix
the define and provide support for the old command until it is no longer
needed for backward compatibility.

Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/seccomp.h                  | 2 +-
 kernel/seccomp.c                              | 9 +++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 473a61695ac3..6ba18b82a02e 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -142,7 +142,7 @@ struct seccomp_notif_addfd {
 #define SECCOMP_IOCTL_NOTIF_RECV	SECCOMP_IOWR(0, struct seccomp_notif)
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
-#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOW(2, __u64)
 /* On success, the return value is the remote process's added fd number */
 #define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3, \
 						struct seccomp_notif_addfd)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 9660abf91135..61e556bca338 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -43,6 +43,14 @@
 #include <linux/anon_inodes.h>
 #include <linux/lockdep.h>
 
+/*
+ * When SECCOMP_IOCTL_NOTIF_ID_VALID was first introduced, it had the
+ * wrong direction flag in the ioctl number. This is the broken one,
+ * which the kernel needs to keep supporting until all userspaces stop
+ * using the wrong command number.
+ */
+#define SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR	SECCOMP_IOR(2, __u64)
+
 enum notify_state {
 	SECCOMP_NOTIFY_INIT,
 	SECCOMP_NOTIFY_SENT,
@@ -1397,6 +1405,7 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 		return seccomp_notify_recv(filter, buf);
 	case SECCOMP_IOCTL_NOTIF_SEND:
 		return seccomp_notify_send(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
 	}
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index cf1480e498ea..403c6d0f149e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -184,7 +184,7 @@ struct seccomp_metadata {
 #define SECCOMP_IOCTL_NOTIF_RECV	SECCOMP_IOWR(0, struct seccomp_notif)
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
-#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOW(2, __u64)
 
 struct seccomp_notif {
 	__u64 id;
-- 
2.25.1

