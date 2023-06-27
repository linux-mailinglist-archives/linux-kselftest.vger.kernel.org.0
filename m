Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136D673F86A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjF0JLl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 05:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjF0JL2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 05:11:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2373C1BFF
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 02:11:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98de21518fbso415613666b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687857066; x=1690449066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpzTw3E7Z1hiaRKO3mrWVuNDi99XvZiDXNO0HWAlUSI=;
        b=QSbolgKuWBtTP13NnqwJj/MLdAunJIZ6gtz5oOH0Gk/6uu5TXD3aDKDtckngzeGNaE
         1divA1wajXFvZ959P2P+ecVS56HtJWwKO5XYGX0JXEuYv6O05YsmkbaJIdCG/KL7/D10
         uHEgJAb7XNFWgRbEDEIIJ4I4sZ9N739G6DGlqAlMaT5P42qCLKyHgYCbKoqfG4iTAKAx
         bI1OoTRkfyOhA46nTLx7ebwlkZpdnr8u5LXchC20fCpLld228zc/vEqpWyQD9aAoB47D
         lerSIo0JkhbQ8MVSsOZDGbfhT7fNhyaPuOcCJRfbgyLEzvbkW+Le68KX/VsjoMKN7tK9
         YR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857066; x=1690449066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpzTw3E7Z1hiaRKO3mrWVuNDi99XvZiDXNO0HWAlUSI=;
        b=RtxrEx1Fz/L+aLr8LATv6bdx2Q21iXvSfJLVsmiO+cagiTYhwVufGb4DI4qUYRf4kX
         l/yTTCr+p2nxFK1xVhJQpC24PLeGMpkVKNcXgeQW7Ex8jUNWiTUcKRKTYjltPAgVfVig
         ixK6JYsjaZYjhPBSW1gTAXEZTDQFP8MBdYEtizkBMz4yPvjgdMwBvyyMGVU6/r5i0iuP
         7KR8AtYe6aE1kVELo7KXofRjt/G2YYgrEGFj0igkmJ1K/1gkUAs+juQNQK48LwhXPknX
         3YpqDctTRB0U/prUE3ukL3F+/h2NBVFOAC+mtFggo1rqH5EW6cMHCvN2mXZg0mj2dMQa
         ctZA==
X-Gm-Message-State: AC+VfDwBQVwnOSCKEBXe+YuIxxHiMK6oO/9eiI39h5skyVWnr4uuKpMZ
        lwPhJSW/SQVR3Q+cavj0ks2IdQ==
X-Google-Smtp-Source: ACHHUZ450s4E0+V1ZLBeLohB3/YHAZdFg1IWiV0LH2NrGhbm/Wxox9eaLfHNxRxcEpnc0aueIWf7OQ==
X-Received: by 2002:a17:906:5a59:b0:98d:f11e:4816 with SMTP id my25-20020a1709065a5900b0098df11e4816mr7286613ejc.29.1687857066569;
        Tue, 27 Jun 2023 02:11:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ox27-20020a170907101b00b00988e81e1638sm4328436ejb.92.2023.06.27.02.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:11:06 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:11:05 +0200
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
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 09/12] KVM: selftests: Only do get/set tests on
 present blessed list
Message-ID: <20230627-adcb173b3ee813e2e16353bd@orel>
References: <cover.1687515463.git.haibo1.xu@intel.com>
 <47f0502d076c071260a87953cbabadfc85d278cf.1687515463.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f0502d076c071260a87953cbabadfc85d278cf.1687515463.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 23, 2023 at 06:40:11PM +0800, Haibo Xu wrote:
> Only do the get/set tests on present and blessed registers
> since we don't know the capabilities of any new ones.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/get-reg-list.c | 29 ++++++++++++++--------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index b956ee410996..3beb6b62de0a 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -52,6 +52,10 @@ extern int vcpu_configs_n;
>  	for_each_reg_filtered(i)						\
>  		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
>  
> +#define for_each_present_blessed_reg(i)			\
> +	for ((i) = 0; (i) < blessed_n; ++(i))		\
> +		if (find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))
> +
>  static const char *config_name(struct vcpu_reg_list *c)
>  {
>  	struct vcpu_reg_sublist *s;
> @@ -189,6 +193,16 @@ static void run_test(struct vcpu_reg_list *c)
>  		return;
>  	}
>  
> +	for_each_sublist(c, s)
> +		blessed_n += s->regs_n;
> +	blessed_reg = calloc(blessed_n, sizeof(__u64));
> +
> +	n = 0;
> +	for_each_sublist(c, s) {
> +		for (i = 0; i < s->regs_n; ++i)
> +			blessed_reg[n++] = s->regs[i];
> +	}
> +
>  	/*
>  	 * We only test that we can get the register and then write back the
>  	 * same value. Some registers may allow other values to be written
> @@ -198,8 +212,11 @@ static void run_test(struct vcpu_reg_list *c)
>  	 * be written need to have the other values tested, then we should
>  	 * create a new set of tests for those in a new independent test
>  	 * executable.
> +	 *
> +	 * Only do the get/set tests on present, blessed list registers,
> +	 * since we don't know the capabilities of any new registers.
>  	 */
> -	for_each_reg(i) {
> +	for_each_present_blessed_reg(i) {
>  		uint8_t addr[2048 / 8];
>  		struct kvm_one_reg reg = {
>  			.id = reg_list->reg[i],
> @@ -242,16 +259,6 @@ static void run_test(struct vcpu_reg_list *c)
>  		}
>  	}
>  
> -	for_each_sublist(c, s)
> -		blessed_n += s->regs_n;
> -	blessed_reg = calloc(blessed_n, sizeof(__u64));
> -
> -	n = 0;
> -	for_each_sublist(c, s) {
> -		for (i = 0; i < s->regs_n; ++i)
> -			blessed_reg[n++] = s->regs[i];
> -	}
> -
>  	for_each_new_reg(i)
>  		++new_regs;
>  
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
