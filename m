Return-Path: <linux-kselftest+bounces-4154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78709849F6A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 17:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4291C221DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C333CF9;
	Mon,  5 Feb 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekHT+Gb3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE040BE3;
	Mon,  5 Feb 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150256; cv=none; b=hO6+GFxCNEqOcbSnIVl34KBT9CpzjsmD6Sm2IpF1yss9hBPsH7ccuaaTD3UCzmjgq4gOY9fUDrNv8VHU6fPQ6ZIUka+IwRQ1p/PEUFL4t9tQvzy4ROpJm5THa3f1rIjxDQdbiIJvu1IaWFlU67vKjHaGTbLycjt4y9li0rFHbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150256; c=relaxed/simple;
	bh=fIMCSPUEi6cexm0uafrNgsHcCO+RxErvwhtxx6mdG5M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKnfqFCEH0O7FXaz8V4RmtX//ZK/66/c3iAXLoyMOBaPVmt3Gxogp3asV25XesrsYhS+XIsJIolyBKqoa7rjP03TxjbeGcQkxO0Mc/UCx9F4RFV3KiK7divu6CdtKvoIFbjh8N2KobKVtXVlLessH9BGAr3+BxjvATOpLTTFUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekHT+Gb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D96C43390;
	Mon,  5 Feb 2024 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707150256;
	bh=fIMCSPUEi6cexm0uafrNgsHcCO+RxErvwhtxx6mdG5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ekHT+Gb3KAQ+Ahd1adEl8P74E+onUgWUxlneL25GP8bxSLtCspDxDjyy0VItSvd2f
	 VyJskXNW3PEy1/ZW20R45xwBx3fHnkaQh0Tyae/NPlVjiIpWqBKzQN//CSbVeFkSdK
	 igh8cKnztJzyuYLAOXytR0yXLd8Y8plcuYdJPRpFTFQLZ1WAYauyJeuQgeI49aPcRP
	 kpkkqk1evmzFifpqRcsTInL2NmCrMZ01UJG4a8boMcpacGtDL8wiLKZAWeIMyJaeD5
	 W7UkXrQIcpxIzs6/UXCSDJuYEMPIlxDYYcL2wqEnlRidds4EbWLO9JKftBFWrPrDGT
	 peoI+Ll4176LQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rX1lV-000TlO-Cr;
	Mon, 05 Feb 2024 16:24:13 +0000
Date: Mon, 05 Feb 2024 16:24:12 +0000
Message-ID: <86zfwe6frn.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Haibo Xu <haibo1.xu@intel.com>,
	ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	wchen <waylingii@gmail.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Like Xu <likexu@tencent.com>,
	Vipin Sharma <vipinsh@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v5 00/12] RISCV: Add kvm Sstc timer selftests
In-Reply-To: <CAJve8onDbX44Ph6a-FdO2+p7QOQLah-7OyF+yUc06wud+SvmQQ@mail.gmail.com>
References: <cover.1705916069.git.haibo1.xu@intel.com>
	<CAJve8onDbX44Ph6a-FdO2+p7QOQLah-7OyF+yUc06wud+SvmQQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, pbonzini@redhat.com, shuah@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, anup@brainfault.org, atishp@atishpatra.org, guoren@kernel.org, conor.dooley@microchip.com, mchitale@ventanamicro.com, waylingii@gmail.com, greentime.hu@sifive.com, jszhang@kernel.org, samuel@sholland.org, minda.chen@starfivetech.com, seanjc@google.com, peterx@redhat.com, likexu@tencent.com, vipinsh@google.com, thuth@redhat.com, aaronlewis@google.com, maciej.wieczor-retman@intel.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 05 Feb 2024 13:10:26 +0000,
Haibo Xu <xiaobo55x@gmail.com> wrote:
> 
> Hi Marc,
> 
> Could you help review the first 3 patches in this series?

For these 3 patches:

Reviewed-by: Marc Zyngier <maz@kernel.org>

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

