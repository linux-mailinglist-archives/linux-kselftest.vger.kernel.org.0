Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C00204293
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 23:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgFVVXT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 17:23:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:20594 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbgFVVXT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 17:23:19 -0400
IronPort-SDR: OvNfOnG76QU0OXK9nUGSUclbrYRVxvuDNmgGK/o0CXYbqUZ5rrxIy/3cVkM4UobxFiSz1h4BQr
 VoUlZ0ZHXjbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131284806"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="131284806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:23:18 -0700
IronPort-SDR: 1qe1IqEQbX6OFoTJB/64GhFCnOlcqBqDRIHdYkPjPGp0lpD2vselbJo1xK1b/kyWyMRONNW+yI
 jLIFlQwcNFkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="278894253"
Received: from scheller-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.117])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2020 14:23:14 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     pengfei.xu@intel.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] selftests: tpm: Use 'test -e' instead of 'test -f'
Date:   Tue, 23 Jun 2020 00:20:21 +0300
Message-Id: <20200622212034.20624-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
References: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

'test -f' is suitable only for *regular* files. Use 'test -e' instead.

Cc: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Fixes: 5627f9cffee7 ("Kernel selftests: Add check if TPM devices are supported")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
 tools/testing/selftests/tpm2/test_space.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 79f8e9da5d21..338d6b0272dc 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -4,7 +4,7 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-[ -f /dev/tpm0 ] || exit $ksft_skip
+[ -e /dev/tpm0 ] || exit $ksft_skip
 
 python -m unittest -v tpm2_tests.SmokeTest
 python -m unittest -v tpm2_tests.AsyncTest
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 36c9d030a1c6..847cabb20a5f 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -4,6 +4,6 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-[ -f /dev/tpmrm0 ] || exit $ksft_skip
+[ -e /dev/tpmrm0 ] || exit $ksft_skip
 
 python -m unittest -v tpm2_tests.SpaceTest
-- 
2.25.1

