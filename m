Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A726429BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 05:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhJLDDf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 23:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJLDDd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 23:03:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01C4C061570;
        Mon, 11 Oct 2021 20:01:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t15so2676717pfl.13;
        Mon, 11 Oct 2021 20:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMCytzgSZ3FsdSOFb5Ppvpt7FDy4HICMnNT5RYUnNMY=;
        b=ZZvCI+IWpcOzBSZFRoQ4p0Uh3753QA+4/hnULh2LKdY3+zrsOnKTHtHUVuBmEkcwKn
         Bqho4lQWmwJfqma+V+v534dMUd9h5dvFhuyIgW4w5gvgGxA/doVG0TlGMC2Y8A0I+LkZ
         LLdylk14M5dbHKRuNIEdSVjbo3HadhJZ0jfhS8XrP9oZiGZrpGx+zmAse9SpucwThh9/
         x+55iuYsk2lXxwGz1NlhSxGdYdjCmRdiqBzAxHLy9cvHoe8lYccBWrecZK+ryjfZdE+n
         eTYgvy0V1Iu5aNf6fIQ+526DMiF8fKp/0S5rzRRKiocNTp5g33JKLU/TjxJ/oMaTQuhZ
         FWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMCytzgSZ3FsdSOFb5Ppvpt7FDy4HICMnNT5RYUnNMY=;
        b=ykbMFNZMwIulqH4K5CGlA3q0kSekM6YvP2/6mA/T8P69I/wZPI/awqzGUXgxRQ2c9D
         FvJg6H3mVMN394VLCms0XUHFtvhs+SIbbaO+62nwsrdsbpZGaMmBQ1mat5eZzTED7O+A
         fNpHXLG1aSsV4lM9cs4u+aDfwKdxC3OC5Lw1hmppvnELaaVptti7f/pzimEQb6cv3Nlk
         DTOhd1gCoLlr3dTgTbs+owpG+68djOkNPWzzAhZMiktJaEKpibePAc7M0h/A5bxIKUaz
         hWLfPaIaG6LqzriRrGlVO9U3wdCXb0tdoFVSQ70oDf6O/8HfLWHxJj7uupvud3yB61yd
         ddyw==
X-Gm-Message-State: AOAM532ibYL599Q+h7YU7v4cD8doOprKnaQrDTtwGmqb1+9n8uFOqn5g
        SSGpY0o/ONf2FK3Hz27XbYI=
X-Google-Smtp-Source: ABdhPJySfeA3NkPC4FfFwnhlWMrGmUc41lxkXJ2BoSb4GTmdEWlk9TDD8NGtVRczHibbvSWS6EWVpA==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr29664983pfl.51.1634007691395;
        Mon, 11 Oct 2021 20:01:31 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id e15sm8739432pfc.134.2021.10.11.20.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:01:31 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Yang <davidcomponentone@gmail.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 11:01:16 +0800
Message-Id: <20211012030116.184027-1-davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./tools/testing/selftests/vm/split_huge_page_test.c:344:36-42:
ERROR: application of sizeof to pointer"
Using the "strlen" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 tools/testing/selftests/vm/split_huge_page_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
index 1af16d2c2a0a..52497b7b9f1d 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -341,7 +341,7 @@ void split_file_backed_thp(void)
 	}
 
 	/* write something to the file, so a file-backed THP can be allocated */
-	num_written = write(fd, tmpfs_loc, sizeof(tmpfs_loc));
+	num_written = write(fd, tmpfs_loc, strlen(tmpfs_loc) + 1);
 	close(fd);
 
 	if (num_written < 1) {
-- 
2.30.2

