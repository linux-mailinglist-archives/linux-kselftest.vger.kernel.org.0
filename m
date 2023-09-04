Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCA791805
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjIDN0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjIDN0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:26:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9CCD
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Sep 2023 06:26:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso1924059a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Sep 2023 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693834003; x=1694438803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uL2B+XqPFUs3X1qoEJuP1SxRFKqVUX3leZ/vaoEUcA=;
        b=aiTrpEn/hhG7AJydLun6Cs2uzWNfhpFECX2ZZWUubsQipyd89eZR+kRR3iGm22Qmxm
         0rfRTgjPOCGpeebTtXH8VKUs4VBAzy8f/daWWsvoNVvA+f1C540Y+9/mOvjPMSJmorI4
         aKjQZnxNiQ9Jvrtj+MLjngXYRqHxcPuChM75zJX2ruE7m9bxWx6s2SpHnkaA/UI//CUp
         3c3Y61pe0NlsjSu7miqrroGPSsvwT4w/Qf4Ne/QOJ1YP2oEOUD56Vy/QXxDA/PYlKHLp
         HokpMbhgoak7/XDhJEGUJ1ptAtEnryVyb8KXzIHWYTpoqsXBdRyMSzsczT/hDNvc1ZUG
         CJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834003; x=1694438803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uL2B+XqPFUs3X1qoEJuP1SxRFKqVUX3leZ/vaoEUcA=;
        b=h6srl4XEZd5SM2y+B92KpUdFmPXP29u3HG9T674X3wUqZTRDzvNT1g6ZfWoKyzAZcS
         t/nAKU4u27/v75I8PmRkwSzJXlLnIU+bx8pBJxGsSVGIQg5dvG7JaE/2iJ9TfVdXI23J
         SWpbGA8KWq+3Wf4WnBxwYYnCUT7KXT8PIOajBQpUTiKNnbVDmsccckrxg2hqS5Cp+XsL
         36zbAGx3q5/r5UP+jhMtUlAz7TfmjphdJipSzT4W8GFm4wHmPU5icJh9lLOksp/o5h3z
         u6QzsMv6UO5Yi13Bu4qFLS2qeFY8/MEogop7dotfY+HQODoG34kj7YWHnMymd4sFM0Mn
         V5+w==
X-Gm-Message-State: AOJu0YzlQ2+wtgfXmGB+XMplJxnJrCBm0Mq1iAC1l5osjrjDlKO36+aw
        3iE7ymoHodjxou50OJC/0qb5yQ==
X-Google-Smtp-Source: AGHT+IGOFIwY6Wm7dsAMFZC9Eb7yEm5sipTomJmGwCL0leiifhPgy+OojWu1/AqpYEmyOm13m0TRlA==
X-Received: by 2002:a05:6402:17d7:b0:52c:84c4:a0bf with SMTP id s23-20020a05640217d700b0052c84c4a0bfmr4777586edy.30.1693834002867;
        Mon, 04 Sep 2023 06:26:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n18-20020a056402515200b0052a3aa50d72sm5855572edd.40.2023.09.04.06.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:26:42 -0700 (PDT)
Date:   Mon, 4 Sep 2023 15:26:41 +0200
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
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/8] tools: riscv: Add header file csr.h
Message-ID: <20230904-79306f36fc9cbe222eb0ef8f@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <8173daae52720dbdabbd88a5d412f653e6706de1.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8173daae52720dbdabbd88a5d412f653e6706de1.1693659382.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 02, 2023 at 08:59:25PM +0800, Haibo Xu wrote:
> Borrow the csr definitions and operations from kernel's
> arch/riscv/include/asm/csr.h to tools/ for riscv.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/arch/riscv/include/asm/csr.h | 521 +++++++++++++++++++++++++++++
>  1 file changed, 521 insertions(+)
>  create mode 100644 tools/arch/riscv/include/asm/csr.h
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
