Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A317352F16
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBSTD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 14:19:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:60570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBSTD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 14:19:03 -0400
IronPort-SDR: rJbcTbQtoBKb3XfexvLvjj4ib6p0Jvn80MoBBVy0SrkvqnrpqfsLFjO5JmwHkfh77owmMUybU8
 QM4zUj55AKoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="191996751"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="191996751"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:19:02 -0700
IronPort-SDR: v5mVhrmj4sECZ9hSELGIIzlriGwvIjXO/U1OTonKk/ij3/+8g/UzbRYkkYxMy7eXeR5dED8tYT
 skhDYGciTV8w==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="419767412"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:19:01 -0700
Date:   Fri, 2 Apr 2021 18:18:54 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/21] Miscellaneous fixes for resctrl selftests
Message-ID: <YGdgDqyma+/VXNcc@otcwcpicx3.sc.intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
 <YF451jic7QNyUCVD@otcwcpicx3.sc.intel.com>
 <b10f5509-5111-e3e4-c247-dde542c36358@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b10f5509-5111-e3e4-c247-dde542c36358@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Shuah,

On Fri, Apr 02, 2021 at 12:17:17PM -0600, Shuah Khan wrote:
> On 3/26/21 1:45 PM, Fenghua Yu wrote:
> > Hi, Shuah,
> > 
> > On Wed, Mar 17, 2021 at 02:22:34AM +0000, Fenghua Yu wrote:
> > > This patch set has several miscellaneous fixes to resctrl selftest tool
> > > that are easily visible to user. V1 had fixes to CAT test and CMT test
> > > but they were dropped in V2 because having them here made the patchset
> > > humongous. So, changes to CAT test and CMT test will be posted in another
> > > patchset.
> > > 
> > > Change Log:
> > > v6:
> > > - Add Tested-by: Babu Moger <babu.moger@amd.com>.
> > > - Replace "cat" by CAT_STR etc (Babu).
> > > - Capitalize the first letter of printed message (Babu).
> > 
> > Any comment on this series? Will you push it into linux-kselftest.git?
> > 
> Yes. Will apply for 5.13-rc1

Great! Thank you very much for your help!

-Fenghua
