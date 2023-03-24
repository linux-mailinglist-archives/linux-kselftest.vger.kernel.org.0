Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A06C872A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 21:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCXU7o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjCXU7k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 16:59:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7916AC3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:59:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b124-20020a253482000000b00b72947f6a54so2918787yba.14
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679691577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yw8bxlWiVUYvv5AbPqioo8nDrcBziQC1l0Q2DouGamM=;
        b=qZ646UOKygYmjFpivrARhJHeQ6Go6kJ9HdGUO+/6baz6gJsf9QJe1ex6mFCjOsNh8v
         L+mp+SM6xG0AEro23UhNYOuj5rZYIKSjIzDnTG3CA7LxnI5MkPvj1c9j7VJgDhvG32de
         PQKGoFMBmWM956CK0CGFhV1YlStEAXUrur0NMmAn0CpKa31xdXtxrZdFOYYFr4ru2Fb3
         ywE5pRJw40gOwIYanB4aGYA392gc+Pl/fAJIpz5MiU229AwAGX8UmrCgtuCkIKNLvk+5
         Qpih0H5t1qos0D/w3iEGYMUk/THZ8/oKo91rWTTVZ7u8CEgS2iy041wfr5yztL3CEqJq
         pCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yw8bxlWiVUYvv5AbPqioo8nDrcBziQC1l0Q2DouGamM=;
        b=DYmDMyNvoddUbFPWWX2hAsTdTMUKCmVC1HIhOedEtHu/h/YGxcCwf0DHs1vJjLkxCC
         rBzhTJK9vQCasEwWt7I9dQSRb8JKF4lvSHCxiefKJM4IvdF4BJxa8cpv+owAyw6Iz2bs
         PfPcLNdo+2yEq9tQUmNlzlD2zN1iACwIxA+2q7MfqIa+cje4ABh1I2eL3sO2a7p3uIDV
         1VyOaWj+SNN15Nk5CD3ze/b65zVF7QV2kDim09huak2PkcCUTWlRpi9nhCBRa3hdiqbk
         5JO9/xTeVfn60f1tjZqcVTHvc6GT9g4OCskc8u/Fvqzb7jNbb96LIEMyBlprVGdIJcUT
         hILQ==
X-Gm-Message-State: AAQBX9eqPp/M11b+rxogIp7XY6/BIYzGMSlwqGsAdbzcyap8B0wMqv4h
        44tkW6yRDAbqT5bRUTrXFJ/gtIvq9rg=
X-Google-Smtp-Source: AKy350Y0uAfSCYpymvYMsZDIoMQWupR+DbqRNjYQB61IpzlPO9eZRXxMRMnS9MmHnB263GZRofzV2cy8wiQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1201:b0:b6c:4d60:1bd6 with SMTP id
 s1-20020a056902120100b00b6c4d601bd6mr2334335ybu.9.1679691577552; Fri, 24 Mar
 2023 13:59:37 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:58:52 -0700
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167969137429.2756469.2347841728687804486.b4-ty@google.com>
Subject: Re: [PATCH v3 00/13] Overhauling amx_test
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mingwei Zhang <mizhang@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 21 Feb 2023 16:36:42 +0000, Mingwei Zhang wrote:
> In this version, I have integrated Aaron's changes to the amx_test. In
> addition, we also integrated one fix patch for a kernel warning due to
> xsave address issue.
> 
> Patch 1:
> Fix a host FPU kernel warning due to missing XTILEDATA in xinit.
> 
> [...]

Applied everything except patch 7 to kvm-x86 selftests.  Please holler if I
missed something subtle about patch 7 (using & vs. ==).  This is at the head
of kvm-x86/selftests, i.e. I can fix it up if necessary.

[01/13] x86/fpu/xstate: Avoid getting xstate address of init_fpstate if fpstate contains the component
        (no commit info)
[02/13] KVM: selftests: x86: Add a working xstate data structure
        https://github.com/kvm-x86/linux/commit/03e8ddff78ac
[03/13] KVM: selftests: x86: Fix an error in comment of amx_test
        https://github.com/kvm-x86/linux/commit/c23d3b210baf
[04/13] KVM: selftests: x86: Enable checking on xcomp_bv in amx_test
        https://github.com/kvm-x86/linux/commit/1e2de0651567
[05/13] KVM: selftests: x86: Add check of CR0.TS in the #NM handler in amx_test
        https://github.com/kvm-x86/linux/commit/04f5d4539105
[06/13] KVM: selftests: x86: Add the XFD check to IA32_XFD in #NM handler
        https://github.com/kvm-x86/linux/commit/eeae141ddb54

[08/13] KVM: selftests: x86: Repeat the checking of xheader when IA32_XFD[XTILEDATA] is set in amx_test
        https://github.com/kvm-x86/linux/commit/cabed3f958e9
[09/13] KVM: selftests: x86: Assert that XTILE is XSAVE-enabled
        https://github.com/kvm-x86/linux/commit/44217830267d
[10/13] KVM: selftests: x86: Assert that both XTILE{CFG,DATA} are XSAVE-enabled
        https://github.com/kvm-x86/linux/commit/7b328195c462
[11/13] KVM: selftests: x86: Remove redundant check that XSAVE is supported
        https://github.com/kvm-x86/linux/commit/08f63d826980
[12/13] KVM: selftests: x86: Check that the palette table exists before using it
        https://github.com/kvm-x86/linux/commit/7042ef575496
[13/13] KVM: selftests: x86: Check that XTILEDATA supports XFD
        https://github.com/kvm-x86/linux/commit/564435d346ff

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
