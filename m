Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828BE5253E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357176AbiELRlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357202AbiELRlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:41:02 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A237A83
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:41:00 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id 3so4053289ily.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ir1zw0OZe5UU2KiBzSYOwuHmCrXrkYEC7RGqZNVaeEM=;
        b=IvE6/JS9OoyiNcMDOiJ6ONy7E+AnfyES5kY3vljwcFFCH5EJ2w4OWI0JhOekQErXdD
         jV+1Rw5uvDB61t4c1HIlfmHGaZKUKuG/KQbyC3kVZ3bAjrq/5ZCPz/4kVyLIszDiFvwX
         7ym2TWAqgaTUCfGwgC/P+uk4t8jRoUwtK3Yfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ir1zw0OZe5UU2KiBzSYOwuHmCrXrkYEC7RGqZNVaeEM=;
        b=g+juG7S3t9d32nySTbEj9D2yLEVJyaARjmfrfwkdhi+5uBvIIajupoDJ4CkZyjZ2f7
         Y1DPDZYCJQkikvsg+coFJapUizvnmw6HiIW9a3LaOMUO6PqtguPGvJKUyoKH7GrPPPzr
         de5sTITV1y+GUkKWaQuY0zedC84+ikJdqTPIQdaYHI2AWpA5BxhA63Lq1suBoOLQUd14
         /ufFTbeoBriagK1BNbQjiI9Z7kQLRONzW7u+Cv21zEzU32R872tM+wnzHsBkfQVeUD+p
         PJsjzkrgKXCQxaXhQi34jiyzZmZVzKVU+etl4JWJS/N7hPl0gjmcpZZY09+rXU7UsbWn
         miCA==
X-Gm-Message-State: AOAM533tlQCAN5ODBZ9C6asCOhIEjD6WUmN8ifI1Cw8u4Ff4zegRgkLL
        VLXG1AVJSi7bFvewHcdckEI9Gw==
X-Google-Smtp-Source: ABdhPJyCHrPg6BOwQEl56IJ7j6yjJ11xRJ3CgQk/iWhLk7WlvMrIYE5O/ICKVuQLfymYoHOQW9912Q==
X-Received: by 2002:a92:6e0b:0:b0:2c9:a276:58cc with SMTP id j11-20020a926e0b000000b002c9a27658ccmr576228ilc.199.1652377259680;
        Thu, 12 May 2022 10:40:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i3-20020a02ca03000000b0032bf978122asm41450jak.59.2022.05.12.10.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:40:59 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 3/8] selftests: kvm: priv_memfd_test: Add support
 for memory conversion
To:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220511000811.384766-1-vannapurve@google.com>
 <20220511000811.384766-4-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <934a07be-ce72-7916-5614-e78af8293b5c@linuxfoundation.org>
