Return-Path: <linux-kselftest+bounces-30609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2462A86117
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12C81B81F90
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB971F5858;
	Fri, 11 Apr 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pg2dy6lP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51481F5827
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383282; cv=none; b=RTKroMr4di90DaDcrZpH4pw/RuO3dfVzsyiB4h735KZsU1nXAqDz7QtshZu3aeinnXQLAOtnc7UBXsCYRZyjEdHmxqMxM9/EBn/twAbwBrxjaoIKFRHGOPI+DJL3DCZ32OWkg3O++nLZtEx68caqYGeFakO/D3YQ3xglq6j221k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383282; c=relaxed/simple;
	bh=eIezD/ylug29m/0E9n8KTA18+3Fnkn4hc9wAgrXcGDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9fcDsZQNMPt1VtfW7g1c/5ZCnliBa8bc5BQwqvdwwD/mxt+y5pSO5Hpnp5lOltQ/pnnuVZ46Jhvp5xE7rjRJzfcSsG8CGWwXvjRiJoSqbTL65vUap+9AOIAoRDWAbvoIAHYXV1vGH9910KKoBZ22DrjXXP0/YQeNs6QBSjA5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pg2dy6lP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744383279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIezD/ylug29m/0E9n8KTA18+3Fnkn4hc9wAgrXcGDs=;
	b=Pg2dy6lPnKeF/JExoZAZEqGsgLrYnJmBpLu440L/pYTvqz9HM7npVIAHWfCszvuLryCAlu
	K15QmEOGKF4S0WZ6yRxrS26dB/Nkk7OBAJrFNuEYeTrv0esqbn4TV0ztiB4TOQyJnEANa1
	1p9Q8L3jUum8IaMpL8C1rYW9OYn+DjM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-sSH2lB47OvKKtfPR0FkguA-1; Fri, 11 Apr 2025 10:54:37 -0400
X-MC-Unique: sSH2lB47OvKKtfPR0FkguA-1
X-Mimecast-MFC-AGG-ID: sSH2lB47OvKKtfPR0FkguA_1744383277
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e643fea7fd8so4328056276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 07:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744383277; x=1744988077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIezD/ylug29m/0E9n8KTA18+3Fnkn4hc9wAgrXcGDs=;
        b=b/JsDSDrX5S5raL4Dcb0Bq8L/YofaSIW12QaLspYODIk7OKGvLAJrbI9b16Tzzt/YL
         HSaoioWunHdFwXYvbu0ceBwR5JBe80gmVAYx+NE1MxWIQy5LeGY6wJvlSBRV3ZPEK+zB
         j0FanoFcxx1X1XfHiv6fGhRMbX5IYKsrL2z3E4vX6iipfZjWd5l1mNKaGCbj+KdyBK5g
         pj4S/GDSuRIp7jhAiDgYvlr4zpv9KDS5JsA6Z4Qdcz0bT17ZDs29R/7fOOFB4SkAZrLl
         BXlF88xeQsxiNFox4Cco7RJrZ3gh7+q0fS/4AK75G6Pf3o5cicUPhqKVjcCymqWChbn5
         X4hA==
X-Forwarded-Encrypted: i=1; AJvYcCVwE5KZTKeplkCPOEcMNClernWMlOy/cF9sYMmaCggs8AvV9UGZq//nRjjQWt99AVyJtXS00+qJ3XHSGfIbVgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytcebJRl1bvcC1J5B2cdQXtXj8BePoByf9svhLyHHHFk6NlHMJ
	bHznmviNx6gIjZwJLbwSnZcQq+fCtf+wlCfZETtUt+ULGWA0GaPSROevUjSQW9WTxNo9m8mfxI8
	9BGe2zSb9CGWQTeA/mNhGhuBqA15FokBjVxLtT6oYl0uinjtYdZKVm/wR/gM767oVB8vMa14ndl
	JMRonAQRen9RPMPDGlqpZvkdnUJu0hviQA/+XgSWxw
X-Gm-Gg: ASbGnctVCTE+/kVHJ671XUGtH38K967+ecze6XXHmGIMwzsvs7rlfq03T3u1BIpd3Wx
	cKjcssXrn65MmzYDVCb7H/3yLiHh5JijNgPLNeFaXx8jXzk8Wmzq1r0DsZrszI8R95CmLBsknt9
	99EXN8wZ0=
X-Received: by 2002:a05:6902:2610:b0:e64:cd91:9c6b with SMTP id 3f1490d57ef6-e704df2291amr4619285276.2.1744383277341;
        Fri, 11 Apr 2025 07:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9EhHuwFK1eSJF4vhK7gbADFbwjvKEoRXy8ZAl3D71EQC1R6+/ICnerdqvFsdHOfDHSi8SQ87qKPne+7PucWY=
X-Received: by 2002:a05:6902:2610:b0:e64:cd91:9c6b with SMTP id
 3f1490d57ef6-e704df2291amr4619252276.2.1744383277052; Fri, 11 Apr 2025
 07:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <9024776c-7028-4522-a773-8d53d233dabf@opensource.cirrus.com>
 <c559ae66-745e-4403-9b6f-ebc8cf85d2aa@opensource.cirrus.com>
In-Reply-To: <c559ae66-745e-4403-9b6f-ebc8cf85d2aa@opensource.cirrus.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 11 Apr 2025 08:54:11 -0600
X-Gm-Features: ATxdqUFEnMGFBBYFnjFYQ5hxWKTSkFJJeahcrNctdJFN2mYzO52OAa5ud2kmFMg
Message-ID: <CAA1CXcB-Y5fYdcFx9c+Yj9Bu-WtFF3TeDTzH2ehKFvGEBtGeXA@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 6:39=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 08/04/2025 10:25 am, Richard Fitzgerald wrote:
> > On 19/03/2025 11:05 pm, Nico Pache wrote:
> >> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> >> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to t=
he
> >> depends on clause, and set CONFIG_FW_CS_DSP=3Dy in the kunit tooling.
> >>
> >> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file
> >> download")
> >> Signed-off-by: Nico Pache <npache@redhat.com>
> >
> > This patch doesn't actually work and breaks kunit.py.
> >
>
> I was working on a series to make the same fixes to another Cirrus
> KUnit test. That series makes the necessary changes to all_tests.config
> so I took the liberty of fixing your patch and including it in
> my series.

Thank you! much appreciated. I will try to apply and test your series
next week.

Sorry, meant to get back to you sooner, I've been very overloaded.

Cheers,
-- Nico
>
> https://lore.kernel.org/linux-kselftest/20250411123608.1676462-1-rf@opens=
ource.cirrus.com/T/#t
>


