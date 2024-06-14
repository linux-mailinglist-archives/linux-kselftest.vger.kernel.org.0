Return-Path: <linux-kselftest+bounces-11983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA89094B5
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586F01F23E05
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A3D188CA0;
	Fri, 14 Jun 2024 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEIlC0cb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CA186E3C
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406972; cv=none; b=lEedayDSxU08c6+lSWT9n69NxKdxV5dMwKjs8DPyQSCml/R2HOO5V6ZEF+jlIVuqauhsPwLd9HBbSNekEe+j4Bh67FiRgs+lCRGXutfQWaueO08mglKHQGsdFfVuZrGt65IDKcWproX/212d9FoDhRrsvfwvJkIqK2n+Oj8Yzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406972; c=relaxed/simple;
	bh=1PXiu3XyrGn6eioRMQi+2p0r/15GuzVsN093zgKL+z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRak18Ofc2rigaWnCxgeho+2+5Yqb9SzovV8BmlFF1kOPgOQFmeWQ2lcxi8KdaCaUPUrEk9ILRYzhfIWCg+XZdhDkTcZn1mQHQD/E8ddLLu3heUkvOEAxCLSJxqtBCIUc9G11/nJZ7ethrMNWFIgygpEIq+4yVZ1BsmrnnxeBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEIlC0cb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f0d6255bdso2398485f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 16:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406969; x=1719011769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LahH6YvliG7eYlUbvikNbUEjbap7UqWjJYCEVPQs1io=;
        b=WEIlC0cbjlsU29zG3suUH6LAoVVZBEU9a+RoHqxwLlF9WMXTCvBWjj1O+m4cr+MgF3
         NSR+KXgyc8tId+UVSbfEIa9SxnD37TvpMnLBEGjDioXbj014iJ6P97MiaV51zK3EE3gi
         mW4zpXDK3IVxEi7JhHUS8gCaqWE4hcrLMc2Q9sYOonHEgYT01uvld8OA0wIFpokNwGEm
         lZBuJmyS2RAGZpBRRngt5hMaONIkjxYiyrViMmnv7j/b2rCD4qfyyJHEZFZM2qCp7BHd
         fXv4ZhJ1cn/uE26Le/5pQG4vfkxEh4lRI2RXkYeihAMRDLHKp5pLVU7EdiGS4UkeNO8m
         W2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406969; x=1719011769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LahH6YvliG7eYlUbvikNbUEjbap7UqWjJYCEVPQs1io=;
        b=lPgqE0PP8sooERkNJ8it5tI1p3M+4Wb7cqVpsU/fl6z5kew9J1IJMwcTrAipKJwIkQ
         mVaNbIffP0kscaEXArM6HhWTLMvkf60hqPvktu8ldnVdvUKDM+TpfHS/vrJKORcM5Lq8
         n6DPf0jCdie9Zyh3m8gmSmjzqZ8q311uHOP+/pVcyOmG7Yic3+/SF3EPlws9MeYYngzp
         ChYnpP77l9sn4YYNBzoZE1zNntu9sjkibgZ8trd72Fk1YEe5Nn7XCKwqygNaHL058XNJ
         r0Cd7/cFCtw3X8R9fxHqfBPUKTADx69XjvE018Ats2qPM1kybeTOMrFe7VDpfwWZ1ewz
         g+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfbmxbvGeQ2ovbpF8wssIqkzHv/qSnwDlTJArvbws/isR6THyv4CsQxnmrdYi8+TfK+J1mNjWeZcr3gdng+nx3fqr41gOXgQAgBvFp5j40
X-Gm-Message-State: AOJu0YxxVh+oKtXKTjw3r3OIqa1jaU3wtOCqBLVwT31+kxczU0U68Eqq
	L+SWHxSOEJajzVXr2YcWRC24wPDF+1bXSwlNcZn8lIHmDWzE8yk/6tZcjD/vqV4DjMi+KMd1FYz
	vY1sK3p8WI5ZwJDo+sa8n+bo2lAL0IAufN6O5
