Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14FE7019A0
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 May 2023 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjEMUVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 May 2023 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEMUVV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 May 2023 16:21:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50632D6B;
        Sat, 13 May 2023 13:21:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5068638856dso2583039a12.1;
        Sat, 13 May 2023 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684009279; x=1686601279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phVfYEyjqUA1/8JzWnwWyJem9HZ6085CTPXJTMUib4g=;
        b=jfdhvxTIOPKnh+n2ESRxn+iltKq4nh61eRKsxsBV3oW1Ii/X7aBXAv5Nou7cNo3LDK
         RkQWrcskIMLc2WGI/FXV6llw+fSYLG8RM7SNaurWDObJLBtDDXxaJHfKN/k14P+q0wpT
         r/R1zhu7SRLCOUKIRIxnvf4WSrTNIEwiGlwlpJnN3XTtUBv87y2s3BfYYYOxyjIO9tCs
         MJDYr1yzY6cMjC8UXgHF6eC/UOXpuaiXRsfiKCRbj1/Z3s5TV+vNeMW/u1nrNA9I8zOp
         UrHGgaaaTZOkwa9wtKPliidEM/bI0RQnKBFKIYuLx+/HlLFhzNmVsMa8PGoYxEldKW9c
         GTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684009279; x=1686601279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phVfYEyjqUA1/8JzWnwWyJem9HZ6085CTPXJTMUib4g=;
        b=W4Z4Qez4NnIZpO0oRn4zNddvvBdXJrEtLwCVM9L4Ke385lCIYf1Wi/9U1A5ZYVxDxk
         527Z0MR8zJEvynRhZrqBzgbooKCTsWn8zz1vtcMXtZxJ1JBvQn+4P/Mn1KHi55iahV/L
         70qRMm2Tu50iOvibkzbIG7RLg92tUVnwQtZwqm9/DXtutUd/7JbRyU1P+G4+6LKjMwrG
         Ss7+rp4RROiCWBkv996SyTQw50f4KWdapJNjtFqfau0/STqk1cFhvX2WC5iUqu+rVyas
         mAlBdf6U5veDdfzhQBHbOCRNtIbrM8e49s4Z9LkohCtnltBfSSCGGVdfOaGUOtT0CV6F
         AS1Q==
X-Gm-Message-State: AC+VfDzhcL/K88AKkv1kTlflclpgVXhE6MpPSiG7H6QTyECYmhYCEETg
        UfFeOZHp5tytcy3oPD8RB6U=
X-Google-Smtp-Source: ACHHUZ6D50diLOr1mJEybUqQgqdZ/OhjmdX7JuUmJJIFtY8WY3xSxqG/VvvFG+eERIrAaYaD9xdCPg==
X-Received: by 2002:a05:6402:3482:b0:508:40a5:beb4 with SMTP id v2-20020a056402348200b0050840a5beb4mr28652324edc.3.1684009279137;
        Sat, 13 May 2023 13:21:19 -0700 (PDT)
Received: from ivan-B550MH.. ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id d14-20020a50fb0e000000b0050bc6d0e880sm5109637edq.61.2023.05.13.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 13:21:18 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 3/3] selftests: ALSA: Add test for the 'valsa' driver
Date:   Sun, 14 May 2023 00:20:37 +0400
Message-Id: <20230513202037.158777-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
References: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test covers the new Virtual ALSA driver, including the capturing,
playback and ioctl redefinition functionalities. This test is also helpful
as an usage example of the 'valsa' driver.

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
- Generate random or pattern-based capture data
- Check the playback stream for containing the looped pattern
- Inject delays into the playback and capturing processes
- Inject errors during the PCM callbacks

Also, this driver can check the playback stream for containing the
predefined pattern, which is used in the corresponding selftest to check
the PCM middle layer data transferring functionality. Additionally, this
driver redefines the default RESET ioctl, and the selftest covers this PCM
API functionality as well.

After all, I think this driver would be a good start, and I believe in the
future we will see more virtual sound drivers.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 tools/testing/selftests/alsa/valsa-test.sh | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 tools/testing/selftests/alsa/valsa-test.sh

diff --git a/tools/testing/selftests/alsa/valsa-test.sh b/tools/testing/selftests/alsa/valsa-test.sh
new file mode 100755
index 000000000000..872dfac138c2
--- /dev/null
+++ b/tools/testing/selftests/alsa/valsa-test.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test for the 'valsa' virtual driver. It tests capture and playback functionalities,
+# as well as the 'reset' ioctl redefinition.
+
+uid=$(id -u)
+if [ $uid -ne 0 ]; then
+	echo "$0: Must be run as root"
+	exit 1
+fi
+
+if ! which modprobe > /dev/null 2>&1; then
+	echo "$0: You need modprobe installed"
+        exit 4
+fi
+
+if ! modinfo snd-valsa > /dev/null 2>&1; then
+	echo "$0: You must have the following enabled in your kernel:"
+	echo "CONFIG_SND_ALSAV=m"
+	exit 4
+fi
+
+modprobe snd-valsa
+
+if [ ! -e /sys/kernel/debug/valsa/pc_test ]; then
+	mount -t debugfs none /sys/kernel/debug
+
+	if [ ! -e /sys/kernel/debug/valsa/pc_test ]; then
+		echo "$0: Error mounting debugfs"
+		exit 4
+	fi
+fi
+
+success="1"
+arecord -D hw:CARD=valsa,DEV=0 -c 1 --buffer-size=8192 -f S16_LE -r 8000 --duration=4 out.wav
+
+if [[ $(< /sys/kernel/debug/valsa/ioctl_test) == "$success" ]]; then
+	echo "$0: ioctl test: success"
+else
+	echo "$0: ioctl test: fail"
+fi
+
+aplay -D hw:CARD=valsa,DEV=0 -c 1 --buffer-size=8192 -f S16_LE -r 8000 out.wav
+
+if [[ $(< /sys/kernel/debug/valsa/pc_test) == "$success" ]]; then
+	echo "$0: playback test: success"
+else
+	echo "$0: playback test: fail"
+fi
+
+rm -rf out.wav
+if ! rmmod snd-valsa > /dev/null 2>&1; then
+	echo "$0: Can't remove 'valsa' module: disable PulseAudio and unload it manually"
+fi
-- 
2.34.1

