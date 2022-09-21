Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB945D0229
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIUR7u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIUR7r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 13:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860481CFF7;
        Wed, 21 Sep 2022 10:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20BB0628ED;
        Wed, 21 Sep 2022 17:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB7C433B5;
        Wed, 21 Sep 2022 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663783184;
        bh=4pOLMeztJIu3nEW0T2LRhuRZWiCYEs+UKkekq56DBPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNHZB5s5geTf6XpneECm156/eqIW/xBej9otdtyGKvacbkPzMeYTn+XcJBPWiBI5s
         KjbNe9LHB/mSL3WogLp8DPbFTTJdThwyo2uEUCyeOYTLPArxza1+1Yc0o51SyvtODf
         wUQ6Ye3NgEEYMk+ZAQiBD6K7Kv4tpc70XIySFsi7YpIzSBYBsmNq8+JgD6oTzewzVu
         mFO5MkOa/Bp6WAfEMPbJ4JtJkwrIeAKmgtVkCj57F9UVF8ClX/1yDyBWBM48aWs2tn
         mG7bVc0nhJHPGby20WH+ykUa95ntpnb8Rky+hDrqrBIcoMkenZYvS22eTXH2hlq791
         05cmP+H6+/K/A==
Date:   Wed, 21 Sep 2022 20:59:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v2] selftest: tpm2: Add Client.__del__() to close
 /dev/tpm* handle
Message-ID: <YytRDQ2/u8R3Z6dx@kernel.org>
References: <20220920131518.1984701-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920131518.1984701-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 20, 2022 at 09:15:18AM -0400, Stefan Berger wrote:
> The following output can bee seen when the test is executed:
> 
>   test_flush_context (tpm2_tests.SpaceTest) ... \
>     /usr/lib64/python3.6/unittest/case.py:605: ResourceWarning: \
>     unclosed file <_io.FileIO name='/dev/tpmrm0' mode='rb+' closefd=True>
> 
> An instance of Client does not implicitly close /dev/tpm* handle, once it
> gets destroyed. Close the file handle in the class destructor
> Client.__del__().
> 
> Fixes: 6ea3dfe1e0732 ("selftests: add TPM 2.0 tests")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
>  tools/testing/selftests/tpm2/tpm2.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
> index 057a4f49c79d..c7363c6764fc 100644
> --- a/tools/testing/selftests/tpm2/tpm2.py
> +++ b/tools/testing/selftests/tpm2/tpm2.py
> @@ -371,6 +371,10 @@ class Client:
>              fcntl.fcntl(self.tpm, fcntl.F_SETFL, flags)
>              self.tpm_poll = select.poll()
>  
> +    def __del__(self):
> +        if self.tpm:
> +            self.tpm.close()
> +
>      def close(self):
>          self.tpm.close()
>  
> -- 
> 2.36.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