X-Google-Smtp-Source: AGHT+IGSGeWdWrHeyLBhi8ahJUOIBOV4p81XB0K8UtbxXZp0W1Hbsh5/A+lYxE2gXbWBKN4sXqq0XRi16MlYhpjbjow=
X-Received: by 2002:a05:6000:4583:b0:360:8768:8dda with SMTP id
 ffacd0b85a97d-36087688e20mr695294f8f.7.1718406968805; Fri, 14 Jun 2024
 16:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com> <20240611215544.2105970-4-jiaqiyan@google.com>
 <9461874d-e2d6-25fc-813c-9c9bb0ad1aec@google.com>
In-Reply-To: <9461874d-e2d6-25fc-813c-9c9bb0ad1aec@google.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 14 Jun 2024 16:15:56 -0700
Message-ID: <CACw3F525-4w9N5wSVrbTnSz=g=4SxvXD=dWL9nsf1iQuaYj8OQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] docs: mm: add enable_soft_offline sysctl
To: David Rientjes <rientjes@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your questions, David!

On Tue, Jun 11, 2024 at 5:25=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Tue, 11 Jun 2024, Jiaqi Yan wrote:
>
> > @@ -267,6 +268,20 @@ used::
> >  These are informational only.  They do not mean that anything is wrong
> >  with your system.  To disable them, echo 4 (bit 2) into drop_caches.
> >
> > +enable_soft_offline
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Control whether to soft offline memory pages that have (excessive) cor=
rectable
> > +memory errors.  It is your call to choose between reliability (stay aw=
ay from
> > +fragile physical memory) vs performance (brought by HugeTLB or transpa=
rent
> > +hugepages).
> > +
>
> Could you expand upon the relevance of HugeTLB or THP in this
> documentation?  I understand the need in some cases to soft offline memor=
y
> after a number of correctable memory errors, but it's not clear how the
> performance implications plays into this.  The paragraph below goes into =
a

To be accurate, I should say soft offlining transparent hugepage
impacts performance, and soft offlining hugetlb hugepage impacts
capacity. It may be clearer to first explain soft-offline's behaviors
and implications, so that user knows what is the cost of soft-offline,
then talks about the behavior of enable_soft_offline:

  Correctable memory errors are very common on servers. Soft-offline is ker=
nel's
  handling for memory pages having (excessive) corrected memory errors.

  For different types of page, soft-offline has different behaviors / costs=
.
  - For a raw error page, soft-offline migrates the in-use page's content t=
o
    a new raw page.
  - For a page that is part of a transparent hugepage, soft-offline splits =
the
    transparent hugepage into raw pages, then migrates only the raw error p=
age.
    As a result, user is transparently backed by 1 less hugepage, impacting
    memory access performance.
  - For a page that is part of a HugeTLB hugepage, soft-offline first migra=
tes
    the entire HugeTLB hugepage, during which a free hugepage will be consu=
med
    as migration target. Then the original hugepage is dissolved into raw
    pages without compensation, reducing the capacity of the HugeTLB pool b=
y 1.

  It is user's call to choose between reliability (staying away from fragil=
e
  physical memory) vs performance / capacity implications in transparent an=
d
  HugeTLB cases.

> difference in the splitting behavior, are hugepage users the only ones
> that should be concerned with this?

If the cost of migrating a raw page is negligible, then yes, only
hugepage users should be concerned and think about should they disable
soft offline.

>
> > +When setting to 1, kernel attempts to soft offline the page when it th=
inks
> > +needed.  For in-use page, page content will be migrated to a new page.=
  If
> > +the oringinal hugepage is a HugeTLB hugepage, regardless of in-use or =
free,
>
> s/oringinal/original/

To fix in v3.

>
> > +it will be dissolved into raw pages, and the capacity of the HugeTLB p=
ool
> > +will reduce by 1.  If the original hugepage is a transparent hugepage,=
 it
> > +will be split into raw pages.  When setting to 0, kernel won't attempt=
 to
> > +soft offline the page.  Its default value is 1.
> >
>
> This behavior is the same for all architectures?
>

Yes, enable_soft_offline has the same behavior for all architectures,
and default=3D1.

It may be worth mentioning that setting enable_soft_offline to 0 means:
- If RAS Correctable Errors Collector is running, its request to soft
offline pages will be ignored.
- On ARM, the request to soft offline pages from GHES driver will be ignore=
d.
- On PARISC, the request to soft offline pages from Page Deallocation
Table will be ignored.

I can add these clarifications in v3 if they are valuable.

