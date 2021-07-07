Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A253BEFA5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 20:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhGGSqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 14:46:06 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33762 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhGGSqG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 14:46:06 -0400
Received: by mail-pf1-f172.google.com with SMTP id 145so3080782pfv.0;
        Wed, 07 Jul 2021 11:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pbkoTI7CwQStSb9kTtVA+aCTwErRXZb2NE0miM8f/c=;
        b=ll8VXd1P9p4hbpFyE02hVISGaIwTmq0OjTuYVy5N7EfotYcdvjI315U2Gx3eCeYq46
         rG+cKp+tnpr66mTqJ4feJ1cD2HcwDsn3n2vFT5N5X6MrpxjM1IX2AZE4vvN0Qgw7ihul
         vOCL5hll4l19ryCXCkD87K+D88FsIMw83DfCSvG9nCpmPr3jw3X1Sx0lI3KoiI8vk0i+
         vvHKyL3CQD+MmcysN1QmEaBF7ZsYnZ3NiVDrh6nQiqQMb6VgpxuRAHgLgoj1HNpnUDiV
         +zkb/X68SyXjxTRmKY9W5EI7XuJNpL5L0t9bcmWO6lTMOB+XU9npTiVRKECls1RZVO8j
         /KIw==
X-Gm-Message-State: AOAM530Yj1OceSTE4cT6qznF2xXb89bW5dAVu1/xSPzkHYnHIMBoBFEh
        VcJIcvLvZn+/3dkyFbpcQ6I=
X-Google-Smtp-Source: ABdhPJxH2e3S6YzGnWMt5ZZhyuhsb6pGf9a09rRfHIk4m3v8/OZ5x66UyovLLi+S3iSyvkveUyL5/Q==
X-Received: by 2002:aa7:84cb:0:b029:312:bd08:246f with SMTP id x11-20020aa784cb0000b0290312bd08246fmr26598502pfn.13.1625683404969;
        Wed, 07 Jul 2021 11:43:24 -0700 (PDT)
Received: from localhost ([191.96.120.45])
        by smtp.gmail.com with ESMTPSA id j4sm7292297pjv.7.2021.07.07.11.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 11:43:24 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     rafael@kernel.org, rgoldwyn@suse.com, kuno@frob.nl,
        fontana@sharpeleven.org, Ciaran.Farrell@suse.com,
        Christopher.DeNicolo@suse.com, hch@lst.de, corbet@lwn.net,
        linux@leemhuis.info, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, tj@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-spdx@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        copyleft-next@lists.fedorahosted.org
Subject: [PATCH 2/2] testing: use the copyleft-next-0.3.1 SPDX tag
Date:   Wed,  7 Jul 2021 11:43:10 -0700
Message-Id: <20210707184310.3624761-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707184310.3624761-1-mcgrof@kernel.org>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Two selftests drivers exist under the copyleft-next license.
These drivers were added prior to SPDX practice taking full swing
in the kernel. Now that we have an SPDX tag for copylef-next-0.3.1
documented, embrace it and remove the boiler plate.

Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc: Kuno Woudt <kuno@frob.nl>
Cc: Richard Fontana <fontana@sharpeleven.org>
Cc: copyleft-next@lists.fedorahosted.org
Cc: Ciaran Farrell <Ciaran.Farrell@suse.com>
Cc: Christopher De Nicolo <Christopher.DeNicolo@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_kmod.c                          | 12 +-----------
 lib/test_sysctl.c                        | 12 +-----------
 tools/testing/selftests/kmod/kmod.sh     | 13 +------------
 tools/testing/selftests/sysctl/sysctl.sh | 12 +-----------
 4 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index ce1589391413..d62afd89dc63 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 /*
  * kmod stress test driver
  *
  * Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or at your option any
- * later version; or, when distributed separately from the Linux kernel or
- * when incorporated into other software packages, subject to the following
- * license:
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of copyleft-next (version 0.3.1 or later) as published
- * at http://copyleft-next.org/.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 3750323973f4..9e5bd10a930a 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 /*
  * proc sysctl test driver
  *
  * Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or at your option any
- * later version; or, when distributed separately from the Linux kernel or
- * when incorporated into other software packages, subject to the following
- * license:
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of copyleft-next (version 0.3.1 or later) as published
- * at http://copyleft-next.org/.
  */
 
 /*
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index afd42387e8b2..7189715d7960 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -1,18 +1,7 @@
 #!/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 # Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
 #
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU General Public License as published by the Free
-# Software Foundation; either version 2 of the License, or at your option any
-# later version; or, when distributed separately from the Linux kernel or
-# when incorporated into other software packages, subject to the following
-# license:
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of copyleft-next (version 0.3.1 or later) as published
-# at http://copyleft-next.org/.
-
 # This is a stress test script for kmod, the kernel module loader. It uses
 # test_kmod which exposes a series of knobs for the API for us so we can
 # tweak each test in userspace rather than in kernelspace.
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 19515dcb7d04..2046c603a4d4 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -1,16 +1,6 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 # Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU General Public License as published by the Free
-# Software Foundation; either version 2 of the License, or at your option any
-# later version; or, when distributed separately from the Linux kernel or
-# when incorporated into other software packages, subject to the following
-# license:
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of copyleft-next (version 0.3.1 or later) as published
-# at http://copyleft-next.org/.
 
 # This performs a series tests against the proc sysctl interface.
 
-- 
2.27.0

