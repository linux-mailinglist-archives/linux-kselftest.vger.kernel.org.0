Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEC383AAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 May 2021 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhEQRFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 13:05:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:8432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235813AbhEQRFM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 13:05:12 -0400
IronPort-SDR: /oJOvQ9XCriDmNMLEVFfeRxf1ti3kT8zrJ8iSoK4pew8kW12/PS6bC5bv15AtbYa2CT4ee7J1D
 NNFFLOpGzrNw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187635255"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="187635255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 10:03:54 -0700
IronPort-SDR: WOgV2X3XYklRo+6PFaegK7WvezVNrOV2fcMOrKVLIRKwYQ2uwaNhlVfa05faVvCFxGA2htG4ZJ
 nXGMbkjLzxUA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="472491460"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.243.177]) ([10.212.243.177])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 10:03:54 -0700
Subject: Re: [PATCH v5 2/2] selftests/sgx: Migrate to kselftest harness
To:     Jarkko Sakkinen <jarkko@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210512215323.420639-1-jarkko@kernel.org>
 <20210512215323.420639-2-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3b920525-694c-a8e4-93f5-7b1a3f9ad009@intel.com>
Date:   Mon, 17 May 2021 10:03:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512215323.420639-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 5/12/2021 2:53 PM, Jarkko Sakkinen wrote:
> Migrate to kselftest harness. Use a fixture test with enclave initialized
> and de-initialized for each of the existing three tests, in other words:
> 
> 1. One FIXTURE() for managing the enclave life-cycle.
> 2. Three TEST_F()'s, one for each test case.
> 
> This gives a leaps better reporting than before. Here's an example
> transcript:
> 
> TAP version 13
> 1..3
> 
> ok 1 enclave.unclobbered_vdso
> 
> ok 2 enclave.clobbered_vdso
> 
> ok 3 enclave.clobbered_vdso_and_user_function
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> 
> v5:
> * Use TH_LOG() for printing enclave address ranges instead of printf(),
>    based on Reinette's remark.

Thank you for considering my feedback. The motivation for my comment was 
to consider how this test output will be parsed. If these tests will 
have their output parsed by automated systems then it needs to conform 
to the TAP13 format as supported by kselftest.

In your latest version the output printed during a successful test has 
been changed, using TH_LOG() as you noted. From what I can tell this is 
the only output addressed - failing tests continue to print error 
messages (perror, fprintf) without consideration of how they will be 
parsed. My apologies, I am not a kselftest expert to know what the best 
way for this integration is.

Reinette
