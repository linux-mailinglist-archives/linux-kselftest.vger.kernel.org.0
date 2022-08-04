Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398558A0B6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 20:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiHDSqA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Aug 2022 14:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbiHDSp6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Aug 2022 14:45:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D743140AB
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Aug 2022 11:45:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 123so452623ybv.7
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Aug 2022 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv+wsFrh4DdUVERLr5V/KNAtkHdf/ae8g7mRWoQV2vE=;
        b=fxkQU+2WZZjRVLr2eroyYKPm8AgKG3xp6FGuMxFlzJoag3W2VMzQxlONAnfvpzmo7A
         zEOBlh5AZWpF/ZDj6GEbZ3tjLUdZtpzayMZfofQ/acWOX8+OItwS8faaxhtd50Tn7huX
         YtHEEcoY0Mcg0mPQn977qxZ+QL2FuZI++O0PfuHxbldjX5ERnI5+f2zuLIO4mKHgWOvF
         vz39cdiHqTk/FGzOh7vbciLJ9a6m434ukZlslque7GoksIUaXqngFT3gU5viRICLpbT+
         1Sp5vQ+nPNEr4uyc+g/XSBLjkvqlv9Qz5FPHuKXcFw7dyEm2G0OarCx32/SHVqPpVcJ/
         OYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv+wsFrh4DdUVERLr5V/KNAtkHdf/ae8g7mRWoQV2vE=;
        b=HKK4kgeAQUR6/PGHVUlLWZIAKciEaTZXcG4d/yMYCVOgnY/u0bb/OJC1gXAyJO+la/
         EsXoYOx8XE3TtyVnrO8dd3NkbG4XSsewWDhXFgEPUdT96dHgOQvUk3SjsbpghsiInA9z
         FoGLcUcA4HuH7Ub6y12ikrHEwqxmgfZEWhHgR971wh5t3/dkJTM1+Ptb5SOslywVB5H2
         bOx843NH5g4K6MVk65oeHG83DmZGCHBOr+68Mt8Rwoweqqz5v+gHPJnIT//ZWTAo5k0f
         G72MYTvI2PnyfEfSKQP850xcuYvb6d46lRZ9J2uCzqOWnsWf9h1hcPY15c1ATBfNtQgW
         iGRQ==
X-Gm-Message-State: ACgBeo2TODGMpQqN8vdztO660xufAOjoP1Jv9syvoZxRHypgtRqhVtlS
        lt2Jdo6SSTVaNjqeUDvl+1bR57kgE/UzaC4rXynxJQ==
X-Google-Smtp-Source: AA6agR4uqEh3ACmlnwmuqh3zCaHN34o5K3HksL/9bk1AQobkkYCs30No26gdFLPAH1rvm4lKSxFg1rZsjRNvT9M1b2A=
X-Received: by 2002:a25:ab84:0:b0:671:748b:ffab with SMTP id
 v4-20020a25ab84000000b00671748bffabmr2283018ybi.427.1659638755187; Thu, 04
 Aug 2022 11:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <adel.abushaev@gmail.com> <20220803164045.3585187-1-adel.abushaev@gmail.com>
 <20220803164045.3585187-2-adel.abushaev@gmail.com> <Yuq9PMIfmX0UsYtL@lunn.ch>
 <4a757ba1-7b8e-6012-458e-217056eaee63@gmail.com> <Yuvl9uKX8z0dh5YY@lunn.ch>
 <7c42bf11-8a30-3220-9d52-34b46b68888f@gmail.com> <CANn89iJMCrLBbPPEnk2U7ja58AawCrDe01JmBStN9btBPQQgOQ@mail.gmail.com>
 <20220804110945.08c5d58b@kernel.org>
In-Reply-To: <20220804110945.08c5d58b@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 4 Aug 2022 11:45:44 -0700
Message-ID: <CANn89iKv1oLKwOi4USR+bGsWLuBGz+1EnAwz-pbodNsxp9JN5w@mail.gmail.com>
Subject: Re: [RFC net-next 1/6] net: Documentation on QUIC kernel Tx crypto.
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Adel Abouchaev <adel.abushaev@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
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

On Thu, Aug 4, 2022 at 11:09 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 4 Aug 2022 10:00:37 -0700 Eric Dumazet wrote:
> > On Thu, Aug 4, 2022 at 9:58 AM Adel Abouchaev <adel.abushaev@gmail.com> wrote:
> > > Looking at
> > > https://github.com/shemminger/iproute2/blob/main/misc/ss.c#L589 the ss.c
> > > still uses proc/.
> >
> > Only for legacy reasons.
>
> That but in all honesty also the fact that a proc file is pretty easy
> and self-describing while the historic netlink families are undocumented
> code salads.
>
> > ss -t for sure will use netlink first, then fallback to /proc
> >
> > New counters should use netlink, please.
>
> Just to be sure I'm not missing anything - we're talking about some
> new netlink, right? Is there an existing place for "overall prot family
> stats" over netlink today?

I thought we were speaking of dumping ULP info on a per UDP socket basis.

If this is about new SNMP counters, then sure, /proc is fine I guess.
