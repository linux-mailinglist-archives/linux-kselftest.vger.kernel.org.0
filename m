Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C228652E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2019 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfHHPKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 11:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbfHHPKO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 11:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5ED5C8DA5B;
        Thu,  8 Aug 2019 15:10:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1EF9600CC;
        Thu,  8 Aug 2019 15:10:12 +0000 (UTC)
Date:   Thu, 8 Aug 2019 17:10:10 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     pbonzini@redhat.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
Message-ID: <20190808151010.ktbqbfevgcs3bkjy@kamzik.brq.redhat.com>
References: <20190808123140.25583-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808123140.25583-1-naresh.kamboju@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 08 Aug 2019 15:10:14 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 08, 2019 at 01:31:40PM +0100, Naresh Kamboju wrote:
> selftests kvm all test cases need pre-required kernel configs for the
> tests to get pass.
> 
> The KVM tests are skipped without these configs:
> 
>         dev_fd = open(KVM_DEV_PATH, O_RDONLY);
>         if (dev_fd < 0)
>                 exit(KSFT_SKIP);
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> ---
>  tools/testing/selftests/kvm/config | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/config
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
> -- 
> 2.17.1
>

What does the kselftests config file do? I was about to complain that this
would break compiling on non-x86 platforms, but 'make kselftest' and other
forms of invoking the build work fine on aarch64 even with this config
file. So is this just for documentation? If so, then its still obviously
wrong for non-x86 platforms. The only config that makes sense here is KVM.
If the other options need to be documented for x86, then should they get
an additional config file? tools/testing/selftests/kvm/x86_64/config?

Thanks,
drew
