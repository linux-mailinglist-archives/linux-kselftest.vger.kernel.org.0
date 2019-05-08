Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F017E0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfEHQ0U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 12:26:20 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55281 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfEHQ0T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 12:26:19 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so5036138ite.4
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2019 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75vFqUksf0tQ2CrucJLVayay02aXl+jl+xEBhfOLKh8=;
        b=Byu4evv3/Taq0hD9gQdOBBv7eqPsD0iQj96N0oZ4q6bzkunFBjqxs7K7E+FKM8iZPH
         3tgGSJk2srZ8UR5ZnbgDk88nKruFXnxSjKfwQcBQ8RM+8HtDiL9cg8NaPNZo4djwyESi
         rSigA0zYLJs7uLbX+SAyeqhldjxG5qmZM7rc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75vFqUksf0tQ2CrucJLVayay02aXl+jl+xEBhfOLKh8=;
        b=gv4QjjFmW05m0WJiv6sf/nISaKcUJTuPCs9Wefk45VDcwRDdF5qd88KnAcK1XrHS+i
         +b1xpE0ivAosc3rfTF4+jvptbt/wotATB8Ubl6or8hvhOeWB3Av1yPXu+jkWgPQnxk5t
         7crpsiOmyBoSV+GGl5qpevH1JiWWNO9rmgpHxOY7QfIw42wAkImh5l0ghROxEYb01l11
         osqcUb3JVrVYG4mNRGhpEeTKr9XgLiRUHoQKCoN7HbPv/I7VRZnidZf537Cp4yf4yti5
         T1HgtHInpwkDxM1Jr4lpnAUMW+6+0egY8g6j1f/VgnGMYLH2MZD8yqeOqcMIi8dD1q9J
         SdNQ==
X-Gm-Message-State: APjAAAXcoGlmdwqigNv8hDvr83q8j49l/GsEsOBG4EkE7jmX7rekYLxB
        rytE6QPWXwfoBPY1JjJyDfjybg==
X-Google-Smtp-Source: APXvYqzQoskEtmbjbTtX+OwFuML4TDWByi9RvdqJOynVcQV+gClTL5kianyjqI8MKT/DQSvYCHE8RQ==
X-Received: by 2002:a02:2e52:: with SMTP id u18mr29934269jae.84.1557332779112;
        Wed, 08 May 2019 09:26:19 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 3sm1657304itk.1.2019.05.08.09.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:26:18 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: fix install target to use default install path
Date:   Wed,  8 May 2019 10:26:16 -0600
Message-Id: <20190508162616.9393-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Install target fails when INSTALL_PATH is undefined. Fix install target
to use "output_dir/install as the default install location. "output_dir"
is either the root of selftests directory under kernel source tree or
output directory specified by O= or KBUILD_OUTPUT.

e.g:
make -C tools/testing/selftests install
<installs under tools/testing/selftests/install>

make O=/tmp/kselftest -C tools/testing/selftests install
<installs under /tmp/kselftest/install>

export KBUILD_OUTPUT=/tmp/kselftest
make -C tools/testing/selftests install
<installs under /tmp/kselftest/install>

In addition, add "all" target as dependency to "install" to build and
install using a single command.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9f05448e5e4b..c71a63b923d4 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -163,11 +163,17 @@ clean_hotplug:
 run_pstore_crash:
 	make -C pstore run_crash
 
-INSTALL_PATH ?= install
+# Use $BUILD as the default install root. $BUILD points to the
+# right output location for the following cases:
+# 1. output_dir=kernel_src
+# 2. a separate output directory is specified using O= KBUILD_OUTPUT
+# 3. a separate output directory is specified using KBUILD_OUTPUT
+#
+INSTALL_PATH ?= $(BUILD)/install
 INSTALL_PATH := $(abspath $(INSTALL_PATH))
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
 
-install:
+install: all
 ifdef INSTALL_PATH
 	@# Ask all targets to install their files
 	mkdir -p $(INSTALL_PATH)/kselftest
-- 
2.17.1

