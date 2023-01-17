Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F280670DD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 00:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAQXqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 18:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjAQXpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 18:45:40 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BB4DE25
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:51:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso467047pjt.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dz4YSfpv2T4m79ecLVLYg/MjvlF/TKDxbBLqvBzZUw=;
        b=sv78Dh2Q372NesG6fn9eLYR446uOhxqMw95J9Xmhrg1XZKK9E0pPqMndt5u6CFNZt+
         wEx7TGifDWupQ1scvBA7o1nLOawl/DGYwQ/EpX3Vefiab0uJOUJG0SfBWAjtwQfs3Oym
         9VvMWaizc8KXBH/FiUMj//KhicHS00IpGpo/4RCopkl9BMcYDeUnlsqv3wUtQA4yMTfT
         wNZSSV1OQs2TLn+dbNinHZ4ZSqgEbAuy5evzUe8XBMKF4hNltMJPeY/gN0UC0FHD254Q
         kF4s5VHwl6vpnWc2LRSEN9qEOrgZj2zH8YjY9UAxxNUdPIMuzjRJlkcQ1Sm03Mpvlryj
         fAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dz4YSfpv2T4m79ecLVLYg/MjvlF/TKDxbBLqvBzZUw=;
        b=ZXE9rYN7OVhOann0CDzx4E3K4P16Ghi6VojqPkCzqXPTCMgRvFEGVKy4advRskGgNv
         lxlCbiMSmlGz54/iqVWo4vtHu9KBtR2yiXjJ61Vly4ibCtXSIqoRkwnHigYNVtwR/hoS
         zXJ+/ZEbfBPDSOwud88Jx2T5gNh1dmhHebXeA+t30hmQMxgX1XhtlV4jE2slmjeckvkP
         Ky2Klol64CvOUACnDp+GMO6o4wHlHGpFYxEtBTIgOoqd5jgvFRbl4m2u58c6dNBbixlq
         nDoO8mAxjZKvs/bP6SUyLm+kyG7ldiMQ4X1+RrfGKOuuvY6aaRT0SAZBVNXrPMJzZ73j
         ihnQ==
X-Gm-Message-State: AFqh2kppw5OeCIsb8c+NptuQ4ZI2F9roMMwYa15UJ4Ixcnj5JQMTUd2i
        IGS7/u0vG6jX/HWUsYsPumkCMg==
X-Google-Smtp-Source: AMrXdXtw6UInomjD3WXWYJY8U/YyUCazJws5E/fdEK6s0Kvi4UPULlGid2XrdO9gLfFWa2NS3d4S5A==
X-Received: by 2002:a05:6a20:ce43:b0:b8:c3c0:e7f7 with SMTP id id3-20020a056a20ce4300b000b8c3c0e7f7mr395043pzb.1.1673995906357;
        Tue, 17 Jan 2023 14:51:46 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z13-20020aa79e4d000000b0058bc1a13ffcsm7232252pfq.25.2023.01.17.14.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:51:45 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:51:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
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
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Subject: Re: [V2 PATCH 4/6] KVM: selftests: x86: Add helpers to execute VMs
 with private memory
Message-ID: <Y8cmfjRIRp2EphTa@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-5-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-5-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> +void vcpu_run_and_handle_mapgpa(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Loop until the guest exits with any reason other than
> +	 * KVM_HC_MAP_GPA_RANGE hypercall.
> +	 */
> +
> +	while (true) {
> +		vcpu_run(vcpu);
> +
> +		if ((vcpu->run->exit_reason == KVM_EXIT_HYPERCALL) &&
> +			(vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)) {

I get what you're trying to do, and I completely agree that we need better helpers
and/or macros to reduce this type of boilerplate, but adding a one-off helper like
this is going to be a net negative overall.  This helper services exactly one use
case, and also obfuscates what a test does.

In other words, this is yet another thing that needs broad, generic support
(_vcpu_run() is a very special case).  E.g. something like this to make it easy
for tests to run a guest and handle ucalls plus specific exits (just a strawman,
I think we can do better for handling ucalls).

#define vcpu_run_loop(vcpu, handlers, ucalls)				\
do {									\
	uint32_t __exit;						\
	int __r = 0;							\
									\
	while (!r)  {							\
		vcpu_run(vcpu);						\
									\
		__exit = vcpu->run->exit_reason;			\
									\
		if (__exit < ARRAY_SIZE(handlers) && handlers[__exit])	\
			__r = handlers[__exit](vcpu);			\	
		else if (__exit == KVM_EXIT_IO && ucalls)		\
			__r = handle_exit_ucall(vcpu, ucalls,		\
						ARRAY_SIZE(ucalls));	\
		else							\
			TEST_FAIL(...)					\
	}								\
} while (0)


For this series, I think it makes sense to just open code yet another test.  It
really doesn't end up being much code, which is partly why we haven't added
helpers :-/
