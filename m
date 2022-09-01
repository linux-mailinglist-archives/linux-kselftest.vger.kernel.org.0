Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26445AA2B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 00:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiIAWSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiIAWSB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF354C81;
        Thu,  1 Sep 2022 15:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F059061FD1;
        Thu,  1 Sep 2022 22:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05276C433B5;
        Thu,  1 Sep 2022 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662070679;
        bh=EOBK6AGpSj2ywhzuceDEQ5nVOfuQCv60bd7TDIbLEIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEJ9DKeXW7ZC9Mchwjg3FoUpW6m4j/2cSQc0mYk9eX4c4o51wMJhUkQjqgxBU9Epk
         peUKDT43BQy101QDd4skU7eYs6XL0qIGG6IDa2XjSJcCo96E8eP7Y9O7bN7iqG87l4
         zITWk98d/Qvxo1FmFhcvTcIWyijHfP9IzSa7Mgctgk0jyXtgAzOHtRo6A5ZCpOyAJ5
         kpKYNTBgBK/3HdseQwtQ29JDrJz41Xy/09X317X4Uxh9b2psRjIw9fSfMWzRDWKcpU
         pSvgt/f8HktQm2ai8nsbbvq84aU6Gdi3s5rFprbWoqRAzsrZ1OSM9O/ZG9b/D2ItQL
         aUk150/UqCp/A==
Date:   Fri, 2 Sep 2022 01:17:54 +0300
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
Subject: Re: [PATCH 5/6] selftests/sgx: retry the ioctls returned with EAGAIN
Message-ID: <YxEvkp3RNpZmLr6b@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-6-jarkko@kernel.org>
 <5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com>
 <Yw7IFcnjbfm3Xgqk@kernel.org>
 <c3717761-7b00-db03-117a-0b672c865fa9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3717761-7b00-db03-117a-0b672c865fa9@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 11:09:21AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/30/2022 7:31 PM, Jarkko Sakkinen wrote:
> > On Tue, Aug 30, 2022 at 03:56:29PM -0700, Reinette Chatre wrote:
> >> Hi Haitao and Jarkko,
> >>
> >>
> >> selftests/sgx: Retry the ioctl()s returned with EAGAIN
> >>
> >>
> >> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> >>> From: Haitao Huang <haitao.huang@linux.intel.com>
> >>>
> >>> For EMODT and EREMOVE ioctls with a large range, kernel
> >>
> >> ioctl()s?
> > 
> > Ioctl is common enough to be considered as noun and is
> > widely phrased like that in commit messages. I don't
> > see any added clarity.
> 
> ok. I was asked to make this change in the SGX2 patches and
> thought that I should propagate this advice :)

I can use the other form too, np.

> 
> >>> +			modt_ioc.count = 0;
> >>> +		} else
> >>> +			break;
> >>
> >> Watch out for unbalanced braces (also later in patch). This causes
> >> checkpatch.pl noise.
> > 
> > Again. I did run checkpatch to all of these. Will revisit.
> 
> It looks like I see it because I use "checkpatch.pl --strict".

Thanks BTW for pointing this out :-)

> Reinette

BR, Jarkko
