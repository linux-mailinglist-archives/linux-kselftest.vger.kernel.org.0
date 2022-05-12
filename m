Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DDE5253FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357048AbiELRqH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357233AbiELRp6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:45:58 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3B12613
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:45:56 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso7559782fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pZ9h+s6h2+1qS4V/lr1+HPr3vp4rl9/9pnc5MgAiHb4=;
        b=VBjXrSrh6RboKZRgN/Ib5xzMxbhAijEoDCAuhLKOpfVPdBGmDAzSmLKv8bSg5QW7y4
         3mqmcYR5/SWL7pQgkwk8xsZ7UIK+C1Z05ek1YEdkbRueTl4lI/BEA2w6FjZIk28QIxjF
         FuLHSrKG/4n0a0xsLofGyez4RSh+oHEoAIgfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZ9h+s6h2+1qS4V/lr1+HPr3vp4rl9/9pnc5MgAiHb4=;
        b=2IF1S1IYu86Uk4O8YHwbd7kqYZyr1mxRh7MX8xpUiegtSzXy5ffRjoamfX2AL3yg4Z
         465WO5SbePWuAVL2JXKpFgfoZfpOz8T2Da8wL3itQXf/m7BrU0VTKkTW/+kZwpoayC1y
         xQ0pLqYHKDShzoRa8vdRMOsv+qRK0TpAgGg9LeVWdJVas3umwa7VxyyiblpHtkQrh4/N
         tANipGPPQHbzWZTA7MsEQBmwQv+co3Y8GY3/KPxXTvvQkQnk57c9JR9IhqWS19hVtWmY
         Ladklv/1Jd9KEuNM+mxzZj0FTiJhWKG9H2JOOX26bC//T/Qa9//gSPTmH2I665BTleB6
         khzw==
X-Gm-Message-State: AOAM531c48M36WpFLzGloQLxHnvFmv+n/9BPzcf2E9E2kfzXvbbBTGgo
        kQ7SCH1Sgd/vOPt2uHeV4+g7hw==
X-Google-Smtp-Source: ABdhPJydZ/eJU55U4wrTdxdPrOmcr/r8xF7yWuRPmZDzeEMIweJfMbFWjkFuN99HN71Z9pz4nPUVvw==
X-Received: by 2002:a05:6870:95a4:b0:d7:18b5:f927 with SMTP id k36-20020a05687095a400b000d718b5f927mr527535oao.45.1652377555169;
        Thu, 12 May 2022 10:45:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a3-20020a05683012c300b00606387601a2sm126250otq.34.2022.05.12.10.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:45:54 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 4/8] selftests: kvm: priv_memfd_test: Add shared
 access test
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
        diviness@google.com
References: <20220511000811.384766-1-vannapurve@google.com>
 <20220511000811.384766-5-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d908a526-7367-366d-9f45-f40274c1b27e@linuxfoundation.org>
Date:   Thu, 12 May 2022 11:45:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-5-vannapurve@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 6:08 PM, Vishal Annapurve wrote:
> Add a test to access private memory in shared fashion
> which should exercise implicit memory conversion path
> using KVM_EXIT_MEMORY_ERROR.
> 

This comment applies all patches in this series. Keep commit log
line length around 76 for readability in "git log" display.


Also same comment about combining lines of code when it isn't
necessary to split them, align the lines with parenthesis to
make it easier to read, and run checkpatch.

> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>   tools/testing/selftests/kvm/priv_memfd_test.c | 69 +++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
> index 55e24c893b07..48bc4343e7b5 100644
> --- a/tools/testing/selftests/kvm/priv_memfd_test.c
> +++ b/tools/testing/selftests/kvm/priv_memfd_test.c
> @@ -147,12 +147,81 @@ static void pmpat_guest_code(void)
>   	GUEST_DONE();
>   }
>   
> +/* Test to verify guest shared accesses on private memory with following steps:
> + * 1) Upon entry, guest signals VMM that it has started.
> + * 2) VMM populates the shared memory with known pattern and continues guest
> + *    execution.
> + * 3) Guest reads private gpa range in a shared fashion and verifies that it
> + *    reads what VMM has written in step2.
> + * 3) Guest writes a different pattern on the shared memory and signals VMM
> + *      that it has updated the shared memory.
> + * 4) VMM verifies shared memory contents to be same as the data populated
> + *      in step 3 and continues guest execution.
> + */
> +#define PMSAT_ID				1
> +#define PMSAT_DESC				"PrivateMemorySharedAccessTest"
> +
> +/* Guest code execution stages for private mem access test */
> +#define PMSAT_GUEST_STARTED			0ULL
> +#define PMSAT_GUEST_TEST_MEM_UPDATED		1ULL
> +
> +static bool pmsat_handle_vm_stage(struct kvm_vm *vm,
> +			void *test_info,
> +			uint64_t stage)
> +{
> +	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
> +
> +	switch (stage) {
> +	case PMSAT_GUEST_STARTED: {
> +		/* Initialize the contents of shared memory */
> +		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
> +			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
> +			"Shared memory update failed");
> +		VM_STAGE_PROCESSED(PMSAT_GUEST_STARTED);
> +		break;
> +	}
> +	case PMSAT_GUEST_TEST_MEM_UPDATED: {
> +		/* verify data to be same as what guest wrote */
> +		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
> +			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
> +			"Shared memory view mismatch");
> +		VM_STAGE_PROCESSED(PMSAT_GUEST_TEST_MEM_UPDATED);
> +		break;
> +	}
> +	default:
> +		printf("Unhandled VM stage %ld\n", stage);

Is this a test failure? Add more information to use why it isn't handled.

> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void pmsat_guest_code(void)
> +{
> +	void *shared_mem = (void *)TEST_MEM_GPA;
> +
> +	GUEST_SYNC(PMSAT_GUEST_STARTED);
> +	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
> +			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
> +
> +	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
> +			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
> +	GUEST_SYNC(PMSAT_GUEST_TEST_MEM_UPDATED);
> +
> +	GUEST_DONE();
> +}
> +
>   static struct test_run_helper priv_memfd_testsuite[] = {
>   	[PMPAT_ID] = {
>   		.test_desc = PMPAT_DESC,
>   		.vmst_handler = pmpat_handle_vm_stage,
>   		.guest_fn = pmpat_guest_code,
>   	},
> +	[PMSAT_ID] = {
> +		.test_desc = PMSAT_DESC,
> +		.vmst_handler = pmsat_handle_vm_stage,
> +		.guest_fn = pmsat_guest_code,
> +	},
>   };
>   
>   static void handle_vm_exit_hypercall(struct kvm_run *run,
> 

thanks,
-- Shuah
