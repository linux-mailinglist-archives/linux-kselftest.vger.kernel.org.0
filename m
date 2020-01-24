Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76567148E17
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 19:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391756AbgAXSyK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 13:54:10 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45046 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388710AbgAXSyK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 13:54:10 -0500
Received: by mail-vk1-f194.google.com with SMTP id y184so835166vkc.11
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9IbFX230h+2YJkS//36Bone21Vlk4mvmv7ukUtwlrg=;
        b=DAXjtZMQxree0LJO6fobOGURErQ0ju/inC8/fsZF0REb/T72vFjS7K0OhD0Y+lf2gK
         lMPRw+NUBnFlszUuo1F/uLO7RoYDcq6CWVZ5BnXUxTgouURwMS2+PEcc6JnpM+rHv1lO
         Q+wAY4Fvcu1Tt5CmyotNaXTNXtiYUbF2NVpmLkfbcJaUW2KVvuXLwarJvxsy/CmqxCzc
         lF0yf3bRXw9OsO6bwUqmrWWhymuzSbWXcS4C1Yxq5LfRRbxfXuwQcB+KudGLC8h6tVTk
         XaEai9+ATEb46ZczpqDbhaWNgUERSjbEX/rDpyXjd+8ejWhSyzbE4tkDbrAZZHxu2to0
         jFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9IbFX230h+2YJkS//36Bone21Vlk4mvmv7ukUtwlrg=;
        b=EWJIHQGNj18zx6Fa5bVZ7mFZW+bYivXzj5B1sFzUpVGDIkel9SAf5knXnDMucGuUdq
         vD76cof+QVMUeerIHY3fcat22VLYsQIdzXH5x1xxLKu5dF7ls8lBdRK68saI/rNz00Cw
         unxcz6psi3gy7a0peLtPDMRmUXY4/hR8tDnJwskLBGGwvmJzYLiFGmWPG0FRF/6KTu+0
         qynZLwZ1gTAnd0gzVQunTGquEFRqk+d5Wnq10JAghOCmPxN+TLcJ2BiwQ8ktROZRVoWE
         1xPBywA2mPKkVW/u/5IKCwbQl7BC8udUVa+SEeEg53Oik6t88YKB4m0c5yAtGdgEAaYR
         YB4Q==
X-Gm-Message-State: APjAAAUpQuUM1xZx1ZHh9mzFFhrBPCxUqUlUrkdCk1QylGkbx3Sol57g
        mvDxURVe+Q/z//rQ8cabCUtsvbEr7QM6zKrDfYgBhg==
X-Google-Smtp-Source: APXvYqw2YjgP0ld3PdNvgZHc2Qrs2rZ5eSmsUx2bHhYUETj9IyOKKofaCjFO6+esQ4rua8ianeDtcJVIAImimd5dRp4=
X-Received: by 2002:a1f:db81:: with SMTP id s123mr2936809vkg.45.1579892048933;
 Fri, 24 Jan 2020 10:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com> <20200123180436.99487-11-bgardon@google.com>
 <aaf2afbb-1613-cc78-8b4f-6a7318acb22a@redhat.com>
In-Reply-To: <aaf2afbb-1613-cc78-8b4f-6a7318acb22a@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Fri, 24 Jan 2020 10:53:57 -0800
Message-ID: <CANgfPd-cj4Bau4fYRoQY3hW0K4w19LaFr=6RjgyZGO65fZuq9g@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] KVM: selftests: Move memslot 0 above KVM
 internal memslots
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 1:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/01/20 19:04, Ben Gardon wrote:
> > KVM creates internal memslots between 3 and 4 GiB paddrs on the first
> > vCPU creation. If memslot 0 is large enough it collides with these
> > memslots an causes vCPU creation to fail. Instead of creating memslot 0
> > at paddr 0, start it 4G into the guest physical address space.
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> This breaks all tests for me:
>
>    $ ./state_test
>    Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
>    Guest physical address width detected: 46
>    ==== Test Assertion Failure ====
>   lib/x86_64/processor.c:580: false
>   pid=4873 tid=4873 - Success
>      1  0x0000000000409996: addr_gva2gpa at processor.c:579
>      2  0x0000000000406a38: addr_gva2hva at kvm_util.c:1636
>      3  0x000000000041036c: kvm_vm_elf_load at elf.c:192
>      4  0x0000000000409ea9: vm_create_default at processor.c:829
>      5  0x0000000000400f6f: main at state_test.c:132
>      6  0x00007f21bdf90494: ?? ??:0
>      7  0x0000000000401287: _start at ??:?
>   No mapping for vm virtual address, gva: 0x400000

Uh oh, I obviously did not test this patch adequately. My apologies.
I'll send another version of this patch after I've had time to test it
better. The memslots between 3G and 4G are also somewhat x86 specific,
so maybe this code should be elsewhere.

>
> Memslot 0 should not be too large, so this patch should not be needed.

I found that 3GB was not sufficient for memslot zero in my testing
because it needs to contain both the stack for every vCPU and the page
tables for the VM. When I ran with 416 vCPUs and of 1.6TB of total
ram, memslot zero needed to be substantially larger than 3G. Just the
4K guest PTEs required to map 4G per-vCPU for 416 vCPUs require (((416
* (4<<30)) / 4096) * 8) / (1<<30) = 3.25GB of memory.
I suppose another slot could be used for the page tables, but that
would complicate the implementation of any tests that want to run
large VMs substantially.

>
> Paolo
>
