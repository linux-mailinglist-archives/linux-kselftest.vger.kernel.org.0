Return-Path: <linux-kselftest+bounces-18732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4998B9C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6ED1F2357F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BF19CC08;
	Tue,  1 Oct 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Epzj5Fa7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA01862BD
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778718; cv=none; b=XTIsDg1cCnwYVzwQpXiw8Ku4EDMqhuNK2gEGC7O2JFSDX0rR2k/AsTw2XUrJNnai4AgS8ebAA3xPP9orXf1VzQhUrX8bO3+wprqnOWKL7/TeUH+3sJZBp2+AV9wW4GDWX8KPvJsqS1BWVjO779E06I2SgZaxTuJrfYrbsV50R2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778718; c=relaxed/simple;
	bh=BHxBdN0+0XFc2gscEzhmEBjFXgbgPMlgA7qFw8/FInY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ93qaeVpyOIN9+QKlcXufhhelBzUR3ocP3CHV57G39uWaCxDBTXvpxutyAyPUQ53LfDHpjy1EI6npfL8HYX/ab61Ra3osPvqrlpPxQwYXCkmUpw2/Q+1SuQUNbWTpD+vdKzLtirNfyotoPUegaEuNPZJMZB/iM2K/1LgptDkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Epzj5Fa7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727778715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFX2w5y/1YTkg4M3sx1+O7IJ/a9wNfaFRAayvFDPj2U=;
	b=Epzj5Fa7fkln37bootEBddPf5dXqqSZLzxCUCcrsPgSPN9dxhchxYFrzajoVr0INg6M9MX
	aYFtBB+Loao1Z8FtRR7M5+urm1lVN0r3gZH4O5dfZfqkTehMKBDvuFuEFiwEIjHkkdqT6P
	y1RhZWK+8MBGWFZQbJMPnS/qGswid7g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-14wOixCwNtW-rj-N7T7UDw-1; Tue, 01 Oct 2024 06:31:54 -0400
X-MC-Unique: 14wOixCwNtW-rj-N7T7UDw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f79069e685so40560351fa.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 03:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727778712; x=1728383512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFX2w5y/1YTkg4M3sx1+O7IJ/a9wNfaFRAayvFDPj2U=;
        b=jwTMW4z+DjNfCkHiTjnfXAlyZF8agKAAaLsdjDDQCcmzCCXQpm2RJyIgT2zKxIRfam
         SeSe/ggDYbJvVSixmxrjPE68BobGL4aDlVTa4mxC714/dczbuCRbQXiCmjGEnogNXptG
         yl3DhCeIotF28pzY65NDQFyucT4EkobEbqvSlAUy+l1dXz3ZHbP394k5h1gBXA6xmvEQ
         ptLvSbfkJTJTHkLdUbslHYrtIq11FQ744muKoy7v/kM4upQNNLzVFqykCKB1s2KLUqnK
         yguR6Z60WKS3XTkWf4UEGEmuRXDy9VWHuXBu+ZQAaJp46ERrtV30mXVU2L/nAF/8MQdO
         PRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Lb5c7akC8fe+y7GxjkhayvJpL4fCJ+j5I0l40xeMOE3bwEapFbDetWmIjC8V2Jha96LgV0SuRpdqXSkW5rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwdbh6UpTKHskUv+IKytDU7GPqNixaEg4eQys0Snr6a0zWV2WE
	lxT6k7SkuUXRgcX9/j1/JvOxgWJn/QO2tJvGa+mGjjAG09W8PVmNLSNBeLObdmR42yfUJeCEM8O
	QGR3wHTVOW0609o5WjyvDE1et4qon60zQvAY1iZsWsBNvbjlQaeQ5jpCg6EXx6Dz3juqRH5xYWz
	WluQ4yR2g7+IheH1cvOS38O8NYDNLv0l3qYKcx6GPX
X-Received: by 2002:a2e:b889:0:b0:2fa:d6cf:28f6 with SMTP id 38308e7fff4ca-2fad6cf2c81mr22444711fa.3.1727778712383;
        Tue, 01 Oct 2024 03:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEigpLyS7jOvPPrdCyLrpJ7l3ogwdCk5nU+Sx78wFqjh8XJSsDghWBrZl9qdNcLnsLV29Ppj+o544CxVwWSQzE=
X-Received: by 2002:a2e:b889:0:b0:2fa:d6cf:28f6 with SMTP id
 38308e7fff4ca-2fad6cf2c81mr22444471fa.3.1727778711910; Tue, 01 Oct 2024
 03:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926152044.2205129-1-david@redhat.com>
In-Reply-To: <20240926152044.2205129-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 1 Oct 2024 12:31:33 +0200
Message-ID: <CAMXpfWtjE9tKhrvRmnCC_PeneV6LAB3XSqAUBzCMGAjvH6oxJA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] selftests/mm: hugetlb_fault_after_madv improvements
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series has been successfully tested. Now when executing the
hugetlb_fault_after_madv selftest the benefits of both patches could
be observed.
# ./hugetlb_fault_after_madv
TAP version 13
1..1
# [INFO] detected default hugetlb page size: 1024 KiB
ok 1 SIGBUS behavior
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Thu, Sep 26, 2024 at 5:20=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Mario brought to my attention that the hugetlb_fault_after_madv test
> is currently always skipped on s390x.
>
> Let's adjust the test to be independent of the default hugetlb page size
> and while at it, also improve the test output.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Mario Casquero <mcasquer@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
>
> David Hildenbrand (2):
>   selftests/mm: hugetlb_fault_after_madv: use default hguetlb page size
>   selftests/mm: hugetlb_fault_after_madv: improve test output
>
>  .../selftests/mm/hugetlb_fault_after_madv.c   | 48 ++++++++++++++++---
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> --
> 2.46.1
>


