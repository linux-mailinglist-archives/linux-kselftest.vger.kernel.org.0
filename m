Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658B325637E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Aug 2020 01:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH1X1R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Aug 2020 19:27:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:30377 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgH1X1O (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Aug 2020 19:27:14 -0400
IronPort-SDR: 8zMilxar9NaNnNFJObuGvuorTYaF2zMK+TvZbw+n/Io+uMbWz0ggeah890dbJ5P6mKRXq1A0Hz
 FbIglHuwD/7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="241577558"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="241577558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 16:27:13 -0700
IronPort-SDR: aFUo5/ueJR9F9AkbOVEeok/6ZDWjzZuQWWMWoNddiPznRojLznEO7CkhtRrf9DqVg2cf22cmVs
 IqQ9/8dU9qog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="374214094"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.74])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2020 16:27:07 -0700
Date:   Sat, 29 Aug 2020 02:27:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Nathaniel McCallum <npmccallum@redhat.com>,
        X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        "Xing, Cedric" <cedric.xing@intel.com>, chenalexchen@google.com,
        Conrad Parker <conradparker@google.com>, cyhanish@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Subject: Re: [PATCH v36 22/24] selftests/x86: Add a selftest for SGX
Message-ID: <20200828232706.GB20705@linux.intel.com>
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
 <20200716135303.276442-23-jarkko.sakkinen@linux.intel.com>
 <CAOASepO-DuQW88hxtAJv5Ki4GNYnkGNz5qK_dTEK_y8roMdPkg@mail.gmail.com>
 <20200827152051.GB22351@sjchrist-ice>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200827152051.GB22351@sjchrist-ice>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 27, 2020 at 08:20:51AM -0700, Sean Christopherson wrote:
> On Thu, Aug 27, 2020 at 12:47:04AM -0400, Nathaniel McCallum wrote:
> > > +int main(int argc, char *argv[], char *envp[])
> > > +{
> > > +       struct sgx_enclave_exception exception;
> > > +       struct vdso_symtab symtab;
> > > +       Elf64_Sym *eenter_sym;
> > > +       uint64_t result = 0;
> > > +       struct encl encl;
> > > +       unsigned int i;
> > > +       void *addr;
> > > +
> > > +       if (!encl_load("test_encl.elf", &encl))
> > > +               goto err;
> > > +
> > > +       if (!encl_measure(&encl))
> > > +               goto err;
> > > +
> > > +       if (!encl_build(&encl))
> > > +               goto err;
> > > +
> > > +       /*
> > > +        * An enclave consumer only must do this.
> > > +        */
> > > +       for (i = 0; i < encl.nr_segments; i++) {
> > > +               struct encl_segment *seg = &encl.segment_tbl[i];
> > > +
> > > +               addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
> > > +                           seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
> > 
> > My patch version is a bit behind (v32), but I suspect this still
> > applies. I discovered the following by accident.
> > 
> > In the Enarx code base, this invocation succeeds:
> > mmap(0x200000000000, 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED |
> > MAP_FIXED, sgxfd, 0)
> > 
> > However, this one fails with -EINVAL:
> > mmap(0x200000000000, 0x1000, PROT_READ | PROT_WRITE,
> > MAP_SHARED_VALIDATE | MAP_FIXED, sgxfd, 0)
> > 
> > From man mmap:
> > 
> >        MAP_SHARED_VALIDATE (since Linux 4.15)
> >               This flag provides the same behavior as MAP_SHARED
> > except that MAP_SHARED mappings ignore unknown
> >               flags in flags.  By contrast, when creating a mapping
> > using MAP_SHARED_VALIDATE, the kernel veri‐
> >               fies  all  passed  flags  are  known  and fails the
> > mapping with the error EOPNOTSUPP for unknown
> >               flags.  This mapping type is also required to be able to
> > use some mapping flags (e.g., MAP_SYNC).
> > 
> > I can try again on a newer patch set tomorrow if need be. But the
> > documentation of mmap() doesn't match the behavior I'm seeing. A brief
> > look through the patch set didn't turn up anything obvious that could
> > be causing this.
> 
> This is a bug in sgx_get_unmapped_area().  EPC must be mapped SHARED, and
> so MAP_PRIVATE is disallowed.  The current check is:
> 
>   if (flags & MAP_PRIVATE)
>           return -EINVAL;
> 
> and the base "flags" are:
> 
>   #define MAP_SHARED      0x01            /* Share changes */
>   #define MAP_PRIVATE     0x02            /* Changes are private */
>   #define MAP_SHARED_VALIDATE 0x03        /* share + validate extension flags */
> 
> which causes the SGX check to interpret MAP_SHARED_VALIDATE as MAP_PRIVATE.
> The types are just that, types, not flag modifiers.  So the SGX code needs
> to be:
> 
>   if ((flags & MAP_TYPE) == MAP_PRIVATE)
>           return -EINVAL;

Updated, thanks.

/Jarkko
