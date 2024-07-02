Return-Path: <linux-kselftest+bounces-13077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A1E92478A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A251F21C46
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB61CB31A;
	Tue,  2 Jul 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYCT38O4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D01C8FA9
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946200; cv=none; b=K5eHRPvM/mdEBhb10He+eY6LAqVhP5fM72BXcc+j973YuLcCW8W9BIDBVRyKvpvuxGajti3cT0WB3rMYGZo6RGdt2GvyLRP7OH/xsEBFcpNYi247ROBLaj/u1GCrYemd9UMNE5X4Q+kkVo3XHU8rWCZOHAXx3+J/fHIDWYkqIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946200; c=relaxed/simple;
	bh=wBCH0RGXQscHQNhVbPuJToAcNW1ub3XjfpU3YyPq5Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ar/9OMnFSeIEptFpHN/9vkO7MAc72gWyErFmOJTi7pFBfEsb76bTrMFCc5d4PvqwNyOQ5C0kkAbJkA86WxWi0nbUtWXLsUUMHioxlPkWWo5iuWdxetSIfUySxFHumRWrhxSR6n6y1oqSXsSVFZkEKWpnPp+RkpGLxzS+8BPLeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYCT38O4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so2777a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719946197; x=1720550997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBCH0RGXQscHQNhVbPuJToAcNW1ub3XjfpU3YyPq5Pg=;
        b=pYCT38O4BWrPsDNAJuC8oCfG1wPjSDFz/t+1NIR1LZAfM/o6d62IrI1ABe/5NJggci
         b1LlyRfoRIIqkwVQh65Iexis2zIQ4ZIPesXtN5e69aHaSvDTppSV1xlB1ybet4Kmf9Zg
         uRPvxHmij9YQuqMtnOlds6PMsrESLjrvDMVfbsVcTP+r3wAotj15Zd88rtV1Ndd0/EgB
         /iWh7fvblF7ViZtt7UV4WyAo6UhuXhxDy40wUbnfNOETfPZkk5wlEQJqCgZ94XEAOs6h
         5sXANOZozoUZfp9yhYnGv2m6UjM2HORXncFze21QO3DDdA7NqE+jvEmu9fOut9E1/Bx9
         sQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946197; x=1720550997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBCH0RGXQscHQNhVbPuJToAcNW1ub3XjfpU3YyPq5Pg=;
        b=M96Kci1hRjrn1ub9h/Vh7sif0TMMF/rgilqLdBJsL6vX1fb+jU8OU1vA2MUlanThfA
         g8p55Hhzfe+Q2n3+QN+Bsi7Uw9bThnNYBdk4ay+NLthhl+gzIpO0umN+BNCNwfsMT82q
         0peynoO131XmP7Z0dKPREJthui56du6OaYX11Iz5a0SuK+TwJGdGauSUPZFa9tY2ZmQ3
         Jjnxwvu74gLPOuj0EbQVPNfOzmzfgKYz93E7+rMblFDjBHpaN9b+GQgOAHGHapzx/Yvz
         9pYkXHeMhd15Xx0V+6XKMXCplW8VsCfKsodQ0XGdtV+aFnDiCn7uI7a5h3QnMSck8k1D
         mV5g==
X-Forwarded-Encrypted: i=1; AJvYcCVRETkcM4ZdfA18ck8Dn0r7n0pcC0GTWtO0Alfz4em69Igfh72A1TDpsjZ9PR+o6nWSWG481X5SQjAKniu+h4eiHcHyV9NpbDFat3Mcy36x
X-Gm-Message-State: AOJu0Yw9Gsy9iFKaYTSBkI3FswY9CFfmj7Aac6EE3E+HglZvJyIx8j/d
	nbYcuxfz8TfSNaoSaNVEbKb5z1s7BV8doABKihJw59Mgez8tDqVzfVS0ODQEe2XOKnYomtMqFJR
	Lgzb4kbz6wOBLFFeztGOiO0epOkQ4sTiYzM3M
X-Google-Smtp-Source: AGHT+IEXouaVIvQZ1bo2Efta4GbpBxhXnzrZmhgd0nFm/uUDODI5B9UrHV01kVC3BKPp2wNuFauI52mbQ00Tz1Bob00=
X-Received: by 2002:a50:9e2c:0:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-58c9891046cmr17632a12.7.1719946197278; Tue, 02 Jul 2024
 11:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614233105.265009-1-jhubbard@nvidia.com> <20240614233105.265009-2-jhubbard@nvidia.com>
 <CAG4es9WQOOga8Oh9BOjr_JXy5gcUzVN0iTtfjN_HVdRj7_G7iQ@mail.gmail.com> <b4720a40-6e74-4b1d-93ca-a3444e400a1a@nvidia.com>
In-Reply-To: <b4720a40-6e74-4b1d-93ca-a3444e400a1a@nvidia.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 2 Jul 2024 11:49:31 -0700
Message-ID: <CAG4es9V4EiVBi08X7xNrEpCd5eUum1-5DrYV7+52BB=OP_4DKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selftests/vDSO: fix clang build errors and warnings
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Lutomirski <luto@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev, Carlos Llamas <cmllamas@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:26=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 7/2/24 11:12 AM, Edward Liaw wrote:
> > On Fri, Jun 14, 2024 at 4:31=E2=80=AFPM John Hubbard <jhubbard@nvidia.c=
om> wrote:
> ...
> > Hi John,
> > Could you try re-submitting this series with the RESEND prefix?
> >
> > Thanks,
> > Edward
>
> Sure. Is that the key, for kselftests? Because I've got 5+ small
> patchsets that are languishing there, and I'm at a loss for how to even
> get a response, much less get something merged.

I don't really know, but it was suggested to me that it can help to
point out that the patch might have been missed before.

>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>

