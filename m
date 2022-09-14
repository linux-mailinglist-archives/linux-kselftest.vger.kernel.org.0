Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7391C5B8F25
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiINTJ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiINTJ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 15:09:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84DB82754
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 12:09:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so5906118pjo.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Vf0GqOOK3uEkXN9WNsKg2nCcJ7gEgVHu0tfubCGolLk=;
        b=Ix8wQG8P2YBtgMuYLRU2gZVvgfG/KvQdltCQJtYPe3r5Nw2RASFGCYjRlBE363g4Uq
         LBRcA+z6swJhD/p979NxWvW0gtGKcRoxyYeoVs0n9+dgeFCd10TJG4Qs+FDhubksdM4G
         44OOmlLoTGNzjI8X53X2M4UxQlVrwxh1eYRrZW/RHfyZxu4M5YOlR4bSELZPHPlEQyCj
         gEHni2QM+xiJzfsEK0UED68GE9ZfQoaxwt5/VnDKK2DcPzG2EKEPdvh5ZSVmAJIfkaMR
         FaycXB4gSxuQqBflbF2VfX4e9FiWR+KmGd8I49K4txy/xTIHr3+DairQNiYpIAyZOu1g
         lvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Vf0GqOOK3uEkXN9WNsKg2nCcJ7gEgVHu0tfubCGolLk=;
        b=lTuWXLA/3M9t9ZJqmLahRU8iA0YgbCbHbMhw7XgjpYvupdrdzZ2NOu/bxB1mZLsAN0
         RhfvjpL1f0HxMCe0efyzSSWyDugwxoOxp+JIPEa/jxKrWXPumwsdPxgfEhYCBoeoigW0
         JMpa3ZaBLmCDTy8KBVqByVIzjSMre2VvgqqTIk2qe3f5+FeJO8CoEeLpzf9qmMJgxMFB
         AT4EcDIS31T9ozfysiEt0YJb2ubo6Rwu9RE2OwEx9FfNRzFgsvpdN/Pi4EvbG7k0pwrp
         spTk+RZcgaCnLqfxrcRHwWBpQFSFg3MDDntVeIuFYlTsRY2YCdGxiM9fUAnFUfn5qHk/
         Zfbw==
X-Gm-Message-State: ACrzQf2LhFRqLGAqKWiR83E1c2Uc0gxOXV5whr/XE/hHoWkCnCKvifJt
        1JDae2WGvq7Yo/y9ZgOw3Wax5XXgbFQPSpfvx5auTQ==
X-Google-Smtp-Source: AMsMyM4Ala40C7jBkQ2I54dEklxAZPC8zv+v2oEl63bhkLcXaIOX+9pXi8KM9ZGWLSuVRjS6+nBHZJGan+C2gOXb0UM=
X-Received: by 2002:a17:90b:1d02:b0:203:2d73:8efb with SMTP id
 on2-20020a17090b1d0200b002032d738efbmr766863pjb.214.1663182564226; Wed, 14
 Sep 2022 12:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-2-vannapurve@google.com> <YxpaFfw4jbwwvEI6@google.com>
In-Reply-To: <YxpaFfw4jbwwvEI6@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Wed, 14 Sep 2022 12:09:13 -0700
Message-ID: <CAGtprH-3qyf4hn+J=G3RFtvYwDdH+Zd3deDnnCycobyyF1V30A@mail.gmail.com>
Subject: Re: [V1 PATCH 1/5] selftests: kvm: move common startup logic to kvm_util.c
To:     David Matlack <dmatlack@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>, drjones@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 8, 2022 at 2:09 PM David Matlack <dmatlack@google.com> wrote:
>
...
> >       print_skip("__NR_userfaultfd must be present for userfaultfd test");
> > -     return KSFT_SKIP;
>
> exit(KSFT_SKIP) to preserve the test behavior.

Ack, though this change should go away in the next series with common
selftest init using constructor attribute.

Regards,
Vishal
