Return-Path: <linux-kselftest+bounces-45676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0605C5F852
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2E04348FF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D992FBDE4;
	Fri, 14 Nov 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i8uaM4bq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920429D27A;
	Fri, 14 Nov 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159951; cv=none; b=YJHVuTDoupfNN8pjHZvMxydXOQCfKwLpzZWKr9NArCOsP74pEGZ3RszSDxV4QsL931XA8wPzNPZ8CiT7TuRbCGuMYyXj2/S9pFxMOZaG8KNQPKt2cunYQHCu8s6NC2Z0VmDAm+LXUop0fzqiiMibqTl04m4qufMSTnEkPG/c/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159951; c=relaxed/simple;
	bh=MYESjMwsofYhqqquOVfZchs52Vx8aKwvtmP2Lmh5LHE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eqKESJ9r0dTl36FPXVIC4UmfVJ0WgprJ7cM/8TIRDCdmbFeQRpIeR1wCQHW3Rbtw224ALufiwHUhvQeYaGJ4ETtUGuGRrnuBoDNLPbmCEljj5175ByQlcCwtwxnbySOp9/ZeTF7swC1Dlxmh70VeO+VWz66akfsDvgCujigaNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i8uaM4bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF69C4CEF5;
	Fri, 14 Nov 2025 22:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763159950;
	bh=MYESjMwsofYhqqquOVfZchs52Vx8aKwvtmP2Lmh5LHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i8uaM4bqM/bAoszT1IjaRnvMQKaHJOAf2cjkjEQMgfdFGodOKmrvYIXQ72E7IljE2
	 wMLOmULdxSobtPEPSgdfYKeEuuC2Hw7V/uPUKlTFV0IvsQICMERyNtvFwZHby9fF+p
	 B/R2us7EVhMEVKTjjFgmroiAhM5yIjim9sXODTgc=
Date: Fri, 14 Nov 2025 14:39:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Carlos Llamas
 <cmllamas@google.com>, Peter Xu <peterx@redhat.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Ujwal Kundur
 <ujwal.kundur@gmail.com>, Brendan Jackman <jackmanb@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "open list:MEMORY MANAGEMENT - USERFAULTFD"
 <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
Message-Id: <20251114143909.14ecee31b88f179bc2858e30@linux-foundation.org>
In-Reply-To: <9d30836b-9ddb-4432-aa39-85e32c2ea645@kernel.org>
References: <20251113034623.3127012-1-cmllamas@google.com>
	<e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
	<4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local>
	<aRXyxWeh81-aTHaC@google.com>
	<b4291d0d-b913-4e61-9f9d-fbebd1eb4720@lucifer.local>
	<20251113153205.6507ecb308e7d09362905da7@linux-foundation.org>
	<9d30836b-9ddb-4432-aa39-85e32c2ea645@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 09:11:40 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> >>> Oops, I keep getting confused about this Cc stable thing. Please let me
> >>> know if a v2 dropping the tag is needed.
> >>
> >> No need, Andrew should spot the objection and drop the tag :)
> > 
> > I actually add cc:stable tags to selftests fixes!
> > 
> > Because why not.  Why leave people running known-to-be-buggy code when
> > our backporting processes are so well-functioning and lightweight?
> > 
> > I'm not getting the objection?
> 
> I thought we were so inconsistent on that that it ends up being a wasted 
> effort to even try taking care about stability of selfests in stable trees.

Oh,  I try to be vigilant about it.

hp2:/usr/src/mm> git log tools/testing/selftests/mm | grep stable@|wc
     44      89    1462

I pass selftests patches through the same brain algorithm as
I do everything else, shrug.

