Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08C5ADEB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 06:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiIFEys (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 00:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIFEyr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 00:54:47 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2FC12A98;
        Mon,  5 Sep 2022 21:54:45 -0700 (PDT)
Date:   Tue, 6 Sep 2022 05:54:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662440083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hEQ8207Wqe20jUMzx18IBRP3OCnR8vMZaKCXgkLkmoI=;
        b=cpKKgUdkl1pr2b5NAK+po55wTT4lLZFVj2qXXrk+tQJtYXNItl2oTLRu2W5BbAdhXBxw2d
        zVPdqLj35UVIKoqWdjwC+LOeaHmkB4MQkY09RikH1UtRHMJYcb+LiGFTEEvAfDSNba37CD
        z91nYZEs/rqeI0hbE1URG2e9enSD2Vs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Reiji Watanabe <reijiw@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 7/7] KVM: selftests: Add test for RAZ/WI AArch32 ID
 registers
Message-ID: <YxbSkCMxZdwKGqQM@google.com>
References: <20220902154804.1939819-1-oliver.upton@linux.dev>
 <20220902154804.1939819-8-oliver.upton@linux.dev>
 <20220905073140.lrsrbyu2zhkiki5a@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905073140.lrsrbyu2zhkiki5a@kamzik>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Drew,

On Mon, Sep 05, 2022 at 09:31:40AM +0200, Andrew Jones wrote:

[...]

> > +static uint64_t reg_ids[] = {
> > +	KVM_ARM64_SYS_REG(SYS_ID_PFR0_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_PFR1_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_DFR0_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_MMFR0_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_MMFR1_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_MMFR2_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_MMFR3_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_ISAR0_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_ISAR1_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_ISAR2_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_ISAR3_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_ISAR4_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_ISAR5_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_MMFR4_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_ISAR6_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_MVFR0_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_MVFR1_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_MVFR2_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_PFR2_EL1),
> > +	KVM_ARM64_SYS_REG(SYS_ID_MMFR5_EL1),
> 
> Hi Oliver,
> 
> I see all the hidden and unallocated registers have been filtered out of
> the test lists. They should also behave as RAZ, right? Maybe we should
> keep them in the lists here for consistency and to test them as well.

Sure, can do. The reason I only tested these registers is because they
have RAZ/WI behavior with this series, whereas the rest are RAZ +
invariant. Should be easy enough to cover the whole range, though.

--
Thanks,
Oliver
