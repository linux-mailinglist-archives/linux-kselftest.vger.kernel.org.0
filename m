Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FB7861B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjHWUs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbjHWUsC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 16:48:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DA10D8;
        Wed, 23 Aug 2023 13:48:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692823677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Yapx1izqMJNWGK86iIChhl3nrTxYbrL7JSLHDQf04I=;
        b=bn1U5vh7lJw1fYSPNnnahndougAW/wNnVzaFq/KE0dHrxPoiaBK+WT67o5omMBmRcpZJG1
        JRwYBwCgCSTEFjHdciilk7Ijytbv05jGaU7JVGCUrBCKwzBM219yeLDdCdwcSUHmmfjoB9
        AmiP0c2y5XsG6SUgpMSStDnJupVG4SqecK4jgOA2/B0bHmNE8BClWYmkW40jlhPJNAqb8i
        VZSJnF0/59MIyb0UeK5IOX5Nv4Gfipsk5I0C/zLos2tIkvar9flMv/87ZGBPV9GVWvvabJ
        n9isWQJB1LxSlmiP2XvC1votth+EAC30kSfs42H5CsnqLd1H0GkBAVZ+NZdETw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692823677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Yapx1izqMJNWGK86iIChhl3nrTxYbrL7JSLHDQf04I=;
        b=moPng/ju61TIqvlhSh1Q6penCZsj2aRYqBLzACeg5iH4k7zo4kfr31GlSpbHa/4/jMJayl
        waJQONQh+J02rgDw==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
In-Reply-To: <83a832b156f6e3bf906fee657b0147f042481a36.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <83a832b156f6e3bf906fee657b0147f042481a36.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Wed, 23 Aug 2023 22:47:56 +0200
Message-ID: <875y55eb9f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 14 2023 at 00:23, Kuppuswamy Sathyanarayanan wrote:
> +static int __init tdx_event_irq_init(void)
> +{
> +	struct irq_affinity_desc desc;
> +	struct irq_alloc_info info;
> +	struct irq_cfg *cfg;
> +	int irq;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return 0;
> +
> +	init_irq_alloc_info(&info, NULL);
> +
> +	cpumask_set_cpu(smp_processor_id(), &desc.mask);

desc is completely uninitialized here and therefore desc.mask and
desc.is_managed contain random stack content.

The only reason why this "works" is that tdx_event_irq_init() is an
early initcall which is invoked before SMP init, so the only choice of
the allocator is to pick an interrupt on CPU0.

Thanks,

        tglx



