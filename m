Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0DC52FA56
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiEUJc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbiEUJc2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 05:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B7969CEE
        for <linux-kselftest@vger.kernel.org>; Sat, 21 May 2022 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653125545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lvxdXwOHitcBIpGs6wIQPCxkxQb56H4Xqa134ITbFFo=;
        b=KjPKvMT4/JKDHwt1VaWIOxUUl/giI3sEMf7IUIZu4IsrS14OXDBrMCxzEkltqub5d5IQlj
        8FJ/BLd8aXXXyBBmcOzlUxPoJF4oYraPitH0SRI/pEbLyoIs5+OEbJgcs12FFQ+mKRWPVb
        i9DzpE3JJ2987DPL+e2I9QaI1NHnFBA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-8bO_fNkHPYStxkFJdY0KQA-1; Sat, 21 May 2022 05:32:24 -0400
X-MC-Unique: 8bO_fNkHPYStxkFJdY0KQA-1
Received: by mail-pf1-f198.google.com with SMTP id cw22-20020a056a00451600b0050e09a0c53aso4828855pfb.2
        for <linux-kselftest@vger.kernel.org>; Sat, 21 May 2022 02:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvxdXwOHitcBIpGs6wIQPCxkxQb56H4Xqa134ITbFFo=;
        b=zDUmzEYfk8qsCIt6atdUzDnS34hJN27aNguy4plyZfwFPB/w8s35EmsyohV5auhqHy
         4x4Dl5Y+k9ZqIYhqWCcihrEsK2+6Wk8baubKu69Q/xvqPoxzHJuHoQg/LOy2coaC4CtK
         fkXN76vgUX+xkNTktT/RS1dFrsD4j0M9ZupyAeXwj+soU5doCw/LElyRazhJVuQADPYO
         ytvpC77gmRQRaCUmOZ1n0fJAglMLl6DtlFOmzzRVTUKbAYJ3RhmGX+7XwBsrSWgCVwvm
         Ae6+KgfGn0EXP3cE+zoXWMXRSk6xiOq8OiqgT3tg3SF5KQy18iZ/pkccvuX0648xCvuD
         adlg==
X-Gm-Message-State: AOAM533M1Sd779NSa5dUhV1FOyLYvdlkwr91hijuVEM4LDvi682TTUYu
        AhhirKNge62y0oNvwh6tw5CVpCdzpExljtwIwFRVxbWokL0/S9WrCdAs6LhMHLydtacUFq0Myb9
        ocDSBAnZ9hMnaIzDEI2m22fpt5VSranqGJwGAifwhZ9oB
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id m2-20020a17090ade0200b001df3f94811cmr15866276pjv.112.1653125543200;
        Sat, 21 May 2022 02:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZSU2qJUc3vst7EcYhkZxGtYX1NO9nd4dXQIH+kq11dwaVfU8QzctRDQMSoJsmOb3HNifMH180iKdF5vsCY3w=
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id
 m2-20020a17090ade0200b001df3f94811cmr15866253pjv.112.1653125542902; Sat, 21
 May 2022 02:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220521093017.148149-1-usama.anjum@collabora.com>
In-Reply-To: <20220521093017.148149-1-usama.anjum@collabora.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Sat, 21 May 2022 11:32:11 +0200
Message-ID: <CABgObfauKbK5oepM49CKH4yJ3mBVzYTtLD8ycsobtmxTtgMCqA@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: correct the renamed test name in .gitignore
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Yang Weijiang <weijiang.yang@intel.com>, kernel@collabora.com,
        kvm <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 21, 2022 at 11:31 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Correct the vmx_pmu_caps_test test name from vmx_pmu_msrs_test in
> .gitignore file.
>
> Fixes: dc8a9febbab0 ("KVM: selftests: x86: Fix test failure on arch lbr capable platforms")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Hi, this is fixed already.

Paolo

