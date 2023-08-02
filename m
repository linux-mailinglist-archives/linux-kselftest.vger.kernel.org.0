Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB52D76DA79
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjHBWQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 18:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjHBWQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 18:16:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2402703
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 15:16:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d064a458dd5so261368276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691014605; x=1691619405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUKe0tndPE8THtppbQ2T+ebrmbNyYQbFqdjBVqfHPSc=;
        b=38kWKGnIr9nG7NEImMKN/kYSbzmt49a74eU6F0kFCbveiePdOPvNcSEILmD2Jrj89V
         5s3HlMArUkW/HBVjC+BKGdl78VEbeZGDRzpzebvzFmuEnfdGuYFrCh3LXUe2ON7XsDcJ
         XDSLeSHsdI1bdoXHmvcO1jlgRNqVX9i7F64mW3dIaLVO9uUlcnnTV8K4Ciie8zUrBEma
         T3UfOaEFJQ/Gp4fnvYg3Li6J3QtmUyuB1OzkNZ28bLiFkz/bN6RFDN4Eyei9qrn/QWZT
         hpTPIOVK7oPnJ3vimIJk7oKHDviRjKFyB8E7Hn/7QR0uMlBKyc9mGCI06sxNJxlvAPN5
         ZCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691014605; x=1691619405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUKe0tndPE8THtppbQ2T+ebrmbNyYQbFqdjBVqfHPSc=;
        b=EedUOLUrXfUn9VmMLNsr1q6pvJRv7guK3SEzVlS6u4LpbpBTXBX2j8BgDHRsvXaScS
         mKbJUDZRcTLBaJyN2s8sPslbpcbyFQzI5bmfghyL6ZPF5NaOmIJrWZE3zplAdbNv5W35
         mzjRHrcnwHT05FePIVlAWly7tEFs3wJAfIf5qFAn3cHc+rhwjmu3lLwAC7EwgRQQ/lKe
         9KKJdjuK6DYCQzhHvMsaLexWxC+zFhj9peBJyWELYDoRbG2i7nwyd7U4MhmGUMa4dg+t
         goDhPsY4g4yk0kiGCploVcD60HLZcOdWj00Vl+509l8qKQXltzV8AeTswe8hAJY8vbzY
         luiQ==
X-Gm-Message-State: ABy/qLZ9GnVlw9qX3nVaQhuKnnXnoaK5WC/POxV4WlWZFP+g2Tccf8zM
        TM+qX84c70mAS8SVN2f3Qc/j6dMqBfI=
X-Google-Smtp-Source: APBJJlHy/PqtmZyQAWZYe0P365x5lyVjJbw50xRf2ugSL9QxHVv9uASQitOtxhGFeAyfSZaX2h+IOYFbSyM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aaae:0:b0:d04:d397:352d with SMTP id
 t43-20020a25aaae000000b00d04d397352dmr130484ybi.4.1691014604767; Wed, 02 Aug
 2023 15:16:44 -0700 (PDT)
Date:   Wed, 2 Aug 2023 15:16:43 -0700
In-Reply-To: <cover.1690364259.git.haibo1.xu@intel.com>
Mime-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com>
Message-ID: <ZMrVrXlvu/FJEayx@google.com>
Subject: Re: [PATCH 0/4] RISCV: Add kvm Sstc timer selftest
From:   Sean Christopherson <seanjc@google.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023, Haibo Xu wrote:
> The sstc_timer selftest is used to validate Sstc timer functionality
> in a guest, which sets up periodic timer interrupts and check the
> basic interrupt status upon its receipt.
> 
> This KVM selftest was ported from aarch64 arch_timer and tested
> with Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> 
> Haibo Xu (4):
>   tools: riscv: Add header file csr.h
>   KVM: riscv: selftests: Add exception handling support
>   KVM: riscv: selftests: Add guest helper to get vcpu id
>   KVM: riscv: selftests: Add sstc_timer test

FYI, patch 4 will conflict with the in-flight guest printf changes[*], as will
reworking the existing arch_timer test.  My plan is to create an immutable tag
later this week (waiting to make sure nothing explodes).  I highly recommend basing
v2 on top of that.

[*] https://lore.kernel.org/all/20230729003643.1053367-1-seanjc@google.com
