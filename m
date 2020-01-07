Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E161E133361
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAGVS2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 16:18:28 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35312 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgAGVSV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 16:18:21 -0500
Received: by mail-vk1-f193.google.com with SMTP id o187so388503vka.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWHlfsIIqdm4CbdrtbAbeq2yRN1pjIyOoBGlDv3Smng=;
        b=jvwFbmReRt9SroYc8ybUNmLn1tiPYK6p8ILrC7V9oODm6acKcSC0C5Z8srJwQzhEky
         mK9jaymqbeaX8fnhrt09ztan8PSQq6YqcFBdPcbK4IN+2+f9zMXdtieX3/PL5TN4ul+E
         3PNCrM9CpCXg8SplB7jDlsZzz42uDf4zq2EsO9Z7NsGjZEkZn0FawYvjONzy/AVNfqoF
         HEeV4oUbrc4kC1PgQ0mkJS53oPISOckpJv5VRNmxgSFZUsXnwulO9dFrFATaYD8Vawi1
         6tIjCJa4UGyZFPHI9PjWHvd6UTWXCXwNmKYZ71udv3gZzFJ2eEOpRdzT3vETXRFDwKcn
         3NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWHlfsIIqdm4CbdrtbAbeq2yRN1pjIyOoBGlDv3Smng=;
        b=r5pMMA5UaN2qO3GRA+6Xqv3XNFrQ+vNgyYTvtH98/PXH7EA6vyQpSlU/6cDfQ8GYZV
         sbH4xzUYbV5YPbDrj7FWjLYallkR2bFI6T16opuo/YvfTcmfMxoGP1eGBKWOVG2CbhdE
         /54Cm0W3yMJxeSFQTU44L/TqDs1l7RMUHTp3SXd/C4z1jhEyKsoW51fAwRKmSqd84zG8
         xQ61uoZdV50/5p9Vmb6rF8Z5c+wfjjkLRAejNM1JhdfwueZHgBilZTt6jyNhyGxa3MHd
         qIyeVI537/Qt1mQBQBd7SN9y+Ue/uu2Oz2ePHxFAXUJ4+35mk/pGTKGR3HxnDLC3EYF7
         Nw+g==
X-Gm-Message-State: APjAAAWXZ4Mei+8R9dx7JcOS0r+KH+U0nL1zQkRGM2u7vqGhA8LKHbMe
        OSx2BxR4BRHITeaStQwARV5nICCEJQczCpYVwUksDw==
X-Google-Smtp-Source: APXvYqxumwkbw/b3bQhS1QzSVsUSdF39aqCErT/H6DqIdEW/GJF4vkawveLg6w1NU6pRre6WHkV6HbdXHk9+c9kEkTU=
X-Received: by 2002:a1f:1fd1:: with SMTP id f200mr957892vkf.21.1578431899872;
 Tue, 07 Jan 2020 13:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com> <20191216213901.106941-5-bgardon@google.com>
 <20200107150245.cblsqirr5mu4fqoo@kamzik.brq.redhat.com>
In-Reply-To: <20200107150245.cblsqirr5mu4fqoo@kamzik.brq.redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 7 Jan 2020 13:18:08 -0800
Message-ID: <CANgfPd-CiO-HmY0Hit4101EQR8YMqAPUe80n-g6EjQys7x69Gw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] KVM: selftests: Add memory size parameter to the
 demand paging test
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

