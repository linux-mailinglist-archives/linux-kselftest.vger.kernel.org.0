Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DA449D33B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 21:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiAZUNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 15:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiAZUNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 15:13:48 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269FEC06173B
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:13:48 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso411381ott.7
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzbj8zCgavNPOsqdAJKfKx15yXUuBarV4g88BfwJ5Uw=;
        b=EiCjf/dXx6PcwQfYyD5Mtu4jSLNd5zEa47wWx2U5haMMbtJEQhSPeTaHqEOzI96wE+
         2RGa+InuUKeD//habRPfunHmUIU05w2nCr0vL/0LA71m8HO9bM2k0p26IOaae29ZCfw6
         3LkAnT/jvGR05sDRNIQR+dYLOxsdW7rR1X7Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzbj8zCgavNPOsqdAJKfKx15yXUuBarV4g88BfwJ5Uw=;
        b=ZaVBgdTlI5p3LnXF8nfWw/HNWj8TechUrH0tLQ9ETJTxm/LZIZdOV8hXyyQA++w8uC
         Kj2GMT2HER0Yhg3jJvsmyBV6UoIWa91ngWb6X3nJkfPh0TRt2TAQPB3xduY9k0EvWebz
         zgVbqGzHb7eFhbkgeZz9xlOtUAeIVvQDz2hNalOXqxFTeoqHIj02qbAZFRrVL97N5vgi
         G9v3kVF9Vp+RXe8liLs3gze3cg9wcfb3bTJQY6+0lvF5yBgtMlTvVqioetoO0yo56NpN
         0ADkMbwQooZKCTu6O+DlyY3Uj42iCUqPVtSMJvmBzt7ouT3WdBthuZrcFBTueUFi5Sig
         8mYA==
X-Gm-Message-State: AOAM53356RPPHt08McBHX8uZ9lO7d61p6kxB16Mwab5Sd3KITPArlPm7
        RcNo91jHg4vNPbtw8HaPQ/TvFQ==
X-Google-Smtp-Source: ABdhPJwOLiJkefCmcpRy9PRna8y1Dkefx1bROzrpi2irVbbFBq3filLVRABU/M8eHV6GzXHir5v5Og==
X-Received: by 2002:a05:6830:4491:: with SMTP id r17mr319589otv.112.1643228027463;
        Wed, 26 Jan 2022 12:13:47 -0800 (PST)
Received: from shuah-tx13.internal ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a128sm5993573oob.17.2022.01.26.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:13:47 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/kselftest: clarify running mainline tests on stables
Date:   Wed, 26 Jan 2022 13:13:41 -0700
Message-Id: <20220126201341.55771-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the document to clarifiy support for running mainline
kselftest on stable releases and the reasons for not removing
test code that can test older kernels.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/dev-tools/kselftest.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index dcefee707ccd..a833ecf12fbc 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -7,6 +7,14 @@ directory. These are intended to be small tests to exercise individual code
 paths in the kernel. Tests are intended to be run after building, installing
 and booting a kernel.
 
+Kselftest from mainline can be run on older stable kernels. Running tests
+from mainline offers the best coverage. Several test rings run mainline
+kselftest suite on stable releases. The reason is that when a new test
+gets added to test existing code to regression test a bug, we should be
+able to run that test on an older kernel. Hence, it is important to keep
+code that can still test an older kernel and make sure it skips the test
+gracefully on newer releases.
+
 You can find additional information on Kselftest framework, how to
 write new tests using the framework on Kselftest wiki:
 
-- 
2.32.0

