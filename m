Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B9C780299
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 02:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356569AbjHRAN2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 20:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356669AbjHRANC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 20:13:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F163AB8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 17:12:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6b66b41232so450022276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692317558; x=1692922358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyFiJQqm3tBP8SIgjl0Qxy1dqHuO5l6iiXEk26fSOc4=;
        b=yBibd7R2dj4+RzsCFfqr0OqrSTg7Rr9auo+WBM9mSRbr0xYuF2xKVvtg288gsZzSb+
         NrlatEmCvD3807EP08ZNMuXwSgXieiY7tQJvi+oOFcQxb6jdh9GtrHQF7wKrtGem9aTE
         1DR8ZdCB7omtmyoP7rLihcEeeozK8685rTkf2ziquxG7ef3oHigiacx7tWUc+7J9udJn
         b0S1XHADk4bVd96DYYQNuAPYzJs5ZI8xkd3ie0sLoiRyOCR0DGJoJaYL5aPn6/CmMu9u
         rbY/ZS7GQ+LTU/wZIuV6ASFXFAzePBmUirZ3YV10HzcmVjlm7/2nin5u+b1LSdF0o87F
         gh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317558; x=1692922358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyFiJQqm3tBP8SIgjl0Qxy1dqHuO5l6iiXEk26fSOc4=;
        b=SK6VPp5C3Jl+1BQyuy5RG1GNgxyycB4K2x7RKZ49dM6KVAOtkdaUiqiEuipo5Zz+Zo
         HXFpHBksw88K4AZOf6P0YTAaGbG5qV6jmd2fodKCZ8TCosKWoe8G7tn/cglK9zfREyNW
         BlIN0S6Pcv47bLAVlENPOcqcDslOBEC9VFwIo8X7JjmuxUxno648BeEM9KeR+9p3U9HY
         +PJQ6iNTUvqcdsqTcitFVMcPxL1AYqv0p9IFapKYDy3RCdJodltPq02dWePleBAPbfSB
         Kz00gBbjua1v77PxsIyWJiAhZqsEqzplnibRZCmMhtvnxaNGRhQNphDEn4wFCyAhcWhB
         aZVg==
X-Gm-Message-State: AOJu0YwXjAz40ZmaqLxDbQ5fsIKlXpfnTeB8prEn1Vr+3dbcxBiGLHgo
        QKjXjaUdKAubDu53px6G6g22uDfdotE=
X-Google-Smtp-Source: AGHT+IFhqT2eJ7lYeTsux9ANxyC3ZxYvL9QjB0dejnaAc0hXC7o0cJkL7/6251VeIJd1wBspfMiqFfCHAC8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ae9d:0:b0:d47:f09c:cc8e with SMTP id
 b29-20020a25ae9d000000b00d47f09ccc8emr13349ybj.10.1692317558148; Thu, 17 Aug
 2023 17:12:38 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:12:25 -0700
In-Reply-To: <20230810090945.16053-1-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230810090945.16053-1-cloudliang@tencent.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <169230522030.1327124.6232234563848769453.b4-ty@google.com>
Subject: Re: [PATCH v6 0/6] KVM: selftests: Improve PMU event filter settings
 and add test cases
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 10 Aug 2023 17:09:39 +0800, Jinrong Liang wrote:
> This patch series aims to improve the PMU event filter settings with a cleaner
> and more organized structure and adds several test cases related to PMU event
> filters.
> 
> These changes help to ensure that KVM's PMU event filter functions as expected
> in all supported use cases.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/6] KVM: selftests: Add x86 properties for Intel PMU in processor.h
      https://github.com/kvm-x86/linux/commit/cf6d80c0eb95
[2/6] KVM: selftests: Drop the return of remove_event()
      https://github.com/kvm-x86/linux/commit/c853be2265cc
[3/6] KVM: selftests: Introduce __kvm_pmu_event_filter to improved event filter settings
      https://github.com/kvm-x86/linux/commit/de527b1daf69
[4/6] KVM: selftests: Add test cases for unsupported PMU event filter input values
      https://github.com/kvm-x86/linux/commit/86ab6af8b96a
[5/6] KVM: selftests: Test if event filter meets expectations on fixed counters
      https://github.com/kvm-x86/linux/commit/d4e36166820a
[6/6] KVM: selftests: Test gp event filters don't affect fixed event filters
      https://github.com/kvm-x86/linux/commit/740d087e7fff

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
