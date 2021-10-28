Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE343DFEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ1L0E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1L0E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 07:26:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF6C061570;
        Thu, 28 Oct 2021 04:23:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa4so4445883pjb.2;
        Thu, 28 Oct 2021 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvnootBtDGVgLyDMhxKtt7j81OcPK/yRLbkFlYIzag8=;
        b=E+fFVcTV7AN2DNE8DwXVmv1OniOy3ZL4cwkZIK6QM03yC6+AcEA+AOSVx0kfHyY48c
         pKRShfobTaldoT1EzJaGCAkXh2rlwcV3xBb3VaOByoK0MKAXkfxiTdeACsvVo8kDa+PN
         VKWVkdg06o0vpSxt9t/Mtr8k/4i2fQz2zXRxOGVC2Fse7J1zPUnQVFaWnQ9pyXgmRYxQ
         2qAuVRGfO9Sx5qsSL7wyOhOEE4D2i3YdnQE2xRw+TnwXGyekz5cvjZ3nplhArQfCud9B
         bdw1QwyWv1AhpGu27RPrj7llu8qI16NZJy2iRw3pfmpjxLDrWN6W8o5mrL58esrRop3l
         b5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvnootBtDGVgLyDMhxKtt7j81OcPK/yRLbkFlYIzag8=;
        b=xV9wgLiD2EUTiCYrPXa9R1gpElYN1TB3WtcO4YyJJZyhOZ3hGcUXyRe25MfsLsDoho
         5s9SOqBjSYsTWUk8WspM9Zd+gS+ntrRguoeVAT2o5Iz0Nfj2l2rgwsAXifQ24Tkx8oEY
         4TJTgXeJWxUg+4fz3rQfbFxyi5bqtAlbgkngN9ZkahmZxvTZ/E9G7wwCDqyhj2KDv4o2
         1v9zD4Ipi4/8z5IsuYaz1hG+pQWT2qIPYbqp+F122ouK4ppTOPhs73IAzmwW7HqugiFY
         J82xWrhZQiksxHZuU7Wv8CsVHlr1AgEtKt9V2lFsS3+EvliGf9gg4vNtyqvpypAp2Uei
         Zegg==
X-Gm-Message-State: AOAM530dEnIx/gr29RRZLsqP2Tjc9psn+VnxzwA/NwYDUYvlHGw+LCvM
        2uKyWWYVFb4umS5Ta0OslUIjeYFmfk8=
X-Google-Smtp-Source: ABdhPJxcrr9mZ0anG9vgeQ1+PV0mOQX8OeiZ6bW53lFUNbMY7klUyxliQzquDXfFyqoiGpp9tgwa3Q==
X-Received: by 2002:a17:902:6b4a:b0:13f:8e99:2149 with SMTP id g10-20020a1709026b4a00b0013f8e992149mr3340883plt.87.1635420217299;
        Thu, 28 Oct 2021 04:23:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x26sm3142758pff.25.2021.10.28.04.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:23:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] userfaultfd/selftests: use swap() to make code cleaner
Date:   Thu, 28 Oct 2021 11:23:31 +0000
Message-Id: <20211028112331.16152-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use swap() in order to make code cleaner. Issue found by coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/testing/selftests/vm/userfaultfd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 8a09057d2f22..41dfe6f4ebfb 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1413,7 +1413,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 static int userfaultfd_stress(void)
 {
 	void *area;
-	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
@@ -1524,13 +1523,8 @@ static int userfaultfd_stress(void)
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

