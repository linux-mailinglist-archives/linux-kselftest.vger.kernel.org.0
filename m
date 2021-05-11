Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AF37AE98
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhEKSn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 14:43:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:32595 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKSn7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 14:43:59 -0400
IronPort-SDR: zLRpky9fTDlIZUrkWZBo4I+/vViK8ZXZd9FZyVtAuH+4ElP+jUOeS7mUhanVX10Yckmfqkje2L
 e3vRUgClTbBg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199584267"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="199584267"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:42:50 -0700
IronPort-SDR: SNslpm6H7oY9Yy0CklaU2a5gXmehDeLljBthZO+XRQTzzmy/zNpYvxKwdFJtOB1sKFX2XwphPS
 Sm3Fe1AU2vnw==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="436794266"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.255.230.234]) ([10.255.230.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:42:50 -0700
Subject: Re: [PATCH v4 2/2] selftests/sgx: Migrate to kselftest harness
To:     Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210508035648.18176-1-jarkko@kernel.org>
 <20210508035648.18176-2-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <960f1cd8-d805-8ed8-6af0-eed1f49e3c65@intel.com>
Date:   Tue, 11 May 2021 11:42:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210508035648.18176-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 5/7/2021 8:56 PM, Jarkko Sakkinen wrote:
> Migrate to kselftest harness. Use a fixture test with enclave initialized
> and de-initialized for each of the existing three tests, in other words:
> 
> 1. One FIXTURE() for managing the enclave life-cycle.
> 2. Three TEST_F()'s, one for each test case.

These changes make it easier to add tests and I think it is a valuable 
addition.

> 
> This gives a leaps better reporting than before. Here's an example
> transcript:
> 
> TAP version 13
> 1..3
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> ok 1 enclave.unclobbered_vdso
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> ok 2 enclave.clobbered_vdso
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> ok 3 enclave.clobbered_vdso_and_user_function
> 

The output claims to conform to TAP13 but it does not seem as though all 
of the output conforms to TAP13. I assume such output would confuse 
automated systems.

Reinette
