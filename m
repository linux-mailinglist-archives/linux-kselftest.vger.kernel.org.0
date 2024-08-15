Return-Path: <linux-kselftest+bounces-15383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E7952900
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 07:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782481F232CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 05:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9578116BE1F;
	Thu, 15 Aug 2024 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="O4x6Oz2Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB516BE09;
	Thu, 15 Aug 2024 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723700373; cv=none; b=ECNmaGVW21vifYDFs85spzMvFSvqVKRwMovMgX6OkQTMICJ62Qj38V/jmI5Mz37K9cL55ySI0T9rLwzOfUS6abRxriw3YOEl5J966npkMLYBkqqWX6bsjQz9di2oUqNQ6EzlosjA2S+8ABPLI5v/RlDy8vHYRV+ncHzr2/mgNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723700373; c=relaxed/simple;
	bh=FQNp4BEQ7IqVDDn/jXcrdkYEW19V4KPHQVKFwyOZObY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SsMVxsHdsVKm9Iq3nMeb9diERQfiARkai5s7Ru1wMptwG9UizkRc6+hCm0/PaNKnmdeMvAlIRMUpaERkys52rQQNk0ET1YzmadgYjgd72SE+bPegEr3poH18XdmN8z0yNDdMpMdI/3kCSkFxLRGInV+ZPkY/Xgm8ZfYc1W2LRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=O4x6Oz2Q; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1723700369;
	bh=FQNp4BEQ7IqVDDn/jXcrdkYEW19V4KPHQVKFwyOZObY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O4x6Oz2QIjlYofqnyrnOauhbjMsH0SgqQZdqka13CEPMI1a8eG5nRZOtksp6y9cFs
	 YTlVWSvqEP/BjXn8d1Zqlq6tSSWXqObG94OFdNdUmSijzlamn+j+AA6dYyTTW7AFdI
	 1Nge5w9VDU1UAxsJhNqnVeKW3cRsXc6FcthUY5xg=
