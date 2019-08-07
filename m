Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACFA8504F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2019 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbfHGPwk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Aug 2019 11:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388779AbfHGPwk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Aug 2019 11:52:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6421F21E73;
        Wed,  7 Aug 2019 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565193160;
        bh=t56h21KNASqJFrwBf8iDFQutW8Xbq368HNoCUfPaANw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=LkdVjXB2jDNMFwA/lkPddhSh8C/yg3ibIcujkqsbH+3FJ86d7KtaM0IPpKnaVIJBR
         1zhaF4EPIFntFV2NxHJs7RpQ+JDSyu84jla6yPYqKWMlU0EuqJxCVGt61UkOXrCjqE
         Y/U+EdOLVJ3DYcFE5Vf5cX878Vt9s5GCziIkRlfY=
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190807135814.12906-1-naresh.kamboju@linaro.org>
From:   shuah <shuah@kernel.org>
Message-ID: <b6b4f179-1fef-65db-8125-fa60e3627656@kernel.org>
Date:   Wed, 7 Aug 2019 09:52:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807135814.12906-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Naresh,

On 8/7/19 7:58 AM, Naresh Kamboju wrote:
> selftests kvm test cases need pre-required kernel configs for the test
> to get pass.
> 

Can you elaborate and add more information on which tests fail without
these configs. I am all for adding configs, however I would like to
see more information explaining which tests don't pass without this
change.

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

That being said, it is up to Paolo to decide a call on this patch.

thanks,
-- Shuah

