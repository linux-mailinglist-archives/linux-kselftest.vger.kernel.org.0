Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5034D76E239
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjHCH57 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjHCH5J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:57:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB093ED
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 00:44:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c10ba30afso381911666b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691048689; x=1691653489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CSSRhpwsXf70z+1rxlQ2+hkymtm2lwEBhyh07kPB2pk=;
        b=hVshpXD1f4VzOD4XcxN3LbCb5HapivOPgFQ+ILU0E4alQRUTVmJwgTwVgUvmzBMszt
         NDqQtPAZmoLrTkgoPimF8eEzhIDPdpAKz+2EKqLtmx7HB/j2CAUcEcg/+5rMoDpwE0nO
         3eWEEAyYy1dNbtgfyBWfxn0dYcGaX5y2VC5pxwRD13Nkz2YIkx8/HrOFqbbgo1cDi1xv
         RefAjQl5EQ0h6nMKJja2YklPKW0V8kuY+qiTMI5yn3SCwLsVjJpvexcAFsqNgXTVLnRH
         QkGpbWuDmvFT02VSc55AQg68lHgTe2htKOM4EvvpIE/Tk4ZGfEhGvwHg19itDFbM26AX
         qdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048689; x=1691653489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSSRhpwsXf70z+1rxlQ2+hkymtm2lwEBhyh07kPB2pk=;
        b=ga2cdbzlneFM4YNmm0pudF/MAdks+ngckhPAnhafKxbVn5Mc63LMswKmTOB+MpFofB
         7GR5d4LdnwtJ4nPB5CDwqnilOAiXjkPwW35zcGmvHrHQqQazIRxs+L02oKVjSolzUI13
         RI8nNCP7WAJ5ba9EIj+hqrfw1/4pmlwYwtY+dmAJIH8f4FnRNk67J2h674IAszIEpser
         P3I9hpXQHEc1ZdfBiBXg2Zl00tN/d23/W5902kuaru9wzPKTZEOQ5GD4i6bG7SLj71UC
         wejHhIVuYMvMgI2PclDAlOqCorlIJfPvtLZfjHW1+S32Y1Wxbo0tS6OF4+NNcAdqtm6H
         fLqg==
X-Gm-Message-State: ABy/qLYGYfEjRRrCdl5vGCoh0n9oD9lLSrUZofHXjRzR/H7PXPzz4kFq
        0nt98+ZriyXxpwWEWNe6E3erQA==
X-Google-Smtp-Source: APBJJlHdMEoyrcmNp/byt0aZUIBGbZ/dYH98Vd4bOX3Z9OBMzCaUzxR0W2Ed2cfgzDFl1sbdTUlvww==
X-Received: by 2002:a17:906:8a4d:b0:993:da0b:8783 with SMTP id gx13-20020a1709068a4d00b00993da0b8783mr8855806ejc.3.1691048689638;
        Thu, 03 Aug 2023 00:44:49 -0700 (PDT)
Received: from localhost (212-5-140-29.ip.btc-net.bg. [212.5.140.29])
        by smtp.gmail.com with ESMTPSA id si15-20020a170906cecf00b00993004239a4sm10128648ejb.215.2023.08.03.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:44:49 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:44:47 +0300
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Haibo Xu <xiaobo55x@gmail.com>, Haibo Xu <haibo1.xu@intel.com>,
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
Message-ID: <20230803-5b7e7c0d95597b004764a296@orel>
References: <cover.1690364259.git.haibo1.xu@intel.com>
 <35ce2b9f7ca655eb3af13730b1ca9f05b518e08f.1690364259.git.haibo1.xu@intel.com>
 <20230728-879500f157954d849fb303ec@orel>
 <CAJve8onDLEC1JFdERi098sTmN3-UkwaJ1aJz3CJNYU-GShkEyg@mail.gmail.com>
 <ZMsbXk4JU/Ung7qu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMsbXk4JU/Ung7qu@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 11:13:34PM -0400, Guo Ren wrote:
> On Wed, Aug 02, 2023 at 10:05:00AM +0800, Haibo Xu wrote:
> > On Fri, Jul 28, 2023 at 5:43 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Thu, Jul 27, 2023 at 03:20:05PM +0800, Haibo Xu wrote:
> > > > Borrow some of the csr definitions and operations from kernel's
> > > > arch/riscv/include/asm/csr.h to tools/ for riscv.
> > >
> > > You should copy the entire file verbatim.
> > >
> > 
> > Ok, will copy all the definitions in the original csr.h
> Why not include the original one? Maintain the one csr.h is more
> comfortable.

selftests and other userspace tools can't always compile when including a
kernel header without modifying the header in some way. Rather than
polluting headers with #ifdeffery, the practice has been to copy necessary
headers to tools/include and modify if necessary.

Thanks,
drew
