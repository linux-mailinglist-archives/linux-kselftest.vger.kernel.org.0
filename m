Return-Path: <linux-kselftest+bounces-12350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C803D910E6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 19:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D82859E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36281B3F10;
	Thu, 20 Jun 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8cWZnup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203641AF6A9
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904362; cv=none; b=uBZWW99GoHbd+2huOYTmnESZFRAVSNyPog5CoYKreaH5FrIBSxaHok/5adQUEGl8jd08Av9Aj5+mozaCDkut4EFPuEiLXL3PEi/dz/Ld1cGrrk/PbpVdzns2Xw9ujQWcm2TQt7XqHS0yFvScodgRUU5JA9IAIxF3HuR+RjdbK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904362; c=relaxed/simple;
	bh=glgA9OLkXsS5bl3oHprB1pKZFc+XKLwwjPbsEv+eYl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQehqKslKjDnDI9nS5Cp+W2Lt1DUM/71et7jsx4KconHPVMkHWE2YX0tbMN0gNREA+X36hvkRIGEa35Q6Fba3OeLZ8lZfi2xjIyXINFmngYzkWVUVU9/AyquTj58FHj/ia+GCEYJ8vqvnf62WDbbLf3f/3vIcrRHOZbo82DoJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8cWZnup; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36226e98370so702381f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718904359; x=1719509159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiRdU3CBR8zGYesiy4ojjtoIZbVxcxArnAv9h/zGc/U=;
        b=h8cWZnupEE8obqpXy9cPIfHmvzlHaiFS+JV2l+smvkfLL9xdL+Rht64yCQnFaWBhaz
         4fn1ADpDgbO3BWXJI7uXwkbyc3gLgDOGtqeKgJ5sqln+JAlbo8FfUEbTJivsBfEiDMNE
         9wvi8JyKN0ecc3gSJLENKIdU9DEHGsKJSN6HYvktcaYzvSCgwhuc01BEiA2eBqr8PGQe
         YPfbqkHij1TvcpN1Pno7NXozPK1Cs0kbCHDb/owvFzUneEjGdInOvWGGgB9D2/j/RPy6
         GPHJKnSbMWrVfmHxScRPAuihVplGiwY43CtDyUM008j5jTFULuMPTDUd/TVrMq4LdM2H
         mAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904359; x=1719509159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiRdU3CBR8zGYesiy4ojjtoIZbVxcxArnAv9h/zGc/U=;
        b=PtE+iCWOMNCt2L3j1yf2Sm8jtPns6AgTFqpNmfdIb7tpJWfu/dEZ88yW52LKuMAX57
         f1uqK+qt921i9QQBwQ42R4cyzVAVWcpg6JznGm9V2Ot4yR07ou0Wjy4jp4snvc4Rg9mk
         1I5Buv8xqw8PvaeuqzQolSJNnz0NiAwXcdXGy8c3BxCr2rswtYB4HAPWnNQslxgV2xoM
         1LNfp+FtNhm3k/ly1CPnxoZEyKTDo/sZVrkTt/CxdaCHC7sXsWpqEfdhOx4ZqfJhz2Qb
         WTZDcUOYS39dnYSlXt7apdZDUOS4xRztW1Zq08mV0ZwfwvSWud9/haI2XnDS+Ol8RKZE
         LRSg==
X-Forwarded-Encrypted: i=1; AJvYcCWXTK2K85DgVm9ViF7FQBRFIFvs9sXAGCucgbvJbdEVH1BPmQxnuoRK+wJONJ1WDtTTM4ae8lnhDoIqh70P94vIYORtsN9DdMWphYlCa37u
X-Gm-Message-State: AOJu0YxNrdMEbxqxqmFSwFBiEKmku1kCCnpr2t9RHVEMRNcf9B3If9wk
	NYRiGSgmH4Xgp0iqggkkK7MOTCh8Lhts0N9vjaHmwVFZ70sw/eoJ7bmFfESNbvfwnUhYbTdGa4I
	pJ2Rh7kckGEW4MXggNbjDukzs+4UuOdc1o4Vi
