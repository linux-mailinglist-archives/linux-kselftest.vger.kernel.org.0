Return-Path: <linux-kselftest+bounces-34093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C32CAC96EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 23:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AFE1C209E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80A27A906;
	Fri, 30 May 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d23bNV2Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C62274FF7
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639590; cv=none; b=Abc7NKrYFoiztRa4hN2jMdN5FN395d1RVFymUWDMtSBGiwlGjw/1bddzQP2WL/0joCj205VPbLUcn7HUE0Mjs8zeyfHzqR30VDgcaTOqqksqBeP4HUoznt4e/3Q+6J+PFyMJDHOI4IVkMZqH3mpd3dxVEYOCfT3h9ahDeKrnzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639590; c=relaxed/simple;
	bh=+cYVeMlrP+QZqiuoVmL5LUc9uQbSMDkjj6DNynR9P+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT154OajdPvMLM5GcaPW9ufVQt04qb7xe1tSuoa1nOVsDfqHs8jD7LL1AKShScl4OBVXHTZ/MR0iulh+phirZXe+IPCGuDXRMpGhJ2jwIrk1MGKJ4rZr1fp5yJ6NsA6qUCo8Mt5G7ZF4ibJBt4UNqAr2sDcdSLtC1ysuPZG++zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d23bNV2Q; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87de47585acso1666912241.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748639588; x=1749244388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWSnOvPKHr/lJuH5eM1BOiskSSeG00tK+eTNYLS0Y84=;
        b=d23bNV2QgcgHLeElTl1N7x47U0sNthHXlydJZuQiqpHMUUdXv5wxf3mKMmW+P8Z+wS
         It2H331mnpvXKvMNsPCCPp2+1sP2kVJiwBvRiACvOFXkDH8e4Vh6x+rLEePD+CRgfvPn
         0s0xTnRau7RApXwCcAvxc8A0LFANkFCtslmHKM7eRBza465coIEboaPi1jnWWsNcLBUp
         CirsZPMYff3LpPQlPa32uSAShzrONq6UBZENuAYCOoZlcycLCWZJwt1n3D7VOkFFt0V1
         VRMBy/MfAtYwFXgL08fJ0jkaeC+b6KwM6hxWxYfxvCFeUbcleBTQ9K3SzE9uQJeEZ+qi
         EYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748639588; x=1749244388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWSnOvPKHr/lJuH5eM1BOiskSSeG00tK+eTNYLS0Y84=;
        b=Xb3W0e2Vk40krjsGUz2Dy1KZefyRfBQlnRfMgXgDYEts5hSARQwJQyzWZgSmTzLgds
         ESv1xskMRt1hbYH1+SwDgb8HAr92keNc36Nor6K2/TYUk+SLol8ZmJMe2bEIYdfdSRKY
         AW5WKQD/LuPM5NJ3G+8P32iC1ZQbXiz2v4j/tXlF9Gixq3+Oylf2eXJ1GW1Sb4GoZw4U
         HvXKgyQkZj1HMm7cifx+DjEl9iNpB2lAoE2OqZM165VP/UgRmtkaWqkVz0Spte/YluQi
         dE5ZeUmCr5A04CWkkKqwz7GMoWuXT0Jvx9eu20jk+9i/DVEI5sO9WIsT2cMqclhtpR9E
         ZX/g==
X-Forwarded-Encrypted: i=1; AJvYcCV7KY9teMqQ1SMeVYuoFnJWvz2xYWOjzF4FUcN5rBPrH6dB/O6TaabiW9MK1razGMHGxzs0zujNZw0pGWEMTTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszE91qARMNBozecscWtGpeY4pFYqsR4traQ4o6PW9AKvYkW17
	K+2682tHVHbHVTTk1xpu87ImKvwlFI2iB8fT5+AFOH4i5KRZncEfJRtMVhH/CyHXBq+erc9PX1y
	zQ4mcDQ/Cz4wxRGi3C/kRIvtQSI0HxzqfWBtQ88J6
X-Gm-Gg: ASbGncv7E3uwURpETp/aKbHLSe7vsg6/VPw0kSpuGKrlnmzXRCiphVfy9mcdk3seyfQ
	Q6JRnQzCWmp3FKWiYYmWETTvKZRFNNVjqTnOLfVmsbQp7eFowNzJv93BcX+lAr44KUFFKynyUIS
	oaSxJJG5K2uZfpWV8ee4Vxd4j6xae1ULFM6gJ3otZrIIg=
X-Google-Smtp-Source: AGHT+IE7ag7ZsR/pBlw7D1vdrH7BDXwUIjY8c0tVPudvcm4wziuE7Sw9Iinmnqbv2lM6zKFlMpB4iBzPBez8WQnqWeY=
X-Received: by 2002:a05:6122:8c0d:b0:530:71e7:37eb with SMTP id
 71dfb90a1353d-5308115f60bmr4750575e0c.10.1748639587944; Fri, 30 May 2025
 14:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <20250523233018.1702151-9-dmatlack@google.com>
In-Reply-To: <20250523233018.1702151-9-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 30 May 2025 14:12:36 -0700
X-Gm-Features: AX0GCFv2NK3qgZsM3svh8Ufi47vnPMWzuIXew7qX7EySA-Brol1MrBvlIdg3tv4
Message-ID: <CALzav=fJS69JeKa-t6ze8Sx0Nwp+y8zRMfFu0RUaCoCcZR3jYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/33] vfio: selftests: Validate 2M/1G HugeTLB are
 mapped as 2M/1G in IOMMU
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 4:30=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
> +static int iommu_mapping_get(const char *bdf, u64 iova,
> +                            struct iommu_mapping *mapping)
> +{
> +       if (access("/sys/kernel/debug/iommu/intel", F_OK))
> +               return intel_iommu_mapping_get(bdf, iova, mapping);
> +

Oops, this should be !access(...).

> +       return -EOPNOTSUPP;
> +}

