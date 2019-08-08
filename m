Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB3867DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2019 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404079AbfHHRWt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 13:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHRWt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 13:22:49 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2AC217F4;
        Thu,  8 Aug 2019 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565284968;
        bh=goDYQLYWzyP/I29xI6KE9eIk6wrBfRZGKb9lERIu32E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ua1MGXeQgpUilKwU9Lv6sFBtO5Ne3BfYuhBuC2bI/xL1c/K6rZ+GE5kbSBIAM9H73
         2xuxIpKlQbsYUjWDPlQp6YqlPF4drvL4x1jkHEm+EhI1QRTuRhSdKoUqsEKHEv8bgP
         aRFjcz2gknk+f1DC/RQI4SFJKyW1uuQr+QciRObU=
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190808123140.25583-1-naresh.kamboju@linaro.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5a06389b-5996-b11d-1435-8f4667c1dc4b@kernel.org>
Date:   Thu, 8 Aug 2019 11:22:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808123140.25583-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/19 6:31 AM, Naresh Kamboju wrote:
> selftests kvm all test cases need pre-required kernel configs for the
> tests to get pass.
> 
> The KVM tests are skipped without these configs:
> 
>          dev_fd = open(KVM_DEV_PATH, O_RDONLY);
>          if (dev_fd < 0)
>                  exit(KSFT_SKIP);
> 

Thanks.

> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> ---
>   tools/testing/selftests/kvm/config | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/config
> 
> diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
> new file mode 100644
> index 000000000000..63ed533f73d6
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/config
> @@ -0,0 +1,3 @@
> +CONFIG_KVM=y
> +CONFIG_KVM_INTEL=y
> +CONFIG_KVM_AMD=y
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

