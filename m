Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27828568
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfEWR4q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 13:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731116AbfEWR4p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 13:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C9F3307CDF2;
        Thu, 23 May 2019 17:56:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ED9968386;
        Thu, 23 May 2019 17:56:40 +0000 (UTC)
Date:   Thu, 23 May 2019 19:56:38 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 9/9] KVM: selftests: Move kvm_create_max_vcpus test to
 generic code
Message-ID: <20190523175638.5sc5zjbgsqe4bkes@kamzik.brq.redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190523164309.13345-10-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523164309.13345-10-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 23 May 2019 17:56:45 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 06:43:09PM +0200, Thomas Huth wrote:
> There is nothing x86-specific in the test apart from the VM_MODE_P52V48_4K
> which we can now replace with VM_MODE_DEFAULT. Thus let's move the file to
> the main folder and enable it for aarch64 and s390x, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile                          | 4 +++-
>  .../testing/selftests/kvm/{x86_64 => }/kvm_create_max_vcpus.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>  rename tools/testing/selftests/kvm/{x86_64 => }/kvm_create_max_vcpus.c (93%)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index d8beb990c8f4..aef5bd1166cf 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -21,15 +21,17 @@ TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_close_while_nested_test
>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
> -TEST_GEN_PROGS_x86_64 += x86_64/kvm_create_max_vcpus
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
> +TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>  TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
>  
>  TEST_GEN_PROGS_aarch64 += dirty_log_test
>  TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
> +TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>  
>  TEST_GEN_PROGS_s390x += s390x/sync_regs_test
> +TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
>  
>  TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
>  LIBKVM += $(LIBKVM_$(UNAME_M))
> diff --git a/tools/testing/selftests/kvm/x86_64/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> similarity index 93%
> rename from tools/testing/selftests/kvm/x86_64/kvm_create_max_vcpus.c
> rename to tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> index 50e92996f918..db78ce07c416 100644
> --- a/tools/testing/selftests/kvm/x86_64/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * kvm_create_max_vcpus
>   *
> @@ -28,7 +29,7 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
>  	printf("Testing creating %d vCPUs, with IDs %d...%d.\n",
>  	       num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
>  
> -	vm = vm_create(VM_MODE_P52V48_4K, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> +	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
>  
>  	for (i = 0; i < num_vcpus; i++) {
>  		int vcpu_id = first_vcpu_id + i;
> -- 
> 2.21.0
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
