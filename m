Return-Path: <linux-kselftest+bounces-46437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5F7C856BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A45E3502F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E331D366;
	Tue, 25 Nov 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBKPnuqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4A222578;
	Tue, 25 Nov 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080953; cv=none; b=nhEk0wKRfe0JFVOsHrkMCNc1OWgHyadAUolstPpZJ71/xV/3nvcH+7vnIGKGEwD5PDDJUkljsvsEV3Lw/204jXHL+HHsPQLJG27wbBEMCmZpXNvW/ZAF5fjzfbD+/z0Kxjy8y76PZhmSTG4p930koP1srCrY9W7nMhG6aA/U3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080953; c=relaxed/simple;
	bh=QtIX7m37UB3jSsMIWRrcRctC3VHFDnbfN3XBMYjY5iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIVCXOAMeOuXvVJVUW3wB12xVnxcOs7FF2rf0wF20VlFyky3RpAFbtx8KVKTgZ11IDeAOYC3/Y4wfNRwWDIzsOoUOoKFs+4o9TKYbA90QJv5Bo0CLOwd8ENNXm3TiHGAdReRKMtp7huSOaO24oc5pE40uwO8S5yOP/UjiScNIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBKPnuqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DC5C4CEF1;
	Tue, 25 Nov 2025 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764080953;
	bh=QtIX7m37UB3jSsMIWRrcRctC3VHFDnbfN3XBMYjY5iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBKPnuqgEw3szxGkQOnxr0TMpZ/I3SfNa3fREd5sHp8tNCegHRljayZIIKjHWeZRx
	 LNFSWCHEtnVAzQ44+gTiYwuHP45oAoqYfcOcO1Jmf+ESzW4HMVxtPO2WqxraAGjxcK
	 NU190+XBXxcDq4qG70hy+0R8LyBy1sc0+HIXaOZihCDRvwK4VkvZBktyTpdch+MFW1
	 WJALRPtOUP6N7aTvT7sxAb9UId41zDLJ8llvhlk5UhGAaOcPlvFAaT4hhJ6qAcp6Zw
	 26pmyKLrpNOouIEegNgpIiIt1vncfTwTgqEFdr0049Fkv/BR3j/2aaosGBPrb5nEyL
	 qfD/kciwyAYJQ==
Date: Tue, 25 Nov 2025 16:29:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/5] userfaultfd, shmem: use a VMA callback to handle
 UFFDIO_CONTINUE
Message-ID: <aSW9MJJ1CF65m5w9@kernel.org>
References: <20251123102707.559422-1-rppt@kernel.org>
 <20251123102707.559422-3-rppt@kernel.org>
 <a06e57ff-b77b-44fd-9b69-929d7647644b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06e57ff-b77b-44fd-9b69-929d7647644b@kernel.org>

On Mon, Nov 24, 2025 at 12:03:17PM +0100, David Hildenbrand (Red Hat) wrote:
> On 11/23/25 11:27, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> > it needs to get a folio that already exists in the pagecache backing
> > that VMA.
> > 
> > Instead of using shmem_get_folio() for that, add a get_pagecache_folio()
> 
> get_shared_folio()
> 
> Given that the helper now no longer receives a VMA, I assume we can just
> really call it get_folio() and the "shared" part would be implicit. (from
> the inode)

It makes naming shmem_vm_ops.get_folio harder, because we already have
shmem_get_folio :)
I'll think of something.

> -- 
> Cheers
> David

-- 
Sincerely yours,
Mike.

