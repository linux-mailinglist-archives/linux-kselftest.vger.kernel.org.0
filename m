Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9091868A4BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 22:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjBCVg2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 16:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjBCVgY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 16:36:24 -0500
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 13:36:09 PST
Received: from out-75.mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3597A8A3D
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 13:36:09 -0800 (PST)
Date:   Fri, 3 Feb 2023 21:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675459825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2wKiDc3ijvfRcPytBTnYThEIpGCkfZyMLsZ4A0/NL14=;
        b=GIuXwkfF5SespCmBTOJAXKlo1F9yIYLPzcLhk3ZDpddbYFK9FwBiQLS4psW6n3KPnkpBph
        QrZuGrt4waL5zYLVll38NqmwJZL/FLlD+VxUYgufMFgC5vXiUW9gHvkMMmB8EWp+yxmdqD
        XsFGYpV4TmZXMppL17eiU5z/kBL5IUM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     shahuang@redhat.com, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Matlack <dmatlack@google.com>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.linux.dev>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: selftests: Remove redundant setbuf()
Message-ID: <Y9185pzirL1Bqo20@google.com>
References: <20230203061038.277655-1-shahuang@redhat.com>
 <Y91VV+WWrakREsN6@google.com>
 <Y91XSZaRyqJjsg8o@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y91XSZaRyqJjsg8o@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 06:49:45PM +0000, Oliver Upton wrote:
> On Fri, Feb 03, 2023 at 06:41:27PM +0000, Sean Christopherson wrote:
> > On Fri, Feb 03, 2023, shahuang@redhat.com wrote:
> > > From: Shaoqin Huang <shahuang@redhat.com>
> > > 
> > > Since setbuf(stdout, NULL) has been called in kvm_util.c with
> > > __attribute((constructor)). Selftests no need to setup it in their own
> > > code.
> > > 
> > > Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> > > ---
> > 
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
> 
> Thanks!
> 
> > Oliver/Marc, want to grab this one?  I doubt there will be conflicts, but IIRC
> > there are a handful of in-flight changes for aarch64/page_fault_test.c.
> 
> That is indeed the plan.

Now fully caffeinated I see that this was poking at an x86 selftest too.
Thanks for reviewing it, I'll grab the patch today.

-- 
Thanks,
Oliver
