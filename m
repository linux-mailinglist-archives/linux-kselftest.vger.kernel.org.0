Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC117DD10
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2019 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfHAN6j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Aug 2019 09:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfHAN6j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Aug 2019 09:58:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C328C20838;
        Thu,  1 Aug 2019 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564667918;
        bh=sloo8NtsVS8tKYY6BZDzoeCr41LlzdgRSZc+mtHfZqM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aiAh4ZaNRKuR+YTlJNoGYmB3DQEqWi8LUFgBASJ4/TSRxK5u9OHFop1ePHoeVTcre
         YTl+57EfnvFJAgwfUr+1ziMxe8Z21ewdGlK22aYoqPDp7xYXT4kPd4PUH4M6rIl37v
         4JyPDc7mk/v7yEYjpEapUH9kIeknC2Cabz7r4XxY=
Subject: Re: [PATCH] KVM: selftests: Update gitignore file for latest changes
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190731142851.9793-1-thuth@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <20c43c74-09f9-8f0b-64e4-a481a40387cb@kernel.org>
Date:   Thu, 1 Aug 2019 07:58:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731142851.9793-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/31/19 8:28 AM, Thomas Huth wrote:
> The kvm_create_max_vcpus test has been moved to the main directory,
> and sync_regs_test is now available on s390x, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tools/testing/selftests/kvm/.gitignore | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 41266af0d3dc..b35da375530a 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,7 +1,7 @@
> +/s390x/sync_regs_test
>   /x86_64/cr4_cpuid_sync_test
>   /x86_64/evmcs_test
>   /x86_64/hyperv_cpuid
> -/x86_64/kvm_create_max_vcpus
>   /x86_64/mmio_warning_test
>   /x86_64/platform_info_test
>   /x86_64/set_sregs_test
> @@ -13,3 +13,4 @@
>   /x86_64/vmx_tsc_adjust_test
>   /clear_dirty_log_test
>   /dirty_log_test
> +/kvm_create_max_vcpus
> 

Hi Paolo,

Let me know if you need me to take any of these patches. In any
case:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
