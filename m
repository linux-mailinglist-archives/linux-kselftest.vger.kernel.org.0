Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CA5394D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbiEaQPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbiEaQP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 12:15:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395495DCE
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 09:15:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q1so11148390ejz.9
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc6gvDu/qCvsuozChw2iy5NBV+S2vwfP2USSk50VMaI=;
        b=XFtuth3C72V67k3+fMSyhH1pmrbg8CevCXU8dXJ6Sm9JEFBuS1Dkcz8LaMSZsOzAuT
         Ys0IC+HnBqxy6ybSR5QEb0dWYLiwBSVV8QU08XP8+TnbDSyRNAPUGi7wgIGbJBSBNJ4C
         scvA3/xgUHBhIDZsTdb2SJQ+ff8W8Kf9lb4UMttoqY5sWjBA1+jUduOYmAwmpnyP19yd
         /6Fkqxsi251mNBs0UuieKMGyu/NYsuxv6lEIK0DcMIvzwSF1d+yq5xPBB0j5RavmSJkr
         YekkVFqKM3x2MrjMyac/hk3VbdUScyPcDQMfdqfanZ/sOWp89bKNtD69kjkwYB82kN+z
         aptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc6gvDu/qCvsuozChw2iy5NBV+S2vwfP2USSk50VMaI=;
        b=OeR6mVld/6KbKJhkq+3c8y640XC7ZhXTY/CF0bzU6JfhNnW9iM54HJj/s8yJyCfjk7
         GefbCl74JgdG+G8yGvkVTw/Y6nSCZ6XG3tPIkxY3AgxjWBQOe7kGgmOEcNxwwsawDNDZ
         OCEc9GV2aUtVAdmnakaV4YznQsClqaTQ5cOegoQWHJtgv+DmobP3s0X7UXWGY61ZIeo8
         e7EBm8YvCAzlDSEGBrihNpnANzDiEWSnLbTe1o1adq6B97DZNip0cQuMPVWrf9DMTLuj
         QA3okxjCvae4VgRK3g+YS1QwIaW86LWxzaLAkjldON/p6MypetMY1H7Nzbd9HmHi2bTS
         1qIg==
X-Gm-Message-State: AOAM531I+Kcz/fjilYevHNLxht17UTwM6i8LeM2w2CHiVfhR6OVoRmtz
        Zu2nHH8/GrOj7QSZz7PWF8LGuOnbllhT8ih60+rgLS59p0Tpcg==
X-Google-Smtp-Source: ABdhPJwN17Hgc+ppJgUO4HXW0nH1ejUJ/8liIf3QjlGw/tzvqb5Qe2xK9aZnyTAB6QbJpR0wXNNZx7uvqSI7I3Vj8gA=
X-Received: by 2002:a17:906:7953:b0:6fe:dcc0:356f with SMTP id
 l19-20020a170906795300b006fedcc0356fmr39943846ejo.75.1654013722984; Tue, 31
 May 2022 09:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220530133133.1931716-1-sashal@kernel.org> <20220530133133.1931716-89-sashal@kernel.org>
In-Reply-To: <20220530133133.1931716-89-sashal@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 31 May 2022 09:15:11 -0700
Message-ID: <CAGS_qxrtZBrpk8x64oj53o4EEUCgTj1c4D12W+6UNArQfiiXaQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.17 089/135] kunit: bail out of test filtering
 logic quicker if OOM
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Mon, May 30, 2022 at 6:36 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Daniel Latypov <dlatypov@google.com>
>
> [ Upstream commit a02353f491622e49c7ddedc6a6dc4f1d6ed2150a ]
>

Is it possible to make sure the fix for this commit gets picked up as well [1]?
I was waiting a bit to see if it was going to get picked up
automatically, but I don't see such an email yet:
https://lore.kernel.org/stable/?q=kunit+OOM
(Perhaps the automation just hasn't gotten around to it yet?)

Alternatively, reverting just this commit would also work, if that's easier.

[1] commit 1b11063d32d7e11366e48be64215ff517ce32217
Author: Daniel Latypov <dlatypov@google.com>
Date:   Fri May 13 11:37:07 2022 -0700

    kunit: fix executor OOM error handling logic on non-UML

    The existing logic happens to work fine on UML, but is not correct when
    running on other arches.

    1. We didn't initialize `int err`, and kunit_filter_suites() doesn't
       explicitly set it to 0 on success. So we had false "failures".
       Note: it doesn't happen on UML, causing this to get overlooked.
    2. If we error out, we do not call kunit_handle_shutdown().
       This makes kunit.py timeout when using a non-UML arch, since the QEMU
       process doesn't ever exit.

    Fixes: a02353f49162 ("kunit: bail out of test filtering logic
quicker if OOM")
    Signed-off-by: Daniel Latypov <dlatypov@google.com>
    Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
    Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Without 1b11063d32d7 above, this "fix" breaks more cases than it fixes
due to my sloppiness.

Thanks,
Daniel
