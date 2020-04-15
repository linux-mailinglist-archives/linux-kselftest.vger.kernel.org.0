Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE711AB483
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Apr 2020 01:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgDOX6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 19:58:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38730 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgDOX6F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 19:58:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FNw0WG140765;
        Wed, 15 Apr 2020 23:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/HuKgOISMSSp6FBWgYwKINeJR9xqAL62CULDfVaFD3I=;
 b=fcE3AmoUb0jaz3u9ndxLpBS0WrNUOFP1xptbDrxiagOI4FwtVZqIR0HzxXGaFtvVA+A8
 0tzDj1+BFmwoGYfl6mBHe8sitMn3SIrVU04AICXw2bAOzmeqVSvudJ9LsqzVUbdnq5sn
 IoctUtBFccXm0R84w8jbJ/wIw9H4CCS0dzM3cqjdQkKuadLF8C4z1KHuvWn+DK5iNSoG
 xQFuVBHubczhVtMUMZvOqfSSeRa6VtfxDIBKBG7CHMfzERDsvk5l227+dbeM+SbNEZVd
 7BaWntTg1GFqYJaxvAY+6Y3k09fRFnPbsRqBzA1LUBfxUe6dga48WuWdebzqLjH3jwhy XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30e0bfbxnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 23:58:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FNvCf3101163;
        Wed, 15 Apr 2020 23:57:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30dn8x8cnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 23:57:59 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03FNvvwL028653;
        Wed, 15 Apr 2020 23:57:57 GMT
Received: from localhost.localdomain (/10.159.130.134)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 16:57:57 -0700
Subject: Re: [PATCH 1/1] selftests: kvm: Add overlapped memory regions test
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, sean.j.christopherson@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200415204505.10021-1-wainersm@redhat.com>
 <20200415204505.10021-2-wainersm@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <455a01b6-506b-3c16-7ad8-327ad63292e9@oracle.com>
Date:   Wed, 15 Apr 2020 16:57:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204505.10021-2-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=2 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150180
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/15/20 1:45 PM, Wainer dos Santos Moschetta wrote:
> Add the test_overlap_memory_regions() test case in
> set_memory_region_test. This should check that overlapping
> memory regions on the guest physical address cannot be added.


I think the commit header and the body need some improvement. For example,

         Header: Test that overlapping guest memory regions can not be added

         Body:  Enhance the existing tests in set_memory_region_test.c 
so that it tests overlapping guest

                     memory regions. The new test verifies that adding 
overlapping guest memory regions fails.

>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   .../selftests/kvm/set_memory_region_test.c    | 75 ++++++++++++++++++-
>   1 file changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 260e638826dc..74a987002273 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -331,6 +331,8 @@ static void test_add_max_memory_regions(void)
>   	uint64_t mem_reg_npages;
>   	void *mem;
>   
> +	pr_info("Testing KVM_CAP_NR_MEMSLOTS memory regions can be added\n");
> +
>   	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
>   	TEST_ASSERT(max_mem_slots > 0,
>   		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
> @@ -338,7 +340,8 @@ static void test_add_max_memory_regions(void)
>   
>   	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
>   
> -	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, MEM_REGION_SIZE);
> +	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT,
> +						 MEM_REGION_SIZE);
>   
>   	/* Check it can be added memory slots up to the maximum allowed */
>   	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
> @@ -365,6 +368,75 @@ static void test_add_max_memory_regions(void)
>   	kvm_vm_free(vm);
>   }
>   
> +/*
> + * Test it cannot add memory slots with overlapped regions.


     "Test that we can not add memory slots with overlapping regions."

> + *
> + * The following cases are covered:
> + *
> + *             0x100000 0x300000
> + *       0x0       0x200000  0x400000
> + * slot0 |         |---2MB--|           (SUCCESS)
> + * slot1       |---2MB--|               (FAIL)
> + * slot2 |---2MB--|                     (SUCCESS)
> + * slot3           |---2MB--|           (FAIL)
> + * slot4                |---2MB--|      (FAIL)
> + * slot5                     |---2MB--| (SUCCESS)
> + */
> +void test_overlap_memory_regions(void)
> +{
> +	int i;
> +	int ret;
> +	int vm_fd;
> +	struct kvm_userspace_memory_region kvm_region;
> +	struct kvm_vm *vm;
> +	struct slot_t {
> +		uint64_t guest_addr;
> +		int exp_ret; /* Expected ioctl return value */
> +	};
> +	struct slot_t slots[] = {{0x200000,  0}, {0x100000, -1}, {0x000000,  0},
> +				 {0x200000, -1}, {0x300000, -1}, {0x400000,  0}
> +				};
> +	uint64_t mem_reg_npages;
> +	void *mem;
> +
> +	pr_info("Testing KVM_SET_USER_MEMORY_REGION with overlapped memory regions\n");
> +
> +	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
> +	vm_fd = vm_get_fd(vm);
> +
> +	pr_info("Working with memory region of %iMB\n", MEM_REGION_SIZE >> 20);
> +	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT,
> +						 MEM_REGION_SIZE);
> +
> +	mem = mmap(NULL, MEM_REGION_SIZE, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");


I think a better message would be:  "mmap() failure in host".

> +
> +	kvm_region.flags = 0;
> +	kvm_region.memory_size = MEM_REGION_SIZE;
> +	kvm_region.userspace_addr = (uint64_t) mem;
> +
> +	for (i = 0; i < sizeof(slots)/sizeof(struct slot_t); i++) {
> +		pr_info("Add slot %i, guest address 0x%06lx, expect rc=%i\n",
> +			i, slots[i].guest_addr, slots[i].exp_ret);
> +		if (slots[i].exp_ret == 0) {
> +			vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +						    slots[i].guest_addr, i,
> +						    mem_reg_npages, 0);
> +		} else {
> +			kvm_region.slot = i;
> +			kvm_region.guest_phys_addr = slots[i].guest_addr;
> +			ret = ioctl(vm_fd, KVM_SET_USER_MEMORY_REGION,
> +				    &kvm_region);
> +			TEST_ASSERT(ret == -1 && errno == EEXIST,
> +				    "Adding overlapped memory region should fail with EEXIT");
> +		}
> +	}
> +
> +	munmap(mem, MEM_REGION_SIZE);
> +	kvm_vm_free(vm);
> +}
> +
>   int main(int argc, char *argv[])
>   {
>   #ifdef __x86_64__
> @@ -383,6 +455,7 @@ int main(int argc, char *argv[])
>   #endif
>   
>   	test_add_max_memory_regions();
> +	test_overlap_memory_regions();
>   
>   #ifdef __x86_64__
>   	if (argc > 1)

Other than the comments above,

     Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

