Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18E63AF730
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhFUVK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 17:10:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:56921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhFUVK2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 17:10:28 -0400
IronPort-SDR: WuhYj42CvR6r6tHcKr6HRF3sFsSALUoS8f8nrZnRxquolAQVHVhX7Uvf/ukjw63NzwhkDVYWE6
 1ojXFWVfL+8A==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="268071701"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="268071701"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 14:08:12 -0700
IronPort-SDR: gv+kbT/6xrIRu6Aj0NTA+IYfXiwZkvL1IxfnNUMdZmsBNVlBju5yeQfdOUZXXkWL+5eaZp8tYs
 KnFhUKR1xQjg==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="473545889"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.236.132]) ([10.212.236.132])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 14:08:11 -0700
Subject: Re: [PATCH] selftests/sgx: remove checks for file execute permissions
To:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, tim.gardner@canonical.com,
        jarkko@kernel.org, shuah@kernel.org, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20210621190556.4B5DCBB1@viggo.jf.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <121f7215-f11d-2533-b736-9f18516c3220@intel.com>
Date:   Mon, 21 Jun 2021 14:08:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621190556.4B5DCBB1@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 6/21/2021 12:05 PM, Dave Hansen wrote:
> 
> The SGX selftests can fail for a bunch of non-obvious reasons
> like 'noexec' permissions on /dev (which is the default *EVERYWHERE*
> it seems).
> 
> A new test mistakenly also looked for +x permission on the
> /dev/sgx_enclave.  File execute permissions really only apply to
> the ability of execve() to work on a file, *NOT* on the ability
> for an application to map the file with PROT_EXEC.  SGX needs to
> mmap(PROT_EXEC), but doesn't need to execve() the device file.
> 
> Remove the check.
> 
> Fixes: 4284f7acb78b ("selftests/sgx: Improve error detection and messages")
> Reported-by: Tim Gardner <tim.gardner@canonical.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-sgx@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 

Thank you very much for fixing this. With this applied the SGX tests are 
able to run again on my system.

Tested-by: Reinette Chatre <reinette.chatre@intel.com>

I think it is missing a "Signed-off-by".

Reinette
