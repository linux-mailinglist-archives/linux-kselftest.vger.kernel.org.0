Return-Path: <linux-kselftest+bounces-1356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17548089D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708ADB214DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752C84123E;
	Thu,  7 Dec 2023 14:08:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7623D0AC;
	Thu,  7 Dec 2023 14:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D40BC433C7;
	Thu,  7 Dec 2023 14:08:32 +0000 (UTC)
Date: Thu, 7 Dec 2023 14:08:29 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 07/25] arm64: enable the Permission Overlay Extension
 for EL0
Message-ID: <ZXHR3YmNjZu92EbZ@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-8-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-8-joey.gouly@arm.com>

On Fri, Nov 24, 2023 at 04:34:52PM +0000, Joey Gouly wrote:
> +#ifdef CONFIG_ARM64_POE
> +static void cpu_enable_poe(const struct arm64_cpu_capabilities *__unused)
> +{
> +	sysreg_clear_set(REG_TCR2_EL1, 0, TCR2_EL1x_E0POE);
> +	sysreg_clear_set(CPACR_EL1, 0, CPACR_ELx_E0POE);
> +}
> +#endif

Don't we need the TCR2_EL1x.POE bit (for EL1) enabled as well? I'm
thinking of the LDXR/STXR instructions accessing user memory (the futex
code).

-- 
Catalin

