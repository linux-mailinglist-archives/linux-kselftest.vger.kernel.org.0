Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91D69B741
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Feb 2023 01:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBRA6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 19:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBRA6P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 19:58:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8BFEB43
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 16:58:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q5-20020a17090a1b0500b00229ca6a4636so3171037pjq.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 16:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjXQxU0MTNlezU2eGAKfedmw+7iHhF9c4Ur7D8yHd+o=;
        b=KHqIhrEDQSsz66Prz1EANNc1398H2HOk82HkHJPGXy4CaKATL7pajs8GcY/bMqSLId
         +s2i6sGBOZb/zbZFAJNB1/UPdX76Y2B/cOiEtsCqhvGQuiz/rVOVCmj/OrqIxHEHaDki
         Uz9+uEMCed9ZkphZ5xU//eQd8rZJQa/i3GVUoMZeQC0HpoXqwr/GWPZ4iiOUrq1+MmAH
         HeX4p2f1PTr/W4jPO0PrFnrXlw8OXpilSG182D6WPwPhBVBh0oMuF2zWRaTYUDERQJ16
         Cwaka4JpbHg81gpRmfesX/hlbI+jGPhAE2tTL7b31Sx+ywDHiP+1d6PRrv1eIOrZHoUr
         9LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjXQxU0MTNlezU2eGAKfedmw+7iHhF9c4Ur7D8yHd+o=;
        b=slRVnPGVK7RRlwE+NNTyOtYYap6QGbdhY/UXTye1Ix7IN8blD+T2h4N/R+EjTwHP5G
         gwdHkA+hIi6CRIbUzBdGLkK4mWaXd6leYpihj7Ip6yG+6BgGpgJaVIn1AdkJgW+YrXE1
         /Zi7k1SP2RZIBjhwe+6IKz0lZ9Nav63ISnyZNa0TACDphngvo/C9zOeQUOBOEdqK0AzC
         vUCc6+S2Q2dI5w+eZrGqpUdQAcUDJgujCCsNx4mC9MSFJ2UOJYg4hUbvsqhpQTZy26Kg
         L8nwEr5RUBQfkcD826cwbg3xDZ+eR9uW8NkLxx/KjAJb5eLXNxHYySo4rout6CHJwfFG
         UCYA==
X-Gm-Message-State: AO0yUKU+UY1MQYUZVEZat9N7g39QBVOs7pafCLodJnxkk0/Hy2+p8U55
        lxMiDx5vSZcZiJtfJJ6eZ0TJOKU7uEenFCrMEy8=
X-Google-Smtp-Source: AK7set8E+2CThG5C4mr5NX+XGSjdAd+deenCdQbsgIaZS18SAZATQEGrR/qt5BA3BWpBzJoSiyfgPw==
X-Received: by 2002:a17:902:ce84:b0:19a:9880:1764 with SMTP id f4-20020a170902ce8400b0019a98801764mr2588533plg.59.1676681892880;
        Fri, 17 Feb 2023 16:58:12 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902ac9600b001963a178dfcsm3697533plr.244.2023.02.17.16.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 16:58:12 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:58:08 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Aaron Lewis <aaronlewis@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 0/7] Overhauling amx_test
Message-ID: <Y/AioE5iY4clmUIB@google.com>
References: <20230214184606.510551-1-mizhang@google.com>
 <CAAAPnDF9qKq5+PpqjN+1g8=zn0tkQ=aPQupwM+gJiuSE12zb4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAAPnDF9qKq5+PpqjN+1g8=zn0tkQ=aPQupwM+gJiuSE12zb4Q@mail.gmail.com>
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

On Fri, Feb 17, 2023, Aaron Lewis wrote:
> On Tue, Feb 14, 2023 at 6:46 PM Mingwei Zhang <mizhang@google.com> wrote:
> >
> > AMX architecture involves several entities such as xstate, XCR0,
> > IA32_XFD. This series add several missing checks on top of the existing
> > amx_test.
> >
> > v1 -> v2:
> >  - Add a working xstate data structure suggested by seanjc.
> >  - Split the checking of CR0.TS from the checking of XFD.
> >  - Fix all the issues pointed by in review.
> >
> > v1:
> > https://lore.kernel.org/all/20230110185823.1856951-1-mizhang@google.com/
> >
> > Mingwei Zhang (7):
> >   KVM: selftests: x86: Fix an error in comment of amx_test
> >   KVM: selftests: x86: Add a working xstate data structure
> >   KVM: selftests: x86: Add check of CR0.TS in the #NM handler in
> >     amx_test
> >   KVM: selftests: Add the XFD check to IA32_XFD in #NM handler
> >   KVM: selftests: Fix the checks to XFD_ERR using and operation
> >   KVM: selftests: x86: Enable checking on xcomp_bv in amx_test
> >   KVM: selftests: x86: Repeat the checking of xheader when
> >     IA32_XFD[XTILEDATA] is set in amx_test
> >
> >  .../selftests/kvm/include/x86_64/processor.h  | 12 ++++
> >  tools/testing/selftests/kvm/x86_64/amx_test.c | 59 ++++++++++---------
> >  2 files changed, 43 insertions(+), 28 deletions(-)
> >
> > --
> > 2.39.1.581.gbfd45094c4-goog
> >
> 
> Would you be open to adding my series to the end of this one?  That
> way we have one series that's overhauling amx_test.
> 
> https://lore.kernel.org/kvm/20230217215959.1569092-1-aaronlewis@google.com/

Sure, I will integrate your changes into this series.
