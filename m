Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1063870199B
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 May 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjEMUVN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 May 2023 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMUVM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 May 2023 16:21:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347626A4;
        Sat, 13 May 2023 13:21:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5068638856dso2583024a12.1;
        Sat, 13 May 2023 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684009269; x=1686601269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pI0vsmpY7mdUr70LiqqOXYMCiqJ/xh4FarR28VDA3tQ=;
        b=SZ4hSMKsHGaXlLqSku8AD4/x/CeRqwaHcZPywriobqnvKyvivb450tjcJFRpNAplQx
         ZKkGZ6Lqjt/vAKFOsFwm9bznpX59kYJB6YzxqyLmF5awylrSTXjZzSNgfXJjPvc7nS9/
         Kt8p97wvKXfucnIIbQdPjEIUb6iV22hbEdFAOT28HuG72UtKb6En97RAbmd5O3EukoaG
         7dkx5q5T+1oOG8ScWGsZWtox3HC/dF2y7dRLPHjx1zqEy2pNE8tzJLlzGXQYeazEgq1e
         9WHh9jcz4vQj0NmgmyF2cUfhfD758KbgJ/Tguy+OXnpKQiDz3MxnRz6AmAuSvO833RON
         I3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684009269; x=1686601269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pI0vsmpY7mdUr70LiqqOXYMCiqJ/xh4FarR28VDA3tQ=;
        b=evNqfkBk4R8AHDoNzlLsfQFSRYQTKot/3nfk3vQuCFrQgEaJTfKMApSNHJg7+Gt6wV
         slQ+nLXXmhYft3vuT7GGKUnoN0KVIvq3bQd1O+/ZXL6KQUuV04zbEX4clNtHwTSwhu4l
         tVD54f42XIVLY/XU+3bOKz7DV7hOHr53LvpFhPnCiD8W6BEyhjCy3gO6/a7s26/dTmF9
         1aKKmcgYuC36i39gO91henuC2osHB+em7auPOrj1tD/oWRXbmhOQm5J1yd48xKBObCEz
         kwiIo5XajZsNk96YsXT9PMMDqYAp/H1eyesMpj6lcErQb28cmRt3OT9IjoVJgkgP++74
         WDbA==
X-Gm-Message-State: AC+VfDx8H2soGScL++vtGIP+PGIlEbcyf5ztQV9gbjSQEHuSGc7sb7aM
        RoRKDsYDpBLd6Wh+rC/iqa0=
X-Google-Smtp-Source: ACHHUZ625/aVC/WnxBwyH6Dh1+EYRSKpvxQlGTanFoaRhbxtj1LMDThxQmKD1kACZ7pmrqVwVNpu8g==
X-Received: by 2002:a05:6402:27cd:b0:50c:79f:c693 with SMTP id c13-20020a05640227cd00b0050c079fc693mr26358719ede.1.1684009269048;
        Sat, 13 May 2023 13:21:09 -0700 (PDT)
Received: from ivan-B550MH.. ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id d14-20020a50fb0e000000b0050bc6d0e880sm5109637edq.61.2023.05.13.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 13:21:08 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/3] docs: admin-guide: add valsa driver documentation
Date:   Sun, 14 May 2023 00:20:35 +0400
Message-Id: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add documentation for the new Virtual ALSA driver. It covers all possible
usage cases: errors and delay injections, random and pattern-based data
generation, playback and ioctl redefinition functionalities testing.

We have a lot of different virtual media drivers, which can be used for
testing of the userspace applications and media subsystem middle layer.
However, all of them are aimed at testing the video functionality and
simulating the video devices. For audio devices we have only snd-dummy
module, which is good in simulating the correct behavior of an ALSA device.
I decided to write a tool, which would help to test the userspace ALSA
programs (and the PCM middle layer as well) under unusual circumstances
to figure out how they would behave. So I came up with this Virtual ALSA
Driver.

This new Virtual ALSA Driver has several features which can be useful
during the userspace ALSA applications testing/fuzzing, or testing/fuzzing
of the PCM middle layer. Not all of them can be implemented using the
existing virtual drivers (like dummy or loopback). Here is what can this
driver do:

- Simulate both capture and playback processes
- Check the playback stream for containing the looped pattern
- Generate random or pattern-based capture data
- Inject delays into the playback and capturing processes
- Inject errors during the PCM callbacks

