Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27864597202
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiHQOxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiHQOxe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 10:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3B402C8;
        Wed, 17 Aug 2022 07:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E33486142E;
        Wed, 17 Aug 2022 14:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF458C433C1;
        Wed, 17 Aug 2022 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660748010;
        bh=Pa5i8IC5TrT2DHQTMupGT4J67/zODUCPCOA2f64JMvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2h4leWkcnaYK4uW9V8k69ic9pVYJy6XNjyxbZb1AKoanqf9Q/4Yk4a7mBoVGN2Xj
         ZB69fHM8iYGoZcwPtvZrScXkKDjiaKK023eo3b3f/JhsYCjXN8ErHuG++uoAQE+CiD
         kyvKTgU0oO3lwxFFDz/C+JHs+7dryidAHuUQOSG5EoJ87eRwBpPRVRbEyGtosB00j4
         AH1rWtDIqZ6MxquUu2fjcPHs3NJIEJGVQ0Ah3wfeouFrR88tOWrn6+ODGpiB37OwcR
         G6tqhKiX1/Czb2fO6XEL+JzFYN1RIKSzglH9c88ic8OmyoASX7K5uz7uyara+e9iuN
         cWciwXOAiojIw==
Date:   Wed, 17 Aug 2022 17:53:26 +0300
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
Message-ID: <Yv0A5vjd0OIfxxfT@kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com>
 <Yvz+yxnxp8G6KzHi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvz+yxnxp8G6KzHi@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 17, 2022 at 05:44:31PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 16, 2022 at 09:35:27PM -0700, Reinette Chatre wrote:
> > >>> This portion below was also copied from previous test and by only
> > >>> testing a write to the first page of the range the purpose is not
> > >>> clear. Could you please elaborate if the intention is to only test
> > >>> accessibility of the first page and why that is sufficient?
> > >>
> > >> It is sufficient because the test reproduces the bug. It would have to be
> > >> rather elaborated why you would possibly want to do more than that.
> > 
> > That is fair. An accurate comment (currently an inaccurate copy&paste) would
> > help to explain this part of the test.
> 
> I would simply add something like:
> 
> /* 
>  * Define memory pool size big enough to trigger the reclaimer in the EAUG
>  * path of the page reclaimer.
>  */
> 
> Suggestions/edits obviously welcome for the comment.

I wonder if we could put .bt files somewhere to make them available. In
root causing this bug bpftrace scripting was the key so it would nice to
have them available along with kselftest.

I could imagine that we end up also in future to bugs allocation so
it would have the script when you clone the kernel tree, and possibly
more scripts in future.

E.g. add bt/alloc-error.bt under tools/testing/selftests/sgx.

BR, Jarkko
