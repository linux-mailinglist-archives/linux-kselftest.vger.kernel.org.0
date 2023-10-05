Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357997B9FA4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjJEO01 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjJEOYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:24:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEF87287;
        Wed,  4 Oct 2023 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PXvaL0YHKWoIp6ItLWn51f3AysUSNJgd0DaMiX2uAic=; b=P/GmtBrNdqyYciQSKghQIq5uyU
        hAQNHtExo+DtJclOklF5ySyh1Lj4xOOiJXjgMy4miZrkA9GcqmBCkfYR/+RvBfHCIt5cQM5u6jtAI
        oxHAl1beCpW8u4KIsFqmtp6fGtOeOr5uZUqdofoofJkEpDL277Lz25nqvR3AX7k33eQwxU/4P8OFf
        k8n3d2xVqtLb2Ag9VC1rJvUH7fm3CPzHigzM3j0gC0dr8j7Su1wkflAur6vCYoBqMqm5hiwqfVvg/
        U4T9c6FL0hTayMyVrZuFzJ9OoFSE/4yAd8Ii6SzVEUOzhr3R7t2cqjdFdh9tAu03O4VqA7LqVecy1
        ZN3AoFvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qoIBI-001XnF-1g;
        Thu, 05 Oct 2023 06:49:56 +0000
Date:   Wed, 4 Oct 2023 23:49:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/7] RISC-V: Detect XVentanaCondOps from ISA string
Message-ID: <ZR5clPwviAN2SHVY@infradead.org>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-2-apatel@ventanamicro.com>
 <ZRpitP5y1yhzKwbE@infradead.org>
 <CAK9=C2XyQtHy3__i+fahbi49=j5Z3Z_Bv5s3Ptqjmuaa5q18LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9=C2XyQtHy3__i+fahbi49=j5Z3Z_Bv5s3Ptqjmuaa5q18LA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 02, 2023 at 09:06:08PM +0530, Anup Patel wrote:
> > extensions?
> >
> 
> We already have few T-Head specific extensions so Linux RISC-V
> does allow vendor extensions.

Only for kernel internal operation and to actually boot the
chip.  IMHO still the wrong tradeoff, but very different from actually
user visible extensions that will lead to fragmentation of the
ecoysystem.
