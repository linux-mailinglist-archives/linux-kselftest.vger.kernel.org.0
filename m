Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74C3BDD50
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jul 2021 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhGFShh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 14:37:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:26101 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231172AbhGFShh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 14:37:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209130117"
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="209130117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 11:34:56 -0700
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="481695884"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.213.166]) ([10.212.213.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 11:34:55 -0700
Subject: Re: [PATCH 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
To:     Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-5-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
Date:   Tue, 6 Jul 2021 11:34:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705143652.116125-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 7/5/2021 7:36 AM, Jarkko Sakkinen wrote:
> Create a heap for the test enclave, which has the same size as all
> available Enclave Page Cache (EPC) pages in the system. This will guarantee
> that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
> have been swapped out by the page reclaimer during the load time. Actually,
> this adds a bit more stress than that since part of the EPC gets reserved
> for the Version Array (VA) pages.
> 
> For each test, the page fault handler gets triggered in two occasions:
> 
> - When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
>    page fault handler.
> - During the execution, each page that is referenced gets swapped in
>    by the page fault handler.
> 

If I understand this correctly, all EPC pages are now being consumed 
during fixture setup and thus every SGX test, no matter how big or 
small, now becomes a stress test of the reclaimer instead of there being 
a unique reclaimer test. Since an enclave is set up and torn down for 
every test this seems like a significant addition. It also seems like 
this would impact future tests of dynamic page addition where not all 
scenarios could be tested with all EPC pages already consumed.

Reinette
