Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193E85AA3FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 02:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiIBAAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 20:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBAAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 20:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E1F3F1E2;
        Thu,  1 Sep 2022 17:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC21662079;
        Fri,  2 Sep 2022 00:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB79C433D6;
        Fri,  2 Sep 2022 00:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662076838;
        bh=QVuI6VbDm8mXD5ShzIumQFmyw/sWUX3u3OTJH3VBfl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6CRMRAytUoMPRGIeY5TalnqtaV4IM6c6gOYpbOTFeieQUq5Uwt1fXmfBzYvILeRR
         fKXrap5lqPlGRoZ5ubd5O9iTRO6yP7fC1RWgS6eKHrkT9D9vJHlEf2R6MB4FthqwwU
         vX+o7YK/mN05IRzvsPC6Pv3Ljft3Q+RDxRbx+xq+BRP9q+5gm4IwYooLiJYXAAQtiL
         NGAv/Y/Ov7ZKVwRv6yD40QfKxAELPArWDEKxGopnIA/FNKVYNAaWYzGvW16FdVJiEB
         41vKdvEX3TGyxk3ixxf5D1dLGgZ0vTbn2KkgtkxJQJMESZjXtxHSG+wOLm5uUeHv6l
         r7b8t0qoAQ4xA==
Date:   Fri, 2 Sep 2022 03:00:33 +0300
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
Message-ID: <YxFHoRBW3ZumV0qQ@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-5-jarkko@kernel.org>
 <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
 <Yw7HOIfnaO0IcDiX@kernel.org>
 <7c85f675-db1a-eb5c-2575-759d662a0ecd@intel.com>
 <YxEvUm9jmHaAbdU2@kernel.org>
 <793bd158-1e1b-2dad-5841-081d840d45d8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793bd158-1e1b-2dad-5841-081d840d45d8@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 01, 2022 at 04:11:34PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 9/1/2022 3:16 PM, Jarkko Sakkinen wrote:
> > On Wed, Aug 31, 2022 at 11:09:02AM -0700, Reinette Chatre wrote:
> >> On 8/30/2022 7:28 PM, Jarkko Sakkinen wrote:
> >>> On Tue, Aug 30, 2022 at 03:55:47PM -0700, Reinette Chatre wrote:
> >>>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> 
> >>>> There seems to be at least three patches merged into one here:
> >>>> 1) Update SGX selftests to create enclaves with provided size dedicated
> >>>>    to EDMM (this change causes a lot of noise and distracts from the test
> >>>>    addition).
> >>>> 2) The mrenclave_ecreate() fix (which is still incomplete).
> >>>> 3) The actual test addition.
> >>>
> >>> I would agree on this on a kernel patch but not for kselftest patch. It
> >>> does not really give useful value here. This adds a test and that is a
> >>> good enough granularity in my opinion, unless some major architecture
> >>> work is required as precursory. It is not the case here.
> >>
> >> I must say that for many good reasons this goes against one of the
> >> fundamental rules of kernel patches: separate logical changes into
> >> separate patches. This is your domain though so of course the work
> >> within it follows your guidance and I will not pursue it further.
> > 
> > I don't consider kselftest patch exactly same as kernel patch
> 
> You are not alone.
> 
> > but I can split this. What would be good enough?
> 
> I identified three candidate patches in my original response that
> is quoted above, but as I mentioned I understand the sentiment
> and this is your domain so I will not insist on it.

OK, fair enough, I'll rework on this. It's my domain but
at least my own aim is always only satisfy on consensus
:-)

BR, Jarkko
