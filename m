Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B840774571C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGCISk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 04:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGCISk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 04:18:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D21E40
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Jul 2023 01:18:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso4793165a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jul 2023 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688372317; x=1690964317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0AIPmQjwEPFU9S6QPuv3kXAJyYa7R0ahvO9uqbNsw0=;
        b=CTXm0Evd7f9xNERgFGe8Kgf2dIrXOUMZPOBGhEgXQdvIjRhhrv5Qh3s5ENWJ09z7ev
         5wm7FiXz+iF/TvW0dDpczV2RwoT7ClRWoiG7fSddWKzNyBagcc/r7pNw84OiXN04lL4z
         wC0LmC5S4SY3KJKOoKwf0war+sU1MsM9XTZc+Scp7fmMYsS9QJtvuv34rKr0yMZAysn8
         D2fh7In8mMCQM9+yNYsq6aVEQIOZzk4aw7h/eGK/mN535gJJ9Vny0AUFRXYlZM0dEbQr
         O8A0Ma5CFWhzbHzM3joBe8qmF4w64d0CQLFSC5gbL99qho7IZPwuRlOOued1WUV58MLW
         eK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372317; x=1690964317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0AIPmQjwEPFU9S6QPuv3kXAJyYa7R0ahvO9uqbNsw0=;
        b=djbZC8Ytrx7f4fzx7neQn9MgRqDpmNXoo0Fr5tAAkeNr6ICp+UswAqlMrmAbH7s6uU
         7vH4M7My7VPGAT5RtwzNqdv8/m0fDCfEszvx9j2Xd0YV9lBMgdvUCM7w2aqrNqJ6417i
         Fr0P8nmiDONgVegns+BD1E08aqdcWPMwC56gNUHnquAHgc/ajKWCAjSLLC1dQWQeQzpg
         BffAgtfbkDvS6GNhv4cI7LwaqS9pgTCetKTGzZ4VDUgmvb/wEi//TEO+IWwuh3eGBDr+
         N9CweuuTyF0YOVwx18fQf1UftqdC2K2CmRekaJsMOKHaoGy+r80+LOfez/3jvlAx0J3g
         OFeg==
X-Gm-Message-State: ABy/qLYvC4lz1Lt+B6Sx09h9m0kI+3G/MZYYTwDGERw6dWrEz1QeBWPv
        hE45mTl7mZ77rtK2GVb7Q3POuA==
X-Google-Smtp-Source: APBJJlFjFKFq1EVk2plu+5SIDoHMMxjYDFXuQ8UHkU0hLQGKGPcjw2PacRkzpqFIW8QfcigNzutaAw==
X-Received: by 2002:a05:6402:4497:b0:51a:200b:d8ff with SMTP id er23-20020a056402449700b0051a200bd8ffmr6795812edb.13.1688372316835;
        Mon, 03 Jul 2023 01:18:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id n22-20020a056402515600b0051e0f100c48sm1171605edd.22.2023.07.03.01.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:18:36 -0700 (PDT)
Date:   Mon, 3 Jul 2023 10:18:35 +0200
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
Subject: Re: [PATCH v5 10/13] KVM: selftests: Only do get/set tests on
 present blessed list
Message-ID: <20230702-49c5545eb1ae2d0cf11c7b95@orel>
References: <cover.1688010022.git.haibo1.xu@intel.com>
 <f44c3aa46971d524319c6340f9ce1b00c0182fd2.1688010022.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44c3aa46971d524319c6340f9ce1b00c0182fd2.1688010022.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 01, 2023 at 09:42:58PM +0800, Haibo Xu wrote:
> Only do the get/set tests on present and blessed registers
> since we don't know the capabilities of any new ones.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/get-reg-list.c | 29 ++++++++++++++--------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index c61090806007..74fb6f6fdd09 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -49,6 +49,10 @@ extern int vcpu_configs_n;
>  	for_each_reg_filtered(i)						\
>  		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
>  
> +#define for_each_present_blessed_reg(i)			\
> +	for ((i) = 0; (i) < blessed_n; ++(i))		\
> +		if (find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))

I just realized this is backwards. We need 'i' to index reg_list->reg in
the body of the loop. That means we need to write this as

#define for_each_present_blessed_reg(i)                                         \
        for_each_reg(i)                                                         \
                if (find_reg(blessed_reg, blessed_n, reg_list->reg[i]))

(Which, in hindsight, makes sense since we're replacing a for_each_reg()
loop.)

Thanks,
drew
