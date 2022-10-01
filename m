Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DBD5F1BC1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJAKPx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJAKPw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 06:15:52 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D325F2779;
        Sat,  1 Oct 2022 03:15:51 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j7so3315783ilu.7;
        Sat, 01 Oct 2022 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=v3jmQ7DCv9g/WfZvgKQuoM+JyWe/RALxTXqXXmTRJcw=;
        b=itlyK/xOtBscbHChDMf8oJBMM3nQXfc1oh9bugPhuoixkoCeUj3mv1F/iwFy8A9j9f
         UXzVIu8BUjMhNMJIuj2JSs8/Sur+kqy4DesmOBhOeXG+3Px0F4dPtoznM0ntdLTdqESX
         jUAW1iGDScDbRVfP+Dq3fnCCeU6xfnBUvGPuyMn5FvGEzLOoiQhQ/JXWi9HNhCqm6GiI
         5Nd5Iw5RrxOlAV1V9hajXRvBHsvxsgnk4ZWQ8uVjNMtera23Y3ZUPNdxVE2xGo0ZcYbe
         vj5WUmbLsZyfnfgii9dnhHw7VivBx4haecQcasS0Q1WLD4jrPoC5WSHyr0w+ZEUSdSRX
         okrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=v3jmQ7DCv9g/WfZvgKQuoM+JyWe/RALxTXqXXmTRJcw=;
        b=tzMpeIt/JCnfY2JKqLatrbhGQQfszPIoQiHSwVSHbL32jkyPRfqjUr/UueGzuxjdmn
         N5mur3DydShbsuXhQvnulbUI4q8DgVT9RV6YtB+hiIJKNU/ZKcWH2EUWcU9kcWMHKgCX
         pFzNpoDhjy20qCqS/74/VW2rn4R0D4u3kHFsFbMDnFeUufagZG196rguGyeTnOyL8HmH
         KnqMx6YYTAcf77RwG5TRMLw3W4Y4ei8JQNGlZ722mLXMEmAAu8LqTywUPpJuwdX0ZZi2
         qsf31cVvsa6sF+VoR/Ahk6DteYXtUwhV10XgY6pzbLKHLzmOjYTagzkKSkzMQZHKKZVW
         bBIw==
X-Gm-Message-State: ACrzQf05qf4dcJ3ORlMjq44xRoLDbQX3SiTMKT/6q9mcXwDioHzUdrRK
        PDWbjBhlK3++98/TcflNUxfnnBClSfuaYg4+YTXcABoHb8s=
X-Google-Smtp-Source: AMsMyM7JcJ2YuNOCFulk6lhwAK381yUMJPpSObWnWw3uFqo1rMJT/tLjTz+kLStBqYXBLixR/BV/CCrlljIXGXgnCrc=
X-Received: by 2002:a05:6e02:1caf:b0:2f2:1639:63a0 with SMTP id
 x15-20020a056e021caf00b002f2163963a0mr5866167ill.5.1664619350700; Sat, 01 Oct
 2022 03:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com>
In-Reply-To: <20221001002638.2881842-1-dlatypov@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Oct 2022 12:15:39 +0200
Message-ID: <CANiq72nU-eDOT94q26dTVgCFA_Hs1cGiLpDCmQ5n-cCVKAcsqQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] kunit: more assertion reworking
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 1, 2022 at 2:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Note: this does change the function signature of
> kunit_do_failed_assertion, so we'd need to update the rust wrapper in
> https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/kunit.rs,
> but hopefully it's just a simple change, e.g. maybe just like:

Yeah, should be simple. Thanks for pointing it out!

The series looks like a great cleanup on top of the stack reduction.

Cheers,
Miguel
