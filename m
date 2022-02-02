Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBEF4A6944
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 01:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiBBAdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 19:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243339AbiBBAdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 19:33:45 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175DEC061714
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 16:33:45 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id c188so23427650iof.6
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Feb 2022 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JepB/7vXyZQxWCvygSiSQrAo+dG4wBZLbFMfRyPaAg4=;
        b=BYjOOb9hkhtXBfhwGlSCCO509XKcvbv2hf2hjKfopkh4jOXW8O7HhQjDtyYIJa0jl5
         qTtw9X86XWTlwMVzFMnM1PJoeTfB9MsBay3aIwLob3YGE1Oy90CKWlPXcFf5aPf5E+FR
         QnQRAqB7avjTD9AOWkm0wdpaP7ob+3r/RNbW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JepB/7vXyZQxWCvygSiSQrAo+dG4wBZLbFMfRyPaAg4=;
        b=DfR5QFnrR2QAXS1JjyQJcMKF+7k4TBJtJwK3UhhrF5y2sQ5468b+IRo5bjkNNogyPR
         EpZ8dAHxzRd/toxy5kaeKSppqju9WTQxVoaugp9Y8DU9tKifggwZxmcU6hOz96ZvOICx
         Z2lOaaOH9n9tUArwBVe+IRYtNFiqZyYGkTs262DAzGe3NMhU7qMRj/IvJ/QoV0wDesJZ
         PScYuXUOzkgehYEN6u/AznrG6F6JWOGcX1DZE+t4l03FSO9qmdQ4Rp2TXb/0w1nD/x93
         hhMUfzF1EURInGvm4UOpakU0qwaIqLk+Z1/SJOXdvUgMImBl60eRFlidrupqMP/DHt4i
         G47Q==
X-Gm-Message-State: AOAM531gTx8NDlH24ozlF9jHUveIQegGFNTW79AnGgcl7cdMoAZMHdV5
        xsdFcBW5GgP9T1pgsM73CBCDvg==
X-Google-Smtp-Source: ABdhPJyLnuma3ioM5xd1+ADrOhX9jvjTMjYRkEa1l7nl/NLBbTeuZXG1YAA6NxvjtObNkd79ajkSow==
X-Received: by 2002:a02:6248:: with SMTP id d69mr14688442jac.133.1643762024503;
        Tue, 01 Feb 2022 16:33:44 -0800 (PST)
Received: from shuah-tx13.internal ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l13sm5971445ilj.24.2022.02.01.16.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 16:33:44 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     akpm@linux-foundation.org, shuah@kernel.org, chi.minghao@zte.com.cn
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/vm: Revert "tools/testing/selftests/vm/userfaultfd.c: use swap() to make code cleaner"
Date:   Tue,  1 Feb 2022 17:33:40 -0700
Message-Id: <20220202003340.87195-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With this change, userfaultfd fails to build with undefined reference
swap() error:

userfaultfd.c: In function ‘userfaultfd_stress’:
userfaultfd.c:1530:17: warning: implicit declaration of function ‘swap’; did you mean ‘swab’? [-Wimplicit-function-declaration]
 1530 |                 swap(area_src, area_dst);
      |                 ^~~~
      |                 swab
/usr/bin/ld: /tmp/ccDGOAdV.o: in function `userfaultfd_stress':
userfaultfd.c:(.text+0x549e): undefined reference to `swap'
/usr/bin/ld: userfaultfd.c:(.text+0x54bc): undefined reference to `swap'
collect2: error: ld returned 1 exit status

Revert the commit to fix the problem.

Fixes: 2c769ed7137a ("tools/testing/selftests/vm/userfaultfd.c: use swap() to make code cleaner")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/vm/userfaultfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index d3fd24f9fae8..2f49c9af1b58 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1417,6 +1417,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 static int userfaultfd_stress(void)
 {
 	void *area;
+	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
@@ -1527,9 +1528,13 @@ static int userfaultfd_stress(void)
 					    count_verify[nr], nr);
 
 		/* prepare next bounce */
-		swap(area_src, area_dst);
+		tmp_area = area_src;
+		area_src = area_dst;
+		area_dst = tmp_area;
 
-		swap(area_src_alias, area_dst_alias);
+		tmp_area = area_src_alias;
+		area_src_alias = area_dst_alias;
+		area_dst_alias = tmp_area;
 
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
-- 
2.32.0

