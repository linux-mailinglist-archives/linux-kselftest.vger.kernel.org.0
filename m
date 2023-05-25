Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64707111E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 19:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbjEYRUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 13:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjEYRU3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 13:20:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6B319D
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 10:20:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso6695075e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685035224; x=1687627224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BsSMy+JyYACPWrjjdZYwT/+fcHGskJiY38T07+T9dQ=;
        b=pffAAv8U4UDe2UO5AaMNBCKJwsA+fY/uXlxRYWYfOSF/U831Cbn+aYPxlrMSwbhgZb
         TJ3rx1gTr+K1LN6r+qy3C+Gerl601yJAy8AKOIVHRjsHhwRhM0mR8bH/dqseh0HTJwDl
         aTiHPcC0yw4VA3HzAumqaPgq0KwYo24ZqEHl9kQtn+U7cDTGuIhcpJuNZs5uHfdAhEEM
         sYxNXpBUEAAXjC6xxQMqA15kRL462Pj9tKNyS/cgeUu5jjoy+gglRJ4yP7PXtcefEg26
         u3Y3AIXcDMKw5KULmLOOQImp2uNFtr5k8MA3uRGHPFRaKVMeGy/HWPTjQYaXkLpCGlq1
         MCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035224; x=1687627224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BsSMy+JyYACPWrjjdZYwT/+fcHGskJiY38T07+T9dQ=;
        b=OcZD/50ArhNRNxi+L7CH+AefLK7MAOXvKxd/YlhOCRkb2c4dhK/WPlFdrWb9TJLuno
         qBXKEF3GKVCmwmQ/kBDV6gsgj0v/MP6XkDPXKbtr9DOQdn/1ycBXKUIzxTl2a4PRtAqU
         macOOwH09VJGTRrMy5OpsfoVH4uBhMb09lNYQGFvJaqBkKislvqkG+gLhqdWKOMBQ8Hq
         +fdfsD7LeGfJ/ZpmuLeTn/Y58+dCIhQYkWLZAY8asQnemIj2Wi4IPGkqOKBaE4Vt/q1y
         D6ygsAG0PqeZquSv/XBqEki8Bc1/o8zrJlAHmdUD5rN8wLL2XDuxP6X7K3wKTYzxgJ7y
         oW+g==
X-Gm-Message-State: AC+VfDyuXuNPB69EY6mMz0Y4+4iIZ2UGMczp1o6kbRNM6ScFvlXIBrH/
        mNkISdPXTyUkQ1kTxa1Cvy0DzQ==
X-Google-Smtp-Source: ACHHUZ7XVIxEPsxV1O2HxjW5C+Kciziw8ncF6RMfoJyVKR3UnpdSFexzOl8yKxJCJvMncweFjvx0TA==
X-Received: by 2002:a05:600c:249:b0:3f5:fb97:eafe with SMTP id 9-20020a05600c024900b003f5fb97eafemr2817182wmj.30.1685035224349;
        Thu, 25 May 2023 10:20:24 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003f604ca479esm6313634wme.3.2023.05.25.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 10:20:23 -0700 (PDT)
Date:   Thu, 25 May 2023 19:20:23 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, maz@kernel.org, oliver.upton@linux.dev,
        seanjc@google.com, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 00/11] RISCV: Add KVM_GET_REG_LIST API
Message-ID: <20230525-6e0855eb07086a96eaa82362@orel>
References: <cover.1684999824.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684999824.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 25, 2023 at 03:38:24PM +0800, Haibo Xu wrote:
> KVM_GET_REG_LIST will dump all register IDs that are available to
> KVM_GET/SET_ONE_REG and It's very useful to identify some platform
> regression issue during VM migration.
> 
> Patch 1-7 re-structured the get-reg-list test in aarch64 to make some
> of the code as common test framework that can be shared by riscv.
> 
> Patch 8 enabled the KVM_GET_REG_LIST API in riscv and patch 9-11 added
> the corresponding kselftest for checking possible register regressions.
> 
> The get-reg-list kvm selftest was ported from aarch64 and tested with
> Linux 6.4-rc1 on a Qemu riscv virt machine.
> 
> ---
> Changed since v1:
>   * rebase to Andrew's changes
>   * fix coding style
> 
> Andrew Jones (7):
>   KVM: arm64: selftests: Replace str_with_index with strdup_printf
>   KVM: arm64: selftests: Drop SVE cap check in print_reg
>   KVM: arm64: selftests: Remove print_reg's dependency on vcpu_config
>   KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
>   KVM: arm64: selftests: Delete core_reg_fixup
>   KVM: arm64: selftests: Split get-reg-list test code
>   KVM: arm64: selftests: Finish generalizing get-reg-list

All the patches above should also have your s-o-b since your posting them.

Thanks,
drew
