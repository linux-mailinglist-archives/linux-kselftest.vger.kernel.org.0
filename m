Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA17B7EEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjJDMV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbjJDMV1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:21:27 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE893;
        Wed,  4 Oct 2023 05:21:22 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65d0da28fa8so12140906d6.0;
        Wed, 04 Oct 2023 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696422081; x=1697026881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AM7m7vaSmmMYAyEADAXdMx0sZwgXiamITxRXtutrqys=;
        b=Pb+59J6I4x7+S1oGKFk1bJMbVv3b4vAtsPo9ZvzEQrPxPUEt118fT/c0bA6E3lI2Vr
         8QbP3NeVw0TmB+2bwIhSTZk6TUmsMkCO+yVjo2apx00C5dX3KwiJYq1iZ8grhXEEtLiz
         ROejw1hldDFLIr84u12nRTpcZG+TvBl6KTh9MPSYjydXkU5T+r8hoVOSoqjNt9MvcjOj
         UzPMcmAKWiET2vOQsD4pINRw6dsJdN+SuPDO9mXrF5q486brTs8zYJ+rWZJ6RD/fleGl
         BRROJR27EAOsWtmyf1DTsFp2CwoibXohcAstP+feccQkr6qzrfVzvkd4sjthqcS8AI0w
         q+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422081; x=1697026881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM7m7vaSmmMYAyEADAXdMx0sZwgXiamITxRXtutrqys=;
        b=nP5SQUN2FWoa38WSwYhu0vD0SixUzH/34wWpkyjmqJ3LM3zUn+sui9H/Jf0lqDUf20
         FWh4CUUj5MXeSyhbuAssMJYCHQLD+daUCwkMJ1WQV4DzraavEFOH5qDNZPU7rU3D/t2Z
         bcyvDa5g+Xs/D90V1q/HvtDaC/jarGQRPulMA/nkB4jZEZoRBayx7CeYgocVxvmIXh8s
         CBVUZfG5b6R9jmNW5AeOz1Vi5AMVRJD/GSldY8mStvWmLX4zX/Hz3XIGArzagm3IW/PZ
         xcrs48PJSBuED0a4sHS9pGQ/fVf06/D2Wmo5ccTZKMARQiKhOiTZ1zXvIR7oyCtW1lO6
         JNAg==
X-Gm-Message-State: AOJu0YzawUDef7HgXoQgZEdn8VvUOARrGgkN1z+uiOwayX3QqxsroGxT
        jGHcsnceewFIWyx+vffIQ5s=
X-Google-Smtp-Source: AGHT+IH6JR0icKV87wR6aK9vYjlSTqVEiUxLPDe63ZwohLb+GJ8E9PGNFpX9Dg+q4xR/zsjTXO5W9A==
X-Received: by 2002:a0c:e18f:0:b0:656:4ba4:f8b6 with SMTP id p15-20020a0ce18f000000b006564ba4f8b6mr2113572qvl.54.1696422081606;
        Wed, 04 Oct 2023 05:21:21 -0700 (PDT)
Received: from luigi.stachecki.net ([2607:fb90:fe4a:a54:f3b3:2ab7:a445:b3f2])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cf00f000000b0065b12c7a48dsm1277228qvk.133.2023.10.04.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:21:21 -0700 (PDT)
Date:   Wed, 4 Oct 2023 08:21:11 -0400
From:   Tyler Stachecki <stachecki.tyler@gmail.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/5] KVM: x86: Fix breakage in KVM_SET_XSAVE's ABI
Message-ID: <ZR1Yt6Z+dhMbn/FJ@luigi.stachecki.net>
References: <20230928001956.924301-1-seanjc@google.com>
 <ZR0QOGo5DftkRWsr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR0QOGo5DftkRWsr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 04, 2023 at 04:11:52AM -0300, Leonardo Bras wrote:
> So this patch is supposed to fix migration of VM from a host with
> pre-ad856280ddea (OLD) kernel to a host with ad856280ddea + your set(NEW).
> Right?
> 
> Let's get the scenario here, where all machines are the same:
> 1 - VM created on OLD kernel with a host-supported xfeature F, which is not
>     guest supported.
> 2 - VM is migrated to a NEW kernel/host, and KVM_SET_XSAVE xfeature F.
> 3 - VM will be migrated to another host, qemu requests KVM_GET_XSAVE, which
>     returns only guest-supported xfeatures, and this is passed to next host
> 4 - VM will be started on 3rd host with guest-supported xfeatures, meaning
>     xfeature F is filtered-out, which is not good, because the VM will have
>     less features compared to boot.

This is what I was (trying) to convey earlier...

See Sean's response here:
https://lore.kernel.org/all/ZRMHY83W%2FVPjYyhy@google.com/

I'll copy the pertinent part of his very detailed response inline:
> KVM *must* "trim" features when servicing KVM_GET_SAVE{2}, because that's been
> KVM's ABI for a very long time, and userspace absolutely relies on that
> functionality to ensure that a VM can be migrated within a pool of heterogenous
> systems so long as the features that are *exposed* to the guest are supported
> on all platforms.

My 2 cents: as an outsider with less familiarity of the KVM code, it is hard
to understand the contract here with the guest/userspace. It seems there is a
fundamental question of whether or not "superfluous" features, those being
host-supported features which extend that which the guest is actually capable
of, can be removed between the time that the guest boots and when it
terminates, through however many live-migrations that may be.

Ultimately, this problem is not really fixable if said features cannot be
removed.

Is there an RFC or document which captures expectations of this form?
