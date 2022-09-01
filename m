Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84435AA2B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 00:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiIAWRC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 18:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIAWRA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 18:17:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB88C54C81;
        Thu,  1 Sep 2022 15:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EEE2B82939;
        Thu,  1 Sep 2022 22:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACFDC433C1;
        Thu,  1 Sep 2022 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662070615;
        bh=Q8oHaed7pp/JeSvQt7PceFgTel3M1wSliltuKvesyUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuKea1dj41uBG1+BDdKpqJPIOD6rt9GlKSza8u7RX6+KJDVbhF0eZLHdIaksdqie9
         Xyzb1+2HHYua/CXOSfc8ZhMMx8sib+E+t1Y0vUMHJY0ue49uU9rvYf0b02t1C1xLlD
         yGynssCNgziMBR64yZP559RURelZnTdvkb/do9FzH6L/iT5Og2s5yHltapBmaVUG9w
         ZLr2964QS937NteBmnHnj5OTnWj2yXbQuCrZdtLRdZRFAdOpBw6vtev/w+9vyeNGrq
         bAcsqNJ5vSBkKurtDs+Np9P7etMzg4421y4T/EqIKFO1CWCQO4WmIqr5RSnbf2Is8u
         UqUSVymnQIOFA==
Date:   Fri, 2 Sep 2022 01:16:50 +0300
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
Message-ID: <YxEvUm9jmHaAbdU2@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-5-jarkko@kernel.org>
 <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
 <Yw7HOIfnaO0IcDiX@kernel.org>
 <7c85f675-db1a-eb5c-2575-759d662a0ecd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c85f675-db1a-eb5c-2575-759d662a0ecd@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 11:09:02AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/30/2022 7:28 PM, Jarkko Sakkinen wrote:
> > On Tue, Aug 30, 2022 at 03:55:47PM -0700, Reinette Chatre wrote:
> >> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> >>> From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> >>>
> >>> Add a new test case which is same as augment_via_eaccept but adds a
> >>> larger number of EPC pages to stress test EAUG via EACCEPT.
> >>>
> >>> Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> >>> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>> ---
> >>> v2:
> >>> - Addressed Reinette's feedback:
> >>>   https://lore.kernel.org/linux-sgx/24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com/
> >>> ---
> >>>  tools/testing/selftests/sgx/load.c      |   5 +-
> >>>  tools/testing/selftests/sgx/main.c      | 141 +++++++++++++++++++++---
> >>>  tools/testing/selftests/sgx/main.h      |   3 +-
> >>>  tools/testing/selftests/sgx/sigstruct.c |   2 +-
> >>>  4 files changed, 129 insertions(+), 22 deletions(-)
> >>
> >> There seems to be at least three patches merged into one here:
> >> 1) Update SGX selftests to create enclaves with provided size dedicated
> >>    to EDMM (this change causes a lot of noise and distracts from the test
> >>    addition).
> >> 2) The mrenclave_ecreate() fix (which is still incomplete).
> >> 3) The actual test addition.
> > 
> > I would agree on this on a kernel patch but not for kselftest patch. It
> > does not really give useful value here. This adds a test and that is a
> > good enough granularity in my opinion, unless some major architecture
> > work is required as precursory. It is not the case here.
> 
> I must say that for many good reasons this goes against one of the
> fundamental rules of kernel patches: separate logical changes into
> separate patches. This is your domain though so of course the work
> within it follows your guidance and I will not pursue it further.

I don't consider kselftest patch exactly same as kernel patch
but I can split this. What would be good enough?

> I usually run checkpatch.pl with "--strict".

I honestly did not know that this option was available :-)
First time I hear of it.

Thanks.

> 
> Reinette

BR, Jarkko
