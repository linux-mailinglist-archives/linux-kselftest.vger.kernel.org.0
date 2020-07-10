Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE21C21BB2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGJQjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJQjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 12:39:39 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0EC08C5DC
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 09:39:39 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e90so4653996ote.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=67PxYPjEch8C6zTSY3ZVdK7Ai5qglilo8P3dvtMjP2I=;
        b=E9yMShM6sDUhQaoeReQuGbgI9Vn3xImSR1eUM6By8RjxBWzXFo/jVabBWhH08e4l6A
         /8tS7Ri72njF9MXMCfGvMOViQrDEgrjB6VhVAdNd8SL2XsKXKL1uQU/bGJkqCGfESfRh
         JSRhx0llgU7FAov0AO7ApqKkevZpSLnFxB9pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=67PxYPjEch8C6zTSY3ZVdK7Ai5qglilo8P3dvtMjP2I=;
        b=nHvaBA0Yv90xptuIlVyBkgiL/joU0GnBlF+zJJ6KMpcm4xEjXqFiSfdtVMfYP4NbyI
         XC3pnl2DHE++XLIQI0WvuH6mc/NWjzAe8Dl/STVIUNYzxTfZauNuPC6WwZy8LSRB7Tmc
         YMcdAi5s7bRaRMEvSJBwNWx9IQzOdIku/iMldiaZPCAwWpT+p+L8k+Do7TsZFkBaV5A5
         mY2WV0PSYXSpHhIdRIXPqd1czSB9XDhq3BphK66dYXsGJzqHJTTtSeB1r2YQAj99iQ55
         Prw6x2xQ6yG2ts3es2CUqbteQChWo0XPaDgqa4WGC1oqV0XR3+Jumt62E67lPfIKl795
         GXrg==
X-Gm-Message-State: AOAM533GHKYJUptG4fXq74ixgfmjA6SdKHEdacdU+ZgXKu5udIM6dckX
        GE8unOyxtjkPHhStAXtDa736JlNH/vc=
X-Google-Smtp-Source: ABdhPJzZu8RJ5CiP3e56yR3ByIb+ZpA64vNU4j+ohS2B1YPBxZuN/9f93c3eItJoGb5gkgF04tCMIg==
X-Received: by 2002:a9d:3a65:: with SMTP id j92mr38137082otc.14.1594399178326;
        Fri, 10 Jul 2020 09:39:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m2sm1230613ooe.43.2020.07.10.09.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 09:39:37 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.8-rc5
Message-ID: <f4297017-1d27-741d-3abc-36b6918801f6@linuxfoundation.org>
Date:   Fri, 10 Jul 2020 10:39:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0C286AB941D5FF612009F235"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------0C286AB941D5FF612009F235
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.8-rc5.

