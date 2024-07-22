Return-Path: <linux-kselftest+bounces-13983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E648938832
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 06:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C169D1C20C9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE38171AA;
	Mon, 22 Jul 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGK3GXQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE08BFC;
	Mon, 22 Jul 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721624258; cv=none; b=NVU4GBhJinA3+f51mnyVhjKjipQEvDh1UtWEoM4BueROqBnjKsm/jFJ01DV/dnRz+qckYrXixarUF3hUTbkiz1lpdA59cPYa3eWN5zAb0T7qiBeuNqxHtE4PEEbT7VRhMLdxmTwK9TY+KzmE0+OC01SqnIrDGUbYD6e4GZSm4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721624258; c=relaxed/simple;
	bh=EffWJCJWTHLmJnAHT6Ac6+Vnyib2j7zgkQknG7DKlM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aecO6x+LlwCHoZIy/U6KwpAL9lWcNy1aA33TUByh2nOWzFlmtOsdCORkdDch8Lqxr6FrxR4FuKG3zkBVapnVG8TFfdcHqhrHXC1MNb2MY5vVmTTne0A6x7ah6q+HTi4gr8Jk0gEfT9FPAwnjI/V0xN1JS4cFNCmKoZx/AlYmS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGK3GXQZ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-260f4c9dfe2so1759466fac.0;
        Sun, 21 Jul 2024 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721624256; x=1722229056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmEwT+Coyv+UcBMEGsDoi0+n6MRPLwi4C8KTf2IQTtU=;
        b=BGK3GXQZTIBcWyt38Gww+PmTa6+32qcJY5jxUF/t+6H2VH/J/vhLKpKq8tJzB9VZ4X
         IpVkp+RjqW5V1GyxU0p3G6EXdITuPEYDbhMWDDAhVtnvlmpbWxqVRrAzQG+5w4/1l+KO
         OI1mqtUbz5QLVfv+H2REOe9YFDQYjMq70II3IpOYCfyKvdF4p2oZmnondlPvz375+Ko9
         lKWUCSLqm4yT4t6N+Z7OVElIrGuv8x/hFFpxLI94zTjzY4mB14oZbN7lJiolpDkAwCQ8
         5f7LsTX4pVP47cm5lr2Ti1PsnJmZGJUkBgTzgTlapRWR4ToY09u2jN0eN84SL+jxGiiW
         I1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721624256; x=1722229056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmEwT+Coyv+UcBMEGsDoi0+n6MRPLwi4C8KTf2IQTtU=;
        b=aLeZ391vNS9nr+SqVFO99tj0+AbCU33QBpkzu00OAeoWcI/T8krBju8Tq+k6TM7y6P
         vNYJL4Va2NMnerYjI+pVCQrENa7vdvkd/iQSjudXl2mvMhE0t9ANx/2yhS1a1gONW5ub
         8plUw0dXgmXsJv7AZs01Yv1fjpk7mzQr4cR7N+8eKrR6fTzpX5taJ/wO4nPA3s850oUO
         kA7B5u8mqCUwWPRWFnv2rwdgHn/biAf2GCvgLmCAP8tSNeeLDZwgPq2bud7eRSsOyHnX
         7XTUqFPetqDVWR3ZBk4QmDTyrXuz1a72ZItpy9mUi3OFs//ff+LdJEAZnsneCrxA5qJQ
         dAlg==
X-Forwarded-Encrypted: i=1; AJvYcCW+dDhAp/dY0FcDQs8WQFDOeGXbUldIDrp2F9ORfBhND9P2zoWlcddrsTIfiQHb8MEB2gncjW4LnRo5Pbl2uAbhm16ANMZyhqyHv6mUmsRQKAANc0kpioHK/nlhZp/cG/g0Qq9TXZFTPUo1fxKR
X-Gm-Message-State: AOJu0YxFAWvLdJ2WdvBnHVAXS0BX8dOJELGfTdTLhWnSoRaCON1ovJXb
	yyOmYS7ngLbakvxe3si6cyT84cfsfDfwQE0MiYFPeLYuC7p4CZqqBeATvumpvnZVrPMIdAttDOX
	0SIT/Ad5ao40uP1/t2FaTc9b9WZY=
