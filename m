Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5226D14DBF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2020 14:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgA3Nbh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 08:31:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:7053 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbgA3Nbh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 08:31:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 05:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="402326794"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2020 05:31:36 -0800
Date:   Thu, 30 Jan 2020 05:41:56 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>
Subject: Re: [RESEND PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
Message-ID: <20200130134156.GB74965@romley-ivt3.sc.intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 16, 2020 at 01:32:33PM -0800, Fenghua Yu wrote:
> [Resend the v9 patch set to Shuah Khan and linux-kselftest mailing list.
> No code and commit message change.]
> 
> With more and more resctrl features are being added by Intel, AMD
> and ARM, a test tool is becoming more and more useful to validate
> that both hardware and software functionalities work as expected.

Hi, Khan,

Any comment on the resctrl selftest tool? Any plan to push the patches
to upstream?

Thanks.

-Fenghua
