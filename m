Return-Path: <linux-kselftest+bounces-5556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007F586BA02
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFBD288F88
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88C7003E;
	Wed, 28 Feb 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcLPSQyO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30570033
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156096; cv=none; b=ZaowenxiFSP88CmNVKg953jx8hD1cAFMrQiyPbj2AgwYM3742Obot5FDo0y3gE5A3yQ7Td9nKE6hgNbOegxXjNT+QpapA/LL5BrqyaobvovWcShpqZ60JqLMxOt71UKUzMELHND7z13+oPteClQjbUSJW7OV5NdLXJaiJBn4bU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156096; c=relaxed/simple;
	bh=hYKDYcEw5lHqH2aRTYPwr/dy/RfHP5zZ7HjM/dRqXn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ftmbQnzBuuS2UG0cSuVSuMQWjRWcr+v2EKRfwAnVPW0Ch+TmF8Mprtm8HmF01Q4shf2fmM3OG0Ckx6pHuo7MdwbY/XPEJFMdXttTZYuL2XKDpBSv2F6IvYkpLVCNwsSMdFphcekgZOudiVTshN6/66cPtve6tGEcGw/CYn0m1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UcLPSQyO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dc435b3e87so2364265ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709156094; x=1709760894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XXg0IkU5TUPFv8zc80T7AHB4FtUby0AfD+GckQIvQA=;
        b=UcLPSQyOeIiK0wylL/NBmVbjHt3P0pyG3v/m8DYkEENMwHttJRnaQWuwJ9ucwI+6aE
         ShGU1NoCZz9ibuG9IrbJSxhO5im8yLcYO3kJE9mrTJno4xXQPV29Pla+E/JoySkVCkCi
         itBtdkI7oVCTt2k6Nbms9/y2GEi92U8n8aQJxY3fFa3eFDrbpRjoImZyl1NQX5FlFBwn
         EYPD/BDpsB+BqmSN9sipdbDiWbT5zYZmHoAxcHZXrpynnubWfa1rbnZkbzL/zm86MwA6
         UkZn/rjqPCTEwfB88g5OFED7xEQE4m1e6wnGlhPfUDWWPG7+cvLC0vOXa4aLnIckiH9x
         +c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156094; x=1709760894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XXg0IkU5TUPFv8zc80T7AHB4FtUby0AfD+GckQIvQA=;
        b=S9Q8oui2UgUbnW/ggvq8VMtnu+/hhNi1+1BvQvVd69x7VDVbyBbc/I1PDihAR8eNAL
         /dFuA/LYiPdWyonvPEHHmRHnT7cDpNvau+5aCXSXstHOLGnf9QYd8dc1zJt2zhhw0GSs
         OZWb+uRK8ypppXv8GpjGoJzLDN9wmAT6tNv3JWPbBzxPX2XxACjTve1IiUT/b17IjO4O
         dA9aXjlOTnRPoKJAZkf3WPk3QajrQvV/14dr8D+EiyIEpHXyI2osnmefWOlrvAFAm6qo
         7AD9x6taF+4QWeMTTEPN3lblTB3xJYtcYMwUzLut+YgIf+6iOrKmTFkHlnL77mB9NFWL
         ERiw==
X-Forwarded-Encrypted: i=1; AJvYcCWdSHK//u+nRdfGbuoT42u6SWNoWPaRlfmcJdQ402nRjbG3CIyX9AHe5NY8f6l85Lovtc7qkMPJyy7mbN6xrj4Mxm+SO4xA24FIDoi3V9S4
X-Gm-Message-State: AOJu0YwXlfSSqtd3TiYBem+JiPFmohKOfQPWCD6myBVT2DtZxCdnX0rV
	pNixAjeXXXHfdJyoNePiFlNUnoCdX4/owsOAdAChmEsZ6NgDf2gplY6uoItV7cMCGeGMpOn02u4
	lYg==
X-Google-Smtp-Source: AGHT+IHSa/71jx2w7IQMMCTRY7oSd9bBuHsHilIQ/kXSBHYoaxZh4u+KcytiCqhfbrsj61dcHuvEZ/TgqXQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c3:b0:1dc:b333:f2a4 with SMTP id
 o3-20020a170902d4c300b001dcb333f2a4mr463plg.12.1709156094095; Wed, 28 Feb
 2024 13:34:54 -0800 (PST)
Date: Wed, 28 Feb 2024 21:34:53 +0000
In-Reply-To: <Zd-lzwQb0APsBFjM@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208204844.119326-1-thuth@redhat.com> <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk> <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com> <Zd-lzwQb0APsBFjM@linux.dev>
Message-ID: <Zd-m_WinXvoCmMCb@google.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Marc Zyngier <maz@kernel.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 28, 2024, Oliver Upton wrote:
> +cc Raghavendra
> 
> Hey,
> 
> On Wed, Feb 28, 2024 at 01:19:48PM -0800, Sean Christopherson wrote:
> > but due to a different issue that is fixed in the kvm-arm tree[*], but not in mine,
> > I built without -Werror and didn't see the new warn in the sea of GUEST_PRINTF
> > warnings.
> > 
> > Ugh, and I still can't enable -Werror, because there are unused functions in
> > aarch64/vpmu_counter_access.c
> > 
> >   aarch64/vpmu_counter_access.c:96:20: error: unused function 'enable_counter' [-Werror,-Wunused-function]
> >   static inline void enable_counter(int idx)
> >                    ^
> >   aarch64/vpmu_counter_access.c:104:20: error: unused function 'disable_counter' [-Werror,-Wunused-function]
> >   static inline void disable_counter(int idx)
> >                    ^
> >   2 errors generated.
> >   make: *** [Makefile:278: /usr/local/google/home/seanjc/go/src/kernel.org/nox/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.o] Error 1
> >   make: *** Waiting for unfinished jobs....
> > 
> >   Commit 49f31cff9c533d264659356b90445023b04e10fb failed to build with 'make-clang make-arm make -j128'.
> > 
> > Oliver/Marc, any thoughts on how you want to fix the unused function warnings?
> > As evidenced by this goof, being able to compile with -Werror is super helpful.
> 
> Are these the only remaining warnings we have in the arm64 selftests
> build?

Yep, unless I've missed something, this is the only outstanding warning across
all architectures that support selftests (sans LoongArch and PPC, which are
pending).

