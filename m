Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC31D95E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 14:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgESMIZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 08:08:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54250 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgESMIY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 08:08:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 923684050C;
        Tue, 19 May 2020 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589890104; bh=5U+7CPG84Fx9MSC1QbUrTwvZo58qbTd3QcFm6yKsI9w=;
        h=From:To:Cc:Subject:Date:From;
        b=F98P3paCBmltrL9S1Ef3yazrOSEjbRdI26DYsfv2I2yxHmGNMcUsqop8Y7FREVDc3
         Wg/vfiP+OdUO7px0l6hJYguCZuz7vHcWf7j8UzRXi3kBpefueDrNVeOnc3tTIsagbh
         BgZxwOcFZp5+Ydrk7B/h7yPkZzHf4zRWCm44ILp+MLX1u8oJ+rsIzXiVdj7Jm6jOzH
         M0atw6L9jbRYj1i1S/lBuKHrASrNSuNKhe8y3G1RAs5Nwc2fqQwg+Sv+Aw18Rf7DmI
         IUqX7hymMrvVkOXUIZLcGKMRHhpHvdgqiTRADRjVlCv4U6MePR5lfEzTUi5q7soC+6
         Cfzrei8hUv9bQ==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 716F7A005C;
        Tue, 19 May 2020 12:08:20 +0000 (UTC)
From:   Nikita Sobolev <Nikita.Sobolev@synopsys.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Subject: [PATCH v2] Kernel selftests: Add check if tpm devices are supported
Date:   Tue, 19 May 2020 15:07:43 +0300
Message-Id: <20200519120743.41358-1-Nikita.Sobolev@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tpm2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
are available. In case, when these devices are not available test
fails, but expected behaviour is skipped test.

Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
---
Changes for v2:
    - Coding Style cleanup

 tools/testing/selftests/tpm2/test_smoke.sh | 5 +++++
 tools/testing/selftests/tpm2/test_space.sh | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 8155c2ea7ccb..663062701d5a 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -f /dev/tpm0 ] || exit $ksft_skip
+
 python -m unittest -v tpm2_tests.SmokeTest
 python -m unittest -v tpm2_tests.AsyncTest
 
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index a6f5e346635e..36c9d030a1c6 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,4 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -f /dev/tpmrm0 ] || exit $ksft_skip
+
 python -m unittest -v tpm2_tests.SpaceTest
-- 
2.16.2

