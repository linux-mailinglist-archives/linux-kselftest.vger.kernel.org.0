Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87F0597181
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiHQOog (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiHQOof (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 10:44:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8474C49B42;
        Wed, 17 Aug 2022 07:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31C64B81DFB;
        Wed, 17 Aug 2022 14:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DDC433C1;
        Wed, 17 Aug 2022 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660747471;
        bh=5+hesGY57xQHtUlGuPxqV55DlNRITexFStZnpOUjosc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwkPzrQv4yGKxWlawuNpbVntJN4LEfpnbd0DbhhcYa0Njc3wfN+lEwn97cL0QnFYT
         NItsXu9JdTxMuD9S7eusL8VI/FJT20pmBc10Daec5Zw5VVUn9kGbxEGeWuO6LkEYeA
         SzQNHyUkl03Ptn2kTbrS9EY/K8W5JfApm9xKwAZ78uaUbtEPZOj8nR+1L6metNylHX
         mUlqaxIRjoonfvd+Npfwwei1amC4kvhWGCi4RRSdZX6itfCXTav1dXbKmMULYiTaVG
         rVc10EPbb0vTf88hVHn1ai87xODmTFqXC0aCARKtxz8QE/ehS0J2ZLVBa/ISrL7Mg0
         K2avT2zDGd4lw==
Date:   Wed, 17 Aug 2022 17:44:27 +0300
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
Message-ID: <Yvz+yxnxp8G6KzHi@kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 16, 2022 at 09:35:27PM -0700, Reinette Chatre wrote:
> >>> This portion below was also copied from previous test and by only
> >>> testing a write to the first page of the range the purpose is not
> >>> clear. Could you please elaborate if the intention is to only test
> >>> accessibility of the first page and why that is sufficient?
> >>
> >> It is sufficient because the test reproduces the bug. It would have to be
> >> rather elaborated why you would possibly want to do more than that.
> 
> That is fair. An accurate comment (currently an inaccurate copy&paste) would
> help to explain this part of the test.

I would simply add something like:

/* 
 * Define memory pool size big enough to trigger the reclaimer in the EAUG
 * path of the page reclaimer.
 */

Suggestions/edits obviously welcome for the comment.

BR, Jarkko
