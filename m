Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB31586C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 01:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBKA0J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 19:26:09 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55376 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBKA0J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 19:26:09 -0500
Received: by mail-pl1-f201.google.com with SMTP id w11so3776239plp.22
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 16:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HpkmKDHicHDmtN7FR/CAsd7jrGUK0Ch8LLHTELEcaI8=;
        b=WlcYBoQN/UUVFckJDb98wgrYBIMpqWfe4YPOk623qSX1nuLl2QCee199r3HRf2PXaV
         vB4qCCPeRVg6DAL58TUwJbNEx9tUFk/hT6ln8v1QXgYUw0HczC3qR3jATdNIYf8jkt4l
         R8HRlys6HV34vo03lz8Dp5F3rTIHS1wfYLJbL/Rh58kVGdkb9KA5fi7rvCoj/pwv3xhe
         Nqle/Cu3ywo//U3/+vjuQcZVJMPYtymaK7DSRDBCO4Qhg6ucp1IcrH+7Jk/WxjyyLtA5
         ++VP8lx70bn7CM175UqAd8bDn6O3I3zmlJAjdwFi47sjVUlgh/uCReNLlwtwHDSXYBTE
         mBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HpkmKDHicHDmtN7FR/CAsd7jrGUK0Ch8LLHTELEcaI8=;
        b=XHMi7Pee5orv7ayK9g1kMXmVkt7nv0u5YsKw/wkrXmiOk2lJZ3fV6n0V7xTE2DVddw
         lRSJhRgm6AQgOaQrED4uzjF1f4jvYbsmNc52OSroTSJJ9onWU5ilmSxtOE2dMVgHFhyN
         Vgt1x4jE5F3oX/MZynO+8+3W6Bb6IpRY5aTd85Xn4kiC+AY6MTSWvFw2kviFY0ZlUqej
         EVFzb4mex2rnRsuNkXcnfJYP+77nP4eqw0Ch3Vq+9sHUsY9E6TRgac48B54jSLZ3BlyE
         t5z1RyO9ce2B3m24jvpJW3JXUJ8SLN8XKFxBnYYkOPOBFwBGilTm+7nHuWveTnDZRbjY
         8gaA==
X-Gm-Message-State: APjAAAUimSQtlCTtx0QiKos5rjsNIPvdaaYZ7Az78dYxj5ptV2M0TIFO
        6rz74vyD5KgL/5T8Y9m9DS7VabJ6MfDmuL8q
X-Google-Smtp-Source: APXvYqwfJ//FL4XeWE5K0KVKUilnpBT2yJ5Ok0NBAzyqjqJgwQ/24jECDHHQUh+bfzZBXM2UBb1vEKSK5qgEjANW
X-Received: by 2002:a63:5a11:: with SMTP id o17mr4313739pgb.60.1581380768895;
 Mon, 10 Feb 2020 16:26:08 -0800 (PST)
Date:   Mon, 10 Feb 2020 16:25:51 -0800
Message-Id: <20200211002551.147187-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] kunit: run kunit_tool from any directory
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implemented small fix so that the script changes work directories to the
linux directory where kunit.py is run. This enables the user to run
kunit from any working directory. Originally considered using
os.path.join but this is more error prone as we would have to find all
file path usages and modify them accordingly. Using os.chdir ensures
that the entire script is run within /linux.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
 tools/testing/kunit/kunit.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e59eb9e7f923..3cc7be7b28a0 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -35,6 +35,13 @@ def create_default_kunitconfig():
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
 				kunit_kernel.kunitconfig_path)
 
+def get_kernel_root_path():
+	parts = sys.argv[0] if not __file__ else __file__
+	parts = os.path.realpath(parts).split('tools/testing/kunit')
+	if len(parts) != 2:
+		sys.exit(1)
+	return parts[0]
+
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
@@ -114,6 +121,9 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if get_kernel_root_path():
+			os.chdir(get_kernel_root_path())
+
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
-- 
2.25.0.341.g760bfbb309-goog

