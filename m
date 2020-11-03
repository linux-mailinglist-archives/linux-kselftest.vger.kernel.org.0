Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3012A4E0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 19:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgKCSON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 13:14:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgKCSON (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 13:14:13 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35C720780;
        Tue,  3 Nov 2020 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604427252;
        bh=xcmtesgScEThQWVAlyFHd721UIZTZBM+vfZNEw5TWHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VimesJGlvik33xmtNnlRSxLtCoeagRnzi3P48Mt4udCeWae8MrB7kbLbSumPf5F15
         Ku982wT3xj9JAYwm4Ol3n+M9OgWO5KrFlHYhIod0StZ0pIG7z+e+jY0wUOJ/cHUyho
         JVeirJgujY0qEwRZE13TH1EGI5f/uLoc09DA1ca4=
Date:   Tue, 3 Nov 2020 19:14:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <20201103181407.GA83845@kroah.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <20201102205320.1458656-6-ira.weiny@intel.com>
 <20201103065024.GC75930@kroah.com>
 <20201103175335.GA1531489@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103175335.GA1531489@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 09:53:36AM -0800, Ira Weiny wrote:
> On Tue, Nov 03, 2020 at 07:50:24AM +0100, Greg KH wrote:
> > On Mon, Nov 02, 2020 at 12:53:15PM -0800, ira.weiny@intel.com wrote:
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > 
> 
> [snip]
> 
> > > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > > index 2955ba976048..0959a4c0ca64 100644
> > > --- a/include/linux/pkeys.h
> > > +++ b/include/linux/pkeys.h
> > > @@ -50,4 +50,28 @@ static inline void copy_init_pkru_to_fpregs(void)
> > >  
> > >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> > >  
> > > +#define PKS_FLAG_EXCLUSIVE 0x00
> > > +
> > > +#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > > +static inline int pks_key_alloc(const char * const pkey_user, int flags)
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +static inline void pks_key_free(int pkey)
> > > +{
> > > +}
> > > +static inline void pks_mk_noaccess(int pkey)
> > > +{
> > > +	WARN_ON_ONCE(1);
> > 
> > So for panic-on-warn systems, this is ok to reboot the box?
> 
> I would not expect this to reboot the box no.  But it is a violation of the API
> contract.  If pky_key_alloc() returns an error calling any of the other
> functions is an error.
> 
> > 
> > Are you sure, that feels odd...
> 
> It does feel odd and downright wrong...  But there are a lot of WARN_ON_ONCE's
> out there to catch this type of internal programming error.  Is panic-on-warn
> commonly used?

Yes it is, and we are trying to recover from that as it is something
that you should recover from.  Properly handle the error and move on.

thanks,

greg k-h
