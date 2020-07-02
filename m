Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E676212953
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jul 2020 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgGBQ1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jul 2020 12:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGBQ1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jul 2020 12:27:01 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8FFC08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Jul 2020 09:27:01 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id i4so2131964ooj.10
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jul 2020 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=+HQPPeKFIejGiV86yMGdqBrbHg3TiXW0sg4eTbb57QY=;
        b=ZnRwDcNdKT12L60bjWxeAZ/j55/odGKh7b6lNVs8Y7PiBzOaUuAqRuvhDb1+GMNHW7
         gyAOD8ca/GJ7gFj5h11+m8V431lTUfqotMZ3yAbwbEA051halP0Bm5ljqLggDR178fn0
         DQ1SYuzFImuQbXIALp8X1bX4SLlQBsQsM/xxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=+HQPPeKFIejGiV86yMGdqBrbHg3TiXW0sg4eTbb57QY=;
        b=bfyc1rpYIGecPKFH5CsGS+HpbDf+rg6fg0l0bfyxxhbJ3V1b0T2XEdpkyyFXkA1ySc
         6m6pUFaGSWGC2LEw6u9k9cSzwpKTzDmWZ9PWoIaQqGFduknv9jUW2gJ8R55VfUWsiWq1
         SypFvMt9kGse9nnlriMForlBWxx9DCErkVbwxuuq9SkG0cJWKSwFFRIHN9NgofkVNScZ
         zZpWeIcgAzoRA+Pxp1WNnKjpI2/88KL++d4TLXEFEtlNNpCrMe/NhuUamC27Pm6PG+yv
         d6CgTxqNvjJOSVNzyBWmXd9RaQxfZYCUWoPsjniZqd3UOmGeyZgEyBTsKtM0PyGEBB5G
         mROg==
X-Gm-Message-State: AOAM531r3yDJyWXoML7Q3JT43UZHsFf5HpXBMsmGzM+4ZMS8URctvdXP
        Uv4N+3Sw128ftQqRC1K7teiCE5qLhwM=
X-Google-Smtp-Source: ABdhPJxqqV5v5JxyQMfvIA/8/KzIDufypGIk+mmqtOiMddVrepIJcizENTmMohNnN2mwxalpz+tcWA==
X-Received: by 2002:a4a:b109:: with SMTP id a9mr19183218ooo.83.1593707220433;
        Thu, 02 Jul 2020 09:27:00 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 72sm2699953oii.43.2020.07.02.09.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 09:26:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.8-rc4
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <c97a669c-02d8-24c6-3bbf-295124d8261a@linuxfoundation.org>
Date:   Thu, 2 Jul 2020 10:26:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------723C156AC411040FCB61D4F9"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------723C156AC411040FCB61D4F9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.8-rc4.

This kselftest fixes update for Linux 5.8-rc4 consists of tpm test
fixes from Jarkko Sakkinen.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

   Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-fixes-5.8-rc4

for you to fetch changes up to 377ff83083c953dd58c5a030b3c9b5b85d8cc727:

   selftests: tpm: Use /bin/sh instead of /bin/bash (2020-06-29 14:19:38 
-0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.8-rc4

This kselftest fixes update for Linux 5.8-rc4 consists of tpm test
fixes from Jarkko Sakkinen.

----------------------------------------------------------------
Jarkko Sakkinen (3):
       Revert "tpm: selftest: cleanup after unseal with wrong 
auth/policy test"
       selftests: tpm: Use 'test -e' instead of 'test -f'
       selftests: tpm: Use /bin/sh instead of /bin/bash

  tools/testing/selftests/tpm2/test_smoke.sh | 9 ++-------
  tools/testing/selftests/tpm2/test_space.sh | 4 ++--
  2 files changed, 4 insertions(+), 9 deletions(-)

----------------------------------------------------------------

--------------723C156AC411040FCB61D4F9
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.8-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.8-rc4.diff"

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 663062701d5a..1334e301d2a0 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,15 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-[ -f /dev/tpm0 ] || exit $ksft_skip
+[ -e /dev/tpm0 ] || exit $ksft_skip
 
 python -m unittest -v tpm2_tests.SmokeTest
 python -m unittest -v tpm2_tests.AsyncTest
-
-CLEAR_CMD=$(which tpm2_clear)
-if [ -n $CLEAR_CMD ]; then
-	tpm2_clear -T device
-fi
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 36c9d030a1c6..00259cb746cf 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,9 +1,9 @@
-#!/bin/bash
+#!/bin/sh
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-[ -f /dev/tpmrm0 ] || exit $ksft_skip
+[ -e /dev/tpmrm0 ] || exit $ksft_skip
 
 python -m unittest -v tpm2_tests.SpaceTest

--------------723C156AC411040FCB61D4F9--
