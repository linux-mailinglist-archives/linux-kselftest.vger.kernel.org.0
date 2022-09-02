Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D034C5AA3FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 02:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiIBACY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 20:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBACY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 20:02:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADAA543F1;
        Thu,  1 Sep 2022 17:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7F49BCE2965;
        Fri,  2 Sep 2022 00:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DBBC433D6;
        Fri,  2 Sep 2022 00:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662076939;
        bh=7yCiQ08HlnZ7fUAo9iH9dlpmV7GKTg7i59BCTqci8H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvc8HU/cvDYpFzg7MUMcf6X5W7uBLs4tCT811MgdtScjkig/siR6jrsRvA2S9a3SY
         7sggdfbmJ29a/o2yq/RiZqvcNJcAwM1CW6TTcd2y6CStnBuib4yZydONJlb+zLeqNy
         mEQh/qtVDiATpM9erd4OYp1t6QLsXcrcPQKfe9Paqq0tkIqVlBL7gKDW7i4ehHftE/
         RW8/l4m9b+XEIC2FzkJ4oc+yAlvYzN6LQbvjq07p1Mq2J/WTHm1rrwHVgu1k7Qz3xv
         WJe3Lr5k5Rv9ua/020cwLwZT5BTWNtrG2HJDAPLYWEcAnc22DcZRC7QqgjHYfTssPi
         dO2EIRsLXWz5g==
Date:   Fri, 2 Sep 2022 03:02:15 +0300
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
Subject: Re: [PATCH 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <YxFIB2clOEY9TX8A@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-5-jarkko@kernel.org>
 <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
 <Yw7HOIfnaO0IcDiX@kernel.org>
 <7c85f675-db1a-eb5c-2575-759d662a0ecd@intel.com>
 <YxEvUm9jmHaAbdU2@kernel.org>
 <793bd158-1e1b-2dad-5841-081d840d45d8@intel.com>
 <YxFHoRBW3ZumV0qQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxFHoRBW3ZumV0qQ@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 02, 2022 at 03:00:36AM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 01, 2022 at 04:11:34PM -0700, Reinette Chatre wrote:
> > Hi Jarkko,
> > 
> > On 9/1/2022 3:16 PM, Jarkko Sakkinen wrote:
> > > On Wed, Aug 31, 2022 at 11:09:02AM -0700, Reinette Chatre wrote:
> > >> On 8/30/2022 7:28 PM, Jarkko Sakkinen wrote:
> > >>> On Tue, Aug 30, 2022 at 03:55:47PM -0700, Reinette Chatre wrote:
> > >>>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > 
> > >>>> There seems to be at least three patches merged into one here:
> > >>>> 1) Update SGX selftests to create enclaves with provided size dedicated
> > >>>>    to EDMM (this change causes a lot of noise and distracts from the test
> > >>>>    addition).
> > >>>> 2) The mrenclave_ecreate() fix (which is still incomplete).
> > >>>> 3) The actual test addition.
> > >>>
> > >>> I would agree on this on a kernel patch but not for kselftest patch. It
> > >>> does not really give useful value here. This adds a test and that is a
> > >>> good enough granularity in my opinion, unless some major architecture
> > >>> work is required as precursory. It is not the case here.
> > >>
> > >> I must say that for many good reasons this goes against one of the
> > >> fundamental rules of kernel patches: separate logical changes into
> > >> separate patches. This is your domain though so of course the work
> > >> within it follows your guidance and I will not pursue it further.
> > > 
> > > I don't consider kselftest patch exactly same as kernel patch
> > 
> > You are not alone.
> > 
> > > but I can split this. What would be good enough?
> > 
> > I identified three candidate patches in my original response that
> > is quoted above, but as I mentioned I understand the sentiment
> > and this is your domain so I will not insist on it.
> 
> OK, fair enough, I'll rework on this. It's my domain but
> at least my own aim is always only satisfy on consensus
> :-)

I'll also split the patch set because this is not as urgent
as getting the fixes in. There will be separate fixes and
kselftest improvements patch sets.

BR, Jarkko
