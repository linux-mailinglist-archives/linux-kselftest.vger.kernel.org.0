Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5D5F6EF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 22:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiJFUYD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 16:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiJFUYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 16:24:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9BBB07C
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Oct 2022 13:23:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so2841307pgs.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Oct 2022 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YMVD388HY4gyN9KXMp2mD0UxMIRKINTjTu+0ma51kI=;
        b=ZaK/h7gI4j1HzDQbCtiys+s/JZmJJZpQGu818KofOQuSks/l65WxVexlmCH7Q/UD1D
         2QBY0bV8xeLjmy868p//N5X3NmDnYzWK7Sb1B1qZ7QvFtzF3YgiQhr1Ssy/hHkL3w3Sz
         yFog3EYTjV8JGFMCgvzgzz4wTRufqrOCyxNVAfIR5Piiy+Met4OJdVtTyUwznfbzGaC4
         TtJVA40+OHY1tKsHhqiX3BxbKMsIbt0C3v1eU8Fx7gAGFzhkqjIYXP1uGOo20Z/KH3Pe
         j85R805hQikwAgDeuy2mIpHt/qzD9B2QtgSV6BfGvEWyLohQV+lIllvKbanffgCgMwWC
         JPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YMVD388HY4gyN9KXMp2mD0UxMIRKINTjTu+0ma51kI=;
        b=U4DRIVc+LWPQR4GenBNGT7VWvg2tt48DoNz09CoeMnzzrlhT1P2rC5h2zQ9EZ/pSib
         NWq90YN2YicyrMOvuCwdwhErFV3rbn/DN4lsdKdHBLf0Enp4Buuw6Bu8u81fr3FSHY3Y
         1aqaK2665p5t1yX0+tc1vLUeFy6iscDFxJMmZ6JkvSaM1TUOaAbXjP2evYnWWMQh79nk
         i4jNE+oA7rKanuiHopdrVsBGirAxkLBuQ+//467rvk9/zbIaBj/znVSnUIhfGJuy7ufO
         G4Ho7+9QiMxD6f4q2gicknpqOrmytt8o5bRSVyWWbXHgCUFX8ytDUEf+PsgNJ4UJevK+
         mOQQ==
X-Gm-Message-State: ACrzQf0QsmjVMhrMcPCoXOnDwl0zcLjxvon3ZJX9kYI+/7KEZQhfyoAJ
        Vg0iCfhlJooRZZey5HSM5bGwMQ==
X-Google-Smtp-Source: AMsMyM6Usq1xbc+hq7aorYaRMqyYzyH8p33s7j+wBGcQBvAD9iBc9TLdvg3KOYHNAKDwbwo8uL4pkA==
X-Received: by 2002:a05:6a00:1595:b0:562:6199:bdab with SMTP id u21-20020a056a00159500b005626199bdabmr1477052pfk.64.1665087836860;
        Thu, 06 Oct 2022 13:23:56 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709027e8c00b0016dbaf3ff2esm48576pla.22.2022.10.06.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:23:56 -0700 (PDT)
Date:   Thu, 6 Oct 2022 20:23:52 +0000
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
Subject: Re: [RFC V3 PATCH 6/6] sefltests: kvm: x86: Add selftest for private
 memory
Message-ID: <Yz85WEQWsXAbLWnu@google.com>
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-7-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819174659.2427983-7-vannapurve@google.com>
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

On Fri, Aug 19, 2022, Vishal Annapurve wrote:
> +static bool verify_mem_contents(void *mem, uint32_t size, uint8_t pat)

As per feedback in v1[*], spell out "pattern".

[*] https://lore.kernel.org/all/YtiJx11AZHslcGnN@google.com

> +{
> +	uint8_t *buf = (uint8_t *)mem;
> +
> +	for (uint32_t i = 0; i < size; i++) {
> +		if (buf[i] != pat)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Add custom implementation for memset to avoid using standard/builtin memset
> + * which may use features like SSE/GOT that don't work with guest vm execution
> + * within selftests.
> + */
> +void *memset(void *mem, int byte, size_t size)
> +{
> +	uint8_t *buf = (uint8_t *)mem;
> +
> +	for (uint32_t i = 0; i < size; i++)
> +		buf[i] = byte;
> +
> +	return buf;
> +}

memset(), memcpy(), and memcmp() are safe to use as of commit 6b6f71484bf4 ("KVM:
selftests: Implement memcmp(), memcpy(), and memset() for guest use").

Note the "fun" with gcc "optimizing" into infinite recursion... :-)

> +
> +static void populate_test_area(void *test_area_base, uint64_t pat)
> +{
> +	memset(test_area_base, pat, TEST_AREA_SIZE);
> +}
> +
> +static void populate_guest_test_mem(void *guest_test_mem, uint64_t pat)
> +{
> +	memset(guest_test_mem, pat, GUEST_TEST_MEM_SIZE);
> +}
> +
> +static bool verify_test_area(void *test_area_base, uint64_t area_pat,
> +	uint64_t guest_pat)

Again, avoid "pat".

> +{
> +	void *test_area1_base = test_area_base;
> +	uint64_t test_area1_size = GUEST_TEST_MEM_OFFSET;
> +	void *guest_test_mem = test_area_base + test_area1_size;
> +	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
> +	void *test_area2_base = guest_test_mem + guest_test_size;
> +	uint64_t test_area2_size = (TEST_AREA_SIZE - (GUEST_TEST_MEM_OFFSET +
> +			GUEST_TEST_MEM_SIZE));

This is all amazingly hard to read.  AFAICT, the local variables are largely useless.
Actually, why even take in @test_area_base, isn't it hardcoded to TEST_AREA_GPA?
Then everything except the pattern can be hardcoded.

> +	return (verify_mem_contents(test_area1_base, test_area1_size, area_pat) &&
> +		verify_mem_contents(guest_test_mem, guest_test_size, guest_pat) &&
> +		verify_mem_contents(test_area2_base, test_area2_size, area_pat));
> +}
