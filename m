Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76814A08D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 10:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgA0JSY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 04:18:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgA0JSY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 04:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580116703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=SjQY1L2fP4IHF3cwKrrTmP56dRMYwDzmyVOLtNg1Xnk=;
        b=YLgySwWprN36Roet6nZhAHQVXWaObMxy4AkiQQmdP++NW05ssEXhD2hV8mKu5wjf0A6VNa
        d+SDAaRsRqjx7S91yRZhpkz/bGiZx9ASwsdTgMWPqsHRiz4KDnqHQ7+cGq0myesYh10/4l
        cyO+uOyczxz4XiAhZVn/LGymp6guDms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-nSXuy8P3Pyi4ku4_4B1-Bg-1; Mon, 27 Jan 2020 04:18:22 -0500
X-MC-Unique: nSXuy8P3Pyi4ku4_4B1-Bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C6571084437;
        Mon, 27 Jan 2020 09:18:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C91A88888B;
        Mon, 27 Jan 2020 09:18:12 +0000 (UTC)
Subject: Re: [PATCH v4 01/10] KVM: selftests: Create a demand paging test
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-2-bgardon@google.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2655bc5d-eac1-7cbe-d3b2-5dc9ad3ffa5e@redhat.com>
Date:   Mon, 27 Jan 2020 10:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123180436.99487-2-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/2020 19.04, Ben Gardon wrote:
> While userfaultfd, KVM's demand paging implementation, is not specific
> to KVM, having a benchmark for its performance will be useful for
> guiding performance improvements to KVM. As a first step towards creating
> a userfaultfd demand paging test, create a simple memory access test,
> based on dirty_log_test.
> 
> Reviewed-by: Oliver Upton <oupton@google.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   3 +
>  .../selftests/kvm/demand_paging_test.c        | 286 ++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/demand_paging_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 30072c3f52fbe..9619d96e15c41 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -17,3 +17,4 @@
>  /clear_dirty_log_test
>  /dirty_log_test
>  /kvm_create_max_vcpus
> +/demand_paging_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 3138a916574a9..e2e1b92faee3b 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -28,15 +28,18 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
>  TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_test
> +TEST_GEN_PROGS_x86_64 += demand_paging_test
>  TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
>  
>  TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
>  TEST_GEN_PROGS_aarch64 += dirty_log_test
> +TEST_GEN_PROGS_aarch64 += demand_paging_test
>  TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>  
>  TEST_GEN_PROGS_s390x = s390x/memop
>  TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>  TEST_GEN_PROGS_s390x += dirty_log_test
> +TEST_GEN_PROGS_s390x += demand_paging_test
>  TEST_GEN_PROGS_s390x += kvm_create_max_vcpus

I gave your series a quick try on s390x (without patch 10/10 since that
is causing more trouble), but the test does not work there yet:

# selftests: kvm: demand_paging_test
# ==== Test Assertion Failure ====
#   lib/kvm_util.c:700: ret == 0
#   pid=247240 tid=247240 - Invalid argument
#      1	0x0000000001004085: vm_userspace_mem_region_add at kvm_util.c:695
#      2	0x00000000010042dd: _vm_create at kvm_util.c:233
#      3	0x0000000001001b07: create_vm at demand_paging_test.c:185
#      4	 (inlined by) run_test at demand_paging_test.c:387
#      5	 (inlined by) main at demand_paging_test.c:676
#      6	0x000003ffb5323461: ?? ??:0
#      7	0x000000000100259d: .annobin_init.c.hot at crt1.o:?
#      8	0xffffffffffffffff: ?? ??:0
#   KVM_SET_USER_MEMORY_REGION IOCTL failed,
#   rc: -1 errno: 22
#   slot: 0 flags: 0x0
#   guest_phys_addr: 0x0 size: 0x607000
# Testing guest mode: PA-bits:40,  VA-bits:48,  4K pages
not ok 4 selftests: kvm: demand_paging_test # exit=254

I'd suggest to leave it disabled on s390x until the issue has been debugged.

 Thomas

