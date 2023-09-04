Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540B9791829
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjIDNbk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjIDNbj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:31:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA2CD3
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Sep 2023 06:31:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcf2de59cso223545866b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Sep 2023 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693834294; x=1694439094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCYvspyPAR7BQTyfNQLsPOWKxV3J1BTko++dNnBZlmc=;
        b=Vd/e66qjkvvZX17kbWh+Z7IXMqery1Fs3O8dyfR9G04aEBoSp0WL97mlr0/lq6RXSU
         owc7mAd3DUU8MGX4LzSfEl30gVSo8CFLjYUMaeoOIS8LmRL37kjWAWwdvySJR+H+KAvM
         02OQelRS5N4ox4HNLfzDKefCUGa2wHR0pjmDzR4NACNgCwD9ncSuMzGNLj5RNiJa+9a6
         wbIOBa8nfAWjBCztIgTzpW1Q0o0+V/X8f1DRUnm6UsjGcxkUjiVzpBQS+fB9wyV4wbd6
         DfF1XgVEmTyOPhf5+3D+gj7tJZtSdgMXpWvH9rmAUJfr1QHNxLYCSpuunlJpd1gMWaLe
         x3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834294; x=1694439094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCYvspyPAR7BQTyfNQLsPOWKxV3J1BTko++dNnBZlmc=;
        b=jpJt/Xq2Phggqw2xgQ1+nvaKwbn6iHTqq4csBrbCpDKo2X1CQjPpnIj29Wp/8G4I7J
         eY1i9R2wb/N4bL3mMfYUQYDX7naBEaCTR/Mk+yz5s8xjm/aF9Px4Enrj5WEIIza8rE/r
         nRCwg6Kei5Vci++pn6mgGWoMzb/LmW87yMAwgon1BgfAdxmp3bpw2oz5or0YGq/2Mxna
         SGeYqWOy2kIC0NGtM9CRAqFRFrtC82/n8TiTcK0lqHCIRJXZDzpaQPdlChAfVko4+/y9
         mOrWVx0iUytKGhLz0qbnY16ZMxA9I9RdsjoavKfrUi78UpxTC0rdq+HwanfO1qhdRxiP
         1Fqg==
X-Gm-Message-State: AOJu0Yz8uXexdxll3aim6D6HOILR5Y3DY7ZyxsyxqtU2GYwPbzECQtjO
        rc63JF/cJCfkg0o7tj52NXCOXg==
X-Google-Smtp-Source: AGHT+IGtFqpzjt6uSaukx7aodEb/54kI1XEGaEwgvvmfQYwT0ivCYh8vhE7uW3lVgPNl4aIYuhjmcA==
X-Received: by 2002:a17:907:7808:b0:9a5:d095:a8e1 with SMTP id la8-20020a170907780800b009a5d095a8e1mr6644948ejc.11.1693834294609;
        Mon, 04 Sep 2023 06:31:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m21-20020a1709060d9500b0099bc2d1429csm6167078eji.72.2023.09.04.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:31:34 -0700 (PDT)
Date:   Mon, 4 Sep 2023 15:31:33 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        wchen <waylingii@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>, Like Xu <likexu@tencent.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/8] KVM: riscv: selftests: Switch to use macro from
 csr.h
Message-ID: <20230904-d35320b23119ee97737e8a74@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <ee4e518cbed9ff4210b74a22c5af21c410fab85d.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4e518cbed9ff4210b74a22c5af21c410fab85d.1693659382.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 02, 2023 at 08:59:26PM +0800, Haibo Xu wrote:
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 5b62a3d2aa9b..6810c887fadc 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -8,6 +8,7 @@
>  #define SELFTEST_KVM_PROCESSOR_H
>  
>  #include "kvm_util.h"
> +#include <asm/csr.h>
>  #include <linux/stringify.h>
>  
>  static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
> @@ -95,12 +96,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
>  #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
>  #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
>  
> -#define SATP_PPN				_AC(0x00000FFFFFFFFFFF, UL)
>  #define SATP_MODE_39				_AC(0x8000000000000000, UL)
>  #define SATP_MODE_48				_AC(0x9000000000000000, UL)

SATP_MODE_39/48 are also in csr.h

> -#define SATP_ASID_BITS				16
> -#define SATP_ASID_SHIFT				44
> -#define SATP_ASID_MASK				_AC(0xFFFF, UL)
>  
>  #define SBI_EXT_EXPERIMENTAL_START		0x08000000
>  #define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
> -- 
> 2.34.1
>

Thanks,
drew
