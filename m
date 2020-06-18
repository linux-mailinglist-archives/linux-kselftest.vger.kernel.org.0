Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2238A1FE9B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 05:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFRD5m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 23:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgFRD5l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 23:57:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A7C06174E
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 20:57:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 205so4358684qkg.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 20:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kxq9wRrE0VcoWqdZaicI3/uHvnI8AYX6HIWvnm/8zQU=;
        b=Z0X0AmgFWFKBZX0ES2R4eb0Zccw1evdsbhMfTQR8REFSgqGBre9aVWppzpZHKBD1T2
         p2vk59LxddnUhMiGRtjZSxJwll0NNPe283ZTTiZ1HjLE0v2EsPbiDHrGWEFSNfFDJ96t
         zG34duQCPI6NFTakIDfkNqOa2QNGLK0X8vQsPM8kuiDKllhrvTAg2SVTXN2KRnCL97op
         citaOJ/yBH3DLNHEX3GdXrivfTYhkDqky8KacUjgsFIcnYZpN9F/4tlrHDcx96M38x/4
         nihDusTfHIueFxSn7yrqTqe0sg3gFV8YWOtHdjVpA+iA0v9xFWXdi6O2GXGkFW5gc1YR
         C0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kxq9wRrE0VcoWqdZaicI3/uHvnI8AYX6HIWvnm/8zQU=;
        b=UdMh6a3NbFAJUG2kwrVotD0hnXwoCHQTN6ljSOivBkvaQeiEznC8ufmxNoaDc3SPCo
         kVCSIYLbaHzCh68LTGmvrSN6jp5eSlCvs7V0FCo1t1rc4okuIPkW4wIY7pKNsbIDNoWi
         RQvYjuFrLOp5GwH2mKCfxeCB3s3siswkPZLKMDvQnbQvWz1I574D9qiyAhpvHJ9R/ppU
         YqaJgjOW1042MFBHXuS5IProXzsoU1465ozQw6o55Qy8kPGl2wOLjGYD2hF/R778x07l
         u0GGJRJxoPaOdLzfGq+PK/E/6qvSMtfpPGa0jQQUQ6MAs2fg8nAPuAkrPOLAyU2Dhdy7
         ondA==
X-Gm-Message-State: AOAM531NzpK0QuozUBxzmfZXDoX1BMrXiYAGyH+ebRwqzFfkqoQhUMP6
        dNk8IMfz3JIFZdSWB6pLxDkSRw==
X-Google-Smtp-Source: ABdhPJx7UOP/sLgtGoIwIcclUrfK9C91LRQm5rNLMKQL+9lN8jMkDMH6MlF3cRaZ2mvb6P4/pXHg4A==
X-Received: by 2002:a37:a386:: with SMTP id m128mr2023002qke.224.1592452660335;
        Wed, 17 Jun 2020 20:57:40 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id a1sm1846168qkn.87.2020.06.17.20.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 20:57:39 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: fix KconfigParseError by ignoring CC_VERSION_TEXT
Date:   Thu, 18 Jun 2020 00:57:36 -0300
Message-Id: <20200618035736.245566-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 8b59cd81dc5 ("kbuild: ensure full rebuild when the compiler
is updated") added the environment variable CC_VERSION_TEXT,
parse_from_string() doesn't expect a string and this causes the
failure below:

[iha@bbking linux]$ tools/testing/kunit/kunit.py run --timeout=60
[00:20:12] Configuring KUnit Kernel ...
Generating .config ...
Traceback (most recent call last):
  File "tools/testing/kunit/kunit.py", line 347, in <module>
    main(sys.argv[1:])
  File "tools/testing/kunit/kunit.py", line 257, in main
    result = run_tests(linux, request)
  File "tools/testing/kunit/kunit.py", line 134, in run_tests
    config_result = config_tests(linux, config_request)
  File "tools/testing/kunit/kunit.py", line 64, in config_tests
    success = linux.build_reconfig(request.build_dir, request.make_options)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 161, in build_reconfig
    return self.build_config(build_dir, make_options)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 145, in build_config
    return self.validate_config(build_dir)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 124, in validate_config
    validated_kconfig.read_from_file(kconfig_path)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 89, in read_from_file
    self.parse_from_string(f.read())
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 85, in parse_from_string
    raise KconfigParseError('Failed to parse: ' + line)
kunit_config.KconfigParseError: Failed to parse: CONFIG_CC_VERSION_TEXT="gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)"

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 tools/testing/kunit/kunit_config.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index e75063d603b5..3033520597b6 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -9,6 +9,7 @@
 import collections
 import re
 
+CONFIG_IGNORE_CC_VERSION_TEXT = 'CONFIG_CC_VERSION_TEXT'
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+)$'
 
@@ -79,7 +80,7 @@ class Kconfig(object):
 				self.add_entry(entry)
 				continue
 
-			if line[0] == '#':
+			if line[0] == '#' or CONFIG_IGNORE_CC_VERSION_TEXT in line:
 				continue
 			else:
 				raise KconfigParseError('Failed to parse: ' + line)

base-commit: 7bf200b3a4ac10b1b0376c70b8c66ed39eae7cdd
-- 
2.26.2

