Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F453505ED7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Apr 2022 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiDRUQN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 16:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiDRUQN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 16:16:13 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3C72E6B1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 13:13:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t15so8283692oie.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bCpvuooTMQFHb8fBAPBgClqkOF+kRRFnzjAvhAnIUI=;
        b=OWTlGQDNWs980Ym0XDdFMdsBJhP9HeAYgCAOahMB2uE+IG6fr2FeT+Fp+tELDQbtEv
         wn80c2ciI6JJJfzsdBDFB8Y8AxTVEoTWXZOed9qaGVM6m5scibLNaVII7JSTayS/XEq/
         aekc9iNLbKkreeFTnIRbp2tW4rAoQVstluUS04LGLEYZfvQws3Ct3MIol4jJM8oCs9Tz
         GuymAa1S7NY3wHtlktFKn8hIMnI+u67sEktIcOrqLMuEpXPVU2ZY3N4dLXBWlTEIrQ0U
         OH38BxiRKkxdJRIwFbPGRWsen0MaGtcQ/yzO+iEOBbtao/gLrGn4wyIz8hffNoCLxPx7
         rGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bCpvuooTMQFHb8fBAPBgClqkOF+kRRFnzjAvhAnIUI=;
        b=epEQsfB8mFiPzaK3tkxJs9xyoHxtHscZD9BvX70rLpPHAbtIXk/2+9RuwtxNeoTkaI
         wyH79gH/8z0CX0B5LUEPUUZ5jdqGT0RdRAK6dSodRZT8flulu7X3YqMfu3lgZR41Bk9Y
         4+3OYbXIaucmer3hLz1dWBmRr7l2l7QnYJZ4QXOF7kj/S4RXQ16ro6s8gaWD+OBxzc7s
         OQjgSyMvj+O80x2DW2GqhDjbvD2VkQhtdbr/z++vLWkWVBZNU33WPNp9zDRL7e9ItXae
         t7lZAcTeL55eR3JqwlQ7lViBP5yGbjY64OBWpnvnGVioXNlSpLcHH7Q/awL7AfGitaqV
         QMrQ==
X-Gm-Message-State: AOAM530m1Qga4QD+byhOFaxlolmMFYGLpxGfQD8In5RMLH0C954rFpbI
        8OOxwYFBblgD7PiRGKbSbGuWy50IMkRu7EpONBVspLXjQaN0bA==
X-Google-Smtp-Source: ABdhPJydPcLdynJb9dyw+0KvivU1+NK3qxSQNTgnfFlahabXUFTqteI9cKwcM5vSQ4rxqbrgw/byCEPS2u2RK9o26/o=
X-Received: by 2002:a05:6808:bc2:b0:2ec:e7f0:c11e with SMTP id
 o2-20020a0568080bc200b002ece7f0c11emr7794828oik.126.1650312811792; Mon, 18
 Apr 2022 13:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220218082428.11699-1-sj@kernel.org> <9a7f8d0b-3f0f-8584-6c12-423b0d5a979d@linuxfoundation.org>
 <CAJj2-QEcyO4NrfC7w2X0KA9uRKFhF=3hEf8sOr37EGY6xckUdA@mail.gmail.com>
In-Reply-To: <CAJj2-QEcyO4NrfC7w2X0KA9uRKFhF=3hEf8sOr37EGY6xckUdA@mail.gmail.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Mon, 18 Apr 2022 13:13:20 -0700
Message-ID: <CAJj2-QEjtM8L2vu5hGT6vWasuFXPDKEuW+Df7x10o4qT_dfmGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/damon: make selftests executable
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
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

> I don't recall why we decided to add the check in runner.sh - let's keep them
> consistent with the rest of the scripts. If we get rid of the check, we can
> make the change then.
>
> thanks,
> -- Shuah

It seems reasonable to add the x bit for these tests to be consistent with
the rest.

I also received an email from a patchwork-bot+linux-kselftest@kernel.org
telling me my patch series was included in shuah/linux-kselftest.git, but
that does not seem to be the case.
Is this a bug?

Sorry about the previous non-plain-text email. I never replied to anyone
before and didn't know what I was doing.

> Hello:
>
>
> This series was applied to shuah/linux-kselftest.git (next)
>
> by Jakub Kicinski <kuba@kernel.org>:
>
>
> On Fri, 18 Feb 2022 00:10:15 +0000 you wrote:
> > These patches fixes trivial errors with building
> > and running DAMON selftests.
> >
> > Yuanchu Xie (2):
> >   selftests/damon: add damon to selftests root Makefile
> >   selftests/damon: make selftests executable
> >
> > [...]
>
>
> Here is the summary with links:
>   - [1/2] selftests/damon: add damon to selftests root Makefile
>     (no matching commit)
>   - [2/2] selftests/damon: make selftests executable
>     https://git.kernel.org/shuah/linux-kselftest/c/1335648f0b6f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
