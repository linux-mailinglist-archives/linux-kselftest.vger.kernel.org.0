Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410BA5EB5CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIZXc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiIZXcz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 19:32:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB927A758
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Sep 2022 16:32:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q9so7893985pgq.8
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Sep 2022 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=h/2EKphffF4UXwNhYdd0utL+718PHKhRavdj7iu09cw=;
        b=FKfTngM1rz6fKUYtP/0lWPd7FszHHCkHwEAC+Xsv/I/5f1UcmzT2y7pfGHjG6cpZIA
         9bOd6Nj5NHgZjNevW5g8cr2G8MenrviL4ivU/JUdxitZbJ+5RHuX5hJr9F+uHvntxt8A
         b3e+BgYp8aY/UU97FPdr6itQkCzsSO8jxuGI8DR5cDdcwZ02X9HDTxialS3KEC0/kAYR
         1KyGf3P5lGLW+3pD/lwK90rhbxMFttSF5HmzqOhNJDr5BSuBsCRYZDJOxonQzdd0O6KU
         MsQR3mYxg/REoLo6s+ja4SzHq9OAUByMcBoBAbsqXzmtiXJgwVn55kGavTPJjRRLE7aX
         OH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=h/2EKphffF4UXwNhYdd0utL+718PHKhRavdj7iu09cw=;
        b=VzFdZO7W5TeFgNdPoY8HIh9OkdokSRn4p9kWlzUYheit+Ehv2oKed58c8Cv1nrJ3n0
         I98+QBVGP5rfsWUxhSOGT3Xz4bBAyFoSd97NnGeWaaG01ycs8fukg41ZAF0JcvNQ0Y4X
         Uqpgjxpwf0zMQMVCdGIR01jFm11dtyjSZS+xTvNkXXK+6hP7QE+sQPbBppGMbYtOG+Zn
         d6EUvZPlvhDTKK0AJwuhpXr5cE0hcWae8z3M2aPBexfc9gLSewYWDxSQNVIGGgWky485
         YtNGOW4Kf8dClTDR4jKOi7p41MWKDQcXcvYWbIT6LLxZAwHp4BMoadae+HjSqdpOHY7F
         mUYQ==
X-Gm-Message-State: ACrzQf2si+BvyYkmfzX7czEM5IK7UH9lcko1AYXLLgSop4Y+ekEbMvJT
        sOvdncdjNsatoSyMu4H/H97TXURIYHgT5JURFkmDAA==
X-Google-Smtp-Source: AMsMyM413kcA9No/7IjWkHZJrnnJ+ga+1jJysRduCAOS5LhFyLGvg+N4cqnOtdyUdhqYxPUQEhCd4/l69mwI1ixcA6Y=
X-Received: by 2002:a63:b4f:0:b0:439:cc64:50e6 with SMTP id
 a15-20020a630b4f000000b00439cc6450e6mr21467751pgl.483.1664235173927; Mon, 26
 Sep 2022 16:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-6-vannapurve@google.com> <YyuDcXT7siGcKi3d@google.com>
In-Reply-To: <YyuDcXT7siGcKi3d@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 26 Sep 2022 16:32:43 -0700
Message-ID: <CAGtprH800a_Gz6QVbnAVD7og4yimpRd6k_TziJy3z4x8o3x53Q@mail.gmail.com>
Subject: Re: [V2 PATCH 5/8] KVM: selftests: x86: delete svm_vmcall_test
To:     David Matlack <dmatlack@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 21, 2022 at 2:34 PM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Sep 15, 2022 at 12:04:45AM +0000, Vishal Annapurve wrote:
> > svm_vmcall_test is superseded by fix_hypercall_test.
>
> Please provide a more detailed description of why svm_vmcall_test is
> being dropped. e.g. What do you mean by "superseded" specifically?
>
> I ask because this will be helpful context for future readers of this
> commit. I also ask because it's not clear to me that fix_hypercall_test
> is a 1:1 replacement of svm_vmcall_test. e.g. svm_vmcall_test sets up an
> L2 while fix_hypercall_test just executes in L1.
>

You are right, I earlier wrongly interpreted it to be just testing
vmcall, but it also does vmcall from L2.
I will exclude this change in the next series.

> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> > --
> > 2.37.2.789.g6183377224-goog
> >
