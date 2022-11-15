Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A262A3AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 22:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiKOVDy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 16:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKOVDx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 16:03:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C424F34
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 13:03:53 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p8so26401930lfu.11
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XN/JoD1Jkh5RiwHD+lQjGD3lA2y98OeJdmQsFCxCuyA=;
        b=YC7UsN5xOK3nqbxoyurBd6rrth0X426lMlB7j8sex1g/gGjk9AeOVRXplLiix8pquB
         Q0WinLExp7O5/KaHgxOxOrIqphur4o5c+BO/gpIY4qLkabHcGVRf3vXIXzWL2fyeB32K
         y5mKhjfvgmCCxcvTgqHjrRZQvb+tJmH8x0MmzvYhUjYuuhLpWkgCe+VJfmzbkzpQRuS/
         pfoWsWXMD/9Jd2NFvZ9zhlPhWDXK+CH989ra/XOO34rLN9DPjHMYypKc4No+xzhaYUEi
         HXIoVQt7yBmUToOg8c1PSeeinfq3A4bTI72KM1vNTPamZY/EhbkYWXLelBNm1d7cjIpt
         lw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XN/JoD1Jkh5RiwHD+lQjGD3lA2y98OeJdmQsFCxCuyA=;
        b=famUQzivyCkLUPWYBrf2VjHjrgJLUKmIoW6+ldoB62B9WB/xF0A6G49U28NX8oAOkj
         OyWsyRPrcJ8KYm/5kOuwmD5BOYykcMqGdts005QulSKfehY1+IDDmVroBrOpdFoiKcPq
         bNewAStyWKlWbCse4EOdopXu01w+GrfUTXrHvSRojxZMVEWN05hkEHAzyq9/UyuhBW2T
         LstajpZ6chrcXrlUWdz99lrxd0cckRRkKDYJAkv/fd2yEmqblZD8/zvH8PoZ151OBFNn
         vv1Ze/2E2ySlgEiuBvVM2jwHYKI/JOP0Ms6lfMk9oq/RQLcEwQRqG2TH1Pcd4Y/Smp+5
         gY0g==
X-Gm-Message-State: ANoB5pnugC9UedBNYyBalcQcKXJeOxmTJ0RZxtFsr3lq9cM5DH4uUFbn
        HNgtIFrWYrAuZVIIZtr2M2ke7HDFq26mFV3skxs9jA==
X-Google-Smtp-Source: AA0mqf5h/MrxXfn9SLFayYGdwbJTkogFj7iMO7hUREB7Wsjo9WV5llZFJPBWslWVyPzAU5FhF+cFETW9exE+uGEBiKI=
X-Received: by 2002:a05:6512:2033:b0:4b0:8a8f:8e28 with SMTP id
 s19-20020a056512203300b004b08a8f8e28mr5782626lfs.682.1668546231091; Tue, 15
 Nov 2022 13:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20221013121319.994170-1-vannapurve@google.com> <20221013121319.994170-2-vannapurve@google.com>
In-Reply-To: <20221013121319.994170-2-vannapurve@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 15 Nov 2022 14:03:39 -0700
Message-ID: <CAMkAt6rEWm3x3nqcss4R9Dzar55=P6EazmD0J-kq+HEs5qT9QQ@mail.gmail.com>
Subject: Re: [V3 PATCH 1/4] KVM: selftests: move common startup logic to kvm_util.c
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com, Andrew Jones <andrew.jones@linux.dev>
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

On Thu, Oct 13, 2022 at 6:13 AM Vishal Annapurve <vannapurve@google.com> wrote:
>
> Consolidate common startup logic in one place by implementing a single
> setup function with __attribute((constructor)) for all selftests within
> kvm_util.c.
>
> This allows moving logic like:
>         /* Tell stdout not to buffer its content */
>         setbuf(stdout, NULL);
> to a single file for all selftests.
>
> This will also allow any required setup at entry in future to be done in
> common main function.
>
> More context is discussed at:
> https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

Reviewed-by: Peter Gonda <pgonda@google.com>
