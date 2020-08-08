Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8167B23F686
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Aug 2020 07:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgHHFGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Aug 2020 01:06:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:1291 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgHHFGY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Aug 2020 01:06:24 -0400
IronPort-SDR: wGKfKHq9ex18F+5zjhqXAAA6zVE6h4EyD0gl6yeMkAGxFgS0YmfRzWjKNX7UieSJRM/lDCMR/V
 Cxjg/MT/2p3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="154400918"
X-IronPort-AV: E=Sophos;i="5.75,448,1589266800"; 
   d="scan'208";a="154400918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 22:06:23 -0700
IronPort-SDR: zOIIPvd03rOwBuFsBRe3OPQGX78V6+D/IsczlGRQvTrEDLcXUVo2xor7SfaWtyEIXv+hX84AcL
 ndDUtMXnQ2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,448,1589266800"; 
   d="scan'208";a="307577088"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2020 22:06:23 -0700
Date:   Fri, 7 Aug 2020 22:06:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>
Subject: Re: [PATCH 1/1] kvm: mmu: zap pages when zapping only parent
Message-ID: <20200808050623.GA1123@linux.intel.com>
References: <20200727203324.2614917-1-bgardon@google.com>
 <20200804211444.GA31916@linux.intel.com>
 <CANgfPd9kbnzW+eaBi+dwA1+E2VXEd6JfN4n2PstWrmh4VPRFjA@mail.gmail.com>
 <cf54ab19-611c-c975-8080-b49e13c966f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf54ab19-611c-c975-8080-b49e13c966f3@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 05, 2020 at 08:48:03PM +0200, Paolo Bonzini wrote:
> On 05/08/20 19:10, Ben Gardon wrote:
> >>
> >> Alternatively, what about moving this logic into mmu_page_zap_pte()?  That
> >> can be done with a little massaging of FNAME(invlpg) and would avoid what is
> >> effectively redundant checks on is_shadow_present_pte() and is_last_spte().
> >> Patches attached and somewhat tested.
> > That seems like a good change to me and the patches you attached look
> > good to me. I'm happy to review them more if you want to send them to
> > the mailing list as their own series. Thanks for putting them
> > together.
> > 
> 
> Thanks, I'll wait for that.

Sorry for the delay, been buried with internal stuff.  I'll get the series
posted on Monday.
