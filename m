Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0871D3F2540
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 05:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbhHTDZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 23:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhHTDZc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 23:25:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C4C061575;
        Thu, 19 Aug 2021 20:24:55 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bk29so3786583qkb.8;
        Thu, 19 Aug 2021 20:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF5bhbYoJf9SXOblGMdmj7Y+6qx0GyikKNHYj6CQ+rg=;
        b=HnwPaAA70RowsHgQJXQNjtcr9MDcOcmnElroFhPNOIxfA6HkB73Tc+ER429vv+O/1a
         BBhtbNN8Z0pwDiNYUv89XvakXdkqApjJJ1FOMchg97U3QYHNxI+ZXkbBqazCJ5Z7ScXv
         T3w4xKbAEn3KlvtZQQnldK79GfRwVKyFyqr6DMG51buW68m5cMXrBfthmGqDbsifZiy4
         BGC9UBY+5DcSnNNfpjdlFv8eC/ixszQ/otl0sAgamJEc0GATQreuIpFsTzOLAWQ8AtAY
         VQv94kc/c+iWA7L0RlbKPdreMle1J2DIQPCrP4SkLdVEDsxnFHiKyLf3h9IkmpiGQoin
         mJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF5bhbYoJf9SXOblGMdmj7Y+6qx0GyikKNHYj6CQ+rg=;
        b=tZS/p4ZqfDTGKcIxEDzfHwptM9qqMnZEgefwZUFWZmOc9qduNggjMhIVmi2/h/4/2V
         qFkr0lwceAtT5CAj15J1r+M9a6cqF6n/hzQQ+KXkE+D1SCcybIpcY9ahTmm5v37xcCxm
         80HK3CGI2Ck7S9KMV2lvUVudIsTlzQmZvPrgwVYtXnjje/A50zQEp1BDhZyawnxkoPOU
         yG6FwE41mZQnPwaU3NaizFvjCzMFlv0kBQprgYPh/mHqIkoQfI4ONpqKcSO6hZ9dCpVS
         2/BcRWIZMc6DJXDggxsa5m6v7UXJlR6LC2hBNAmJ+V0qN13d4RRtpaJf5cCWYwMQU1fv
         dVOg==
X-Gm-Message-State: AOAM530JmlXDoeH8QX9ETakNZDiAxfL/UIMRE/AaNl9qY0A1hQVA/zAr
        CenOTdH/60ZstqUMUnDHgLw=
X-Google-Smtp-Source: ABdhPJyWSdkAUQQwApTH15HwRfS5OXow5G9my1pLg9cueDS+K+Xhm9vaUzJNV9mgi4CmC9+DfE3Epw==
X-Received: by 2002:a37:67d7:: with SMTP id b206mr6833446qkc.395.1629429894761;
        Thu, 19 Aug 2021 20:24:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y15sm2523164qko.78.2021.08.19.20.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:24:54 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] testing/vm/: fix application of sizeof to pointer
Date:   Thu, 19 Aug 2021 20:24:30 -0700
Message-Id: <20210820032430.12948-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

sizeof when applied to a pointer typed expression gives the size of the
pointer.

./tools/testing/selftests/vm/split_huge_page_test.c:344:36-42: ERROR application
of sizeof to pointer

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 tools/testing/selftests/vm/split_huge_page_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
index 1af16d2..54bf57f 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -341,7 +341,7 @@ void split_file_backed_thp(void)
 	}
 
 	/* write something to the file, so a file-backed THP can be allocated */
-	num_written = write(fd, tmpfs_loc, sizeof(tmpfs_loc));
+	num_written = write(fd, tmpfs_loc, sizeof(*tmpfs_loc));
 	close(fd);
 
 	if (num_written < 1) {
-- 
1.8.3.1


