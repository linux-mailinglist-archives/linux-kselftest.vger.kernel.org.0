Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3140CECA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhIOV3f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 17:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhIOV3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 17:29:33 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB66C061575
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 14:28:14 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a20so4475404ilq.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abD5VjgZ8HXnpuGs79I/oeyTYUiv/nSNnMDhyKm1NjA=;
        b=bXMRAJ3lq0L4NKgfxfIXFaQn9y67r8KHq74UuKDIgdXW+9uuRAmhVD8N2FK5bKbc2i
         ltoEJ9nnz0+T1YqTUs12ARBolb2rV81YIAKfb/9mXz3/Yb7LUHJ/qENYOt0RNlbtVcid
         7DarsEcQi4nmE7RYr91VbWjnBpMkV1/DhxULc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abD5VjgZ8HXnpuGs79I/oeyTYUiv/nSNnMDhyKm1NjA=;
        b=Dql0QUhP26jdfeP+8RjFXEBz/2vbgOHLzv4SFIMBwZ4xP0sVbwA2cH2MVrY0xz0dtg
         tetSWQOS27/Gys1+p4FR5G0m77Gj0OeL9Z2EOvlUmshj8s4SKlarvaou7X1Px6eCJjbV
         W0Zxvgj1wMTdztAY/ImVtyh9IEfINpmdTy1EmjY34XWYuKUX/Sof4D4bwWNOuJ7xVNgt
         uioaoLmSlWjtHBhONQg39A1NPkFzWU1el9XiX7zDbX/XArGsqYQdl1+C5/2ygMhQ9ph/
         /I4RNBg83jPJ8P6iM/w4NnzobT1BBwuJeo3UXaljQeRWA6n9vi7bidqOIFqHWBC8jR2C
         nzmQ==
X-Gm-Message-State: AOAM5320AdmAptZ66q8xEtdh97LEepviT9prr7aAJus2k3eHSRMWBJo2
        BJS1nl5H4WZW06URQZ6WoYnWqg==
X-Google-Smtp-Source: ABdhPJwyfCLdvAiMBlX3bMZgpmdcE88EYz+205FYgOhWU/DiM5nDofUhYa955dy+8nmOlsmstpxjLQ==
X-Received: by 2002:a05:6e02:12a3:: with SMTP id f3mr1593954ilr.54.1631741293603;
        Wed, 15 Sep 2021 14:28:13 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f2sm622884ioz.14.2021.09.15.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:28:12 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return warn
Date:   Wed, 15 Sep 2021 15:28:07 -0600
Message-Id: <ecac8f61fd0ec5c4e608fb0ed2c00016c05c1905.1631737524.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1631737524.git.skhan@linuxfoundation.org>
References: <cover.1631737524.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix get_trans_hugepagesz() to check fscanf() return value to get rid
of the following warning:

lib/test_util.c: In function ‘get_trans_hugepagesz’:
lib/test_util.c:138:2: warning: ignoring return value of ‘fscanf’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  138 |  fscanf(f, "%ld", &size);
      |  ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/lib/test_util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index af1031fed97f..938cd423643e 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -129,13 +129,16 @@ size_t get_trans_hugepagesz(void)
 {
 	size_t size;
 	FILE *f;
+	int ret;
 
 	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
 
 	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
 	TEST_ASSERT(f != NULL, "Error in opening transparent_hugepage/hpage_pmd_size");
 
-	fscanf(f, "%ld", &size);
+	ret = fscanf(f, "%ld", &size);
+	ret = fscanf(f, "%ld", &size);
+	TEST_ASSERT(ret < 1, "Error reading transparent_hugepage/hpage_pmd_size");
 	fclose(f);
 
 	return size;
-- 
2.30.2

