Return-Path: <linux-kselftest+bounces-1838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C3D811471
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12820282803
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE282E84E;
	Wed, 13 Dec 2023 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KXYuAUC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675FDCD
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 06:18:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-333630e9e43so6777548f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702477096; x=1703081896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMvhSkMSE/Am1VRqFroHUAOOjs4iyetVHF646YQvvOI=;
        b=KXYuAUC+oqLsgtArLl7kxsnNfiAs/D34549ViQ0T1w5JcR9DNL28cPsX+eWz3UwAEI
         8TGxKAGhiHTDqXwxikPbTDIYsfGc4qz0CXNybP4ZvwhunNjpGqwoEBEStVAiDGKJe8aa
         SqmIsR2JUija7SjRcSPZ7kTQkZSUzWGclN4L4pjxloK+W6jrXw1VyKOZM0EQaBOLyVO5
         5Iw/UZwCuGW+grdag38FnL7ZMSt5IdyTfkQ7R8QTVGva1uVbepKOUXuyeAMqX+CjadKM
         oKynrpFp6eKIBrR1gelKAQhQjwWf/0jHrpmw7ioGp0Z3IeAHN5h/5JWXvrPIeCdR9KyJ
         qWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477096; x=1703081896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMvhSkMSE/Am1VRqFroHUAOOjs4iyetVHF646YQvvOI=;
        b=bdeY29WqYwBtbw+FHDcG4KC8R4lNy0M8aDlwSVrvzzwnqb6r3yGlm3A/15krm1Sxuf
         hYNwSK7eri2XAGBp0wXIrzZf1j5oksBp9SNXALRXNXPgyPuSghJsGZYMzCVdo5YtuKYq
         /jOedE6by2s0tIB8P5GKJDBfWAkZnf/5TzxPK0Fx4btrGM7DzT1COE+FxVMmXnVMAXqR
         VN5CbD9sZhEzITpUlPciQGwL6aPsRidZrQYBUIFp1ik2k0YJ2b3M9k57/C43GB9T9qFv
         ZQcrhXScai5ZuownDEtPMre1mqgm0iCP+22VbXa4JzZgFVv6uH/5DOXC4BItHRVJFNyh
         fCBQ==
X-Gm-Message-State: AOJu0YzQZAG2f095Fw0Wde+TSlLIoQgkqHsvHhIuoACmD+rG7eNRaK++
	rDMJouOgpe4QGVwver6sDvPaBw==
X-Google-Smtp-Source: AGHT+IHHAN8IaZVRK1Ps8W71SJhwMq4xLyWFOqoAIKM4rFfgBhljotdkzECz0shi/fy3fHhekB11VQ==
X-Received: by 2002:a5d:6242:0:b0:333:3c06:b433 with SMTP id m2-20020a5d6242000000b003333c06b433mr2848127wrv.0.1702477095654;
        Wed, 13 Dec 2023 06:18:15 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v16-20020adfa1d0000000b003362e9b75c3sm4056912wrv.88.2023.12.13.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:18:15 -0800 (PST)
Date: Wed, 13 Dec 2023 15:18:14 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Samuel Holland <samuel@sholland.org>, Sean Christopherson <seanjc@google.com>, 
	Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>, Vipin Sharma <vipinsh@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Aaron Lewis <aaronlewis@google.com>, 
	Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 10/11] KVM: riscv: selftests: Add sstc timer test
Message-ID: <20231213-4ba5fcc75b41cd19ec96f08e@orel>
References: <cover.1702371136.git.haibo1.xu@intel.com>
 <3bb7d5ae5a1a016e970faa0759c47214c9391b19.1702371136.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb7d5ae5a1a016e970faa0759c47214c9391b19.1702371136.git.haibo1.xu@intel.com>

On Tue, Dec 12, 2023 at 05:31:19PM +0800, Haibo Xu wrote:
> Add a KVM selftests to validate the Sstc timer functionality.
> The test was ported from arm64 arch timer test.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/aarch64/arch_timer.c        |  12 +-
>  tools/testing/selftests/kvm/arch_timer.c      |  10 +-
>  .../selftests/kvm/include/riscv/arch_timer.h  |  71 ++++++++++++
>  .../selftests/kvm/include/riscv/processor.h   |  10 ++
>  .../selftests/kvm/include/timer_test.h        |   5 +-
>  .../testing/selftests/kvm/riscv/arch_timer.c  | 107 ++++++++++++++++++
>  7 files changed, 206 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
>  create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

