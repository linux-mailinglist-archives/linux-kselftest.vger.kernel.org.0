Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD857D4BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 22:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiGUUYU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 16:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUUYU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 16:24:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3B987F5B
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 13:24:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z22so4557031lfu.7
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aD4926dvljhrKdsU/hZIUVWeXcneDH2x6OW5Cqf9UI=;
        b=Vamwul9sMeLAf/BVd5hnWopf/OqMlFv4Unis7y21ZX+sHwCRPS2CLpzRwc92HMP/E+
         //4x5Mz2jZLtKveoiQlGarXNW747cGzQH6BiceV1rRFj0scZ2M/G6uxXGB+6wJhFgHHa
         3y549YTAgt5UMCg2Q1R4lAzQmqlGXIEFbi6x1gx8WDDsx508/iVq8lyu9pg/xTwyBFK9
         8GXlYSfBDUV9BIRSDHW+etyLsj3D7WpK84EyEywXL22DzkCxDqxmMZ9uqGxmUFIO/rzA
         D5wy3Rof67Vqy2KpKFEJq2CI0qH1fdlsNmeskw3t9WHrnbZKWXCFXQiUqKj0NjqTXKtT
         UGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aD4926dvljhrKdsU/hZIUVWeXcneDH2x6OW5Cqf9UI=;
        b=nu9rahLvZGXsaFpyngwR6Ly2kkRYIthJzJYh/+JCf4MljDTANDMpTfkjnlGyfnaJVh
         4yBI5bBXZTzq+E9g4X8HuM7hAtcyDJJZ/5VfIYWeIk3Ld/DfCTVYH67I8WW7QaR8+Bxw
         rVwjxy3a2wcwlDEu6S1urAWNHlHxTqW25ztrHgEMBz+cOhjj5hPNt9nDP9Zk5q7zHdPe
         y321QB1XKHyRwzvTV0gvzb/wraMulcLuvj1LGVqAMloMcCaS82aJakZwDc+nNxpQlsfp
         0RApBPhaIAVGdensk3Sh8coZob6V5VK2itB+r3Kz2KLtvfv0h6haGmZbyMTzkyUUYy2O
         vtPA==
X-Gm-Message-State: AJIora//zjF3ZNKVFZxmgpLt2fjLZaiH30PJdrSV8tkG3JYU0lWWrMfO
        E/y/ueGOod1GYVMB1fFUZnh+6b2IHRRjkCqUtCa92Q==
X-Google-Smtp-Source: AGRyM1tKFqn+ojVEqhdqlrqIY2yacsxNP5Zhgoo4Q+xNu2RFlpsmlAsmC3H6RCZBj00h97rACmBXAlbpdTjW3oQhnJM=
X-Received: by 2002:a05:6512:1381:b0:489:cd0b:3a03 with SMTP id
 p1-20020a056512138100b00489cd0b3a03mr12880lfa.583.1658435056200; Thu, 21 Jul
 2022 13:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220511000811.384766-1-vannapurve@google.com>
 <20220511000811.384766-3-vannapurve@google.com> <YtiJx11AZHslcGnN@google.com>
In-Reply-To: <YtiJx11AZHslcGnN@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 21 Jul 2022 13:24:04 -0700
Message-ID: <CAGtprH9BQkcJcpp=uEJJLwM-Z=cW9rsJ7iVKbjv_gisVj8EWGQ@mail.gmail.com>
Subject: Re: [RFC V2 PATCH 2/8] selftests: kvm: Add a basic selftest to test
 private memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, "H . Peter Anvin" <hpa@zytor.com>,
        shauh@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>, wei.w.wang@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Austin Diviness <diviness@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 20, 2022 at 4:03 PM Sean Christopherson <seanjc@google.com> wrote:
> ...
> > + * which doesn't handle global offset table updates. Calling standard libc
> > + * functions would normally result in referring to the global offset table.
> > + * Adding O1 here seems to prohibit compiler from replacing the memory
> > + * operations with standard libc functions such as memset.
> > + */
>
> Eww.  We should either fix kvm_vm_elf_load() or override the problematic libc
> variants.  Playing games with per-function attributes is not maintainable.
>

