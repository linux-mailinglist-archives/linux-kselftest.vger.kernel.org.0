Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DB295A79
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508110AbgJVIg2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 04:36:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51832 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503413AbgJVIg2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 04:36:28 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kVW5C-0003FX-E2
        for linux-kselftest@vger.kernel.org; Thu, 22 Oct 2020 08:36:26 +0000
Received: by mail-pf1-f197.google.com with SMTP id e7so765982pfh.14
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 01:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2jy434wIuwXoLXzyeW6c/CAdjOSlRMynxqAD7g4/dU=;
        b=qGtF2aft8qkyzijpEBYk+cUHXRsBTOQHERs4nRCMfRk8jhe98XPY7xjZHyqIG4Amjl
         nJtS91TT4SQ3SUNG6UTIB6s6dvlw6x0dIdgYvL3xuTMkkfmC2PyrJ/m272iYs9ZrsrXF
         zlav7SK5qs6s7WeGNI9o7bRT7PTx8bOaPyHRbKMLe+/GxwdlG9w1Z/EPJUT7kclOtFeQ
         Y3PReU2v45GyXj418q185iH9H6XVa9DK7oxnS5UrIJgPsg4i0fHgR776VfgvDELC4QPk
         BRovv5oTG0DNG3GVs6SJF4jo1uyAc0zoyV14oWxFqC0IcpX42xNiUFSyMnww3gBYyTIU
         ypGg==
X-Gm-Message-State: AOAM531oXBMLSrKAxs+NZUuXwawgU3RooI4ciSqLxAyKTYyH1ZBaUQ4k
        u3RQeZTAgKBRAbjki2O++VppgSRN08EQQzNDDZUII0FT9YhG37YtDTrqthaUbMvht8p6QtaGvVb
        erlIrAlgKjdPMUkRe2NcJrRK4tDCucSuVhO3h5rWyjRqk
X-Received: by 2002:a17:90b:438c:: with SMTP id in12mr1367419pjb.32.1603355784923;
        Thu, 22 Oct 2020 01:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNakAo0xdaw0VJxwPqXKhIaUfkhybuIzehY4Ztq4OIlZTIcIge6pr0+zczxLDbkwa2t0WsBg==
X-Received: by 2002:a17:90b:438c:: with SMTP id in12mr1367403pjb.32.1603355784654;
        Thu, 22 Oct 2020 01:36:24 -0700 (PDT)
Received: from localhost.localdomain (223-137-29-213.emome-ip.hinet.net. [223.137.29.213])
        by smtp.gmail.com with ESMTPSA id y191sm1335465pfb.175.2020.10.22.01.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:36:23 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, shuah@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, mathieu.desnoyers@efficios.com
Subject: [PATCH] selftests/powerpc/eeh: disable kselftest timeout setting for eeh-basic
Date:   Thu, 22 Oct 2020 16:36:16 +0800
Message-Id: <20201022083616.41666-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The eeh-basic test got its own 60 seconds timeout (defined in commit
414f50434aa2 "selftests/eeh: Bump EEH wait time to 60s") per breakable
device.

And we have discovered that the number of breakable devices varies
on different hardware. The device recovery time ranges from 0 to 35
seconds. In our test pool it will take about 30 seconds to run on a
Power8 system that with 5 breakable devices, 60 seconds to run on a
Power9 system that with 4 breakable devices.

Thus it's better to disable the default 45 seconds timeout setting in
the kselftest framework to give it a chance to finish. And let the
test to take care of the timeout control.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/powerpc/eeh/Makefile | 2 +-
 tools/testing/selftests/powerpc/eeh/settings | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/eeh/settings

diff --git a/tools/testing/selftests/powerpc/eeh/Makefile b/tools/testing/selftests/powerpc/eeh/Makefile
index b397bab..ae963eb 100644
--- a/tools/testing/selftests/powerpc/eeh/Makefile
+++ b/tools/testing/selftests/powerpc/eeh/Makefile
@@ -3,7 +3,7 @@ noarg:
 	$(MAKE) -C ../
 
 TEST_PROGS := eeh-basic.sh
-TEST_FILES := eeh-functions.sh
+TEST_FILES := eeh-functions.sh settings
 
 top_srcdir = ../../../../..
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/eeh/settings b/tools/testing/selftests/powerpc/eeh/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/eeh/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4

