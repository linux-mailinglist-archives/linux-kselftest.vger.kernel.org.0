Return-Path: <linux-kselftest+bounces-45156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A9C4219B
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 01:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895394E1C60
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF916C133;
	Sat,  8 Nov 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rDOela9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B72883F;
	Sat,  8 Nov 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560536; cv=none; b=IQft3uJIoori6nrkfBOWT+1KXNDhbSVYeRqX07BYNV0xi0//fNYnQTTKUUjjHPQfxruPjjIVaYwwm2G1DT2LxBeshIemqGtJZj2/dGF0+Zcu/gbrJLmS3dqy4SJ9S4U1ks6tactTSt3gN5iFGDnPNAVov01aBaXej37TSPYJ9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560536; c=relaxed/simple;
	bh=OTeLr/gdmWTJmpiKPkfQJJfAv0QmvVtcPkNjwhc99NY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QEa2Z0Jocb2ri5JY82vfumoUnkDeUMBVclUGz8WhTZ4xfzH3PWdwSnN1sujCGbuaqfSTBS8V0DT9xbTuq4PvmuBUEu7MO9uW+ynA+tB2ZkMwYEABuWn67Dn7aiyjMve2cf9mHmAT4yWftXbpcMP5rWQTPlA1wR5uok9AzCd22RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rDOela9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C2DC4CEF7;
	Sat,  8 Nov 2025 00:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762560536;
	bh=OTeLr/gdmWTJmpiKPkfQJJfAv0QmvVtcPkNjwhc99NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rDOela9v4Nmo0EdfH0Cec9HO/dHEdeyP+DvdMtXYxA1H49algjk0eMiXxRk2DVLBT
	 gziferQ9JXx+Etq25IJmPttTOmFRuKw+TkiQAiMggVUmkEoZEdFqe7ITxZV4GwSA9k
	 WxbC4PN+8vIuDPtaclrn5UsM6Ub1oa61r0e3rcGs=
Date: Fri, 7 Nov 2025 16:08:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah
 Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-Id: <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>
In-Reply-To: <6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
	<fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
	<aQyOZ6eYng-IjxS_@fedora>
	<6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 10:27:27 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> On 06.11.25 13:02, Ankit Khushwaha wrote:
> > On Thu, Nov 06, 2025 at 12:18:57PM +0100, David Hildenbrand (Red Hat) wrote:
> >> On 06.11.25 11:49, Ankit Khushwaha wrote:
> >>> Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
> >>> triggers following warning:
> >>>
> >>> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> >>> false [-Wtautological-compare]
> >>>    1035 |                 if (addr + c.dest_alignment < addr) {
> >>>         |                                             ^
> >>>
> >>> typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
> >>
> >> With which compiler are you seeing this?
> > 
> > Hi David,
> > 
> > clang version 20.1.8 (Fedora 20.1.8-4.fc42) raised this warning.
> > 
> > To reproduce:
> > 	make -C tools/testing/selftests/mm CC=clang
> 
> Thanks, and thanks to Lorenzo for the details.
> 
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

I must say, applying this would be an unhappy life event.

	if (void* + ulong < void*)

makes perfect sense in a world which permits void* arithmetic (ie,
ours).  So what the heck is clang doing??

If we do

	void *addr2 = addr + c.dest_alignment;
	if (addr2 < addr)
		...

then which statement warns, and why?

