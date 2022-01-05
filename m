Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F91485B9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 23:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbiAEW3K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 17:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244964AbiAEW3J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 17:29:09 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50A2C0611FD
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Jan 2022 14:29:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id co15so443794pjb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jan 2022 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NlNJ4grmTdeP8Ezi+MHLWLR1H1WOrSKO/roOqPIpLbo=;
        b=lcWVbw4ShlPDOZFedTW9LKOrUtdb0j3Ok8QwjZL8FBH5aeSmphdXAviZUApWVabJb8
         7mZiOI+HYWoiuw9OnP1dEWf+3SAc2EemATQSiH+geyoR3m00KucUcyfLLH428z3KMu3f
         Sd3raTZPd0glAqzErWQNsYb8C+R27GgqE7Mlgz8JyXPcJAuv3jBIQfynG4tq1UvnI6/M
         DU+wvedrGddOUpODqItCFlOOjxzWK+KPv0jGTsIbfAkLwzMsB40eO9cP0zYyLedPWVT/
         UnVR1B8xFbscWQ2l1T8EWcI64u/gQWqHV0IFWaka7AmfIOaGTuG/8kmljTWb8b3hyu1x
         bnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NlNJ4grmTdeP8Ezi+MHLWLR1H1WOrSKO/roOqPIpLbo=;
        b=LnLU1DMINiTJe7//ck2gA7SQWwjz3qIbV2DRxng2Y4037lC3Nca83cF1eQBqyj84FZ
         2tt9BhaUXZY3qc7fg7YvltBc11BacsJz7VVQNHXkMtaXQ0FvKZl62db0A6Q54Cf1SBsC
         0GXwZK21G8VhdNMyfLEUJc7Wpxv0w8ALLTitem2YaxDyqwLAnA3yzBvvr9ZS506zrgVb
         WmDEqrLhaSbRyrRXKeZ2p/t8GseGy5pMKNg3On9pU+mZjYjOTb3BcHjebmbaP4E9LcGw
         Y2IIpN7sc9iAmrMwF8MS/SrR1TStQvmaaIHHt9eAbD+YPbYh7zsLaiRIw0Mt8H7CRxFh
         Kmgg==
X-Gm-Message-State: AOAM531TKRijA+hA7pldpQfMLO+cMFdjpBOb8YCZ6bxJvrt8NvdFut25
        TXcbZG5er1v4MzoinRgIMqOInA==
X-Google-Smtp-Source: ABdhPJw/hS0IxkmtNQWaTfp7MjckeyXJKDDA6HAM1Mtx+suUSTVQ4BsX6dhq/PytaoZhbdgDvhwzKA==
X-Received: by 2002:a17:90b:4a86:: with SMTP id lp6mr6662981pjb.57.1641421749028;
        Wed, 05 Jan 2022 14:29:09 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p6sm52463pgl.16.2022.01.05.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 14:29:08 -0800 (PST)
Date:   Wed, 5 Jan 2022 22:29:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Zhong <yang.zhong@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v5 16/21] kvm: x86: Add CPUID support for Intel AMX
Message-ID: <YdYbsQ/q6VzR3m7d@google.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-17-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105123532.12586-17-yang.zhong@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022, Yang Zhong wrote:
> From: Jing Liu <jing2.liu@intel.com>
> 
> Extend CPUID emulation to support XFD, AMX_TILE, AMX_INT8 and
> AMX_BF16. Adding those bits into kvm_cpu_caps finally activates all
> previous logics in this series.
> 
> Hide XFD on 32bit host kernels. Otherwise it leads to a weird situation
> where KVM tells userspace to migrate MSR_IA32_XFD and then rejects
> attempts to read/write the MSR.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

No need for my SoB, I provided a very tiny snippet of code review.

> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
