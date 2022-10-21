Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899BA608167
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Oct 2022 00:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJUWSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 18:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJUWS2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:28 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0BB2AB11A
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 15:18:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q11so2368200ilj.10
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEShaJ32qONw6Ik3PO9e5EbC1hloeWQUD82bcXUGSI8=;
        b=fEx4OTp+x4ZE3H0fyqrFYVgdQxHMwlNZn9v+cFhrbYHz7TvbhSRwcHFDCONm6rROR8
         KZGHntnFCQuRr909vmwZQjb1lJgqJpCwL/jigAYpuLI7eCLxKzlne6Wm2rIiNKrhBxYi
         CLeJjlNpmomCTYwKuAhN9vxHI8n2g7ByAVVV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEShaJ32qONw6Ik3PO9e5EbC1hloeWQUD82bcXUGSI8=;
        b=Ld/XZrCQ6RRueSWKdKjgAbCrLTqhJC6Nkj4H5PuvZgTj1pUiXqmcfC6x3YCGWzSzSv
         seaLtj9Q78cW48x4CFW6zYbKfRUS8bSSB6PGF5IZDQpc4y1DGp6PXVUuIgBIDlW8JH9p
         gfFyXGSmAy2+vydb4pq7jPIP8VSBnxaAPXNw+LR9R7SzLozk+Q34wMsvHrsl3NyWbvt0
         TrDx5GyLyJNjwoDGFoEkiJrn1RX9QoQmkdpNP5jQD0Tr3EYUxY+gb20VVqPbsllMhnAu
         bvbS5gXIbwu5XZkbaN+KH9CQ2OxxlPATs90v1ZIRUuxXm4MdqIAArKhzb9OW7mD9WkVL
         iqpg==
X-Gm-Message-State: ACrzQf0YpPSMtZSqvBcpf1WoO3FXxU/ZtLTY+dwfyHENvjiDcfAWTh1O
        ddlDzZ7uYVxAwPJYA0PQh5CKmQ==
X-Google-Smtp-Source: AMsMyM6lM/rYjfxg+jLPtpZy6aJxXUzDKCO0FalDgdayZH+Xuieo7F5XlhyjFLFaCIc2/6eX9SdmgQ==
X-Received: by 2002:a05:6e02:184d:b0:2fc:2d17:4fbf with SMTP id b13-20020a056e02184d00b002fc2d174fbfmr14693702ilv.150.1666390705483;
        Fri, 21 Oct 2022 15:18:25 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056638480600b0036cc14af7adsm430740jab.149.2022.10.21.15.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:18:24 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftests/watchdog: add test for WDIOC_GETTEMP
Date:   Fri, 21 Oct 2022 16:18:19 -0600
Message-Id: <2b559a7d0d2be46729f3a03dc639dd4a69e465bb.1666390362.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666390362.git.skhan@linuxfoundation.org>
References: <cover.1666390362.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test for WDIOC_GETTEMP and this ioctl might not be supported by some
devices and if it is this test will print the following message:

Inappropriate ioctl for device

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 03103eaa946c..5ec0384b7f02 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
 * Watchdog Driver Test Program
-* - Tests all ioctls except WDIOC_GETTEMP
+* - Tests all ioctls
 * - Tests Magic Close - CONFIG_WATCHDOG_NOWAYOUT
 * - Could be tested against softdog driver on systems that
 *   don't have watchdog hadrware.
-* - TODO:
-* - Enhance test to add coverage for WDIOC_GETTEMP.
 *
 * Reference: Documentation/watchdog/watchdog-api.rst
  */
@@ -177,6 +175,7 @@ int main(int argc, char *argv[])
 	int oneshot = 0;
 	char *file = "/dev/watchdog";
 	struct watchdog_info info;
+	int temperature;
 
 	setbuf(stdout, NULL);
 
@@ -255,6 +254,12 @@ int main(int argc, char *argv[])
 				print_status(flags);
 			else
 				printf("WDIOC_GETSTATUS error '%s'\n", strerror(errno));
+			ret = ioctl(fd, WDIOC_GETTEMP, &temperature);
+			if (ret)
+				printf("WDIOC_GETTEMP: '%s'\n", strerror(errno));
+			else
+				printf("Temeprature: %d\n", temperature);
+
 			break;
 		case 't':
 			flags = strtoul(optarg, NULL, 0);
-- 
2.34.1

