Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4471FED42
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFRILM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 04:11:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:57920 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgFRIG2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 04:06:28 -0400
IronPort-SDR: iqTgzkBx7e1dvaH74xyRZq0QyBRhoUBV+uAYIgmqFxYJC+fW66bavjGseU/T299y0wGZT5N84l
 SzF9ZtRSx1vQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="130900688"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="130900688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 01:05:20 -0700
IronPort-SDR: GaA7pOZC0htEapDDeKUdOgwtYlnuYPCANNQGNUVefeGC9uRImDiGhZ+n2kBW/9TPM26D5uheIL
 F6kt4Hk/FVGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="299584911"
Received: from xpf-desktop.sh.intel.com ([10.239.13.107])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jun 2020 01:05:09 -0700
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>
Subject: [PATCH v2] Kernel selftests: TPM2: upgrade TPM2 tests from Python 2 to Python 3
Date:   Thu, 18 Jun 2020 16:15:02 +0800
Message-Id: <20200618081502.15302-1-pengfei.xu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Python 2 is no longer supported by the Python upstream project, so
upgrade TPM2 tests to Python 3.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh |  4 +-
 tools/testing/selftests/tpm2/test_space.sh |  2 +-
 tools/testing/selftests/tpm2/tpm2.py       | 68 ++++++++++++++--------
 tools/testing/selftests/tpm2/tpm2_tests.py | 24 +++++---
 4 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 663062701d5a..d05467f6d258 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -6,8 +6,8 @@ ksft_skip=4
 
 [ -f /dev/tpm0 ] || exit $ksft_skip
 
-python -m unittest -v tpm2_tests.SmokeTest
-python -m unittest -v tpm2_tests.AsyncTest
+python3 -m unittest -v tpm2_tests.SmokeTest
+python3 -m unittest -v tpm2_tests.AsyncTest
 
 CLEAR_CMD=$(which tpm2_clear)
 if [ -n $CLEAR_CMD ]; then
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 36c9d030a1c6..151c64e8ee9f 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -6,4 +6,4 @@ ksft_skip=4
 
 [ -f /dev/tpmrm0 ] || exit $ksft_skip
 
-python -m unittest -v tpm2_tests.SpaceTest
+python3 -m unittest -v tpm2_tests.SpaceTest
diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index d0fcb66a88a6..b0ccc1499c53 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -247,14 +247,18 @@ class ProtocolError(Exception):
 class AuthCommand(object):
     """TPMS_AUTH_COMMAND"""
 
-    def __init__(self, session_handle=TPM2_RS_PW, nonce='', session_attributes=0,
-                 hmac=''):
+    def __init__(self, session_handle=TPM2_RS_PW, nonce=''.encode(),
+                 session_attributes=0, hmac=''.encode()):
+        if not isinstance(nonce, bytes):
+            nonce = nonce.encode()
+        if not isinstance(hmac, bytes):
+            hmac = hmac.encode()
         self.session_handle = session_handle
         self.nonce = nonce
         self.session_attributes = session_attributes
         self.hmac = hmac
 
