Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891487A00DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 11:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjINJwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjINJwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 05:52:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C61FC3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:52:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31f6ddb3047so673729f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694685121; x=1695289921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87hkIaEeaycrb+JmT+Kn5bO8XmPQAs/7YcVaTE26sUI=;
        b=KF5cQPlhzQZJn23fWS1ibp4Z4H8CuKL7wivlrBWqGKQBC0Eyfv9HS02MTXJ2iSo9YI
         opQgPDoEbYiikbQoyEbzxrOnkA24Qf27nJwX/gmA7FP/2Xl709igvbkEFpWLJB2IwAfE
         ngkMOiybQz/ekgnugz/gVc/KY8QQ66qcRt+J9GCexzgWdSNBm+aUyrtCddcIoi5NMdQp
         SAnw7yGg3tbUwgexKVaCfSXH/2iMN9MOGMwxKjfZaee2QIiymNl1hIJ5ocaqHolDELGP
         h0EiKEoe2UsDSod6JS/4lOSNN/JQAsgdXLFWYgtTJb6rLo3xxhmLuLbUD8S3ctwmfea5
         rImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685121; x=1695289921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87hkIaEeaycrb+JmT+Kn5bO8XmPQAs/7YcVaTE26sUI=;
        b=LWhsUeWIsxQHV9k0eCpeCIeXv43p35EYVuswQsmPmandW4d3JQawkpONpszy21RTiV
         zM2oF/r2GnQ41viWosGYIjDflqZUwc1URyAjxFTz1FxtAX27ZS/B2oXGXd9GOHlpG6y8
         cv8VC6J+SRRQYFaaNehcatgQoAyMivJRBjgfIYEiwp4bBMeTIqlKzLO+XoKUx2CjQ4k4
         KolnG67YHwfEbV9WoROW+a1tzxy5xqXVczdqfjtnR9bnOj3yu4TW0U5GyCSBWcV4qo2N
         3VEsc6RspJRpXnmd2VMvnfdXmGb+vZX4YpgMM7MXc+USV1CFNUadpWOm909qD8OpFA6l
         ZnwA==
X-Gm-Message-State: AOJu0Yw2b9qw4aDiCJjw9Y4GjMgUBgWRldhDi4/xrE/0FgCrQMgdsKd5
        h0qvG6VAwjXIGeVteJYNCfPvUw==
X-Google-Smtp-Source: AGHT+IE9t7DU458yWwT1itzK5VNW8FsjrH1qSa0IsiYq57mBauEQWRv09OgpY8852LzCHRw39zKnyg==
X-Received: by 2002:adf:e7cb:0:b0:318:8ad:f9f with SMTP id e11-20020adfe7cb000000b0031808ad0f9fmr4346446wrn.24.1694685121603;
        Thu, 14 Sep 2023 02:52:01 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6184000000b003176c6e87b1sm1290730wru.81.2023.09.14.02.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:52:00 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:51:59 +0200
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
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 9/9] KVM: riscv: selftests: Add sstc timer test
Message-ID: <20230914-d2e594e7d84503ad14036e2d@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 09:37:03AM +0800, Haibo Xu wrote:
> Add a KVM selftests to validate the Sstc timer functionality.
> The test was ported from arm64 arch timer test.

I just tried this test out. Running it over and over again on QEMU I see
it works sometimes, but it frequently fails with the
GUEST_ASSERT_EQ(config_iter + 1, irq_iter) assert and at least once I
also saw the __GUEST_ASSERT(xcnt >= cmp) assert.

Thanks,
drew
