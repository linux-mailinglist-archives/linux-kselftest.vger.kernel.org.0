Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B16D9D90
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbjDFQaX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbjDFQaW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 12:30:22 -0400
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 09:30:18 PDT
Received: from out-22.mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B82E76A2
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 09:30:18 -0700 (PDT)
Date:   Thu, 6 Apr 2023 16:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680798240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWTa+WmjvRizEenNCYTpznSZcah8zt6cqf7cKCxX7a0=;
        b=YpT2Fq4n3IHoq0NhqGWEGK0xXZgdwSqB4fNw/EmbCwH+l+E/MrrjoaME/5opFFWMdi+c+R
        ZE4p8Y5lVIJD1YkvcVRijUkT7UmIcs5v809lkhdseoQq1syH+eK2vgk7gXhKeHpyl6Zl0Z
        QMSkBoDf4Wai6xmXfI6vbezrnWtEGTE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake
 "KVM_HYPERCAL_EXIT_SMC" -> "KVM_HYPERCALL_EXIT_SMC"
Message-ID: <ZC7yHC+FIJgE4APf@linux.dev>
References: <20230406080226.122955-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406080226.122955-1-colin.i.king@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 06, 2023 at 09:02:26AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a test assert message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

> ---
>  tools/testing/selftests/kvm/aarch64/smccc_filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/smccc_filter.c b/tools/testing/selftests/kvm/aarch64/smccc_filter.c
> index 0f9db0641847..82650313451a 100644
> --- a/tools/testing/selftests/kvm/aarch64/smccc_filter.c
> +++ b/tools/testing/selftests/kvm/aarch64/smccc_filter.c
> @@ -211,7 +211,7 @@ static void expect_call_fwd_to_user(struct kvm_vcpu *vcpu, uint32_t func_id,
>  			    "KVM_HYPERCALL_EXIT_SMC is not set");
>  	else
>  		TEST_ASSERT(!(run->hypercall.flags & KVM_HYPERCALL_EXIT_SMC),
> -			    "KVM_HYPERCAL_EXIT_SMC is set");
> +			    "KVM_HYPERCALL_EXIT_SMC is set");
>  }
>  
>  /* SMCCC calls forwarded to userspace cause KVM_EXIT_HYPERCALL exits */
> -- 
> 2.30.2
> 

-- 
Thanks,
Oliver
