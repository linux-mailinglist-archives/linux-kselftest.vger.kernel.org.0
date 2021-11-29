Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F5462881
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 00:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhK2Xqk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 18:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhK2Xqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 18:46:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E5FC061574;
        Mon, 29 Nov 2021 15:43:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D16DB80E60;
        Mon, 29 Nov 2021 23:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E85C53FC7;
        Mon, 29 Nov 2021 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638229393;
        bh=v0akOi0mvD4yAAD/9uHOV/phrtGDtd87F2BTeHC8rCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qjtwn6sClt3hk+bYK30jgyULuNHdqpCQo+KyNMhVUsnc+x4HHKxC+Wup5C5bDzMhp
         H3DN67Q+yHKbzeP/e0B5e7bHProA74UldcB/OiK9tZSlbb73TPFx2sCH2oODrI+a3K
         xKa+gIgLfBidm607gvqlFU6JYSeTgIMmt4ur0HHDnuudpMOfpG9w1dKShJx8K7ciIJ
         3ObNnoqe9JTPtMkrCGsMLi1Aduvw69kY4qCqqlyJ3+PKtiy7v2jl5xqRNQ8FETbtEd
         i0MhmVU9AjoVEDN8O+LXdAPtHV20fXlBlCp8b880OeUOedoCVdZWtTRCffEQsrLcjy
         InW/h9FxUoQ0Q==
Date:   Tue, 30 Nov 2021 01:43:10 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] selftests: tpm2: Reset the dictionary attack lock
Message-ID: <YaVljk1vLRZ/TDJ/@iki.fi>
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128041052.1395504-3-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 27, 2021 at 11:10:52PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Reset the dictionary attack lock to avoid the following types of test
> failures after running the test 2 times:
> 
> ======================================================================
> ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2_tests.py", line 105, in test_unseal_with_wrong_policy
>     blob = self.client.seal(self.root_key, data, auth, policy_dig)
>   File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 620, in seal
>     rsp = self.send_cmd(cmd)
>   File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 397, in send_cmd
>     raise ProtocolError(cc, rc)
> tpm2.ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tools/testing/selftests/tpm2/tpm2_tests.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> index e63a37819978..ad6f54c01adf 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -139,6 +139,8 @@ class SmokeTest(unittest.TestCase):
>          except:
>              self.client.flush_context(handle)
>              raise
> +        finally:
> +            self.client.reset_da_lock()
>  
>          self.assertEqual(rc, tpm2.TPM2_RC_POLICY_FAIL)
>  
> -- 
> 2.31.1
> 

I don't agree with this as a DA lock has legit use. This would be adequate
for systems dedicated for kernel testing only.

We could make this available in the folder where TPM2 tests are:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-scripts.git/tree/tpm2-reset-da-lock

/Jarkko
