Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6D76692E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjG1Jnz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjG1Jnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:43:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F572D54
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 02:43:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bc0da5684so260906866b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690537414; x=1691142214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VN3bKW0/ABSrFl1yO1pT/mPHAallRpzyjbuLLOn5cdo=;
        b=mubQ3pHrxz7BU95uSOuyFAUOva8dWGvzVOb1YmqvqVFQuR9C6fnLi9yikTYxYJo+tG
         F67EAAmEUvjBhfrREZd+0h88CDUoNsVXctUQCnzX5cL8/YXVZ3ZzcDuiGXL1SkUdHEmk
         mCeUfhF8cJgLXwGR991MoXDehKLbuQ7uS9lzJSG79+NCWyoiXEOn+vz/M9oNHc1UeXDw
         8JF4B/g/8BYxtk7NHqYlKRp9eUVzXQaVLlgs7HMr70A8qlKKVT0Lyk0ZpDu0RysS3Xue
         JaIdng9gUVpLg/8BV7OgPBOqftFMh9Khg0Gn9jZooF9dQ4YtKJR0KCDSlM3QcAiaiCWO
         cWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690537414; x=1691142214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN3bKW0/ABSrFl1yO1pT/mPHAallRpzyjbuLLOn5cdo=;
        b=fxe1LxKr30PbFb0KFW7P+cL8Odxlw5y5fQFWxch/33jjRuc9X/DtmkN3Zr98eTBliB
         C9Mf+kjUqIh8wtdYjGs86yqFK57IK0xCSRCbuaOrxvKiQiqnYdNgmWQHcdfbnvA6qD8Y
         /75M0NhzfhOddO3+Sc8sYC0xoaLF/F0N4viBavIJeLWVJYRhDjtRq3xtplLDFw32Jw5u
         bTgRww/d0zW856XG6gNEwSyYc/hclAqzWSyNZl867CCU/IZIBB37a8pj18HyHvCTMuKs
         hdQChuuaH26NVpTbDCebwFPH243eC6ZS5PEP1wNsIJ1v3eizXJypRhL9j7aWq4yhbt6e
         2baA==
X-Gm-Message-State: ABy/qLZz48Lqcbx4EoyGKmwmN0pe/jbm4a1IsIAtnljGxm7WUWm/Vun5
        0agD9JRAi1Vb0cxD+BdAdY0Ybg==
X-Google-Smtp-Source: APBJJlE8srirkpyZ+pJy0GLOeA8E+QJebP8+eXBZLrEYR7zeJjYF0kH9i+D8CGkFA3aDHWriyIbs9g==
X-Received: by 2002:a17:906:76d8:b0:993:ffcb:ad4e with SMTP id q24-20020a17090676d800b00993ffcbad4emr1400134ejn.13.1690537413972;
        Fri, 28 Jul 2023 02:43:33 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id r15-20020a1709067fcf00b009937dbabbdasm1816275ejs.217.2023.07.28.02.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:43:33 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:43:32 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
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
Message-ID: <20230728-879500f157954d849fb303ec@orel>
References: <cover.1690364259.git.haibo1.xu@intel.com>
 <35ce2b9f7ca655eb3af13730b1ca9f05b518e08f.1690364259.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ce2b9f7ca655eb3af13730b1ca9f05b518e08f.1690364259.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 03:20:05PM +0800, Haibo Xu wrote:
> Borrow some of the csr definitions and operations from kernel's
> arch/riscv/include/asm/csr.h to tools/ for riscv.

You should copy the entire file verbatim.

Thanks,
drew
