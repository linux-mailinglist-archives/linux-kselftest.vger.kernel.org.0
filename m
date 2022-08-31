Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6615A73EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiHaCdR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 22:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiHaCdQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 22:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DE7A74E8;
        Tue, 30 Aug 2022 19:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1F7461913;
        Wed, 31 Aug 2022 02:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF99C433D6;
        Wed, 31 Aug 2022 02:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661913194;
        bh=eTHfuq3On28IsRiVZ2H9boyUGWutmmHIbW6a6kyfzkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZX21Jsw4uSHFioeoVbvJaexz9X9bPCu7Z87QQUrRc8xZbfbr+0z4fCougfJ5VX/QK
         3lUchBZXivL7INKEnupXyBHra/J32dokusP2f1M6M4NNcj6dq0KNTalmS7dnpLTRaW
         1gFUVkNlgczKPWkC5kYN/RT0SJhomGQ6X4BnyycVawPQ2OjH0sHn/K/DPGNMMa2WXL
         5YgjFD3tXG3KEUjzdegBWs/Gh6JyN0xfQwbwBSff5d+t5MasREwlU5EbzsfijmITKQ
         wZiE6VT7Rd0lJyqPBtnSYTM/I58WijY7obSQPdlC2jZjP9IPTSEADrT31YKkTjK/vq
         MlqJ4sfa22Esw==
Date:   Wed, 31 Aug 2022 05:33:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Message-ID: <Yw7IZWHbHjdjMa/Y@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
 <64498c9f-a6e1-6379-ca8e-d751fb239bec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64498c9f-a6e1-6379-ca8e-d751fb239bec@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 03:57:24PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  tools/testing/selftests/sgx/alloc-error.bt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644 tools/testing/selftests/sgx/alloc-error.bt
> > 
> > diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
> > new file mode 100644
> > index 000000000000..9268d50dea29
> > --- /dev/null
> > +++ b/tools/testing/selftests/sgx/alloc-error.bt
> > @@ -0,0 +1,7 @@
> > +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> > +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> > +}
> > +
> > +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> > +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> > +}
> 
> 
> Could there be a snippet of comments in this new file to guide users
> on how to use this script?

Do not mean to be rude but I'm not sure what there is to guide but
I'm open for ideas.

BR, Jarkko
