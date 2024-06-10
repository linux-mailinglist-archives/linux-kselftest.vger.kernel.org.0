Return-Path: <linux-kselftest+bounces-11592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D79028FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451ED285160
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4708185626;
	Mon, 10 Jun 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdpTivhf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DF1B5A4;
	Mon, 10 Jun 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046355; cv=none; b=ImcocjbFPYt0b8uz/z3sgakCa3E9x3qsDPnJMC6YJeKDGMfXKX0TaJ9KLUIeVEzov02Go2+hYXuqypnFSVg+lz6xR/kaANF8CxXCkeOkJvHeahaYHIs1/Giond4U5E4/mt2t54DbEP+E1yZGk4uXb3crd/rLRncqzH7ZHjnrOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046355; c=relaxed/simple;
	bh=ZQmVAWnF8v7SoLum4h6QPX+CI7BadFQV9FnQJOXaDio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPc10ymUNrgJl7PSLRptk4k2XjDC7WsS4u01DCEDiNkiKsbfDPjETQtCWTWB/4pTUtXks2Xo4nCbxyQhPimrY5O++dJht6WU8CvthjlZomXiahcoPasEjlnXzc7dYAQRdr/lGvXdXe0yOi33JfHk8xlmwcIERqHpI4EJzy8UUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdpTivhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDFC2BBFC;
	Mon, 10 Jun 2024 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718046354;
	bh=ZQmVAWnF8v7SoLum4h6QPX+CI7BadFQV9FnQJOXaDio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdpTivhfm4Myls0526XPowHUnRMG2EUiXYz51iLCtjh1PSP9XY2ALOcgt0TOy9mVd
	 IWn8hUH6wRvswqGFwlgX9BXoO/Bm1BZOTFSP9/bepbRZRHEHYLP1WWXMl2JoAcR7Ue
	 L+zee8qYk31KSb50Y37AuimPGwF1EjeKFIskbFTOKzkI2+PLmlLx/qDFW74wmlRRrO
	 W3FhutcZ/aCQUjrtJgAo2tF84Q/BiHmlMRQPHGVBlyFnX4JT+mZzJ4V4hsAqxDLuVI
	 419Rr/EzZ5+fszNp3FXDW0atHgW3YdjeNHx6tD2whp6iht11HeMamNj0+9mlFsEgoC
	 rIEf3/1ZrXlBA==
Date: Mon, 10 Jun 2024 12:05:54 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] kunit: test: Add vm_mmap() allocation resource
 manager
Message-ID: <202406101202.3D887825@keescook>
References: <20240519190422.work.715-kees@kernel.org>
 <20240519191254.651865-1-keescook@chromium.org>
 <ZksX4r0a1EGE_VPl@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZksX4r0a1EGE_VPl@J2N7QTR9R3>

On Mon, May 20, 2024 at 10:29:06AM +0100, Mark Rutland wrote:
> On Sun, May 19, 2024 at 12:12:52PM -0700, Kees Cook wrote:
> > +/* Create and attach a new mm if it doesn't already exist. */
> > +static int kunit_attach_mm(void)
> > +{
> > +	struct vm_area_struct *vma;
> > +	struct mm_struct *mm;
> > +
> > +	if (current->mm)
> > +		return 0;
> 
> My tests deliberately created/destroyed the mm for each test; surely we
> don't want to inherit an MM in some arbitrary state? ... or is this just
> so the mm can be allocated lazily upon the first mmap() within a test?

It's for lazily creation and for supporting running the KUnit test as a
module (where a userspace would exist). The old usercopy test worked
against the existing userspace, so I'd want to continue to support that.

> 
> > +
> > +	mm = mm_alloc();
> > +	if (!mm)
> > +		return -ENOMEM;
> > +
> > +	if (mmap_write_lock_killable(mm))
> > +		goto out_free;
> > +
> > +	/* Define the task size. */
> > +	mm->task_size = TASK_SIZE;
> > +
> > +	/* Prepare the base VMA. */
> > +	vma = vm_area_alloc(mm);
> > +	if (!vma)
> > +		goto out_unlock;
> > +
> > +	vma_set_anonymous(vma);
> > +	vma->vm_start = UBUF_ADDR_BASE;
> > +	vma->vm_end = UBUF_ADDR_BASE + PAGE_SIZE;
> > +	vm_flags_init(vma, VM_READ | VM_MAYREAD | VM_WRITE | VM_MAYWRITE);
> > +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> > +
> > +	if (insert_vm_struct(mm, vma))
> > +		goto out_free_vma;
> > +
> > +	mmap_write_unlock(mm);
> 
> Why do we need this VMA given you have kunit_vm_mmap()?

When I was originally testing this, it seemed like I couldn't perform a
vm_mmap() without an existing VMA.

> This existed in my uaccess tests because I didn't use vm_mmap(), and I
> wanted complete control over the addresses used.
> 
> Given you add kunit_vm_mmap(), I don't think we want this VMA -- it
> doesn't serve any real purpose to tests, and accesses can erroneously
> hit it, which is problematic.
> 
> UBUF_ADDR_BASE shouldn't be necessary either with kunit_vm_mmap(),
> unless you want to use fixed addresses. That was just arbitrarily chosen
> to be above NULL and the usual minimum mmap limit.

I'll recheck whether this is needed. I think I had to make some other
changes as well, so maybe something here ended up being redundant
without my noticing it the first time.

Thanks for looking this over!

-- 
Kees Cook

