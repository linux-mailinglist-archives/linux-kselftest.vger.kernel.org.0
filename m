Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9769E43D82B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhJ1AhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 20:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1AhU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 20:37:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD75C061570;
        Wed, 27 Oct 2021 17:34:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so6525298pji.5;
        Wed, 27 Oct 2021 17:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sIa1ZOan1HJMn9VErgSz3i/hhv+xzoYibTldJx4MsU=;
        b=BX7k1nFwfzMbPy83sKVubBn8YhJeHNPBCZoS4NZWKY9zOKWqFG0wkRXOCNZUok0q51
         5sy+LjcOnmuOMgF+Acj6k+oBFPnrfeceVRd6p+n5bRZk4LpPKpl+Nsrt2eHsAeqUMlFo
         gKe72ikNOHeJ3zn3Hbfvjcev2R8njh1ju8f/y363/0AMjsENafLQDz6ARj8tgAOUPhbe
         h8GT2zzPwP+qr03IJ4DmsXZX/EOSL/7UnCBfqlwMNB6gApf746+p0eQGrDFSt9RJhcRj
         R4i6uuE98FjlDGsfrb6RuGBV6v5j6MP4UdfZHS9CU5nnVQOtRNx53ZQkhqNW1UpLWtFZ
         SZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sIa1ZOan1HJMn9VErgSz3i/hhv+xzoYibTldJx4MsU=;
        b=zy/8o/JWgw/gpXVFDTC6HgLmWA8UQVsMLnvLaLM02wAnDz3pl/nxjuw+stF+wVtpK9
         R/cZWvbCZtS55U93CFpZlWTnq/Y6Xo8Cts6rGHfHuR50OAKmyFGL7rusMnzwLRvoBzZF
         H9MWXo7/0Y9+qpJvbm2D/++G9rJEtVDKKp0rAeSf4/82ryM9pPPqouoRoogGHuLlCFjd
         gmuaff6ECjgQ3qC4T4TOvXuXL4HdB048/vWguovbsrmnCmziYaK+gWoUb4jLXY3OgN/j
         McHc9eFKiV6kGzHIit5URXIW+asGTFB1mNayePLfuKOafCE33y0lJmpC9dzb9/cwW+Tv
         mhSA==
X-Gm-Message-State: AOAM530fKQVpncO8s44XVPVAfpCxB/xHEOn0dR5nzlukgblwXGbzyd+6
        7RIsVJpIJO3Er7ycUv2Xdqo=
X-Google-Smtp-Source: ABdhPJyv4GCuYVbFnYeygYoIrjE67yxUSv1ATU6JLJU7IF8jy8zB0fGMETpY1xSKUHOFhJ5g0TbSFQ==
X-Received: by 2002:a17:902:bf4b:b0:13f:bf61:3867 with SMTP id u11-20020a170902bf4b00b0013fbf613867mr991589pls.22.1635381293765;
        Wed, 27 Oct 2021 17:34:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q18sm1157801pfj.46.2021.10.27.17.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:34:53 -0700 (PDT)
From:   Yang Guang <cgel.zte@gmail.com>
X-Google-Original-From: Yang Guang <yang.guang5@zte.com.cn>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftest/sgx: use swap() to make code cleaner
Date:   Thu, 28 Oct 2021 00:34:44 +0000
Message-Id: <20211028003444.7046-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Using swap() make it more readable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 tools/testing/selftests/sgx/sigstruct.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 92bbc5a15c39..47eb0749dba4 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -59,13 +59,10 @@ static void reverse_bytes(void *data, int length)
 {
 	int i = 0;
 	int j = length - 1;
-	uint8_t temp;
 	uint8_t *ptr = data;
 
 	while (i < j) {
-		temp = ptr[i];
-		ptr[i] = ptr[j];
-		ptr[j] = temp;
+		swap(ptr[i], ptr[j]);
 		i++;
 		j--;
 	}
-- 
2.30.2

