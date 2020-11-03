Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373202A4F20
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 19:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgKCSmV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 13:42:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:57561 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgKCSmV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 13:42:21 -0500
IronPort-SDR: t0cm1t6hDHqBWbnymcYBQWQ0V0T1mscZggcEyDdYPQ31BUuWDMTiVuf5pXxU5UMobiOPDpoctM
 Auy7mfGjf6OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="156093808"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="156093808"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:42:20 -0800
IronPort-SDR: NHUhhr4Ld0+ktxaexVqc9ly5ziPRS5Y+EjthlhRuorVcxAnBGj8aOQJlCSYv9leRTjjDuriVDY
 sxTjbk20XkgQ==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="528593430"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:42:19 -0800
Date:   Tue, 3 Nov 2020 10:42:18 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 05/10] x86/pks: Add PKS kernel API
Message-ID: <20201103184218.GB1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <20201102205320.1458656-6-ira.weiny@intel.com>
 <20201103065024.GC75930@kroah.com>
 <20201103175335.GA1531489@iweiny-DESK2.sc.intel.com>
 <20201103181407.GA83845@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103181407.GA83845@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 07:14:07PM +0100, Greg KH wrote:
> On Tue, Nov 03, 2020 at 09:53:36AM -0800, Ira Weiny wrote:
> > On Tue, Nov 03, 2020 at 07:50:24AM +0100, Greg KH wrote:
> > > On Mon, Nov 02, 2020 at 12:53:15PM -0800, ira.weiny@intel.com wrote:
> > > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > > 
> > 
> > [snip]
> > 
> > > > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > > > index 2955ba976048..0959a4c0ca64 100644
> > > > --- a/include/linux/pkeys.h
> > > > +++ b/include/linux/pkeys.h
> > > > @@ -50,4 +50,28 @@ static inline void copy_init_pkru_to_fpregs(void)
> > > >  
> > > >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> > > >  
> > > > +#define PKS_FLAG_EXCLUSIVE 0x00
> > > > +
> > > > +#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > > > +static inline int pks_key_alloc(const char * const pkey_user, int flags)
> > > > +{
> > > > +	return -EOPNOTSUPP;
> > > > +}
> > > > +static inline void pks_key_free(int pkey)
> > > > +{
> > > > +}
> > > > +static inline void pks_mk_noaccess(int pkey)
> > > > +{
> > > > +	WARN_ON_ONCE(1);
> > > 
> > > So for panic-on-warn systems, this is ok to reboot the box?
> > 
> > I would not expect this to reboot the box no.  But it is a violation of the API
> > contract.  If pky_key_alloc() returns an error calling any of the other
> > functions is an error.
> > 
> > > 
> > > Are you sure, that feels odd...
> > 
> > It does feel odd and downright wrong...  But there are a lot of WARN_ON_ONCE's
> > out there to catch this type of internal programming error.  Is panic-on-warn
> > commonly used?
> 
> Yes it is, and we are trying to recover from that as it is something
> that you should recover from.  Properly handle the error and move on.

Sorry, I did not know that...  Ok I'll look at the series because I probably
have others I need to change.

Thanks,
Ira