I will try to spend more time on how kvm_vm_elf_load can be modified
to handle GOT fixups in different scenarios including
statically/dynamically linked sefltest binaries as I currently recall
limited information here.

But modifying kvm_vm_elf_load to fixup GOT entries will be
insufficient as guest VM code (possibly whole selftest binary) will
need to be compiled with flags that allow memset/memcpy
implementations to work with specific guest VM configurations e.g. AVX
extension. Same concern is outlined in
https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/kvm/lib/x86_64/svm.c#L64.

Would it be ok to maintain selftest binary compilation flags based on
guest VM configurations?

> > +static bool __attribute__((optimize("O1"))) do_mem_op(enum mem_op op,
> > +             void *mem, uint64_t pat, uint32_t size)
>
> Oof.  Don't be so agressive in shortening names, _especially_ when there's no
> established/universal abbreviation.  It took me forever to figure out that "pat"
> is "pattern".  And for x86, "pat" is especially confusing because it already
> a very well-established name that just so happens to be relevant to memory types,
> just a different kind of a memory type...
>
> > +{
> > +     uint64_t *buf = (uint64_t *)mem;
> > +     uint32_t chunk_size = sizeof(pat);
> > +     uint64_t mem_addr = (uint64_t)mem;
> > +
> > +     if (((mem_addr % chunk_size) != 0) || ((size % chunk_size) != 0))
>
> All the patterns are a repeating byte, why restrict this to 8-byte chunks?  Then
> this confusing assert-but-not-an-assert goes away.
>
> > +             return false;
> > +
> > +     for (uint32_t i = 0; i < (size / chunk_size); i++) {
> > +             if (op == SET_PAT)
> > +                     buf[i] = pat;
> > +             if (op == VERIFY_PAT) {
> > +                     if (buf[i] != pat)
> > +                             return false;
>
> If overriding memset() and memcmp() doesn't work for whatever reason, add proper
> helpers instead of a do_stuff() wrapper.
>
> > +             }
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +/* Test to verify guest private accesses on private memory with following steps:
> > + * 1) Upon entry, guest signals VMM that it has started.
> > + * 2) VMM populates the shared memory with known pattern and continues guest
> > + *    execution.
> > + * 3) Guest writes a different pattern on the private memory and signals VMM
> > + *      that it has updated private memory.
> > + * 4) VMM verifies its shared memory contents to be same as the data populated
> > + *      in step 2 and continues guest execution.
> > + * 5) Guest verifies its private memory contents to be same as the data
> > + *      populated in step 3 and marks the end of the guest execution.
> > + */
> > +#define PMPAT_ID                             0
> > +#define PMPAT_DESC                           "PrivateMemoryPrivateAccessTest"
> > +
> > +/* Guest code execution stages for private mem access test */
> > +#define PMPAT_GUEST_STARTED                  0ULL
> > +#define PMPAT_GUEST_PRIV_MEM_UPDATED         1ULL
> > +
> > +static bool pmpat_handle_vm_stage(struct kvm_vm *vm,
> > +                     void *test_info,
> > +                     uint64_t stage)
>
>
> Align parameters, both in prototypes and in invocations.  And don't wrap unnecessarily.
>
> static bool pmpat_handle_vm_stage(struct kvm_vm *vm, void *test_info,
>                                   uint64_t stage)
>
>
> Or even let that poke out (probably not in this case, but do keep in mind that the
> 80 char "limit" is a soft limit that can be broken if doing so yields more readable
> code).
>
> static bool pmpat_handle_vm_stage(struct kvm_vm *vm, void *test_info, uint64_t stage)
>
> > +{
> > +     void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
> > +
> > +     switch (stage) {
> > +     case PMPAT_GUEST_STARTED: {
> > +             /* Initialize the contents of shared memory */
> > +             TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
> > +                     TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
> > +                     "Shared memory update failure");
>
> Align indentation (here and many other places).
>
> > +             VM_STAGE_PROCESSED(PMPAT_GUEST_STARTED);
> > +             break;
> > +     }
> > +     case PMPAT_GUEST_PRIV_MEM_UPDATED: {
> > +             /* verify host updated data is still intact */
> > +             TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
> > +                     TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
> > +                     "Shared memory view mismatch");
> > +             VM_STAGE_PROCESSED(PMPAT_GUEST_PRIV_MEM_UPDATED);
> > +             break;
> > +     }
> > +     default:
> > +             printf("Unhandled VM stage %ld\n", stage);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static void pmpat_guest_code(void)
> > +{
> > +     void *priv_mem = (void *)TEST_MEM_GPA;
> > +     int ret;
> > +
> > +     GUEST_SYNC(PMPAT_GUEST_STARTED);
> > +
> > +     /* Mark the GPA range to be treated as always accessed privately */
> > +     ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
> > +             TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
> > +             KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
> > +     GUEST_ASSERT_1(ret == 0, ret);
>
> "!ret" instead of "ret == 0"
>
> > +
> > +     GUEST_ASSERT(do_mem_op(SET_PAT, priv_mem, TEST_MEM_DATA_PAT2,
> > +                     TEST_MEM_SIZE));
> > +     GUEST_SYNC(PMPAT_GUEST_PRIV_MEM_UPDATED);
> > +
> > +     GUEST_ASSERT(do_mem_op(VERIFY_PAT, priv_mem,
> > +                     TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +static struct test_run_helper priv_memfd_testsuite[] = {
> > +     [PMPAT_ID] = {
> > +             .test_desc = PMPAT_DESC,
> > +             .vmst_handler = pmpat_handle_vm_stage,
> > +             .guest_fn = pmpat_guest_code,
> > +     },
> > +};
>
> ...
>
> > +/* Do private access to the guest's private memory */
> > +static void setup_and_execute_test(uint32_t test_id)
>
> This helper appears to be the bulk of the shared code between tests.  This can
> and should be a helper to create a VM with private memory.  Not sure what to call
> such a helper, maybe vm_create_with_private_memory()?  A little verbose, but
> literal isn't always bad.
>
> > +{
> > +     struct kvm_vm *vm;
> > +     int priv_memfd;
> > +     int ret;
> > +     void *shared_mem;
> > +     struct kvm_enable_cap cap;
> > +
> > +     vm = vm_create_default(VCPU_ID, 0,
> > +                             priv_memfd_testsuite[test_id].guest_fn);
> > +
> > +     /* Allocate shared memory */
> > +     shared_mem = mmap(NULL, TEST_MEM_SIZE,
> > +                     PROT_READ | PROT_WRITE,
> > +                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
> > +     TEST_ASSERT(shared_mem != MAP_FAILED, "Failed to mmap() host");
> > +
> > +     /* Allocate private memory */
> > +     priv_memfd = memfd_create("vm_private_mem", MFD_INACCESSIBLE);
> > +     TEST_ASSERT(priv_memfd != -1, "Failed to create priv_memfd");
> > +     ret = fallocate(priv_memfd, 0, 0, TEST_MEM_SIZE);
> > +     TEST_ASSERT(ret != -1, "fallocate failed");
> > +
> > +     priv_memory_region_add(vm, shared_mem,
> > +                             TEST_MEM_SLOT, TEST_MEM_SIZE,
> > +                             TEST_MEM_GPA, priv_memfd, 0);
> > +
> > +     pr_info("Mapping test memory pages 0x%x page_size 0x%x\n",
> > +                                     TEST_MEM_SIZE/vm_get_page_size(vm),
> > +                                     vm_get_page_size(vm));
> > +     virt_map(vm, TEST_MEM_GPA, TEST_MEM_GPA,
> > +                                     (TEST_MEM_SIZE/vm_get_page_size(vm)));
> > +
> > +     /* Enable exit on KVM_HC_MAP_GPA_RANGE */
> > +     pr_info("Enabling exit on map_gpa_range hypercall\n");
> > +     ret = ioctl(vm_get_fd(vm), KVM_CHECK_EXTENSION, KVM_CAP_EXIT_HYPERCALL);
> > +     TEST_ASSERT(ret & (1 << KVM_HC_MAP_GPA_RANGE),
> > +                             "VM exit on MAP_GPA_RANGE HC not supported");
>
> Impressively bizarre indentation :-)
>

Thanks Sean for all the feedback here. I will address the comments in
the next series.

Regards,
Vishal
