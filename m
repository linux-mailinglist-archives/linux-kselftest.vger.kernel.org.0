Return-Path: <linux-kselftest+bounces-39828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBEAB33D7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 13:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC19487DB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC12DFA22;
	Mon, 25 Aug 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nCOJKiJs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0681EA7E9
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119762; cv=none; b=PDx42X3H4TcDBSPMOsyZ11frgiGVtR5ZNJooG5irAosd3R5K+QbCo3ORPCj4OUhGSNgXT5g6sSmgynprxSAysChT/w0tJHbfxCfNxHjzij630NvgecUCtqGfu8yVAG3/Klw6vHr816u0XdQaAzW9WGUyRPvUHGofr/POIhJoPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119762; c=relaxed/simple;
	bh=HHzUYhwlozHgD2yKHCQ6VbSRe+a2+HdrK8dJd5Ripyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lByWo3yn6sT02Ae75ZcRKhp5i8Xe2o5tdkC3aBynaHtSSI0jSKHEBJydTBSw84JHvKP37ARu48JDo11juY9j6oVJcP+/jVG3E3Bn8yURpsVunUwSpdWosrd1NVUtnTabH2OMXgHWNdgjR7xDK02ia5UMhtcO4knx/IH7B+fraNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nCOJKiJs; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87030df79so477830185a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1756119759; x=1756724559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KrFoOnuL5GMtaq0YKgHhpMxoakpxp6Ykplg7n1PuXc=;
        b=nCOJKiJsZqcFQH/AmZkScDKmKRWRzDLZdsPQaFWNFZDkkzMRzsuzju2xqCln4JaCB9
         1gRqLx8b5agj3dsGsJjY/9lGxMAqqmb9ZGc0IcujP+EkB0IRbKXzwx3c9SkD6TX0h2GL
         dzA4Yae7x1pIAbdhwQm142mVWaoDw+r6qJz8xdljck+vQNRtXYF0ej8ugScchJKfrGDs
         Vi9udMyTphgwv1k15grZTH8c6W2QkVmdfMBTLJ+fg1WqQcWgrioUFoHJXiu800XH+Ta4
         yTPTPOjwqmBuAnCzZOqobMNpnqbmZ6hdNbvD23HzjPb+P9W/CltOFmKxFIr4zNWTrQo7
         dolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756119759; x=1756724559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KrFoOnuL5GMtaq0YKgHhpMxoakpxp6Ykplg7n1PuXc=;
        b=GLOgCRwlDkQte5qWRcyj0+mLsBlmDNajDTs1i+eq4foNFmaC2BoLuvRzTUM/CEf5xO
         eGX4LublUaAncD1tPf/JJQp851DiQjEoGt7RJAYlMcpY4UMXvJ1CbJEM4lBBVhNSunWx
         y5GpxxFiJrUQDBYpqd3qZmTTqdxUrcnWiMvHucUTInrJNF6ZKH4e0bNyscuVtoYs2DbP
         EsE7SrHFt/Smz84ICQgaG8oak52VpwU6TxxQOiOiTAnrwDXpnxIDGv+mh1TLwnjr+OVA
         tgtGAL+9jDRUuchUtVK//F7B5tkhzU2atfwpJldcTz1zl4SwUu6kMAP/j7ZoyCp0Xx28
         QR6w==
X-Forwarded-Encrypted: i=1; AJvYcCVbKegKcozmnTvyjs9UaDIX7p8QHMfogRamht7J85mbmMHdJGzUXnlmRi8dsCogMRg2EmpaQsK3fjgA1ntj8Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxLUlpPGYZDSDLClfxvQBv1scE7nDb+P1FlKUhya8DSurIWUKA
	UB+cyuO5w/URbI1GUzbFjywDJTVhfCbhyMSo2Q0oIQffuIpJ5KkyIQxEtzBxxwM5/M0=
X-Gm-Gg: ASbGncus/fOMAWd+Ua3z5h9lcvJtv87O55aVbf7BGSC3SUT43D8hmwmtKmXKrrxKiie
	xLtDIF1PWb/iEx+HGREnj6xda6NQQY+ggGl62EDw+MgNSbL84nLuR/MJgRqaZR/GCb2a5ATqtbA
	nI9psF6me7Md3j9g23VK4G4vl15YKjzjv+wXISOnOknvLVvkHlA+jd81akgh5D0CIceKm5d9gzR
	HPj5scVki78+ZdVBPUq7erpx717FeLe3ZYcbVVgmtKHIN9btv0BP20LzwCeWfFDk8gDngnIatRV
	Tx+HzdytIeICVdM3Gy+ZBuyDeXmGxKQtpquMRM4kr+Nua78IaSq9IvBMO03/imbaSvvM+KjFqZy
	ZDJoLThxxIRpNtlkC/izx4V5UFQ==
X-Google-Smtp-Source: AGHT+IF+Xp2kSkiYMs9XH9xufQw3bih7peJ51tO8RYHjQC3ESxBEZ2qFaKuTNArd2lSB1l4CzhQLSQ==
X-Received: by 2002:a05:620a:1a98:b0:7e9:f820:2b46 with SMTP id af79cd13be357-7ea11082af5mr1233715085a.82.1756119759186;
        Mon, 25 Aug 2025 04:02:39 -0700 (PDT)
Received: from localhost ([138.199.100.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf3bb4e4bsm463662185a.60.2025.08.25.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:02:38 -0700 (PDT)
Date: Mon, 25 Aug 2025 06:02:37 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/6] KVM: riscv: selftests: Add SBI FWFT to
 get-reg-list test
Message-ID: <20250825-5f0ede7adacb9fcc102d6cca@orel>
References: <20250823155947.1354229-1-apatel@ventanamicro.com>
 <20250823155947.1354229-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823155947.1354229-7-apatel@ventanamicro.com>

On Sat, Aug 23, 2025 at 09:29:47PM +0530, Anup Patel wrote:
> KVM RISC-V now supports SBI FWFT, so add it to the get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

