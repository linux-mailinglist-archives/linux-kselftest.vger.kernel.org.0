Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3531639E437
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jun 2021 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFGQhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 12:37:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:36380 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhFGQhR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 12:37:17 -0400
IronPort-SDR: MpFVcGBs585a0sMDz9G67pKbeZQaLcYDy+Knt4b9q2sR8F+mw0K07cFPWvo4zz/6EOGWu0I9Qt
 CUmTWoBbX3Ew==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201636687"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="201636687"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:35:26 -0700
IronPort-SDR: gGHkq0JA9XxW08rmIHn0Yozoin8bhHh51CRsA+vUv/Gtkpqib6IDZfyfn/QmddtWIFah/Ie8xS
 krPnFy0JLezg==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="637329904"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.69.116]) ([10.209.69.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:35:26 -0700
Subject: Re: [PATCH v7 2/4] selftests/sgx: Migrate to kselftest harness
To:     Jarkko Sakkinen <jarkko@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210526124740.16783-1-jarkko@kernel.org>
 <20210526124740.16783-2-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <da0c7ded-3fec-9b30-8955-7a2525dc1f22@intel.com>
Date:   Mon, 7 Jun 2021 09:35:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210526124740.16783-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 5/26/2021 5:47 AM, Jarkko Sakkinen wrote:

...

> -	exit(KSFT_PASS);
> +static inline int encl_call(const void *in, void *out, struct sgx_enclave_run *run, bool clobbered)
> +{
> +	void *in2 = (void *)in;
> +	int ret;
>   
> -err:
> -	encl_delete(&encl);
> -	exit(KSFT_FAIL);
> +	if (clobbered)
> +		ret = vdso_sgx_enter_enclave((unsigned long)in2, (unsigned long)out, 0,
> +					     EENTER, 0, 0, run);
> +	else
> +		ret = sgx_enter_enclave(in2, out, 0, EENTER, NULL, NULL, run);
> +
> +	return ret;
> +}

I find this change unnecessary because it is very specific to the 
current test cases and limiting future test cases. From what I 
understand it attempts to create a generic "call into the enclave" 
wrapper but in doing so it constrains the call to use only two 
registers, assuming there will always and only be just an "in" and "out" 
parameter needed.

Reinette
