Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C06353095
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBVHz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 17:07:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:17832 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBVHz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 17:07:55 -0400
IronPort-SDR: vpI/AKc/jMvzfh4R7XqFnFcD5p9DGWGRCfoa+mlTqUhd+zy8x56B6EpidJiuUa5xxQfgCDHk81
 jliZgfmQQPAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="192017127"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="192017127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 14:07:53 -0700
IronPort-SDR: hJ5K3+3GjSt2mxesegwSFijJTwqbTnFcp2R+z7jGeAZFT70vVsum1zpcG7kuNAaHV8SIpYDahi
 h0xr9Y0SKWcw==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="413336770"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 14:07:53 -0700
Date:   Fri, 2 Apr 2021 21:07:42 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/21] Miscellaneous fixes for resctrl selftests
Message-ID: <YGeHnkEnhNrXuYeL@otcwcpicx3.sc.intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
 <YF451jic7QNyUCVD@otcwcpicx3.sc.intel.com>
 <b10f5509-5111-e3e4-c247-dde542c36358@linuxfoundation.org>
 <YGdgDqyma+/VXNcc@otcwcpicx3.sc.intel.com>
 <c2221c02-5646-0521-a501-87717d872b37@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2221c02-5646-0521-a501-87717d872b37@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 02, 2021 at 02:04:16PM -0600, Shuah Khan wrote:
> On 4/2/21 12:18 PM, Fenghua Yu wrote:
> > Hi, Shuah,
> > 
> > On Fri, Apr 02, 2021 at 12:17:17PM -0600, Shuah Khan wrote:
> > > On 3/26/21 1:45 PM, Fenghua Yu wrote:
> > > > Hi, Shuah,
> > > > 
> > > > On Wed, Mar 17, 2021 at 02:22:34AM +0000, Fenghua Yu wrote:
> > > > > This patch set has several miscellaneous fixes to resctrl selftest tool
> > > > > that are easily visible to user. V1 had fixes to CAT test and CMT test
> > > > > but they were dropped in V2 because having them here made the patchset
> > > > > humongous. So, changes to CAT test and CMT test will be posted in another
> > > > > patchset.
> > > > > 
> > > > > Change Log:
> > > > > v6:
> > > > > - Add Tested-by: Babu Moger <babu.moger@amd.com>.
> > > > > - Replace "cat" by CAT_STR etc (Babu).
> > > > > - Capitalize the first letter of printed message (Babu).
> > > > 
> > > > Any comment on this series? Will you push it into linux-kselftest.git?
> > > > 
> > > Yes. Will apply for 5.13-rc1
> > 
> > Great! Thank you very much for your help!
> > 
> 
> Done. Now applied to linux-selftest next.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/
> next
> 
> Ran sanity test and suggested a change in message for 12/21.
> 
> Please take a look other such messages and improve them as well
> and send follow-on patches.

Sure. Will send a follow-on patch to change the messages.

Thanks.

-Fenghua