X-Google-Smtp-Source: AGHT+IFS97xWUk+8EsMmc1uhOxElvJVojbiwIIcSg3aELt83j6gfs+TQ+RXLkp4YqGbsB9Fb8XO3HZt270xtdpu2z6s=
X-Received: by 2002:a05:6000:e8d:b0:35f:2cd1:a394 with SMTP id
 ffacd0b85a97d-363175b849amr4395583f8f.22.1718904359131; Thu, 20 Jun 2024
 10:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617170545.3820912-1-jiaqiyan@google.com> <20240617170545.3820912-4-jiaqiyan@google.com>
 <ZnJqeQtkMqNaXaMl@localhost.localdomain>
In-Reply-To: <ZnJqeQtkMqNaXaMl@localhost.localdomain>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 20 Jun 2024 10:25:43 -0700
Message-ID: <CACw3F50_xhJ5OBU0sae=fZUz-Syo=QuOpV_6jNTcYGosyEraSQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] docs: mm: add enable_soft_offline sysctl
To: Oscar Salvador <osalvador@suse.de>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	ioworker0@gmail.com, muchun.song@linux.dev, akpm@linux-foundation.org, 
	shuah@kernel.org, corbet@lwn.net, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:20=E2=80=AFPM Oscar Salvador <osalvador@suse.de>=
 wrote:
>
> On Mon, Jun 17, 2024 at 05:05:45PM +0000, Jiaqi Yan wrote:
> > Add the documentation for soft offline behaviors / costs, and what
> > the new enable_soft_offline sysctl is for.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst | 33 +++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/ad=
min-guide/sysctl/vm.rst
> > index e86c968a7a0e..fc62fc272fc5 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -36,6 +36,7 @@ Currently, these files are in /proc/sys/vm:
> >  - dirtytime_expire_seconds
> >  - dirty_writeback_centisecs
> >  - drop_caches
> > +- enable_soft_offline
> >  - extfrag_threshold
> >  - highmem_is_dirtyable
> >  - hugetlb_shm_group
> > @@ -267,6 +268,38 @@ used::
> >  These are informational only.  They do not mean that anything is wrong
> >  with your system.  To disable them, echo 4 (bit 2) into drop_caches.
> >
> > +enable_soft_offline
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Correctable memory errors are very common on servers. Soft-offline is =
kernel's
> > +solution for memory pages having (excessive) corrected memory errors.
> > +
> > +For different types of page, soft-offline has different behaviors / co=
sts.
> > +- For a raw error page, soft-offline migrates the in-use page's conten=
t to
> > +  a new raw page.
> > +- For a page that is part of a transparent hugepage,  soft-offline spl=
its the
> > +  transparent hugepage into raw pages, then migrates only the raw erro=
r page.
> > +  As a result, user is transparently backed by 1 less hugepage, impact=
ing
> > +  memory access performance.
> > +- For a page that is part of a HugeTLB hugepage, soft-offline first mi=
grates
> > +  the entire HugeTLB hugepage, during which a free hugepage will be co=
nsumed
> > +  as migration target.  Then the original hugepage is dissolved into r=
aw
> > +  pages without compensation, reducing the capacity of the HugeTLB poo=
l by 1.
> > +
> > +It is user's call to choose between reliability (staying away from fra=
gile
> > +physical memory) vs performance / capacity implications in transparent=
 and
> > +HugeTLB cases.
> > +
> > +For all architectures, enable_soft_offline controls whether to soft of=
fline
> > +memory pages.  When setting to 1, kernel attempts to soft offline the =
pages
> > +whenever it thinks needed.  When setting to 0, kernel returns EOPNOTSU=
PP to
> > +the request to soft offline the pages.  Its default value is 1.
> > +
> > +It is worth mentioning that after setting enable_soft_offline to 0:
> > +- If RAS Correctable Errors Collector is running, its request to soft =
offline
> > +  pages will fail.
> > +- On ARM, the request to soft offline pages from GHES driver will fail=
.
> > +- On PARISC, the request to soft offline pages from Page Deallocation =
Table
> > +  will fail.
>
> I do not know about others but the 'fail' word feels wrong here.
> I would reword that as "... the request to soft offline pages from
> xxxx will not be performed".

Will reword in v4.

>
>
> Other than that:
>
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks Oscar!

>
> --
> Oscar Salvador
> SUSE Labs