Also, this driver can check the playback stream for containing the
predefined pattern, which is used in the corresponding selftest to check
the PCM middle layer data transferring functionality. Additionally, this
driver redefines the default RESET ioctl, and the selftest covers this PCM
API functionality as well.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 Documentation/admin-guide/index.rst |   1 +
 Documentation/admin-guide/valsa.rst | 114 ++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/admin-guide/valsa.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 43ea35613dfc..328cc59275a1 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -131,6 +131,7 @@ configure specific aspects of kernel behavior to your liking.
    thunderbolt
    ufs
    unicode
+   valsa
    vga-softcursor
    video-output
    xfs
diff --git a/Documentation/admin-guide/valsa.rst b/Documentation/admin-guide/valsa.rst
new file mode 100644
index 000000000000..64ffc130fb4c
--- /dev/null
+++ b/Documentation/admin-guide/valsa.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+The Virtual ALSA Driver
+=======================
+
+The Virtual ALSA Driver emulates a generic ALSA device, and can be used for
+testing/fuzzing of the userspace ALSA applications, as well as for testing/fuzzing of
+the ALSA middle layer. Additionally, it can be used for simulating hard to reproduce
+problems with PCM devices.
+
+What can this driver do?
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+At this moment the driver can do the following things:
+	* Simulate both capture and playback processes
+	* Generate random or pattern-based capturing data
+	* Inject delays into the playback and capturing processes
+	* Inject errors during the PCM callbacks
+
+Also, this driver can check the playback stream for containing the
+predefined pattern, which is used in the corresponding selftest (alsa/valsa-test.sh)
+to check the PCM middle layer data transferring functionality. Additionally, this
+driver redefines the default RESET ioctl, and the selftest covers this PCM
+API functionality as well.
+
+Configuration
+-------------
+
+The driver has several parameters besides the common ALSA module parameters:
+
+	* fill_mode (bool) - Buffer fill mode (see below)
+	* inject_delay (int)
+	* inject_hwpars_err (bool)
+	* inject_prepare_err (bool)
+	* inject_trigger_err (bool)
+
+
+Capture Data Generation
+-----------------------
+
+The driver has two modes of data generation: the first (0 in the fill_mode parameter)
+means random data generation, the second (1 in the fill_mode) - pattern-based
+data generation. Let's look at the second mode.
+
+First of all, you may want to specify the pattern for data generation. You can do it
+by writing the pattern to the debugfs file (/sys/kernel/debug/valsa/fill_pattern).
+Like that:
+
+.. code-block:: bash
+
+	echo -n mycoolpattern > /sys/kernel/debug/valsa/fill_pattern
+
+After this, every capture action performed on the 'valsa' device will return
+'mycoolpatternmycoolpatternmycoolpatternmy...' in the capturing buffer.
+
+The pattern itself can be up to 4096 bytes long.
+
+Delay injection
+---------------
+
+The driver has 'inject_delay' parameter, which has very self-descriptive name and
+can be used for time delay/speedup simulations. The parameter has integer type, and
+it means the delay added between module's internal timer ticks.
+
+If the 'inject_delay' value is positive, the buffer will be filled slower, if it is
+negative - faster. You can try it yourself by starting a recording in any
+audiorecording application (like Audacity) and selecting the 'valsa' device as a
+source.
+
+This parameter can be also used for generating a huge amount of sound data in a very
+short period of time (with the negative 'inject_delay' value).
+
+Errors injection
+----------------
+
+This module can be used for injecting errors into the PCM communication process. This
+action can help you to figure out how the userspace ALSA program behaves under unusual
+circumstances.
+
+For example, you can make all 'hw_params' PCM callback calls return EBUSY error by
+writing '1' to the 'inject_hwpars_err' module parameter:
+
+.. code-block:: bash
+
+	echo 1 > /sys/module/snd_valsa/parameters/inject_hwpars_err
+
+Errors can be injected into the following PCM callbacks:
+
+	* hw_params (EBUSY)
+	* prepare (EINVAL)
+	* trigger (EINVAL)
+
+
+Playback test
+-------------
+
+This driver can be also used for the playback functionality testing - every time you
+write the playback data to the 'valsa' PCM device and close it, the driver checks the
+buffer for containing the looped pattern (which is specified in the fill_pattern
+debugfs file). If the playback buffer content represents the looped pattern, 'pc_test'
+debugfs entry is set into '1'. Otherwise, the driver sets it to '0'.
+
+ioctl redefinition test
+-----------------------
+
+The driver redefines the 'reset' ioctl, which is default for all PCM devices. To test
+this functionality, we can trigger the reset ioctl and check the 'ioctl_test' debugfs
+entry:
+
+.. code-block:: bash
+
+	cat /sys/kernel/debug/valsa/ioctl_test
+
+If the ioctl is triggered successfully, this file will contain '1', and '0' otherwise.
-- 
2.34.1

