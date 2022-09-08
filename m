Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FED5B2A60
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 01:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiIHXcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 19:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIHXb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 19:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77D1402C;
        Thu,  8 Sep 2022 16:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D86E661E6B;
        Thu,  8 Sep 2022 23:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDDFC433D6;
        Thu,  8 Sep 2022 23:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662679705;
        bh=Eo93VCMrgvKOMrm1ftkl2pC8sCfd6qOMdIaidBm6YlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=attQb81Uoww89Ha9CLEDtpSNRdfmtwWQWGtN35eNo1MneyQZGUwbuD4CIi7WvoL0B
         eVhzP3RMDshfKAmslGCe6m9pFRkYAL9YOzeQC2Yl37k8sWpmsaHuFMwX32gB6u4as1
         AAOopsHyXyg/A5NmE456sAqQMDJPf4W75+nPOrEJcSZR1o82HYS9BY5oSocbVFnusb
         IqFQkoXcJ2yfjj7mrJoFJamv/9m+n+Gk7qEdcYXAhDF5lG6lN5A24E42TztURIiUHe
         nXnEygMWqwBw3qwKURRbS5rqhvPeRTxIun5Hzf5ZY/DE8sa0W2gw8fkEKsD+fFhD3K
         HVJhoDA8HfGCA==
Date:   Fri, 9 Sep 2022 02:28:18 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <Yxp6kqvB5wzJCEYQ@kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-6-jarkko@kernel.org>
 <ecd03fbb-8019-07ae-e27d-44b1dd20bfb1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd03fbb-8019-07ae-e27d-44b1dd20bfb1@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 08, 2022 at 03:44:29PM -0700, Reinette Chatre wrote:
> Hi Jarkko and Vijay,
> 
> On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> > From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > 
> > Add a new test case which is same as augment_via_eaccept but adds a
> > larger number of EPC pages to stress test EAUG via EACCEPT.
> > 
> > Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> 
> ...
> 
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > index 78c3b913ce10..e596b45bc5f8 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -22,8 +22,10 @@
> >  #include "main.h"
> >  
> >  static const size_t ENCL_HEAP_SIZE_DEFAULT = PAGE_SIZE;
> > +static const unsigned long TIMEOUT_DEFAULT = 900;
> 
> I am not sure about the naming here ... it is _very_ close to
> (and thus appears to be in the same namespace as)
> TEST_TIMEOUT_DEFAULT from the included kselftest_harness.h.
> 
> This is surely a nitpick but how about SGX_TEST_TIMEOUT_DEFAULT?

Agreed, I would use ENCL_TEST_TIMEOUT_DEFAULT (better match
with existing names).

> 
> >  static const uint64_t MAGIC = 0x1122334455667788ULL;
> >  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> > +
> 
> There is an extra empty line here ... but it looks like intended code
> organization?

Yeah, I think it'd make sense to have it there and would
not be productive to make it a separate patch.

> 
> >  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
> >  
> >  /*
> 
> 
> Apart from the naming comment this addition looks good. 
> 
> This is a valuable addition to the SGX tests.
> 
> Reinette

Thank you.

BR, Jarkko
