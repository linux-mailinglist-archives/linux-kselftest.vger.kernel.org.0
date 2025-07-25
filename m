Return-Path: <linux-kselftest+bounces-37998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBCB1224A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E61675C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5D2EF655;
	Fri, 25 Jul 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noJl4hdw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3B239E75
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Jul 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462100; cv=none; b=aP5Xc9nTJpu/T0UZQV2NUz+VRxwQW+u1Z6WXY/OjcHpwCy+5YKJ3hamSHjSbnyfNXO1zOyIkBy+LW2h+7EaWjhXVRrgc8xzYf8ESx54FIEczpzsri2mMHZAi4r9br1G4vX/pMI5ujqBzXRa5uCq72NMCNNQInXh9mXOuN+0C0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462100; c=relaxed/simple;
	bh=ppQd582oZginp+3pcQAfvhafTXmi3sug/cDu6IWhOMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFrclm1WT6PVoFaCxHT2bN98hjBmwm95a/YVzMcHFuuCwuLOKO5yb6qzx58OUxlAa68+zH2rrH54H9j8j0/slh4nK77kp+NyXur1t1tOqY8Bt/wpgzwLn9KEDfSJT0914m95fu66odoa9CjbcOzUyRF1wfLHulR+JKIdTiSGA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noJl4hdw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55628eaec6cso2175082e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jul 2025 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753462096; x=1754066896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppQd582oZginp+3pcQAfvhafTXmi3sug/cDu6IWhOMw=;
        b=noJl4hdwx2RCEnbOzgDSRQFrGxhSfQkotnKKfRVP8Qiodk2eN+UWq2+lNgX9915l66
         RZEBtjt+IpEVCCFDzon++/VNPf68Sg7vF3NlQ1b6W1ULYE3UBTylCZAdc7w2PvZNRrj1
         p2VK6pB2rCdj8PAvE1BiIaRkdpaEnWqD5k6C6J5R8JtJ37ayISSM5HceuswfsoaZNVew
         5dw6dYKKIHbmxYG55rqpFuuhCpL5lO1GAbYKRBJTuY+PIi8B5XTofkkSfzeVu9f/8h3e
         59ACh+6uOpTU603NCQvxKu7hwBz/LBSM21MdLDDys4QmYFBRLCdxlylmeH2bTIn7hnx+
         r3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462096; x=1754066896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppQd582oZginp+3pcQAfvhafTXmi3sug/cDu6IWhOMw=;
        b=FGSPtl/Ri9XpvFB51PYyCfBnv2t00U37CClvKE9S594uN8AaCXqoccofLPRflg1A4m
         rAH4jdX0rKYVqkPJj9taqRCBJI14f5WaQt6zFAJUeWIFAi23Sb2zmatJIT8rZEP6ms2F
         XoJPONJ1Hzq9aBafsDSauCy6r3NJgLm2eKbZXM1873Niu7chPe0ceEi7Jtgg584ndRMj
         jNpdHNfzlgeRFWa5Fzb4XYmW3YMu6GPY+t74e6hRBk4N5fe0blnkV0oYuQeSfzSIp9SG
         RH/W4V6qc9ehAqc0+ulcr87Tqr+ZCwbd+Q6GbZg/i5kJuYznmJG1Vg97M98uk30QGjyh
         ykxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnF21hN7GYK/oaJg60DWw50mih0nBP8CZGYtvs7qhHb7v3tZWeFTR6AtWEe9nwmrU+NYoo6QIjwG7Zy/YeBJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXlUbrmMby0/Uqy6cxM0Yuv1aBjY+ZQ5pyILojfH7zcAMUdbT
	GmbEXpwZjCEMOL6xmfnFwli78CYg11OKzfnqYe4COsQnQa7dRPTWxkfKINjNFqKEA73qrB3sC7V
	BtSl3BbT8v2WxdbtQ9xgL5JNWSg8X2OIy5WyAdJrB
X-Gm-Gg: ASbGncuL6m19eLE3pUTRaQI89YaU2ANG6GIo6K18rJkajMQv5a8dbphv4MaHcle+YAL
	K2d1MuCALM0ZFBox6NDwiMWhT9nUX25LkkwIkKDp//6GyAQ62fLmnd+yN4fBU7CdFhhQPsabSKo
	AtYStzK/ALFAmkAXVL0Tgo/NQXlRBWbbMylPe+ac9QMBho/ZQ0/0pXfs7D1uogsmSE01b/z4ypV
	kHVJlo=
X-Google-Smtp-Source: AGHT+IHRFHPeqj4nIOtWh6Ys6eD3VO7gQX4V7dsVKR085JKaRqkPB/v1BUD9NdFQ0WfSjcyFuM7LsqS6dpAfH6dAKiQ=
X-Received: by 2002:a05:6512:3050:b0:553:a632:c7df with SMTP id
 2adb3069b0e04-55b5f3cf5cfmr661229e87.11.1753462095911; Fri, 25 Jul 2025
 09:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 25 Jul 2025 09:47:48 -0700
X-Gm-Features: Ac12FXxyagwElMOCi051dyM63Ch611iKG5b_MU_nG8G_LbqFaLPO58JmZEy3jU8
Message-ID: <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 4:21=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> This series introduces VFIO selftests, located in
> tools/testing/selftests/vfio/.

Hi Alex,

I wanted to discuss how you would like to proceed with this series.

The series is quite large, so one thing I was wondering is if you
think it should be split up into separate series to make it easier to
review and merge. Something like this:

 - Patches 01-08 + 30 (VFIO selftests library, some basic tests, and run sc=
ript)
 - Patches 09-22 (driver framework)
 - Patches 23-28 (iommufd support)
 - Patches 31-33 (integration with KVM selftests)

I also was curious about your thoughts on maintenance of VFIO
selftests, since I don't think we discussed that in the RFC. I am
happy to help maintain VFIO selftests in whatever way makes the most
sense. For now I added tools/testing/selftests/vfio under the
top-level VFIO section in MAINTAINERS (so you would be the maintainer)
and then also added a separate section for VFIO selftests with myself
as a Reviewer (see PATCH 01). Reviewer felt like a better choice than
Maintainer for myself since I am new to VFIO upstream (I've primarily
worked on KVM in the past).

Thanks.
--David

