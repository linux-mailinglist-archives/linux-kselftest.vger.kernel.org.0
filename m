Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DF182000
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgCKRty (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 13:49:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:20305 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgCKRty (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 13:49:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 10:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="353932452"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2020 10:49:53 -0700
Message-ID: <588d18133c0ad76b375a920b6e6cc1598564163a.camel@intel.com>
Subject: Re: [PATCH V1 09/13] selftests/resctrl: Modularize fill_buf for new
 CAT test case
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 10:45:07 -0700
In-Reply-To: <50cb755f-e112-5d71-11fa-a7cbc951d91e@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <43b368952bb006ee973311d9c9ae0eb53d8e7f60.1583657204.git.sai.praneeth.prakhya@intel.com>
         <4c84be1d-8839-2c85-b294-7e3c454240bb@intel.com>
         <7a1f93d4516a7de99c5dbc4afd6279d6fe7aa126.camel@intel.com>
         <50cb755f-e112-5d71-11fa-a7cbc951d91e@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Wed, 2020-03-11 at 08:44 -0700, Reinette Chatre wrote:
> Hi Sai,
> 
> On 3/10/2020 6:04 PM, Sai Praneeth Prakhya wrote:
> > On Tue, 2020-03-10 at 14:59 -0700, Reinette Chatre wrote:
> > > On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> > > > Currently fill_buf (in-built benchmark) runs as a separate process a
> > > > 
> > > 

[SNIP]

> > > Should buffer be freed on this error path?
> > 
> > Yes, that's right.. my bad. Will fix it. But the right fix is,
> > use_buffer_forever() should not return at all. It's meant to loop around
> > the
> > buffer _forever_.
> > 
> > > I think the asymmetrical nature of the memory allocation and release
> > > creates traps like this.
> > > 
> > > It may be less error prone to have the pointer returned by init_buffer
> > > and the acted on and released within fill_cache(), passed to
> > > "use_buffer_forever()" as a parameter.  The buffer size is known here,
> > > there is no need to keep an "end pointer" around.
> > 
> > The main reason for having "startptr" as a global variable is to free
> > memory
> > when fill_buf is killed. fill_buf runs as a separate process (for test
> > cases
> > like MBM, MBA and CQM) and when user issues Ctrl_c or when the test kills
> > benchmark_pid (i.e. fill_buf), the buffer is freed (please see
> > ctrl_handler()).
> 
> I see. Got it, thanks.
> 
> > So, I thought, as "startptr" is anyways global, why pass it around as an
> > argument? While making this change I thought it's natural to make "endptr"
> > global as well because the function didn't really look good to just take
> > endptr as an argument without startptr.
> 
> Maintaining the end pointer is unusual. The start of the buffer and the
> size are known properties that the end of the buffer can be computed
> from. Not a problem, it just seems inconsistent that some of the buffer
> functions operate on the start pointer and size while others operate on
> the start pointer and end pointer.

Ok.. makes sense. I will try to make it consistent by using endptr all the
time. One advantage of using endptr is that we could just compute endptr once
and use it when needed by passing it as variable (will try to not make it
global variable).

Regards,
Sai

