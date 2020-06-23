Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071E72050C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbgFWLcO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jun 2020 07:32:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:13397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732450AbgFWLcH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jun 2020 07:32:07 -0400
IronPort-SDR: pMpnCYkGbQbgOtkmZxsuOb8kyRtrhcIjn2UmW+3nO2zehu17+aRiUcCtP7+PKAdbbU89Ua/qRu
 pPzdNd9tIKKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="162125691"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="162125691"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 04:32:04 -0700
IronPort-SDR: 5tkfT0mZr3W/taJOkL52IkrQPichvXxonir3i8I80hB2DPMHRI27NufAZe238Pjv7lkhilhA4x
 ntx8O0syHBkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="353775553"
Received: from xpf-desktop.sh.intel.com ([10.239.13.107])
  by orsmga001.jf.intel.com with ESMTP; 23 Jun 2020 04:32:01 -0700
Date:   Tue, 23 Jun 2020 19:41:55 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Heng Su <heng.su@intel.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v2] Kernel selftests: TPM2: upgrade TPM2 tests from
 Python 2 to Python 3
Message-ID: <20200623114155.GA15561@xpf-desktop.sh.intel.com>
References: <20200618081502.15302-1-pengfei.xu@intel.com>
 <20200622214613.GA22727@linux.intel.com>
 <20200622214739.GB22727@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622214739.GB22727@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkk,
  Thanks for your comments!
  My feedback is as below.

  BR.

On 2020-06-23 at 00:47:39 +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 23, 2020 at 12:46:18AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jun 18, 2020 at 04:15:02PM +0800, Pengfei Xu wrote:
> > > Python 2 is no longer supported by the Python upstream project, so
> > > upgrade TPM2 tests to Python 3.
> > > 
> > > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > 
> > Use "selftests: tpm: <short summary>".
> > 

   Will do.

> > > ---
> > >  tools/testing/selftests/tpm2/test_smoke.sh |  4 +-
> > >  tools/testing/selftests/tpm2/test_space.sh |  2 +-
> > >  tools/testing/selftests/tpm2/tpm2.py       | 68 ++++++++++++++--------
> > >  tools/testing/selftests/tpm2/tpm2_tests.py | 24 +++++---
> > >  4 files changed, 61 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> > > index 663062701d5a..d05467f6d258 100755
> > > --- a/tools/testing/selftests/tpm2/test_smoke.sh
> > > +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> > > @@ -6,8 +6,8 @@ ksft_skip=4
> > >  
> > >  [ -f /dev/tpm0 ] || exit $ksft_skip
> > >  
> > > -python -m unittest -v tpm2_tests.SmokeTest
> > > -python -m unittest -v tpm2_tests.AsyncTest
> > > +python3 -m unittest -v tpm2_tests.SmokeTest
> > > +python3 -m unittest -v tpm2_tests.AsyncTest
> > >  
> > >  CLEAR_CMD=$(which tpm2_clear)
> > >  if [ -n $CLEAR_CMD ]; then
> > > diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
> > > index 36c9d030a1c6..151c64e8ee9f 100755
> > > --- a/tools/testing/selftests/tpm2/test_space.sh
> > > +++ b/tools/testing/selftests/tpm2/test_space.sh
> > > @@ -6,4 +6,4 @@ ksft_skip=4
> > >  
> > >  [ -f /dev/tpmrm0 ] || exit $ksft_skip
> > >  
> > > -python -m unittest -v tpm2_tests.SpaceTest
> > > +python3 -m unittest -v tpm2_tests.SpaceTest
> > > diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
> > > index d0fcb66a88a6..b0ccc1499c53 100644
> > > --- a/tools/testing/selftests/tpm2/tpm2.py
> > > +++ b/tools/testing/selftests/tpm2/tpm2.py
> > > @@ -247,14 +247,18 @@ class ProtocolError(Exception):
> > >  class AuthCommand(object):
> > >      """TPMS_AUTH_COMMAND"""
> > >  
> > > -    def __init__(self, session_handle=TPM2_RS_PW, nonce='', session_attributes=0,
> > > -                 hmac=''):
> > > +    def __init__(self, session_handle=TPM2_RS_PW, nonce=''.encode(),
> > > +                 session_attributes=0, hmac=''.encode()):
> > > +        if not isinstance(nonce, bytes):
> > > +            nonce = nonce.encode()
> > > +        if not isinstance(hmac, bytes):
> > > +            hmac = hmac.encode()
> > 
> > This looks messy. Please, instead
> > 
> >     def __init__(self, session_handle=TPM2_RS_PW, nonce=bytes(),
> >                  session_attributes=0, hmac=bytes()):
> >          self.session_handle = session_handle
> >          self.nonce = nonce
> >          self.session_attributes = session_attributes
> > 
> > Applies also to other places.
> 
> I.e. use '.encode()' in the call site.
> 

  I tried to use bytes(parm, encoding='UTF-8') way, it met the situation
  that sometimes parm is string, sometimes parm is bytes.
  And it's better we could convert all types value to bytes in
  __init__ function.

  Could we modify it as below:
def ConvertToBytes(parm):
    if not isinstance(parm, bytes):
        parm = parm.encode()
    return parm

class AuthCommand(object):
    """TPMS_AUTH_COMMAND"""

    def __init__(self, session_handle=TPM2_RS_PW, nonce='',
                 session_attributes=0, hmac=''):
        self.session_handle = session_handle
        self.nonce = ConvertToBytes(nonce)
        self.session_attributes = session_attributes
        self.hmac = ConvertToBytes(hmac)

Thanks!

> /Jarkko
