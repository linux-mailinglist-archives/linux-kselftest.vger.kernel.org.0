Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD147B999B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 03:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbjJEBaK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 21:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjJEBaJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 21:30:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BFEE
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 18:30:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8188b718so5523467b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 18:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696469403; x=1697074203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqc981CBMLWk+FQW6EA7FJZRSQfVRhbIKI7MGCKnNEk=;
        b=T6h5sEE9DJdh1aGUjFcv1tEmbSk8YF6vXZMe+fIu4/y0nb3hXT9242HxPQJe+GaUvu
         F083OG5cxSbrvrk/Sx90Kx5XWNJdj9nCfGq5lrvvLjIzTf9O9GjIzIxotDa/E4MfiITA
         xnnXkAvudwSbQDhkvt3yFwnvzQLF0pwztwuqLYmF9HP8+mFMbgCgxpEA/z1N6mT+i1Si
         wI8Jh+1/OQgSxcmDY59N10sDegx/JUJP/HV+1Ts58jlh8aCyMgHPyUVHjw7aN9FrIp1Z
         hvWPxscALaRXQ398nwOXrcQhz7/NvKSH+8j4E3LNUcnodxchqSNvulRaDLMSKvpavAtt
         gb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696469403; x=1697074203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqc981CBMLWk+FQW6EA7FJZRSQfVRhbIKI7MGCKnNEk=;
        b=en5NaAMc7yN6Odtk2pZqspbSe/yvg/8DdyRChmHv1JlkCssOFg5YdQguoeBmp0Sbj/
         pzU3POQUgEUKEDQD2RvXNHRoTvBr7voycg9MaoKumwcq6jqO/W3daYbNPzAoxAjw9qfl
         PwU1Je2QwRJpAzeNOdqDY9Ja313SAJlzRWom2ae5Es2akOW1XODBZrB81StiL63IIybm
         HcDNUjQ5hkTdI6w5kBR5pr1j7XuwIaD9mWf5TRe0A73dvbHFGY4ry65UUOgsF+QD92R8
         BMNYDSnqZwcnp0ooeJdRYq8DrGVzvo4e9guvA80M/kn7sqmsziq7o5lCqQ0En+/FuDMs
         Edxg==
X-Gm-Message-State: AOJu0Ywu66oXGJZu//uzjsyCAwu8GQUvL2m06/oMblKocXt9KEuHZMui
        sOXkNaZvERQqwXzF1vpjutcsWynRa5o=
X-Google-Smtp-Source: AGHT+IFqbf0gkO9Qoa4YBFhqDgjc+6TQ/LCF7VPFui1r6bU6n9f4cTS1dfvkOaHDVedFUeqKKjsNdPOL4Qc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:431d:0:b0:59b:e684:3c76 with SMTP id
 q29-20020a81431d000000b0059be6843c76mr66748ywa.2.1696469403561; Wed, 04 Oct
 2023 18:30:03 -0700 (PDT)
Date:   Wed,  4 Oct 2023 18:29:23 -0700
In-Reply-To: <20230928001956.924301-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230928001956.924301-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169644980223.2754169.1786296654866171118.b4-ty@google.com>
Subject: Re: [PATCH 0/5] KVM: x86: Fix breakage in KVM_SET_XSAVE's ABI
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Sep 2023 17:19:51 -0700, Sean Christopherson wrote:
> Rework how KVM limits guest-unsupported xfeatures to effectively hide
> only when saving state for userspace (KVM_GET_XSAVE), i.e. to let userspace
> load all host-supported xfeatures (via KVM_SET_XSAVE) irrespective of
> what features have been exposed to the guest.
> 
> The effect on KVM_SET_XSAVE was knowingly done by commit ad856280ddea
> ("x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0"):
> 
> [...]

Applied to kvm-x86 fpu, even though there is still ongoing discussion.  I want
to get this exposure in -next sooner than later.  I'll keep this in its own
branch so it'll be easier to rewrite/discard if necessary.

[1/5] x86/fpu: Allow caller to constrain xfeatures when copying to uabi buffer
      https://github.com/kvm-x86/linux/commit/2d287ec65e79
[2/5] KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2}
      https://github.com/kvm-x86/linux/commit/27526efb5cff
[3/5] KVM: selftests: Touch relevant XSAVE state in guest for state test
      https://github.com/kvm-x86/linux/commit/ff0654c71fb6
[4/5] KVM: selftests: Load XSAVE state into untouched vCPU during state test
      https://github.com/kvm-x86/linux/commit/d7b8762ec4a3
[5/5] KVM: selftests: Force load all supported XSAVE state in state test
      https://github.com/kvm-x86/linux/commit/afb2c7e27a7f

--
https://github.com/kvm-x86/linux/tree/next
