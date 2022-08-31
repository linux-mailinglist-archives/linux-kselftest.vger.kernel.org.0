Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3C5A858D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiHaS1n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiHaS0w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 14:26:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D6F32E7;
        Wed, 31 Aug 2022 11:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E68B8220F;
        Wed, 31 Aug 2022 18:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AF3C433D6;
        Wed, 31 Aug 2022 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970189;
        bh=kSSmDw1mwdTG9dsLxK81HAvFG60qGsT4znGs6QkcCK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHBXEAOjpTKGVlBV2qYPEpP+dne3VcvDQdkUp3JeUAShr7mgkn7f1TAcyvFyiqUp2
         h7GkrMWHV5SEwhSXvAhfc0lNobsR3kOrVy3DuFvbLizRKVlStxD3OWhBQfyqd6ZfBy
         uoRyoU2qWSPOL/CyEdMBuYRtr/0UTmzv0Q7iHeuPRDKboGO0wPYa4Xm7X1mfOvbPYc
         nTUNkRQvg8AUXUdJKKKbb+qF1M1dbrL7mdeKivUKnMzcJ8PJ+raTU6JTuEEmyEQ7ow
         aH5mIV8IfaSyVzOwWEJka/YSShzyawHyW9Y7SK5N8cYfmquCwDv2CpcCk5ixxx7lve
         hc/F7c9Si6QaQ==
Date:   Wed, 31 Aug 2022 21:23:04 +0300
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
Message-ID: <Yw+nCBVYfueEXVZK@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
 <64498c9f-a6e1-6379-ca8e-d751fb239bec@intel.com>
 <Yw7IZWHbHjdjMa/Y@kernel.org>
 <218a5ae1-f74e-36e3-1137-c001d49126bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218a5ae1-f74e-36e3-1137-c001d49126bb@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 11:10:20AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/30/2022 7:33 PM, Jarkko Sakkinen wrote:
> > On Tue, Aug 30, 2022 at 03:57:24PM -0700, Reinette Chatre wrote:
> >> Hi Jarkko,
> >>
> >> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>> ---
> >>>  tools/testing/selftests/sgx/alloc-error.bt | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>  create mode 100644 tools/testing/selftests/sgx/alloc-error.bt
> >>>
> >>> diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
> >>> new file mode 100644
> >>> index 000000000000..9268d50dea29
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/sgx/alloc-error.bt
> >>> @@ -0,0 +1,7 @@
> >>> +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> >>> +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> >>> +}
> >>> +
> >>> +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> >>> +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> >>> +}
> >>
> >>
> >> Could there be a snippet of comments in this new file to guide users
> >> on how to use this script?
> > 
> > Do not mean to be rude but I'm not sure what there is to guide but
> > I'm open for ideas.
> 
> How about something like below in comments as part of the script:
> 
> "bpftrace script using kretprobe to trace returns of some key functions
>  in support of tracking allocation errors."

I think comments that I put (before seeing) also
make it clear enough (not to say that what you
had not been a valid alternative).

BR, Jarkko
