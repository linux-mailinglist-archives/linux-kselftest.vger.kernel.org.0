Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2959E7A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbiHWQh6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 12:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245016AbiHWQhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 12:37:24 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C7D6D54D;
        Tue, 23 Aug 2022 07:44:51 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661265889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYTxuO09xQHamH8HB9DanmNLqgTyS7iN+66gFB/iGcs=;
        b=KzS2iPpdIzfHDC3yepdSeojEKRrJeBGV61JZxpWQCWAB5NKd2i2D94pZKSuDM3G2eJ+izs
        YH21AVjrNOZyMSuuQy6w0ir/+3q7zjahK2l6toOyZkSk/VUDgyVAMtk9rvwdQk0szY003u
        jUrrEx4Pa3dRbNvCt5aPDinF0ofcJvA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, peterx@redhat.com,
        pbonzini@redhat.com, corbet@lwn.net, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
Message-ID: <YwTn2r6FLCx9mAU7@google.com>
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-2-gshan@redhat.com>
 <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <87fshovtu0.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fshovtu0.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 22, 2022 at 10:42:15PM +0100, Marc Zyngier wrote:
> Hi Gavin,
> 
> On Mon, 22 Aug 2022 02:58:20 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
> > 
> > Hi Marc,
> > 
> > On 8/19/22 6:00 PM, Marc Zyngier wrote:
> > > On Fri, 19 Aug 2022 01:55:57 +0100,
> > > Gavin Shan <gshan@redhat.com> wrote:
> > >> 
> > >> The ring-based dirty memory tracking has been available and enabled
> > >> on x86 for a while. The feature is beneficial when the number of
> > >> dirty pages is small in a checkpointing system or live migration
> > >> scenario. More details can be found from fb04a1eddb1a ("KVM: X86:
> > >> Implement ring-based dirty memory tracking").
> > >> 
> > >> This enables the ring-based dirty memory tracking on ARM64. It's
> > >> notable that no extra reserved ring entries are needed on ARM64
> > >> because the huge pages are always split into base pages when page
> > >> dirty tracking is enabled.
> > > 
> > > Can you please elaborate on this? Adding a per-CPU ring of course
> > > results in extra memory allocation, so there must be a subtle
> > > x86-specific detail that I'm not aware of...
> > > 
> > 
> > Sure. I guess it's helpful to explain how it works in next revision.
> > Something like below:
> > 
> > This enables the ring-based dirty memory tracking on ARM64. The feature
> > is enabled by CONFIG_HAVE_KVM_DIRTY_RING, detected and enabled by
> > CONFIG_HAVE_KVM_DIRTY_RING. A ring buffer is created on every vcpu and
> > each entry is described by 'struct kvm_dirty_gfn'. The ring buffer is
> > pushed by host when page becomes dirty and pulled by userspace. A vcpu
> > exit is forced when the ring buffer becomes full. The ring buffers on
> > all vcpus can be reset by ioctl command KVM_RESET_DIRTY_RINGS.
> > 
> > Yes, I think so. Adding a per-CPU ring results in extra memory allocation.
> > However, it's avoiding synchronization among multiple vcpus when dirty
> > pages happen on multiple vcpus. More discussion can be found from [1]
> 
> Oh, I totally buy the relaxation of the synchronisation (though I
> doubt this will have any visible effect until we have something like
> Oliver's patches to allow parallel faulting).
> 

Heh, yeah I need to get that out the door. I'll also note that Gavin's
changes are still relevant without that series, as we do write unprotect
in parallel at PTE granularity after commit f783ef1c0e82 ("KVM: arm64:
Add fast path to handle permission relaxation during dirty logging").

--
Thanks,
Oliver
