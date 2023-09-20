Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2257A8917
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjITP7R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 11:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjITP7R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 11:59:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C66EC6
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:59:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso8801198a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695225549; x=1695830349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTOJJcBmIOT1+zi0OT/D2Ib8E/xBZc3n9UZuUTQAznk=;
        b=Gl6FWXk6yzKOoc0d6MY67zjOaZFsQ/eWn4xMYvkewbV9nojS9o1XGFL8ALbRZbVdBh
         oLY/DONYIwK+TerP4LruP8ZWUmVS9V7xFniM9CpUlGPp7PAQ8KJMCTdHGCI+sDx+eLFd
         DFrPyrkwF6fyyd/k+pNtHu/fAQoD8ztisoC1fim2dxX53zIG6TobzbqtEo+7wlqLGsKY
         KatU1jv9qrnI9oeVcUY+u6ftC8dwHJqzSIofU6G16gDz1yHesZwy28Nrnr2OwdWQ9bmT
         umU5TgE3T/XYc4NntsUbsr0rYlqdmuMv3ZfYm+ImF455bz6XtBJSizl/bh+Wc0tglOWG
         aQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225549; x=1695830349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTOJJcBmIOT1+zi0OT/D2Ib8E/xBZc3n9UZuUTQAznk=;
        b=pj/VLdMPECyz+hbLVKz2Lz3C2NirOb/mNFcZWYnjL5OWHv46KH6jNtpk/iB4NVMdiU
         oO86v6851RM2jwKcziaVzGWJB0XCE9RuRPa5xGfN3im26HXl63u93eS7OVw02MTd2S6X
         AqM1a5fBsyawj7fyoFQFevYwK9m0ALE5B+4nKMUviqBrQ4aOlRsXTNN0iuX6FeJqjXMC
         aPU60wWIc6GU9pzboyHYlbfPC/6D86uDbLGtOh9KCd8LfjfScaF14kXyd3vrt5/IBrvK
         /EVve7/osko8uMG6xovPGvhrj6TWXDIUHGioy39V9x1iKZAQghwabK4rOuT6krvZ93rs
         gU4w==
X-Gm-Message-State: AOJu0Yw5iqIu8TMFxR42qHk7no50ikbSgtIBVfar6fHXfDlCh3sVbjq1
        eDf662bmPYdsJCJmfTIqgGZTuQ==
X-Google-Smtp-Source: AGHT+IHW9j1u4BZK6Q94x+QFx47AjJOr1ij3Eo4Zz9gh+6BWeijfKQS2YiZAaLykAhzJF3l96vQ3Sg==
X-Received: by 2002:a17:907:2cd9:b0:9ae:4d6d:ba5b with SMTP id hg25-20020a1709072cd900b009ae4d6dba5bmr1730696ejc.40.1695225548942;
        Wed, 20 Sep 2023 08:59:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090606ce00b00993cc1242d4sm9573744ejb.151.2023.09.20.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:59:08 -0700 (PDT)
Date:   Wed, 20 Sep 2023 17:59:07 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2 4/4] KVM: riscv: selftests: Selectively filter-out AIA
 registers
Message-ID: <20230920-e3fc5272a2818c67a17cd90c@orel>
References: <20230920154608.1447057-1-apatel@ventanamicro.com>
 <20230920154608.1447057-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920154608.1447057-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 09:16:08PM +0530, Anup Patel wrote:
> Currently the AIA ONE_REG registers are reported by get-reg-list
> as new registers for various vcpu_reg_list configs whenever Ssaia
> is available on the host because Ssaia extension can only be
> disabled by Smstateen extension which is not always available.
> 
> To tackle this, we should filter-out AIA ONE_REG registers only
> when Ssaia can't be disabled for a VCPU.
> 
> Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

I guess you missed my reply to myself where I corrected my analysis and
gave an r-b. Anyway, here it is again, and thanks for fixing up the nits.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
