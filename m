Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726D243215E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhJRPDE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhJRPC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:58 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA7C061771
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Oct 2021 08:00:47 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z5so600312ybj.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Oct 2021 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQkeMWxNdicFAAWTAtbOE6aF1W+WIaXoV/8+6cchqI8=;
        b=HQuhjHzd68lT6lhxBf8HUihdVnwS4T2Ig7sWEvOoCGgH+ysNUMxEI3OkdpA0XJ74h0
         +JbF74+ixWIP4aQ9aV+cZsR4mY7dUANs/zVo4qgrvzHBGLI8wpa07bQ+UixgKa75y/UO
         C8QKQboTm9rG3SZsGHsNXpR0TGfklavauhsf14OFmCnwBrzID3M9j5at+j75UpVCSx2D
         /fOfh3RfFDrqKLx9jnLqJOC/m5H7gypxMkx0a2L/mf0WAC4anpLHRrMTsz1nlizuu6Lt
         TCuvOEQtuoijHtNWIpS8evoR4GC97kOX1tr6sx8zqntbtS/+7+TmwBMzsdPBCiph2WF2
         oDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQkeMWxNdicFAAWTAtbOE6aF1W+WIaXoV/8+6cchqI8=;
        b=HWrzgQ9gvRkeidoR0c844+uGSHm92c+sPW7/Oz2mTFYvJUZusz70U6KdtXWyoP4KHl
         x9+R1HX4xwkKU4V8VgnCrJkZRGKSLd1GvYsGRbOo+Wqtqd6frI2KOnTbE4tt3tX58K3k
         +zxzlYbE+ipB7OudTiLwqvmTPkG19tJNsbrtYEKKDuTvvkZHtvkDwbE9kHpR2XYq0Z/n
         crENQLEz6bpU58yYCIIEAZVvttD0t5UMalBvmNeZOPVGRyH0dTZc1mH7ySUhj/6D0tnC
         jd8XN2lAQJ5uAi7uvr2PIpZzTDAun8olPb5tPBnAWJJQDr00cWNs9CXwPjKf7sAr9mtc
         V/SQ==
X-Gm-Message-State: AOAM531JrxVKFRWxClf/EuQ83aWUzx9pB7f3YRty++mmik9dsP3P7UsD
        s3+vr7Rj0CKj+OB0PF6/6d9DlayUybCuczwdmaEOaw==
X-Google-Smtp-Source: ABdhPJzTXAMFmMoIkV0+BXEjgWpxmi9RsQZHUznpHserY8wnyjT9v19fakt246AE5Zru3tzrkr8HqjfXlsxAVsKqAPg=
X-Received: by 2002:a25:1487:: with SMTP id 129mr32454048ybu.206.1634569246414;
 Mon, 18 Oct 2021 08:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211005234459.430873-3-michael.roth@amd.com>
In-Reply-To: <20211005234459.430873-3-michael.roth@amd.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 18 Oct 2021 08:00:00 -0700
Message-ID: <CAL715W+-H7ZSQZeZmAbbJNGKaZCNqf4VdLismivxux=gerFuDw@mail.gmail.com>
Subject: Re: [RFC 02/16] KVM: selftests: add hooks for managing encrypted
 guest memory
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> +                             uint8_t enc_bit)
> +{
> +       vm->memcrypt.enabled = true;
> +       vm->memcrypt.enc_by_default = enc_by_default;
> +       vm->memcrypt.has_enc_bit = has_enc_bit;
> +       vm->memcrypt.enc_bit = enc_bit;
> +}
> +
> +struct sparsebit *
> +vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
> +                          uint64_t *size)
> +{
> +       struct userspace_mem_region *region;
> +       struct sparsebit *encrypted_phy_pages;
> +
> +       if (!vm->memcrypt.enabled)
> +               return NULL;
> +
> +       region = memslot2region(vm, slot);
> +       if (!region)
> +               return NULL;
> +
> +       encrypted_phy_pages = sparsebit_alloc();
> +       sparsebit_copy(encrypted_phy_pages, region->encrypted_phy_pages);

Do we have to make a copy for the sparsebit? Why not just return the
pointer? By looking at your subsequent patches, I find that this data
structure seems to be just read-only?

-Mingwei
