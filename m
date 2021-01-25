Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D12302863
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 18:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbhAYRCl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 12:02:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:50368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbhAYRCL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 12:02:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611594083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vhg3ZuXdxoTlKTck/oJokadNWML4/97msM+l8PPW1KQ=;
        b=ekr2Ky1dZoRqi6ycGHVcexZtgRdu4MDaulztS70s8hHeoDI4yFro/m5BDFgGJjh7XxGRcq
        OdP/PJmINTbjpgXdHy4MQI8TR0XvbgfyJK1DIbaE0IJT4yiv7duwl7QsRrI2lC9GQ+4fV8
        Fl+xfN24YgfeX+iBNh+IKs3bk8PeCaI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4907CAD7A;
        Mon, 25 Jan 2021 17:01:23 +0000 (UTC)
Date:   Mon, 25 Jan 2021 18:01:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 06/11] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210125170122.GU827@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-7-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121122723.3446-7-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 21-01-21 14:27:18, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Introduce "memfd_secret" system call with the ability to create memory
> areas visible only in the context of the owning process and not mapped not
> only to other processes but in the kernel page tables as well.
> 
> The user will create a file descriptor using the memfd_secret() system
> call. The memory areas created by mmap() calls from this file descriptor
> will be unmapped from the kernel direct map and they will be only mapped in
> the page table of the owning mm.
> 
> The secret memory remains accessible in the process context using uaccess
> primitives, but it is not accessible using direct/linear map addresses.
> 
> Functions in the follow_page()/get_user_page() family will refuse to return
> a page that belongs to the secret memory area.
> 
> A page that was a part of the secret memory area is cleared when it is
> freed.
> 
> The following example demonstrates creation of a secret mapping (error
> handling is omitted):
> 
> 	fd = memfd_secret(0);
> 	ftruncate(fd, MAP_SIZE);
> 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

I do not see any access control or permission model for this feature.
Is this feature generally safe to anybody?
-- 
Michal Hocko
SUSE Labs
