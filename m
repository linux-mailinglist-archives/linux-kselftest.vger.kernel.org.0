Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0652042D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 23:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgFVVqY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 17:46:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:20658 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730609AbgFVVqU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 17:46:20 -0400
IronPort-SDR: 960zQAbJ6DlcoXtN01CxvZMaW6Rqv8KkEM4yLpQ6vkG90yQSLSrWGjXOICVGfhyyx6D0sMCjvq
 fZPsM3a9yOJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="141383801"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="141383801"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:46:17 -0700
IronPort-SDR: NaFZINSRLZL0a/PTkHaBPxmWnkeLhBQ3jiZ/On3ot9F9N0sDZK+kbUNCPiHD93jUsPfGHOFD8O
 dmtZ82DFiD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="451984214"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2020 14:46:14 -0700
Date:   Tue, 23 Jun 2020 00:46:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Heng Su <heng.su@intel.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v2] Kernel selftests: TPM2: upgrade TPM2 tests from
 Python 2 to Python 3
Message-ID: <20200622214613.GA22727@linux.intel.com>
References: <20200618081502.15302-1-pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618081502.15302-1-pengfei.xu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 04:15:02PM +0800, Pengfei Xu wrote:
> Python 2 is no longer supported by the Python upstream project, so
> upgrade TPM2 tests to Python 3.
> 
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>

Use "selftests: tpm: <short summary>".

> ---
>  tools/testing/selftests/tpm2/test_smoke.sh |  4 +-
>  tools/testing/selftests/tpm2/test_space.sh |  2 +-
>  tools/testing/selftests/tpm2/tpm2.py       | 68 ++++++++++++++--------
>  tools/testing/selftests/tpm2/tpm2_tests.py | 24 +++++---
>  4 files changed, 61 insertions(+), 37 deletions(-)
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
> index d0fcb66a88a6..b0ccc1499c53 100644
> --- a/tools/testing/selftests/tpm2/tpm2.py
> +++ b/tools/testing/selftests/tpm2/tpm2.py
> @@ -247,14 +247,18 @@ class ProtocolError(Exception):
>  class AuthCommand(object):
>      """TPMS_AUTH_COMMAND"""
>  
> -    def __init__(self, session_handle=TPM2_RS_PW, nonce='', session_attributes=0,
> -                 hmac=''):
> +    def __init__(self, session_handle=TPM2_RS_PW, nonce=''.encode(),
> +                 session_attributes=0, hmac=''.encode()):
> +        if not isinstance(nonce, bytes):
> +            nonce = nonce.encode()
> +        if not isinstance(hmac, bytes):
> +            hmac = hmac.encode()

This looks messy. Please, instead

    def __init__(self, session_handle=TPM2_RS_PW, nonce=bytes(),
                 session_attributes=0, hmac=bytes()):
         self.session_handle = session_handle
         self.nonce = nonce
         self.session_attributes = session_attributes

Applies also to other places.

/Jarkko
