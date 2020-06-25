Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411D420A7D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406145AbgFYVyx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 17:54:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:27464 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390589AbgFYVyx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 17:54:53 -0400
IronPort-SDR: vpuESzVfeqNVyEyA1Q/M6q/pPH+mFiPiwZWiOE1HbjqQ0+TOgdEsJmC+CZ+rE/yNwKif/DiYUW
 Kle7JSDSOXrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="143321396"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="143321396"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:51:50 -0700
IronPort-SDR: OCBOXSiEwPklVAC5YbY5Zt9AzyzjF0GNb0dD/ZZQjR4DSy8lXGiAH6Y7dwuJa9WJ7sfsqQUweH
 QSrWk19GsuHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="294019079"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by orsmga002.jf.intel.com with ESMTP; 25 Jun 2020 14:51:46 -0700
Date:   Fri, 26 Jun 2020 00:51:45 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Heng Su <heng.su@intel.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v3] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
Message-ID: <20200625215145.GH20341@linux.intel.com>
References: <20200625163754.7165-1-pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625163754.7165-1-pengfei.xu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 12:37:54AM +0800, Pengfei Xu wrote:
> Python 2 is no longer supported by the Python upstream project, so
> upgrade TPM2 tests to Python 3.
> 
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  tools/testing/selftests/tpm2/test_smoke.sh |  4 +-
>  tools/testing/selftests/tpm2/test_space.sh |  2 +-
>  tools/testing/selftests/tpm2/tpm2.py       | 56 +++++++++++-----------
>  tools/testing/selftests/tpm2/tpm2_tests.py | 39 +++++++--------
>  4 files changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> index 663062701d5a..d05467f6d258 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -6,8 +6,8 @@ ksft_skip=4
>  
>  [ -f /dev/tpm0 ] || exit $ksft_skip
>  
> -python -m unittest -v tpm2_tests.SmokeTest
> -python -m unittest -v tpm2_tests.AsyncTest
> +python3 -m unittest -v tpm2_tests.SmokeTest
> +python3 -m unittest -v tpm2_tests.AsyncTest
>  
>  CLEAR_CMD=$(which tpm2_clear)
>  if [ -n $CLEAR_CMD ]; then
> diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
> index 36c9d030a1c6..151c64e8ee9f 100755
> --- a/tools/testing/selftests/tpm2/test_space.sh
> +++ b/tools/testing/selftests/tpm2/test_space.sh
> @@ -6,4 +6,4 @@ ksft_skip=4
>  
>  [ -f /dev/tpmrm0 ] || exit $ksft_skip
>  
> -python -m unittest -v tpm2_tests.SpaceTest
> +python3 -m unittest -v tpm2_tests.SpaceTest
> diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
> index d0fcb66a88a6..88a0e7776a23 100644
> --- a/tools/testing/selftests/tpm2/tpm2.py
> +++ b/tools/testing/selftests/tpm2/tpm2.py
> @@ -247,14 +247,14 @@ class ProtocolError(Exception):
>  class AuthCommand(object):
>      """TPMS_AUTH_COMMAND"""
>  
> -    def __init__(self, session_handle=TPM2_RS_PW, nonce='', session_attributes=0,
> -                 hmac=''):
> +    def __init__(self, session_handle=TPM2_RS_PW, nonce=''.encode(),
> +                 session_attributes=0, hmac=''.encode()):

Initialize these just directly as empty bytes objects (e.g.
nonce=bytes())

