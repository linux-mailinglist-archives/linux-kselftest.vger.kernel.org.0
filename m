Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE2AB7B7
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfIFMFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 08:05:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43654 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389271AbfIFMFy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 08:05:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so1575302wrx.10;
        Fri, 06 Sep 2019 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3MsjuI+jLglUEwbd8AXZzmHdZN7fGCEk4aCyF3JBrpI=;
        b=Zz7wbT7D3FjCaR4fcNdo4uCNEAvBEGLURPBI2ys0hsQe3GTMJDa+Wmqd63ymtJmv4S
         7AeKc442JyAvPCFCqH8WZqWvrM8FrY5hwTRE0Z0rf2s286oqKdLuvUjsAjDhQ9KqAzcQ
         yS+zxp8YwdgtBLwT/kSwMn9+PFmo00xoxySMw+dnhBnVv+mi7X8PSf39R/WoqsXxSDEd
         SKra5f96K1AWw8WrUTo8Usf3wqxeqcKxv8O67W0fBPhhSCKEj072uQuBjeCAHcv5F5nU
         Kz7hbdHpzaQl1wryvG+7xu+HWKLw+313smtGWNbHSuN0fRTpdCa7aAyLbaAcqbS3oY5E
         6GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3MsjuI+jLglUEwbd8AXZzmHdZN7fGCEk4aCyF3JBrpI=;
        b=qeFYyq4u+PVPuERv1KLj7hoO7Y4tZ4HwbaH0N1A8wAoKDWBM9c6XicnG3y0mjwX7+d
         VqtbdmI3+veix0UMBUfvi9AXqssX8dLBUTcef+aM85stJN7lSinf80+DwOwCCdcz7/f/
         Fje5MNCE7xExceVgPCi2ym7uC7WbA0u4aarwZrgQ4EEht7r2CppSCycafAoXnaH7wzNG
         nso6zjpt7ddEA5XZH23BJL6vwNcKQYRFBdvPpBiBvSBkZ7DGNhPbpO51JspsH1+VkVQU
         i4kOA9GLDNwpBBy4HBPNc60NRolAQvScA+1SJV3f2q/vhjcOhAszr1Jobwsm5WmDZKRV
         XcdA==
X-Gm-Message-State: APjAAAWcD0OozSMS3Uof/igVCixukWD8vOO5zUnrmuAB34g+107A+sOA
        DACMlKE/TQryBWy6DX2lz6k=
X-Google-Smtp-Source: APXvYqwbcDRA7+51fS8+sh+zSo/JveupA+DXpdeADf0df4rX31lKt4Ca7rclYd9CHOpTjb/GXMpIrA==
X-Received: by 2002:adf:f00b:: with SMTP id j11mr6654541wro.298.1567771552196;
        Fri, 06 Sep 2019 05:05:52 -0700 (PDT)
Received: from localhost.localdomain (bl5-208-252.dsl.telepac.pt. [82.154.208.252])
        by smtp.gmail.com with ESMTPSA id l2sm6233851wme.36.2019.09.06.05.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 05:05:51 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     shuah@kernel.org, brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH] kunit: Fix '--build_dir' option
Date:   Fri,  6 Sep 2019 21:05:41 +0900
Message-Id: <1567771541-7690-1-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit fails to run with '--build_dir' option because the option is not
properly sent to kernel running procedure.  This commit fixes the
problem.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 tools/testing/kunit/kunit.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 8d33980..e016430 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -62,9 +62,11 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 					      'Tests not Parsed.')
 	if request.raw_output:
 		kunit_parser.raw_output(
-			linux.run_kernel(timeout=request.timeout))
+			linux.run_kernel(timeout=request.timeout,
+					 build_dir=request.build_dir))
 	else:
-		kunit_output = linux.run_kernel(timeout=request.timeout)
+		kunit_output = linux.run_kernel(timeout=request.timeout,
+						build_dir=request.build_dir)
 		test_result = kunit_parser.parse_run_tests(kunit_output)
 	test_end = time.time()
 
-- 
2.7.4

