Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94B2791910
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbjIDNqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbjIDNqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:46:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBFFE1
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Sep 2023 06:46:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so317507766b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Sep 2023 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693835173; x=1694439973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvFpohTVYIZg5zZrtXqASIgY84rg/Ko8jDcHzB0T9Sk=;
        b=AGWgoqtOgAoGQ9YM2Q8tVG78Z0ckLz16CVxzS5E+VvbkH5aA4dGWTfytqMvSL6/Q5S
         HGELQoRTgrfYrAJ4fQTF7Azzp2SLGWV+NyXDQV2STuEYJ7CIpknDZiskukv/IiPzufsD
         1uKzAIc/J8674rZdIhyv2YWD6FkexdKXgQ/PPO6P5efqlmzuhoyjcLtZ0ebz0aK0vuHY
         +rVBqjZwlYmK14s46dxuFEQH+iDtqkL0Y4yAzT2fVHNqxHpsQqWtxCuJaF1FUugdtB6U
         yWQVb14ItOs62DOuTPIstV7WmyzuiqJoIhDgizy6tYoAzQs+9Va83LRSYNxNH8pM/U2B
         MTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693835173; x=1694439973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvFpohTVYIZg5zZrtXqASIgY84rg/Ko8jDcHzB0T9Sk=;
        b=RLSczqzeqlyfNXX15vcNScYyZbTCfQrwHuBen4HpvH1CXyVdXXpw1kTs/SgChwIwX7
         zoYGB7zm/eje1O/WV74uRZrNlcfdBg2EjQZoRrT75Ei1k/CzfSahoqFwMgx5LOQA8hTj
         yUZ49PI3rKDfikLj4Tk3hDgNfgzQykYTk8GCY0okhf7vZQqLj6XTv8t0JHn1hEI2ja71
         keuRBXW9P+biKceA/emg7GH8gc0AdP634BgY9LNWc+p5rYkbXjKeViRTPcz+rJQgfuGA
         Lfy/912QUMa3OcjH964XdQLyvaZ7GgmYnL2CL4DdQD2FWfm9gEyBmxhc7rTzl14YABhZ
         ci9g==
X-Gm-Message-State: AOJu0YwopcQe3gLxQjExuL7kLp/3N5undUPWUzGnGMDeMdsOZA7I5sTM
        Jp/R44AJDT6Bt8MVf8j7YTNO2g==
X-Google-Smtp-Source: AGHT+IEdZjuBxG+ZQHNKrQOJiw6f0psWqsTfKbwqOJ2nIP8Um69rD+e7ovBSZFqMEfeYtMk2y26GEQ==
X-Received: by 2002:a17:906:51c5:b0:99c:5056:4e31 with SMTP id v5-20020a17090651c500b0099c50564e31mr10901921ejk.15.1693835172485;
        Mon, 04 Sep 2023 06:46:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709066b9200b009930308425csm6163942ejr.31.2023.09.04.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:46:12 -0700 (PDT)
Date:   Mon, 4 Sep 2023 15:46:11 +0200
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
        Guo Ren <guoren@kernel.org>, wchen <waylingii@gmail.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/8] KVM: riscv: selftests: Add exception handling
 support
Message-ID: <20230904-c4d2ea8fcfdea6e6722332b2@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <ff41e98a062e0fbb5c2d8dc26d9e4e02c4ce3ea8.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff41e98a062e0fbb5c2d8dc26d9e4e02c4ce3ea8.1693659382.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 02, 2023 at 08:59:27PM +0800, Haibo Xu wrote:
> Add the infrastructure for guest exception handling in riscv selftests.
> Customized handlers can be enabled by vm_install_exception_handler(vector)
> or vm_install_interrupt_handler().
> 
> The code is inspired from that of x86/arm64.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/riscv/processor.h   |  43 ++++++++
>  .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++++++++++++++++
>  .../selftests/kvm/lib/riscv/processor.c       |  69 ++++++++++++
>  4 files changed, 214 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
