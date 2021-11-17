Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1A45481F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 15:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhKQOIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 09:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhKQOIf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 09:08:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DCED619F6;
        Wed, 17 Nov 2021 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637157936;
        bh=o5d3JLc2FU8DoP61c0YcvTWGhjj6PXVQXE0nUI90jxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H2B54rkrMOChaToC9xIv3hAEjGQH8jV3N1M5uEwjIrlWETa8bDCE4sU5VqoJb7ytH
         1T2WvPHUBsuWRHWa5uSgl9rgqEQVY5EVXamOJg5G+W2aENR+tCs3PSPDooEN+gFngj
         i6Kf2WONBuEeq1QC3GzyxTIOlrxcNqYmaKqyhBaSIUG6mo3dwj67Q/A+g03RmfIZog
         RARSyRoFOYZuF37TjSSiHSdWymMuGYE1h9sk39hxN1C13Y9KAC3FFJzUeJqKKKDW8E
         7KrZlTfXtzCmY6A+HZx5ifaQ455K23jaoCAQVIoq8MTtiZy8vTiTrf1jrnOSWVfFtB
         3PyCVfKxW7MyQ==
Date:   Wed, 17 Nov 2021 06:05:35 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Davide Caratti <dcaratti@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Li Zhijian <zhijianx.li@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, lizhijian@cn.fujitsu.com,
        linux-kernel@vger.kernel.org, lkp@intel.com, philip.li@intel.com
Subject: Re: [PATCH v2 1/3] selftests/tc-testing: add exit code
Message-ID: <20211117060535.1d47295a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <YZTDcjv4ZPXv8Oaz@dcaratti.users.ipa.redhat.com>
References: <20211117054517.31847-1-zhijianx.li@intel.com>
        <YZTDcjv4ZPXv8Oaz@dcaratti.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 17 Nov 2021 09:55:14 +0100 Davide Caratti wrote:
> On Wed, Nov 17, 2021 at 01:45:15PM +0800, Li Zhijian wrote:
> > Mark the summary result as FAIL to prevent from confusing the selftest
> > framework if some of them are failed.
> > 
> > Previously, the selftest framework always treats it as *ok* even though
> > some of them are failed actually. That's because the script tdc.sh always
> > return 0.  
> 
> yes, also tdc was lacking support for KSFT_SKIP for a long time.

Should this go via netdev? Is the risk of conflicts low enough 
so it doesn't matter?

We should probably add a MAINTAINERS entry for tdc. Adding Jamal.
