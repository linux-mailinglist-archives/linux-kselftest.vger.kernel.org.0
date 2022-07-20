Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD257BFFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiGTWTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 18:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiGTWTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 18:19:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED051422
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 15:19:51 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o18so17685124pgu.9
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ZxyLZ0QxKzQzDRLPibOfpzfI1ZlC+suEMS1udnprk8=;
        b=BY/258fxiwyb/hCVHWHpPTg2PYUCxJ45zmq8SCD/Y3AhUT46OCJHN/mT+DkG6m01tj
         34tjvpxtQjJJp/JFHKQY8uM+YMOKSAgtweSqgR1sT4lHyz509usVCuGJYF0Na0765S4d
         BgZl5NIzuMzo9j0NoUtH8rtyelIa+Ep/60SGw1GjT7p9JV+ktxNRjuKhGGGv206krOXd
         SvrsO817DqmrqicsJwekKrCioa11PfTSt9GsDvufT2kgDyC/RVmOoRom+p8DGA/hxa3X
         r3IbOaL3JvDnauAPBfOKpDFHWclcNl6sDgJRUPrRPw5kfWo2SQnZ+AppGwSB6SEmFVlO
         FpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ZxyLZ0QxKzQzDRLPibOfpzfI1ZlC+suEMS1udnprk8=;
        b=X9j33H1xWIcrzLsdIwFjP4BInt8Ovnk5gYTg2kRA8NvJTFMGQsIyZkckBOKDSd9UkV
         Sl13IJzX9ZllTtLHfrKk+kA1QtwmaJsSu3f9vZKTJnDPa/Z4nCLQzmU6vgRKFzHf5VtT
         yGpPY/brw4lluDNzcTaqS/+1Cx8fBPoR+j9lLtpVhfyMuhuEZ4haEooEdJQX6cCwxJh2
         0EsXasa6UvR/YhFP85hvarO5CKdYLC6JDiJ6LtDpFauNTDrihM9TrpDcJcMbgRaEZvIL
         uRhI7DGLdpO+RYRSkvoNTi3qAUX5mpJvQz68WMqsOEIED3eEGsa++F8N6xycrcvnbnw2
         7Crw==
X-Gm-Message-State: AJIora9OMkM7o4q3Kv6nfPlS+jh+GEgAEGlYGRYl6Z5H0GdsO6vq0NTw
        McDm3p9uxRiOIzLV69RWeE69oA==
X-Google-Smtp-Source: AGRyM1sQTtoUHcxxTGn5INxwcSsDTwXdrs+zrCZ2Hxmv+xffsTeoooZDt9v2hmn+vUWnpM4KG/y4hg==
X-Received: by 2002:a63:1848:0:b0:416:1821:aa0b with SMTP id 8-20020a631848000000b004161821aa0bmr35801786pgy.394.1658355590980;
        Wed, 20 Jul 2022 15:19:50 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id z28-20020aa7949c000000b0052516db7123sm141228pfk.35.2022.07.20.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:19:50 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:19:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shauh@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com
Subject: Re: [RFC V2 PATCH 0/8] selftests: KVM: selftests for fd-based
 approach of supporting private memory
Message-ID: <Yth/gpebtWkTu4bC@google.com>
References: <20220511000811.384766-1-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
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

On Wed, May 11, 2022, Vishal Annapurve wrote:
>  tools/testing/selftests/kvm/priv_memfd_test.c | 1359 +++++++++++++++++

Please don't create a megatest.  We have megatests for nVMX and nSVM in KVM-Unit-Test
and IMO they are a mistake.  E.g. to run a single test instead of the entire suite,
the KUT tests provide a funky wildcard/filter syntax.  But the names of the tests
aren't discoverable, so inevitably I have to look at the source code to figure out
the exact name of the test I want to run.  And don't get me started on sub-tests
within sub-tests...

AFAICT, what you've proposed here doesn't provide any such filter mechanism.  And
I would rather we NOT start adding those to selftests, because we'd effectively be
reinventing the wheel _and_ dealing with strings in C is a pain.  Writing a script
to find and run all tests is trivial, e.g. grep the .gitignore to find tests for
the target arch.  Or when the system under test is different than the build system,
copy the binaries to a dedicated directory and run every binary in that directory.

Discovering and running a single test is similarly trivial.  For KUT, it's less
trivial because running a test involves invoking a VMM command line, and some of
the tests need specific command line parameters.  But for selftests, except for the
NX huge page test, they're all standalone and don't need additional setup.

And unlike KUT's nVMX and nSVM tests, which involve running hundreds of little
sub-tests with only minor differences in setup, these tests are largely independent,
i.e. you're not really getting much code reuse.

And if you split the tests up, then all of the inter-test namespacing goes away,
e.g. there is zero chance I will ever remember what "PSPAHCT" stands for.

+#define PSPAHCT_GUEST_STARTED                          0ULL
+#define PSPAHCT_GUEST_PRIVATE_MEM_UPDATED              1ULL
+#define PSPAHCT_GUEST_SHARED_MEM_UPDATED               2ULL
+#define PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2             3ULL

If you find yourself doing a lot of copy+paste, then we should enhance the APIs
provided by the core infrastructure.
