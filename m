Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ABB69B533
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBQWEs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 17:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQWEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 17:04:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C345F252
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 14:04:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u2so1900781wrs.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 14:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cFO3DV470+NGJj/IZweUNO04rAsuRCnZaCote7lstUs=;
        b=CB8vEGuOcAxfRiPnS7ZUouUxUHYsgmY57COOoQ6rBiI5//bUWP07ysURjI1t/3m2Ye
         JmzZT7MO9nPE+akjzWxM513Jz3evYlKh1L6Anuc12P8tgYvQ8qZXhvSJHALp0ZlTLl0C
         8BKAAv7qZJfenUCNXrowkvJl1ewUjYzpUqbtHUzimK/gaaBwdEIQdZQkS2ZD+05aARhm
         Qc/Qmtg0XE1ZU/T43aNHvX3R7mnYIaOA2I4CphVHl3Zuct9SbFtb9RY82DSUSWBmrFO+
         h7A1A7oUmo88IVtdCFbto54zXECIU/c0l7fuFrEJZxwlzTXrb3wFcbHq6sZzIgn0APDP
         bsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFO3DV470+NGJj/IZweUNO04rAsuRCnZaCote7lstUs=;
        b=SIt7tmx8yy3WINOzQMv5DzzO49QtH3v4MV02JUHTnPZV3qRxNVPfoKXIuYbg8f3nlu
         63ucYg8xV6ScacpjNpW3Wwb8DF5esnVfkVCBRSaKg+1t6646nyfevErAzIB35PBwnuR2
         7utH/lvMsL8m7GyqW0kmtIoy3X6fIKg4brZcwwJQRNlmdEaufzbeCMdwak7Op/qr0BTr
         vvPmnyDPkqVw6eTLJ9CDqkeWDXkjqvctyvzbrz6qK3xPGb+RB1zcGnOd+4XJGUBLjfUB
         vpSTQoRIgWmJxBzalrnBm4QjZjUmt6nNaZillv/gitWjKaK4e2mAIf7tLX3/qShW9e3/
         Dmcg==
X-Gm-Message-State: AO0yUKX7Mi1x9T8p2h8qH49YSNZsJ+BYZ5IeOKrB9NvtnSxKtfcwGgWS
        bkQp5JnWwwQQDBY1NvnLqNFALneybqPwhmY5SJcQYA==
X-Google-Smtp-Source: AK7set+PpkDJ+DrM8hLJnDbpSrM13HnkBpytZ8jrm5/0MahuhoduBDt6imKQwWlC8cefBCvyMHJo/ifma8jHbR2HtqY=
X-Received: by 2002:a5d:640e:0:b0:2c4:dbc:8e34 with SMTP id
 z14-20020a5d640e000000b002c40dbc8e34mr229934wru.123.1676671484761; Fri, 17
 Feb 2023 14:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com>
In-Reply-To: <20230214184606.510551-1-mizhang@google.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Fri, 17 Feb 2023 22:04:33 +0000
Message-ID: <CAAAPnDF9qKq5+PpqjN+1g8=zn0tkQ=aPQupwM+gJiuSE12zb4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Overhauling amx_test
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 14, 2023 at 6:46 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> AMX architecture involves several entities such as xstate, XCR0,
> IA32_XFD. This series add several missing checks on top of the existing
> amx_test.
>
> v1 -> v2:
>  - Add a working xstate data structure suggested by seanjc.
>  - Split the checking of CR0.TS from the checking of XFD.
>  - Fix all the issues pointed by in review.
>
> v1:
> https://lore.kernel.org/all/20230110185823.1856951-1-mizhang@google.com/
>
> Mingwei Zhang (7):
>   KVM: selftests: x86: Fix an error in comment of amx_test
>   KVM: selftests: x86: Add a working xstate data structure
>   KVM: selftests: x86: Add check of CR0.TS in the #NM handler in
>     amx_test
>   KVM: selftests: Add the XFD check to IA32_XFD in #NM handler
>   KVM: selftests: Fix the checks to XFD_ERR using and operation
>   KVM: selftests: x86: Enable checking on xcomp_bv in amx_test
>   KVM: selftests: x86: Repeat the checking of xheader when
>     IA32_XFD[XTILEDATA] is set in amx_test
>
>  .../selftests/kvm/include/x86_64/processor.h  | 12 ++++
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 59 ++++++++++---------
>  2 files changed, 43 insertions(+), 28 deletions(-)
>
> --
> 2.39.1.581.gbfd45094c4-goog
>

Would you be open to adding my series to the end of this one?  That
way we have one series that's overhauling amx_test.

https://lore.kernel.org/kvm/20230217215959.1569092-1-aaronlewis@google.com/