Date:   Thu, 12 May 2022 11:40:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-4-vannapurve@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 6:08 PM, Vishal Annapurve wrote:
> Add handling of explicit private/shared memory conversion using
> KVM_HC_MAP_GPA_RANGE and implicit memory conversion by handling
> KVM_EXIT_MEMORY_ERROR.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>   tools/testing/selftests/kvm/priv_memfd_test.c | 87 +++++++++++++++++++
>   1 file changed, 87 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
> index bbb58c62e186..55e24c893b07 100644
> --- a/tools/testing/selftests/kvm/priv_memfd_test.c
> +++ b/tools/testing/selftests/kvm/priv_memfd_test.c
> @@ -155,6 +155,83 @@ static struct test_run_helper priv_memfd_testsuite[] = {
>   	},
>   };
>   
> +static void handle_vm_exit_hypercall(struct kvm_run *run,
> +	uint32_t test_id)
> +{
> +	uint64_t gpa, npages, attrs;
> +	int priv_memfd =
> +		priv_memfd_testsuite[test_id].priv_memfd;

Do you need this on a separate line? Doesn't looks like it will exceed
the limit with the tab?

> +	int ret;
> +	int fallocate_mode;
> +
> +	if (run->hypercall.nr != KVM_HC_MAP_GPA_RANGE) {
> +		TEST_FAIL("Unhandled Hypercall %lld\n",
> +					run->hypercall.nr);

Is this considered test fail or skip because of unmet dependency?
Also do you need run->hypercall.nr os a separate line?

> +	}
> +
> +	gpa = run->hypercall.args[0];
> +	npages = run->hypercall.args[1];
> +	attrs = run->hypercall.args[2];
> +
> +	if ((gpa < TEST_MEM_GPA) || ((gpa +
> +		(npages << MIN_PAGE_SHIFT)) > TEST_MEM_END)) {
> +		TEST_FAIL("Unhandled gpa 0x%lx npages %ld\n",
> +			gpa, npages);

Same question here about gpa, npages on a separate line? Also
align it with the previous line for readability.

TEST_FAIL("Unhandled gpa 0x%lx npages %ld\n",
	  gpa, npages);
  
> +	}
> +
> +	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
> +		fallocate_mode = 0;
> +	else {
> +		fallocate_mode = (FALLOC_FL_PUNCH_HOLE |
> +			FALLOC_FL_KEEP_SIZE);
> +	}
> +	pr_info("Converting off 0x%lx pages 0x%lx to %s\n",
> +		(gpa - TEST_MEM_GPA), npages,
> +		fallocate_mode ?
> +			"shared" : "private");
> +	ret = fallocate(priv_memfd, fallocate_mode,
> +		(gpa - TEST_MEM_GPA),
> +		npages << MIN_PAGE_SHIFT);
> +	TEST_ASSERT(ret != -1,
> +		"fallocate failed in hc handling");
> +	run->hypercall.ret = 0;
> +}
> +
> +static void handle_vm_exit_memory_error(struct kvm_run *run,
> +	uint32_t test_id)
> +{
> +	uint64_t gpa, size, flags;
> +	int ret;
> +	int priv_memfd =
> +		priv_memfd_testsuite[test_id].priv_memfd;
> +	int fallocate_mode;
> +
> +	gpa = run->memory.gpa;
> +	size = run->memory.size;
> +	flags = run->memory.flags;
> +
> +	if ((gpa < TEST_MEM_GPA) || ((gpa + size)
> +					> TEST_MEM_END)) {
> +		TEST_FAIL("Unhandled gpa 0x%lx size 0x%lx\n",
> +			gpa, size);
> +	}
> +
> +	if (flags & KVM_MEMORY_EXIT_FLAG_PRIVATE)
> +		fallocate_mode = 0;
> +	else {
> +		fallocate_mode = (FALLOC_FL_PUNCH_HOLE |
> +				FALLOC_FL_KEEP_SIZE);
> +	}
> +	pr_info("Converting off 0x%lx size 0x%lx to %s\n",
> +		(gpa - TEST_MEM_GPA), size,
> +		fallocate_mode ?
> +			"shared" : "private");
> +	ret = fallocate(priv_memfd, fallocate_mode,
> +		(gpa - TEST_MEM_GPA), size);
> +	TEST_ASSERT(ret != -1,
> +		"fallocate failed in memory error handling");
> +}
> +
>   static void vcpu_work(struct kvm_vm *vm, uint32_t test_id)
>   {
>   	struct kvm_run *run;
> @@ -181,6 +258,16 @@ static void vcpu_work(struct kvm_vm *vm, uint32_t test_id)
>   			continue;
>   		}
>   
> +		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
> +			handle_vm_exit_hypercall(run, test_id);
> +			continue;
> +		}
> +
> +		if (run->exit_reason == KVM_EXIT_MEMORY_ERROR) {
> +			handle_vm_exit_memory_error(run, test_id);
> +			continue;
> +		}
> +
>   		TEST_FAIL("Unhandled VCPU exit reason %d\n", run->exit_reason);
>   		break;
>   	}
> 

Looks like you can easily combine lines without running into # chars limit
for several lines of code in this patch. If you haven't already, run
checkpatch to make sure coding guidelines are honored.

thanks,
-- Shuah
