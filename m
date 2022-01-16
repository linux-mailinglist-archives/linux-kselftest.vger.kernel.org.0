Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892E748FD78
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jan 2022 15:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiAPOeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jan 2022 09:34:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33146 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiAPOef (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jan 2022 09:34:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14139B80D05;
        Sun, 16 Jan 2022 14:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF34C36AE7;
        Sun, 16 Jan 2022 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642343672;
        bh=oCqvjsNEHd9Y5M9rEsW3iU49LfLeq8eNQ8Zn339zLqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j58W1h/obVl+IfAzefOxcsNjkMZGG9Dh7jPlmOPhHkz2nq9mysO1oJvaEn9mQkNfj
         ylI2Advz7kOA48NCzouItB152EWl6E3XY8I5hGqc9jNY/PpeIAqcx0CHKaudy8Pc9Z
         KJKtfAh1LmpnPXYD7eyVGZCazzJeMzNPV48SLuuZ7ZP8GyLjllSCfApEZnJIrUVVAG
         S1f34/3bv2CEgtlXTn3BVTEsuvxHkAatjm0N0NqnQaZuMC5Jtss+lTcguvnLE0AIw7
         zqYC+7leO0dKC6vTQLEwFC88CA/rv+rcZWpfBRSpqQW0M5i6te5pTUTSdeghWOBGFU
         6J3bPsKGKjbcQ==
Date:   Sun, 16 Jan 2022 16:34:20 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: tpm: add async space test with
 noneexisting handle
Message-ID: <YeQs7Fy5NaK6m6Ar@iki.fi>
References: <20220116012627.2031-1-tstruk@gmail.com>
 <20220116012627.2031-2-tstruk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116012627.2031-2-tstruk@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 15, 2022 at 05:26:27PM -0800, Tadeusz Struk wrote:
> Add a test for /dev/tpmrm0 in async mode that checks if
> the code handles invalid handles correctly.
> 
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: <linux-integrity@vger.kernel.org>
> Cc: <linux-kselftest@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> 
> Tested-by: Jarkko Sakkinen<jarkko@kernel.org>
> Signed-off-by: Tadeusz Struk <tstruk@gmail.com>
> ---
> Changed in v2:
> - Updated commit message
> Changed in v3:
> - Fixed typo in the function name
> ---
>  tools/testing/selftests/tpm2/tpm2_tests.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> index 9d764306887b..340ffef97fb6 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -302,3 +302,19 @@ class AsyncTest(unittest.TestCase):
>          log.debug("Calling get_cap in a NON_BLOCKING mode")
>          async_client.get_cap(tpm2.TPM2_CAP_HANDLES, tpm2.HR_LOADED_SESSION)
>          async_client.close()
> +
> +    def test_flush_invalid_context(self):
> +        log = logging.getLogger(__name__)
> +        log.debug(sys._getframe().f_code.co_name)
> +
> +        async_client = tpm2.Client(tpm2.Client.FLAG_SPACE | tpm2.Client.FLAG_NONBLOCK)
> +        log.debug("Calling flush_context passing in an invalid handle ")
> +        handle = 0x80123456
> +        rc = 0
> +        try:
> +            async_client.flush_context(handle)
> +        except OSError as e:
> +            rc = e.errno
> +
> +        self.assertEqual(rc, 22)
> +        async_client.close()
> -- 
> 2.30.2
> 

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
