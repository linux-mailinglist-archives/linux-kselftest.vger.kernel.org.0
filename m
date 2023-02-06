Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CB68C43C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBFRJX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 12:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBFRJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 12:09:22 -0500
Received: from out-206.mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A42449C
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 09:09:19 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:09:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675703355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBVaYLjdQ8/dQyRtJonhbtUyjbtJ5AvxiqChQWbzT+0=;
        b=auy0OdHHIMu0/N8C/mssCk1MzFsU6CIxsyUULv0kSodZ80VMOJbWjyOQ9s/to2fucQpkwg
        xrsqwOqEP1m/HjlGSEVccpQ2p0fUgD1gI1P3lC4Ccj9XDGGaOBVEgaQ2MlQcoG+iFDuIWS
        zf9zn42HB2IlKT/TW0nBhJ8R0wwmDxI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mark Brown <broonie@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com,
        anup@brainfault.org
Subject: Re: [PATCH] KVM: selftests: Enable USERFAULTFD
Message-ID: <Y+E0MuGJ+hE3zslT@google.com>
References: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+cc x86, riscv as they're also affected.

On Thu, Feb 02, 2023 at 09:01:36PM +0000, Mark Brown wrote:
> The page_fault_test KVM selftest requires userfaultfd but the config
> fragment for the KVM selftests does not enable it, meaning that those tests
> are skipped in CI systems that rely on appropriate settings in the config
> fragments except on S/390 which happens to have it in defconfig. Enable
> the option in the config fragment so that the tests get run.

Thanks for catching this.

I believe we also need UFFD for demand_paging_test, which is used by all
the KVM selftests arches. I plan on picking this up, but if anyone has
objections please shout :)

--
Thanks,
Oliver

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
> index 63ed533f73d6..d011b38e259e 100644
> --- a/tools/testing/selftests/kvm/config
> +++ b/tools/testing/selftests/kvm/config
> @@ -1,3 +1,4 @@
>  CONFIG_KVM=y
>  CONFIG_KVM_INTEL=y
>  CONFIG_KVM_AMD=y
> +CONFIG_USERFAULTFD=y
> 
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230202-kvm-selftest-userfaultfd-ea85a8b5f873
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

-- 
Thanks,
Oliver
