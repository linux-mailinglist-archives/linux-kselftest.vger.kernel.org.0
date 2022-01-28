Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3884A0099
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 20:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiA1TDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 14:03:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:60998 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233548AbiA1TDz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 14:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643396635; x=1674932635;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0O6N4dHY8ZrXm7VcvIBy9JE6w7mV4wWWQ8ji21LAko8=;
  b=EtBdjjO3OIDPM2zkP8GF+EAysvuwIQVCyUtB/yd2yMNV3l1KROl+qFXT
   ocd4XiBBsG+Pfh2xA2imNG6JQzVeF6ahnhDgKQ9wwj2e/cNvLN1IKIQHd
   RpeD5HslG+foDt/10+2rH7mJUw5XbsK57cE+tv25Ht3o+tiy6atTjkrVx
   hGUJ63+YZsagkr1lTKnwHG5JLj6oIDXsfDbM9ZhWTc+I6i6hUBrmFkBYI
   KyWdfcdz5ExPFeKo6+RSnsw3hiB87L0dxH6QHSU5rFii1m/u18lhIr8DI
   JJ4TEeqYIHNoJ9VGB1WpvPBaG0dP2Ic8iaO/9Hf76w7Cus4SWZYKxSUAB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="230755964"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="230755964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:03:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="697187198"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:03:53 -0800
Message-ID: <920a4095-f405-fb39-78d5-cd0ec2ae6484@intel.com>
Date:   Fri, 28 Jan 2022 11:03:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <f2b46fd652450d9361577e63a8d4b0b85190c4a2.1643393473.git.reinette.chatre@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/4] selftests/sgx: Do not attempt enclave build without
 valid enclave
In-Reply-To: <f2b46fd652450d9361577e63a8d4b0b85190c4a2.1643393473.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 10:23, Reinette Chatre wrote:
> It is not possible to build an enclave if it was not possible to load
> the binary from which it should be constructed. Do not attempt
> to make further progress but instead return with failure.
> 
> Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

>  tools/testing/selftests/sgx/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 370c4995f7c4..a7cd2c3e6f7e 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  	if (!encl_load("test_encl.elf", encl, heap_size)) {
>  		encl_delete(encl);
>  		TH_LOG("Failed to load the test enclave.\n");
> +		return false;
>  	}
>  
>  	if (!encl_measure(encl))

One more sentence to add to the changelog:

	A "return false" from setup_test_encl() is expected to trip an
	ASSERT_TRUE() and abort the rest of the test.

That at least saves a reviewer from needing to check what the callers see.
