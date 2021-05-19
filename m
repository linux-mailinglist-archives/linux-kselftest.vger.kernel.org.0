Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25B3898E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 23:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhESVyj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhESVyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 17:54:39 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69829C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:53:17 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j30so13492952ila.5
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHKLEyIhofUJ9O3L6wRXKwbLS4Rc68P4WfTPWjMjPlE=;
        b=YdhjX1Bx6Wds8k+sGHxeLk5XXdy9lQknlHF5nJ+CZtZ7/QiKRI0LuL4KWEUGxY9pZU
         YJ6DXWcWfevNK/4Xvz06EFTSmMeSCcCmAuJlGqGvK016b/Tap+LIuxYMHLyBUaXTu25T
         1NPVQ2oyI303T5RIXMqvJLy+5QmFr7xmC7Jtld9c9cDYhnhKCxeJde4TSf5HOYgXwc1Q
         +Dgfto6/H0ka/uuKmsIlcDjSJrvZqbKQjYF8JLLftlqbFAcfxQPuRC3R9zFmZd7icWmp
         wyc8Fj4lqPcTxmrEW7UrPVa36TP3hwCnbf/VtzAmZoW9b2h3ITJAPJPekIXWzBRBzSuS
         sp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHKLEyIhofUJ9O3L6wRXKwbLS4Rc68P4WfTPWjMjPlE=;
        b=Zj5PdmA+GaiaD7beZ32PgjBkClrGtUJhsqymK4v1OxgAxjEprpndPMas9BtW9qVut6
         xQ98gRRNJDiKglIcHeih/fQylV5zOzQaCX9U+iJSyp664udtPF2JkolohKP5zqdAoVsM
         jHRWbsZaluF+u13ix4rCRuQGWm+5IX/5FrO48BlGn0dXJjQ+7JgtSNOAobxoYP0Sm5w6
         Urw9CGVmdSMkGfqjIgaEuCkItw2tRZ1wJ9QYvtNJPbJTgmd7wMqzqLToYZ/BIBupWc3D
         1WjdSGruitO4ii50KGvfVL7UsFYp7xLOmo8XwiDw3auvDpXg/WcGPv+rb36p8ve/UCjr
         pWwg==
X-Gm-Message-State: AOAM530IwwSz9B1fs0xwTugY9bwjOaLv8X816953lEFM9PmQySpMaZ6z
        eKvndzHqChBhZf1FjxEeKTGuGvL4s7cdTHa62mnfzQ==
X-Google-Smtp-Source: ABdhPJyqvn00++/Enjz0iknPn/khIgX0sjeuE6FEcTFhA4v0lx82z3Q5R4bucC9JlNrOHhGRcMkhe9/xXwzgl0hTtoo=
X-Received: by 2002:a92:c5ac:: with SMTP id r12mr1160400ilt.283.1621461196624;
 Wed, 19 May 2021 14:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com> <20210519200339.829146-6-axelrasmussen@google.com>
In-Reply-To: <20210519200339.829146-6-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 14:53:06 -0700
Message-ID: <CANgfPd9K88ddOzUuVSCw007N_7=2-7QMB-wc2BHPKnzdYe5Cnw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] KVM: selftests: allow different backing source types
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 19, 2021 at 1:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> Add an argument which lets us specify a different backing memory type
> for the test. The default is just to use anonymous, matching existing
> behavior.
>
> This is in preparation for testing UFFD minor faults. For that, we'll
> need to use a new backing memory type which is setup with MAP_SHARED.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/demand_paging_test.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 94cf047358d5..01890a7b0155 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -241,6 +241,7 @@ static void setup_demand_paging(struct kvm_vm *vm,
>  struct test_params {
>         bool use_uffd;
>         useconds_t uffd_delay;
> +       enum vm_mem_backing_src_type src_type;
>         bool partition_vcpu_memory_access;
>  };
>
> @@ -258,11 +259,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         int r;
>
>         vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
> -                                VM_MEM_SRC_ANONYMOUS);
> +                                p->src_type);
>
>         perf_test_args.wr_fract = 1;
>
> -       demand_paging_size = get_backing_src_pagesz(VM_MEM_SRC_ANONYMOUS);
> +       demand_paging_size = get_backing_src_pagesz(p->src_type);
>
>         guest_data_prototype = malloc(demand_paging_size);
>         TEST_ASSERT(guest_data_prototype,
> @@ -378,7 +379,7 @@ static void help(char *name)
>  {
>         puts("");
>         printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
> -              "          [-b memory] [-v vcpus] [-o]\n", name);
> +              "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
>         guest_modes_help();
>         printf(" -u: use User Fault FD to handle vCPU page\n"
>                "     faults.\n");
> @@ -388,6 +389,8 @@ static void help(char *name)
>         printf(" -b: specify the size of the memory region which should be\n"
>                "     demand paged by each vCPU. e.g. 10M or 3G.\n"
>                "     Default: 1G\n");
> +       printf(" -t: The type of backing memory to use. Default: anonymous\n");
> +       backing_src_help();
>         printf(" -v: specify the number of vCPUs to run.\n");
>         printf(" -o: Overlap guest memory accesses instead of partitioning\n"
>                "     them into a separate region of memory for each vCPU.\n");
> @@ -399,13 +402,14 @@ int main(int argc, char *argv[])
>  {
>         int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
>         struct test_params p = {
> +               .src_type = VM_MEM_SRC_ANONYMOUS,
>                 .partition_vcpu_memory_access = true,
>         };
>         int opt;
>
>         guest_modes_append_default();
>
> -       while ((opt = getopt(argc, argv, "hm:ud:b:v:o")) != -1) {
> +       while ((opt = getopt(argc, argv, "hm:ud:b:t:v:o")) != -1) {
>                 switch (opt) {
>                 case 'm':
>                         guest_modes_cmdline(optarg);
> @@ -420,6 +424,9 @@ int main(int argc, char *argv[])
>                 case 'b':
>                         guest_percpu_mem_size = parse_size(optarg);
>                         break;
> +               case 't':
> +                       p.src_type = parse_backing_src_type(optarg);
> +                       break;
>                 case 'v':
>                         nr_vcpus = atoi(optarg);
>                         TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
> --
> 2.31.1.751.gd2f1c929bd-goog
>
