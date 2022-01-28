Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C966F4A00D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 20:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350909AbiA1T0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 14:26:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:58952 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbiA1T0a (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 14:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643397990; x=1674933990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fnFScRHDah5tUzKPZOosa/jrI5oCwCiChqlhvAAbzIA=;
  b=lH//e74RF3MXOyxLLc5krg+xJ19tZnrRY6+UF9MS6ptsgq+Tv+Rc5f22
   EyE9WORU38rEn65x+nnthTygV+o2do7jXA93pvEMFl2AWKy0LUMjAKqBC
   fjvU2JXaJbglKVFjFfdX1afL93WP5CyewMvf+vjsF6RscoAtiW/xI5C9X
   xELLWu78ZKifM+VjPnoeYr8rYYKm5QoOcez2yHkLLVrhtZ8HHSaoBZNkW
   EI2BUATQLviu/kVMtDXZnng+o234I2zRA1aniJlh9YUu2VuBPoHyMOS2n
   CH150mYhs39DAQiTfeVq5xr6aBVc0bMdOtUKIj5gGot6aHEle7VlVEsyH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247132474"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="247132474"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:26:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="697193079"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:26:29 -0800
Message-ID: <35d888c6-ffed-fb89-d02d-8c7ef15cd902@intel.com>
Date:   Fri, 28 Jan 2022 11:26:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Subject: Re: [PATCH 1/4] selftests/sgx: Fix segfault upon early test failure
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <3c1d84724ecc7c94131ba1d94dc4c5de5aafc58f.1643393473.git.reinette.chatre@intel.com>
 <df2248d2-eb61-22d6-3a51-d8091f9eaad6@intel.com>
 <8993eb98-ae1a-9af8-353b-e13895f9804b@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <8993eb98-ae1a-9af8-353b-e13895f9804b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 11:22, Reinette Chatre wrote:
>  	if (encl->segment_tbl) {
> +		/*
> +		 * Most segments form part of the enclave binary
> +		 * and have their mappings deleted with earlier
> +		 * munmap() of encl->bin.
> +		 * As a mapping of anonymous memory the heap
> +		 * segment is separate from the enclave
> +		 * binary and needs its mapping deleted separately.
> +		 */
>  		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
>  		munmap(heap_seg->src, heap_seg->size);

I was more wondering why the status of heap_seg->src is tied to
encl->segment_tbl.
