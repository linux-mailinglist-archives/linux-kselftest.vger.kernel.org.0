Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92967B259
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 13:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjAYMIX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 07:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjAYMIW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 07:08:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93629DE;
        Wed, 25 Jan 2023 04:08:17 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o20so28596229lfk.5;
        Wed, 25 Jan 2023 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoZq3tlgCy0RO1N45CDLCeGiReKfRSVizOBtVP9nDzc=;
        b=FkgGqf6pFK7wGQSQRWumeQ0T72S3FmEwJU9nlIzIK9S4yd/bSWsDipcG7ga7Xn95wl
         ktkdqwppeOXPM9BN+Fk2nJ2ph/hy8qA+jfrhbxF0MtsPOQ5InxIJQZiaYHdvEacvS+gE
         e/vCxNLsD3D5P+7D+uVUM5xc0ASeyATrpRPfFOykjuD2dfgofzUtQXFpk5koWxW6j+pd
         rG7Y6TUeTurttpce8ZY9FGx/h2GSCi+RNPKRpn//uQI/C+nnHPKSRNm4wo7d35GH5SBJ
         C9IA8Q8+H7z8mecYTHNoq0uH8B5pD/xBTpM4JLzfCMBIOYBvhnqB0NeFZ+CBa327Sjmk
         RY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoZq3tlgCy0RO1N45CDLCeGiReKfRSVizOBtVP9nDzc=;
        b=OZkUa3u9CLUbR5HYYg2JNt5k6EcshXG3BJBmX19QfS7B1PzhFMU4aGLKPYI7t3ivIf
         47gveqou5oSAB3pYTCcsyIkXYOm75zdBK/mhqpjaqVI2ngVbBQGSvYdOmf30tswHj/lI
         iQ13GpAMUYtIr7Ed9vGvVA0oWIRt/IboisW4P1Ghd6LwB/XgiShniuca5rCPhQ9vSRYs
         UNWCyQ9+TIDDjM64XnAfBx0ZTgQpLCY0g37OfHN9SD1CsrAzMrkO29TZ+CMtpSyPtA2x
         JOP4uKVnC7Rwu7y+8+Qr0IBx+ONYkvfNubreIrOHyYW9C6levqTyfOhta71syTVw64Kr
         xSiA==
X-Gm-Message-State: AFqh2kq1x7k2VlOjA1ofDV5sj+cyzfnVDcoIFfv8icLcxVYFPHlLUH6N
        ry0EPrKXXNH4dxU+fdxsqZk=
X-Google-Smtp-Source: AMrXdXuVdoxTwyxGGlwHoT8ad5HgFzjXvWdJ2ja4/0S59ul46fZMS6RKe1J4eyB/KeTE9gzAouItXQ==
X-Received: by 2002:a05:6512:b04:b0:4cc:7258:f178 with SMTP id w4-20020a0565120b0400b004cc7258f178mr15333338lfu.59.1674648495787;
        Wed, 25 Jan 2023 04:08:15 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.0])
        by smtp.gmail.com with ESMTPSA id b3-20020a0565120b8300b004b55ddeb7e3sm463311lfv.309.2023.01.25.04.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 04:08:15 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     davidgow@google.com
Cc:     dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] tools/testing/kunit/kunit.py: substitute if with elif
Date:   Wed, 25 Jan 2023 17:08:12 +0500
Message-Id: <20230125120812.5276-1-apantykhin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

No need to re-check for request.run_isolated with next if.

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/testing/kunit/kunit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 43fbe96318fe..2e20944eefb4 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -145,7 +145,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 		tests = _list_tests(linux, request)
 		if request.run_isolated == 'test':
 			filter_globs = tests
-		if request.run_isolated == 'suite':
+		elif request.run_isolated == 'suite':
 			filter_globs = _suites_from_test_list(tests)
 			# Apply the test-part of the user's glob, if present.
 			if '.' in request.filter_glob:
-- 
2.25.1

