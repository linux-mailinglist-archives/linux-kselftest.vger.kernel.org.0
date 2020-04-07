Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E431D1A184D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGWox (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 18:44:53 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44810 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgDGWov (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 18:44:51 -0400
Received: by mail-il1-f195.google.com with SMTP id j69so4880700ila.11
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Apr 2020 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oofgp/T6AW49TxBbYkC8nWUbJk1leoz17ITw6jj2QJ0=;
        b=FQwZ9WExx4B4zYVFH4rDo7FKhKj9DJhOj95gcRjYqZLyNBTbpmzDfbpfvFKHM2MSww
         HwpH/AXvsxgS7kSRpBe5si9OOfyZ0zu0rgafv0v9/J/yBCnfBY1+gCELGdPEsbadZjmu
         /x+mh7ZsLn/Cy8h9jdWhUPYtDl2XGtz0pqrRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oofgp/T6AW49TxBbYkC8nWUbJk1leoz17ITw6jj2QJ0=;
        b=CWaRdjlNvx2aHW2UKp6SZ4SkHKZEtVE34dolVb8qT0AiLzB2gc0So9CBMTitTgHSg/
         JQ32TJTyfl5Pu/hBQR5MDgEgk6sVEXlsN1bcHAC6ye0m5TibnFWr82YtS+xBh7YsUaAU
         FW7vC0xrr/BWfdtIAIivr3erRI1UsSAb3KsdgpZbF3tIbtd+KiNA9JkyBbDaN4U/zzRx
         Vaa77aNIIWeW786wBFNOWCmSTGil8iSVk+fwFu7uL4qkxUtby7nL7gZGRChnTDwPPi/D
         Ruv/ueImieVn0S5sFH+6FwmGT9ZDgSnZpdyZLn1gnZPJuOQijIq88CZEXHUCBDe4lPEq
         hzWw==
X-Gm-Message-State: AGi0Puap7z8blrD6HfjZcJ82GbRYmIsakpJFSpIQOe3thvPIFa3E7sen
        5EOD6kVlte/zAxbSTCmvorgBXw==
X-Google-Smtp-Source: APiQypKOH2Yw4cE+ZWnzZZK0xkO4YQUmuivtdVtcuJdE5RMdeBIN8GbObMxVNUWhUJgnY95NNqIyuA==
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr5288157ilj.112.1586299490170;
        Tue, 07 Apr 2020 15:44:50 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i4sm7315788ilq.4.2020.04.07.15.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:44:49 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, rong.a.chen@intel.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Fix memfd test run-time regression
Date:   Tue,  7 Apr 2020 16:44:46 -0600
Message-Id: <20200407224446.1578-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit d3fd949abd3e ("selftests: Fix memfd to support relocatable
build (O=objdir)") introduced regression run-time regression with
a change to include programs that should be run from shell scripts
to list of programs that run as independent tests. This fix restores
the original designation.

Fixes: d3fd949abd3e ("selftests: Fix memfd to support relocatable build (O=objdir)")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/memfd/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 0a15f9e23431..187b14cad00c 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,8 +4,9 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
+TEST_GEN_PROGS := memfd_test
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
+TEST_GEN_FILES := fuse_test fuse_mnt
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
-- 
2.20.1

