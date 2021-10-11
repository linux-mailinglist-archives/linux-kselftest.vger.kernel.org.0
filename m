Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028AA428CFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhJKM3q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 08:29:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3960 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhJKM3q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 08:29:46 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSdJg6v6Hz689Qs;
        Mon, 11 Oct 2021 20:24:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 14:27:44 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 13:27:43 +0100
Date:   Mon, 11 Oct 2021 13:27:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Alan Hayward" <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        "Salil Akerkar" <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 23/38] arm64/sme: Implement ZA context switching
Message-ID: <20211011132725.00000f47@Huawei.com>
In-Reply-To: <20210930181144.10029-24-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
        <20210930181144.10029-24-broonie@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.204]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Sep 2021 19:11:29 +0100
Mark Brown <broonie@kernel.org> wrote:

> Allocate space for storing ZA on first access to SME and use that to save
> and restore ZA state when context switching. We do this by using the vector
> form of the LDR and STR ZA instructions, these do not require streaming
> mode and have implementation recommendations that they avoid contention
> issues in shared SMCU implementations.
> 
> Since ZA is architecturally guaranteed to be zeroed when enabled we do not
> need to explicitly zero ZA, either we will be restoring from a saved copy
> or trapping on first use of SME so we know that ZA must be disabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

sme_alloc() forwards definition should be in the next patch.
> ---
>  arch/arm64/include/asm/fpsimd.h       |  5 ++++-
>  arch/arm64/include/asm/fpsimdmacros.h | 22 ++++++++++++++++++++++
>  arch/arm64/include/asm/processor.h    |  1 +
>  arch/arm64/kernel/entry-fpsimd.S      | 22 ++++++++++++++++++++++
>  arch/arm64/kernel/fpsimd.c            | 16 ++++++++++------
>  arch/arm64/kvm/fpsimd.c               |  2 +-
>  6 files changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 43737ca91f1a..45f7153067bb 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -47,7 +47,7 @@ extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
>  
>  extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
>  				     void *sve_state, unsigned int sve_vl,
> -				     unsigned int sme_vl);
> +				     void *za_state, unsigned int sme_vl);
>  
>  extern void fpsimd_flush_task_state(struct task_struct *target);
>  extern void fpsimd_save_and_flush_cpu_state(void);
> @@ -90,6 +90,8 @@ extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
>  extern unsigned int sve_get_vl(void);
>  extern void sve_set_vq(unsigned long vq_minus_1);
>  extern void sme_set_vq(unsigned long vq_minus_1);
> +extern void sme_save_state(void *state, unsigned int vq_minus_1);
> +extern void sme_load_state(void const *state, unsigned int vq_minus_1);
>  
>  struct arm64_cpu_capabilities;
>  extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
> @@ -119,6 +121,7 @@ static inline unsigned int __bit_to_vq(unsigned int bit)
>  extern size_t sve_state_size(struct task_struct const *task);
>  
>  extern void sve_alloc(struct task_struct *task);
> +extern void sme_alloc(struct task_struct *task);

Should be in the next patch where this function is introduced.

>  extern void fpsimd_release_task(struct task_struct *task);
>  extern void fpsimd_sync_to_sve(struct task_struct *task);
>  extern void sve_sync_to_fpsimd(struct task_struct *task);
