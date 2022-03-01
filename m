Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372EF4C806B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Mar 2022 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiCABoz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 20:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiCABoy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 20:44:54 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E710BE9;
        Mon, 28 Feb 2022 17:44:14 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f18so8763139qtb.3;
        Mon, 28 Feb 2022 17:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijVtiJoCX033kgglssHFDQK/4oP5FPrgwPvKftWG7NU=;
        b=ol4DQL0ca5JemLcFkQ8DxS87cD8v1ik9zyBS6qePe4NhbB1LmjzqdSFTsT5TMCtPeJ
         Y1363nX8zXjBQBQe6XDnw3x3+PfXuKZcGgnxG8WkPZmLftKMniKr1DpFEh3ZYH+QAiDe
         vTwLrG/UqXyTQWVdWqGkRGEQapO/1QmYLn0swRkhFvo0hGEVwJxo9/XX4nUP/PqE0yed
         ckWU3gq/c9umPznNczYWFwZdywTmLrsZ5f2McdXZMoVCCjPMO3zHNaquJt6Ey7A3RTLa
         j7JDCGy17bZR2YE1vQaYiDGWpoagd4qLTyTIDxKnkVfYuBboVFkPkPQYpgB4bicQJ6cU
         ddww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijVtiJoCX033kgglssHFDQK/4oP5FPrgwPvKftWG7NU=;
        b=nU2VC7M92PEp+geuB6A1oVCj29dsBu/G9i189lPSD9b4wjTvHjakVeY0YNPe4VlkPw
         eZEd6RhvLwFbtV4hRacpZT14nicDDKPBntD2G/WfuokYO4ELHbQj+w1lVLSxpQiUHN2s
         gxYvKDZDERTk8HcOkI4N1ZOUYbfqw2m/ANIqHFNL/dK5s9qS4/2/W5Lq3nsuav+4t5dM
         +Avy88fpgBocYk9grqDCiRA0siRcN8Y0S2426dItsnnHGyD3PrJrp/qzPcbhz+yx7lxZ
         S1dRnYGjTP4fVebXLTdpeX0PhQGwgXDp+8DmNV/2TVSeCEi23igc0vpQgnOOod0okwR/
         mIog==
X-Gm-Message-State: AOAM5314Npqhv1b/eFPNB2Rw4zvOYdgief4WdMPfdPvcsnFzqWfT3UqI
        sySKU0ZFR9wZq/xjfnrvIJ6Psk999Oo=
X-Google-Smtp-Source: ABdhPJyxWuV2ytRAvxyA9QC3jVUgo0v+W1A5Mo1+hRGqwRivfKaS8N8n31zbv1Ynuht0e2JMNYBuUA==
X-Received: by 2002:a05:622a:4ca:b0:2de:91c4:3d7c with SMTP id q10-20020a05622a04ca00b002de91c43d7cmr19030405qtx.618.1646099053438;
        Mon, 28 Feb 2022 17:44:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a051300b002dff3437923sm6492305qtx.11.2022.02.28.17.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:44:13 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lv Ruyi (CGEL ZTE)" <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] selftests: vm: remove duplicated macro and use swap() to make code cleaner
Date:   Tue,  1 Mar 2022 01:44:04 +0000
Message-Id: <20220301014404.2052655-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Lv Ruyi (CGEL ZTE)" <lv.ruyi@zte.com.cn>

The macro is duplicated, so remove one. And use swap to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
---
 tools/testing/selftests/vm/userfaultfd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index ab394e6bff43..100f08362164 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -121,9 +121,6 @@ struct uffd_stats {
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
-#define swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
-
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"
@@ -1424,7 +1421,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 static int userfaultfd_stress(void)
 {
 	void *area;
-	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
@@ -1535,13 +1531,8 @@ static int userfaultfd_stress(void)
 					    count_verify[nr], nr);
 
 		/* prepare next bounce */
-		tmp_area = area_src;
-		area_src = area_dst;
-		area_dst = tmp_area;
-
-		tmp_area = area_src_alias;
-		area_src_alias = area_dst_alias;
-		area_dst_alias = tmp_area;
+		swap(area_src, area_dst);
+		swap(area_src_alias, area_dst_alias);
 
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
-- 
2.25.1