>          self.session_handle = session_handle
>          self.nonce = nonce
>          self.session_attributes = session_attributes
>          self.hmac = hmac
>  
> -    def __str__(self):
> +    def __bytes__(self):
>          fmt = '>I H%us B H%us' % (len(self.nonce), len(self.hmac))
>          return struct.pack(fmt, self.session_handle, len(self.nonce),
>                             self.nonce, self.session_attributes, len(self.hmac),
> @@ -268,11 +268,11 @@ class AuthCommand(object):
>  class SensitiveCreate(object):
>      """TPMS_SENSITIVE_CREATE"""
>  
> -    def __init__(self, user_auth='', data=''):
> +    def __init__(self, user_auth=''.encode(), data=''.encode()):

Ditto.

>          self.user_auth = user_auth
>          self.data = data
>  
> -    def __str__(self):
> +    def __bytes__(self):
>          fmt = '>H%us H%us' % (len(self.user_auth), len(self.data))
>          return struct.pack(fmt, len(self.user_auth), self.user_auth,
>                             len(self.data), self.data)
> @@ -296,8 +296,9 @@ class Public(object):
>          return '>HHIH%us%usH%us' % \
>              (len(self.auth_policy), len(self.parameters), len(self.unique))
>  
> -    def __init__(self, object_type, name_alg, object_attributes, auth_policy='',
> -                 parameters='', unique=''):
> +    def __init__(self, object_type, name_alg, object_attributes,
> +                 auth_policy=''.encode(), parameters=''.encode(),
> +                 unique=''.encode()):

Ditto.

>          self.object_type = object_type
>          self.name_alg = name_alg
>          self.object_attributes = object_attributes
> @@ -305,7 +306,7 @@ class Public(object):
>          self.parameters = parameters
>          self.unique = unique
>  
> -    def __str__(self):
> +    def __bytes__(self):
>          return struct.pack(self.__fmt(),
>                             self.object_type,
>                             self.name_alg,
> @@ -343,7 +344,7 @@ def get_algorithm(name):
>  
>  def hex_dump(d):
>      d = [format(ord(x), '02x') for x in d]
> -    d = [d[i: i + 16] for i in xrange(0, len(d), 16)]
> +    d = [d[i: i + 16] for i in range(0, len(d), 16)]
>      d = [' '.join(x) for x in d]
>      d = os.linesep.join(d)
>  
> @@ -401,7 +402,7 @@ class Client:
>          pcrsel_len = max((i >> 3) + 1, 3)
>          pcrsel = [0] * pcrsel_len
>          pcrsel[i >> 3] = 1 << (i & 7)
> -        pcrsel = ''.join(map(chr, pcrsel))
> +        pcrsel = ''.join(map(chr, pcrsel)).encode()
>  
>          fmt = '>HII IHB%us' % (pcrsel_len)
>          cmd = struct.pack(fmt,
> @@ -443,7 +444,7 @@ class Client:
>              TPM2_CC_PCR_EXTEND,
>              i,
>              len(auth_cmd),
> -            str(auth_cmd),
> +            bytes(auth_cmd),
>              1, bank_alg, dig)
>  
>          self.send_cmd(cmd)
> @@ -457,7 +458,7 @@ class Client:
>                            TPM2_RH_NULL,
>                            TPM2_RH_NULL,
>                            16,
> -                          '\0' * 16,
> +                          ('\0' * 16).encode(),
>                            0,
>                            session_type,
>                            TPM2_ALG_NULL,
> @@ -472,7 +473,7 @@ class Client:
>  
>          for i in pcrs:
>              pcr = self.read_pcr(i, bank_alg)
> -            if pcr == None:
> +            if pcr is None:
>                  return None
>              x += pcr
>  
> @@ -489,7 +490,7 @@ class Client:
>          pcrsel = [0] * pcrsel_len
>          for i in pcrs:
>              pcrsel[i >> 3] |= 1 << (i & 7)
> -        pcrsel = ''.join(map(chr, pcrsel))
> +        pcrsel = ''.join(map(chr, pcrsel)).encode()
>  
>          fmt = '>HII IH%usIHB3s' % ds
>          cmd = struct.pack(fmt,
> @@ -497,7 +498,8 @@ class Client:
>                            struct.calcsize(fmt),
>                            TPM2_CC_POLICY_PCR,
>                            handle,
> -                          len(dig), str(dig),
> +                          len(dig),
> +                          bytes(dig),
>                            1,
>                            bank_alg,
>                            pcrsel_len, pcrsel)
> @@ -534,7 +536,7 @@ class Client:
>  
>          self.send_cmd(cmd)
>  
> -    def create_root_key(self, auth_value = ''):
> +    def create_root_key(self, auth_value = ''.encode()):
>          attributes = \
>              Public.FIXED_TPM | \
>              Public.FIXED_PARENT | \
> @@ -570,11 +572,11 @@ class Client:
>              TPM2_CC_CREATE_PRIMARY,
>              TPM2_RH_OWNER,
>              len(auth_cmd),
> -            str(auth_cmd),
> +            bytes(auth_cmd),
>              len(sensitive),
> -            str(sensitive),
> +            bytes(sensitive),
>              len(public),
> -            str(public),
> +            bytes(public),
>              0, 0)
>  
>          return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
> @@ -587,7 +589,7 @@ class Client:
>          attributes = 0
>          if not policy_dig:
>              attributes |= Public.USER_WITH_AUTH
> -            policy_dig = ''
> +            policy_dig = ''.encode()
>  
>          auth_cmd =  AuthCommand()
>          sensitive = SensitiveCreate(user_auth=auth_value, data=data)
> @@ -608,11 +610,11 @@ class Client:
>              TPM2_CC_CREATE,
>              parent_key,
>              len(auth_cmd),
> -            str(auth_cmd),
> +            bytes(auth_cmd),
>              len(sensitive),
> -            str(sensitive),
> +            bytes(sensitive),
>              len(public),
> -            str(public),
> +            bytes(public),
>              0, 0)
>  
>          rsp = self.send_cmd(cmd)
> @@ -635,7 +637,7 @@ class Client:
>              TPM2_CC_LOAD,
>              parent_key,
>              len(auth_cmd),
> -            str(auth_cmd),
> +            bytes(auth_cmd),
>              blob)
>  
>          data_handle = struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
> @@ -653,7 +655,7 @@ class Client:
>              TPM2_CC_UNSEAL,
>              data_handle,
>              len(auth_cmd),
> -            str(auth_cmd))
> +            bytes(auth_cmd))
>  
>          try:
>              rsp = self.send_cmd(cmd)
> @@ -675,7 +677,7 @@ class Client:
>              TPM2_CC_DICTIONARY_ATTACK_LOCK_RESET,
>              TPM2_RH_LOCKOUT,
>              len(auth_cmd),
> -            str(auth_cmd))
> +            bytes(auth_cmd))
>  
>          self.send_cmd(cmd)
>  
> @@ -693,7 +695,7 @@ class Client:
>          more_data, cap, cnt = struct.unpack('>BII', rsp[:9])
>          rsp = rsp[9:]
>  
> -        for i in xrange(0, cnt):
> +        for i in range(0, cnt):
>              handle = struct.unpack('>I', rsp[:4])[0]
>              handles.append(handle)
>              rsp = rsp[4:]
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> index 728be7c69b76..9d764306887b 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -20,8 +20,8 @@ class SmokeTest(unittest.TestCase):
>          self.client.close()
>  
>      def test_seal_with_auth(self):
> -        data = 'X' * 64
> -        auth = 'A' * 15
> +        data = ('X' * 64).encode()
> +        auth = ('A' * 15).encode()
>  
>          blob = self.client.seal(self.root_key, data, auth, None)
>          result = self.client.unseal(self.root_key, blob, auth, None)
> @@ -30,8 +30,8 @@ class SmokeTest(unittest.TestCase):
>      def test_seal_with_policy(self):
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>  
> -        data = 'X' * 64
> -        auth = 'A' * 15
> +        data = ('X' * 64).encode()
> +        auth = ('A' * 15).encode()
>          pcrs = [16]
>  
>          try:
> @@ -58,14 +58,15 @@ class SmokeTest(unittest.TestCase):
>          self.assertEqual(data, result)
>  
>      def test_unseal_with_wrong_auth(self):
> -        data = 'X' * 64
> -        auth = 'A' * 20
> +        data = ('X' * 64).encode()
> +        auth = ('A' * 20).encode()
>          rc = 0
>  
>          blob = self.client.seal(self.root_key, data, auth, None)
>          try:
> -            result = self.client.unseal(self.root_key, blob, auth[:-1] + 'B', None)
> -        except ProtocolError, e:
> +            result = self.client.unseal(self.root_key, blob,
> +                        auth[:-1] + 'B'.encode(), None)
> +        except ProtocolError as e:
>              rc = e.rc
>  
>          self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
> @@ -73,8 +74,8 @@ class SmokeTest(unittest.TestCase):
>      def test_unseal_with_wrong_policy(self):
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>  
> -        data = 'X' * 64
> -        auth = 'A' * 17
> +        data = ('X' * 64).encode()
> +        auth = ('A' * 17).encode()
>          pcrs = [16]
>  
>          try:
> @@ -91,7 +92,7 @@ class SmokeTest(unittest.TestCase):
>          # This should succeed.
>  
>          ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
> -        self.client.extend_pcr(1, 'X' * ds)
> +        self.client.extend_pcr(1, ('X' * ds).encode())
>  
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>  
> @@ -108,7 +109,7 @@ class SmokeTest(unittest.TestCase):
>  
>          # Then, extend a PCR that is part of the policy and try to unseal.
>          # This should fail.
> -        self.client.extend_pcr(16, 'X' * ds)
> +        self.client.extend_pcr(16, ('X' * ds).encode())
>  
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>  
> @@ -119,7 +120,7 @@ class SmokeTest(unittest.TestCase):
>              self.client.policy_password(handle)
>  
>              result = self.client.unseal(self.root_key, blob, auth, handle)
> -        except ProtocolError, e:
> +        except ProtocolError as e:
>              rc = e.rc
>              self.client.flush_context(handle)
>          except:
> @@ -130,13 +131,13 @@ class SmokeTest(unittest.TestCase):
>  
>      def test_seal_with_too_long_auth(self):
>          ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
> -        data = 'X' * 64
> -        auth = 'A' * (ds + 1)
> +        data = ('X' * 64).encode()
> +        auth = ('A' * (ds + 1)).encode()
>  
>          rc = 0
>          try:
>              blob = self.client.seal(self.root_key, data, auth, None)
> -        except ProtocolError, e:
> +        except ProtocolError as e:
>              rc = e.rc
>  
>          self.assertEqual(rc, tpm2.TPM2_RC_SIZE)
> @@ -152,7 +153,7 @@ class SmokeTest(unittest.TestCase):
>                                0xDEADBEEF)
>  
>              self.client.send_cmd(cmd)
> -        except IOError, e:
> +        except IOError as e:
>              rejected = True
>          except:
>              pass
> @@ -212,7 +213,7 @@ class SmokeTest(unittest.TestCase):
>              self.client.tpm.write(cmd)
>              rsp = self.client.tpm.read()
>  
> -        except IOError, e:
> +        except IOError as e:
>              # read the response
>              rsp = self.client.tpm.read()
>              rejected = True
> @@ -283,7 +284,7 @@ class SpaceTest(unittest.TestCase):
>          rc = 0
>          try:
>              space1.send_cmd(cmd)
> -        except ProtocolError, e:
> +        except ProtocolError as e:
>              rc = e.rc
>  
>          self.assertEqual(rc, tpm2.TPM2_RC_COMMAND_CODE |
> -- 
> 2.17.1
> 

Otherwise, starts to look good.

/Jarkko
