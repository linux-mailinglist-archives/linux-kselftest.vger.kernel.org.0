Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8D5BDBB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 06:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiITEcG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 00:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiITEcE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 00:32:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6504F688;
        Mon, 19 Sep 2022 21:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B8D6B82460;
        Tue, 20 Sep 2022 04:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C39C433C1;
        Tue, 20 Sep 2022 04:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663648320;
        bh=G4YYpJnTxquXyhq/5s9yFVygBQrSnN4g3Clkw1kfHYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBsUr0SyKHXeh6IQNo5NEP3SbQbzlbh85z7FniPDcwJAnD0n0bYtMyeYJ43GOxDEF
         ZSU7jvZ16xwkf+UMnutERd/UDWmFByJ1OvnlTWWq1w2Yiz1G0FJYpaHjR0f7fYpKSQ
         RxZ8VR5w8tNilGrZeYa8262CnUnaizN/bT9gLGRPbSmWJUWzrAw1+XR78JBqpzVXn2
         vpmEhJVtC/q7cBXZWsMNRHoGC4Z3s21a4Xvzk8D5+xIAGpmXbrldkhmknLhb42GBAM
         o7pFhtlECcqWsvSSTc228e7DysnTA1VGkDUmycUNxnZ3sRbyML6q2x3pGAmHjJgfIp
         cER6eQTENZEJQ==
Date:   Tue, 20 Sep 2022 07:31:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Stefan Berger <stefanb@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: tpm2: Implement class desstructor to close
 file descriptor
Message-ID: <YylCPAGbn7MgICau@kernel.org>
References: <20220909152056.1335261-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909152056.1335261-1-stefanb@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

s/desstructor/destructor/

I'd change it to "selftest: tpm2: Add Client.__del__() to close /dev/tpm* handle"

On Fri, Sep 09, 2022 at 11:20:56AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement a class destructor to close the open TPM file descriptor
> and avoid the following error message:
> 
>  test_flush_context (tpm2_tests.SpaceTest) ... \
>    /usr/lib64/python3.6/unittest/case.py:605: ResourceWarning: \
>    unclosed file <_io.FileIO name='/dev/tpmrm0' mode='rb+' closefd=True>

I don't recall seeing this. Does this happen on every test case?

Should better describe what is going on, e.g.

"
The following output can bee seen when the test is executed:

  test_flush_context (tpm2_tests.SpaceTest) ... \
    /usr/lib64/python3.6/unittest/case.py:605: ResourceWarning: \
    unclosed file <_io.FileIO name='/dev/tpmrm0' mode='rb+' closefd=True>

An instance of Client does not implicitly close /dev/tpm* handle, once it
gets destroyed. Close the file handle in the class destructor
Client.__del__().
"

> 
> Fixes: 6ea3dfe1e0732 ("selftests: add TPM 2.0 tests")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

BR, Jarkko
