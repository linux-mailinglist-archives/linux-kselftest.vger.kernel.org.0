Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17E297760
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbgJWS4d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464852AbgJWS4d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 14:56:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D08C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 11:56:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m11so2256106otk.13
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoT3yWOrSBsazr0sI34MLouxI66P/1yaiC+BUbvBhVc=;
        b=EJJbzOU5YcXKkZkJyjL044nb3GvCvkwsMdiMk8c6ng9UPQusWKKAKoYX1hw1D3P0+0
         XVpiXrnDohOvhglPaqqPDAf79YnzuWImu40KRK7Gxr8SIVczB6bo/S3Tg2+ubugJAc04
         BIuaRzNEU/5rrO3ph+ep/ia/bOck5Hth07qBG5GVBDWX5cmBO2H9cD/pt+4ZYT2ygyY0
         1ash+G4niL3BBnn5ekGYwJKc8HunAjw3UsdpiNHcgfW7T/9f+P4DUB5yNEqtZt3Ik53t
         zAN2Hhf3YhU0S1HAGyXw/4pz+UCDUHz3wbf65y+SwiujWN7058OFstD+XJs4AOk6s7sv
         YFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoT3yWOrSBsazr0sI34MLouxI66P/1yaiC+BUbvBhVc=;
        b=foFAmz98HpWD9YD3pQn8j8csHvOAr8bIDlMo4tQPrq+xI+Ps6lLSI0O3FYatT7mLSk
         69NKwfk6SjyeK1ZyWCsUXWfJl0GFfNsRXEA1NHrtoRBTLKvWOMeEZx3Fz0On+qwCyyT4
         HPA63fISUXGyI/yDLKGjDjxXRwTCt5QP6a6dKX5UvKMXSB+Y5sPQD6eCIFpUAG3xgmtx
         K8PjaGBEoxR9ROFvpRSTmBaI645lU+/ZCggQoLN67Ly06fbilh3shkltmPfKUOIg3J2P
         ErwNLt8JQ2QKJYlIYJuOgdOtyOyHOAGDI6D+U9poBlTnJBxvLpH/F/CZbyHBptHjBty5
         d6Uw==
X-Gm-Message-State: AOAM532bB5zf92gtMpKYI15hDvc+kUHQNsbL295reyUSqVgtIdekKIRu
        +O6kQ2uawUFfJcEiAPqKIMP3lRW6ZjN64ZAkRymbyg==
X-Google-Smtp-Source: ABdhPJzFo5v/hylmtjASbZpKKqG6nIfUwnRCajjhbZC/oESvTnYj2dsxSOQTw28NTqX+RyCiwVUyxDujQaimXgp7b9U=
X-Received: by 2002:a9d:34d:: with SMTP id 71mr2539238otv.251.1603479392382;
 Fri, 23 Oct 2020 11:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201023150536.282568-1-98.arpi@gmail.com> <20201023184803.GA3922681@elver.google.com>
In-Reply-To: <20201023184803.GA3922681@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 23 Oct 2020 20:56:20 +0200
Message-ID: <CANpmjNNdh=FmbC5ML7=gDOcdUsfUdsg6hgXeva4emdFKGPyjog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 23 Oct 2020 at 20:48, Marco Elver <elver@google.com> wrote:
[...]
> > + */
> > +static inline void *kunit_param_generator_helper(struct kunit *test,
>
> I don't think this needs to be inline, but see my other suggestion
> below, which might make this function obsolete.

Ah sorry, it's in a header so we might get complaints if it's not
inline. But in any case, if you use the KUNIT_ARRAY_PARAM() macro I
proposed, this function will become obsolete.

Thanks,
-- Marco
