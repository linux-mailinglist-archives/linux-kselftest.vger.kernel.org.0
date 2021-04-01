Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC73350BC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Apr 2021 03:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhDABQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 21:16:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:54039 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhDABPl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 21:15:41 -0400
IronPort-SDR: J+amwlH/HUZNX2Mb1pdkbMJ7pQU1UN0Aed8+3vZrnt6gS0cmA6r9JqI+d1rzCT8wdWVNCfb8nT
 jyi1HlYPGKdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="253462895"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="253462895"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 18:15:40 -0700
IronPort-SDR: q84Mbr6GTdcqrEw1OcK8lUatWI/ngVamlhNwOzmHE5VQlQZnfhRDRwcd6YNeZKNJF1V/wnQcuL
 D5mtcElaznLg==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="455748644"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 18:15:40 -0700
Date:   Wed, 31 Mar 2021 18:15:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V5 08/10] x86/entry: Preserve PKRS MSR across exceptions
Message-ID: <20210401011540.GG3014244@iweiny-DESK2.sc.intel.com>
References: <20210331191405.341999-1-ira.weiny@intel.com>
 <20210331191405.341999-9-ira.weiny@intel.com>
 <dcd6a103-5220-d624-0655-b9c7146f9de5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd6a103-5220-d624-0655-b9c7146f9de5@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 31, 2021 at 12:31:56PM -0700, Dave Hansen wrote:
> On 3/31/21 12:14 PM, ira.weiny@intel.com wrote:
> > + * To protect against exceptions having access to this memory we save the
> > + * current running value and sets the PKRS value to be used during the
> > + * exception.
> 
> This series seems to have grown some "we's".

I suppose it has...

> 
> The preexisting pkey code was not innocent in this regard, either.  But,
> please fix this up across the series in the next submission.  Literally
> removing "we" from this sentence doesn't change the meaning at all.

Sure I can audit the series for this...  Waiting a day for other comments.

Thanks,
Ira

