Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77E11C331
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfLLC11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:27:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41943 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfLLC10 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:27:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id bd4so359022plb.8;
        Wed, 11 Dec 2019 18:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/DmT8fP3US2mNRD3KIo8GttDd8Q9fHyuiepw4gR6YTM=;
        b=IWjQO/l9nXA+wC1Ym8paKXg4dGklI6sUs1iXWfivJqky3o8bmn7PQtRDp70OMewQlt
         SUOdZn1Li9dh1zEjX8F0owKAjNZoQbF6WRl/zf2zFTa3eKOhKp1cQ+JHJaCWfRpswaG9
         d3CR5SnOodSzgKW3jiN/5KzMgonhyDPHYgPkZdWR9sMh9XhAvILFzwxzeae8XVZBMW1S
         EdXBRpk7dZGvMvmUMRM+MMJ5fhzdEXptiWMkCYVm+RARmebz/xvFeoesFrywKvhgd7/E
         oz2r8O5g3iV2RCDrPYTbTytdd560pIf0p4picOrrjTfEzSvrFmPKj/gssVQoDzuVmIvs
         vHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/DmT8fP3US2mNRD3KIo8GttDd8Q9fHyuiepw4gR6YTM=;
        b=lApoQfe5VRfXEroDzq3DKZWCtOUVmXFyECLIXJSNpyQC+IH5WfdbenRSvhV+QLf6vf
         3+5BbUtyfpBY8EOFUHxnlHm4STFf7TgXrh7C8Q6Z2aXVheGYNOZKL1pKI7uQUWAbnZAJ
         oWpekL1jAFH7ijjBcz5m6IioUivzC6bHWQjgCtVOU3Mxoz22Hc/+xebO7g8a+Zv+vWN7
         aIiZYWDN4zwzpgM7Oi6/lJt766CVILZROa6picBlEgI7vbY4XcG07JSaa9E/nzZnH//W
         R8j1DsSFsfWj2bVhO+EvNugrvNuDQ2awu6LFj78VT6zhnVd4vQQ5X+TqJOo4d/rmauiO
         BFPQ==
X-Gm-Message-State: APjAAAV0RFVr3LbvvsQywH7BOx5jhmE6d7GMCJg7Bru71Fqw0UVp5QLj
        oWfMFe0mP99rcG2Kz0JxwGs=
X-Google-Smtp-Source: APXvYqwBumUYoleJ4JkKcZMjBqM+8PzAINuXP+9ZxfdCNfDzpF/L6otz74Q/se6CCbe/R5apuGhYmw==
X-Received: by 2002:a17:902:ff10:: with SMTP id f16mr6938529plj.312.1576117645778;
        Wed, 11 Dec 2019 18:27:25 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id d22sm4245173pgg.52.2019.12.11.18.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 18:27:25 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sj38.park@gmail.com,
        sjpark@amazon.de
Subject: [PATCH v6 3/6] kunit: Create default config in '--build_dir'
Date:   Thu, 12 Dec 2019 02:27:08 +0000
Message-Id: <20191212022711.10062-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
References: <20191212022711.10062-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If both '--build_dir' and '--defconfig' are given, the handling of
'--defconfig' ignores '--build_dir' option.  This commit modifies the
behavior to respect '--build_dir' option.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Suggested-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 11 +++++++++--
 tools/testing/kunit/kunit_kernel.py |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f8f26951cd1b..5b222418eacd 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -31,9 +31,9 @@ class KunitStatus(Enum):
 	TEST_FAILURE = auto()
 
 def create_default_kunitconfig():
-	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+	if not os.path.exists(kunit_kernel.kunitconfig_path):
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
-				kunit_kernel.KUNITCONFIG_PATH)
+				kunit_kernel.kunitconfig_path)
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
@@ -114,6 +114,13 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
 		if cli_args.defconfig:
 			create_default_kunitconfig()
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf3876835331..c04a12e2f711 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,7 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
-KUNITCONFIG_PATH = 'kunitconfig'
+kunitconfig_path = 'kunitconfig'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -82,7 +82,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(KUNITCONFIG_PATH)
+		self._kconfig.read_from_file(kunitconfig_path)
 		self._ops = LinuxSourceTreeOperations()
 
 	def clean(self):
-- 
2.17.1

