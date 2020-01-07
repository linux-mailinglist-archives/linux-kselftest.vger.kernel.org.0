Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC5132E59
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 19:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgAGS0Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 13:26:24 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38570 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGS0Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 13:26:24 -0500
Received: by mail-vs1-f67.google.com with SMTP id v12so136044vsv.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 10:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=180HQDGZyjA3825E1ybbAgS73yQoWTFqKE6iODg5bn4=;
        b=kz5j+01kye8wJBsHY0lsrDc02IJK8yj8NouSr3PjL4rhatokFqmtPTKBpkEOoKCbk5
         07DXnzBJGFjyWXYHJ0ZnsagSHIRkoLWfAG1lIhwn7RD0nYa21mxUy9W344TDDyc5hOoJ
         oj+jLds8pDjR1as1vZtgZU+BaU5LD1EeS/E1+4vdbBH9Iasjp6j9gT09gbOKRckF83Zl
         4gn4j/NuNlFWjGIedpSzoM3D3mIt/Lv95EZx7s/tArTee9Ow3rcdHQJ2KAuYMganEE+t
         gkL0Xf65n/vWGbSl304pSWPqC8hguj71i8m+r6PODrQ2uVhuH6MxS/2tG9aDiFbny4X9
         OhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=180HQDGZyjA3825E1ybbAgS73yQoWTFqKE6iODg5bn4=;
        b=VnfElMraqeVl4jzJNeZ7oAwHwDdnk0xlakojLSNRc6sdgabYs2lMbb6QR+LXCr09B+
         gmuQAY1YO6mv1SrpIiTX/EXjlb6ZusIUffwUqWtObD+COM08mSio0blwWEkjghxGar58
         6qwS+IEOnNiMpLnLZoJ/nfQwXcFu2nuomWqr7I0Fi0/w8uiZcAL89gyygKJr7aV2timG
         vm7knf9foeMOVlfGrAInHqVZLFz9QK1/KgWZdD9lkZg6ogUY/3NteuAEJZGtukuf3CS2
         JL53L0PCtJ8VAL8AIBumYl7s8o42+AlZJ6zvRq53KidDnVPY3qVfMglhsGG9QR4FkfTT
         ihqg==
X-Gm-Message-State: APjAAAV8xUC/EL0SbxJ+ofrWbuvUTroOPe2idyZWw8aZBjkKAFUgCg5Z
        AVyNjmXGs0DN86iROrKKWp9MpmKn9+YQ4xwwpZrXZw==
X-Google-Smtp-Source: APXvYqzkXi0wXOwP//CKn0kWO+Wgdv1M2iTHL07U2YSncefx4C6YPC5Jja38MLtT3ns+OFLPEsILPqyaF1cG8ZNjEMY=
X-Received: by 2002:a67:f054:: with SMTP id q20mr365066vsm.17.1578421582246;
 Tue, 07 Jan 2020 10:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com> <20191216213901.106941-6-bgardon@google.com>
 <20200107152341.rtfmciob5ly6nnjj@kamzik.brq.redhat.com>
In-Reply-To: <20200107152341.rtfmciob5ly6nnjj@kamzik.brq.redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 7 Jan 2020 10:26:10 -0800
Message-ID: <CANgfPd9aCcN8BJDkkDuC2=3Po3f6BQ6q7JkQfL7n+giDCySu7A@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] KVM: selftests: Pass args to vCPU instead of using globals
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 7, 2020 at 7:23 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Dec 16, 2019 at 01:38:58PM -0800, Ben Gardon wrote:
> > In preparation for supporting multiple vCPUs in the demand paging test,
> > pass arguments to the vCPU instead of syncing globals to it.
>
> This will only work if we don't spill parameters onto the stack and all
> data we want to pass fit in registers.

That's a great point. I'll see about using globals and deriving the
cpu ID to look up args. In your pseudocode below I see you use
arch_get_cpu_id, but I don't believe this function exists in selftests
and I don't have the knowledge off the top of my head to implement it
for s390 and aarch64. Do you have any pointers for implementing such a
function?

