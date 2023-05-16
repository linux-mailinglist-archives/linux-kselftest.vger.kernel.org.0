Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAFC705B84
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 01:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjEPX4K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 19:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEPX4J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 19:56:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA855BD
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 16:56:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso536a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 16:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684281366; x=1686873366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTpjK4cMLE86CEBQAy0o7c1MtYlIewmfVg/CfBkzS8g=;
        b=S6BjV/lnZHhJsIdjUWkam5dY6C+mo1ieKbzG4UHHJfBP49QZq6QLvGuaPjGHLXxg/T
         2QagfQVirGsBg/WEz5YrT6PSrDAffE5c/5zcneGPlcQfp6acvCmYADqIKiJ/FMKfkli7
         W/TOL5WsLXPtrVzsCEwS76u2cllo0vfS7FRghu1qjn2qa86TDxkloHLOdW8YtVducYW+
         4LzQP8VLdDH9r59mpqDKgyoE8+N98u8OiBpf6tBCB/dnc2pOeAJcRTGxMHTWlrs6OFTM
         AVQcqOxRBEfW+4lavr1y5FtR31v5l2iTxXulaHqdpy3WEh02cuRJFKF1KpDuUZnmMcEk
         eoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684281366; x=1686873366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTpjK4cMLE86CEBQAy0o7c1MtYlIewmfVg/CfBkzS8g=;
        b=faSFk42oRgVMmjWWQhSh/FFw1e/zydS+CCaRqXX75kYxu9/hPblwXqSc85ctn2wDA5
         cR9oUQBN+PjdCxBCFHSv9fXEgiit6anDrDFggAD9sti7KkPbG0dZCYLwU1ij3SeId+X3
         aHRqdKqpcE7mfi7UoxpXLsWTGGirUABka09q6spGes29Su3lPaEuVHIJlDeWR2pW7ZDw
         mZfiXqcmRaZ0mOrq88xnBJfoAfrPfZq45f+/OGDsySFB6Moh+Sbhls+Gn1m+AJZj2GOt
         gk5oezdhoIPfn8pnC9DV+7d+MTvJANadTtENsTcG8PTgl5JyGzTj1ggrwwN3cuXNpGjA
         KpTg==
X-Gm-Message-State: AC+VfDx0OYmneO7gIG1eOPPugcWmN1d3lIvlFJrBWtbBgYdSr09zQMmk
        XIFZZvB30R4/3Rv4kFhhU3XLVQG73ftPR0crMMiXaw==
X-Google-Smtp-Source: ACHHUZ5ScDuPkH20J7HKHvZ0+VfHcTYMC1wGAQr7Rn/HstW93ubQaQWZPc77RY9AKiQO5HbaQBDv4cNtEDEtLylBffQ=
X-Received: by 2002:a50:8752:0:b0:50d:bb88:a80c with SMTP id
 18-20020a508752000000b0050dbb88a80cmr19046edv.3.1684281365993; Tue, 16 May
 2023 16:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-2-jeffxu@chromium.org>
 <6cb7df56-0479-30be-5389-b4b819572deb@intel.com>
In-Reply-To: <6cb7df56-0479-30be-5389-b4b819572deb@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 16:55:28 -0700
Message-ID: <CALmYWFszHvHa2_DqMPZcWkVqhAtKxrbpJ4Mzg+VWLnPHQD_fsw@mail.gmail.com>
Subject: Re: [PATCH 1/6] PKEY: Introduce PKEY_ENFORCE_API flag
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 16, 2023 at 4:14=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -20,7 +20,7 @@ int __execute_only_pkey(struct mm_struct *mm)
> >       /* Do we need to assign a pkey for mm's execute-only maps? */
> >       if (execute_only_pkey =3D=3D -1) {
> >               /* Go allocate one to use, which might fail */
> > -             execute_only_pkey =3D mm_pkey_alloc(mm);
> > +             execute_only_pkey =3D mm_pkey_alloc(mm, 0);
> >               if (execute_only_pkey < 0)
> >                       return -1;
> >               need_to_set_mm_pkey =3D true;
>
> In your threat model, what mechanism prevents the attacker from
> modifying executable mappings?
>
> I was trying to figure out if the implicit execute-only pkey should have
> the PKEY_ENFORCE_API bit set.  I think that in particular would probably
> cause some kind of ABI breakage, but it still reminded me that I have an
> incomplete picture of the threat model.
Yes. The main reason for not adding it now is the ABI breakage.
As a next step,  we could potentially develop mseal(), which fits more
to the code segment.
The PKEY_ENFORCE_API allows munmap(), so the user case is slightly differen=
t.

I will leave the threat model / V8 specific question to Stephan.
