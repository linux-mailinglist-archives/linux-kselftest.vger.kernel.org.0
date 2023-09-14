Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647977A0162
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbjINKP7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjINKP7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 06:15:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7CD1BE5
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 03:15:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so675733f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694686553; x=1695291353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyIjI/I6fiuQb5fro76kkYxOSc4xq/0TuIo+mtjDBWI=;
        b=QA3eGr+g541KCdar2tCcnj5cTCklF9uEIbH6NOz9SXHpL0vOAKJBOKvewdQFiNhQrD
         ZBu9q3pL2wUuSBviEFP36/T5c02jF8lmYaxkpY1TOxj7UkB/H/4ZzkEMv/3DlvakqTqz
         YV/NolPyqkBEjkIufXupEfjuF7kfCjUiGKNm/8AAYXlXjKw48qjqbeKjytASiU0RomIz
         enDWv2eGMJ1Wz8WkC8vg7+0dMUWSCTjBXX0a4VqPD/4nx+LUOKbhTGo5ssvU4ssDG8ha
         RGnAEPnT2AqoFf6MQ0NYSRRjosa1m1wzX+7CUMoyEG3dScBrDQwmEUz94hL6bzy22H9q
         9l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694686553; x=1695291353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyIjI/I6fiuQb5fro76kkYxOSc4xq/0TuIo+mtjDBWI=;
        b=Sj9H9A0VhsZ672e3JbSU//2744NI4PXl7ea2LtX7aLjniJvEbD+NN2vOWy8EOfCxhL
         /ARuvqlsAYg6S2PTEMzdAVXujlUCeNHWrNWd0PBmiQqH3tnKQNb8X+Q7SvH3JeF1Am5P
         VdeeSbiy9y7b1LLzmFat2MLp7gmbcMAFCn4e1EZS2LEN25eFezLjAxZ3r1UnHSAHrZyZ
         zNhqFmwwN+fnQ54EmmebUOc7kQegybBs4CGf3rq/So81YqsOyKYPztRP1oQra3rtt2hJ
         aMGjQAmoVziy0bxYFH6gPB5SM9XjWPJcxoffFcjLRVxBqARuynzZO5pw1Ls6et8x+cUV
         xdyg==
X-Gm-Message-State: AOJu0Yy8gO+66aEA6UWOQLPOt8Sv1FyZsWZywL0NcqSN7vThytQF6u0P
        B0S4+lnnOQP7pymLqhGM/yP/ow==
X-Google-Smtp-Source: AGHT+IH7ZT746JOyiS+eOvZlolhRQEl4EX2Lm6S0kGQOnu5nvVuWeFGDXcIG88aW5kDFIAcnKh6/BQ==
X-Received: by 2002:adf:d0c3:0:b0:31a:d2f9:7372 with SMTP id z3-20020adfd0c3000000b0031ad2f97372mr4347143wrh.29.1694686552802;
        Thu, 14 Sep 2023 03:15:52 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5248000000b0031fc4c31d77sm1340310wrc.88.2023.09.14.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 03:15:51 -0700 (PDT)
Date:   Thu, 14 Sep 2023 12:15:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, xiaobo55x@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
Message-ID: <20230914-2232dea1c6d03fb5985755e6@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
 <20230914-ee133dd5e804282ce28833d6@orel>
 <20230914-reflector-preshow-786425ad7ae2@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-reflector-preshow-786425ad7ae2@wendy>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 10:52:15AM +0100, Conor Dooley wrote:
> On Thu, Sep 14, 2023 at 11:36:01AM +0200, Andrew Jones wrote:
> > > +static inline void cpu_relax(void)
> > > +{
> > > +#ifdef __riscv_zihintpause
> > > +	asm volatile("pause" ::: "memory");
> > > +#else
> > > +	/* Encoding of the pause instruction */
> > > +	asm volatile(".4byte 0x100000F" ::: "memory");
> > > +#endif
> > > +}
> > 
> > cpu_relax() should go to include/riscv/processor.h
> 
> Can the one from asm/vdso/processor.h be reused, or are there special
> considerations preventing that?

We'd need to copy it into tools/arch/riscv/include/asm, but it could be
done. Hmm, now that I look at it, I see we're missing the barrier() call
in this kvm selftests version.

Thanks,
drew
