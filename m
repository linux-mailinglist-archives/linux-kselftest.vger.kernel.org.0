Return-Path: <linux-kselftest+bounces-14880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8B79498D3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 22:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F251C21A7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD5811F7;
	Tue,  6 Aug 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss93FVLv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741938DD8;
	Tue,  6 Aug 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975037; cv=none; b=Gejqt7cBrnUNJwWOCGUUuZ9iL74c0mFL42s1gmbP3xpTbeh2E4u/d+3JisS3i1sgv2BakmibINouJme2ZdtbwHRb8Meok2KceGj6anBt2Z3aWrDMZVR7BOcMYiz0Jj2VTdy7fG3jAdUJe8Uu7GAZQtd+TjpAW9A4CZVHfIQZdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975037; c=relaxed/simple;
	bh=SSiLomxL//zY67+OfrSfJCKDltG7KAmpSaLz5hXWlqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOpUTN7sfx/COEib+LiOD/DKofr5reJD44BfBkv8PQ1MA/h/o2N3OgAYXHMeR4fWHNgr2hOsu0VEFPdngccFpqQNBx8dgL/gY3fz2yEtPrz+E0r2X6bBdQaQE05oOT23gjYmbzn5y0ihAcpWeGCVgdb56+9ebbbtH2/CHnsF3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss93FVLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD94BC32786;
	Tue,  6 Aug 2024 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722975037;
	bh=SSiLomxL//zY67+OfrSfJCKDltG7KAmpSaLz5hXWlqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ss93FVLv34StJ+xuJI6MJltQ2GcdU2Etb2vuw+r1BM+KEW1PgHFl+Z2OctLjEoA9y
	 IGI7Ox6GVVB1AHVRC6hqRfuTi5NuqXLVFOhyJiQKOmI9DteEvT7WADraJBZW5uc2Z1
	 GpqWX1VuyA/m2mlNBTJBHgSv5hRi5MPau+3fVx4z6wjoUBvo2Sacd86I28v5AEYFn/
	 wE2HRR7hbV4kKWABcgIUJPPF3nE5BlH3PBgTg1ZT1RJ46bb3WWoi7bQ1FHR6whAh8X
	 0yI4xPaMfcGSZeAgqq3phenE6XpCe0lpCjNuZw1voIH3VtXW+//7d38Tga56O+Qr0O
	 AKcF9NUpy5zmw==
Date: Tue, 6 Aug 2024 21:10:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v7 9/9] selftests/clone3: Test shadow stack support
Message-ID: <b172c2c1-42d3-4c50-8065-9bd4ae21ffea@sirena.org.uk>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A4C5k1PZaqbvidwo"
Content-Disposition: inline
In-Reply-To: <202408052046.00BC7CBC@keescook>
X-Cookie: One picture is worth 128K words.


--A4C5k1PZaqbvidwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 08:54:54PM -0700, Kees Cook wrote:

>   # Running test 'Shadow stack on system with shadow stack'
>   # [5496] Trying clone3() with flags 0 (size 0)
>   # I am the parent (5496). My child's pid is 5505
>   # Child exited with signal 11
>   # [5496] clone3() with flags says: 11 expected 0
>   # [5496] Result (11) is different than expected (0)
>   not ok 20 Shadow stack on system with shadow stack

> The child segfaults immediately, it seems?

Does this help:

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 1755fa21e6fb..27acbdf44c5f 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -198,13 +198,14 @@ int arch_shstk_post_fork(struct task_struct *t, struc=
t kernel_clone_args *args)
 	 * the token 64-bit.
 	 */
 	struct mm_struct *mm;
-	unsigned long addr;
+	unsigned long addr, ssp;
 	u64 expected;
 	u64 val;
-	int ret =3D -EINVAL;;
+	int ret =3D -EINVAL;
=20
-	addr =3D args->shadow_stack + args->shadow_stack_size - sizeof(u64);
-	expected =3D (addr - SS_FRAME_SIZE) | BIT(0);
+	ssp =3D args->shadow_stack + args->shadow_stack_size;
+	addr =3D ssp - SS_FRAME_SIZE;
+	expected =3D ssp | BIT(0);
=20
 	mm =3D get_task_mm(t);
 	if (!mm)

--A4C5k1PZaqbvidwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaygzQACgkQJNaLcl1U
h9B6Xwf/UaYSzrSa86cliyUv9R+kMDZyJtEseOLNm/iYYkVCDJsd9eDaXt2NIaLj
BvGnXKy8+G7KT6n4qkCHFFajGljl9yKWMchEyF2R9St1XWH8rcu4YXfoOxpy4Axo
BbQFDUVksmQg+/+NsuTOrd9mWDKfh+tOFN4yuImGcR5prKaXEnP8+wWcJrkswdxD
kl0AnUXB1cW6a5tMmdgIuA4csSQIFWQjiKg2BBqd29otKX58tM1zReYV+46v1CsP
l7B811tIonjJncQlRdD+XQWiJZk+VNTE0+u6qWhulrAqRIMp99lugsN1Z7Puv8WN
e9MAhZDjlEAOppyR3AuZgrZCrp9/jA==
=2dt8
-----END PGP SIGNATURE-----

--A4C5k1PZaqbvidwo--

