Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B641E649A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbgE1OwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 10:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391291AbgE1OwB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 10:52:01 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399552075F;
        Thu, 28 May 2020 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590677520;
        bh=MBo4bydaito7Zjn+vXtlyMHlcEan2eQv5rPVnMPb2hU=;
        h=From:To:Cc:Subject:Date:From;
        b=badEl0doIkZEELJSx0nuJDS02rcm35o0j/kBDK5cCxECBCskSnj298BmpBWgrq1lT
         KmVbmkl2a4cp9tZ3/17ImRTUDpwEhj6yBlnd8XrCrLehx57WsVcCeLdOMjJPDv2TKD
         +4bNLdxZ+75uCfjUPxdR9+3fL5KuRocd06DH2ANc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: [PATCH 0/4] selftests, sysctl, lib: Fix prime_numbers and sysctl test to run
Date:   Thu, 28 May 2020 23:51:54 +0900
Message-Id: <159067751438.229397.6746886115540895104.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Recently, I found some tests were always skipped.
Here is a series of patches to fix those issues.

The prime_numbers test is skipped in some cases because
prime_numbers.ko is not always compiled.
Since the CONFIG_PRIME_NUMBERS is not independently
configurable item (it has no title and help), it is enabled
only if other configs (DRM_DEBUG_SELFTEST etc.) select it.

To fix this issue, I added a title and help for
CONFIG_PRIME_NUMBERS.

The sysctl test is skipped because
 - selftests/sysctl/config requires CONFIG_TEST_SYSCTL=y. But
   since lib/test_sysctl.c doesn't use module_init(), the
   test_syscall is not listed under /sys/module/ and the 
   test script gives up.
 - Even if we make CONFIG_TEST_SYSCTL=m, the test script checks
   /sys/modules/test_sysctl before loading module and gives up.
 - Ayway, since the test module introduces useless sysctl
   interface to the kernel, it would better be a module.

This series includes fixes for above 3 points.
 - Fix lib/test_sysctl.c to use module_init()
 - Fix tools/testing/selftests/sysctl/sysctl.sh to try to load
   test module if it is not loaded (nor embedded).
 - Fix tools/testing/selftests/sysctl/config to require
   CONFIG_TEST_SYSCTL=m, not y.

Thank you,

---

Masami Hiramatsu (4):
      lib: Make prime number generator independently selectable
      lib: Make test_sysctl initialized as module
      selftests/sysctl: Fix to load test_sysctl module
      selftests/sysctl: Make sysctl test driver as a module


 lib/math/Kconfig                         |    7 ++++++-
 lib/test_sysctl.c                        |    2 +-
 tools/testing/selftests/sysctl/config    |    2 +-
 tools/testing/selftests/sysctl/sysctl.sh |   13 ++-----------
 4 files changed, 10 insertions(+), 14 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
