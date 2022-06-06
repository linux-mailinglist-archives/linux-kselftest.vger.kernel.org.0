Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B1C53EA46
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jun 2022 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiFFPmO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiFFPmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 11:42:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B29E64
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 08:42:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq6so16714525ejb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uehsw7JCHsCehIFzJ7Aoew6SKLLpwBI0xFRB23aWgk0=;
        b=tcrko6FTGCS/eACggns71j8w2N7EZA3SyXAUcixwJMcKre5pzGrYtmf4jdhNTTM839
         EuLtacAOl7LqmzTsKuVTTpp5y71v2y6drwykMBAoZpnB8AsMUNCb6g/yZR3xQrC9zNvt
         qFbk7zACZB8LJO+M18DqOOYEdb+sZGl1QuYwvgk4+gjZ8GM/K5YKU5Ht13M5EHfKLuSA
         8RkoT/hzNe8770BPI+dtMfLSjo/xiV7dRr7QEWqvuH57E9DBRd1LMGTjBB+CgyMKjnCd
         lbe0zxxz09zn6dlkVeW/KjfOVLwv1m4Bz+TI/jBB2HRStNsRT4x/J7TdaNL81BauiE6l
         ZDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uehsw7JCHsCehIFzJ7Aoew6SKLLpwBI0xFRB23aWgk0=;
        b=nQ9byt7IkdGZCUeYOpVZU5JTMNE29wFMiv8NguUiUY1gPpQXLznnOVMEqg6Xppcaa2
         PqjwqH/RzAkgej/PWe0VmYMRZu0YoCBbn5qcHjGCIDq3eKesWd0j+w8if0oYpwgApSg5
         kbwdO9hGUgokRJtQG5Wyf1fHqEY9X+cBqnV0cUFys+RK8fGcvQOHN25IAJkHo73FNEX+
         WAlQ+1GSUqdWDUuddpnraa77yqagNCXyDq6vYgH5mIPUJrHgb18VO7TiTzZkQvjvsGo9
         J61Qsa+aY+PD7nURRf7H71OSfj3cYJShd+XSHjkqwZAR+sx06bb+MCnS1zFCLzVW9kJw
         4vFg==
X-Gm-Message-State: AOAM5330fA59fCYX7YIDCHukhJCwNJVR8grH1YYYwhRrvQPosb4SyYYi
        cfG3Lqoybj4sU7k19ZlMX52BOCkosbR5y/IRvfdJjg==
X-Google-Smtp-Source: ABdhPJxEb0Eopb/17oP8J0PE3mgoandk4wXldPU5cxioIQw6Wc+XdMik0Mex5P5wo9mIQpxJKyhtTSWg7FK9cOBBhUg=
X-Received: by 2002:a17:907:16a4:b0:711:c9a7:dc75 with SMTP id
 hc36-20020a17090716a400b00711c9a7dc75mr6704199ejc.542.1654530125425; Mon, 06
 Jun 2022 08:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220530133133.1931716-1-sashal@kernel.org> <20220530133133.1931716-89-sashal@kernel.org>
 <CAGS_qxrtZBrpk8x64oj53o4EEUCgTj1c4D12W+6UNArQfiiXaQ@mail.gmail.com> <YpyvEyomrPpj3JJR@sashalap>
In-Reply-To: <YpyvEyomrPpj3JJR@sashalap>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 6 Jun 2022 08:41:54 -0700
Message-ID: <CAGS_qxrOW-hha-anpd0+D8LbaPTYrsWpHc2Qvz8ZeURZEq5ZWQ@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 5, 2022 at 6:26 AM Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, May 31, 2022 at 09:15:11AM -0700, Daniel Latypov wrote:
> >On Mon, May 30, 2022 at 6:36 AM Sasha Levin <sashal@kernel.org> wrote:
> >>
> >> From: Daniel Latypov <dlatypov@google.com>
> >>
> >> [ Upstream commit a02353f491622e49c7ddedc6a6dc4f1d6ed2150a ]
> >>
> >
> >Is it possible to make sure the fix for this commit gets picked up as well [1]?
> >I was waiting a bit to see if it was going to get picked up
> >automatically, but I don't see such an email yet:
> >https://lore.kernel.org/stable/?q=kunit+OOM
> >(Perhaps the automation just hasn't gotten around to it yet?)
>
> I'll make sure the fix added along with this commit.

I just saw the emails about it being added to the 5.{17,18} stable trees.

Thanks a bunch!
Daniel
