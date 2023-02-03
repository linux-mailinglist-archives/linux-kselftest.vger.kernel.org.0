Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402A868A24D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjBCS4H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 13:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBCS4H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 13:56:07 -0500
X-Greylist: delayed 371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 10:56:06 PST
Received: from out-112.mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B623112
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 10:56:05 -0800 (PST)
Date:   Fri, 3 Feb 2023 18:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675450192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wN4paWkwXIa3CFgztXV8SjaEAKuP+2RoDhhtXu4cIuU=;
        b=jO6B/3uutUTT+e3ZPGeCi9N2WzRphHCd8Zvt0BZnk3yz3hqj0/QgdlY4HYzBqDa7nYVYR4
        y3EIPzceLl6k9iZPGNf8CLHnL6iIYKEUTXzCerI9p/kEgRr/r62o7EW1USVsS6OZnqey0/
        4+MyUYmWm61ViF9E8I8/vrzR7q8kJ1Q=
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
Message-ID: <Y91XSZaRyqJjsg8o@google.com>
References: <20230203061038.277655-1-shahuang@redhat.com>
 <Y91VV+WWrakREsN6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y91VV+WWrakREsN6@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 06:41:27PM +0000, Sean Christopherson wrote:
> On Fri, Feb 03, 2023, shahuang@redhat.com wrote:
> > From: Shaoqin Huang <shahuang@redhat.com>
> > 
> > Since setbuf(stdout, NULL) has been called in kvm_util.c with
> > __attribute((constructor)). Selftests no need to setup it in their own
> > code.
> > 
> > Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> > ---
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>

Thanks!

> Oliver/Marc, want to grab this one?  I doubt there will be conflicts, but IIRC
> there are a handful of in-flight changes for aarch64/page_fault_test.c.

That is indeed the plan.

Applying patches for arm64 has taken a bit longer because I don't
yet have push access to kvmarm so I need Marc to pull from me. The net
effect is emailed thankyous are delayed by a few days, but that wont be
an issue going forward.

-- 
Thanks,
Oliver
