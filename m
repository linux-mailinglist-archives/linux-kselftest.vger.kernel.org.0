Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECD42A4D86
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 18:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCRxi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 12:53:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:52396 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgKCRxh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 12:53:37 -0500
IronPort-SDR: +SOzUzL1fDlFqmr9jBEiJiQLV1mkD99kYQ2eOYtc/hvHhowIcZz4HmcA03XEnLD/xqUOWHURUV
 wzn5Fhbt8qRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="156085221"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="156085221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 09:53:36 -0800
IronPort-SDR: t3rM9zLgd6ZRLLAjOl3vZJlufQNSBy4tjSshCJtsEFelCEQ7FWt2oAwJFA325Js+8uCWdVnDR2
 O0TkS4PUyBAA==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="538578108"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 09:53:36 -0800
Date:   Tue, 3 Nov 2020 09:53:36 -0800
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
Message-ID: <20201103175335.GA1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <20201102205320.1458656-6-ira.weiny@intel.com>
 <20201103065024.GC75930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103065024.GC75930@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 07:50:24AM +0100, Greg KH wrote:
> On Mon, Nov 02, 2020 at 12:53:15PM -0800, ira.weiny@intel.com wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 

[snip]

> > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > index 2955ba976048..0959a4c0ca64 100644
> > --- a/include/linux/pkeys.h
> > +++ b/include/linux/pkeys.h
> > @@ -50,4 +50,28 @@ static inline void copy_init_pkru_to_fpregs(void)
> >  
> >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> >  
> > +#define PKS_FLAG_EXCLUSIVE 0x00
> > +
> > +#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > +static inline int pks_key_alloc(const char * const pkey_user, int flags)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +static inline void pks_key_free(int pkey)
> > +{
> > +}
> > +static inline void pks_mk_noaccess(int pkey)
> > +{
> > +	WARN_ON_ONCE(1);
> 
> So for panic-on-warn systems, this is ok to reboot the box?

I would not expect this to reboot the box no.  But it is a violation of the API
contract.  If pky_key_alloc() returns an error calling any of the other
functions is an error.

> 
> Are you sure, that feels odd...

It does feel odd and downright wrong...  But there are a lot of WARN_ON_ONCE's
out there to catch this type of internal programming error.  Is panic-on-warn
commonly used?

Ira
