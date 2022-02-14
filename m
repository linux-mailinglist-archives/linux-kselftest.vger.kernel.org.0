Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAA4B5A27
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiBNSpU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 13:45:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiBNSpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 13:45:20 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9626E4F1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 10:45:05 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id fy20so39163392ejc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vljzReEDh1YRn3bh+4c8BFvDCk/NtDbpZzL5W1vanqE=;
        b=XL4260/0arBY8YEOBJquYK+5YNZZIQPBcGOddojeTEnuSba3n59w5GJfEfQyss/3Zw
         mAX2in9deweYvQYM18ArHdIJ4XEKy8qK09l1WcYxT5AL7Rv3J3PEASBUTl4sXn6kh/28
         LuYY9AbmZVcIXxsvC0vqWFP7ys8yZobKaTDG5MFUfI03fVYETE/zpxpCuHTPgciXw3/V
         +nIDaPE0sTyNeTPV+Qdl3W3q74vZYeGdTyF1fLRYmpYECI1wzIqPubpQ5FnYQTHOfpXI
         KRwlCQ2oXusbXZlXJXYIg0GggbQeDR3KXlTZqJd6M9/Y3sILzwZvmAFWlVfdNV7olcNa
         O65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vljzReEDh1YRn3bh+4c8BFvDCk/NtDbpZzL5W1vanqE=;
        b=I4qdu1Hi0pF+yPYUPh+0crHkcbi/hb9BmOY86vZfGdXV9k96WIb1sDOc8R1gg5KfaC
         gb1BhTLiyGyfaiOwDNnyMydX98mjeuwvMQgJY2bJaLGpuGy0oE6q1/ft3g7seb+0/uC8
         SPAskxohA+vAvYGP/7NPrBgAINlLlo7oOE7sI5O0VYXh0dRgp0bVha24OanYPCOo1DY1
         gAyxFy+IBLkQMi4M7Id5E4KjmrRvj5EjBVEtxO/S2njF5F5qGCOu/OZv2OUEUD2FIC8X
         etI8dZ+LhCUXtpI/+stTyF0p5zTMl7BN232Uc0FkNm/7HPBBByGcGmsguO8HHBx5uPrM
         5v4A==
X-Gm-Message-State: AOAM533jgB6OyMHY47nrJLJMZHH+UzyH5yn0ACCH7aiX9mV0iViF9b2N
        HO7YItBO7+kO68+CO+sgCcIdHod/DMsnusuqRVL6RA==
X-Google-Smtp-Source: ABdhPJxwt4ksJQa5iyaD0GLiYzuZ2FR3dG1UMpKPN5HCP0Ndk0yKC3kvtKTfG3icmmGwwyhB5cy7bgXzJ62zEPbgZZ0=
X-Received: by 2002:a17:906:4fca:: with SMTP id i10mr103247ejw.542.1644864193577;
 Mon, 14 Feb 2022 10:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20220211094133.265066-1-ribalda@chromium.org> <20220211094133.265066-3-ribalda@chromium.org>
 <YgY1lzA20zyFcVi3@lahna> <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
 <YgaOS8BLz23k6JVq@lahna> <YgaPXhOr/lFny4IS@lahna> <CANiDSCs7M_hSb2njr50_d3z=cx=N9gWHzVe-HkpCV1Au8yVwOw@mail.gmail.com>
 <CAGS_qxp3OHFwK__wCHBGr9cMsLR=gfD2rhjejXcmFNJ276_ciw@mail.gmail.com> <Ygn1nPpPsM/DDqr1@lahna>
In-Reply-To: <Ygn1nPpPsM/DDqr1@lahna>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 14 Feb 2022 10:43:02 -0800
Message-ID: <CAGS_qxo7caqjJCwcOM1E9o8r-FsMpkULc1G8BdN1VEuN_-zz3g@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] thunderbolt: test: use NULL macros
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 13, 2022 at 10:24 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> > Mika, should I propose a patch that updates the test and adds a
> > drivers/thunderbolt/.kunitconfig with the above contents?
> >
> > Then it could be invoked as
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/thunderbolt
>
> Yes please :)

Sounds good! Sent out
https://lore.kernel.org/lkml/20220214184104.1710107-1-dlatypov@google.com/
