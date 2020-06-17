Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF31FD834
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 00:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQWEF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgFQWDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 18:03:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D25C0617BD
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 15:03:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v24so1559609plo.6
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMyqNAArtVNszcHrT7hbrHR3KGZeRc+Wdy+CDx/HSOE=;
        b=c99QlzL+vb52wHSMq2IhOXRkR899TunU/gm5RTSzYbT4UXIY6a0A3aI6Cz1MpXhAcK
         WMkTb7Crux0hfeow/zGeuszL+/t8eFGOKkXadEFHzSqPdbs++DEBvRaIKCqw7sP7dNmv
         gL2+KE6/YuTlFLgIY7Z/bm0fVIU+eJglNWXhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMyqNAArtVNszcHrT7hbrHR3KGZeRc+Wdy+CDx/HSOE=;
        b=qs/wnzbNjWyTdXX01uZLOh90rZxm2Yv626So8mIzJa2g7DaLcQsynDwJ3DuepOcApO
         anlc9f64Svo3d0Rp1KGoBYHKt7seZ5BwPwarhXfGrtdIwqF+ghY4E7ZMDv4GD4u/Vhyd
         y0nV2CRB7UEGKPkgflJbqFudfTHv/lPCeStQnLPzB8YwG6RBFL1JL4GAgXWlr7C2A0wb
         WZuxgp4+mJ40zYG6Z7lrsqehQiRZ7/+Ih+y1YC8iKSAPZj0QLs6JIosowBxFen22HL3p
         0H3L9M1K/YR5mi54GDWuW85eLf0LC9Rz3+nWTSSqSHWtVB12SaO3CV77ev1FRPtEv6Au
         +1oA==
X-Gm-Message-State: AOAM532szGfKfPTUoiMg1oiADZ1lw2QCV0dajxaRaAbnb6H+XmoMgyNL
        5h5KG23DBzL4bubzuf9AoT7B1Q==
X-Google-Smtp-Source: ABdhPJyH669Vs7q6n5s9zYcdhTuLSHHg0GExur8GysnHPMjfY4l3Jea773ViskgyM9ZuqB0ob4lEiQ==
X-Received: by 2002:a17:90a:22ad:: with SMTP id s42mr1039880pjc.200.1592431416440;
        Wed, 17 Jun 2020 15:03:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13sm784326pfc.136.2020.06.17.15.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:03:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH v5 5/7] fs: Expand __fd_install_received() to accept fd
Date:   Wed, 17 Jun 2020 15:03:25 -0700
Message-Id: <20200617220327.3731559-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220327.3731559-1-keescook@chromium.org>
References: <20200617220327.3731559-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Expand __fd_install_received() with support for replace_fd() for the
coming seccomp "addfd" ioctl(). Add new wrapper fd_replace_received()
for the new mode and update existing wrappers to retain old mode.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/file.c            | 22 +++++++++++++++++-----
 include/linux/file.h | 10 +++++++---
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index de85a42defe2..9568bcfd1f44 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -937,6 +937,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 /**
  * __fd_install_received() - Install received file into file descriptor table
  *
+ * @fd: fd to install into (if negative, a new fd will be allocated)
  * @file: struct file that was received from another process
  * @ufd: __user pointer to write new fd number to
  * @o_flags: the O_* flags to apply to the new fd entry
@@ -947,7 +948,8 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  *
  * Returns newly install fd or -ve on error.
  */
-int __fd_install_received(struct file *file, int __user *ufd, unsigned int o_flags)
+int __fd_install_received(int fd, struct file *file, int __user *ufd,
+			  unsigned int o_flags)
 {
 	struct socket *sock;
 	int new_fd;
@@ -957,9 +959,11 @@ int __fd_install_received(struct file *file, int __user *ufd, unsigned int o_fla
 	if (error)
 		return error;
 
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
+	if (fd < 0) {
+		new_fd = get_unused_fd_flags(o_flags);
+		if (new_fd < 0)
+			return new_fd;
+	}
 
 	if (ufd) {
 		error = put_user(new_fd, ufd);
@@ -969,6 +973,15 @@ int __fd_install_received(struct file *file, int __user *ufd, unsigned int o_fla
 		}
 	}
 
+	if (fd < 0)
+		fd_install(new_fd, get_file(file));
+	else {
+		new_fd = fd;
+		error = replace_fd(new_fd, file, o_flags);
+		if (error)
+			return error;
+	}
+
 	/* Bump the usage count and install the file. The resulting value of
 	 * "error" is ignored here since we only need to take action when
 	 * the file is a socket and testing "sock" for NULL is sufficient.
@@ -978,7 +991,6 @@ int __fd_install_received(struct file *file, int __user *ufd, unsigned int o_fla
 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
 		sock_update_classid(&sock->sk->sk_cgrp_data);
 	}
-	fd_install(new_fd, get_file(file));
 	return new_fd;
 }
 
diff --git a/include/linux/file.h b/include/linux/file.h
index e19974ed9322..04389b0da11b 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -92,18 +92,22 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __fd_install_received(struct file *file, int __user *ufd,
+extern int __fd_install_received(int fd, struct file *file, int __user *ufd,
 				 unsigned int o_flags);
 static inline int fd_install_received_user(struct file *file, int __user *ufd,
 					   unsigned int o_flags)
 {
 	if (ufd == NULL)
 		return -EFAULT;
-	return __fd_install_received(file, ufd, o_flags);
+	return __fd_install_received(-1, file, ufd, o_flags);
 }
 static inline int fd_install_received(struct file *file, unsigned int o_flags)
 {
-	return __fd_install_received(file, NULL, o_flags);
+	return __fd_install_received(-1, file, NULL, o_flags);
+}
+static inline int fd_replace_received(int fd, struct file *file, unsigned int o_flags)
+{
+	return __fd_install_received(fd, file, NULL, o_flags);
 }
 
 extern void flush_delayed_fput(void);
-- 
2.25.1

