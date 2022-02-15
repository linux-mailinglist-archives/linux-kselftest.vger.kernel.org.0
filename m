Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169614B7397
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiBOPZP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 10:25:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiBOPZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 10:25:14 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25085BCC
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 07:25:04 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p63so24166794iod.11
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 07:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=STSfeMkR8sO6JKdBEzPJOeiPGWaxCEMoqHon21FihTU=;
        b=YJUS8WZ6GALIAGJCgBqidA/jRC7Y4VlfQon9K7eJGbV5JFiV8G0w1bkomi5BZCStpo
         emu7g8n7Y+/hd7YAaj3mNC5X9GOT0unsqyZ6koBcMT4NHVx/u3LydOeUDO6Ov0P1JZAE
         iT3hqQ4GGlayHiq7Kauf4oVzTr3qwGqqaWZNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=STSfeMkR8sO6JKdBEzPJOeiPGWaxCEMoqHon21FihTU=;
        b=vy1+dSFsMpBiEGGR0rq3LouNRbpB68RsMHwV3T1NOaLE/WiOrL23uAscQ0NnIL8nFN
         tSZeJEUYmq2SwNRhvqYG+Mt8dd6vs4flhwvpyHrvO+RNRgR7uT4Q2rrKdC3mSN5wbtWN
         OegJzlBhjw6xexItmh/d4Wzho81WD1epHXq1k0NKYBZuloCUb23EvY709NmqSIUpU5ei
         09HCLE9sQmeVDLyp+ZQ0jHExzUMFsqUCGvko9OvJ4hMMn6M/f8u38+2Q7WNtO1l38Dv8
         Prs/2v831i8xNaSy3D91J38CtnKc+/U9hRsuyfRQ0Lj5kPpSKo+WKZ3YIoIj2TyxovgF
         SKEg==
X-Gm-Message-State: AOAM532dLC99rJz9XywJ7UK69xywTO+Vr1Bd3jKgseymaYOvlhEoR4rF
        sHGuEJkL5cRXtQmc/dMPYuHIJQ==
X-Google-Smtp-Source: ABdhPJy+IcgP1I/EPyq/Kpzq9SYpM21us3QTIGn6lhDEubr9KH/TzO2vI54UO9yXV6od31OPqFQCyA==
X-Received: by 2002:a05:6602:2ac1:: with SMTP id m1mr2681467iov.123.1644938703517;
        Tue, 15 Feb 2022 07:25:03 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id r13sm10603485ilb.35.2022.02.15.07.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:25:03 -0800 (PST)
Subject: Re: [PATCH] selftests: kvm: Check whether SIDA memop fails for normal
 guests
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220215074824.188440-1-thuth@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d576d8f7-980f-3bc6-87ad-5a6ae45609b8@linuxfoundation.org>
Date:   Tue, 15 Feb 2022 08:25:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220215074824.188440-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 12:48 AM, Thomas Huth wrote:
> Commit 2c212e1baedc ("KVM: s390: Return error on SIDA memop on normal
> guest") fixed the behavior of the SIDA memops for normal guests. It
> would be nice to have a way to test whether the current kernel has
> the fix applied or not. Thus add a check to the KVM selftests for
> these two memops.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 9f49ead380ab..d19c3ffdea3f 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -160,6 +160,21 @@ int main(int argc, char *argv[])
>   	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
>   	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
>   
> +	/* Check that the SIDA calls are rejected for non-protected guests */
> +	ksmo.gaddr = 0;
> +	ksmo.flags = 0;
> +	ksmo.size = 8;
> +	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.sida_offset = 0x1c0;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL,
> +		    "ioctl does not reject SIDA_READ in non-protected mode");

Printing what passed would be a good addition to understand the tests that
get run and expected to pass.

> +	ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL,
> +		    "ioctl does not reject SIDA_WRITE in non-protected mode");
> +

Same here.

>   	kvm_vm_free(vm);
>   
>   	return 0;
> 

Something to consider in a follow-on patch and future changes to these tests.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
