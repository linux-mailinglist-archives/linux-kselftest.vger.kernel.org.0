Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8446C532A7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiEXMhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiEXMhd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 08:37:33 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C847CDE4;
        Tue, 24 May 2022 05:37:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b11so11731675ilr.4;
        Tue, 24 May 2022 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bps4cmkybJsHRmRlI++Mv8ODqq/5urK8odTvzVNolmA=;
        b=e0fdNFlNobC9meMTY2tqK4IbmCtYFV1mCtQ1DcYDG4m7aZU4g7eEFGWyuJzxi2r8Or
         4RLeO0Qw9wd3WrAFWglyNG2QPOJzybqaTGjOzvNwCS5KesqhcdrcImV2/XraMu/quyOu
         QHtsDwXoS2XoWTzZedQfQW/lwuxFphsCU2co88GyO00wjYTFMI8FqVL8WRyIfoa22uJ5
         tdoFNpYxuX2jClpfKZyL8tHDo6TLN5o2Y3Sa9kIjkySPtQsyNDqjGPzzS6IR8xD6v1W9
         0JMkanhvuygpeNfDkE+TRqOVkDidnmfPk71OvI+2giHnMkM2JpqRut5NVOq3P+h4OBKP
         CKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bps4cmkybJsHRmRlI++Mv8ODqq/5urK8odTvzVNolmA=;
        b=48yKLBF9YgBZ/x1RKkfbNfanZ+E+HXYeB2v6y/3nG1N380DSgn5zAXIk1ZPJqFC6iW
         l9N4zh5i2RI5GJz1AAQ2WIPSDrp3seavux4Sua9wVUJRhwxrIUh/Qi7CCEOxjoqehI7/
         C2PW/z8JSdxlLelKqWVisIQ1Ap3/lDfZlCpUxli42gESGtppfTnlDVcY6vJ+wD2EWiXC
         MD/IW8eTR4aPqJjZSbi/puxU2KcoUshSLqqduOh1DzubDqBLgoOCvdl3v+oyi3SecplM
         +1iMq9cL0/wIYkRubm+nXqEbE2aUGQp07nayt0zcU2dRnc54xErf4Z8flRRb4h7ikZvz
         wH9A==
X-Gm-Message-State: AOAM532tykuxMUVEtGKqbjZYl4WkPJHPjUsqN6+1i/oKVAXROi+qWehU
        4Li7Vvh/hGRYbFOqxAr6qYdbWf59Dnm3T+wiXP8=
X-Google-Smtp-Source: ABdhPJzPSsaN2n2ThbOTzd3bvk07uDC1td5gweg9633ahnWCW6j1+5Gx6f+IU02U2Z+3jxzuxSo1w5yIBAg+n0VoiXo=
X-Received: by 2002:a05:6e02:18c8:b0:2d1:93c7:33c2 with SMTP id
 s8-20020a056e0218c800b002d193c733c2mr7315041ilu.151.1653395850193; Tue, 24
 May 2022 05:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-5-ojeda@kernel.org>
 <CAGS_qxrW+GpDpD7-jxyGaPtQUzBGTdR7N=_7FRR0KdoJCshAAA@mail.gmail.com> <23e4e7b4-bd09-b186-093b-a436ee9cb649@linuxfoundation.org>
In-Reply-To: <23e4e7b4-bd09-b186-093b-a436ee9cb649@linuxfoundation.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 24 May 2022 14:37:19 +0200
Message-ID: <CANiq72mPPVaqpsFc8UK92Ur0utn-Fd80XWtCPq+AmW9ZTWh1oA@mail.gmail.com>
Subject: Re: [PATCH v7 04/25] kunit: take `kunit_assert` as `const`
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 23, 2022 at 8:14 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/23/22 11:15 AM, Daniel Latypov wrote:
> >
> > FYI, we'd asked Shuah to pick this patch up in her "kunit" branch.
> > It's applied here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=7466886b400b1904ce30fa311904849e314a2cf4
> >
> > It had previously seemed unclear if this series could make it for the
> > 5.19 merge window (but it now looks like there's interest in trying it
> > out early on).
>
> I am just about send pull request with this patch included.

Thank you, Daniel and Shuah!

Cheers,
Miguel
