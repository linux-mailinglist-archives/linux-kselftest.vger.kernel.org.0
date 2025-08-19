Return-Path: <linux-kselftest+bounces-39327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D241B2CB61
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2F189F178
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8B30DD04;
	Tue, 19 Aug 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQpLuwh5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D32206B8
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625772; cv=none; b=o5rE9drqePYCg/4yqyuJm65upLCh/3VsNyeNy3UkK20qdIx02FlvYGMB1xTrGUEDIUnk1N/zW0Mkh0XXXoAWT+mVJCjk6MYr+jmOjQtOtJzzdp0hHwYX2Mm7ed87hmuj1Af8XqJ2g/sN1/Sq61Y2pVWi3LPhSAZGFUU0Lf7SyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625772; c=relaxed/simple;
	bh=YWkp7me/aGAqDor+8g4ul51C+lYC9lu/O53kvPxYg4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwFmOiTL4dh/nq3qoQx2j+zuF4G04iwhuy1WCGESaHDxU6X6xt5353Ts19wlPdahzd9grYrhPUMszYiWntnqnFB9eS2CIT/w7ktgqItzOA0t92kjSw8lhRRpaWCftoLLRkwi9HoSIRvg8AVQV+cR6vbK/ewI1Tps0Dui487f8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQpLuwh5; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-50f88cd722bso1676141137.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755625770; x=1756230570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWkp7me/aGAqDor+8g4ul51C+lYC9lu/O53kvPxYg4o=;
        b=fQpLuwh5yNqxvx9BovYEUoVO+U8lWGFmgEesys7A/OYKL61yjBESefcISBOmwUZeGH
         3yB8ZFvi9hdElBnMaPONv1t/vtiFRQ02WNr3Dh/DfRWhKfEF9CBioPzfgyxsgJjzceUe
         a9wix2Va8aRJe4II7SvrGrqjrYSUvRT7k1/3v7UE1Ejkyuhy5LrzrDlJDP3SYBts1jS8
         vyVp3ZGH9bHftyzCazeD7IpKJYxMZvyzt4F+53YG9kr/vFo0qSyWTajVVAd0WWuUf94h
         GjbjCKVb9hYhhweO9vQE7b318m9OT5IvzoNM0WfV8p+cU6W9cqYMxqoMubxtYa5biAIn
         cgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625770; x=1756230570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWkp7me/aGAqDor+8g4ul51C+lYC9lu/O53kvPxYg4o=;
        b=HsYgfNesJhEsoYufR/5+/BneWJSt+N9xBfBiKmiPjXayeMBynJEaHnU0ls25lUCYX0
         YSDbLCCLFKlhaX1vJs1g25hQbUHpAy2TfwwJoaafBfN6btN1KukpVAcM6ldFtQH1+Tnx
         R5Gg9YHB0iqtczjonMLrJt1RmV8C50/ml2m/JTpFWlI15pBwIN0rR7xH89z8XsxEpR4h
         Yf/5RsP/Pn96VzEmPvuJo0Uq3b478pFvNpByJMGq09NICWb3qP2rNiXH3Vpwk7+xPsxR
         zhqv1fBdJxz0gz0J0W1cPZjj9SKTN8XBWRwSNQbU8OvLf3mraXT1t3rHu7sIg0HQmMmy
         2L9w==
X-Forwarded-Encrypted: i=1; AJvYcCUyZnQPGga8VyNzfGSiYDMJJF4jCHx8nzzfLJgD+5BGes1W6hJ4QWkfTp4WMy29Pcga4aO8AYtsn6dp5ZT9v1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywft1oVToS26ZJayPBCTaFH8MElNiXvz+bWj5R0f1yLno2jj2r2
	lGMrZ2oHUesOIaqsNjqmuSAhHYhrD75xAgK7nxLGiog8Kk9Uyc94MSTpj7Bg2Cd26gq2VQuOhkX
	EjNvzeMxL0r17UmJ8+p6aH6i8sN2bu2l1Oy4iOo4G
X-Gm-Gg: ASbGnct/8OhD6Yf76aVkb5VZsrgSwpIY2fBEnKl+xKd2Grw5OgP2jkkpQxA2VOnHxVX
	wfHkeGRQTPzIEuP6CyxJVjOFRf15p6pJLtAOlStqA9q6OwGRTaPAyUjMG1MvsxT4UuJ8PC8bD+1
	0P2/Jq1ZJ4ffnEh4oVl8O9R6Z8hb44UNre8/qpMZDTYg05m3+EeKDDVNq5PD+zLj79H/Tz84hLL
	khU9APuuSwIsA==
X-Google-Smtp-Source: AGHT+IFhwGbrpihJuRhLUkMJwZwhp7F48vbVUtNc9cDlNYXnwMfD57uFUB1fnDEYXaM+LrUY65InbhFraP2uGeXjfLE=
X-Received: by 2002:a05:6102:290e:b0:518:9c6a:2c03 with SMTP id
 ada2fe7eead31-51a52a18e04mr12948137.30.1755625769614; Tue, 19 Aug 2025
 10:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <77qzhwwieggkmyguxm6v7dhpro2ez3nch6qelc2dd5lbdgp6hz@dnbfliagwpnv>
 <aJtYDWm3kT_Nz6Fd@google.com>
In-Reply-To: <aJtYDWm3kT_Nz6Fd@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 19 Aug 2025 10:48:57 -0700
X-Gm-Features: Ac12FXyvmYoSYuILjgZtuLq3eWcuEq7lOvEZt6VwwKRTWGTNC68lrUWFoa_zNzo
Message-ID: <CALzav=caCWiZ1oS05ZpPNcE1cVVmn8jk9xmbXsEF_Sqexq03JA@mail.gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
To: Joel Granados <joel.granados@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:04=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-08-05 05:08 PM, Joel Granados wrote:
> > On Fri, Jun 20, 2025 at 11:19:58PM +0000, David Matlack wrote:
> > > This series introduces VFIO selftests, located in
> > > tools/testing/selftests/vfio/.
> > Sorry for coming late to the party. Only recently got some cycles to go
> > through this. This seems very similar to what we are trying to do with
> > iommutests [3].

Joel and I synced offline. We decided the best path forward for now is
to proceed with VFIO selftests and iommutests in parallel, then look
for opportunities to share code once both have matured a bit.

