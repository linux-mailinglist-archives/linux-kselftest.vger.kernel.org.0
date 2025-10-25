Return-Path: <linux-kselftest+bounces-44036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC4C09247
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214AE3B23D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC92FFFA1;
	Sat, 25 Oct 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KEA7ztmA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C73002D0
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403966; cv=none; b=o6Hr71OZqiGUICcdD1NaR4A0TvkMlhIbOqPnPsambzv23U4sNcUhag5lzXL86gY77Ksf6WtCjfrNYCOz8teaz5g0ogSP4zHfJi0nejPslM9w/9H260Z0MZX3qr2SuocCRPOIwgUrzleS9xEQH+vKXbWKkiucytmUEmYkBT/E+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403966; c=relaxed/simple;
	bh=rxkH9HqQp8MJpuSr9SUPPrL1eIBYUI8t2HD6mPry1gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMmw42nATheQSRnwRV6nkq2DXgSNZEqtsHTRvP+ZJEadKm7wbxrwXSHz+GsjD2OrY/SSGEyyjux2IgI7zCPSOwxjXlqPp4FLp3dPOtl36gv0AyH6v0oEnSsbbKxl2VPNejA/b6IQ40YPwGn5rblvwDOrvCwoa+5cfJzthBjmO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KEA7ztmA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63e18829aa7so4341366a12.3
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761403963; x=1762008763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxkH9HqQp8MJpuSr9SUPPrL1eIBYUI8t2HD6mPry1gY=;
        b=KEA7ztmARobV9Yc1iR7ecvxjk8qwLXPA3I+hGYCCySYVsd3ZaoRYuccAJxJpcCNajz
         0DOML/K0LK3WKvi+qHMgK537S65pXnEzW/+aLRSw+yxO/cKfBkQH68q+P1PoUUqWfuSh
         X9s/01f2ISuSzjDFLwIsc3nCfwlfCfk2G2uKcoy1+ULfEPg1p2G30G8VYOWeOL9lxBvm
         OZmkNaRZfvgFuoJ5PJtl0i5eUanKw72UqXbFaUxSWNRGWTc/yzroeoXgJdq3JBjigQnb
         E99bTcXDtLZ4iyAkldlynod/4Ww+uW8Zuh1e9dRTDnBCgEc9zh+vi4xUonXmLkhGt8rZ
         njcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761403963; x=1762008763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxkH9HqQp8MJpuSr9SUPPrL1eIBYUI8t2HD6mPry1gY=;
        b=uyC4yLAgIrHLqzhNnajuqsjDZk4qCASEWzP7uSKWI12/GIsIdv5yI2wCX6f8AGZFTu
         3sTveK6yKhuhPjyqEEAbkgAxO3rXKQdh5rHDXLqKVc6dIJeX4i5IZaBmvqvlsd8Ze9Ku
         DhIyopFSkz/91IOE0ERkNZ+CjY2lZOWXeJGE6cFAnFaQQVx/pNj9MrcXD28S4X12vjxD
         J/tr68ovh5IQQxt38dQr7a396LrZCCEzVOsgdro5X4KS66gJqN+7Txn+kb/6oV4pl9VK
         8ybk6LaT/mqFZgPXnwEPYT2QOfRWAcRQG2BB6bYuQBuyyjnXpl45M35Zd+p8VfQ/fEcZ
         hkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6APy5E9VIkgvV6pS5dlBo1DNqY4RNst7oq6w5z+bRKrNBa5HdQ86r4l0pK5mIMAaK39teXEY93dJZ0T6hbY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNeWSGTd/PeW6buaHK2nHGZ32SnKrzJuVjUuNef2PA5XJfaOx
	bh0/sdpJFFfatRluMKhkRH3jYMBoY/ajfa78ZRzJSkdVBWP0K41zkUtW1YNFkZf6H89TIqh3Q58
	OveLQN4f2JNBwIuGIqQd4AinkZSuAkynZ2cHTSNi4fQ==
X-Gm-Gg: ASbGncuj+MfF2AHbs+MkWDED14YR6f9MBj4+bD9/ygiPgAMMV2lCXprDyh/Ks/DZuzK
	h/ZOvGgtKsifDNceBbMv7mn1XS3Q84AJUYRK9Y8m+MF7Ws0wT10Yc5C7utG5Xmewb0YLbmfTHLA
	odbuCA0xPPmrWIpaV3xkdVeG1Lsa8GD1+MEvwBra+nf3MHsQ/d+uvsLv1ZDQJfZ85cJ4PAX/nd9
	tgPIAebHUJ5SZ860zcOxVgWQCuaJpsUQJqcWNbj1ZSQH1aWL6v88h45lre55fbjMpock4mftVHd
	G/nLfULp+i2lKMSHsqQs3HGalzkM
X-Google-Smtp-Source: AGHT+IEEmtC5AP/1Gyl7o28TLb62A6fjQmpgJI/nFlghPy3b8TZfgzFAjEpwZUdPvlcd5pyK5S+BLKOml0q59+GzhB4=
X-Received: by 2002:a05:6402:13ca:b0:637:f07d:e80f with SMTP id
 4fb4d7f45d1cf-63c1f58c0d3mr30957969a12.0.1761403962844; Sat, 25 Oct 2025
 07:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 10:52:07 -0400
X-Gm-Features: AWmQ_bllNz8YycDjixpyqg8hZuOQcw77RRZ1nqOvRZhBjS1lHQKHtPcetSr4uhE
Message-ID: <CA+CK2bBvCytQhJ-DbgBDUo-MT0xtuXNW=yzX3StwaNUj=JfnoQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Consolidate iommu page table implementations (AMD)
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: James Gowans <jgowans@amazon.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

I tested this series via iova_stress [1], on Intel, AMD, and ARM
machines, no regressions were detected.
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>

[1] https://github.com/soleen/iova_stress