X-Google-Smtp-Source: AGHT+IG+TyR9WaS5pduZzBveMPWvj0g+FCryKlb2QaRBPI3LzkTJiKwc50G+cBZlyl8TrmMuBI5j4YDuUsCagg8wTIk=
X-Received: by 2002:a05:6870:350e:b0:260:e404:6c88 with SMTP id
 586e51a60fabf-26121d3e53fmr3546724fac.20.1721624255739; Sun, 21 Jul 2024
 21:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720063937.2311958-2-davidgow@google.com>
In-Reply-To: <20240720063937.2311958-2-davidgow@google.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Mon, 22 Jul 2024 12:57:24 +0800
Message-ID: <CAFUsyfKYKsO6krUoa0YYe_hsWqVgZazRXmj7AiBN0LpkaW01NA@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86: checksum: Fix unaligned checksums on < i686
To: David Gow <davidgow@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 2:40=E2=80=AFPM David Gow <davidgow@google.com> wro=
te:
>
> The checksum_32 code was originally written to only handle 2-byte
> aligned buffers, but was later extended to support arbitrary alignment.
> However, the non-PPro variant doesn't apply the carry before jumping to
> the 2- or 4-byte aligned versions, which clear CF.
>
> This causes the new checksum_kunit test to fail, as it runs with a large
> number of different possible alignments and both with and without
> carries.
>
> For example:
> ./tools/testing/kunit/kunit.py run --arch i386 --kconfig_add CONFIG_M486=
=3Dy checksum
> Gives:
>     KTAP version 1
>     # Subtest: checksum
>     1..3
>     ok 1 test_csum_fixed_random_inputs
>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.=
c:267
>     Expected result =3D=3D expec, but
>         result =3D=3D 65281 (0xff01)
>         expec =3D=3D 65280 (0xff00)
>     not ok 2 test_csum_all_carry_inputs
>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c=
:314
>     Expected result =3D=3D expec, but
>         result =3D=3D 65535 (0xffff)
>         expec =3D=3D 65534 (0xfffe)
>     not ok 3 test_csum_no_carry_inputs
>
> With this patch, it passes.
>     KTAP version 1
>     # Subtest: checksum
>     1..3
>     ok 1 test_csum_fixed_random_inputs
>     ok 2 test_csum_all_carry_inputs
>     ok 3 test_csum_no_carry_inputs
>
> I also tested it on a real 486DX2, with the same results.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Re-sending this from [1]. While there's an argument that the whole
> 32-bit checksum code could do with rewriting, it's:
> (a) worth fixing before someone takes the time to rewrite it, and
> (b) worth any future rewrite starting from a point where the tests pass
>
> I don't think there should be any downside to this fix: it only affects
> ancient computers, and adds a single instruction which isn't in a loop.
>
> Cheers,
> -- David
>
> [1]: https://lore.kernel.org/lkml/20230704083206.693155-2-davidgow@google=
.com/
>
> ---
>  arch/x86/lib/checksum_32.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
> index 68f7fa3e1322..a5123b29b403 100644
> --- a/arch/x86/lib/checksum_32.S
> +++ b/arch/x86/lib/checksum_32.S
> @@ -62,6 +62,7 @@ SYM_FUNC_START(csum_partial)
>         jl 8f
>         movzbl (%esi), %ebx
>         adcl %ebx, %eax
> +       adcl $0, %eax
>         roll $8, %eax
>         inc %esi
>         testl $2, %esi
> --
> 2.45.2.1089.g2a221341d9-goog
>

I'm not maintainer but LGTM.

Reviewed-by: Noah Goldstein <goldstein.w.n@gmail.com>

