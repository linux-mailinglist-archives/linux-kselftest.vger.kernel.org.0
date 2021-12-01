Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC37464B6A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 11:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbhLAKTe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 05:19:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57942 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhLAKTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 05:19:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAD46B81E17;
        Wed,  1 Dec 2021 10:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D4C53FCC;
        Wed,  1 Dec 2021 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638353771;
        bh=/yfw6ulS/WNzVaJXtZ1Z8GK06B1i2tECnv9TGqJzLSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3aQDVwB7xpAZbfBe6QwqRcl2SwHGe/ABvt7SbPABG3WT9lTHc1gyEnx3fUpZdjUp
         GIDS1HVIHUnhfc3693GM6BvnRNKsYc2pDYRi8fca5tP0bErjbPdoYzZhNTDHwXX0/f
         TfH5WQrjB0XZWhqw0MgL9Hr6/+O5YC5lsdjw66A9+VbJGFC0HBpQoTTFJVvjqq97OR
         j9GdkGpnS2c+Njf/m+sNY2k2uqzjPR8ZgDKMMJYC+IwiXdqmEHqn2HFYgMaleJkXGM
         SnG+YBi9YkvNHn/xYCd4F+cR6mEpWDNfLUs+2oiVMMGeh+vd7FjnfSl2fcDmLHfv7M
         szAH1dQN6QAVQ==
Date:   Wed, 1 Dec 2021 12:16:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v4 2/2] selftests: tpm2: Reset the dictionary attack lock
Message-ID: <YadLaHB0oJZYTMbh@iki.fi>
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-3-stefanb@linux.vnet.ibm.com>
 <YaVljk1vLRZ/TDJ/@iki.fi>
 <e569444c-e0cd-52bc-308f-7fa457dbf086@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e569444c-e0cd-52bc-308f-7fa457dbf086@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 29, 2021 at 07:26:12PM -0500, Stefan Berger wrote:
> 
> On 11/29/21 18:43, Jarkko Sakkinen wrote:
> > On Sat, Nov 27, 2021 at 11:10:52PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Reset the dictionary attack lock to avoid the following types of test
> > > failures after running the test 2 times:
> > > 
> > > ======================================================================
> > > ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
> > > ----------------------------------------------------------------------
> > > Traceback (most recent call last):
> > >    File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2_tests.py", line 105, in test_unseal_with_wrong_policy
> > >      blob = self.client.seal(self.root_key, data, auth, policy_dig)
> > >    File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 620, in seal
> > >      rsp = self.send_cmd(cmd)
> > >    File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 397, in send_cmd
> > >      raise ProtocolError(cc, rc)
> > > tpm2.ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >   tools/testing/selftests/tpm2/tpm2_tests.py | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> > > index e63a37819978..ad6f54c01adf 100644
> > > --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> > > +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> > > @@ -139,6 +139,8 @@ class SmokeTest(unittest.TestCase):
> > >           except:
> > >               self.client.flush_context(handle)
> > >               raise
> > > +        finally:
> > > +            self.client.reset_da_lock()
> > >           self.assertEqual(rc, tpm2.TPM2_RC_POLICY_FAIL)
> > > -- 
> > > 2.31.1
> > > 
> > I don't agree with this as a DA lock has legit use. This would be adequate
> > for systems dedicated for kernel testing only.
> 
> The problem is this particular test case I am patching here causes the above
> test failures upon rerun. We are testing the driver here presumably and not
> the TPM2, so I think we should leave the TPM2 as cleaned up as possible,
> thus my suggestion is to reset the DA lock and we won't hear any complaints
> after that.

Ok.

> > We could make this available in the folder where TPM2 tests are:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-scripts.git/tree/tpm2-reset-da-lock
> 
> 
> The tss packages also have command line tools to reset the DA lock, but it
> shouldn't be necessary to use them after running a **driver** test case.

If you speak about TSS, please alway say which one :-)

Adding non-volatile state changes explicitly is to a test case is both
intrusive and wrong. These type of choices are not to be done in the
test case implementation for sure.

An improvement that does not add extra side-effect, would be to read the
TPM_PT_LOCKOUT_COUNTER and roll back with a proper error message for the
lockout condition.

You can also configure the maximum number of tries up to (2 << 31) - 1
= 4294967295 with TPM2_DictionaryAttackParameters.

/Jarkko
