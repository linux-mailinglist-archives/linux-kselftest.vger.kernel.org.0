Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F2597450
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiHQQgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 12:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiHQQgP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 12:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845595A178;
        Wed, 17 Aug 2022 09:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CAD7B81E45;
        Wed, 17 Aug 2022 16:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658CFC433D7;
        Wed, 17 Aug 2022 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660754171;
        bh=ABEeOyocmyHdII6tRIHMMGUIuFV0L3cm4IJPxaQnGYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uph8U8L0lYU3KI9ByQQco7Cwmt8krmF2UFX+0aQXOK9gtuTcj4rdZUN5sHLB/Bou5
         rHS3UQyyznfwMX9TWHyTB46xlwNpicWjVEyl7V9dPfzqKqDIzkAdIeJYtoWcNmraJ4
         1z7b1GaWMdi3zcpAdFgea0AKPrtsB8xGoB+pGTm5KZJOM2QefmLNOh57TRhxAk+YLA
         vkG6Vpvi0L4z5kf27R1zju6wwYUYEDCTKVP7MAgT+ynctJ/d/tgl0l6JxQoE24GWLU
         kUYg2BDFXR8tBO8c+jps3oWGhljpXrVyw6YUQZr+43BRXTKm5ayC3sR58i0zTMVUBJ
         B6gcfyyBitCUw==
Date:   Wed, 17 Aug 2022 19:36:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <Yv0Y98oJ0+uPJlk8@kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com>
 <Yvz+yxnxp8G6KzHi@kernel.org>
 <Yv0A5vjd0OIfxxfT@kernel.org>
 <69a5e350-ded9-30c9-dc41-d08c01dd05dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a5e350-ded9-30c9-dc41-d08c01dd05dc@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 17, 2022 at 08:43:57AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/17/2022 7:53 AM, Jarkko Sakkinen wrote:
> > On Wed, Aug 17, 2022 at 05:44:31PM +0300, Jarkko Sakkinen wrote:
> >> On Tue, Aug 16, 2022 at 09:35:27PM -0700, Reinette Chatre wrote:
> >>>>>> This portion below was also copied from previous test and by only
> >>>>>> testing a write to the first page of the range the purpose is not
> >>>>>> clear. Could you please elaborate if the intention is to only test
> >>>>>> accessibility of the first page and why that is sufficient?
> >>>>>
> >>>>> It is sufficient because the test reproduces the bug. It would have to be
> >>>>> rather elaborated why you would possibly want to do more than that.
> >>>
> >>> That is fair. An accurate comment (currently an inaccurate copy&paste) would
> >>> help to explain this part of the test.
> >>
> >> I would simply add something like:
> >>
> >> /* 
> >>  * Define memory pool size big enough to trigger the reclaimer in the EAUG
> >>  * path of the page reclaimer.
> >>  */
> >>
> >> Suggestions/edits obviously welcome for the comment.
> 
> The comment seems to better match the code below than the area referred to above:
>         static const unsigned long edmm_size = 8589934592; //8G
> 
> Even so, I think that raises the point that this is platform specific since
> edmm_size of 8GB would not trigger reclaimer on all platforms.
> 
> How about adjusting it to:
> /*
>  * Define memory pool size big enough to trigger the reclaimer in the EAUG
>  * path of the page reclaimer on some platforms. This constant has been
>  * successful in triggering a bug on some platforms (independent of the
>  * platforms where the reclaimer is triggered) and thus considered
>  * appropriate for general use.
>  */ 
> 
> 
> Regarding the area referred to above, a comment like below may help:
> 
> /*
>  * Pool of pages were successfully added to enclave. Perform sanity
>  * check on first page of the pool only to ensure data can be written
>  * to and read from a dynamically added enclave page.
>  */
> 
> > 
> > I wonder if we could put .bt files somewhere to make them available. In
> > root causing this bug bpftrace scripting was the key so it would nice to
> > have them available along with kselftest.
> > 
> > I could imagine that we end up also in future to bugs allocation so
> > it would have the script when you clone the kernel tree, and possibly
> > more scripts in future.
> > 
> > E.g. add bt/alloc-error.bt under tools/testing/selftests/sgx.
> 
> Thank you very much for helping to debug this issue. I also think
> the scripts you created are very valuable and making them easily
> accessible sounds great.

Yeah, I mean they do no harm there, even if not directly used
by the test program.

Thanks for the valuable feedback. I will incorporate it to the
next version.

BR, Jarkko