This Kselftest fixes update for Linux 5.8-rc5 consists of tmp2 test
changes to run on python3 and kselftest framework fix to incorrect
return type.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 377ff83083c953dd58c5a030b3c9b5b85d8cc727:

   selftests: tpm: Use /bin/sh instead of /bin/bash (2020-06-29 14:19:38 
-0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-fixes-5.8-rc5

for you to fetch changes up to 3c01655ac82eb6d1cc2cfe9507031f1b5e0a6df1:

   kselftest: ksft_test_num return type should be unsigned (2020-07-06 
15:07:47 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.8-rc5

This Kselftest fixes update for Linux 5.8-rc5 consists of tmp2 test
changes to run on python3 and kselftest framework fix to incorrect
return type.

----------------------------------------------------------------
Paolo Bonzini (1):
       kselftest: ksft_test_num return type should be unsigned

Pengfei Xu (1):
       selftests: tpm: upgrade TPM2 tests from Python 2 to Python 3

  tools/testing/selftests/kselftest.h        |  2 +-
  tools/testing/selftests/tpm2/test_smoke.sh |  4 +--
  tools/testing/selftests/tpm2/test_space.sh |  2 +-
  tools/testing/selftests/tpm2/tpm2.py       | 56 
++++++++++++++++--------------
  tools/testing/selftests/tpm2/tpm2_tests.py | 39 +++++++++++----------
  5 files changed, 53 insertions(+), 50 deletions(-)
----------------------------------------------------------------

--------------0C286AB941D5FF612009F235
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.8-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.8-rc5.diff"

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 0ac49d91a260..862eee734553 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -36,7 +36,7 @@ struct ksft_count {
 static struct ksft_count ksft_cnt;
 static unsigned int ksft_plan;
 
-static inline int ksft_test_num(void)
+static inline unsigned int ksft_test_num(void)
 {
 	return ksft_cnt.ksft_pass + ksft_cnt.ksft_fail +
 		ksft_cnt.ksft_xfail + ksft_cnt.ksft_xpass +
diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 1334e301d2a0..3e5ff29ee1dd 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -6,5 +6,5 @@ ksft_skip=4
 
 [ -e /dev/tpm0 ] || exit $ksft_skip
 
-python -m unittest -v tpm2_tests.SmokeTest
-python -m unittest -v tpm2_tests.AsyncTest
+python3 -m unittest -v tpm2_tests.SmokeTest
+python3 -m unittest -v tpm2_tests.AsyncTest
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 00259cb746cf..04c47b13fe8a 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -6,4 +6,4 @@ ksft_skip=4
 
 [ -e /dev/tpmrm0 ] || exit $ksft_skip
 
-python -m unittest -v tpm2_tests.SpaceTest
+python3 -m unittest -v tpm2_tests.SpaceTest
diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index d0fcb66a88a6..f34486cd7342 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -247,14 +247,14 @@ class ProtocolError(Exception):
 class AuthCommand(object):
     """TPMS_AUTH_COMMAND"""
 
-    def __init__(self, session_handle=TPM2_RS_PW, nonce='', session_attributes=0,
-                 hmac=''):
+    def __init__(self, session_handle=TPM2_RS_PW, nonce=bytes(),
+                 session_attributes=0, hmac=bytes()):
         self.session_handle = session_handle
         self.nonce = nonce
         self.session_attributes = session_attributes
         self.hmac = hmac
 
-    def __str__(self):
+    def __bytes__(self):
         fmt = '>I H%us B H%us' % (len(self.nonce), len(self.hmac))
         return struct.pack(fmt, self.session_handle, len(self.nonce),
                            self.nonce, self.session_attributes, len(self.hmac),
@@ -268,11 +268,11 @@ class AuthCommand(object):
 class SensitiveCreate(object):
     """TPMS_SENSITIVE_CREATE"""
 
-    def __init__(self, user_auth='', data=''):
+    def __init__(self, user_auth=bytes(), data=bytes()):
         self.user_auth = user_auth
         self.data = data
 
-    def __str__(self):
+    def __bytes__(self):
         fmt = '>H%us H%us' % (len(self.user_auth), len(self.data))
         return struct.pack(fmt, len(self.user_auth), self.user_auth,
                            len(self.data), self.data)
@@ -296,8 +296,9 @@ class Public(object):
         return '>HHIH%us%usH%us' % \
             (len(self.auth_policy), len(self.parameters), len(self.unique))
 
-    def __init__(self, object_type, name_alg, object_attributes, auth_policy='',
-                 parameters='', unique=''):
+    def __init__(self, object_type, name_alg, object_attributes,
+                 auth_policy=bytes(), parameters=bytes(),
+                 unique=bytes()):
         self.object_type = object_type
         self.name_alg = name_alg
         self.object_attributes = object_attributes
@@ -305,7 +306,7 @@ class Public(object):
         self.parameters = parameters
         self.unique = unique
 
-    def __str__(self):
+    def __bytes__(self):
         return struct.pack(self.__fmt(),
                            self.object_type,
                            self.name_alg,
@@ -343,7 +344,7 @@ def get_algorithm(name):
 
 def hex_dump(d):
     d = [format(ord(x), '02x') for x in d]
-    d = [d[i: i + 16] for i in xrange(0, len(d), 16)]
+    d = [d[i: i + 16] for i in range(0, len(d), 16)]
     d = [' '.join(x) for x in d]
     d = os.linesep.join(d)
 
@@ -401,7 +402,7 @@ class Client:
         pcrsel_len = max((i >> 3) + 1, 3)
         pcrsel = [0] * pcrsel_len
         pcrsel[i >> 3] = 1 << (i & 7)
-        pcrsel = ''.join(map(chr, pcrsel))
+        pcrsel = ''.join(map(chr, pcrsel)).encode()
 
         fmt = '>HII IHB%us' % (pcrsel_len)
         cmd = struct.pack(fmt,
@@ -443,7 +444,7 @@ class Client:
             TPM2_CC_PCR_EXTEND,
             i,
             len(auth_cmd),
-            str(auth_cmd),
+            bytes(auth_cmd),
             1, bank_alg, dig)
 
         self.send_cmd(cmd)
@@ -457,7 +458,7 @@ class Client:
                           TPM2_RH_NULL,
                           TPM2_RH_NULL,
                           16,
-                          '\0' * 16,
+                          ('\0' * 16).encode(),
                           0,
                           session_type,
                           TPM2_ALG_NULL,
@@ -472,7 +473,7 @@ class Client:
 
         for i in pcrs:
             pcr = self.read_pcr(i, bank_alg)
-            if pcr == None:
+            if pcr is None:
                 return None
             x += pcr
 
@@ -489,7 +490,7 @@ class Client:
         pcrsel = [0] * pcrsel_len
         for i in pcrs:
             pcrsel[i >> 3] |= 1 << (i & 7)
-        pcrsel = ''.join(map(chr, pcrsel))
+        pcrsel = ''.join(map(chr, pcrsel)).encode()
 
         fmt = '>HII IH%usIHB3s' % ds
         cmd = struct.pack(fmt,
@@ -497,7 +498,8 @@ class Client:
                           struct.calcsize(fmt),
                           TPM2_CC_POLICY_PCR,
                           handle,
-                          len(dig), str(dig),
+                          len(dig),
+                          bytes(dig),
                           1,
                           bank_alg,
                           pcrsel_len, pcrsel)
@@ -534,7 +536,7 @@ class Client:
 
         self.send_cmd(cmd)
 
-    def create_root_key(self, auth_value = ''):
+    def create_root_key(self, auth_value = bytes()):
         attributes = \
             Public.FIXED_TPM | \
             Public.FIXED_PARENT | \
@@ -570,11 +572,11 @@ class Client:
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
@@ -587,7 +589,7 @@ class Client:
         attributes = 0
         if not policy_dig:
             attributes |= Public.USER_WITH_AUTH
-            policy_dig = ''
+            policy_dig = bytes()
 
         auth_cmd =  AuthCommand()
         sensitive = SensitiveCreate(user_auth=auth_value, data=data)
@@ -608,11 +610,11 @@ class Client:
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
@@ -635,7 +637,7 @@ class Client:
             TPM2_CC_LOAD,
             parent_key,
             len(auth_cmd),
-            str(auth_cmd),
+            bytes(auth_cmd),
             blob)
 
         data_handle = struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
@@ -653,7 +655,7 @@ class Client:
             TPM2_CC_UNSEAL,
             data_handle,
             len(auth_cmd),
-            str(auth_cmd))
+            bytes(auth_cmd))
 
         try:
             rsp = self.send_cmd(cmd)
@@ -675,7 +677,7 @@ class Client:
             TPM2_CC_DICTIONARY_ATTACK_LOCK_RESET,
             TPM2_RH_LOCKOUT,
             len(auth_cmd),
-            str(auth_cmd))
+            bytes(auth_cmd))
 
         self.send_cmd(cmd)
 
@@ -693,7 +695,7 @@ class Client:
         more_data, cap, cnt = struct.unpack('>BII', rsp[:9])
         rsp = rsp[9:]
 
-        for i in xrange(0, cnt):
+        for i in range(0, cnt):
             handle = struct.unpack('>I', rsp[:4])[0]
             handles.append(handle)
             rsp = rsp[4:]
diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 728be7c69b76..9d764306887b 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -20,8 +20,8 @@ class SmokeTest(unittest.TestCase):
         self.client.close()
 
     def test_seal_with_auth(self):
-        data = 'X' * 64
-        auth = 'A' * 15
+        data = ('X' * 64).encode()
+        auth = ('A' * 15).encode()
 
         blob = self.client.seal(self.root_key, data, auth, None)
         result = self.client.unseal(self.root_key, blob, auth, None)
@@ -30,8 +30,8 @@ class SmokeTest(unittest.TestCase):
     def test_seal_with_policy(self):
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
-        data = 'X' * 64
-        auth = 'A' * 15
+        data = ('X' * 64).encode()
+        auth = ('A' * 15).encode()
         pcrs = [16]
 
         try:
@@ -58,14 +58,15 @@ class SmokeTest(unittest.TestCase):
         self.assertEqual(data, result)
 
     def test_unseal_with_wrong_auth(self):
-        data = 'X' * 64
-        auth = 'A' * 20
+        data = ('X' * 64).encode()
+        auth = ('A' * 20).encode()
         rc = 0
 
         blob = self.client.seal(self.root_key, data, auth, None)
         try:
-            result = self.client.unseal(self.root_key, blob, auth[:-1] + 'B', None)
-        except ProtocolError, e:
+            result = self.client.unseal(self.root_key, blob,
+                        auth[:-1] + 'B'.encode(), None)
+        except ProtocolError as e:
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
@@ -73,8 +74,8 @@ class SmokeTest(unittest.TestCase):
     def test_unseal_with_wrong_policy(self):
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
-        data = 'X' * 64
-        auth = 'A' * 17
+        data = ('X' * 64).encode()
+        auth = ('A' * 17).encode()
         pcrs = [16]
 
         try:
@@ -91,7 +92,7 @@ class SmokeTest(unittest.TestCase):
         # This should succeed.
 
         ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
-        self.client.extend_pcr(1, 'X' * ds)
+        self.client.extend_pcr(1, ('X' * ds).encode())
 
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
@@ -108,7 +109,7 @@ class SmokeTest(unittest.TestCase):
 
         # Then, extend a PCR that is part of the policy and try to unseal.
         # This should fail.
-        self.client.extend_pcr(16, 'X' * ds)
+        self.client.extend_pcr(16, ('X' * ds).encode())
 
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
@@ -119,7 +120,7 @@ class SmokeTest(unittest.TestCase):
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
-        except ProtocolError, e:
+        except ProtocolError as e:
             rc = e.rc
             self.client.flush_context(handle)
         except:
@@ -130,13 +131,13 @@ class SmokeTest(unittest.TestCase):
 
     def test_seal_with_too_long_auth(self):
         ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
-        data = 'X' * 64
-        auth = 'A' * (ds + 1)
+        data = ('X' * 64).encode()
+        auth = ('A' * (ds + 1)).encode()
 
         rc = 0
         try:
             blob = self.client.seal(self.root_key, data, auth, None)
-        except ProtocolError, e:
+        except ProtocolError as e:
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_SIZE)
@@ -152,7 +153,7 @@ class SmokeTest(unittest.TestCase):
                               0xDEADBEEF)
 
             self.client.send_cmd(cmd)
-        except IOError, e:
+        except IOError as e:
             rejected = True
         except:
             pass
@@ -212,7 +213,7 @@ class SmokeTest(unittest.TestCase):
             self.client.tpm.write(cmd)
             rsp = self.client.tpm.read()
 
-        except IOError, e:
+        except IOError as e:
             # read the response
             rsp = self.client.tpm.read()
             rejected = True
@@ -283,7 +284,7 @@ class SpaceTest(unittest.TestCase):
         rc = 0
         try:
             space1.send_cmd(cmd)
-        except ProtocolError, e:
+        except ProtocolError as e:
             rc = e.rc
 
         self.assertEqual(rc, tpm2.TPM2_RC_COMMAND_CODE |

--------------0C286AB941D5FF612009F235--
