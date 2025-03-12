Return-Path: <linux-kselftest+bounces-28820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA89A5E057
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6DA175D44
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257F240604;
	Wed, 12 Mar 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu6VBmQz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628A15539A;
	Wed, 12 Mar 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793281; cv=none; b=Rro7s6uU5Ze92GDZ78F1jmPVS3ARheEAoT6DaAdayOGK/atWKkb4/RO3JYfEZsge1BpaVKxj2TOnBCc6hAr+v6oGjOQULFPKQteImKns58YaLl0GAdi1cCpvIA7fXP7dkIT1sepgri4BcwI9iPiAgpfQBNVEsXsWSZa1L/4Gsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793281; c=relaxed/simple;
	bh=knZ+0Ki91XfMnnNBjvRtQYxda8bcVvsvaE8A+MwLFJY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FzbGAAwJssFJ7w8MidavEdvnslrSgTt21OPoO2UKo3MB9cD2C4IQfKtLScq5wqYzZKw5qcCGTC8WFP3a/vIeyVzd9h2NiFIetNzlKGiSD57C1cZPQ7KmRT9gtSqSJa+7uyrSTS0j79HCG5/RtwaErQpGGDSibTwB/VjSYq4M5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu6VBmQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AD8C4CEDD;
	Wed, 12 Mar 2025 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741793280;
	bh=knZ+0Ki91XfMnnNBjvRtQYxda8bcVvsvaE8A+MwLFJY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cu6VBmQz26ajpPamenktK8g8GX/gSYoIYgTmN5l+RfYdCJzKwBt7BzNIJbL84ItlK
	 Jvl+nOahTBFgn9Ui++4b5xOD4aRvGcFb7GW7QP734hYNxsFkvRyBF0wlZs2Kb33SKC
	 UklngiqgjbOxKFocLsWxCeQ/wrU8F67OzDIQ+X6Szr6EXP+9EB+dVIyPBFbcGdYrBj
	 X6udwysXh1kU/fI1E0R05tiF6xDiWGbv5AMAE1EiGtklHkYzZHfwJ1UL9G3tnW7yrZ
	 8ZdjlrgSMmdgKqGeChgl5Zxv8Uxisp7LGJX4oZ8hirmU4+Vm8TyeMQW6y9QDNZQURI
	 wAoG3IGVVQuvw==
Date: Wed, 12 Mar 2025 08:27:57 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org
CC: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
 broonie@kernel.org, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org,
 pedro.falcato@gmail.com, rdunlap@infradead.org, jannh@google.com
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
User-Agent: K-9 Mail for Android
In-Reply-To: <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local>
References: <20250312002117.2556240-1-jeffxu@google.com> <20250312002117.2556240-3-jeffxu@google.com> <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local>
Message-ID: <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 12, 2025 6:49:39 AM PDT, Lorenzo Stoakes <lorenzo=2Estoakes@oracl=
e=2Ecom> wrote:
>On Wed, Mar 12, 2025 at 12:21:17AM +0000, jeffxu@chromium=2Eorg wrote:
>> From: Jeff Xu <jeffxu@chromium=2Eorg>
>>
>> Initially, when mseal was introduced in 6=2E10, semantically, when a VM=
A
>> within the specified address range is sealed, the mprotect will be reje=
cted,
>> leaving all of VMA unmodified=2E However, adding an extra loop to check=
 the mseal
>> flag for every VMA slows things down a bit, therefore in 6=2E12, this i=
ssue was
>> solved by removing can_modify_mm and checking each VMA=E2=80=99s mseal =
flag directly
>> without an extra loop [1]=2E This is a semantic change, i=2Ee=2E partia=
l update is
>> allowed, VMAs can be updated until a sealed VMA is found=2E
>>
>> The new semantic also means, we could allow mprotect on a sealed VMA if=
 the new
>> attribute of VMA remains the same as the old one=2E Relaxing this avoid=
s unnecessary
>> impacts for applications that want to seal a particular mapping=2E Doin=
g this also
>> has no security impact=2E
>>
>> [1] https://lore=2Ekernel=2Eorg/all/20240817-mseal-depessimize-v3-0-d8d=
2e037df30@gmail=2Ecom/
>>
>> Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modif=
y_vma")
>> Signed-off-by: Jeff Xu <jeffxu@chromium=2Eorg>
>> ---
>>  mm/mprotect=2Ec | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/mprotect=2Ec b/mm/mprotect=2Ec
>> index 516b1d847e2c=2E=2Ea24d23967aa5 100644
>> --- a/mm/mprotect=2Ec
>> +++ b/mm/mprotect=2Ec
>> @@ -613,14 +613,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct m=
mu_gather *tlb,
>>  	unsigned long charged =3D 0;
>>  	int error;
>>
>> -	if (!can_modify_vma(vma))
>> -		return -EPERM;
>> -
>>  	if (newflags =3D=3D oldflags) {
>>  		*pprev =3D vma;
>>  		return 0;
>>  	}
>>
>> +	if (!can_modify_vma(vma))
>> +		return -EPERM;
>> +
>>  	/*
>>  	 * Do PROT_NONE PFN permission checks here when we can still
>>  	 * bail out without undoing a lot of state=2E This is a rather
>> --
>> 2=2E49=2E0=2Erc0=2E332=2Eg42c0ae87b1-goog
>>
>
>Hm I'm not so sure about this, to me a seal means 'don't touch', even if
>the touch would be a no-op=2E It's simpler to be totally consistent on th=
is
>and makes the code easier everywhere=2E
>
>Because if we start saying 'apply mseal rules, except if we can determine
>this to be a no-op' then that implies we might have some inconsistency in
>other operations that do not do that, and sometimes a 'no-op' might be
>ill-defined etc=2E

Does mseal mean "you cannot call mprotect on this VMA" or does it mean "yo=
u cannot change this VMA"=2E I've always considered it the latter since the=
 entry point to making VMA changes doesn't matter (mmap, mprotect, etc) it'=
s the VMA that can't change=2E Even the internal function name is "can_modi=
fy", and if the flags aren't changing then it's not a modification=2E

I think it's more ergonomic to check for _changes_=2E

-Kees

--=20
Kees Cook

