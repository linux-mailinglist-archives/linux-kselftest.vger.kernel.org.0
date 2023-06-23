Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6073B0A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 08:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFWGUR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 02:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFWGUQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 02:20:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0F189;
        Thu, 22 Jun 2023 23:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687501214; x=1719037214;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2L8LbF2gBGTP8lafaNRC8LtBh5KQEJXn+zvdgG4MunU=;
  b=dkyoEqW8y4h07tqo89FI/wPN3eCjSJO9reR2swVwZ9PA4zY76gBLcQj3
   jtCpuqFYQovjkrtpgteljReUDJ+60t1fihhIJmyuzXDrEjsnd6jEr589Z
   Afnp6dKDi0BObSjIrZZyX0L96jmiUx4QvgTnxXbKFamgpb9GD7kifdv8q
   trffrmzE+4eaMN/RwrZMyNSJLjxCYE1GtVY87iOCuETe/R4tiSlTooZ21
   vAxY1MlWce9rvH0jg85Drmg7FclcpgWi8IzK5HuIWdoDSgi5BncFuknA2
   OPLraqqDOaxpXU4dPQF3YdCkdzJA/REIjnm7+0NNV7jHOGXEnPHtIjL/k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447077709"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="447077709"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 23:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="744885207"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="744885207"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2023 23:19:58 -0700
Message-ID: <a3c15dff-c165-57c7-16f6-072e251a9368@linux.intel.com>
Date:   Fri, 23 Jun 2023 14:18:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHaV3GwYXCvfNUBn@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZHaV3GwYXCvfNUBn@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/31/23 8:33 AM, Jason Gunthorpe wrote:
> On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework. The use case is nested
>> translation, where modern IOMMU hardware supports two-stage translation
>> tables. The second-stage translation table is managed by the host VMM
>> while the first-stage translation table is owned by the user space.
>> Hence, any IO page fault that occurs on the first-stage page table
>> should be delivered to the user space and handled there. The user space
>> should respond the page fault handling result to the device top-down
>> through the IOMMUFD response uAPI.
>>
>> User space indicates its capablity of handling IO page faults by setting
>> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
>> will then setup its infrastructure for page fault delivery. Together
>> with the iopf-capable flag, user space should also provide an eventfd
>> where it will listen on any down-top page fault messages.
>>
>> On a successful return of the allocation of iopf-capable HWPT, a fault
>> fd will be returned. User space can open and read fault messages from it
>> once the eventfd is signaled.
> This is a performance path so we really need to think about this more,
> polling on an eventfd and then reading a different fd is not a good
> design.
> 
> What I would like is to have a design from the start that fits into
> io_uring, so we can have pre-posted 'recvs' in io_uring that just get
> completed at high speed when PRIs come in.
> 
> This suggests that the PRI should be delivered via read() on a single
> FD and pollability on the single FD without any eventfd.

I will remove the eventfd and provide a single FD for both read() and
write(). The userspace reads the FD to retrieve the fault messages while
writing the FD to respond the handling of the faults. The user space
could leverage the io_uring for asynchronous I/O. A sample userspace
design could look like this:

[pseudo code for discussion only]

	struct io_uring ring;

	io_uring_setup(IOPF_ENTRIES, &ring);

	while (1) {
		struct io_uring_prep_read read;
		struct io_uring_cqe *cqe;

		read.fd = iopf_fd;
		read.buf = malloc(IOPF_SIZE);
		read.len = IOPF_SIZE;
		read.flags = 0;

		io_uring_prep_read(&ring, &read);
		io_uring_submit(&ring);

		// Wait for the read to complete
		while ((cqe = io_uring_get_cqe(&ring)) != NULL) {
			// Check if the read completed
			if (cqe->res < 0)
				break;

			if (page_fault_read_completion(cqe)) {
				// Get the fault data
				void *data = cqe->buf;
				size_t size = cqe->res;

				// Handle the page fault
				handle_page_fault(data);

				// Respond the fault
				struct io_uring_prep_write write;
				write.fd = iopf_fd;
				write.buf = malloc(IOPF_RESPONSE_SIZE);
				write.len = IOPF_RESPONSE_SIZE;
				write.flags = 0;

				io_uring_prep_write(&ring, &write);
             			io_uring_submit(&ring);
			}

			// Reap the cqe
			io_uring_cqe_free(&ring, cqe);
		}
	}

Did I understand you correctly?

Best regards,
baolu
