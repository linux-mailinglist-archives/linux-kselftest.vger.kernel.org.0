Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21475314D25
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 11:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBIKeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 05:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhBIKcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 05:32:07 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E216AC061788
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Feb 2021 02:31:26 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so12195224pgj.4
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Feb 2021 02:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hollensbe-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8x5bjyhrhxpfr+SaTWMkOJdi7iQIvki7V05/TEVvts=;
        b=X0QpyCnn+6C12ErnfFdxbvykHU0wINqehCpTcb7pThN++FyvRMtBPGxFRS5nCAcr7q
         Z9jrjlaVEXd8AtMgUpZlzcTl6wU09xczEQ4pyMX9JF1SJ+HgjkdnRy3Uvech5AD5hwVq
         7w7KCrczI4jsBpKY2I5fx2AJGDtE87qzSPUx81RqQzI4lWx2U07G/nOJ2TbgbpE2Nmgq
         zqvB41fNrW9cvVtc/NNR094KIi2rCidXMYIabFq9nhpy0O5Jw6rEhsDSP8yB4OZrRrkz
         /7KzIKQs3c8bV9CTm5RqnIqevsoTppZ+lelFxJb4kReFM19SXfsYciDFnd81GgBPWvNe
         6Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8x5bjyhrhxpfr+SaTWMkOJdi7iQIvki7V05/TEVvts=;
        b=tujcbwejb3ShUb8p+i2dXUOcQyoD3u5OmtMx8BywgkjQ2wY5v813dOa0A7QIBNUEla
         yR/4R8dq7uVsgDskPXkF40RS7SvvL0svwH7YzItFMPb6Y+0UNg6SPMuA62A9Ho/8A0PB
         Bf2w9ROO80ztlmq8go+5YgiyJ5O49Zb1zCg/HD3spGqjotzO88kMmVl4sET7xyOEhG4k
         Rkifhv1XszVWf61GUTKolDNsetnCeptw7SzOTFsqo8jZKwIr+u4H66xlfuYLTeSQTQCG
         969MQTh+eWlHKeRSWX2ec/4V2F3dL/dITDasI10/A9QRdc96v9H0uZ7WdwqqU/sDuiH7
         6Nmw==
X-Gm-Message-State: AOAM533yVFKDmgIP+1vtvaJtjq9uzq+cpabc+u6muwuQmJNTrwpqvySi
        7tGnAI6Aw4VDyCRqZCvfR4J3om3eG/LGZw==
X-Google-Smtp-Source: ABdhPJyfPs8O+XMHp2oASr8jzAAGDoZG2eYq8rJpP42AJfvSnXAfansh3jNgj6UmoUT+XEodXsrYyg==
X-Received: by 2002:a63:1561:: with SMTP id 33mr21960408pgv.13.1612866686130;
        Tue, 09 Feb 2021 02:31:26 -0800 (PST)
Received: from linuxdev.home ([104.220.82.74])
        by smtp.gmail.com with ESMTPSA id 14sm2070882pjf.10.2021.02.09.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 02:31:25 -0800 (PST)
From:   Erik Hollensbe <linux@hollensbe.org>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, skhan@linuxfoundation.org,
        Erik Hollensbe <linux@hollensbe.org>
Subject: [PATCH] selftests/gpio: Adjust .gitignore to ignore tools-gpio build dir
Date:   Tue,  9 Feb 2021 02:09:25 -0800
Message-Id: <20210209100924.82033-1-linux@hollensbe.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aadb7d9c-6042-0b4e-9d2a-764432ccf0ef@linuxfoundation.org>
References: <aadb7d9c-6042-0b4e-9d2a-764432ccf0ef@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch merely add this to gitignore, noticed while running the
selftests.

Signed-off-by: Erik Hollensbe <linux@hollensbe.org>
---
 tools/testing/selftests/gpio/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
index 4c69408f3e84..640b5cb4ed4e 100644
--- a/tools/testing/selftests/gpio/.gitignore
+++ b/tools/testing/selftests/gpio/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 gpio-mockup-chardev
+tools-gpio
-- 
2.25.1

