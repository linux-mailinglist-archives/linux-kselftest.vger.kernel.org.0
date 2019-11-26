Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F326F10A69C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 23:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKZWgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 17:36:38 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:41470 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfKZWgh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 17:36:37 -0500
Received: by mail-yb1-f201.google.com with SMTP id j66so14123917ybg.8
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 14:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EuaZnHowIBc7y1QLV9A0aE1DHqnTcytF/iy9ArT6dOM=;
        b=ISb7ahBc3XQRcy7hXbzo638Z3k3Vwq80fpiEKdFfPpFa8d6GB9cT22SACX4p+HRS0F
         uLp2LeH46TMRB70xuCT2IH64/j3YZ6Qmgin87KRnfAmL5Xey8+6cFA3U25dWILE3LYBh
         r04C9GgrC/lkQEaJIwxfy1fh0KHKvc3uXJafGArJCUKSKk/kPirUd1k0oXCAnhhUWP65
         h1x9epX6QKtn68b+JoYFDXiPxLrNf+MScJdzypxjD4gW9aE/bcsbOh5UdVwHhL5xGmT1
         6PRxXyBV+QpIwEru7i1Rf8oGxrYsndojf9832I0NB8lHtZ8dSoWKAMzn2lGMl5vUohwc
         gtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EuaZnHowIBc7y1QLV9A0aE1DHqnTcytF/iy9ArT6dOM=;
        b=kR7iZvZz8WtGGcXpASgDASj5gNS8Da/vfShm0hyjkALeYY7R4LRxSXuVFDb5n7OMiQ
         oh4ZVfsMC9UCHyqGvkiIaBhwJbwwxylqF8jNbULxu27QTnu1SwobNHOrgzszb1njcd99
         TubjVN3ndO4K3OyGcCw6gGA5Lbr19Ks8obmNv9pOZVLdhhK0rsPap9clER4xVFyzJA4y
         4Hz1kFoDTjKBf//uQg3b1V2pmi+miaRSHgg3lxUHignThbeeySe5kCmwpn4cm2jniJxD
         5qwHR8tzfC/+GMNrnEmgKXiGijeicCZqdqqIuhiO0dGM5XXw8noFsWJT5RWYjiecnMPN
         1GDQ==
X-Gm-Message-State: APjAAAWfqHI9jyR17sZ4VGUr/NmMVkcq5gHqQ6fRAGW6aNKZtAd3AK8S
        xkMVbDj8ckPH05qQn2wr9Y8EXzcJwp2i0bMG
X-Google-Smtp-Source: APXvYqybZoCVe8mrOgJY9Uodbr4NHifXHLOVmX5qrgUpwHsOA4x5+Hsmfb+KbINBpAxJuTImW+amSbNi4rAVB36+
X-Received: by 2002:a81:68c3:: with SMTP id d186mr781876ywc.188.1574807794992;
 Tue, 26 Nov 2019 14:36:34 -0800 (PST)
Date:   Tue, 26 Nov 2019 14:36:16 -0800
In-Reply-To: <20191126193313.44181-1-heidifahim@google.com>
Message-Id: <20191126223616.98294-1-heidifahim@google.com>
Mime-Version: 1.0
References: <20191126193313.44181-1-heidifahim@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2] kunit: test: Improve error messages for kunit_tool when
 kunitconfig is invalid
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, shuah@kernel.org, davidgow@google.com
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
Addressed Brendan's nit for error message

 tools/testing/kunit/kunit_kernel.py | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf3876835331..e1df9aad778f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -93,6 +93,20 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
+	def validate_config(self, build_dir):
+		kconfig_path = get_kconfig_path(build_dir)
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(kconfig_path)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			invalid = self._kconfig.entries() - validated_kconfig.entries()
+			message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
+					  'but not in .config: %s' % (
+					', '.join([str(e) for e in invalid])
+			)
+			logging.error(message)
+			return False
+		return True
+
 	def build_config(self, build_dir):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
@@ -103,12 +117,7 @@ class LinuxSourceTree(object):
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
@@ -133,12 +142,7 @@ class LinuxSourceTree(object):
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

