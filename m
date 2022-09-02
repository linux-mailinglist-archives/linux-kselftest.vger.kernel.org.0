Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A035AA401
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 02:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiIBAD2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 20:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBADZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 20:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF26F250;
        Thu,  1 Sep 2022 17:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7915B61EE2;
        Fri,  2 Sep 2022 00:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BDCC433C1;
        Fri,  2 Sep 2022 00:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662077003;
        bh=J28V6MUQi5avbgUtRQ61aXc/y67aKX5IwS+L29//y3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWivmOhIMyWTb6oPNyHr/ZsOUkWKlj6WpSmjXSr4av9daW1o3Qo7wSaJ7Y2lFNecJ
         oVjuT7WnptjS91QEpRAVcF0miPyJqrmSEWChvzW0U0JtBuUX9/B+wEVv0J4jtNKLMw
         Nxnh8WIrAcUKw0e2gxfrxswOjOhUtSC7vkGSqjuv1c/NwsQCEyXP78FLTb0aUKHQIg
         AlJfeGHy2YydMBnbZvQ6rAQEthgyWAJLGb8o1W0ms4P6jmCZIDdh3yLk7P+Anteajs
         CZhFVj00fX2G7STBhtqPpTEtsqMYdGnT76cwxK3wY8YCN/IuiEx+11/L3qE31cpv25
         HdKNFAypCH5bg==
Date:   Fri, 2 Sep 2022 03:03:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <YxFIR/cFZIi2Ef23@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-5-jarkko@kernel.org>
 <d2b76530-82a2-6ac1-32ea-696e653d767d@intel.com>
 <YxEwwzXOsCliznQJ@kernel.org>
 <17dcb776-14b8-f673-1f36-8f22b192eadb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dcb776-14b8-f673-1f36-8f22b192eadb@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 01, 2022 at 04:12:22PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 9/1/2022 3:22 PM, Jarkko Sakkinen wrote:
> > On Wed, Aug 31, 2022 at 01:07:35PM -0700, Reinette Chatre wrote:
> >> On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> 
> ...
> 
> >>>  tools/testing/selftests/sgx/load.c |   5 +-
> >>>  tools/testing/selftests/sgx/main.c | 143 +++++++++++++++++++++++++----
> >>>  tools/testing/selftests/sgx/main.h |   3 +-
> >>
> >> Is this test passing on your system? This version is missing the change to
> >> mrenclave_ecreate() that causes SGX_IOC_ENCLAVE_INIT to fail when I try it out.
> > 
> > I *did* get a pass in my test machine. Hmm... I'll check if
> > the kernel tree was out-of-sync, which could be the reason.
> > 
> > I do not compile kernel on that machine but have the kernel
> > tree for running selftests. So there is a possiblity for
> > a human error. Thanks for pointing this out.
> 
> On my system I encounter the failure below (V1 of this series
> did not have this problem):
> 
> [SNIP]
> ok 11 enclave.augment_via_eaccept
> #  RUN           enclave.augment_via_eaccept_long ...
> SGX_IOC_ENCLAVE_INIT failed: Operation not permitted
> # main.c:236:augment_via_eaccept_long:0x0000000000000000 0x0000000000002000 0x03
> # main.c:236:augment_via_eaccept_long:0x0000000000002000 0x0000000000001000 0x05
> # main.c:236:augment_via_eaccept_long:0x0000000000003000 0x0000000000006000 0x03
> # main.c:236:augment_via_eaccept_long:0x0000000000009000 0x0000000000001000 0x03
> # main.c:251:augment_via_eaccept_long:Failed to initialize the test enclave.
> # main.c:1260:augment_via_eaccept_long:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, EDMM_SIZE_LONG) (0)
> # augment_via_eaccept_long: Test terminated by assertion
> #          FAIL  enclave.augment_via_eaccept_long
> not ok 12 enclave.augment_via_eaccept_long
> [SNIP]
> 
> ...
> 
> >>>  
> >>>  static const uint64_t MAGIC = 0x1122334455667788ULL;
> >>>  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> >>> +/* Message-ID: <DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com> */
> >>> +static const uint64_t EDMM_SIZE_LONG = 8L * 1024L * 1024L * 1024L;
> >>> +static const uint64_t TIMEOUT_LONG = 900; /* seconds */
> >>> +
> >>
> >> Apologies if my feedback was vague - I actually think that the comments in V1 added
> >> valuable information, it was just the variation in formatting that was distracting.
> > 
> > IMHO message ID is pretty good reference. Can you
> > propose how would you redo it to minimize the number
> > of iterations in the series?
> 
> The message ID is a good reference but it points to an email thread
> and as used here it is unclear what part of that thread is referred to.
> What you had in V1 was very helpful so it could be:
> 
> /*
>  * The size was chosen based on a bug report:
>  * Message-ID: <DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com>
>  */
> 
> I am not sure about Message-ID vs url. The latter may be more
> convenient since the user needs to first search which inbox the message-ID belongs
> to before the message can be accessed. Not a big deal though so I think
> either works.

This is definitely better, I'll use it. Thanks.

> 
> Reinette

BR, Jarkko
