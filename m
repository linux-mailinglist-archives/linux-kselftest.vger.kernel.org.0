Return-Path: <linux-kselftest+bounces-3704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1128414F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD3E1C226A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACA157E72;
	Mon, 29 Jan 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2f97p3O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F39153BD6
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562759; cv=none; b=Ztu9NBQrttkYMkGzutCSMMhYFMWogEF6xbBDsebZNCc/CsVgHXG3vMABfgDT3NA/dkJLgowc5b+dvAMsuDc4YHD7SJMiw8eNX3nxOlD83SlAIsZKa0ExgdYwgxcsHjzjv4QFZlksInpH639i4u8kXvl/j8vf7w41M6hIp+MU4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562759; c=relaxed/simple;
	bh=toozhxA5OaN5MxZfRA9HcxV1TAMOi0VIEPmcKpxZ+qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY8hMZHLk6r2BYkgqhx2nPrjB6GD6Oy7LNCmPdOUxnvi0QuncaJvHeOPJLeNHDGF45vIaQ+V8oIYeRJGIWELytkq+BLhLjVgnY75PKvAUs4bhNIvLzFOwviqTyhvFFcqhQi4S5EGHofbfwrMTUmOxLxmVZwwC0h5T+PN5hEtJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2f97p3O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706562757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJKK+vZkaLSD6C4kLn8D3sT5aXAcPFeyLxtieK2IGfY=;
	b=C2f97p3OmDOYj6xm7GFFvx+sbvty2/U8czO2OYFx3XKAgrzKgK4wFTh0pMqvkD4SqwIHSD
	q2NLbNnwrcNGr0xiU1Wv3ORcw7+AaG2MoCBA7k28cpgNgAZLLJ+s7yPzbTbkK7nG7CJpQr
	eYxGan+m1nPrRJb18xWK0T8P+Kh2yh0=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-fcyhkf8eMH-PIVKDvYpIag-1; Mon, 29 Jan 2024 16:12:35 -0500
X-MC-Unique: fcyhkf8eMH-PIVKDvYpIag-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-46b1b72c347so717150137.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 13:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562754; x=1707167554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJKK+vZkaLSD6C4kLn8D3sT5aXAcPFeyLxtieK2IGfY=;
        b=PRqqkuZDwEyC1MAJO3LVte52MqPlgJnYEcQkLOCJkcUbKq45snZszrCD2bdg/fnKw6
         eKg84gmmYCj/P2U7T+kUtSVYFoQoC34SBS1kmgsm4086/qKIk+aGwNuv9ZEfs8tPrzcn
         kyLNYup8kWrujKXQl+SRKIjs4fQn1CNyeYm3RZm2vUhXpb/cH/sPldq7LMeesphJS435
         yC4hI7TMES84+d4bM7McgGzcDKr7G5cqs7Plh7XDV+dnQ6aqdcO5SgFMDsuKIj7P5+Qz
         kx+U5/gBwUqd4FGT2VzI9wf0/9Z9CCyUOJ96juKfreQrc7IzqOAgoQDTg1qzMI6JsXRF
         fgjA==
X-Gm-Message-State: AOJu0YxdsV7rz7RjqGNKC//O2Q/qksN6LOTKB7zJsur1Wmvxs/jHxpec
	fc7IJ75ZNz5ZMjdxjImV6TBKxByMKksfZGvh/XVGvEihX0rfb8xOnI+WABUcG+Zmm95gfaPL+5i
	slXkzkan3P83HGMo8UDd3Gm3QMmyTGtHT1/4srf97cgun679lP163rSFHALr0Qu5v9foHZkC6mj
	MmKdNPcYflRjS+jp+MvKDSr/U9pubpZKG72hmYjtxCi6yXrytl
X-Received: by 2002:a05:6102:4414:b0:46b:8824:bb88 with SMTP id df20-20020a056102441400b0046b8824bb88mr520676vsb.26.1706562754498;
        Mon, 29 Jan 2024 13:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNlEojws8R5wF5QnCXftN0hkfKgSKKeqtHsKEcYfVBtVb4+sL8QrxXrDDCkJEjoW6pFQYLBf/wB+o1BmxlrAI=
X-Received: by 2002:a05:6102:4414:b0:46b:8824:bb88 with SMTP id
 df20-20020a056102441400b0046b8824bb88mr520664vsb.26.1706562754231; Mon, 29
 Jan 2024 13:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115246.1234253-1-leitao@debian.org>
In-Reply-To: <20240129115246.1234253-1-leitao@debian.org>
From: Joel Savitz <jsavitz@redhat.com>
Date: Mon, 29 Jan 2024 16:12:18 -0500
Message-ID: <CAL1p7m77d7okCJR4YwYVMZvbBmFCcWrcXMpa1p50N=ED6CDWVA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add hugetlb test category
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, ryan.roberts@arm.com, 
	usama.anjum@collabora.com, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:53=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The usage of run_vmtests.sh does not include hugetlb, which is a valid
> test category.
>
> Add the 'hugetlb' to the usage of run_vmtests.sh.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 55898d64e2eb..2ee0a1c4740f 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -65,6 +65,8 @@ separated by spaces:
>         test copy-on-write semantics
>  - thp
>         test transparent huge pages
> +- hugetlb
> +       test hugetlbfs huge pages
>  - migration
>         invoke move_pages(2) to exercise the migration entry code
>         paths in the kernel
> --
> 2.39.3
>

Reviewed-by: Joel Savitz <jsavitz@redhat.com>


