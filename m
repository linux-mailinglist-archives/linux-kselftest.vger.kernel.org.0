Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE379FF00
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 10:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjINIwW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjINIwW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 04:52:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2982D1BF2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:52:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403004a96a4so7412885e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694681535; x=1695286335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMUcG5dET7EFobfbAHbzg2lwyOfsWQ8F2tpkEXeY8DY=;
        b=StgrfO85sslASZLu1luVqtO7tb55qbJgvfpXkg9pTAfsDnQnC7nM+Yxjs2Ar02n6aW
         SsYJ/0RYNy1wMPnHBZz5y7uxU2qdGDeWZ3CbMk4AD5jVwtTuHxIwtMsW1VGfwUv5xmNg
         8EzC7EGHo288N93zQg/H35PEtCrEC8RMTLHNQZLpN8z/XXhiyWB1gI5nlTUjBLTNfhg6
         vk6/BTYqcwyVUuPNOCJ1Vz5mxMrLZdNqnAYbhxj7BKsQohSCRBtbxK0ucHGuFyje3ecI
         zqu395Teyh74NhcpJnFEGQbtFjyZtJETeej3Cp93WIsDYUkHWJK5Gff/O3ScKKO+PKKW
         cAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681535; x=1695286335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMUcG5dET7EFobfbAHbzg2lwyOfsWQ8F2tpkEXeY8DY=;
        b=JyHM+YiSmhFZ9hj/GqUc0e1gHcsSQqw3LlxO5VF7dcUZc6Q/fgytgotHF4ESzQytFU
         1rVH+6KU3mXZU6DmOwpm3a2+zVMH/Nwv6CaIq3oYGds4LVUUYHcLSirYN+YlMg2RkDpU
         N7lJbhqsf8Lt0ad98ddT6s+Q5lkNSfjTm1sH8bAvuF87Mc23/ueUSI9WUHu01rcHioRS
         DJVXEZbPcLLBSCuC9DmzW9acSZWs2VCPVdBO0lTAfT+vbo1K0/FmQUFZeIuFwbdJb3iF
         yfrr0lG4yVp3FPnJjmpkV4vSnAFD97fSB56gdknzv8wSYM08dyeDgmdxMEpFH+uKGVeg
         E4vg==
X-Gm-Message-State: AOJu0YxnvxQsiYe026xBUBxulDbb58ynZ5ixRFYhSJNvwQorGcniluNI
        ezZc+nqT649z9RB7Lfev4SjSBQ==
X-Google-Smtp-Source: AGHT+IF/71ROIOoJExJf8FEqPIRkV7f1W6lv97o8MVa7W5dAed2t55G5dPLBGqXoAtZVnyXGa4aJ8Q==
X-Received: by 2002:a5d:4f88:0:b0:319:83e4:bbbf with SMTP id d8-20020a5d4f88000000b0031983e4bbbfmr4097683wru.20.1694681535355;
        Thu, 14 Sep 2023 01:52:15 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b0031ad2f9269dsm1137143wrt.40.2023.09.14.01.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:52:14 -0700 (PDT)
Date:   Thu, 14 Sep 2023 10:52:08 +0200
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
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 5/9] KVM: riscv: selftests: Switch to use macro from
 csr.h
Message-ID: <20230914-18bfe93b679e290188e70307@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <6cdda82518977c67004ee01a767bc67962352c13.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cdda82518977c67004ee01a767bc67962352c13.1694421911.git.haibo1.xu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 09:36:59AM +0800, Haibo Xu wrote:
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 5b62a3d2aa9b..67766baed4f7 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -8,6 +8,7 @@
>  #define SELFTEST_KVM_PROCESSOR_H
>  
>  #include "kvm_util.h"
> +#include <asm/csr.h>
>  #include <linux/stringify.h>

nit: Usually we try to keep the order of our includes separated into five
categories, listed below, where each category is sorted alphabetically. Of
course any dependencies the includes have on each other need to be
considered too.

<library-includes-without-a-subdir>
<library-includes-with-subdir>
<linux/...>
<asm/...>
"local-includes"

>  
>  static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
> @@ -95,13 +96,6 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
>  #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
>  #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
>  
> -#define SATP_PPN				_AC(0x00000FFFFFFFFFFF, UL)
> -#define SATP_MODE_39				_AC(0x8000000000000000, UL)
> -#define SATP_MODE_48				_AC(0x9000000000000000, UL)
> -#define SATP_ASID_BITS				16
> -#define SATP_ASID_SHIFT				44
> -#define SATP_ASID_MASK				_AC(0xFFFF, UL)
> -
>  #define SBI_EXT_EXPERIMENTAL_START		0x08000000
>  #define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
>  
> -- 
> 2.34.1
>

Assuming the CONFIG_64BIT patch will come before this, then

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
