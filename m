Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B446465D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 01:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLHA1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 19:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLHA1J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 19:27:09 -0500
X-Greylist: delayed 1806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 16:27:08 PST
Received: from out-225.mta0.migadu.com (out-225.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCFA8C685
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 16:27:08 -0800 (PST)
Date:   Thu, 8 Dec 2022 00:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670459226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8bdcc50wn8UsmiJI5n21HPc9V1IZkZNXUkx+5w7LeM=;
        b=LtxGLfgdz34RIqWijaQ+k2KPddTbVRBOnyMr/S2dcqR+op21TvVEcK8B4TysysD2vTkcPF
        FT17LaFAkwidPdPfNVkviHSMB5dnJRhtZG7UYRSq7lRDazE4GcDoNK0q+TP+8msYlFAq2L
        TRWNQfMlVL23nt6S/7a2W5rSHEhTt9c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: arm64: selftests: Align VA space allocator with
 TTBR0
Message-ID: <Y5EvVtAoDSHvIKie@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-4-oliver.upton@linux.dev>
 <Y5EtP5z6rxSK1VUe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5EtP5z6rxSK1VUe@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 08, 2022 at 12:18:07AM +0000, Sean Christopherson wrote:

[...]

> Together, what about?  The #ifdef is a bit gross, especially around "hi_start",
> but it's less duplicate code.  And IMO, having things bundled in the same place
> makes it a lot easier for newbies (to arm64 or kernel coding in general) to
> understand what's going on and why arm64 is different.

I'd rather we not go this route. We really shouldn't make any attempt to
de-dupe something that is inherently architecture specific.

For example:

> +	/*
> +	 * All architectures supports splitting the virtual address space into
> +	 * a high and a low half.  Populate both halves, except for arm64 which
> +	 * currently uses only TTBR0_EL1 (arbitrary selftests "logic"), i.e.
> +	 * only has a valid low half.
> +	 */
> +	sparsebit_num_t nr_va_bits = (1ULL << (vm->va_bits - 1)) >> vm->page_shift;

This is still wrong for arm64. When we say the VA space is 48 bits, we
really do mean that TTBR0 is able to address a full 48 bits. So this
truncates the MSB for the addressing mode.

With the code living in the arm64 side of the shop, I can also tailor
the comment to directly match the architecture to provide breadcrumbs
tying it back to the Arm ARM.

--
Thanks,
Oliver
