Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280CA2762F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWVTr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIWVTr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 17:19:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B6C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 14:19:46 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 139so658293qkl.11
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=TH7NITt1/yHWLLqIMcLUH9XOOzYm0k8mnM3wRK4YRh8=;
        b=WgG8VKS18X+Z+jXJohpNfVgAhGpTnwAYZbGIWi+8sGilAcec/NVcKG5BlYbMnM8Qxo
         QaAc4E3ThgHPxOZx+QeuMvr4ynnOTly5AHb11TJcpRvcycNfW+CU07vyXZTYaI4pTPNv
         bOuaL8pokxQSWjwCaAbtkVyXrLnyfX+Udjpi4uwfMmg1Lda7d31f/Dfn4MfpbO9k6Koe
         acj8k8k1BRIYBtX7hzST5Qxk1xBtt+to87EAliTUqE5H2lDFM9MGUQGcN28+kEmeLK8u
         BV6956ogKNdVDwfmwOzK8UsCcgFWc8vdOFfHLV1lRdlB9jmCWVr4MVXWqZQpHeethTLS
         I60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=TH7NITt1/yHWLLqIMcLUH9XOOzYm0k8mnM3wRK4YRh8=;
        b=gnJvkGhShBlKDgaC2vlZuTPCy8Y6VLmtCNdo56HNzhGU3z+gAWznVisqSVYfqob6mr
         A+gPn7h50+iniHdpCpTLas97jnYuppcV/zLV4ljLJjHT4MFCDIehdo2ZW0N8j2rc1rX4
         Mca6mSCVS29nqKUrpk/LxxAd+5KVshKJQbingLBOXtdayk1ZmZcoKgrOqbZ2am65XqNl
         oa4U+YYQccsqM2j/dfpc1e5/sXDhl2b1p14nFnSuQRDdc2cuL9MzBLxNiZc1EAXaTGlt
         qpWywPa/ZgR8+rhGrqU2hTzmINBvyHzrVcQAHwgI4i83GoTHYbs5xPenphzTKoXPXS8W
         wDLg==
X-Gm-Message-State: AOAM532RDFTrQcX4WedzR8KnAE4b0vGq3sYFwaLa/ZtBo31cktfG6O5C
        zoNArAIM1EUGig54SzgqGmfil6uIFF/m0YWA+FGdIg==
X-Google-Smtp-Source: ABdhPJw43+sjSUo7FKERKf2xCxxc8JPOYcaeJHrxsWgON3azJYYkTt6PQXCKR9w1wBB51KBkOXp8oqPSBu6aZD1+dNNVJQ==
Sender: "brendanhiggins via sendgmr" 
        <brendanhiggins@mactruck.svl.corp.google.com>
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:1:c634:6bff:fe71:d8d1])
 (user=brendanhiggins job=sendgmr) by 2002:a0c:eac5:: with SMTP id
 y5mr2205279qvp.2.1600895985596; Wed, 23 Sep 2020 14:19:45 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:19:38 -0700
Message-Id: <20200923211938.3727976-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v1] kunit: tool: fix --alltests flag
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Alltests flag evidently stopped working when run from outside of the
root of the source tree, so fix that. Also add an additional broken
config to the broken_on_uml config.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/configs/broken_on_uml.config |  1 +
 tools/testing/kunit/kunit_kernel.py              | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
index 239b9f03da2c..a7f0603d33f6 100644
--- a/tools/testing/kunit/configs/broken_on_uml.config
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -39,3 +39,4 @@
 # CONFIG_QCOM_CPR is not set
 # CONFIG_RESET_BRCMSTB_RESCAL is not set
 # CONFIG_RESET_INTEL_GW is not set
+# CONFIG_ADI_AXI_ADC is not set
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index e20e2056cb38..1b1826500f61 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -53,18 +53,23 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
-	def make_allyesconfig(self):
+	def make_allyesconfig(self, build_dir, make_options):
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
+		command = ['make', 'ARCH=um', 'allyesconfig']
+		if make_options:
+			command.extend(make_options)
+		if build_dir:
+			command += ['O=' + build_dir]
 		process = subprocess.Popen(
-			['make', 'ARCH=um', 'allyesconfig'],
+			command,
 			stdout=subprocess.DEVNULL,
 			stderr=subprocess.STDOUT)
 		process.wait()
 		kunit_parser.print_with_timestamp(
 			'Disabling broken configs to run KUnit tests...')
 		with ExitStack() as es:
-			config = open(KCONFIG_PATH, 'a')
+			config = open(get_kconfig_path(build_dir), 'a')
 			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
 			config.write(disable)
 		kunit_parser.print_with_timestamp(
@@ -161,9 +166,9 @@ class LinuxSourceTree(object):
 			return self.build_config(build_dir, make_options)
 
 	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
-		if alltests:
-			self._ops.make_allyesconfig()
 		try:
+			if alltests:
+				self._ops.make_allyesconfig(build_dir, make_options)
 			self._ops.make_olddefconfig(build_dir, make_options)
 			self._ops.make(jobs, build_dir, make_options)
 		except (ConfigError, BuildError) as e:

base-commit: 92a2b470086f68bf35eb9f94b6cb5ebdfac41b25
-- 
2.28.0.681.g6f77f65b4e-goog

