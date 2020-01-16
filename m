Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2B313F98B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 20:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgAPTbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 14:31:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:13285 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbgAPTbm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 14:31:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 11:31:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="373431363"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2020 11:31:41 -0800
Date:   Thu, 16 Jan 2020 11:42:23 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
Message-ID: <20200116194222.GB51626@romley-ivt3.sc.intel.com>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
 <7aacc3e8-4072-c6b9-5d0f-f687a40ad315@amd.com>
 <CY4PR12MB1574ACDEE30CDCD8113CECA795390@CY4PR12MB1574.namprd12.prod.outlook.com>
 <20200115211749.GA51626@romley-ivt3.sc.intel.com>
 <87k15sxu3k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k15sxu3k.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 15, 2020 at 10:55:43PM +0100, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> >
> > Hi, Boris, Thomas, Ingo, et al,
> >
> > Any comment on this patch set?
> 
> No objections from my side, but you forgot to CC the relevant
> maintainer/mailinglist for tools/testing/selftests/. CC'ed now.

Thank you for your comments, Thomas!

Hi, Shuah,

Do you want me to resend the v9 resctrl selftest patches to you and
linux-kselftest?

This repository has the v9 patches:
git://github.com/fyu1/linux resctrl_selftest

Thanks.

-Fenghua
