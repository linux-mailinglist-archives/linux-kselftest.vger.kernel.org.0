Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB65976C2A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjHBCFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHBCFP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 22:05:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7A212D;
        Tue,  1 Aug 2023 19:05:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so46950491fa.2;
        Tue, 01 Aug 2023 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690941912; x=1691546712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33FGRO0uiP6qTJBMh3rf02rvPSySzQ+cG5TwspD9eRg=;
        b=f3NvgaeSAWtk/Wu+VcamVFH4Q9indsZ08iIwci/KzL+4hqWjX876YurFCS9x0+xLtD
         bAHulBtcK0RwTaVUxZuXdSm/txfwxi5bPyc/pDPqLk9b9zN32zk9w0D4oUkgVMO+MrLX
         nSdQhl0Sb4gmj5LR4DBjY6WULMtolrLNhrDk19fJZwn3/tBNPbOVOcwZiREBuJVSmX/T
         huPRF6RuaE/0TazoDW3S5iozA9bv0ALjAGe+x5n30/DS3KIaltguIBMGmbHLouBVsEs/
         zouGj4OJBDJarSNW6tqOweA6gxBes/21spg2qNdUDxKj1VqqT6iSamPJBibn2/KIFZdz
         Kiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690941912; x=1691546712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33FGRO0uiP6qTJBMh3rf02rvPSySzQ+cG5TwspD9eRg=;
        b=aljhVYnOCEzsGBpWNVfKAews/czgQ88uGDYZBWHiXX9sSghO6YG9J0+z/hLwXL5QGq
         8eQkyh0ijkJGfsk9wivXHBFBNT0Q4YAztQxaMcKwIjsmL9n/zQpyrip/Q10UH/PsVAA9
         9A0nkA7jhdptfR7fVuk7eDis9wAHclqYw3X+yzE3fx+QBaI8lacrWNq9u2bidXkgmyeJ
         JO3+FVdMFCNg2fyul9FabNHHnNLXlWx14GU6aTEf2/1SAPycREtYyicBnHCSvS3Lr+nu
         5CLIsBcPtfgDudWu4G+BYfmbccvpJBKEFI4JoANFFVLk+uFAkq5N0CQtL5I7Xqkiq61l
         uvVg==
X-Gm-Message-State: ABy/qLayp6244rpBg9cjnLXFkw1XzQ9dyK/UpNHPTZmL8RmARzY4/D95
        o2T87+MgYf7/rPngGKHkBXTVh+20tuvq+meEmrk=
X-Google-Smtp-Source: APBJJlEE29GNJN/lG7oFpSff+TdO8x0Tale5Vjg1bNF1bLSbg84oM9Loz4BY7DDRVROs9f5kxpx5NW4/U0LUoMzKucg=
X-Received: by 2002:a2e:860b:0:b0:2b9:55c9:c228 with SMTP id
 a11-20020a2e860b000000b002b955c9c228mr3729409lji.27.1690941912186; Tue, 01
 Aug 2023 19:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <35ce2b9f7ca655eb3af13730b1ca9f05b518e08f.1690364259.git.haibo1.xu@intel.com>
 <20230728-879500f157954d849fb303ec@orel>
In-Reply-To: <20230728-879500f157954d849fb303ec@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 2 Aug 2023 10:05:00 +0800
Message-ID: <CAJve8onDLEC1JFdERi098sTmN3-UkwaJ1aJz3CJNYU-GShkEyg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: riscv: Add header file csr.h
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 5:43=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Jul 27, 2023 at 03:20:05PM +0800, Haibo Xu wrote:
> > Borrow some of the csr definitions and operations from kernel's
> > arch/riscv/include/asm/csr.h to tools/ for riscv.
>
> You should copy the entire file verbatim.
>

Ok, will copy all the definitions in the original csr.h

> Thanks,
> drew