Received: from [IPv6:240e:358:1123:b00:dc73:854d:832e:3] (unknown [IPv6:240e:358:1123:b00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BC57466F26;
	Thu, 15 Aug 2024 01:39:27 -0400 (EDT)
Message-ID: <6553a3f000343d6dd1fb3218cac4709badcaa04d.camel@xry111.site>
Subject: Re: [PATCH] selftests/vDSO: support DT_GNU_HASH
From: Xi Ruoyao <xry111@xry111.site>
To: Fangrui Song <maskray@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 15 Aug 2024 13:39:23 +0800
In-Reply-To: <20240815032614.2747224-1-maskray@google.com>
References: <20240815032614.2747224-1-maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 20:26 -0700, Fangrui Song wrote:
> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
> obsoleted for more than one decade in many Linux distributions.
>=20
> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>=20
> Signed-off-by: Fangrui Song <maskray@google.com>

Tested-by: Xi Ruoyao <xry111@xry111.site>

> ---
> =C2=A0tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++---=
---
> =C2=A01 file changed, 79 insertions(+), 26 deletions(-)
>=20
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/se=
lftests/vDSO/parse_vdso.c
> index 4ae417372e9e..35cb545da13e 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -47,6 +47,7 @@ static struct vdso_info
> =C2=A0	/* Symbol table */
> =C2=A0	ELF(Sym) *symtab;
> =C2=A0	const char *symstrings;
> +	ELF(Word) *gnu_hash;
> =C2=A0	ELF(Word) *bucket, *chain;
> =C2=A0	ELF(Word) nbucket, nchain;
> =C2=A0
> @@ -75,6 +76,16 @@ static unsigned long elf_hash(const char *name)
> =C2=A0	return h;
> =C2=A0}
> =C2=A0
> +static uint32_t gnu_hash(const char *name)
> +{
> +	const unsigned char *s =3D (void *)name;
> +	uint32_t h =3D 5381;
> +
> +	for (; *s; s++)
> +		h +=3D h * 32 + *s;
> +	return h;
> +}
> +
> =C2=A0void vdso_init_from_sysinfo_ehdr(uintptr_t base)
> =C2=A0{
> =C2=A0	size_t i;
> @@ -117,6 +128,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
> =C2=A0	 */
> =C2=A0	ELF(Word) *hash =3D 0;
> =C2=A0	vdso_info.symstrings =3D 0;
> +	vdso_info.gnu_hash =3D 0;
> =C2=A0	vdso_info.symtab =3D 0;
> =C2=A0	vdso_info.versym =3D 0;
> =C2=A0	vdso_info.verdef =3D 0;
> @@ -137,6 +149,11 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
> =C2=A0				((uintptr_t)dyn[i].d_un.d_ptr
> =C2=A0				 + vdso_info.load_offset);
> =C2=A0			break;
> +		case DT_GNU_HASH:
> +			vdso_info.gnu_hash =3D
> +				(ELF(Word) *)((uintptr_t)dyn[i].d_un.d_ptr +
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdso_info.load_offset);
> +			break;
> =C2=A0		case DT_VERSYM:
> =C2=A0			vdso_info.versym =3D (ELF(Versym) *)
> =C2=A0				((uintptr_t)dyn[i].d_un.d_ptr
> @@ -149,17 +166,26 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
> =C2=A0			break;
> =C2=A0		}
> =C2=A0	}
> -	if (!vdso_info.symstrings || !vdso_info.symtab || !hash)
> +	if (!vdso_info.symstrings || !vdso_info.symtab ||
> +	=C2=A0=C2=A0=C2=A0 (!hash && !vdso_info.gnu_hash))
> =C2=A0		return;=C2=A0 /* Failed */
> =C2=A0
> =C2=A0	if (!vdso_info.verdef)
> =C2=A0		vdso_info.versym =3D 0;
> =C2=A0
> =C2=A0	/* Parse the hash table header. */
> -	vdso_info.nbucket =3D hash[0];
> -	vdso_info.nchain =3D hash[1];
> -	vdso_info.bucket =3D &hash[2];
> -	vdso_info.chain =3D &hash[vdso_info.nbucket + 2];
> +	if (vdso_info.gnu_hash) {
> +		vdso_info.nbucket =3D vdso_info.gnu_hash[0];
> +		/* The bucket array is located after the header (4 uint32) and the blo=
om
> +		=C2=A0=C2=A0 filter (size_t array of gnu_hash[2] elements). */
> +		vdso_info.bucket =3D vdso_info.gnu_hash + 4 +
> +				=C2=A0=C2=A0 sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
> +	} else {
> +		vdso_info.nbucket =3D hash[0];
> +		vdso_info.nchain =3D hash[1];
> +		vdso_info.bucket =3D &hash[2];
> +		vdso_info.chain =3D &hash[vdso_info.nbucket + 2];
> +	}
> =C2=A0
> =C2=A0	/* That's all we need. */
> =C2=A0	vdso_info.valid =3D true;
> @@ -203,6 +229,26 @@ static bool vdso_match_version(ELF(Versym) ver,
> =C2=A0		&& !strcmp(name, vdso_info.symstrings + aux->vda_name);
> =C2=A0}
> =C2=A0
> +static bool check_sym(ELF(Sym) *sym, ELF(Word) i, const char *name,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *version, unsigned long ver_=
hash)
> +{
> +	/* Check for a defined global or weak function w/ right name. */
> +	if (ELF64_ST_TYPE(sym->st_info) !=3D STT_FUNC)
> +		return false;
> +	if (ELF64_ST_BIND(sym->st_info) !=3D STB_GLOBAL &&
> +	=C2=A0=C2=A0=C2=A0 ELF64_ST_BIND(sym->st_info) !=3D STB_WEAK)
> +		return false;
> +	if (strcmp(name, vdso_info.symstrings + sym->st_name))
> +		return false;
> +
> +	/* Check symbol version. */
> +	if (vdso_info.versym &&
> +	=C2=A0=C2=A0=C2=A0 !vdso_match_version(vdso_info.versym[i], version, ve=
r_hash))
> +		return false;
> +
> +	return true;
> +}
> +
> =C2=A0void *vdso_sym(const char *version, const char *name)
> =C2=A0{
> =C2=A0	unsigned long ver_hash;
> @@ -210,29 +256,36 @@ void *vdso_sym(const char *version, const char *nam=
e)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	ver_hash =3D elf_hash(version);
> -	ELF(Word) chain =3D vdso_info.bucket[elf_hash(name) % vdso_info.nbucket=
];
> +	ELF(Word) i;
> =C2=A0
> -	for (; chain !=3D STN_UNDEF; chain =3D vdso_info.chain[chain]) {
> -		ELF(Sym) *sym =3D &vdso_info.symtab[chain];
> +	if (vdso_info.gnu_hash) {
> +		uint32_t h1 =3D gnu_hash(name), h2, *hashval;
> =C2=A0
> -		/* Check for a defined global or weak function w/ right name. */
> -		if (ELF64_ST_TYPE(sym->st_info) !=3D STT_FUNC)
> -			continue;
> -		if (ELF64_ST_BIND(sym->st_info) !=3D STB_GLOBAL &&
> -		=C2=A0=C2=A0=C2=A0 ELF64_ST_BIND(sym->st_info) !=3D STB_WEAK)
> -			continue;
> -		if (sym->st_shndx =3D=3D SHN_UNDEF)
> -			continue;
> -		if (strcmp(name, vdso_info.symstrings + sym->st_name))
> -			continue;
> -
> -		/* Check symbol version. */
> -		if (vdso_info.versym
> -		=C2=A0=C2=A0=C2=A0 && !vdso_match_version(vdso_info.versym[chain],
> -					=C2=A0=C2=A0 version, ver_hash))
> -			continue;
> -
> -		return (void *)(vdso_info.load_offset + sym->st_value);
> +		i =3D vdso_info.bucket[h1 % vdso_info.nbucket];
> +		if (i =3D=3D 0)
> +			return 0;
> +		h1 |=3D 1;
> +		hashval =3D vdso_info.bucket + vdso_info.nbucket +
> +			=C2=A0 (i - vdso_info.gnu_hash[1]);
> +		for (;; i++) {
> +			ELF(Sym) *sym =3D &vdso_info.symtab[i];
> +			h2 =3D *hashval++;
> +			if (h1 =3D=3D (h2 | 1) &&
> +			=C2=A0=C2=A0=C2=A0 check_sym(sym, i, name, version, ver_hash))
> +				return (void *)(vdso_info.load_offset +
> +						sym->st_value);
> +			if (h2 & 1)
> +				break;
> +		}
> +	} else {
> +		i =3D vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
> +		for (; i; i =3D vdso_info.chain[i]) {
> +			ELF(Sym) *sym =3D &vdso_info.symtab[i];
> +			if (sym->st_shndx !=3D SHN_UNDEF &&
> +			=C2=A0=C2=A0=C2=A0 check_sym(sym, i, name, version, ver_hash))
> +				return (void *)(vdso_info.load_offset +
> +						sym->st_value);
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

