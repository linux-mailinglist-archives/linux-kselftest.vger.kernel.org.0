Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96AE3D41
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfJXU3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 16:29:18 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34110 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfJXU3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 16:29:16 -0400
Received: by mail-qk1-f202.google.com with SMTP id d127so53916qkc.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OTTgP/4rSMZq1YQryUiCckFA0Or1XPmBCQJjGhG/4Xo=;
        b=k+KQK1yVgr8ftCY21WnHwRy8s7u2DAecuwJppewUUySA6SAvk6D0TqMKRNnRAQIxAe
         koa/CpSG/tMqlcpF0TwQT3hvEfx3jFSpMcNrp8mXRKclZVYizJldrdCOqmRKc5wHnIMY
         WDceg4mifhX2pxAPYV++HQnr/zH4VGfVOaZQNy/dvkawRHLD4jRCpG5aIwT5NBxX5D7F
         SCJxRdQwJdpTwP0ZJUUedSNcOAMRAsRTUO9yko1ejSRBbrwa5zZteMMvixSReRioOhPB
         1B70iyeoARY9KcnjukFGO5frbxtkbCJo0W/vyGeQNZSatoWWipT8f1b6/BTh9PQkxnlF
         LeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OTTgP/4rSMZq1YQryUiCckFA0Or1XPmBCQJjGhG/4Xo=;
        b=Q12TOryh/uP0LRPdMy9PweklMltcsKl7h1lreS+RNPWOk59hszn5hRXOlETqPeUYVb
         348xWjZqmfYH/vraYvjjGNx8ShbOsvHHrpALFCCeWHz3kwYl78CzrSmV70fHKD9jlzbF
         dVy+A5mSvmqUb2NgEFIp3RmdPa4BKCLDeTw/eqYlXagl4+PXMxZ+cbeo2CaJbPu1lYvr
         qbLBdvbjg66ahoHpvHl1GbgFarvy8EugcSi+qK66wvGdKT6FIl1C6/bZBX3RiPmY5FPk
         eKjH8z0ct2M8Jj7iyM7o1wRY5R4f71aH1E/YZmDG3PVps9e2vcIli5vgMzSsQBEGlwBF
         viuQ==
X-Gm-Message-State: APjAAAV7fYBYNtnN91LTGL+4pAEFBQQS47lBk9By5WhWHwnyqSIIFpT7
        ZGRMCfTA7mJ3xbHUEJspCquhe71ji90Ejrj7HQ==
X-Google-Smtp-Source: APXvYqykmweDy/QLQPkGWizAYNIBL+BlX3Ygpu2mWSwRIj83jVjwajIZ8NVAcpVzBNG7dhIbfZW7dElSf1O2aNJ7vA==
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr4095977qvx.83.1571948953537;
 Thu, 24 Oct 2019 13:29:13 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:52 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 3/9] hugetlb_cgroup: add cgroup-v2 support
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

---
 mm/hugetlb_cgroup.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 854117513979b..ac1500205faf7 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -503,8 +503,13 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	cft = &h->cgroup_files[HUGETLB_RES_NULL];
 	memset(cft, 0, sizeof(*cft));

-	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
-					  h->cgroup_files));
+	if (cgroup_subsys_on_dfl(hugetlb_cgrp_subsys)) {
+		WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
+					       h->cgroup_files));
+	} else {
+		WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
+						  h->cgroup_files));
+	}
 }

 void __init hugetlb_cgroup_file_init(void)
@@ -548,8 +553,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	return;
 }

+static struct cftype hugetlb_files[] = {
+	{} /* terminate */
+};
+
 struct cgroup_subsys hugetlb_cgrp_subsys = {
 	.css_alloc	= hugetlb_cgroup_css_alloc,
 	.css_offline	= hugetlb_cgroup_css_offline,
 	.css_free	= hugetlb_cgroup_css_free,
+	.dfl_cftypes = hugetlb_files,
+	.legacy_cftypes = hugetlb_files,
 };
--
2.24.0.rc0.303.g954a862665-goog