On Tue, Jan 7, 2020 at 7:02 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Dec 16, 2019 at 01:38:57PM -0800, Ben Gardon wrote:
> > Add an argument to allow the demand paging test to work on larger and
> > smaller guest sizes.
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  .../selftests/kvm/demand_paging_test.c        | 56 ++++++++++++-------
> >  1 file changed, 35 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> > index 11de5b58995fb..4aa90a3fce99c 100644
> > --- a/tools/testing/selftests/kvm/demand_paging_test.c
> > +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> > @@ -32,6 +32,8 @@
> >  /* Default guest test virtual memory offset */
> >  #define DEFAULT_GUEST_TEST_MEM               0xc0000000
> >
> > +#define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
> > +
> >  /*
> >   * Guest/Host shared variables. Ensure addr_gva2hva() and/or
> >   * sync_global_to/from_guest() are used when accessing from
> > @@ -264,11 +266,10 @@ static int setup_demand_paging(struct kvm_vm *vm,
> >       return 0;
> >  }
> >
> > -#define GUEST_MEM_SHIFT 30 /* 1G */
> >  #define PAGE_SHIFT_4K  12
> >
> >  static void run_test(enum vm_guest_mode mode, bool use_uffd,
> > -                  useconds_t uffd_delay)
> > +                  useconds_t uffd_delay, uint64_t guest_memory_bytes)
> >  {
> >       pthread_t vcpu_thread;
> >       pthread_t uffd_handler_thread;
> > @@ -276,33 +277,40 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
> >       int r;
> >
> >       /*
> > -      * We reserve page table for 2 times of extra dirty mem which
> > -      * will definitely cover the original (1G+) test range.  Here
> > -      * we do the calculation with 4K page size which is the
> > -      * smallest so the page number will be enough for all archs
> > -      * (e.g., 64K page size guest will need even less memory for
> > -      * page tables).
> > +      * We reserve page table for twice the ammount of memory we intend
> > +      * to use in the test region for demand paging. Here we do the
> > +      * calculation with 4K page size which is the smallest so the page
> > +      * number will be enough for all archs. (e.g., 64K page size guest
> > +      * will need even less memory for page tables).
> >        */
> >       vm = create_vm(mode, VCPU_ID,
> > -                    2ul << (GUEST_MEM_SHIFT - PAGE_SHIFT_4K),
> > +                    (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
> >                      guest_code);
> >
> >       guest_page_size = vm_get_page_size(vm);
> > -     /*
> > -      * A little more than 1G of guest page sized pages.  Cover the
> > -      * case where the size is not aligned to 64 pages.
> > -      */
> > -     guest_num_pages = (1ul << (GUEST_MEM_SHIFT -
> > -                                vm_get_page_shift(vm))) + 16;
> > +
> > +     TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
> > +                 "Guest memory size is not guest page size aligned.");
> > +
> > +     guest_num_pages = guest_memory_bytes / guest_page_size;
> > +
> >  #ifdef __s390x__
> >       /* Round up to multiple of 1M (segment size) */
> >       guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
> >  #endif
> > +     /*
> > +      * If there should be more memory in the guest test region than there
> > +      * can be pages in the guest, it will definitely cause problems.
> > +      */
> > +     TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
> > +                 "Requested more guest memory than address space allows.\n"
> > +                 "    guest pages: %lx max gfn: %lx\n",
> > +                 guest_num_pages, vm_get_max_gfn(vm));
> >
> >       host_page_size = getpagesize();
> > -     host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
> > -                      !!((guest_num_pages * guest_page_size) %
> > -                         host_page_size);
> > +     TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
> > +                 "Guest memory size is not host page size aligned.");
> > +     host_num_pages = guest_memory_bytes / host_page_size;
> >
> >       guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
> >                             guest_page_size;
> > @@ -381,7 +389,8 @@ static void help(char *name)
> >       int i;
> >
> >       puts("");
> > -     printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n", name);
> > +     printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
> > +            "          [-b bytes test memory]\n", name);
> >       printf(" -m: specify the guest mode ID to test\n"
> >              "     (default: test all supported modes)\n"
> >              "     This option may be used multiple times.\n"
> > @@ -395,6 +404,8 @@ static void help(char *name)
> >       printf(" -d: add a delay in usec to the User Fault\n"
> >              "     FD handler to simulate demand paging\n"
> >              "     overheads. Ignored without -u.\n");
> > +     printf(" -b: specify the number of bytes of memory which should be\n"
> > +            "     allocated to the guest.\n");
>
> Can we input in megabytes instead? And also it might be nice to output the
> default size here.

I added a little function to parse size arguments so users can specify
2M or 7G. I also changed this to print the default value.

>
> >       puts("");
> >       exit(0);
> >  }
> > @@ -402,6 +413,7 @@ static void help(char *name)
> >  int main(int argc, char *argv[])
> >  {
> >       bool mode_selected = false;
> > +     uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
> >       unsigned int mode;
> >       int opt, i;
> >       bool use_uffd = false;
> > @@ -414,7 +426,7 @@ int main(int argc, char *argv[])
> >       vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
> >  #endif
> >
> > -     while ((opt = getopt(argc, argv, "hm:ud:")) != -1) {
> > +     while ((opt = getopt(argc, argv, "hm:ud:b:")) != -1) {
> >               switch (opt) {
> >               case 'm':
> >                       if (!mode_selected) {
> > @@ -435,6 +447,8 @@ int main(int argc, char *argv[])
> >                       TEST_ASSERT(uffd_delay >= 0,
> >                                   "A negative UFFD delay is not supported.");
> >                       break;
> > +             case 'b':
> > +                     guest_memory_bytes = strtoull(optarg, NULL, 0);
>
> Missing break. So it doesn't look like this was tested.

Woops, you're right, I must not have tested this commit. The break is
added in commit 6/8 and I only tested at the end of the series.
I'll have the break in this commit in the next version of this series.

>
> >               case 'h':
> >               default:
> >                       help(argv[0]);
> > @@ -448,7 +462,7 @@ int main(int argc, char *argv[])
> >               TEST_ASSERT(vm_guest_mode_params[i].supported,
> >                           "Guest mode ID %d (%s) not supported.",
> >                           i, vm_guest_mode_string(i));
> > -             run_test(i, use_uffd, uffd_delay);
> > +             run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
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
