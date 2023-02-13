Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE79695019
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 19:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBMS7J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 13:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBMS7I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 13:59:08 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196C4C2C
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 10:58:42 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 81so5029971ybp.5
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 10:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sC5Aqs8Zx9KnYE6mc2FVfCuvY0HxXOcL8kz2uAMityk=;
        b=V46MGcuWl3FG8fgqKMwn7kH1WW09dtFEK1b5alAAvvIeT2dDpmVrGV3IcA7E+xaaUq
         4+FspjDYoTnE7NZmL6aEZRGu/RRjEjNrr7Gmv7AffjgRJgJ+22YWQ8z7n4nGvq8Gj5fl
         wn8TGX17LY6POKXC1aZ1GEuH057SP08eUZaOt/+mIIqej4M7ScfATlPi/N5iyw+KWt98
         dKo7vF6SVbpaxyqnDbnCgATD3DbL0kmwWee5i/JQNg7Birti9h9z47af4VH31h5vKn23
         W1x6mfF3mUu4gnAqQNdg2gstCLiLDwduhOMSPfYeddvqsXzrsqdKKRjodCRnG2t0KKBv
         SpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sC5Aqs8Zx9KnYE6mc2FVfCuvY0HxXOcL8kz2uAMityk=;
        b=FWpdTQWGZ/oTkACHYoaCV1AHO2diQBMmDRu883kjDOTcRjfiQmql0qcXfXZOVsbkUN
         QR5Cfo8C8seHt/Rd6/0fb8bOPJp+5T9+YXcUL+xj1SgwCGSNdeLqzFzbrxFC/wil4cuI
         +pAuqMUyVi6jb2QT/hbsu9Y6gNZyZnCOcimzcez1IONUdkulMXNr+I5uIpPHR57QE2af
         aOUPEPgfcgUp4TXoqkNN9HqBKv+PeRzSUbypNNm8mAXhcKRWndJqCQ0r5LM6NGANKPJh
         ZiChbsZLN2c/qOBTfTBzW6OZyNDP42+L0F7Q1ijAj2XPbxwyL3EnKnnfrBE4yTaCMQW8
         SugA==
X-Gm-Message-State: AO0yUKUCPKP8wXMXaSgaMzMpPzLPq3epiJacjt6ul/U2AE5BWFmnwj1L
        A+nvLcujSRZ22QvpPKyAnCYMql5OQceAeauEYnpOiwcZUEHodNS7
X-Google-Smtp-Source: AK7set92u7HjWSwWlNONIaamzQpCYwD4/vrcW9EncCbfcJza6KzxR1ziVRIWxtymCs+H2aP/nh+hhePZnAwN8YIHdco=
X-Received: by 2002:a25:1f89:0:b0:80b:5398:3aeb with SMTP id
 f131-20020a251f89000000b0080b53983aebmr2658539ybf.300.1676314713084; Mon, 13
 Feb 2023 10:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20230110185823.1856951-1-mizhang@google.com> <20230110185823.1856951-2-mizhang@google.com>
 <Y+L3HlFDRy+UiUSU@google.com>
In-Reply-To: <Y+L3HlFDRy+UiUSU@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 13 Feb 2023 10:57:56 -0800
Message-ID: <CAL715WL9V8d-jvxkSALKQsMTgwDoyG-zE0g2tKd7FxihUhVGTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: selftests: x86: Fix an error in comment of amx_test
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>
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

On Tue, Feb 7, 2023 at 5:13 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jan 10, 2023, Mingwei Zhang wrote:
> > After the execution of __tilerelease(), AMX component will be in INIT
> > state. Therefore, execution of xsavec saving the AMX state into memory will
>
> s/xsavec/XSAVEC
>
> > cause the XSTATE_BV[18] cleared in xheader. However, the XCOMP_BV[18] will
> > remain set. Fix the error in comment.
> >
> > Cc: Jim Mattson <jmattson@google.com>
> > Cc: Venkatesh Srinivas <venkateshs@google.com>
> > Cc: Aaron Lewis <aaronlewis@google.com>
> >
>
> No need for a blank line.

ack.
>
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  tools/testing/selftests/kvm/x86_64/amx_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> > index bd72c6eb3b67..16533949a189 100644
> > --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> > @@ -204,7 +204,7 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
> >       GUEST_SYNC(4);
> >       __tilerelease();
> >       GUEST_SYNC(5);
> > -     /* bit 18 not in the XCOMP_BV after xsavec() */
> > +     /* bit 18 not in the XSTATE_BV after xsavec() */
>
> I would rather overhaul the entire comment, e.g.
>
>         /* Verify XTILEDATA is not set in XSTATE_BV after XSAVEC */
>
> I had to look at the definition of XFEATURE_XTILEDATA to verify that yes, indeed,
> bit 18 is XTILEDATA.
>
> As for xsavec() vs. XSAVE, IIUC the clearing of XCOMP_BV[18] is a side effect of
> XSAVEC the instruction, not something extra done by xsavec() the function.

I see, that's why you asked me to use capital words.
>
> >       set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
> >       __xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
> >       GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
