Return-Path: <linux-kselftest+bounces-5043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26785C13F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 17:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1221C20FC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60732768EF;
	Tue, 20 Feb 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNkl1r8M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31D763EF;
	Tue, 20 Feb 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446144; cv=none; b=oDhj09IglQpjDJOd0gz5VwT9p9edaZro4VIsEPl82bg0JuKgY7nK1DhuF/CsmZUFgo3TQCqAxl3cFscJaVQaibN+vcdomMhGVkz3CdOrzxF4E6VsQG5hDBqj75KZIX+tlIBSIEssyvzVYjE+Q7/60OFBZ+VPZroCzSx3lQGYxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446144; c=relaxed/simple;
	bh=zFkxNm4XUPZy9yD4NN6KLdlxmc1jFsrfMD0v41KFIfU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZWlRZvBNpzoIYIO12MNSiKtLhsOjsOUSMvQNSindWbVBMQhp7UJOQZSrV3PgmCMRqC+qpEMef4X2YSJAsUVAgmiazpjD2hVqqY2zkIgvJ7zW4TNv+FSo4Nso5VJwWyL0KmJEvGKe65I7munfGUQEMQLpKy2Br0jDTvBNtX1nZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hNkl1r8M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=BzeL9c/hzzSWVv3MKsT7A/KR/PSkHXr2fqH3rJbXD/E=; b=hNkl1r8MrK0h7XuvdH3qSHJNeK
	4DIQ/6TbXd8tHEsUs6nBa1ZRa+mvZx+9488lzdh3/KTqrQ0C3lwKKlmpJRgESnI2Cl1UlQhANoNMW
	lb6VNQKrBJVEbFg0uRuYRZMRR3424F3EmhNMQe/68gwhGaf2FeAax5t2GwozfYVtlY/7lV5PxpigP
	K+1B2BLgRuEKJQBSyq5cpY96o/0NgaYJpXPktU357ig/qcuBMUx+gyj0/xu5MTq3puAkISEDb6c4q
	omQGSCGfwiPYYEOdi3uLiBkGJQw/qKavQHZcDtirpOTVRgNclzOl1gQLCr1j5Ezqnk3ns9TSFFQn1
	wkb0ZBAw==;
Received: from [145.224.98.163] (helo=[127.0.0.1])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcSsW-0000000G1oT-0zRv;
	Tue, 20 Feb 2024 16:21:56 +0000
Date: Tue, 20 Feb 2024 17:21:52 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>, paul@xen.org
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v13_00/21=5D_KVM=3A_xen=3A_upda?= =?US-ASCII?Q?te_shared=5Finfo_and_vcpu=5Finfo_handling?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZdTQCuWor4ipxW6E@google.com>
References: <20240215152916.1158-1-paul@xen.org> <170838297541.2281798.7838961694439257911.b4-ty@google.com> <05973da0-f68c-4c84-8806-bdba92f2ed6e@xen.org> <ZdTQCuWor4ipxW6E@google.com>
Message-ID: <CFFFCD77-3B9E-4808-B084-E86F8EF265A7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

On 20 February 2024 17:15:06 CET, Sean Christopherson <seanjc@google=2Ecom>=
 wrote:
>On Tue, Feb 20, 2024, Paul Durrant wrote:
>> On 20/02/2024 15:55, Sean Christopherson wrote:
>> > On Thu, 15 Feb 2024 15:28:55 +0000, Paul Durrant wrote:
>> > > From: Paul Durrant <pdurrant@amazon=2Ecom>
>> > >=20
>> > > This series contains a new patch from Sean added since v12 [1]:
>> > >=20
>> > > * KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot=
()
>> > >=20
>> > > This frees up the function name kvm_is_error_gpa() such that it can=
 then be
>> > > re-defined in:
>> > >=20
>> > > [=2E=2E=2E]
>> >=20
>> > *sigh*
>> >=20
>> > I forgot to hit "send" on this yesterday=2E  But lucky for me, that w=
orked out in
>> > my favor as I needed to rebase on top of kvm/kvm-uapi to avoid pointl=
ess conflicts
>> > in the uapi headeres=2E
>> >=20
>> > So=2E=2E=2E=2E
>> >=20
>> > Applied to kvm-x86 xen, minus 18 and 19 (trylock stuff) and 21 (locki=
ng cleanup
>> > that we're doing elsewhere)=2E
>> >=20
>>=20
>> Looks like you meant 17 & 18?
>
>Doh, yes=2E
>
>> > Paul and David, please take (another) look at the end result to make =
sure you don't
>> > object to any of my tweaks and that I didn't botch anything=2E
>> >=20
>>=20
>> What was the issue with 17? It was reasonable clean-up and I'd like to =
keep
>> it even without 18 being applied (and I totally understand your reasons=
 for
>> that)=2E
>
>I omitted it purely to avoid creating an unnecessary dependency for the t=
rylock
>patch=2E  That way the trylock patch (or whatever it morphs into) can be =
applied on
>any branch (along with the cleanup), i=2Ee=2E doesn't need to be taken th=
rough kvm-x86/xen=2E

What about if (in_atomic() && read_trylock()) return -EAGAIN; else read_lo=
ck();

That way we don't have any even theoretical fairness issues because the tr=
ylock can fail just *once* which kicks us to the slow path and that'll take=
 the lock normally now=2E

The condition might not actually be in_atomic() but I'm not working this w=
eek and you get the idea=2E

