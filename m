Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC76A98D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 14:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCCNoS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 08:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCCNoR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 08:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8D166D1
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Mar 2023 05:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677850962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KjFop+u9gsgumQbI1NT01HU0M1e24GmQr3F/oJ5Ui+I=;
        b=VWG/3JoN7Z+lZ+xNzmiOGT7uDDwdt37Vk67BnNoUFYTjV0zsBxwpZNHbXF1USIJXCHspOF
        gDYDJTwMHRdPU0MPZm7OOTbm3CTMJ/8NOaNCDuJqmk3hDXeRvcO59CbWGhRGG12XGyLR40
        GAqLXOcf2mW9paEQA4cORScWRHrsZeQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-g2DD61FGP0CAItyCG-Zodw-1; Fri, 03 Mar 2023 08:42:40 -0500
X-MC-Unique: g2DD61FGP0CAItyCG-Zodw-1
Received: by mail-wm1-f72.google.com with SMTP id n15-20020a05600c500f00b003dd07ce79c8so1033596wmr.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Mar 2023 05:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjFop+u9gsgumQbI1NT01HU0M1e24GmQr3F/oJ5Ui+I=;
        b=Yt+CtrTsH4DTUUdms4EghodIA0UcDpB1MTONQsBZvu4ngGrVdo4CfQbVOqZ+CbgWkG
         J66yISPkdY+//X0bAkzo0jxHWCk7gBzFeq8A2D4UUHFypCbABRPB2yZtvCCcGh48Irdp
         nhad0XV2ap0KPGaRe2knyTKm4cI5ZOWqMtghtkUtUfG4KQeFXFKfzhBnq2f5eIh/j6hh
         0zTp0R7UMl/1YgQmQMY+8ku6pO22WhXM2Hgoer88XtuKDU+C3k6+4tKCWBpzXI34Z+Wr
         7dujwyb6ewjoKYlnQBFg6imV+4Y4c86xb5mkBhgkUYFKbpmJoeRK48pRnf5WBNxIxCOG
         wXzQ==
X-Gm-Message-State: AO0yUKVy66/CkSLXG4jDUkKS1LqJoVLqV5dtiwXXL9xRERaKp0OZ5ZhE
        0cDmIPxNP4g8cc6Pi+kPtQpOTCnenBjkA9qWkHf2JAGekfyfKD8DtEnaAmUaOZxB9bEN5gOqUwd
        ppxcpicwkaZ7us0vNSc88VUEpBBDY
X-Received: by 2002:a5d:4ec8:0:b0:2c7:169b:c577 with SMTP id s8-20020a5d4ec8000000b002c7169bc577mr1090570wrv.19.1677850959756;
        Fri, 03 Mar 2023 05:42:39 -0800 (PST)
X-Google-Smtp-Source: AK7set8B4qYd0mFC/ZdyIijg93cTAwkXRp8dgkJL+iYSBZtGCJT1818CAO3C7LJ7lYZ/hehWcWUmww==
X-Received: by 2002:a5d:4ec8:0:b0:2c7:169b:c577 with SMTP id s8-20020a5d4ec8000000b002c7169bc577mr1090555wrv.19.1677850959403;
        Fri, 03 Mar 2023 05:42:39 -0800 (PST)
Received: from localhost.localdomain ([46.33.96.29])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d4d47000000b002c5706f7c6dsm2208708wru.94.2023.03.03.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:42:38 -0800 (PST)
From:   Michal Sekletar <msekleta@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, arozansk@redhat.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Sekletar <msekleta@redhat.com>
Subject: [PATCH 1/2] tty: tty_io: update timestamps on all device nodes
Date:   Fri,  3 Mar 2023 14:36:05 +0100
Message-Id: <20230303133606.227934-1-msekleta@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

User space applications watch for timestamp changes on character device
files in order to determine idle time of a given terminal session. For
example, "w" program uses this information to populate the IDLE column
of its output [1]. Similarly, systemd-logind has optional feature where
it uses atime of the tty character device to determine if there was
activity on the terminal associated with the logind's session object. If
there was no activity for a configured period of time then logind will
terminate such session [2].

Now, usually (e.g. bash running on the terminal) the use of the terminal
will update timestamps (atime and mtime) on the corresponding terminal
character device. However, if access to the terminal, e.g. /dev/pts/0,
is performed through magic character device /dev/tty then such access
obviously changes the state of the terminal, however timestamps on the
device that correspond to the terminal (/dev/pts/0) are not updated.

This patch makes sure that we update timestamps on *all* character
devices that correspond to the given tty, because outside observers (w,
systemd-logind) are maybe checking these timestamps. Obviously, they can
not check timestamps on /dev/tty as that has per-process meaning.

[1] https://gitlab.com/procps-ng/procps/-/blob/v4.0.0/w.c#L286
[2] https://github.com/systemd/systemd/blob/v252/NEWS#L477

Signed-off-by: Michal Sekletar <msekleta@redhat.com>
---
 drivers/tty/tty_io.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 36fb945fdad4..48e0148b0f3e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -101,6 +101,7 @@
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 #include <linux/termios_internal.h>
+#include <linux/fs.h>
 
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
@@ -811,18 +812,27 @@ void start_tty(struct tty_struct *tty)
 }
 EXPORT_SYMBOL(start_tty);
 
-static void tty_update_time(struct timespec64 *time)
+static void tty_update_time(struct tty_struct *tty, int tstamp)
 {
+	struct tty_file_private *priv;
 	time64_t sec = ktime_get_real_seconds();
 
-	/*
-	 * We only care if the two values differ in anything other than the
-	 * lower three bits (i.e every 8 seconds).  If so, then we can update
-	 * the time of the tty device, otherwise it could be construded as a
-	 * security leak to let userspace know the exact timing of the tty.
-	 */
-	if ((sec ^ time->tv_sec) & ~7)
-		time->tv_sec = sec;
+	spin_lock(&tty->files_lock);
+	list_for_each_entry(priv, &tty->tty_files, list) {
+		struct file *filp = priv->file;
+		struct inode *inode = file_inode(filp);
+		struct timespec64 *time = tstamp == S_MTIME ? &inode->i_mtime : &inode->i_atime;
+
+		/*
+		 * We only care if the two values differ in anything other than the
+		 * lower three bits (i.e every 8 seconds).  If so, then we can update
+		 * the time of the tty device, otherwise it could be construded as a
+		 * security leak to let userspace know the exact timing of the tty.
+		 */
+		if ((sec ^ time->tv_sec) & ~7)
+			time->tv_sec = sec;
+	}
+	spin_unlock(&tty->files_lock);
 }
 
 /*
@@ -928,7 +938,7 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	tty_ldisc_deref(ld);
 
 	if (i > 0)
-		tty_update_time(&inode->i_atime);
+		tty_update_time(tty, S_ATIME);
 
 	return i;
 }
@@ -1036,7 +1046,7 @@ static inline ssize_t do_tty_write(
 		cond_resched();
 	}
 	if (written) {
-		tty_update_time(&file_inode(file)->i_mtime);
+		tty_update_time(tty, S_MTIME);
 		ret = written;
 	}
 out:
-- 
2.39.2

