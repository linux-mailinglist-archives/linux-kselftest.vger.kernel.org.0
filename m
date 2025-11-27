Return-Path: <linux-kselftest+bounces-46625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4866C8DCFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB04E3164
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F5320CD5;
	Thu, 27 Nov 2025 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdrDspf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911F79DA;
	Thu, 27 Nov 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239949; cv=none; b=NeozrHycz+6xbcRbU6kGyNkz6OiYEECuA4dQKkJ2mzSJD89/+BOOctsLf6domJEBYbjOB2W6MM2D+xN6LoKdIyFeoO0kwQQvw0kCd90Pz84WvWuo76dxTgr5hrZwDvheLP0MPO4duJVpzhw/x7h7H7EtePWcnxmcUa7sGBl92r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239949; c=relaxed/simple;
	bh=9o1jZ8Oj1DOfr27ZVVqlDJBNXIj4fytpgJFoLZErDXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4PEI6KZxDT/d889ZtcWKTszqMQ969k8GBM/TxQ6mHbweU+pUUZ56Rx8QpxA9WvGYMbRu/gqj6ycsGo4INaSLyxrzFQKF7HLOJM8soEGwhqDAYsckFvz/azl8QVXYOIMX0z1DJh2F/H/8aRhoAUsrUr6lw12bT7J31QZeJ6s5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdrDspf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645DAC4CEF8;
	Thu, 27 Nov 2025 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764239948;
	bh=9o1jZ8Oj1DOfr27ZVVqlDJBNXIj4fytpgJFoLZErDXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdrDspf9sqnTmBIOYvod/rDMAzZHXGCJUoTEMVvCLFgKmKUvLHn5KthSzXHbY6DSN
	 28Z3u+Vwg+5o4ehdfQ103R8cHF9GtKLFVGP3pS75Ki8zXd01n0cFocmT5blduWNEqw
	 0bR+FC4GR0WFX1oXAPfY8krmw/qKdRuLUL3CUfAD1z6hW1ZUpG775MHQOHRUKm41fR
	 7CJ0N5WxfPiUUWCb64he8prtusjo1bMXC/oZpGVl8c8xzIiZLmEsQCGXI09cjE3Aws
	 4VoXilNuLmNFvFDSP9LZXia/IMiIXD+vMwsGwgYo0kXizRa9fcc+HbTNbuM1MHskpK
	 xZ52bPX4oQM9Q==
Date: Thu, 27 Nov 2025 12:39:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 5/5] KVM: selftests: test userfaultfd minor for
 guest_memfd
Message-ID: <aSgqRAF6Ih8u6fdP@kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-6-rppt@kernel.org>
 <18b4cddb-3e04-4272-9f04-6857cea70ff5@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b4cddb-3e04-4272-9f04-6857cea70ff5@amazon.com>

On Wed, Nov 26, 2025 at 04:49:46PM +0000, Nikita Kalyazin wrote:
> On 25/11/2025 18:38, Mike Rapoport wrote:
> > From: Nikita Kalyazin <kalyazin@amazon.com>
> > 
> > +static void test_uffd_minor(int fd, size_t total_size)
> > +{
> > +       struct uffdio_api uffdio_api = {
> > +               .api = UFFD_API,
> > +               .features = UFFD_FEATURE_MINOR_GENERIC,
> 
> Should it be UFFD_FEATURE_MINOR_SHMEM instead? UFFD_FEATURE_MINOR_GENERIC
> was removed in the v1.

I'll drop .features completely, the checks in UFFDIO_REGISTER are
sufficient.
 

-- 
Sincerely yours,
Mike.

