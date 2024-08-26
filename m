Return-Path: <linux-kselftest+bounces-16230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75995E847
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163E7281811
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736E80BFF;
	Mon, 26 Aug 2024 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="fQFdskyc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAA63D;
	Mon, 26 Aug 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652462; cv=none; b=dTtosh1RBURCh1eVz6IUUf3EvLJZPk7ZfLLk8ILUjM2pEhh+bBBIwKVJoPQBgNwzwt4xnXW2ceqbEwi2FglAbQY3xHM0QZThHx94EX42T27Wa0+Bf9Iz010f7rSo/l+lV7SLdlkBQknwtmy1+JIXPOdzlebhM3PhmUqk5hroPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652462; c=relaxed/simple;
	bh=+eROQScU0/a8UGd0Dnf21It+bvVcLGRPthRcv3bwE+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QafUgDK9SbicYgwgrQgnkFP95M2cg6BhGtPGQqtJ3O7CP/m+e27i6i3UNCsHccXPXh3nxOxQARutLnKAyRy7NJkVDjPn09i0BzAbm/rP3L9qX4yJ0PcUaDuHxCFumoQx4yftJdjZOkSNsB8R5vY12x8xy6+9qUwTI32sXyQAQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=fQFdskyc; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724652453;
	bh=+eROQScU0/a8UGd0Dnf21It+bvVcLGRPthRcv3bwE+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fQFdskycP3pmcrNiqZMVj79JVAwZ6bhA7FfvZBKcsYghTU9tZkDMYcFlmbx2r1sKp
	 p5mDhaJDWvKlgnuKN7c5rQTWlCEwqpS/oEQmMX7CmcLELYB/ZzPx49aFW26NIA9zNl
	 5mm9+shFb8RhZ3ELpv6T/9yoQyfEBNwGw+okVB54=
Received: from [IPv6:240e:358:115d:1f00:dc73:854d:832e:2] (unknown [IPv6:240e:358:115d:1f00:dc73:854d:832e:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 6CE6266F26;
	Mon, 26 Aug 2024 02:07:30 -0400 (EDT)
Message-ID: <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
Subject: Re: [PATCH] selftests/vDSO: support DT_GNU_HASH
From: Xi Ruoyao <xry111@xry111.site>
To: Fangrui Song <maskray@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 26 Aug 2024 14:07:24 +0800
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
> ---

Ping.

Some context: I'd change LoongArch vDSO to use the toolchain default
instead of forcing DT_HASH (note that LoongArch is launched decades
after all major distros switched to DT_GNU_HASH), but without the
selftest support we'll lose test coverage.

And now ARM64 has already lost test coverage after commit 48f6430505c0.

> =C2=A0tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++---=
--
> -
> =C2=A01 file changed, 79 insertions(+), 26 deletions(-)
>=20
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c
> b/tools/testing/selftests/vDSO/parse_vdso.c
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
> +				(ELF(Word)
> *)((uintptr_t)dyn[i].d_un.d_ptr +
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
> +		/* The bucket array is located after the header (4
> uint32) and the bloom
> +		=C2=A0=C2=A0 filter (size_t array of gnu_hash[2] elements). */
> +		vdso_info.bucket =3D vdso_info.gnu_hash + 4 +
> +				=C2=A0=C2=A0 sizeof(size_t) / 4 *
> vdso_info.gnu_hash[2];
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
> =C2=A0		&& !strcmp(name, vdso_info.symstrings + aux-
> >vda_name);
> =C2=A0}
> =C2=A0
> +static bool check_sym(ELF(Sym) *sym, ELF(Word) i, const char *name,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *version, unsigned long ver_=
hash)
> +{
> +	/* Check for a defined global or weak function w/ right name.
> */
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
> +	=C2=A0=C2=A0=C2=A0 !vdso_match_version(vdso_info.versym[i], version,
> ver_hash))
> +		return false;
> +
> +	return true;
> +}
> +
> =C2=A0void *vdso_sym(const char *version, const char *name)
> =C2=A0{
> =C2=A0	unsigned long ver_hash;
> @@ -210,29 +256,36 @@ void *vdso_sym(const char *version, const char
> *name)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	ver_hash =3D elf_hash(version);
> -	ELF(Word) chain =3D vdso_info.bucket[elf_hash(name) %
> vdso_info.nbucket];
> +	ELF(Word) i;
> =C2=A0
> -	for (; chain !=3D STN_UNDEF; chain =3D vdso_info.chain[chain]) {
> -		ELF(Sym) *sym =3D &vdso_info.symtab[chain];
> +	if (vdso_info.gnu_hash) {
> +		uint32_t h1 =3D gnu_hash(name), h2, *hashval;
> =C2=A0
> -		/* Check for a defined global or weak function w/
> right name. */
> -		if (ELF64_ST_TYPE(sym->st_info) !=3D STT_FUNC)
> -			continue;
> -		if (ELF64_ST_BIND(sym->st_info) !=3D STB_GLOBAL &&
> -		=C2=A0=C2=A0=C2=A0 ELF64_ST_BIND(sym->st_info) !=3D STB_WEAK)
> -			continue;
> -		if (sym->st_shndx =3D=3D SHN_UNDEF)
> -			continue;
> -		if (strcmp(name, vdso_info.symstrings + sym-
> >st_name))
> -			continue;
> -
> -		/* Check symbol version. */
> -		if (vdso_info.versym
> -		=C2=A0=C2=A0=C2=A0 && !vdso_match_version(vdso_info.versym[chain],
> -					=C2=A0=C2=A0 version, ver_hash))
> -			continue;
> -
> -		return (void *)(vdso_info.load_offset + sym-
> >st_value);
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
> +			=C2=A0=C2=A0=C2=A0 check_sym(sym, i, name, version,
> ver_hash))
> +				return (void *)(vdso_info.load_offset
> +
> +						sym->st_value);
> +			if (h2 & 1)
> +				break;
> +		}
> +	} else {
> +		i =3D vdso_info.bucket[elf_hash(name) %
> vdso_info.nbucket];
> +		for (; i; i =3D vdso_info.chain[i]) {
> +			ELF(Sym) *sym =3D &vdso_info.symtab[i];
> +			if (sym->st_shndx !=3D SHN_UNDEF &&
> +			=C2=A0=C2=A0=C2=A0 check_sym(sym, i, name, version,
> ver_hash))
> +				return (void *)(vdso_info.load_offset
> +
> +						sym->st_value);
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

