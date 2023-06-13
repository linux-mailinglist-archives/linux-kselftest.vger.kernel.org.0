Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2E72EFF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjFMXWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 19:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjFMXWw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 19:22:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98B31BE6
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 16:22:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565a33c35b1so1792117b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686698567; x=1689290567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYwd+D4Cb9qTpytZWzkgxnDLoRC1DHKyxU4tUMBIemU=;
        b=BJYiL8TcZs1Ebm49FgZbHWNW1374idz4WZmf8dHd/xHfsmacZVRq+6H7UrbeO7VMH4
         90JHDi6g+rRvUKE3Z54EofTaruSlGc/64/vKeYL9dY2jilM2GMmJFJNKhTRBHHcY9uRT
         +Sq0i+1PkfsaAhnEC6o2uzEZ2941c6hIFx82pVTq+UuPTS1v6Hw+2/t/YVQP6tewDu5d
         uwYykgZMMrJjEofVI2bzjgOlbDLNtXTTJ6ArqUNeDJ5GtDtKuROEBO74zVsUekF40i3w
         kR1Pgnof+w9vW3ZVKCnVOfO0E+DFZSbChVZe7fJrWsVr5DdlVcmvVb1gMKCKQVVUpUFe
         NMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686698567; x=1689290567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYwd+D4Cb9qTpytZWzkgxnDLoRC1DHKyxU4tUMBIemU=;
        b=BnmNRcJ6dZdfr0W7QJwI8/itsvMTpDerSP3ZkvXOF3saqksDNsoY3mpc2W/7ZcyD2B
         Vt6w7Zq+zf0+dJ3PibuMI8nfxhzMUGEEYfGixwaYWN/n0SQ1xZsI6vCag0Jd/mVVl+Qn
         6RRStIJqSFDumYdUIrUBvTeg4W6L2gDYbSoujC9nTdae6WuEbN1D5K3yTj+YlrNcxZo0
         nVSTtMMgS5MuhQMCpapC9SIpX1wzpuCygu7jI+lmLgSAU6s9M2E6JqXQuNxez4Y1mCH4
         bmi4FlV1DKoW/0EMDwlzGyLobM7Tu1bumiy0vdXiLgAVjue2BuELWG8zKeTgQvRnBU5d
         a+gQ==
X-Gm-Message-State: AC+VfDwDyA6m4+GHJ3RCohVZpBkv41Hs2uXBOuz2qQA6wrfnS1uGSHHW
        f1zFwz9kAYT3uz82eFmA75v0w4+BS4k=
X-Google-Smtp-Source: ACHHUZ4dfcJyKNqzLWwlR7WUr1Os6eFGZ4GJtJ2uWLUwXEpJIebEkmDNXEj5ETVTmyYehsyjLxnA6Zo1vo8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:c44c:0:b0:56d:3b4e:201b with SMTP id
 s12-20020a81c44c000000b0056d3b4e201bmr80300ywj.10.1686698567169; Tue, 13 Jun
 2023 16:22:47 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:22:24 -0700
In-Reply-To: <20230601080338.212942-1-yu.c.zhang@linux.intel.com>
Mime-Version: 1.0
References: <20230601080338.212942-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <168669238973.1996737.17411190747391186497.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Add new CFLAGS to generate dependency files
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        shuah@kernel.org, kvm@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 01 Jun 2023 16:03:38 +0800, Yu Zhang wrote:
> Add "-MD" in CFLAGS to generate dependency files. Currently, each
> time a header file is updated in KVM selftest, we will have to run
> "make clean && make" to rebuild the whole test suite. By adding new
> compiling flags and dependent rules in Makefile, we do not need to
> make clean && make each time a header file is updated.
> 
> 
> [...]

Applied to kvm-x86 selftests, thanks!  Hopefully second time is a charm ;-)

[1/1] KVM: selftests: Add new CFLAGS to generate dependency files
      https://github.com/kvm-x86/linux/commit/5ed19528db8d

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
