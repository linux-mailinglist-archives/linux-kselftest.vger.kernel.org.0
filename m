Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBEF436CBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhJUVfw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhJUVfv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 17:35:51 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E586C061243
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 14:33:35 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a8so2161673ilj.10
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+9RQ1gHI6Eo8JuPymqsyKLdV5Ri8DOq7x3uGVF5r64=;
        b=T7eFuIpU7YmfCpGWZHOzJNdxX9cvRpJDwsJ9Y6il1NtbrD+9f4YFOX2Na6jUtKYVTK
         orosVDofcva9UZBr+8OrVVUIx5awBnDrRqq8N48EjjdBdeOJ+5rWIkrF5yHV3WAfr0yc
         UrtgmevpFqYkFhuyvUXlpgk/RIizjyMWfbDV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+9RQ1gHI6Eo8JuPymqsyKLdV5Ri8DOq7x3uGVF5r64=;
        b=zKpvi5MqUw/Kss3PVe4D+CRIgXVb1JIbubMaqm7t8YeXZOcKte6SvN+FPdWseNcpff
         wgeXrH13hErlkZD0FYsP+3KpeVMQE6mxVWyuPQVFXONgFkmBcRW73xYE5X9mpkfbgAPe
         xAGPSc2ZDmobymhh+Q6pUMSjiesCxkFmiMLbW/lMA68GH5N/LvkcIWIDGNTGHlfw2jfW
         XLJOYICr3E+4+vpNHaDXct4k4UEX/BQEQ9ya/q7RBmNmMLTOi9o2uqErf1KY71s+M/63
         tUV7zUXJZeVhf/P2lpDFMoVnmoz0Z+whNBrq8VNCoRTQdoS2it9b0DUh7CZgrwqtDGLg
         sDyg==
X-Gm-Message-State: AOAM532PYpTK8CWDCOelfapsTbtYns7iku0+Rm3vDrQGoZ3i4fdLrc/x
        flTke788Orpz1wsg1Enf9ZAmQSWtyz9ciA==
X-Google-Smtp-Source: ABdhPJxOjTr8/NCOQNOcS+SMT9tdakhHIuJb23QgMs6gK/z6v83mczVGktP5mCm45gbNs04DhMrsTg==
X-Received: by 2002:a92:cd4f:: with SMTP id v15mr3124404ilq.153.1634852014526;
        Thu, 21 Oct 2021 14:33:34 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t12sm467079ilm.2.2021.10.21.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:33:34 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: x86: fix [-Wstringop-overread] warn in test_process_vm_readv()
Date:   Thu, 21 Oct 2021 15:33:33 -0600
Message-Id: <20211021213333.38350-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following [-Wstringop-overread] by passing in the variable
instead of the value.

test_vsyscall.c: In function ‘test_process_vm_readv’:
test_vsyscall.c:500:22: warning: ‘__builtin_memcmp_eq’ specified bound 4096 exceeds source size 0 [-Wstringop-overread]
  500 |                 if (!memcmp(buf, (const void *)0xffffffffff600000, 4096)) {
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/x86/test_vsyscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 65c141ebfbbd..5b45e6986aea 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -497,7 +497,7 @@ static int test_process_vm_readv(void)
 	}
 
 	if (vsyscall_map_r) {
-		if (!memcmp(buf, (const void *)0xffffffffff600000, 4096)) {
+		if (!memcmp(buf, remote.iov_base, sizeof(buf))) {
 			printf("[OK]\tIt worked and read correct data\n");
 		} else {
 			printf("[FAIL]\tIt worked but returned incorrect data\n");
-- 
2.32.0

