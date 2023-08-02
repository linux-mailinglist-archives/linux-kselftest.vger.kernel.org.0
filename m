Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7251176DA64
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHBWEy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjHBWEx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 18:04:53 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079421FF0
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 15:04:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bba5626342so2983075ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691013892; x=1691618692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3L++u9EqbCU4ZOlfdhCMgX3M04LeaNXIW3H7M8hugcY=;
        b=oxkpla1xmaEMJq7ReMkgKq/10/5JuSCX53MEyrss0daoRCpMtftcRCiIMKToqk2OSo
         3Q7Qmk9MlOrGKQpaYUjCHlmxbFtX0tXI5Kd5uftcQIq7BWNDQtgYweFAyXhqyLf7aYCi
         RJ/Pf6PJ59fi03ExFylkMS6nle0zRJw9LFiI10yUlQvgoOJKnq9QpXLxJAQJDvTsRBqt
         gl+JYhOBSYtmbJg0oxKlCst7AubddXpQyCtY6Sw6vPCyMG5vz95fgqRQCZ8GpHmgLRpt
         ZiznfJgH6E8UaB7ANK0BBCLOfZRo8m2FJuDFmUaoI2fOBjbeSNeNFZuF10VzWePldeqN
         /7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691013892; x=1691618692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3L++u9EqbCU4ZOlfdhCMgX3M04LeaNXIW3H7M8hugcY=;
        b=CTgS8lcn6+SogF0i3TeIGiE4aN3Xmrl2AbBxPx8u+4i1u0cNz9sqrK33/IGxKtzTff
         3qXpLNM9UqQPuuC+sjLZ90VZfGR2oqqszEi5kGm+8kkpuEXluwkEX1LFzTp2SKSR+6IN
         /2uDWx/RLytFjnAAZO6MHyJZJvbLKqLboGDQxoGWxHCgqnF1npV7BHh6Qv3hOlFq+upo
         Dah6rrl/BegTApXtuqqk6gB/q9B37nRllSOfv6vsRGE1ubtgafH1zkHBt7TnwPHevUn9
         FuclqX8vDPRMghubHxvKELvPbDlXfwl7ZjJq9up+oCQ0fMv7iZTTQtS/79pz7AqajJM5
         RVZg==
X-Gm-Message-State: ABy/qLbUpHHtjjkvnhK22gcckk2HkGa9kb0sCKAnzF0QCdZtyW9b2UB/
        N82AadDloGiAWXT6y13QczT8U6FZnVY=
X-Google-Smtp-Source: APBJJlHuUEUcQ4YT4c09eWMKZ89bpytuR2PPEP/5ikB/nJ2D/iOYGrKUYsS+s/nR5STs2XsjJelChZULcps=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2c8:b0:1bc:f6d:b2f1 with SMTP id
 n8-20020a170902d2c800b001bc0f6db2f1mr72209plc.5.1691013892602; Wed, 02 Aug
 2023 15:04:52 -0700 (PDT)
Date:   Wed,  2 Aug 2023 15:01:42 -0700
In-Reply-To: <20230712075910.22480-1-thuth@redhat.com>
Mime-Version: 1.0
References: <20230712075910.22480-1-thuth@redhat.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <169101245511.1754469.7852701829984104093.b4-ty@google.com>
Subject: Re: [PATCH 0/4] Use TAP in some more x86 KVM selftests
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 12 Jul 2023 09:59:06 +0200, Thomas Huth wrote:
> Here's a follow-up from my RFC series last year:
> 
>  https://lore.kernel.org/lkml/20221004093131.40392-1-thuth@redhat.com/T/
> 
> Basic idea of this series is now to use the kselftest_harness.h
> framework to get TAP output in the tests, so that it is easier
> for the user to see what is going on, and e.g. to be able to
> detect whether a certain test is part of the test binary or not
> (which is useful when tests get extended in the course of time).
> 
> [...]

Applied patch 1 to kvm-x86 selftests, thanks!

[1/4] KVM: selftests: Rename the ASSERT_EQ macro
      https://github.com/kvm-x86/linux/commit/6d85f51a1f08

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
