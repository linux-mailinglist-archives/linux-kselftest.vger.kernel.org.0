Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952361A5F0D
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 16:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLOhy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 10:37:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:42870 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLOhy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 10:37:54 -0400
IronPort-SDR: 6X6Y2a955p9PXJvQwseZExGI8zetNBY8qigwixeTfv46jevUnjlbpBvHeKvqcTBhx91JnNb7le
 XYuxp8SmvGtg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 07:37:54 -0700
IronPort-SDR: g5GvYPM/6OJkMkd1J5auhcXyQrxGN9ZljbobsePfIk+rccajZMSz7msFDjzYvmKFAlTFNY9jtF
 BhoCNlkV3IuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="452907895"
Received: from apresura-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.246])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2020 07:37:52 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/tpm2: Change exception handling to be Python 3 compatible
Date:   Sun, 12 Apr 2020 17:36:54 +0300
Message-Id: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I need more time to fix all the byte array / string related stuff but
it makes sense to fix the exceptions as it is fairly mechanical
procedure:

1,$s/except \(.*\), \(.*\):/except \1(\2):/g

I.e. fix the low hanging fruit first and the rest later.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 tools/testing/selftests/tpm2/tpm2_tests.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 728be7c69b76..c3c06899e042 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -65,7 +65,7 @@ class SmokeTest(unittest.TestCase):
         blob = self.client.seal(self.root_key, data, auth, None)
         try:
             result = self.client.unseal(self.root_key, blob, auth[:-1] + 'B', None)
-        except ProtocolError, e:
+        except ProtocolError(e):
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
@@ -119,7 +119,7 @@ class SmokeTest(unittest.TestCase):
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
-        except ProtocolError, e:
+        except ProtocolError(e):
             rc = e.rc
             self.client.flush_context(handle)
         except:
@@ -136,7 +136,7 @@ class SmokeTest(unittest.TestCase):
         rc = 0
         try:
             blob = self.client.seal(self.root_key, data, auth, None)
-        except ProtocolError, e:
+        except ProtocolError(e):
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_SIZE)
@@ -152,7 +152,7 @@ class SmokeTest(unittest.TestCase):
                               0xDEADBEEF)
 
             self.client.send_cmd(cmd)
-        except IOError, e:
+        except IOError(e):
             rejected = True
         except:
             pass
@@ -212,7 +212,7 @@ class SmokeTest(unittest.TestCase):
             self.client.tpm.write(cmd)
             rsp = self.client.tpm.read()
 
-        except IOError, e:
+        except IOError(e):
             # read the response
             rsp = self.client.tpm.read()
             rejected = True
@@ -283,7 +283,7 @@ class SpaceTest(unittest.TestCase):
         rc = 0
         try:
             space1.send_cmd(cmd)
-        except ProtocolError, e:
+        except ProtocolError(e):
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_COMMAND_CODE |
-- 
2.25.1

