Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468E52547A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357320AbiELSKD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354531AbiELSKC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 14:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691B2689C6;
        Thu, 12 May 2022 11:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D458D61682;
        Thu, 12 May 2022 18:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72353C385B8;
        Thu, 12 May 2022 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652378999;
        bh=IPa84a0ExaTFb0Q/aAwP7vM1wEznpiYTW9cY/k40XB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgzFv+Yzg6w3p9oWbiNYgbRVrFr+a2wBBfrHCpr0gEKWvnEJYY2DbCOyq5MKneTp6
         /1D5WZQCabvBh2Fl861WE2Pz04CCWmAlyCUZ9hRXFmd+MZ5FKXps08bdljNJ6Y6GsE
         EAQl1O4Sh2GGRkGSPfDRsstUqaUgtyPCGdl3f+NWmow9OLv+vsVIpxBP4l32xWnClt
         WQGQou2JxgtiEALq4/iQvfahVR/txrCSxiYOhJsbon2j6A8i+kXlDPfgf8beDZ0D4i
         uKLT37oHaghKsaa/F+jfPjdBM0FRnLZisTOQ2fuUVpYa8/lx38IhiwASv2go6z44Wt
         eRL4GYDm0vAFQ==
Date:   Thu, 12 May 2022 21:11:37 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
        seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 00/31] x86/sgx and selftests/sgx: Support SGX2
Message-ID: <Yn1N2chUNs9EcnM3@iki.fi>
References: <cover.1652137848.git.reinette.chatre@intel.com>
 <YnrllJ2OqmcqLUuv@kernel.org>
 <395657d1-b040-89e7-046f-3cbd358ed7c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395657d1-b040-89e7-046f-3cbd358ed7c1@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 11, 2022 at 11:47:31AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 5/10/2022 3:22 PM, Jarkko Sakkinen wrote:
> > If there is any patch that does not have my reviewed-by, please put it
> > there. I was totally happy with v4 already. I went through these, and
> > did not see anything worth of complaining about.
> > 
> > Great job, thank you for doing this.
> > 
> > I can also add my tag separely to each patch, which have not have it on
> > request if that makes things easier in any possible way on request.
> 
> Thank you very much. I do appreciate all the feedback and testing.
> 
> All patches in this series have some tag from you, a few have "Acked-by"
> instead of "Reviewed-by".
> 
> Patch 20/31 "x86/sgx: Free up EPC pages directly to support large
> page ranges" is the only x86/sgx patch that has an "Acked-by" from you
> instead of a "Reviewed-by". All selftests/sgx patches have an "Acked-by"
> from you.
> 
> Here is a summary of your tags if you would like to make changes:
> 
> [PATCH V5 01/31] x86/sgx: Add short descriptions to ENCLS wrappers
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 02/31] x86/sgx: Add wrapper for SGX2 EMODPR function
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 03/31] x86/sgx: Add wrapper for SGX2 EMODT function
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 04/31] x86/sgx: Add wrapper for SGX2 EAUG function
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 05/31] x86/sgx: Support loading enclave page without VMA
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 06/31] x86/sgx: Export sgx_encl_ewb_cpumask()
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 07/31] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 08/31] x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 09/31] x86/sgx: Make sgx_ipi_cb() available internally
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 10/31] x86/sgx: Create utility to validate user provided offset and length
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 11/31] x86/sgx: Keep record of SGX page type
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 12/31] x86/sgx: Export sgx_encl_{grow,shrink}()
> 	Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 13/31] x86/sgx: Export sgx_encl_page_alloc()
> 	Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 14/31] x86/sgx: Support VA page allocation without reclaiming
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 15/31] x86/sgx: Support restricting of enclave page permissions
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 16/31] x86/sgx: Support adding of pages to an initialized enclave
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 17/31] x86/sgx: Tighten accessible memory range after enclave initialization
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 18/31] x86/sgx: Support modifying SGX page type
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 19/31] x86/sgx: Support complete page removal
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 	Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 20/31] x86/sgx: Free up EPC pages directly to support large page ranges
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 21/31] Documentation/x86: Introduce enclave runtime management section
> 	Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 22/31] selftests/sgx: Add test for EPCM permission changes
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 23/31] selftests/sgx: Add test for TCS page permission changes
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 24/31] selftests/sgx: Test two different SGX2 EAUG flows
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 25/31] selftests/sgx: Introduce dynamic entry point
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 26/31] selftests/sgx: Introduce TCS initialization enclave operation
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 27/31] selftests/sgx: Test complete changing of page type flow
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 28/31] selftests/sgx: Test faulty enclave behavior
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 29/31] selftests/sgx: Test invalid access to removed enclave page
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 30/31] selftests/sgx: Test reclaiming of untouched page
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [PATCH V5 31/31] selftests/sgx: Page removal stress test
> 	Acked-by: Jarkko Sakkinen <jarkko@kernel.org>	
> 
> 
> Reinette

It looks good. And yeah, I've been running different versions of this patch
set since April with zero issues, about a month, in our platform. No high
doubts that anything would wrong that could not be later fixed, if problems
arise.

BR, Jarkko
