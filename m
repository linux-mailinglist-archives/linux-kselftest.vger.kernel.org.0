Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529D31588B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 22:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhBIVV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 16:21:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:47834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233733AbhBIUqB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 15:46:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612901312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utBmzEHnMldk+xybu3FUHQ/4GijdaViYwt5S9/fMX5g=;
        b=TjFv3w1m/0Glle7o/mpLcPWsTy958OLjFP0MF4y2grgkrogeIq5dCnnfB5BszcW5ggUnqY
        LL4MV1a1lL2B5WOEu6FaOYZ3DET/TzX9b1n3q4/VP0Y/08QiHTyolRop/Pd6AqhLXBScSy
        PBnAIDa+ir2IADhVPtKtqxwjkXo403U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC40AADF0;
        Tue,  9 Feb 2021 20:08:32 +0000 (UTC)
Date:   Tue, 9 Feb 2021 21:08:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCLrv86O0ZoKhfN0@dhcp22.suse.cz>
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
 <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
 <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
 <YCJbmR11ikrWKaU8@dhcp22.suse.cz>
 <c1e5e7b6-3360-ddc4-2ff5-0e79515ee23a@redhat.com>
 <YCKNMqu8/g0OofqU@dhcp22.suse.cz>
 <8cbfe2c3-cfc6-72e0-bab1-852f80e20684@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cbfe2c3-cfc6-72e0-bab1-852f80e20684@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 09-02-21 17:17:22, David Hildenbrand wrote:
> On 09.02.21 14:25, Michal Hocko wrote:
> > On Tue 09-02-21 11:23:35, David Hildenbrand wrote:
> > [...]
> > > I am constantly trying to fight for making more stuff MOVABLE instead of
> > > going into the other direction (e.g., because it's easier to implement,
> > > which feels like the wrong direction).
> > > 
> > > Maybe I am the only person that really cares about ZONE_MOVABLE these days
> > > :) I can't stop such new stuff from popping up, so at least I want it to be
> > > documented.
> > 
> > MOVABLE zone is certainly an important thing to keep working. And there
> > is still quite a lot of work on the way. But as I've said this is more
> > of a outlier than a norm. On the other hand movable zone is kinda hard
> > requirement for a lot of application and it is to be expected that
> > many features will be less than 100% compatible.  Some usecases even
> > impossible. That's why I am arguing that we should have a central
> > document where the movable zone is documented with all the potential
> > problems we have encountered over time and explicitly state which
> > features are fully/partially incompatible.
> > 
> 
> I'll send a mail during the next weeks to gather current restrictions to
> document them (and include my brain dump). We might see more excessive use
> of ZONE_MOVABLE in the future and as history told us, of CMA as well. We
> really should start documenting/caring.

Excellent! Thanks a lot. I will do my best to help reviewing that.

> @Mike, it would be sufficient for me if one of your patches at least mention
> the situation in the description like
> 
> "Please note that secretmem currently behaves much more like long-term GUP
> instead of mlocked memory; secretmem is unmovable memory directly
> consumed/controlled by user space. secretmem cannot be placed onto
> ZONE_MOVABLE/CMA.

Sounds good to me.

-- 
Michal Hocko
SUSE Labs
