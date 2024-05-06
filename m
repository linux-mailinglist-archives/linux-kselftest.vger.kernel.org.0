Return-Path: <linux-kselftest+bounces-9545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC0C8BD3E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DF3B2289A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9D157A43;
	Mon,  6 May 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfONo+X3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1A41C77
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016889; cv=none; b=FY+YEClGjr7Yk81GAWYnSvi5Bw4oGCzWIX8Yes0ggZ7wwg2CVXO7CEvsuYDlAiIGHIvuJq7qMOxBLFikeMj3oEOc+VsGOONjTcpVFfHeSPeI485Xo6bJywhZ31PGcxxD8sD4IOfYpi6Kuz+GPSBfYu6yETrOOXH3foA71+V5h1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016889; c=relaxed/simple;
	bh=TI5DRoryTSvM2Mo1Mcc+qwJ+bi6PRG7slThxsyfLRog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDrIJejmKS6+vpTBL6DIHbI5Otg+FIym8RF08t1yXvZK5kdCXhLd4kQkFjaE0p47ls8M5op7ojzb12bw8bfueQ2j7S31WaZZWb7mza+18fdtMjm7JB8vOxUDgbDRnXlXexeEQ6l1BK9V4N/eNHc1lLFqM11zIcCtzA0TWV/FdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfONo+X3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso1144a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715016885; x=1715621685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAx91jBQp8b9D9u8QWwgtb//mlM/+KKl3bZWksOtlc8=;
        b=cfONo+X34DgG+3wPAIfw+Bxk4oumNwWgLl1boqBu4NhVEyhKzUlxIH+ahtheTQLM+A
         eVeZeNWWoUCQV93CbgBtBAcM/824X/WPg4A2YuvZYgSvmEH8ZHamFx9smgGa5+yTZLEw
         R9aWFGm8MQCHn5sFG/25uwnFdDDcUHaBdA+uTyyLYYJL6Z3SJlR7ThNBpGkRv1EBZan3
         jn8+RanhDrx6d9Ckfn5FgsSAbnCVZdkMesiqeOSRnpzcCEGL3rjc2eKys+sLeSTdNRv7
         Dnh0k0z0iV4rCqkllytSscLuqakoV2ElNTUJ31tQ13PEWTOzLlBgwZUClZ4Q9N8HpH7v
         4OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016885; x=1715621685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAx91jBQp8b9D9u8QWwgtb//mlM/+KKl3bZWksOtlc8=;
        b=admxkdrIIqO2Iz/vLbmD/6c8G9PozvDzDHsqCohy/UEO860PrmKF9WTPp8MsaGZ7FO
         aF23jlSdIl2vy6JT1GCaLhgwBYUy6M1ddphaaOCLDhkq61Mez6dlGxFr7EJUrxT5pO/B
         i4AZ3d+o0zVbsT8x4bqzApNGnit7iMkRTEXpGyCc3XDXu7d4H2HejdpSmqxvHNl400BW
         m3GmH7r6lO2soYwmoaHe+LGPnaGPnC+jlDM1xqEcljdVlW/7P6qzDRMoqLSbO7/uLzfC
         vBqKC3QNVL2kCgb4jghlBuJ1gbceCda5R3f9qYqt5JvGRZlH3kTDjt4AMOieU7xXGGTf
         YYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBstyN9X7ZC/BkH3n6yoLyfJROWN+VNIVP+gsT//J8xD0FSRZziVza+ZFGLJXN235LfhmCQtpegYDwWhqIyuq8JhU/O9irEJVOv/TonPco
X-Gm-Message-State: AOJu0YxaWe63LV8aFwPa44+whK1kZd+8ehzyga2EOKK6HCEKXLt1LddY
	7sj2uYx7aR4IBefdjxuKgjsQ9xwml9pf0bE6rEb9mVmFJGQqunBhE7cSaBdlSXSI5zyArlUOi8/
	tmC+Kf/sfGNck9l5boVUFtXs8/HmhEgBvqfpx
X-Google-Smtp-Source: AGHT+IHjg392EHjEwddfHI/2Y3LFhkNgzJzNtK3yboLc4F8Z0MarAFd5M8O7Vs9QWsYnjhEWlcgHfrTLnkJYuegmefE=
X-Received: by 2002:a05:6402:1343:b0:573:8b4:a0a6 with SMTP id
 4fb4d7f45d1cf-57308b4a0ccmr93285a12.5.1715016884637; Mon, 06 May 2024
 10:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501180622.1676340-1-edliaw@google.com> <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
 <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com> <CAFhGd8rAW4Mkctq5VkcfVjw_yr=jVdXaWbYXP-vmeVpw7q4ruQ@mail.gmail.com>
In-Reply-To: <CAFhGd8rAW4Mkctq5VkcfVjw_yr=jVdXaWbYXP-vmeVpw7q4ruQ@mail.gmail.com>
From: Edward Liaw <edliaw@google.com>
Date: Mon, 6 May 2024 10:34:17 -0700
Message-ID: <CAG4es9WYrN_tOV1Uxi_ytO2qDRRZW5_uN=2p3iCg=P0r3mM3Og@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for elf_hash
To: Justin Stitt <justinstitt@google.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kernel-team@android.com" <kernel-team@android.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:16=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> On Sun, May 5, 2024 at 6:21=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
> >
> > From: Justin Stitt
> > > Sent: 01 May 2024 20:55
> > ...
> > > > static unsigned long elf_hash(const unsigned char *name)
> > ...
> > > Is it possible to just change the types of the parameters of vdso_sym=
()
> > > or does that trigger even more warnings on the callsites of vdso_sym(=
)?
> >
> > Isn't the problem the definition of elf_hash()?
> > A '\0' terminated string really ought to be 'char *' not 'unsigned char=
 *'.
>
> Right, although note this comment just about its definition:
>
> /* Straight from the ELF specification. */
> static unsigned long elf_hash(const unsigned char *name)
> {
>
> which indeed matches [1]
>
> [1]: https://man.freebsd.org/cgi/man.cgi?query=3Delf_hash&sektion=3D3&apr=
opos=3D0&manpath=3DFreeBSD+7.1-RELEASE

How about I move the type cast into elf_hash, like libelf does
https://sourceforge.net/p/elftoolchain/code/HEAD/tree/trunk/libelf/elf_hash=
.c#l47

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c
b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..33db8abd7d59 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -56,12 +56,15 @@ static struct vdso_info
 } vdso_info;

 /* Straight from the ELF specification. */
-static unsigned long elf_hash(const unsigned char *name)
+static unsigned long elf_hash(const char *name)
 {
  unsigned long h =3D 0, g;
- while (*name)
+ const unsigned char *s;
+
+ s =3D (const unsigned char *) name;
+ while (*s)
  {
- h =3D (h << 4) + *name++;
+ h =3D (h << 4) + *s++;
  if (g =3D h & 0xf0000000)
  h ^=3D g >> 24;
  h &=3D ~g;


>
> >
> >         David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
> >

