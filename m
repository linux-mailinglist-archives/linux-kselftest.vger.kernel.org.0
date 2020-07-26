Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3834322DB41
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jul 2020 03:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGZBiQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jul 2020 21:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZBiQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jul 2020 21:38:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58237C0619D2;
        Sat, 25 Jul 2020 18:38:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so10577710qkn.4;
        Sat, 25 Jul 2020 18:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=DOW/AnP+Zij8+SkDYOEysjK9QaubebMZaoB1Mg/JcqM=;
        b=hyNczvBm2REN+4VLB/rtxKbGWpjgfYuLK3lG0BIU+llj0ISBPejdbgfDvr0vNWVbeW
         HAvIfUwJaT0mfnJQ10tvBI89pu0TrGUT9JvdYwqmiAmce4ZC+px8JHNrhaNDhJP2KM+i
         AcTbFFHfWV52h+deiFXvb+Vc+HXx36tNiWTtpuy6cDhsaJ4IxoanncW8Dz8bE2UZDmaR
         07QC4MePcKSrO67IUmu7dKRMNYxcE5NjilOUb4xFdsINScTJm+ObVrZQKdS1SwEREFLk
         7Io1kwHwX1jVvntCBzb4PzYoUi+NbmyNsDBI3zN8sEGGpVuYMoZJsjAnc+eQUwe+PUI8
         9wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=DOW/AnP+Zij8+SkDYOEysjK9QaubebMZaoB1Mg/JcqM=;
        b=bK3S/Ub5iYKtLWljYinazgRK2TumzJfRLFQkuzmUOyz+YQDiiXErB/kml/OMlDZxRQ
         74UmV/LgOYyK/vTfu/+CzJrGLYn6iHJT/FiNjqfNdDzD95NV6aj66ub1bnXv14QFVzkm
         8TKc6eeyJVDh4CArzWx0U/lhlTOWghNVfosio6NyQ0VACgiNHViOMQ3zi0VI98/HcdPm
         1uA4pLxkTlxJ76H9e/DC7yfYJVcBZWGmcpHMFO8fV2eDSPqNi7NVDBNF8WEGJD8djAXl
         tRwAUr+3yFzD+fkluIPK4Y/lzByBWKnn3EDls0J3eBdsx4T/xrDYBUWKQSipvO7ACBsr
         UzOg==
X-Gm-Message-State: AOAM531wTKn2cvqGCBxepvkBGaIELYZn3DAYVzEr+jxVHMBZwVisVMsj
        zN7VHQ4VSFQPRlM6Yr3h8U4=
X-Google-Smtp-Source: ABdhPJx/vgdg/XXX9wZJr8GKXLGqeSR6LiA7Lsxfib37SnAXo1IdfhGGM5H9g0jF1kHWPAYKZsAhIg==
X-Received: by 2002:a05:620a:4d9:: with SMTP id 25mr12992962qks.411.1595727495368;
        Sat, 25 Jul 2020 18:38:15 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:159c:94c1:6e96:1b7e])
        by smtp.googlemail.com with ESMTPSA id x5sm7840829qtp.76.2020.07.25.18.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 18:38:14 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Shuah Khan <shuah@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Chris Down <chris@chrisdown.name>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [cgroup/testing] cg_read_strcmp: Fix null pointer dereference
Date:   Sat, 25 Jul 2020 21:37:57 -0400
Message-Id: <20200726013808.22242-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200725181506.20199-1-gaurav1086@gmail.com>
References: <20200725181506.20199-1-gaurav1086@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Haven't reproduced this issue. This PR is does a minor code cleanup. 

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

