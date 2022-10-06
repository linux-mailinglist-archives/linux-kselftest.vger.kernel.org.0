Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC75F6EC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJFURq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 16:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJFURp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 16:17:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD0C6978
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Oct 2022 13:17:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e129so2792992pgc.9
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Oct 2022 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4JyhrxAAyOLHmX7A4rrmrzCmFrvZfPiR/hVbSm/Hi8=;
        b=sk5ghBFSrEMOGUq9xNbnQb19kovevNTHzsBOVAU8bqxYIVO3n9h9AE57v3UX0k9qjL
         JUrZJs/USc1xn7/2n8RmxNi1+to+u6eugnEdQslIpkUyb7q7BaWNE6AnnwZuOg/K3MQC
         HUJdmpy+Ggr8aY2+DDwEgoqGph4Fe+BeCayAhXfCVoB8UmvmT9eWFLjMCkqNQiraOrse
         10T1vUVv+rfvPh0ayr95koZ7hK/UliSGAWvsqSNOjosXfx0eDHja3bWIES6OmfGOA/Yv
         e5pEDWhVCziHJF3kStYJ5xXGXGjhIjwO/uMtksdmBdYQo/bjsCQGL+mm7vncIzDJxsIo
         wAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4JyhrxAAyOLHmX7A4rrmrzCmFrvZfPiR/hVbSm/Hi8=;
        b=O2C5xqBFtKREuO1Sz9tE9LvlfwDuuF0l7Z9SkYpt/nFyFB4kWqtjeNIaeglQAUJw4e
         DCcnEmuX+e/+DSPgVQJfhE/SOQArXfLJmLoVQNm5OGpIfBw1M70ERfojcUdFyisP9E0c
         oE1K5B27N80MOpmNl5VV2RXYPpYjHoOsXCkpdR29aVH7ORAufzcpV3OsLocgg4a/TQVF
         tjUsDZ7r/qKkxHI2LYAzpi793E1CoX5RpVScmI/vckXatiAJG6ioektDKCaCmwT4FSXf
         AEsNOpzprJ0x/iZoY81Ar4y2q1RpRxYRyBUCQFXuS8f3h2atG0eyKV8YMy7lsIM+/4Ba
         mHYw==
X-Gm-Message-State: ACrzQf0J0LQx2jsweoIcZgQb9PQanltb9zBjedWsQjPfohyb0lTGj1SO
        5543QM0vqY/2SEyaSrfrJs3Yyw==
X-Google-Smtp-Source: AMsMyM471piwxOjkMBhX2gPsi6zT6/trUG/bsCNxkCSKPBKjsH1VR2Ke++mFLj7SWCNZW3cWXM6HPQ==
X-Received: by 2002:a63:6b88:0:b0:453:3f5e:67d7 with SMTP id g130-20020a636b88000000b004533f5e67d7mr1370342pgc.253.1665087463140;
        Thu, 06 Oct 2022 13:17:43 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709028a9400b00179f442519csm38967plo.40.2022.10.06.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:17:42 -0700 (PDT)
Date:   Thu, 6 Oct 2022 20:17:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com
Subject: Re: [RFC V3 PATCH 5/6] selftests: kvm: x86: Execute VMs with private
 memory
Message-ID: <Yz834mGQDtkdwn7q@google.com>
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-6-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819174659.2427983-6-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 19, 2022, Vishal Annapurve wrote:
> +/*
> + * Execute KVM hypercall to change memory access type for a given gpa range.
> + *
> + * Input Args:
> + *   type - memory conversion type TO_SHARED/TO_PRIVATE
> + *   gpa - starting gpa address
> + *   size - size of the range starting from gpa for which memory access needs
> + *     to be changed
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Function called by guest logic in selftests to update the memory access type
> + * for a given gpa range. This API is useful in exercising implicit conversion
> + * path.
> + */
> +void guest_update_mem_access(enum mem_conversion_type type, uint64_t gpa,
> +	uint64_t size)

Provide wrappers to self-document what's going on, then the massive block comments
go away.  And the guts of this and guest_update_mem_map() are nearly identical.

Hmm, and we probably want to make it possible to do negative testing.

Then the one-off enums for TO_PRIVATE and whatnot go way too.

> +{
> +	int ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> MIN_PAGE_SHIFT,

Needs an assert that @size is page aligned.  And since these are x86-64 specific,
just use PAGE_SHIFT.  Huh, IS_ALIGNED() doesn't exist in selftests.  That should
be added, either by pulling in align.h or by adding the generic macros to
kvm_util_base.h.

And then x86-64's processor.h can defined IS_PAGE_ALIGNED().

E.g.

static inline void __kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
						 uint64_t flags)
{
	return = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIFT, flags, 0);
}

static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
					       uint64_t flags)
{
	int ret;

	GUEST_ASSERT_2(IS_PAGE_ALIGNED(gpa) && IS_PAGE_ALIGNED(size), gpa, size);

	ret = __kvm_hypercall_map_gpa_range(gpa, size, flags);
	GUEST_ASSERT_1(!ret, ret);
}

static inline kvm_hypercall_map_shared(uint64_t gpa, uint64_t size)
{
	kvm_hypercall_map_gpa_range(gpa, size, KVM_CLR_GPA_RANGE_ENC_ACCESS);
}

static inline kvm_hypercall_map_private(uint64_t gpa, uint64_t size)
{
	kvm_hypercall_map_gpa_range(gpa, size, KVM_MARK_GPA_RANGE_ENC_ACCESS);
}

> +static void handle_vm_exit_map_gpa_hypercall(struct kvm_vm *vm,
> +				volatile struct kvm_run *run)

Pass in @vcpu, not a vm+run.

> +{
> +	uint64_t gpa, npages, attrs, size;
> +
> +	TEST_ASSERT(run->hypercall.nr == KVM_HC_MAP_GPA_RANGE,
> +		"Unhandled Hypercall %lld\n", run->hypercall.nr);
> +	gpa = run->hypercall.args[0];
> +	npages = run->hypercall.args[1];
> +	size = npages << MIN_PAGE_SHIFT;
> +	attrs = run->hypercall.args[2];
> +	pr_info("Explicit conversion off 0x%lx size 0x%lx to %s\n", gpa, size,
> +		(attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) ? "private" : "shared");
> +
> +	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
> +		vm_update_private_mem(vm, gpa, size, ALLOCATE_MEM);
> +	else
> +		vm_update_private_mem(vm, gpa, size, UNBACK_MEM);
> +
> +	run->hypercall.ret = 0;
> +}
> +
> +static void handle_vm_exit_memory_error(struct kvm_vm *vm, volatile struct kvm_run *run)

Same  here, take a @vcpu.
