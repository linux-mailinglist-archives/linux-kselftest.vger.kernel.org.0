Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4676DEC4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjHCDOE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjHCDOA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFE82733;
        Wed,  2 Aug 2023 20:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 393B461BBB;
        Thu,  3 Aug 2023 03:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E38EC433C8;
        Thu,  3 Aug 2023 03:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691032430;
        bh=uSf3xwCl9efisUoSoRQolXl/7p0nzj1kHz1aHfTxnaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFvnua7i+h2fTCQnHkPAqHkhk4HR3P1ec2xaUq82RSv28DeurXfTFLyeOVT3N6t2T
         Zi+KP8sQToelogOWDV8DtPiMR8Rqu841G+Vuso7CJTxQ98EG+AF8RqM7YpeLTlpL10
         /4rLkdHqqROKCyrS3vD9SjL/Rxbarby8sOFZ4Z3IemhHX+8Mvn0S2m+wG5IeJaw0Qv
         //FtbaC5/s05HRXE2/IJULu1h+H3jOspin6MkVFkt/x5ye+ArRtbSknZeUkLpjePT1
         lnNdOodIgzRMyXO5qWmI0uFmc1vIVy5l22EvaYnDOJhFV8arl2VglqsgA+KhySREUp
         /U9Srj+PmyrCQ==
Date:   Wed, 2 Aug 2023 23:13:34 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] tools: riscv: Add header file csr.h
Message-ID: <ZMsbXk4JU/Ung7qu@gmail.com>
References: <cover.1690364259.git.haibo1.xu@intel.com>
 <35ce2b9f7ca655eb3af13730b1ca9f05b518e08f.1690364259.git.haibo1.xu@intel.com>
 <20230728-879500f157954d849fb303ec@orel>
 <CAJve8onDLEC1JFdERi098sTmN3-UkwaJ1aJz3CJNYU-GShkEyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8onDLEC1JFdERi098sTmN3-UkwaJ1aJz3CJNYU-GShkEyg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 10:05:00AM +0800, Haibo Xu wrote:
> On Fri, Jul 28, 2023 at 5:43 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Thu, Jul 27, 2023 at 03:20:05PM +0800, Haibo Xu wrote:
> > > Borrow some of the csr definitions and operations from kernel's
> > > arch/riscv/include/asm/csr.h to tools/ for riscv.
> >
> > You should copy the entire file verbatim.
> >
> 
> Ok, will copy all the definitions in the original csr.h
Why not include the original one? Maintain the one csr.h is more
comfortable.
> 
> > Thanks,
> > drew
> 