-    def __str__(self):
+    def __bytes__(self):
         fmt = '>I H%us B H%us' % (len(self.nonce), len(self.hmac))
         return struct.pack(fmt, self.session_handle, len(self.nonce),
                            self.nonce, self.session_attributes, len(self.hmac),
@@ -268,11 +272,15 @@ class AuthCommand(object):
 class SensitiveCreate(object):
     """TPMS_SENSITIVE_CREATE"""
 
-    def __init__(self, user_auth='', data=''):
+    def __init__(self, user_auth=''.encode(), data=''.encode()):
+        if not isinstance(user_auth, bytes):
+            user_auth = user_auth.encode()
+        if not isinstance(data, bytes):
+            data = data.encode()
         self.user_auth = user_auth
         self.data = data
 
-    def __str__(self):
+    def __bytes__(self):
         fmt = '>H%us H%us' % (len(self.user_auth), len(self.data))
         return struct.pack(fmt, len(self.user_auth), self.user_auth,
                            len(self.data), self.data)
@@ -296,8 +304,15 @@ class Public(object):
         return '>HHIH%us%usH%us' % \
             (len(self.auth_policy), len(self.parameters), len(self.unique))
 
-    def __init__(self, object_type, name_alg, object_attributes, auth_policy='',
-                 parameters='', unique=''):
+    def __init__(self, object_type, name_alg, object_attributes,
+                 auth_policy=''.encode(), parameters=''.encode(),
+                 unique=''.encode()):
+        if not isinstance(auth_policy, bytes):
+            auth_policy = auth_policy.encode()
+        if not isinstance(parameters, bytes):
+            parameters = parameters.encode()
+        if not isinstance(unique, bytes):
+            unique = unique.encode()
         self.object_type = object_type
         self.name_alg = name_alg
         self.object_attributes = object_attributes
@@ -305,7 +320,7 @@ class Public(object):
         self.parameters = parameters
         self.unique = unique
 
-    def __str__(self):
+    def __bytes__(self):
         return struct.pack(self.__fmt(),
                            self.object_type,
                            self.name_alg,
@@ -343,7 +358,7 @@ def get_algorithm(name):
 
 def hex_dump(d):
     d = [format(ord(x), '02x') for x in d]
-    d = [d[i: i + 16] for i in xrange(0, len(d), 16)]
+    d = [d[i: i + 16] for i in range(0, len(d), 16)]
     d = [' '.join(x) for x in d]
     d = os.linesep.join(d)
 
@@ -401,7 +416,7 @@ class Client:
         pcrsel_len = max((i >> 3) + 1, 3)
         pcrsel = [0] * pcrsel_len
         pcrsel[i >> 3] = 1 << (i & 7)
-        pcrsel = ''.join(map(chr, pcrsel))
+        pcrsel = ''.join(map(chr, pcrsel)).encode()
 
         fmt = '>HII IHB%us' % (pcrsel_len)
         cmd = struct.pack(fmt,
@@ -430,6 +445,8 @@ class Client:
         return rsp
 
     def extend_pcr(self, i, dig, bank_alg = TPM2_ALG_SHA1):
+        if not isinstance(dig, bytes):
+            dig = dig.encode()
         ds = get_digest_size(bank_alg)
         assert(ds == len(dig))
 
@@ -443,7 +460,7 @@ class Client:
             TPM2_CC_PCR_EXTEND,
             i,
             len(auth_cmd),
-            str(auth_cmd),
+            bytes(auth_cmd),
             1, bank_alg, dig)
 
         self.send_cmd(cmd)
@@ -457,7 +474,7 @@ class Client:
                           TPM2_RH_NULL,
                           TPM2_RH_NULL,
                           16,
-                          '\0' * 16,
+                          ('\0' * 16).encode(),
                           0,
                           session_type,
                           TPM2_ALG_NULL,
@@ -472,7 +489,7 @@ class Client:
 
         for i in pcrs:
             pcr = self.read_pcr(i, bank_alg)
-            if pcr == None:
+            if pcr is None:
                 return None
             x += pcr
 
@@ -489,7 +506,7 @@ class Client:
         pcrsel = [0] * pcrsel_len
         for i in pcrs:
             pcrsel[i >> 3] |= 1 << (i & 7)
-        pcrsel = ''.join(map(chr, pcrsel))
+        pcrsel = ''.join(map(chr, pcrsel)).encode()
 
         fmt = '>HII IH%usIHB3s' % ds
         cmd = struct.pack(fmt,
@@ -497,7 +514,8 @@ class Client:
                           struct.calcsize(fmt),
                           TPM2_CC_POLICY_PCR,
                           handle,
-                          len(dig), str(dig),
+                          len(dig),
+                          bytes(dig),
                           1,
                           bank_alg,
                           pcrsel_len, pcrsel)
@@ -570,11 +588,11 @@ class Client:
             TPM2_CC_CREATE_PRIMARY,
             TPM2_RH_OWNER,
             len(auth_cmd),
-            str(auth_cmd),
+            bytes(auth_cmd),
             len(sensitive),
-            str(sensitive),
+            bytes(sensitive),
             len(public),
-            str(public),
+            bytes(public),
             0, 0)
 
         return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
@@ -608,11 +626,11 @@ class Client:
             TPM2_CC_CREATE,
             parent_key,
             len(auth_cmd),
-            str(auth_cmd),
+            bytes(auth_cmd),
             len(sensitive),
-            str(sensitive),
+            bytes(sensitive),
             len(public),
-            str(public),
+            bytes(public),
             0, 0)
 
         rsp = self.send_cmd(cmd)
