Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3D22D94B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jul 2020 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGYSPe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jul 2020 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgGYSPe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jul 2020 14:15:34 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD9FC08C5C0;
        Sat, 25 Jul 2020 11:15:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so9333848qts.6;
        Sat, 25 Jul 2020 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=BoLLs9pL25bQsh1K8AZlZy8BCoVEU1VbiiHrpjhJ70k=;
        b=jt8+hJpYx7U7Pv4o2UdmKJnGDCnIYuK7uaPWiLSuPerSnu/1L9O+7cW1Se5svGYhBq
         PGZN5uls/Pto4Vf8OVG6r0LfbTqSTYWzZ6dhgYu/LwwpKeF7H2iN9ZCqxnST7LDMPY44
         m+WLoh1ICZwjWcMswMJXNyzFCk7+FYnXesjgx8VPwC72onuXCRtKugi7xXofHe5bCsZl
         dIGiubPw2iiJSqPVzRwcJcr52Kq0GlUIMug5dee0xyCLfV2uOtWLjR6QAB+ZyVrdl8JK
         yo/RS/RzGqC+pjxl2B+88wB2t5fQDXYExVbKqi4ThXbx5oczuTI7hPQirh1Uc7bY/uhQ
         Qr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BoLLs9pL25bQsh1K8AZlZy8BCoVEU1VbiiHrpjhJ70k=;
        b=qxkyAcEMGR+OkytRYFFV3m3OScuPtnlRvY9T6+KqWFnldbMBkwsrqp0YWG8/jHOcGa
         /4m4XXl10WYesVIkYITNks66VGSO5lVvQ/DwnPoCv7gll1qvdcrWbJySI74iKSpJfNsP
         5qh6S3QDglXr7Wm4o10sT2suk3RkZKBjUzdUD/Fhu3eyeGdKXaywiqjG4X1ZZRrsK3wu
         t6S8qsikw9pXuCIvqd0tYeqeYeEs/uyupw9gb9VkC6ujZZ1F0l91d75eO8Yaa4sGW9bR
         XFXo8WZk+EmPe1eKuUauzX3RsnnVGjXnmHErSICMc+BZ66kTdDWbUlB7qCVW4id3dEx5
         He3w==
X-Gm-Message-State: AOAM530uK7oCNMHlxwXiHLXit1zVa5zeAZgfI2s+xvuKQrH2qCtPgPyV
        dy2FSWFgiN/Tw9AjmUL1QSRdcGqJEVyuXQ==
X-Google-Smtp-Source: ABdhPJxGFMafz00I9Zqenkqzb2gAb3+rqPW8PStREmdM83sDRCB6ZQeowtht6kGoIDWaz3WOadCKOQ==
X-Received: by 2002:ac8:478e:: with SMTP id k14mr12856517qtq.21.1595700933813;
        Sat, 25 Jul 2020 11:15:33 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:dd0e:1a59:cbe4:73ee])
        by smtp.googlemail.com with ESMTPSA id o184sm12177664qkd.41.2020.07.25.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:15:33 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Shuah Khan <shuah@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [cgroup/testing] cg_read_strcmp: Fix null pointer dereference
Date:   Sat, 25 Jul 2020 14:14:51 -0400
Message-Id: <20200725181506.20199-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Passing NULL in strcmp will cause a segmentation fault.
Fix this by returning -1 if expected is NULL pointer. 

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 8a637ca7d73a..05853b0b8831 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -106,7 +106,7 @@ int cg_read_strcmp(const char *cgroup, const char *control,
 
 	/* Handle the case of comparing against empty string */
 	if (!expected)
-		size = 32;
+		return -1;
 	else
 		size = strlen(expected) + 1;
 
-- 
2.17.1

