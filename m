Return-Path: <linux-kselftest+bounces-9540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6828BD3B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A46E284D67
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CC157469;
	Mon,  6 May 2024 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqINxCSe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAE13DDD2
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015775; cv=none; b=doOX9t+AO9Uq1828i74WMCs0BuUgnSOf1VWwrWLqXIZ2HOFu946nh9UITD5aEPdHItcDkXXJk5KizhTPwSVKlolqczxNJMHZvo5ZBbPGGgjuPIeQQoWXTH4f3X2CYLuzbgn7d2eXeZg0OrlS4+ejSsR0gBeRrmfnigVCZv8XYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015775; c=relaxed/simple;
	bh=CH8+eM4S1n20YyEYWl0xkpP7fPFGyFDj7hZD+iuKZ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbMvNr6OtCaS3DqTXK/YiKMe33WuyHqJ/Wf9dT296zIm56keZ6CGSDQLlMBi+xjC9MLIwvQldQH+CPwp8GVFx5kf+a+x8lBHy60J5171hRXNycmecF6kjSeC/rfEAblUBK12zgJ+gcL6N6nlrJPobwv8xI2CAI/T7VoTR05s/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqINxCSe; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61be613d903so25012657b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715015773; x=1715620573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KofGXFo7s9xwEHva7ZrVmJtjldE1ogFbG7iHwKVRDOA=;
        b=ZqINxCSe80y6QXEPYUKNdUeFBBAdvKolrppp7RDI/OFz7VaTwxFuvKcdiPseCPpAEL
         uOJEb5pZpvqj7T9n5lDjxWoQO3M6sPzQYdbIIoUlkLVGPpo46gMiue8UGDU0fBwwUuWe
         Mz0hvF6eRPWmb9xlHs6VHAq9MptbPMWP+HqBiIuMisiZuxQO9IsW9ohQg4ryaf2Ej+Ja
         F/6xNWPtSnOIYvGC2hrWoVmYaNvAcTnmJ5n+afohHORfBPhK8u0hzyiSZwkaw2z/w5wr
         hXYA1vGhzjTkUEKL41hxulI3ralpUR0I7OwPD4B17Mpnab/N9HuCxPWrRJHVlvc0cBYS
         UjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715015773; x=1715620573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KofGXFo7s9xwEHva7ZrVmJtjldE1ogFbG7iHwKVRDOA=;
        b=tcUGCN3Qq2lK/OYs7+PnwmM7FH/j9MXznKigaEDuhHrb6mBLAAQDyMznPX8IG2YJO+
         f8LlP0K+C1UQ4cvsXeSxlOnX6JjW86PMZZRr4WohSthuL9riC3bESMuF2dxjSIYRcHXc
         0yM8wROZQ2FU/ijkGRZeUweLmxIQ7Iflbd05kHAPOaJ6qNoaTUzP+0I9JiYaGeZgEYa8
         wH6GrC8I4d6wJNwyuVImMQ2jrxfYZw0k4fCtGQ5IaKaVb6zKzg7YNud5Mhc9nYUnbAIh
         WEqPm4FnFL7fKIyPLLygYfpfnDfW4pj20Dmdh5d734K6i/VUVT+pIZOowZO7HnyGIqM1
         l1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCURqmy/UVUTuIYEXhD3UW26msi+3pqMR9na+KVIMJY7IrAaD13VH8XLF7fcE/mMglnk2W5a9UXnDy/14VblNW7jfCswy0Y4C9o2lLrwcH0G
X-Gm-Message-State: AOJu0Yx3cWZrNKyLhg0JK2vBYoDv/GT9s137l7z+ZdH7zlDUAPPLesRk
	FMySkLFLEwRkWgk9hRjNxGpv2nJQlFVzgsd6ytdzz1iYD4Aa2S4AP3oP1Wg9LgAqoth/UK94tuj
	CDmLeALVp59LrdsF+qc5YqKWW9k/ZRsGMIsW3l1mqI0tGJ/LnukRBjtQ=
X-Google-Smtp-Source: AGHT+IEzpiV/fRSpmds6fIDkQinopcpDSw1n1WY0/LX7bnm5aatstSpU5088BhxTIMAs0gqkQJ3SCI0XZ85AoTU9WjI=
X-Received: by 2002:a25:204:0:b0:de6:4ff:3155 with SMTP id 4-20020a250204000000b00de604ff3155mr11865643ybc.16.1715015772984;
 Mon, 06 May 2024 10:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501180622.1676340-1-edliaw@google.com> <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
 <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com>
In-Reply-To: <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 6 May 2024 10:16:00 -0700
Message-ID: <CAFhGd8rAW4Mkctq5VkcfVjw_yr=jVdXaWbYXP-vmeVpw7q4ruQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for elf_hash
To: David Laight <David.Laight@aculab.com>
Cc: Edward Liaw <edliaw@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kernel-team@android.com" <kernel-team@android.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 6:21=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Justin Stitt
> > Sent: 01 May 2024 20:55
> ...
> > > static unsigned long elf_hash(const unsigned char *name)
> ...
> > Is it possible to just change the types of the parameters of vdso_sym()
> > or does that trigger even more warnings on the callsites of vdso_sym()?
>
> Isn't the problem the definition of elf_hash()?
> A '\0' terminated string really ought to be 'char *' not 'unsigned char *=
'.

Right, although note this comment just about its definition:

/* Straight from the ELF specification. */
static unsigned long elf_hash(const unsigned char *name)
{

which indeed matches [1]

[1]: https://man.freebsd.org/cgi/man.cgi?query=3Delf_hash&sektion=3D3&aprop=
os=3D0&manpath=3DFreeBSD+7.1-RELEASE

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>

