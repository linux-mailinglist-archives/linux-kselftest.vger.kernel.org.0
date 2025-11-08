Return-Path: <linux-kselftest+bounces-45178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043ACC432DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 19:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82853AADE8
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06CD23EAAB;
	Sat,  8 Nov 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TR/TRNNS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56F212548
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624930; cv=none; b=RbsfkH97vSGB06q8WcoGyb1hjX+iZ4E1P8RDfLsRgSYW4ntLRnrya2c4OqmJ5IYPoD5yh5d4AbbYlQ31s1W/Bz1nvTtgpTr1K54fKoUQgpjbTZEskv0z+CNPHGam82SFeHWqIDfBx/UbzQKQ1L2C5m/RDotKUfUjuLA9V6EOKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624930; c=relaxed/simple;
	bh=3IAPhhTO3r40ZZf6LZefAtf94Ln9t0PzMSjZoD5Izaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5AUD0kDMIoXOrDawQkSmBaoFnUQY8rsjBrLbPFqSyBUTqeTnOwrzCnQNr9Fq8oYAJFSOcnEgRRRPkC06C+p3W2GpUV88AwsT4CflrDMBRrSEiRgMq1IKIC1azTyQh6YRZiysTJXsAU7ZRm9WhMj0qqDvjv/nBRuFNUavxRs45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TR/TRNNS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so2829613a12.2
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762624927; x=1763229727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GWnAPZ9fJcziaRXd9RH/lv4CcYCp+R5b37Pg12ambs=;
        b=TR/TRNNSmCGSVrbV5A1z0ywve0vGWlgCPWFzOZYO/umw0mviLuQ1m8z93newQ9A7zz
         BHRXICmNAE7GXU+XESGpD/FgxCU1vp95Ijc4a9sfGRouBRteq1DUAS0+x9wmWG7L8bAo
         0pKSFc3QdVwjEPzhUVgbnCAnu70+zvXIiQpIE6fBPltq3sRyv+TVOSm6J/xwAeZM0iDO
         xOYW15EhMZGPjzIT1RhgESY6HICAkaurs8yFAm2yfAERjW7T3aQIQUb8ncM8gDjaBX3y
         R/XaaP67PLwZVbG7YrTbD0J44DVQLomKPITchLG/uizeeY2evf1ek+l6SUyUTm+xOT3L
         XYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624927; x=1763229727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GWnAPZ9fJcziaRXd9RH/lv4CcYCp+R5b37Pg12ambs=;
        b=IYvxKaOmAoDGEuCip+aFeaiHDv+cgRjRUPKcPTvuJhVm37LhH7vo+9dt6AnXHJyQlm
         hNTRvrgUW3wOt4vzSEwsTXSF74KrWPg/nKA2+uJjklaZUoBDDs8CKycLizeoJwQ2SVDb
         84swtUhWlmUQMKv/z4yOHSat4L9K6ztA6LzdKz9r1zEneEkYx4BdYztuFlA4AlTjZ74M
         Au+ijthVst+EbU3kRIxy+JS8vuCr2m/uUKWhqvqnJIBaTfW1hi09VPgk1nbVUknd5t2w
         /+TGBIRXz5n1zvCuuP0LnfnSZAcdNZG9192DQMOhGUS6EFVTPat/bhJ4P40a2r+pgGHc
         p7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWiXc1G1/QMxci6F+iuSBVCtD8lXHt1l4mPUsHVGd/YDhSoBLWsNszG2aI0LLtAUlsrgctEyZbpSxAeyWp4Joo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtJSbqYPEDJlQ57gBUqGzAjYJV1YIueoyXeQCmjZ+Lk2ReljV
	FXaC+6ITPTtC/6Q9QuuUdrXTm4bY0dl0QcVzDUtZ88qI9RhKCYJYGQQ6bIDbSE36RVWb6FK9RuG
	oFutcu0pYlDQyNX9OiffJHXAk2WIzbgFUtI2izBROig==
X-Gm-Gg: ASbGncuCC139xvCkWNK+ESpx7CT68NlHPQZUfxoW9X0u4VN1gz41P7H1W24RZzES3qV
	SVGl0m3D1wnaTbcUiNyZIut5zSqyjLcOUW2H/QG+AchGu37voCvpIIKWMqwCPpgcRnN7uKrnhrb
	vyzBPtqkTzM5jVjSeyWxjYmggSzAepZbryWmFI6l8WBohRDi/ya8R25DOAOuGKyyZaWIQrG8zo2
	DXfsLHxn4Oj+gjJYcWRUUYVgAh6pzJyyqwpo3UTDhYXCnW/HKPnymquB/EKDlhHriSFNC5Irs75
	bT3MrvO7N4WvGaX51OtGW7BYE/K3axYcxkapYgk=
X-Google-Smtp-Source: AGHT+IFsBU5ndj9huagaCxIuqQWmECbsaAtYI+vyGpVvxucw0lq5Q3fxfGJV+B8R/tEvXu8DaclLEzTrS4Qfd5oPG4I=
X-Received: by 2002:a05:6402:1e8e:b0:640:9aed:6ab6 with SMTP id
 4fb4d7f45d1cf-6415e6e4832mr2571858a12.24.1762624926681; Sat, 08 Nov 2025
 10:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-8-pasha.tatashin@soleen.com> <20251107142304.6d22289c96023fbb7e99464c@linux-foundation.org>
In-Reply-To: <20251107142304.6d22289c96023fbb7e99464c@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 13:01:30 -0500
X-Gm-Features: AWmQ_bmRKs4A_xQMqsLqTmPYtgSzWfjOGsBbh71PdYDaXz1vtujo3t8KJ5u4TWo
Message-ID: <CA+CK2bAvh9Oa2SLfsbJ8zztpEjrgr_hr-uGgF1coy8yoibT39A@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] liveupdate: kho: move to kernel/liveupdate
To: Andrew Morton <akpm@linux-foundation.org>
Cc: brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org, 
	pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:23=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Sat,  1 Nov 2025 10:23:23 -0400 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > Move KHO to kernel/liveupdate/ in preparation of placing all Live Updat=
e
> > core kernel related files to the same place.
>
> I notice that menuconfig is a bit weird after this.
>
> The "General setup" menu offers the "Live Update and Kexec HandOver"
> menu but there's nothing in there.  If one sets
> DEFERRED_STRUCT_PAGE_INIT then things look normal.
>
> Perhaps we shouldn't be offering "Live Update and Kexec HandOver" at
> all if !DEFERRED_STRUCT_PAGE_INIT.

Hi Andrew, thank you for noticing this, yes, indeed it looks strange
when empty. Let's disable the menu when DEFERRED_STRUCT_PAGE_INIT
until we relax this KHO/deferred init dependency.

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 054f6375a7af..d7344d347f69 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -7,6 +7,7 @@
 #

 menu "Live Update and Kexec HandOver"
+       depends on !DEFERRED_STRUCT_PAGE_INIT

 config LIVEUPDATE
        bool "Live Update Orchestrator"

