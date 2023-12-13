Return-Path: <linux-kselftest+bounces-1351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62BA808982
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 14:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F55282595
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C2640C04;
	Thu,  7 Dec 2023 13:51:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DD40BF8;
	Thu,  7 Dec 2023 13:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E23C433C7;
	Thu,  7 Dec 2023 13:51:38 +0000 (UTC)
Date: Thu, 7 Dec 2023 13:51:36 +0000
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
Subject: Re: [PATCH v3 05/25] arm64: context switch POR_EL0 register
Message-ID: <ZXHN6IFeZLz-mFau@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-6-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-6-joey.gouly@arm.com>

On Fri, Nov 24, 2023 at 04:34:50PM +0000, Joey Gouly wrote:
> @@ -498,6 +508,17 @@ static void erratum_1418040_new_exec(void)
>  	preempt_enable();
>  }
>  
> +static void permission_overlay_switch(struct task_struct *next)
> +{
> +	if (system_supports_poe()) {
> +		current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> +		if (current->thread.por_el0 != next->thread.por_el0) {
> +			write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> +			isb();
> +		}
> +	}

Nitpick: use "if (!system_supports_poe()) return;" to avoid too much
indentation.

W.r.t. the isb(), I think we accumulated quite a lot on this path. It
might be worth going through them and having one at the end, where
possible.

-- 
Catalin

