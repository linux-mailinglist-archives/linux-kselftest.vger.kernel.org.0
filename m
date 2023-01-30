Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC4568081F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 10:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjA3JEz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 04:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjA3JEt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 04:04:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D12BED6;
        Mon, 30 Jan 2023 01:04:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j5so10471110pjn.5;
        Mon, 30 Jan 2023 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6UNdUpKWpLSTSOHWKFbbLTpe021E5XwaO8VPJyBruA=;
        b=fDQUb7nqvxToI/bLKsxrjgL1kp+4v6u1YF5/SLsB8nGadBv9GlY3URT6jiA1YTcdME
         VaGMZzo020vEs+jm8HfIUJe5k/B3Q880/VFzh2SA7NDdOsmAFctCzrovUfYsY4Bz2SBQ
         cLRUlKyiVp7YvHbcFEuRmB/Iakam1la0sb4uz42Er+wFx9kxzQMQ27b1TGsg0vDdmkWd
         GcaMTCuz9va70pE18H+y0yQFDYevZaoyV8OYFvy02YgoFZbcwDwOww25QL/h+L9TSti5
         U+lDhkIJngLsR3TqMLYWCXpK4KvV+l393w86+zWQ4Fr0Ke7GwIo9HTp3zSzBr0EB/GQj
         XB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6UNdUpKWpLSTSOHWKFbbLTpe021E5XwaO8VPJyBruA=;
        b=f5ZqgbaMx5nXawUQ/8d4wyzuunWyX96CyZ8Ky3x5Nthnx1HhUpta2N7OKMR39Jam0o
         Jv+C6fBq75MpunpsaxtFimSAGeQiXAV7NUyW6Cr05AjqdwTT0n5amhRsIMePtAsUXUio
         PZLDDrEiZRL4iu87NsRMHmvPrH2if85lSp3VoKXbH6p7pRHsUjiivgAg+z5RbDGrUS88
         g/InXXSngcA86M3kV9cS2Fn6XJo6bt9KKnQpFoe7ZXsTfbtkkyuAkSRmkwQCLAwSS+jC
         JgIPVzu6Vel54xSCSVQCdvRyfc5KxVT0jUtwoXWrIvJ3BjSfssOrBimcy7Uk0mf2y49Y
         myjQ==
X-Gm-Message-State: AO0yUKVsvat7EVPvblwvDYuRFWbdVQYmI/5xyb1XAhImz+jugMWuqrlg
        qKl7042ubVMvjwYra3tzl4c=
X-Google-Smtp-Source: AK7set/3TAw8yhF6CPCb2wGY/0b8uhcN34CMIRKK2RrHevObDG2VhwyzGWNLsR1uIB/skeUSrEC0lA==
X-Received: by 2002:a17:902:ce87:b0:196:341b:ed7 with SMTP id f7-20020a170902ce8700b00196341b0ed7mr21641187plg.15.1675069486498;
        Mon, 30 Jan 2023 01:04:46 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b00192aa53a7d5sm7255321plv.8.2023.01.30.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:04:46 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Kees Cook <keescook@chromium.org>, Andrew Davis <afd@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] .gitignore: Keep track of archived files as they are added to a new git repo
Date:   Mon, 30 Jan 2023 17:04:26 +0800
Message-Id: <20230130090426.13864-1-likexu@tencent.com>
X-Mailer: git-send-email 2.39.1
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

From: Like Xu <likexu@tencent.com>

With thousands of commits going into mainline each development cycle,
the metadata .git folder size is gradually expanding (1GB+), and for some
developers (most likely testers) who don't care about the lengthy git-log,
they just use git-archive to distribute a certain version of code (~210MB)
and rebuild git repository from anywhere for further code changes, e.g.

  $ git init && git add . -A

Then unfortunately, the file tracking metadata from the original git-repo
using "git add -f" will also be lost, to the point where part of source
files wrapped by git-archive may be accidentally cleaned up:

  $ git clean -nxdf
  Would remove Documentation/devicetree/bindings/.yamllint
  Would remove drivers/clk/.kunitconfig
  Would remove drivers/gpu/drm/tests/.kunitconfig
  Would remove drivers/hid/.kunitconfig
  Would remove fs/ext4/.kunitconfig
  Would remove fs/fat/.kunitconfig
  Would remove kernel/kcsan/.kunitconfig
  Would remove lib/kunit/.kunitconfig
  Would remove mm/kfence/.kunitconfig
  Would remove tools/testing/selftests/arm64/tags/
  Would remove tools/testing/selftests/kvm/.gitignore
  Would remove tools/testing/selftests/kvm/Makefile
  Would remove tools/testing/selftests/kvm/config
  Would remove tools/testing/selftests/kvm/settings

This asymmetry is very troubling to those users since finding out which
files to track with "git add -f" clearly requires priori knowledge on
various subsystems. The eradication of this little issue requires naturally
making git-init aware of all .gitignore restrictions at different file tree
hierarchies. Similar issues can be troubleshot with "git check-ignore -v"
for any mistakenly cleaned files.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 .gitignore                               | 2 ++
 tools/testing/selftests/arm64/.gitignore | 2 ++
 tools/testing/selftests/kvm/.gitignore   | 4 ++++
 3 files changed, 8 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/.gitignore

diff --git a/.gitignore b/.gitignore
index 20dce5c3b9e0..fa39e98caee3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -102,6 +102,8 @@ modules.order
 !.gitignore
 !.mailmap
 !.rustfmt.toml
+!.yamllint
+!.kunitconfig
 
 #
 # Generated include files
diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
new file mode 100644
index 000000000000..135d709d2d65
--- /dev/null
+++ b/tools/testing/selftests/arm64/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+!tags
diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 6d9381d60172..96561c8e06e0 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -5,3 +5,7 @@
 !*.h
 !*.S
 !*.sh
+!.gitignore
+!Makefile
+!settings
+!config
\ No newline at end of file
-- 
2.39.1

