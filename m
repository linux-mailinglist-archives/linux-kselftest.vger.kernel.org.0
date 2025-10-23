Return-Path: <linux-kselftest+bounces-43843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C8BFEF3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 04:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A81D3A8891
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 02:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BD91E9B37;
	Thu, 23 Oct 2025 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DELixs+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0D1D6DB5;
	Thu, 23 Oct 2025 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187543; cv=none; b=MmYyvyt40M01JfSdt77GjcdM37vc5MqzndlSMbsGLuRgtLqV7o/C3x8gcKJMdwq7CvZ/mpz7k/YDMq6tf08q7bBZxMv3LPQTVE9gYwPBHgSz8KVGXvCVkXGrdNjLzDltZOWydoVEkhVbWYEw0zr126Gs0G4p1YL8dZx05hY3SlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187543; c=relaxed/simple;
	bh=o8VZqgreM/+4inCjv3Ryf7+yviInpAaMHdtb3IX6YvU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yq1IuBXfiG2yJCuWqsXnuNf7cAhOG7HI3WIo5gL0ztakGjNUc/95SUKUFykh9EPVQAyR0pAVcZaoShEgcfsi2Us24LTPScP6Um2D6AfonnG/gGbml0CD636dOXLq874O7BntIxIgmGY9+NBbexEHnN3Htym97asRTL2SzwEl3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DELixs+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DA6C4CEE7;
	Thu, 23 Oct 2025 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761187543;
	bh=o8VZqgreM/+4inCjv3Ryf7+yviInpAaMHdtb3IX6YvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DELixs+3JW+JqnfawdV6brsJEThbe9/wzBqUgy/CUKJ33mQbr/BNONavmP8E0HGmP
	 LaK5jWZXYUAPerhqLMGTxgezcGLObtdiHj1XYVZ5yZ+jM2NMPeGFLfnM+QoPrdasYj
	 YpIKZaPl6NCWE/BnE5KbZxY4FUD4zn8v2SG8wtxs=
Date: Wed, 22 Oct 2025 19:45:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, brauner@kernel.org, corbet@lwn.net,
 graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org,
 ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, jasonmiu@google.com, dmatlack@google.com,
 skhawaja@google.com
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
Message-Id: <20251022194541.68c26d16b615ded15c5d3014@linux-foundation.org>
In-Reply-To: <CA+CK2bDPLAS7EM--stHkZkx8FSgYBjDOz6FdvWBYrdHwZpZZjw@mail.gmail.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
	<aPchmxfh4ACM0vY2@kernel.org>
	<CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
	<20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
	<CA+CK2bDPLAS7EM--stHkZkx8FSgYBjDOz6FdvWBYrdHwZpZZjw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 20:15:04 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> On Tue, Oct 21, 2025 at 4:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 21 Oct 2025 12:04:47 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > > > With liveupdate: dropped from the subjects
> > >
> > > I noticed "liveupdate: " subject prefix left over only after sending
> > > these patches. Andrew, would you like me to resend them, or could you
> > > remove the prefix from these patches?
> >
> > No problem.
> >
> > What should we do about -stable kernels?
> >
> > It doesn't seem worthwhile to backport a 3-patch series for a pretty
> > obscure bug.  Perhaps we could merge a patch which disables this
> 
> We are using KHO and have had obscure crashes due to this memory
> corruption, with stacks all over the place. I would prefer this fix to
> be properly backported to stable so we can also automatically consume
> it once we switch to the upstream KHO.

Oh.

I added this important info to the [0/N] changelog, added

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Cc: <stable@vger.kernel.org>

to all three and moved this into mm.git's mm-hotfixes branch.


