Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430959947A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbiHSF2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243197AbiHSF2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:28:11 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9B8E0948;
        Thu, 18 Aug 2022 22:28:09 -0700 (PDT)
Date:   Fri, 19 Aug 2022 07:28:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660886888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVozTVP3R6alT//Ll18ulj/6MH8/qR/TwWtAnvBrzdU=;
        b=PMVRFKEZeKyE8EKMtXnLtfOneiT2O4Md6EbjoDnjs8TZwCMnre2cYE8B5wXoyUp7+VZUDi
        rkPY43Q9UBf2HkEAX370IebDwbZrbovf2i8dqr69md/ZWSGw8MNtVegMBEMuMBZcYbryyw
        X9xABLnKrnUYYniQPyUqfhwsay43Jlk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peterx@redhat.com, pbonzini@redhat.com, corbet@lwn.net,
        maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH v1 3/5] KVM: selftests: Dirty host pages in dirty_log_test
Message-ID: <20220819052805.qnhw2d3arxixzvhl@kamzik>
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-4-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819005601.198436-4-gshan@redhat.com>
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

On Fri, Aug 19, 2022 at 08:55:59AM +0800, Gavin Shan wrote:
> It's assumed that 1024 host pages, instead of guest pages, are dirtied
> in each iteration in guest_code(). The current implementation misses
> the case of mismatched page sizes in host and guest. For example,
> ARM64 could have 64KB page size in guest, but 4KB page size in host.
> (TEST_PAGES_PER_LOOP / 16), instead of TEST_PAGES_PER_LOOP, host pages
> are dirtied in every iteration.
> 
> Fix the issue by touching all sub-pages when we have mismatched
> page sizes in host and guest.

I'll let the dirty-log test authors decide what's best to do for this
test, but I'd think we should let the guest continue dirtying its
pages without knowledge of the host pages. Then, adjust the host test
code to assert all sub-pages, other than the ones it expects the guest
to have written, remain untouched.

Thanks,
drew
