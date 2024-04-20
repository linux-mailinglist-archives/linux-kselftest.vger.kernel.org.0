Return-Path: <linux-kselftest+bounces-8511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2E8AB817
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D0281C18
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7238C;
	Sat, 20 Apr 2024 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7/sdj+4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D3205E01
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713572308; cv=none; b=J8ntp7tHKbc0YPSpf4ovGn8iDorEMDCSx1UaTYxcV9V3vnahbxZU12HgWGxUub9jBYQArQaFOyqWu3Q7MlzLEFkl162ppzkDl9GpIV3E8WrbBllXasRwikLKp7duKpUVzKeoykmX0igvwxPUIzZMcvULRpcomOQ86gh3qXV+J2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713572308; c=relaxed/simple;
	bh=fQoWB19QMHOL27Xm5o/jbBLShMYJ5XHwCttfdyu9bSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDDnq1ce+/kH+cT40eAKlRJKOLGj0uKRB+kh5ppr+Lvf5osa+O/mU2L9vZxqL88rSp3G7j9cVugO6xjVzoF25bp9bY5U3b7Av7U9OKAmmgvzbd7h+oY3JPgfRQYJtLRpsNEyQB6hK0IuGKw/IzDsCwtrqCr9iwzQV8NAvgB0cwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l7/sdj+4; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa4204bacdso1524630eaf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713572306; x=1714177106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Utwg+qjcE38+IyUfoRG8C+DfQnQvtcdo0oDB6zO9Hc=;
        b=l7/sdj+424kWCLuCgci51PGFkI95JekcCVaW155zCRHdPFfqzaMROiczxLiayfJUjR
         S+Js7STqyMmMFrqaKdPBOqp1lsAFXE3En6eiFdmKZMNCo4Ms/61ERodShkzc016alrEg
         UxBab3O5XkFkR/s6BaVhuYl6/Ck+JBF1UDveg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713572306; x=1714177106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Utwg+qjcE38+IyUfoRG8C+DfQnQvtcdo0oDB6zO9Hc=;
        b=mtsjgojUpfGARndXNwVBjpS5cxb3V//PORfikOwvLr5tZANZd1wq/redp6PjfnK7YM
         CE6UJYLnGiNARKC/jmlCBwms2TBB30wVetKj+v2WtCEgP33jv7B+wmt67hE2P/H11LoH
         UUWfEXINNDtdu9x8cc3Z3+8eFEr8qTTFGQvpuHGwDqok8+1KIUjtFBF8p53CWTrsx0zp
         ZgomlvPbOMGxX7xUtud7mWmN91Lym+CdZzB6x2DgzWk9hU/TLL6EekHnaSCqf82RrxdU
         dQCeGM8zIC9FzN1xcxn/iZT2wzK7PFWrVFs5RKWvjkwzDiPVCxq1dw+YzqMAVFUQetnS
         322A==
X-Forwarded-Encrypted: i=1; AJvYcCXqHDRm9VwT8ojsa2uILmKSq/1OsM1AgrM8ozqzrW/hLItwbktxUrAWwQtuZd/I56XC7c2pwd5jjpUo7HB8bKkh7yDGeG3Ul82c137uSeoJ
X-Gm-Message-State: AOJu0Yy+Ow8HjStiqdppVlOS3N7J6w5iP7mgp/bRj3pSaZwYlxnm2j4B
	NSMwYnYDUE5zARjJHu9TdCua99qelQbYvc8p5KkSgcMDCxoSiw8AfOykgqoYYBtPMft2q4W355B
	mqBTpfBv3ddYEbHCFKyp6jMtXY7ALkZVGToHx
X-Google-Smtp-Source: AGHT+IETfOV+Jrp5obJ2RdX5EYgUGyMqkEENWK8QW/tSI5x892qaev8gZPWHEJxrnJ8z9joZHBf9wIdf5B+ixtcsb3c=
X-Received: by 2002:a05:6871:6a8:b0:222:5ff6:43f1 with SMTP id
 l40-20020a05687106a800b002225ff643f1mr4720396oao.16.1713572305775; Fri, 19
 Apr 2024 17:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419034350.127838-1-jeffxu@chromium.org> <20240419034350.127838-2-jeffxu@chromium.org>
 <CAKbZUD04B8zK4+eNJ6CYvcrXu1a47aq-q8yPsFLS3Ln515vGMA@mail.gmail.com>
In-Reply-To: <CAKbZUD04B8zK4+eNJ6CYvcrXu1a47aq-q8yPsFLS3Ln515vGMA@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 19 Apr 2024 17:18:14 -0700
Message-ID: <CABi2SkXCZrEEDGuEuVKk9sJ0jwOtLGN1Rgim=dTd-eCKVsATSg@mail.gmail.com>
Subject: Re: [PATCH 1/1] selftest mm/mseal: fix compile warning
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, jeffxu@google.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 9:43=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Fri, Apr 19, 2024 at 4:44=E2=80=AFAM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > fix compile warning reported by test robot
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Closes: https://lore.kernel.org/r/202404190226.OfJOewV8-lkp@intel.com/
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 3 +--
> >  tools/testing/selftests/mm/seal_elf.c   | 3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index 4a326334726d..35cdae93e580 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -79,7 +79,7 @@ static unsigned long get_vma_size(void *addr, int *pr=
ot)
> >                 return 0;
> >
> >         while (fgets(line, sizeof(line), maps)) {
> > -               if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end,=
 &protstr) =3D=3D 3) {
> > +               if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end,=
 (char *) &protstr) =3D=3D 3) {
>
> This fix is wrong. You can simply do:
>
> +               if (sscanf(line, "%lx-%lx %4s", &addr_start,
> &addr_end, protstr) =3D=3D 3) {
>
> and it'll just work (arrays decay to pointers when required).
>
Ya, that is a better fix, I will change that.
Thanks


> >                         if (addr_start =3D=3D (uintptr_t) addr) {
> >                                 size =3D addr_end - addr_start;
> >                                 if (protstr[0] =3D=3D 'r')
> > @@ -208,7 +208,6 @@ static u64 set_pkey_bits(u64 reg, int pkey, u64 fla=
gs)
> >
> >  static void set_pkey(int pkey, unsigned long pkey_value)
> >  {
> > -       unsigned long mask =3D (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRIT=
E);
> >         u64 new_pkey_reg;
> >
> >         new_pkey_reg =3D set_pkey_bits(__read_pkey_reg(), pkey, pkey_va=
lue);
> > diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/self=
tests/mm/seal_elf.c
> > index 7143dc4f1b10..b7e72f9804f8 100644
> > --- a/tools/testing/selftests/mm/seal_elf.c
> > +++ b/tools/testing/selftests/mm/seal_elf.c
> > @@ -105,7 +105,6 @@ static void test_seal_elf(void)
> >         int ret;
> >         FILE *maps;
> >         char line[512];
> > -       int size =3D 0;
> >         uintptr_t  addr_start, addr_end;
> >         char prot[5];
> >         char filename[256];
> > @@ -136,7 +135,7 @@ static void test_seal_elf(void)
> >          */
> >         while (fgets(line, sizeof(line), maps)) {
> >                 if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u %255[^\n]=
",
> > -                       &addr_start, &addr_end, &prot, &filename) =3D=
=3D 4) {
> > +                       &addr_start, &addr_end, (char *)&prot, (char *)=
&filename) =3D=3D 4) {
>
> aaand same here.
>
> --
> Pedro

