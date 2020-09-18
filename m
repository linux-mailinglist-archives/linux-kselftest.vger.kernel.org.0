Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC88D26FAD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIRKrp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 06:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRKrp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 06:47:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8537C06174A;
        Fri, 18 Sep 2020 03:47:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so4852868wmh.4;
        Fri, 18 Sep 2020 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrrwpvwP94b/+YAXXQ8PRjS0aa/rbtbfYwVTAOcVfYc=;
        b=E8uylnaClQh/WtXEc0IMvde9j0F4AqLT4Ug/3Efr8XJnCwJePpTspgKzEnAxDq5JHJ
         0gv7J6GV0hMuaHT4N/MiC/uSatwva0RwOuFuNIamL6yv9hsG/ioH79iCYRQi4o3XaRLg
         Y9o/yioaO66koDHV+VvtLROWUpGNqKdubS7OWwEsdDmeDsoq9FlBQ89wkp8x60TGHPmt
         CjyVevbi6DDJAvEt3H6avRKUPy+uYt/MGJ7HlrWf+5cJSgkmR4eh6mUdRiOWvdTkJX4L
         0pswkNmLy0qN2xGTKqO7+9rh9nQ5zkpdLDa8OfVmZvTkknTTsFCo93UCBDyJUFGWPUwS
         99GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrrwpvwP94b/+YAXXQ8PRjS0aa/rbtbfYwVTAOcVfYc=;
        b=g07RS+wXdKa72HUjDDCYQ0MLrmIxlboo8Fq+CGauqvrvLcL0WVjSE6j+g7AmtPqSR9
         ahVhY8v8bieOeUGG8CpeinGq5rGx9ffimJvZQWnR5fGYGvMr2BeT4tQN6LlwECVjF0vM
         0ZaWG64xKwk22vvCACPhD1xbJiAvrOtcRL94X1iHWgfAFUme3C/xPuSmUoJyW+WczpTR
         atVQ2N9t1dMFzH1b7y8G0jINZzTmPKivYlzKLBDQs05on8UGwJK/mDvdAs/lYIOtJPmA
         eHLKiglUz0OCsXYqMNFF3iU4mJ5GnFsNyV+7MseAQPWPuWtjxiLqSLlXxXIBH7HwmN5c
         LPbw==
X-Gm-Message-State: AOAM530YSuVagXKc0aN3vNMEoiNzrRRVrpc+pLaWkSgcGAE+pBb85Zk5
        rTB8CqT85b3i3jOBOnZJnpU=
X-Google-Smtp-Source: ABdhPJyfnMklXrXIbSYVPGWFbMEloX3r12Pfud66LELFK94r5w2DkCjDNNY/TZNKD10SjkektgdMKg==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr15549287wmb.5.1600426063613;
        Fri, 18 Sep 2020 03:47:43 -0700 (PDT)
Received: from trantor.home (cpc153975-seac28-2-0-cust722.7-2.cable.virginm.net. [81.109.38.211])
        by smtp.gmail.com with ESMTPSA id h4sm5197846wrm.54.2020.09.18.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:47:43 -0700 (PDT)
From:   Boyan Karatotev <boian4o1@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boyan Karatotev <boian4o1@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 0/4] kselftests/arm64: add PAuth tests
Date:   Fri, 18 Sep 2020 11:47:11 +0100
Message-Id: <20200918104715.182310-1-boian4o1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Pointer Authentication (PAuth) is a security feature introduced in ARMv8.3.
It introduces instructions to sign addresses and later check for potential
corruption using a second modifier value and one of a set of keys. The
signature, in the form of the Pointer Authentication Code (PAC), is stored
in some of the top unused bits of the virtual address (e.g. [54: 49] if
TBID0 is enabled and TnSZ is set to use a 48 bit VA space). A set of
controls are present to enable/disable groups of instructions (which use
certain keys) for compatibility with libraries that do not utilize the
feature. PAuth is used to verify the integrity of return addresses on the
stack with less memory than the stack canary.

This patchset adds kselftests to verify the kernel's configuration of the
feature and its runtime behaviour. There are 7 tests which verify that:
	* an authentication failure leads to a SIGSEGV
	* the data/instruction instruction groups are enabled
	* the generic instructions are enabled
	* all 5 keys are different for a single thread
	* exec() changes all keys to new different ones
	* context switching preserves the 4 data/instruction keys
	* context switching preserves the generic keys

The tests have been verified to work on qemu without a working PAUTH
Implementation and on ARM's FVP with a full or partial PAuth
implementation.

Changes in v3:
* remove double blank lines
* Patch 1: "kselftests: add a basic arm64 Pointer Authentication test"
    * shorten pac_corruptor.S to cut out unnecessary code
    * add second signal handler to cover ARMv8.6 compatibily
* Patch 3: "kselftests/arm64: add PAuth test for whether exec() changes keys"
    * change name of "exec_unique_keys" to "exec_changed_keys"
    * change reporting of error to be how many keys were left unchanged
* Path 4: "kselftests/arm64: add PAuth tests for single threaded consistency and key uniqueness"
    * change unique to different
    * rename "single_thread_unique_keys" to "single_thread_different_keys"
    * change reporting of error to be how many keys were left unchanged

Changes in v2:
* remove extra lines at end of files
* Patch 1: "kselftests: add a basic arm64 Pointer Authentication test"
	* add checks for a compatible compiler in Makefile
* Patch 4: "kselftests: add PAuth tests for single threaded consistency and
key uniqueness"
	* rephrase comment for clarity in pac.c

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Boyan Karatotev (4):
  kselftests/arm64: add a basic Pointer Authentication test
  kselftests/arm64: add nop checks for PAuth tests
  kselftests/arm64: add PAuth test for whether exec() changes keys
  kselftests/arm64: add PAuth tests for single threaded consistency and
    differently initialized keys

 tools/testing/selftests/arm64/Makefile        |   2 +-
 .../testing/selftests/arm64/pauth/.gitignore  |   2 +
 tools/testing/selftests/arm64/pauth/Makefile  |  39 ++
 .../selftests/arm64/pauth/exec_target.c       |  34 ++
 tools/testing/selftests/arm64/pauth/helper.c  |  39 ++
 tools/testing/selftests/arm64/pauth/helper.h  |  28 ++
 tools/testing/selftests/arm64/pauth/pac.c     | 368 ++++++++++++++++++
 .../selftests/arm64/pauth/pac_corruptor.S     |  19 +
 8 files changed, 530 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/pauth/.gitignore
 create mode 100644 tools/testing/selftests/arm64/pauth/Makefile
 create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.c
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.h
 create mode 100644 tools/testing/selftests/arm64/pauth/pac.c
 create mode 100644 tools/testing/selftests/arm64/pauth/pac_corruptor.S

--
2.28.0

