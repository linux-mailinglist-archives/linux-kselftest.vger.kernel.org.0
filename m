Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC510A497
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKZTda (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 14:33:30 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49652 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfKZTda (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 14:33:30 -0500
Received: by mail-pf1-f202.google.com with SMTP id r187so12463614pfc.16
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LZgbozaMv2++Eabt+iViPasyBMAegYsg5oYTvMeHf7E=;
        b=S8pmopzzBG0rNok5vDN976cFoAR0A7Q+p/o8pCLnSXixM+5boO1hXI9m0F7yA6sPVV
         IZyY5dqJw+zD9pjkQsCFWgDYz5wF+P5eNiXGqXXFMv+aRYKwpt3F8UawnB7gMei0i6YK
         4d66jyCvy//Wa3Vusi8E+3lZBlUxR6yn31REPHhWKiHXldKjuVnLzFRabBqqG5gAGZtG
         t2QH8dhE+35YRcXlL8MfSG9W6j2mdR4uGOafC5ful+3LPMSrTawaYmujJHXzrggLSV6H
         9lTVl+5Wl79xSAYJW8Mc3QEXtAmUzLcvXtgiiSy/iJjtsjTonesbzCbeMh7TzIaZ0qEV
         VqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LZgbozaMv2++Eabt+iViPasyBMAegYsg5oYTvMeHf7E=;
        b=X8KujmkMTA3e18omHNA2r0xb1Ory6AAXszsRE47uwW2mpa/oN9Qsf0tC6qqV0xy57M
         gYB2rrQspoTZt5SdhQhids1KmXT887CrE74WBoE1m+/wYFyF1TK4QMPkjMypLluRl0Ir
         gzrWhkj3/3+ZWQUOZFnd5zt7YoasBmxSKQ01vBt2j+zg5pPCBgjT/HXywPe/btG8BjTj
         blweeP4DEG5Di8UUKX43VRkFQD+mStu6S0AQM3qcARHM8SixRtcOuAquqvX5QWSq7x3y
         /Ks8u6dzMDLUv0lzEg7nDWhzdb7k4/SAEgvZThJAJHfwBOq9b23L4KlKA0NWejRmUGKy
         Vu5w==
X-Gm-Message-State: APjAAAXpbDApXnOYuGBNtkwnRMFJfAufIF/IYlXwcIgA9bC7DSBte1bj
        4SOquNN566tBmATYRpQCMoypDZV4TUMicqGp
X-Google-Smtp-Source: APXvYqwlu7Ul/+3EqoijwO89c+WDCiAnYLTJIkWSIHVcFHz5+Auv/4L5M6KXbDaJdlS2PHvKtwCyeDHSuT1v47PK
X-Received: by 2002:a63:c606:: with SMTP id w6mr156681pgg.133.1574796809308;
 Tue, 26 Nov 2019 11:33:29 -0800 (PST)
Date:   Tue, 26 Nov 2019 11:33:13 -0800
Message-Id: <20191126193313.44181-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] kunit: test: Improve error messages for kunit_tool when
 kunitconfig is invalid
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previous error message for invalid kunitconfig was vague. Added to it so
that it lists invalid fields and prompts for them to be removed.  Added
validate_config function returning whether or not this kconfig is valid.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf3876835331..010d3f5030d2 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -93,6 +93,19 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
+	def validate_config(self, build_dir):
+		kconfig_path = get_kconfig_path(build_dir)
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(kconfig_path)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			invalid = self._kconfig.entries() - validated_kconfig.entries()
+			message = 'Provided Kconfig is not contained in validated .config. Invalid fields found in kunitconfig: %s' % (
+				', '.join([str(e) for e in invalid])
+			)
+			logging.error(message)
+			return False
+		return True
+
 	def build_config(self, build_dir):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
@@ -103,12 +116,7 @@ class LinuxSourceTree(object):
 		except ConfigError as e:
 			logging.error(e)
 			return False
-		validated_kconfig = kunit_config.Kconfig()
-		validated_kconfig.read_from_file(kconfig_path)
-		if not self._kconfig.is_subset_of(validated_kconfig):
-			logging.error('Provided Kconfig is not contained in validated .config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def build_reconfig(self, build_dir):
 		"""Creates a new .config if it is not a subset of the kunitconfig."""
@@ -133,12 +141,7 @@ class LinuxSourceTree(object):
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False
-		used_kconfig = kunit_config.Kconfig()
-		used_kconfig.read_from_file(get_kconfig_path(build_dir))
-		if not self._kconfig.is_subset_of(used_kconfig):
-			logging.error('Provided Kconfig is not contained in final config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], timeout=None, build_dir=None):
 		args.extend(['mem=256M'])
-- 
2.24.0.432.g9d3f5f5b63-goog

