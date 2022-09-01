Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C35AA2CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiIAWUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 18:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiIAWTf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 18:19:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1A9836A;
        Thu,  1 Sep 2022 15:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CDD7B8295F;
        Thu,  1 Sep 2022 22:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68B9C433C1;
        Thu,  1 Sep 2022 22:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662070714;
        bh=P11/1T5vHWH0SCcpyWwUdgCzRVkbP+ssblCg6//orxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4ZXSvTa25bXtQ4JOhN6MHYEzRmAHL5dr5fAFHDNj4qHH4lJzlUVfzJVTrc4sterB
         v0TbdY23FmZ9U3rsB9+Tffiwq6STUgVrVhzJrTE676a8p5id8KOpvPs0jIF89pkBxI
         oyCYPAg26t6YDYdpuwBZzd9+yu4WBB0OYqi0bZFK2gGuWz2GecnjEiohWPyVyPGj6j
         JWmlCKbpIFgVNffPV5RB9mXnGSKpNMRsRY6E499dtKSWkMYfFFlbTe+j9iVm0BprOi
         6pnCFt0xqZTRFUctkptNL1rMkSBtxumvRChXOQ/qEZ8iwSfEhh2B1NeocGTTGpQE8r
         ngQkItbH/r88A==
Date:   Fri, 2 Sep 2022 01:18:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] selftests/sgx: retry the ioctls returned with EAGAIN
Message-ID: <YxEvtWpCQHpy3Vzf@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-6-jarkko@kernel.org>
 <5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com>
 <Yw7IFcnjbfm3Xgqk@kernel.org>
 <709d9f58-0ae9-833a-ca54-7b50307b377e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709d9f58-0ae9-833a-ca54-7b50307b377e@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 11:14:02AM -0700, Dave Hansen wrote:
> On 8/30/22 19:31, Jarkko Sakkinen wrote:
> >> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> >>> From: Haitao Huang <haitao.huang@linux.intel.com>
> >>>
> >>> For EMODT and EREMOVE ioctls with a large range, kernel
> >> ioctl()s?
> > Ioctl is common enough to be considered as noun and is
> > widely phrased like that in commit messages. I don't
> > see any added clarity.
> 
> I definitely prefer ioctl().

I can use it.

BR, Jarkko
