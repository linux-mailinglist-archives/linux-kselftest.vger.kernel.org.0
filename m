Return-Path: <linux-kselftest+bounces-45191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BABAC43996
	for <lists+linux-kselftest@lfdr.de>; Sun, 09 Nov 2025 07:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A4D3AEC09
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Nov 2025 06:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B134823DD;
	Sun,  9 Nov 2025 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4DJE34b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B12E40E;
	Sun,  9 Nov 2025 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762671261; cv=none; b=OyH7ZktJ/8p8WS0rbP3n+91zaw0C8m/kxeWelgpAZbZ0kupNUwMsMELxVfrNKDftV+oZiY0MNNr7eyhnLjY6g3t2Vu2ngvtaK9UkikArfkl63gD8uWUQpsQwcnuiiQ/r65wPWalGatzldOB5SdI1MaFMd9eVPEr7qIYleLts0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762671261; c=relaxed/simple;
	bh=3JS1OgZ14RhHt06MEdgrfvg3N/fs6BGb/Kur+DRi2oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM8j7HYWt5I/NR7nl5iSb3pd700f4bWKz2y/jnulrzTCtLy1uIHll9g2pSVV4ekgBzpuYA80/6qBAqerEMzndo8e1JtpKfmHtzIgh3FF1xSXPgZkjSiHGvYrQrEY5Vfk4ojkvf3ILpVgLgayWFEkmcqV+pgcwAOnHCRm/F21Q7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4DJE34b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835B6C16AAE;
	Sun,  9 Nov 2025 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762671260;
	bh=3JS1OgZ14RhHt06MEdgrfvg3N/fs6BGb/Kur+DRi2oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4DJE34bZXgLmGCl+bPOHU3/pMacEfW6fXeyFOj4KAAaKC8vgSxqmhz+nCX5IoYly
	 /q2t44l39jqUTuoxLwsvscAUEzf46VSW+s4sloJSKvEq4sXjoSVDyP2c0IlrEbS7DZ
	 NYyv0G5d11oSBi4aWzo2zt/Y6RJNASmKFpX3FofOhaoM9OdaMpQB6Xj4LgIgNsog65
	 VYms1n0QIYM83TSiIdy0LQSgaBugIOmbuNFmiJW/9psFhVjbnZwOTrCrqqzjzBZfCX
	 tmyXuwTYZiGPZ3IM++NLq6+haE6uqZmXREDw41mogiaVbRQD5rw8YfKV/k0Hzoz0kL
	 RVSa5hJth48Wg==
Date: Sun, 9 Nov 2025 08:54:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <aRA6lEQmmrvmj2DX@kernel.org>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
 <aQyOZ6eYng-IjxS_@fedora>
 <6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
 <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>

(added Nathan for clang advice)

On Fri, Nov 07, 2025 at 04:08:55PM -0800, Andrew Morton wrote:
> On Fri, 7 Nov 2025 10:27:27 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> 
> > On 06.11.25 13:02, Ankit Khushwaha wrote:
> > > On Thu, Nov 06, 2025 at 12:18:57PM +0100, David Hildenbrand (Red Hat) wrote:
> > >> On 06.11.25 11:49, Ankit Khushwaha wrote:
> > >>> Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
> > >>> triggers following warning:
> > >>>
> > >>> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> > >>> false [-Wtautological-compare]
> > >>>    1035 |                 if (addr + c.dest_alignment < addr) {
> > >>>         |                                             ^
> > >>>
> > >>> typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
> > >>
> > >> With which compiler are you seeing this?
> > > 
> > > Hi David,
> > > 
> > > clang version 20.1.8 (Fedora 20.1.8-4.fc42) raised this warning.
> > > 
> > > To reproduce:
> > > 	make -C tools/testing/selftests/mm CC=clang
> > 
> > Thanks, and thanks to Lorenzo for the details.
> > 
> > Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> 
> I must say, applying this would be an unhappy life event.
> 
> 	if (void* + ulong < void*)
> 
> makes perfect sense in a world which permits void* arithmetic (ie,
> ours).  So what the heck is clang doing??
> 
> If we do
> 
> 	void *addr2 = addr + c.dest_alignment;
> 	if (addr2 < addr)
> 		...
> 
> then which statement warns, and why?

-- 
Sincerely yours,
Mike.

