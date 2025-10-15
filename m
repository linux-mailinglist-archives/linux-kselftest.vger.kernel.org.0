Return-Path: <linux-kselftest+bounces-43205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89CBDEFF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE01887146
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61CB25B695;
	Wed, 15 Oct 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ewu4UUlH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94934BA37
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538188; cv=none; b=ppm/lowvd4lfb2CJscD5DHmCfluE1Lj0OhxwGyaEjF598MzEv7f6T3rRzbSZKl8eGvMde63RDrzgZ2Mmh+TOJTf2KFuVshe3zpLsxf/oRD+4gPhK32BCMcDkweUPRt0Tug7jZdJ6rbXlIGsEJMHecg5j00q3EyU37TxYxbjNDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538188; c=relaxed/simple;
	bh=PAtt6LJWXf75EYio9dz/gTvlM96/DYgKuXEluISNUPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tq+CEb4WXfOxCS92mSKH7cGFEyy0so37X6Z8rFiDKJbTkiYt9u4YKh1oIyk85KHwt7PBpWyMpvI2BC1Izn1HJnVBB0/6rjIEcCSa/ox0Jiaqhu8hP3BVFjMUpMTMqQniBKDJKYLPQAxZwyU+iE/3aIV0VyHlea2jXzucoIMTKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ewu4UUlH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63bdc7d939fso3230168a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760538185; x=1761142985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PAtt6LJWXf75EYio9dz/gTvlM96/DYgKuXEluISNUPw=;
        b=Ewu4UUlH+4pBSo9+9WLd3Fc1lhrubptln5vECsDvqMML0lxV3mn/0IGWx5a/WvBeVo
         4RaV4Bzuwodbclq7xpOk5uHZgse2exRR1RKJ/mtlCqitoF0r8Dczop3Zx/wtlf+xk/7S
         xiMX04fBVZ77Z/bMd11JzGwnaQUnmvbzbemZpIOUl1vrC17f5pm+Bd44EmsllE8RzJAM
         urnlJ83WYpPLA3vwO9r85oa70Cn7dQGT1wuEIrNV91cRRYJk/E7l6XnU8x8LPUhEFqvP
         cNeBGytia/N9JrUtkHrN59QlRZPB1OcP2TT4PmyvkEL7K4p1MUewjIrkIURhEstTmxab
         Ef1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538185; x=1761142985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAtt6LJWXf75EYio9dz/gTvlM96/DYgKuXEluISNUPw=;
        b=KKzHcn02BPWNR7bwXYjhabrG7EozqPl8EcH678Pga8NYLpX+MGCh+8iA0nRqQHwVE4
         +KIts3+OPGY20L0kAlm8TaQ8ce2B8JhA7PHss7liJ7C88lszyLT2wt+ADvPal5zFSOpJ
         fB/kIn7fFAwe/okiB8cRxH8FaTi9xkk3V0dqS5BOGdMR0WSbUzUm2p9KCJcU4xC7wWjk
         kRJ+C3uJexTHh/xmh32NirIMVOUfIo9r0Zq/Roq6qNK0Zp4SraCxY3flWb3oAcWhzeA2
         0DVFy+j9w1fxJemkl0yAzDgoGyJnxD/m0TKoSVmeucU+FOUMYvVIL8fcvG/UsrLHchmj
         a4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWSTKx/KColZXSLW84YZCKUp9taBnsSTMgZwQQB9PPhCVtMTmi7OaaPQwOZnCfGtGba44nAt9jHp7PTNvC+2Us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ghkuKu8py4KJ7I7NCw07DGdKxVtO8IzIm+tam1dLbXGa/66t
	piyTWxLGrothjGE5z2uaFuiFkIfreMMLAYtLjWZ3Z3uUsL0E9yKCIB06a0W3LTAFID24VxjVxwf
	0tow9Mjcn9biXL6SxIg1Pjz9WvQZHIrFtnErmlSwuyA==
X-Gm-Gg: ASbGncv3qqPvXa608n7rI9tjmFAks3wqco+fX47zzipPOjftyeXKuYZYcSjiX1ie86G
	UGSY5M3n0bGSkioo9JJu1zAd/4F41c6q+3BnqTf2y/OSbTahEoc1jX8+zJTy/9rMLz/uIDVkAAF
	9ccvc0y84djBZmVQomwJ+tM8GqZTUKX/1G303hQyoKTPNrOoehvbRWJOJ06F+J5NZdaBm2ApPXq
	EISk/J2Q9I9HrmMCtqNiTUnEmwihiXL9g==
X-Google-Smtp-Source: AGHT+IHt07hyRkueoFkR4F0w+xF9Gbyc+PiDwaAgXzfFVpNxzbBZcK46A+MFwX9oxnYBoVi3/21yDow56czseXIBw9E=
X-Received: by 2002:a05:6402:27ca:b0:639:4e0b:2724 with SMTP id
 4fb4d7f45d1cf-639d5c31fbfmr28772103a12.24.1760538185250; Wed, 15 Oct 2025
 07:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
In-Reply-To: <mafs0v7kgjoxq.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 10:22:28 -0400
X-Gm-Features: AS18NWArNFoBhagluGBh83EOX5thK2VCtA_UuHBzGdmFvoOqbuMsR--L8cHX_oM
Message-ID: <CA+CK2bAHk2JnQwfA0fJo1qmcwoO_9eeG5_DSL_6OC+-pyT=7Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	glider@google.com, elver@google.com
Content-Type: text/plain; charset="UTF-8"

> > As part of this change, the metadata bitmap size is increased from 512
> > bytes to PAGE_SIZE to align with the page-based allocations from the
> > buddy system.
>
> The implication of this change is that preservation metadata becomes
> less memory-efficient when preserved pages are sparse. Mainly because if
> only one bit is set in the bitmap, now 4k bytes of memory is used
> instead of 512 bytes.
>
> It is hard to say what difference this makes in practice without
> sampling real workloads, but perhaps still worth mentioning in the
> commit message?

Forgot to reply to the other part:

I agree, however, I suspect the implication is going to be minimal, it
is strange to preserve fragmented state and expect a fast reboot. Most
likely, we are going to be optimizing the preservation pools, such as
using 1G order pages for guest memory.

Also, we are moving toward preserving 4K bitmaps as part of the
Stateless KHO patch series, so I think we will make this change
anyway, as part of this fix or as part of transitioning to radix-tree
stateless KHO.


> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thank you.
Pasha

