Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC7769FB6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 19:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjBVSl7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 13:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjBVSle (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 13:41:34 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723742BFE
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:41:03 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536b7ffdd34so132926007b3.6
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7EPVFCA8zq4soZ+RzbgO2c4Vrmh93Mahl0HGb6+1hVw=;
        b=ITBKevfktviDnwoblHkeG2k5hgP7j1Pp557a3hRBGd+T1OxXVsckbs940zqZpOye38
         G42rQ+t1c8Zht27mH4GkPF84adsHQQXjT0yYFyAjQwyqc1Hjgdg90bTmtwzQBifJlO/4
         h0sDqg7nsg3EKE3mH8rgftzSGWUCdjy4pi8DcIUK9/3cZN5Shp4WWHqZHkZ+UtVv59hX
         fzntUwGXC+cGndEewlvGOr4ciKaqCqQI37GnaCuyiStZQ/27yQE+85Xd8euCwPhZO/B/
         6v2Vgl3PylWMN6XBb9ReNRJG4+tCBnLOckb5XYBM90c3AsZc2irt7xlCuTSZgl+rJfGt
         0xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EPVFCA8zq4soZ+RzbgO2c4Vrmh93Mahl0HGb6+1hVw=;
        b=FUpQoEv0D7JjOUBV8SsFBvoaZu7JNN5UIqTuhq0UB1ySHAoGdEK2JrOAtQEuTgRy3O
         2M+f/JSG7YU0e5Ac707UkJShkmmyjaCZJSePGLQIHo+/X/HQDQvKIaeRMu9+9cjhNC/Y
         Nd4vE1Q7RJAGwRv0WPzXauQZaID4UtI0wEt81ucUCJJNGur1jM9zyTpuDsskExhdFW90
         UoWXXNMJ1nfQqBfFAGgNTktjwwooEog+5E21hlVZX/0+vSWbAmLdPIR5zgQ8x+9xcoC5
         iHhcl4++oea2oOFp9nJr5wIuZQfzjrxeKd2q1/c4ZLhCMeEx7DCAr6gwa58mFfP4sqta
         wGcA==
X-Gm-Message-State: AO0yUKUvEBuislc4c5l+kl4iN+giVL0F4BURkTnbmeWHcphfop3w5Erw
        M+X1KMQ43EPAPudoP2fuycbYE0cshVCF1/a5T21iug==
X-Google-Smtp-Source: AK7set8vXpAXFVP3ZNyo2CNseXHZW++5pI6rX5j5OntCGhDRcBYHgU4ykE2BwD8kBTuYFcxRZC63gQbBIPMVVlQhY5A=
X-Received: by 2002:a25:fe02:0:b0:a14:b73e:dcdc with SMTP id
 k2-20020a25fe02000000b00a14b73edcdcmr357601ybe.135.1677091248234; Wed, 22 Feb
 2023 10:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <20230221163655.920289-2-mizhang@google.com>
 <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com> <87ilfum6xh.ffs@tglx>
In-Reply-To: <87ilfum6xh.ffs@tglx>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Wed, 22 Feb 2023 10:40:12 -0800
Message-ID: <CAL715WKLQxxeyFqiKbKsUmQ8bZf2f=rwADyKj1ftgROA+dhpXg@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
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

> > We have this [1]:
> >
> >       if (fpu_state_size_dynamic())
> >               mask &= (header.xfeatures | xinit->header.xcomp_bv);
> >
> > If header.xfeatures[18] = 0 then mask[18] = 0 because
> > xinit->header.xcomp_bv[18] = 0. Then, it won't hit that code. So, I'm
> > confused about the problem that you described here.
>
> Read the suggested changelog I wrote in my reply to Mingwei.
>
> TLDR:
>
>         xsave.header.xfeatures[18] = 1
>         xinit.header.xfeatures[18] = 0
>     ->  mask[18] = 1
>     ->  __raw_xsave_addr(xsave, 18)     <- Success
>     ->  __raw_xsave_addr(xinit, 18)     <- WARN
>
> Thanks,
>
>         tglx

Hi Thomas,

Thanks for the review and I will provide the next version separately
from the series, since this one is independent from the rest.

Chang: to reproduce this issue, you can simply run the amx_test in the
kvm selftest directory.

Thanks.
-Mingwei
