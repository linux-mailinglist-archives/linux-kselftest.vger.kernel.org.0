Return-Path: <linux-kselftest+bounces-46457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA648C86411
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC123A95B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C39329E60;
	Tue, 25 Nov 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DW7CYnxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B36329392
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092344; cv=none; b=Jd+lS35dAxvNJQta1RKC0HNI4tTjLjLo3QBOIpIE9wj/IlMuPjPN0/iVZ0CtY5O/+Xnzm7g0YNGFg3fTSQT/nTU40WMI0KI8raKppcj2LIR5v/YaWSnIX3az5I/w9u894pPt5q/6lfh8vSQyoD+rJLAwOl4vdffodmj9cv3/xPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092344; c=relaxed/simple;
	bh=hYpKuwg+6qk4P1s0BVsJWxLzFkie37j9EJGGxbty2O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flT91Q/Pglufcu4BwX54Gralkt+i9y9qZbsoatYpbWRWhugndqjgqDxtpH4hwLDONcLy6IfzhEsb3e6O1K7kglyoy2tLdRMBW8xdu9xBi3CabpsF6fb4BHWww8XdhzIFSYD0l7A83oX2g+GZ1+VerFN06g4IDD0sBefXE9SpreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DW7CYnxR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-594330147efso5980116e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 09:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764092341; x=1764697141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYpKuwg+6qk4P1s0BVsJWxLzFkie37j9EJGGxbty2O4=;
        b=DW7CYnxRNDbpyakHdtjoLBg1YOyAMn2KKBGzKdzTpfQz7B0e28llGf2GO2xej2ocTc
         tYd55PteEgoj6BeTV/vzzu8dMj/Z3nWaHbXB+CzNpk5XMdFwO60ndxNMsWrW68Ms+vD5
         lZzNusKARXfjGm+FfViVefDbCo6XAjlu3Ld1SvRSoHMcCOCYdRaveCoat8khQBByI2PQ
         uQgsRfMmFKeQugdokJTMVgOQmMTaB3D7LPeo2sYnHUUasUxlqCeFWrfL+HJjssrHZzIr
         ELj1HStCz5kAbBGRLeYSogq6TSKmukp6Zh2V7gaXl8cPEr/rBc94omH79fkPtSnXqhSr
         XWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092341; x=1764697141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYpKuwg+6qk4P1s0BVsJWxLzFkie37j9EJGGxbty2O4=;
        b=WxaGcZoj+2b2wqXspQOk6NNdLgU10D+GjY2EBHXdKU8JN1bTbYyvyv6xpGAHDCF9gX
         E4zwCkjzIsFAb8d+ql5w9PLEM9O7eaaBk/Xc+uQF+RDKs10ZT3vg+ha87plbqjSegr8P
         NmhLTTHXiEFOm8fAy+pQJK9mWaxqKkhvx5nmdPIdpQoCTTOtZahC9TCxADjx5y5qnXh8
         mRNl1z/CcsStqwYX2LWuJJnTg1cxaVy9JzyJHBCBaEtMIUHc01rlFJziuojJCo21/ayu
         uZuFzwPERLtpAsLFceNN+qTlprZRmedkCan4nuBd4Ls41DdTcdCr+51aAMlMng+22Ly9
         Yvag==
X-Forwarded-Encrypted: i=1; AJvYcCVIzO6xvpLTxdhk98os2D8gOrCa2h2n01hhSCvbyrZkUL1LJuXnpAiLqjYmuwj8bSzo0CxufRFzR2LUwUyMfSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHltxNDkRU1X8rfdsWtmKZrmJqbTl2RFpxiBEmMtyQRhDNw/EY
	v8/l7Nbq6nQSnc5dTusDOFIghWsNTnb3ppORgE4hUkTWA3XD99hJAstIq03aXM3NROP3Q1XYspV
	vZrf9IJuLiL3a+KB9MfanfL3JS1l60ZcRs5OD2U02
X-Gm-Gg: ASbGncsIat8MpuTh3RxHzp0VGqaiHFyHX8p3oDauMWzxkoOOVp1EM3s9Vbip+ZCNi8J
	/6Qa1+V3shOTmLgwtiDPXK3vmsRuMjoW0jOTKvAZp/NTr2K+xnOpwQk4c7VhBQS24HFfl0+t5hy
	SRNizyU8Oav+Kr5HAdnVUHEx4p2koeKBiQx1JYHcCRKJpdbn7o6R5gHmmAT9pllwRGBseeY30SB
	H8rd4DEpKD9HURNTI4IVDuKfBAKk9Q3qOP7W1jIkwXlOEKDwffqEUd0b9OEwDsS1vat8KFtzOn1
	jegdWA==
X-Google-Smtp-Source: AGHT+IFq+pkA9wUXo6O1YuyXrs06FlYpW+bNX4EgX0RqVurgQxcjqXf5OCpjt4Cav6Vv/IGQxFOOMXQu/61PgqQPYgY=
X-Received: by 2002:a05:6512:2398:b0:594:2654:5e65 with SMTP id
 2adb3069b0e04-596a3edac23mr5617787e87.26.1764092340301; Tue, 25 Nov 2025
 09:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com> <CAJHc60zkNOrWtzEPr00a6=fHpcW1KmGRu7Txcohe=LHnS6OL_Q@mail.gmail.com>
In-Reply-To: <CAJHc60zkNOrWtzEPr00a6=fHpcW1KmGRu7Txcohe=LHnS6OL_Q@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 25 Nov 2025 09:38:33 -0800
X-Gm-Features: AWmQ_bk-F6GfHzkfFixwREJH6feckFCzraz_YXkqd1eUKsaSXAISX2Opcpq0vY0
Message-ID: <CALzav=dMsiA+a3ZKcQmrYhV+nZvFVUTKifEs2U7hsxVmVWrL3g@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] vfio: selftests: Support for multi-device tests
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 3:20=E2=80=AFAM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> On Fri, Nov 21, 2025 at 11:44=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > This series adds support for tests that use multiple devices, and adds
> > one new test, vfio_pci_device_init_perf_test, which measures parallel
> > device initialization time to demonstrate the improvement from commit
> > e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").
> >
> Apart from a couple of minor nits in patch-6:
> Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>

Thanks Raghu!

I'll send a v4 addressing your comments and the kernel-test-robot
issues on riscv and i386. And then hopefully we can get this into
6.19.

