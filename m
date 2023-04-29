Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8947B6F2245
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Apr 2023 03:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347364AbjD2B7J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 21:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347347AbjD2B7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 21:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D1046B7;
        Fri, 28 Apr 2023 18:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56D126461F;
        Sat, 29 Apr 2023 01:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E67CC4339C;
        Sat, 29 Apr 2023 01:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733542;
        bh=zoqRFyKFzbksP21+pdzLOmw6DiAmo5NhTPCpktIbKRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoSbmnFPIZay/pUusbgPUBv9NjZrpIhi4AU93fSnKwQXUfBBLDF47MThtXWXp6NTb
         xDRmZFwqHDZi1Xwg77NwzMLVTIb4l3WFaGxqbXcWIn49Djbf1hstRT8Q0OyO+KeGiJ
         YBsnED19zmYjcoE+mCIGGG86+SFmLLeroSOZhXjM6EvzpEljFRANkAfjeawCgFEA45
         m2nxUPaqsCe0Pl12TH80wJAl72BHelVqobBMLNH8LHhFock6UniyezY5peDqF1ygIE
         cPHskQ+onsX7uELj2+rsyeKD88/ZOmVxIftMFIBsFqkvp+PFCcVtLa7PyxQ0DeCsoP
         Q5d/OhHqwJZTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 2/3] selftests: cgroup: Add 'malloc' failures checks in test_memcontrol
Date:   Fri, 28 Apr 2023 21:58:56 -0400
Message-Id: <20230429015857.3027290-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230429015857.3027290-1-sashal@kernel.org>
References: <20230429015857.3027290-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit c83f320e55a49abd90629f42a72897afd579e0de ]

There are several 'malloc' calls in test_memcontrol, which can be
unsuccessful. This patch will add 'malloc' failures checking to
give more details about test's fail reasons and avoid possible
undefined behavior during the future null dereference (like the
one in alloc_anon_50M_check_swap function).

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 1e616a8c6a9cf..f4f7c0aef702b 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -98,6 +98,11 @@ static int alloc_anon_50M_check(const char *cgroup, void *arg)
 	int ret = -1;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
@@ -211,6 +216,11 @@ static int alloc_anon_noexit(const char *cgroup, void *arg)
 	char *buf, *ptr;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
@@ -778,6 +788,11 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 	int ret = -1;
 
 	buf = malloc(size);
+	if (buf == NULL) {
+		fprintf(stderr, "malloc() failed\n");
+		return -1;
+	}
+
 	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
 		*ptr = 0;
 
-- 
2.39.2