> I've used multiple VCPUs in tests
> before and stuck with the global syncing. I simply used arrays like this
>
>  static my_type_t my_data[NR_VCPUS];
>
>  static void guest_code(void)
>  {
>      int cpu = arch_get_cpu_id();
>
>      // do something with my_data[cpu]
>  }
>
>  int main(void)
>  {
>      for (i = 0; i < NR_VCPUS; ++i) {
>          // prepare my_data[i]
>          sync_global_to_guest(vm, my_data[i]);
>      }
>
>      // run vcpus
>
>     for (i = 0; i < NR_VCPUS; ++i) {
>          sync_global_from_guest(vm, my_data[i]);
>          // do something with my_data[i]
>     }
>  }
>
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  .../selftests/kvm/demand_paging_test.c        | 61 +++++++++++--------
> >  1 file changed, 37 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> > index 4aa90a3fce99c..8ede26e088ab6 100644
> > --- a/tools/testing/selftests/kvm/demand_paging_test.c
> > +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> > @@ -42,7 +42,6 @@
> >   */
> >  static uint64_t host_page_size;
> >  static uint64_t guest_page_size;
> > -static uint64_t guest_num_pages;
> >
> >  static char *guest_data_prototype;
> >
> > @@ -63,14 +62,13 @@ static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
> >   * Continuously write to the first 8 bytes of each page in the demand paging
> >   * memory region.
> >   */
> > -static void guest_code(void)
> > +static void guest_code(uint64_t gva, uint64_t pages)
> >  {
> >       int i;
> >
> > -     for (i = 0; i < guest_num_pages; i++) {
> > -             uint64_t addr = guest_test_virt_mem;
> > +     for (i = 0; i < pages; i++) {
> > +             uint64_t addr = gva + (i * guest_page_size);
> >
> > -             addr += i * guest_page_size;
> >               addr &= ~(host_page_size - 1);
> >               *(uint64_t *)addr = 0x0123456789ABCDEF;
> >       }
> > @@ -82,18 +80,31 @@ static void guest_code(void)
> >  static void *host_test_mem;
> >  static uint64_t host_num_pages;
> >
> > +struct vcpu_thread_args {
> > +     uint64_t gva;
> > +     uint64_t pages;
> > +     struct kvm_vm *vm;
> > +     int vcpu_id;
> > +};
> > +
> >  static void *vcpu_worker(void *data)
> >  {
> >       int ret;
> > -     struct kvm_vm *vm = data;
> > +     struct vcpu_thread_args *args = (struct vcpu_thread_args *)data;
> > +     struct kvm_vm *vm = args->vm;
> > +     int vcpu_id = args->vcpu_id;
> > +     uint64_t gva = args->gva;
> > +     uint64_t pages = args->pages;
> >       struct kvm_run *run;
> >
> > -     run = vcpu_state(vm, VCPU_ID);
> > +     vcpu_args_set(vm, vcpu_id, 2, gva, pages);
>
> vcpu_args_set() is currently only implemented by x86, so that's a good
> reason for this to be an x86-only test for now. Well, unless this is
> switched back to using global sync.
>
> > +
> > +     run = vcpu_state(vm, vcpu_id);
> >
> >       /* Let the guest access its memory */
> > -     ret = _vcpu_run(vm, VCPU_ID);
> > +     ret = _vcpu_run(vm, vcpu_id);
> >       TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
> > -     if (get_ucall(vm, VCPU_ID, NULL) != UCALL_SYNC) {
> > +     if (get_ucall(vm, vcpu_id, NULL) != UCALL_SYNC) {
> >               TEST_ASSERT(false,
> >                           "Invalid guest sync status: exit_reason=%s\n",
> >                           exit_reason_str(run->exit_reason));
> > @@ -269,11 +280,13 @@ static int setup_demand_paging(struct kvm_vm *vm,
> >  #define PAGE_SHIFT_4K  12
> >
> >  static void run_test(enum vm_guest_mode mode, bool use_uffd,
> > -                  useconds_t uffd_delay, uint64_t guest_memory_bytes)
> > +                  useconds_t uffd_delay, uint64_t vcpu_wss)
>
> Not sure why guest_memory_bytes was renamed to vcpu_wss. What is wss?
> Working set size?

wss indeed stands for working set size, but I agree there's no reason
to use it. I'll change guest_memory_bytes to vcpu_memory_bytes
instead.

>
> >  {
> >       pthread_t vcpu_thread;
> >       pthread_t uffd_handler_thread;
> >       struct kvm_vm *vm;
> > +     struct vcpu_thread_args vcpu_args;
> > +     uint64_t guest_num_pages;
> >       int r;
> >
> >       /*
> > @@ -283,16 +296,15 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
> >        * number will be enough for all archs. (e.g., 64K page size guest
> >        * will need even less memory for page tables).
> >        */
> > -     vm = create_vm(mode, VCPU_ID,
> > -                    (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
> > +     vm = create_vm(mode, VCPU_ID, (2 * vcpu_wss) >> PAGE_SHIFT_4K,
> >                      guest_code);
> >
> >       guest_page_size = vm_get_page_size(vm);
> >
> > -     TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
> > +     TEST_ASSERT(vcpu_wss % guest_page_size == 0,
> >                   "Guest memory size is not guest page size aligned.");
> >
> > -     guest_num_pages = guest_memory_bytes / guest_page_size;
> > +     guest_num_pages = vcpu_wss / guest_page_size;
> >
> >  #ifdef __s390x__
> >       /* Round up to multiple of 1M (segment size) */
> > @@ -308,9 +320,9 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
> >                   guest_num_pages, vm_get_max_gfn(vm));
> >
> >       host_page_size = getpagesize();
> > -     TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
> > +     TEST_ASSERT(vcpu_wss % host_page_size == 0,
> >                   "Guest memory size is not host page size aligned.");
> > -     host_num_pages = guest_memory_bytes / host_page_size;
> > +     host_num_pages = vcpu_wss / host_page_size;
> >
> >       guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
> >                             guest_page_size;
> > @@ -354,10 +366,12 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
> >       /* Export the shared variables to the guest */
> >       sync_global_to_guest(vm, host_page_size);
> >       sync_global_to_guest(vm, guest_page_size);
> > -     sync_global_to_guest(vm, guest_test_virt_mem);
> > -     sync_global_to_guest(vm, guest_num_pages);
> >
> > -     pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
> > +     vcpu_args.vm = vm;
> > +     vcpu_args.vcpu_id = VCPU_ID;
> > +     vcpu_args.gva = guest_test_virt_mem;
> > +     vcpu_args.pages = guest_num_pages;
> > +     pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
> >
> >       /* Wait for the vcpu thread to quit */
> >       pthread_join(vcpu_thread, NULL);
> > @@ -404,8 +418,7 @@ static void help(char *name)
> >       printf(" -d: add a delay in usec to the User Fault\n"
> >              "     FD handler to simulate demand paging\n"
> >              "     overheads. Ignored without -u.\n");
> > -     printf(" -b: specify the number of bytes of memory which should be\n"
> > -            "     allocated to the guest.\n");
> > +     printf(" -b: specify the working set size, in bytes for each vCPU.\n");
> >       puts("");
> >       exit(0);
> >  }
> > @@ -413,7 +426,7 @@ static void help(char *name)
> >  int main(int argc, char *argv[])
> >  {
> >       bool mode_selected = false;
> > -     uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
> > +     uint64_t vcpu_wss = DEFAULT_GUEST_TEST_MEM_SIZE;
> >       unsigned int mode;
> >       int opt, i;
> >       bool use_uffd = false;
> > @@ -448,7 +461,7 @@ int main(int argc, char *argv[])
> >                                   "A negative UFFD delay is not supported.");
> >                       break;
> >               case 'b':
> > -                     guest_memory_bytes = strtoull(optarg, NULL, 0);
> > +                     vcpu_wss = strtoull(optarg, NULL, 0);
> >               case 'h':
> >               default:
> >                       help(argv[0]);
> > @@ -462,7 +475,7 @@ int main(int argc, char *argv[])
> >               TEST_ASSERT(vm_guest_mode_params[i].supported,
> >                           "Guest mode ID %d (%s) not supported.",
> >                           i, vm_guest_mode_string(i));
> > -             run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
> > +             run_test(i, use_uffd, uffd_delay, vcpu_wss);
> >       }
> >
> >       return 0;
> > --
> > 2.24.1.735.g03f4e72817-goog
> >
>
> Thanks,
> drew
>
