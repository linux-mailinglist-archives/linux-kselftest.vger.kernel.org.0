Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15DC7449B0
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jul 2023 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGAO2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Jul 2023 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjGAO2u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Jul 2023 10:28:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12635B3
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Jul 2023 07:28:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so4649810e87.3
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Jul 2023 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688221726; x=1690813726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw6L3iecsaCHUkBPU5RXg0XPBqr03epBdZqP9RT9erM=;
        b=SEjhRB1Z/veXvWxjUBHdLcwTje8hQss7D2GARjcPTW6LyYt9be7tMUY0+aJv5FX8d6
         WN/IafFrpna99BKEss4ZEakuEqvPrr6jxvYicXyxhd9gki78+V6ZtrpXO7KDyY0LdunP
         wF+BIzAGDimhr5pUbfOSVBCdwpO2gAJq+H9oMydEoOX4/yBqliuqlSGq7I6UPlTkDlqc
         Ie8Ghz4fDCBz8V386sK5acwN5hWNX867hbR7NDNaZzi79fiWs1LvQaSE3LA2SeplH7AO
         msFZOPYU8Lpc/KeJfHlTxl1wDJ5tIMB/r0Hr/41wnEKrCOw+bWh9f8QNwaIhh3zufJYc
         Z3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688221726; x=1690813726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw6L3iecsaCHUkBPU5RXg0XPBqr03epBdZqP9RT9erM=;
        b=RNxPjX08E8Vz7IQgh7Qm+/+xFdiBGOAGWTVLoNHBsz/Zu+ek4i4hjOifTlRr9icR7e
         xIJfMFO/7PY8C8SuueEJNGGQvtUQ0H/OwsVgHHVtUt7NfCcvRUO3H61C7OLtOPtdMJFH
         qBziIMAM0owe3k9Vc5dMLLeG+nBjCX1/pLiBo8L393fY/+rm5iHpefkT3dOr8UxnIfZ8
         b0HW4l8qfsqGQsyv0YFi9iB8bb4YpgfqSmkJgRkMA2TpugLLaNnxEKZFNq3RLeJ3rE92
         Stm/P0eip8TDuLqRKOQIs88IzA8UceDhM1xoHBWJhSFpgWegeIRsUVSDFG2nJkIIpo+7
         jcnw==
X-Gm-Message-State: ABy/qLb6eMsklRhMrM3+GXLSuMKblYtvwXjD3DQXoGPwrzLLWaE7KOCB
        Cf7qrKSBKaaynfAj3Z4/3dxt1A==
X-Google-Smtp-Source: APBJJlFs2bVJyhr2R8sltfd2/9wcvYSRVXsl+ohedKMBwI0k0S5K4jvnxW5ud0AbpO+XIPriRJi6lg==
X-Received: by 2002:ac2:4db5:0:b0:4f8:6a29:b59b with SMTP id h21-20020ac24db5000000b004f86a29b59bmr3767983lfe.64.1688221725981;
        Sat, 01 Jul 2023 07:28:45 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7c64f000000b0051de52f8adesm2357555edr.32.2023.07.01.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 07:28:45 -0700 (PDT)
Date:   Sat, 1 Jul 2023 16:28:43 +0200
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
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v5 11/13] KVM: selftests: Add skip_set facility to
 get_reg_list test
Message-ID: <20230701-2da2a0ffa7c1ccd3a549acea@orel>
References: <cover.1688010022.git.haibo1.xu@intel.com>
 <0a418f26388e744b6ae2f17639bea08a05643549.1688010022.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a418f26388e744b6ae2f17639bea08a05643549.1688010022.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 01, 2023 at 09:42:59PM +0800, Haibo Xu wrote:
> Add new skips_set members to vcpu_reg_sublist so as to skip
> set operation on some registers.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/get-reg-list.c    | 20 +++++++++++++------
>  .../selftests/kvm/include/kvm_util_base.h     |  2 ++
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index 74fb6f6fdd09..1a32a900aeea 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -157,6 +157,7 @@ static void run_test(struct vcpu_reg_list *c)
>  {
>  	int new_regs = 0, missing_regs = 0, i, n;
>  	int failed_get = 0, failed_set = 0, failed_reject = 0;
> +	int skipped_set = 0;
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
>  	struct vcpu_reg_sublist *s;
> @@ -210,7 +211,7 @@ static void run_test(struct vcpu_reg_list *c)
>  			.id = reg_list->reg[i],
>  			.addr = (__u64)&addr,
>  		};
> -		bool reject_reg = false;
> +		bool reject_reg = false, skip_reg = false;
>  		int ret;
>  
>  		ret = __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
> @@ -221,8 +222,8 @@ static void run_test(struct vcpu_reg_list *c)
>  			++failed_get;
>  		}
>  
> -		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
>  		for_each_sublist(c, s) {
> +			/* rejects_set registers are rejected for set operation */
>  			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
>  				reject_reg = true;
>  				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
> @@ -234,9 +235,16 @@ static void run_test(struct vcpu_reg_list *c)
>  				}
>  				break;
>  			}
> +
> +			/* skips_set registers are skipped for set operation */
> +			if (s->skips_set && find_reg(s->skips_set, s->skips_set_n, reg.id)) {
> +				skip_reg = true;
> +				++skipped_set;
> +				break;
> +			}
>  		}
>  
> -		if (!reject_reg) {
> +		if (!reject_reg && !skip_reg) {
>  			ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
>  			if (ret) {
>  				printf("%s: Failed to set ", config_name(c));
> @@ -281,9 +289,9 @@ static void run_test(struct vcpu_reg_list *c)
>  	}
>  
>  	TEST_ASSERT(!missing_regs && !failed_get && !failed_set && !failed_reject,
> -		    "%s: There are %d missing registers; "
> -		    "%d registers failed get; %d registers failed set; %d registers failed reject",
> -		    config_name(c), missing_regs, failed_get, failed_set, failed_reject);
> +		    "%s: There are %d missing registers; %d registers failed get; "
> +		    "%d registers failed set; %d registers failed reject; %d registers skipped set",
> +		    config_name(c), missing_regs, failed_get, failed_set, failed_reject, skipped_set);
>  
>  	pr_info("%s: PASS\n", config_name(c));
>  	blessed_n = 0;
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index e4480049000d..67c031fe89a1 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -134,6 +134,8 @@ struct vcpu_reg_sublist {
>  	__u64 regs_n;
>  	__u64 *rejects_set;
>  	__u64 rejects_set_n;
> +	__u64 *skips_set;
> +	__u64 skips_set_n;
>  };
>  
>  struct vcpu_reg_list {
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
