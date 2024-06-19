Return-Path: <linux-kselftest+bounces-12211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE390E2A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE8C1F24053
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDBD55887;
	Wed, 19 Jun 2024 05:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xvDjMUi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679DA28EC
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774834; cv=none; b=OZ2mSCdv5ym4raYnQf9S5S8m17LE/I7SPqpxI/doONbzgZSup30LkLz1gulfGba/CjQxncaKwfoJkCKFh8wSnWMEkL4A6Mo3ZcjB3Lwkg0qdWsd1WcZw6wk5iHoEtePyOAcItH5SJ0L8s/ruuJBU8sn6nHZKDyew0bLif6uleV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774834; c=relaxed/simple;
	bh=TaldpaFdVU9VKO80EHQfPadmZ9ehSii7vDuV8VjyxKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or3vhlk7slOKXw8EYe2PqxsENJ174ySY5W8+H8vG75ldA8comIHH68GdUy4w98kUVtb1dKBn6nuXBVzKgXGCgMk5D+q18CYdDZwEgrkIts+BY3uqbdUeRPV4l8Am2QMqaoS/5CMHB7Z44exb1b4MD9VZ/JsXl385KOdlHDfLFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xvDjMUi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so44274875e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 22:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718774832; x=1719379632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMKzlr4YMJj/i6AQp9On5aFVd7CtHU1kUwtqMK4CQp0=;
        b=3xvDjMUigsR4c/Z4Ic5yt2d4G2yQYON2CtOE6OC2V6pEj5JfZdXq3RKbcUIUh/xuig
         2H5jRq8/9irM1fJzA/VUpt32Q7YJALsKtYrngOEgQ33zKgk4x1LqbgjsInehC5RGvgV6
         H3JJE+JtZqjxCm+vapN+9AKCnwj7neGxcudTxHZSNfLyuL1IiNpaoKWSYnohXfqtOOmd
         0eSSk6h8G0bW2c0KVKggkSgaGj4QxKB7Xas+7OONcAdITCwy5gVDANI/8U3y6P7+rf/Z
         ODsY4o+IEqWxL0Zvd++RG6HrTEInx2cPx8TeVBWkjX3PbyZTAzNOBpUK4xTBnX6Kthq9
         DpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718774832; x=1719379632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMKzlr4YMJj/i6AQp9On5aFVd7CtHU1kUwtqMK4CQp0=;
        b=JKqUz90mIan4u3lWOE+wYuPPWW0rEEW9VUvzYdqMxuySpkUbR2/rFCMnWXaX/jDVFt
         qByOaNI9aBGScyTONp+TzbtsHnjCPS1BkrrAYSx8bF8cA1BQxv09B8L9tlqoXGOGjIfv
         B631CqL1cOrK33CWhaMqFPT4K2r8ihARlxSFNYGFGQLD3F6qYkGKE+7fMQ3bFDE+I9YN
         spg3UDazOJUgwGiOhNE45XLvGHq2SrQLEd5c5XkEju8LcPsUoFVjIr3Fgysg44hvJm//
         rgWnfcI+55KItcSr5qC0TdR2WnNGUSFEDoIW407Z+mmCzhymc9xhB2nOrRhZ0klwHdAf
         e2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpsDcN6fUpCEqFwS17qCh4isPGDuXWgkRqpxMRGiV9w/DWtXZWB9GqR2qC43rysbxjF1g109qRHcx8tacMfTDgC/4V/Gtl2jOmfho+644q
X-Gm-Message-State: AOJu0YxQ2I6q14re2X7OaSbOBLCdb/DNflAnszX0216uofEexpTJaMwW
	Luv6FFt4mnNQ+esMr54SlKxxgM4PnPQz4FDUbEOd1ORTwcE3I9yMM4+RoElXlh6VHip6YDSK/c+
	WLFHXKxtbO53vg/Br/6ILBFyVQmhB4fj9JDqB
X-Google-Smtp-Source: AGHT+IFJQWZ+KHiN/+sHKwZP16by1QOEq1WGoR1DxEL2A3UFRInhIe7af0qptcWZ7wTRqX0VaIgipvW1b8Mme6mmrZQ=
X-Received: by 2002:a5d:69c8:0:b0:35f:2635:5b61 with SMTP id
 ffacd0b85a97d-3631989352fmr1085996f8f.51.1718774831425; Tue, 18 Jun 2024
 22:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617170545.3820912-1-jiaqiyan@google.com> <20240617170545.3820912-2-jiaqiyan@google.com>
 <ZnJmsqvJz63imq3O@localhost.localdomain> <ZnJo73kZk5EDxq0D@localhost.localdomain>
In-Reply-To: <ZnJo73kZk5EDxq0D@localhost.localdomain>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 18 Jun 2024 22:26:59 -0700
Message-ID: <CACw3F52X3BUCeB7OUhbEzEHy7y2vdNO60pybz2x9OdhyZOoStw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Oscar Salvador <osalvador@suse.de>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	ioworker0@gmail.com, muchun.song@linux.dev, akpm@linux-foundation.org, 
	shuah@kernel.org, corbet@lwn.net, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:13=E2=80=AFPM Oscar Salvador <osalvador@suse.de>=
 wrote:
>
> On Wed, Jun 19, 2024 at 07:03:46AM +0200, Oscar Salvador wrote:
> > On Mon, Jun 17, 2024 at 05:05:43PM +0000, Jiaqi Yan wrote:
> > > +   if (!sysctl_enable_soft_offline) {
> > > +           pr_info("%#lx: OS-wide disabled\n", pfn);
> > > +           put_ref_page(pfn, flags);
> > > +           return -EOPNOTSUPP;
> > > +   }
> >
> > We should not be doing anything if soft_offline is disabled, so this ch=
eck should
> > be placed upfront, at the very beginning of the function.
> > Then you can remove the 'put_ref_page' call.
>
> Also, I would go for a pr_info_once here, as otherwise we can spam the lo=
g quite
> easy.

Nice catch. I will do pr_info_once in v4.

>
> --
> Oscar Salvador
> SUSE Labs