@@ -635,7 +653,7 @@ class Client:
             TPM2_CC_LOAD,
             parent_key,
             len(auth_cmd),
-            str(auth_cmd),
+            bytes(auth_cmd),
             blob)
 
         data_handle = struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
@@ -653,7 +671,7 @@ class Client:
             TPM2_CC_UNSEAL,
             data_handle,
             len(auth_cmd),
-            str(auth_cmd))
+            bytes(auth_cmd))
 
         try:
             rsp = self.send_cmd(cmd)
@@ -675,7 +693,7 @@ class Client:
             TPM2_CC_DICTIONARY_ATTACK_LOCK_RESET,
             TPM2_RH_LOCKOUT,
             len(auth_cmd),
-            str(auth_cmd))
+            bytes(auth_cmd))
 
         self.send_cmd(cmd)
 
@@ -693,7 +711,7 @@ class Client:
         more_data, cap, cnt = struct.unpack('>BII', rsp[:9])
         rsp = rsp[9:]
 
-        for i in xrange(0, cnt):
+        for i in range(0, cnt):
             handle = struct.unpack('>I', rsp[:4])[0]
             handles.append(handle)
             rsp = rsp[4:]
diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 728be7c69b76..e134033e6f67 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -25,7 +25,9 @@ class SmokeTest(unittest.TestCase):
 
         blob = self.client.seal(self.root_key, data, auth, None)
         result = self.client.unseal(self.root_key, blob, auth, None)
-        self.assertEqual(data, result)
+        if not isinstance(result, bytes):
+            result = result.encode()
+        self.assertEqual(data.encode(), result)
 
     def test_seal_with_policy(self):
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
@@ -51,11 +53,13 @@ class SmokeTest(unittest.TestCase):
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
+            if not isinstance(result, bytes):
+                result = result.encode()
         except:
             self.client.flush_context(handle)
             raise
 
-        self.assertEqual(data, result)
+        self.assertEqual(data.encode(), result)
 
     def test_unseal_with_wrong_auth(self):
         data = 'X' * 64
@@ -65,7 +69,7 @@ class SmokeTest(unittest.TestCase):
         blob = self.client.seal(self.root_key, data, auth, None)
         try:
             result = self.client.unseal(self.root_key, blob, auth[:-1] + 'B', None)
-        except ProtocolError, e:
+        except ProtocolError as e:
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
@@ -100,11 +104,13 @@ class SmokeTest(unittest.TestCase):
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
+            if not isinstance(result, bytes):
+                result = result.encode()
         except:
             self.client.flush_context(handle)
             raise
 
-        self.assertEqual(data, result)
+        self.assertEqual(data.encode(), result)
 
         # Then, extend a PCR that is part of the policy and try to unseal.
         # This should fail.
@@ -119,7 +125,7 @@ class SmokeTest(unittest.TestCase):
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
-        except ProtocolError, e:
+        except ProtocolError as e:
             rc = e.rc
             self.client.flush_context(handle)
         except:
@@ -136,7 +142,7 @@ class SmokeTest(unittest.TestCase):
         rc = 0
         try:
             blob = self.client.seal(self.root_key, data, auth, None)
-        except ProtocolError, e:
+        except ProtocolError as e:
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_SIZE)
@@ -152,7 +158,7 @@ class SmokeTest(unittest.TestCase):
                               0xDEADBEEF)
 
             self.client.send_cmd(cmd)
-        except IOError, e:
+        except IOError as e:
             rejected = True
         except:
             pass
@@ -212,7 +218,7 @@ class SmokeTest(unittest.TestCase):
             self.client.tpm.write(cmd)
             rsp = self.client.tpm.read()
 
-        except IOError, e:
+        except IOError as e:
             # read the response
             rsp = self.client.tpm.read()
             rejected = True
@@ -283,7 +289,7 @@ class SpaceTest(unittest.TestCase):
         rc = 0
         try:
             space1.send_cmd(cmd)
-        except ProtocolError, e:
+        except ProtocolError as e:
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_COMMAND_CODE |
-- 
2.17.1

