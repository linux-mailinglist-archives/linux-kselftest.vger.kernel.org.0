Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09793D92C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhG1QIG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhG1QH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:07:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38430C061764
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jul 2021 09:07:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k1so3216051plt.12
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jul 2021 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B9f6uyUz014fnggzO8Lz7MpHz0USkcYzM/T+4Ea78YM=;
        b=UU5KdHZMP9IBGOyfkQN4ImyUxqovhAimR6tPwqXnZG0/QBAtlYgm5bNzO/2W3e3Mm4
         o0ygSHzBIDMjtiuybMD47c94ckdLt4Dok/gkm32senPg5kCn0K9ZpDerrYWDfsHo4UPn
         r/CkGC3O0SYBwaldA9baaB+4/0xzxd6cuB8kfc2kHexu53l5XLxuEM9Tm00EYYo8rfRg
         4lsoaTnwx+e1oSMKMkOF3a5o45XXbDIJ0sgfDtR/zjYrkrwEqzGkdK4vk83uYig5GmLa
         BwVF8M8KEfUf9nBZFdTP78JGEDhYKce4ojgcs/nGBODMepMkcO/UqD79xte6Glxl3Err
         dWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B9f6uyUz014fnggzO8Lz7MpHz0USkcYzM/T+4Ea78YM=;
        b=TR8mb9JLLRYXoCi0Xi+oEwKjWIYcRAtqKBGa+GA5jusO2E7OuW2huah5oNQo36K6Qm
         FJHowC9TihFVFJ0xK8bTj4ADP89E0IdeqiDNgxKHpHKuoOF9bj/+EJWZ/vjAneP63NUr
         vvdgt01HgKEhjcKp6JXcbfwBm5hP5ThI9feYAnHn+vvF53T2zjORCULRJ5qRuy9WDnYj
         F0O6h8P0wpu4St1DvIY1AWWf8KiovHKOmfIT2jQoGjYeGWcalzbTxQ7C7daw3zcY8wVF
         OrRDm1mYZ8wCvxt6+aOIe+xRn7MrF1MPvFolx/PpAgZs4qpWzH9ktX7rT7gIJVxjYXp4
         4C0Q==
X-Gm-Message-State: AOAM532I63CNOq/G3Y9dOG9kpVcAQDH0CI0tbWiEKbca0FPjGWvdu5BK
        MUetm4edU+aosWxwWSUl2OMEcg==
X-Google-Smtp-Source: ABdhPJyqhBT8FeAgjWJJ7ruwe46Q1IYbCWhTolNxYnN/jxsLiNOLefPNDqxF2KFRU35oEYxZ5FBXew==
X-Received: by 2002:a63:593:: with SMTP id 141mr494827pgf.133.1627488444252;
        Wed, 28 Jul 2021 09:07:24 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c2sm165230pgh.82.2021.07.28.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:07:23 -0700 (PDT)
Date:   Wed, 28 Jul 2021 16:07:19 +0000
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Erdem Aktas <erdemaktas@google.com>,
        linux-kselftest@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>, Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ricardo Koller <ricarkol@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] KVM: selftests: Add support for creating
 non-default type VMs
Message-ID: <YQGAtxWqBhBUYWBN@google.com>
References: <20210726183816.1343022-1-erdemaktas@google.com>
 <20210726183816.1343022-2-erdemaktas@google.com>
 <YP82iIe3vM/+fRAh@google.com>
 <YQBw8BIcCAq5ybHr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQBw8BIcCAq5ybHr@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 27, 2021 at 08:47:44PM +0000, Sean Christopherson wrote:
> On Mon, Jul 26, 2021, David Matlack wrote:
> > On Mon, Jul 26, 2021 at 11:37:54AM -0700, Erdem Aktas wrote:
> > > Currently vm_create function only creates KVM_X86_LEGACY_VM type VMs.
> > > Changing the vm_create function to accept type parameter to create
> > > new VM types.
> > > 
> > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> 
> *-by tags should not be added unless explicitly provided.  IIRC, our internal
> gerrit will convert +1 to Reviewed-by, but I don't think that's the case here.
> This applies to all patches in this series.
> 
> See "Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:" in
> Documentation/process/submitting-patches.rst for more info.
> 
> > > Reviewed-by: Peter Gonda <pgonda@google.com>
> > > Reviewed-by: Marc Orr <marcorr@google.com>
> > > Reviewed-by: Sagi Shahar <sagis@google.com>
> > 
> > Reviewed-by: David Matlack <dmatlack@google.com>
> > 
> > (aside from the nit below)
> > 
> > > ---
> > >  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
> > >  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++--
> > >  2 files changed, 27 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > > index d53bfadd2..c63df42d6 100644
> > > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > > @@ -88,6 +88,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
> > >  void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
> > >  
> > >  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> > > +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm, int type);
> > 
> > nit: Consider using a more readable function name such as
> > vm_create_with_type().
> 
> Ha!  This is why I don't like doing internal reviews :-D

+1 :)

> 
> Erdem originally had vm_create_type(), I suggested __vm_create() as the double
> underscore scheme is more common in the kernel for cases where there's a default
> wrapper and an inner helper that implements the full API.
> 
> Convention aside, the argument againsts ...with_type() are that it doesn't scale,
> e.g. if someone adds another parameter parameter for which vm_create() provides a
> default, and it doesn't self-document the relationship between vm_create() and
> the inner helper, e.g. by convention, based on names alone I know that vm_create()
> likely is a wrapper around __vm_create().

True, although with __vm_create() is not solving the scalability
problem, it's just preventing scaling altogether (you can only have 1
wrapper function, vm_create). So if any caller wants to override one of
the defaults they have to override all of them.

I agree with you though in this case: __vm_create() is a better choice
(especially given the existence of vm_create_with_vcpus).

A better option than both (but would involve more work) would be to
create an options struct with all optional arguments. Unfortunately C
makes working with options structs a bit clumsy. But it's something to
consider as the number of options passed to __vm_create increases.

For example:

struct vm_options {
        enum vm_guest_mode mode;
        uint64_t phy_pages;
        int perm;
        int type;
};

struct kvm_vm *vm_create(const struct vm_options *options)
{
        ...
}

static const struct vm_options default_vm_options = {
  .mode = VM_MODE_DEFAULT,
  .phy_pages = DEFAULT_GUEST_PHY_PAGES,
  .perm = O_RDWR,
  .type = DEFAULT_VM_TYPE,
};

/* Create a VM with default options. */
vm = create_vm(&default_vm_options);

/* Create a VM with TDX enabled. */
struct vm_options options = default_vm_options;
options.type = VM_TYPE_TDX;
vm = create_vm(&options);

(I'm sure I ham-fisted the const stuff but you get the idea.)

I'm toying with introducing an options struct to perf_test_util as well
so this is very top of mind.

> 
> Compare that with the existing
> 
>   vm_create_default_with_vcpus()
>   vm_create_default()
>   vm_create_with_vcpus()
>   vm_create()
> 
> where the relationship between all the helpers is not immediately clear, and
> vm_create_with_vcpus() is a misnomer because it does much more than call vm_create()
> and instantiate vCPUs, e.g. it also instantiates the IRQ chip and loads the test
> into guest memory.
