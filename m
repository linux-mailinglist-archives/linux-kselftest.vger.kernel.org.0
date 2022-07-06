Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADC7569247
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiGFS7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGFS7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:59:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121F275E8
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 11:59:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v12so7801940edc.10
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJBGd4YWiUvcMgoxfpT1QB+xxsar8YQaWyM+sKP7ZWQ=;
        b=Ha03cEmXtorTod0JjdWM7qlCulK5jqVzsbXnMzrHqrcKjlt9Ma3N59CDMyu1eMZrsG
         UgLyAUK58xH+I6ypU5n9XI0hQviOL6iPVIN3YpyXU1UrGg6v6XT8KknMx2ICrABkWJi0
         LpxFEYgv38vGoni7rA+EjR+FBusEIlvlvEQBwS6PP7QqUdl1jUM7wPDKILu/1/yVkVi/
         0HYjOPejeE0+qkRMvNpfHtAl5+BSiyc/GgJs3HUdFKd2kfLBFxnBqh1le5hpMsVbrOYH
         nV6uMh1u7zL6037NxeP4JDqRDuk2cGg9L5kgs8SY6bsuFg6v2HykiLbnTeP3UGIbizt3
         EZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJBGd4YWiUvcMgoxfpT1QB+xxsar8YQaWyM+sKP7ZWQ=;
        b=A5t/X3YbFwYMWpX0KMx7nz5dvp2un1l+YJWK/6dR4/CgrQ88msQ1xU7xKpEUu1ftHE
         rWuCxsXvFloGZDTb2fe/ptd9kdDF3uHG/pmyGxJxOppH9pFdOVncDMTgX8OQrcqiFFXh
         Yc3e7bSyr8dG4sxp3uDgYVeNb8Zs6r91yvDYRI6ARaTzmodFkYp9PgTjKbhQ85WntcBk
         AXqRBGFjvIjwO831fhWp9gCfaMibf0bE5DH85X1dEMHFjbSGuDyCLHB0CNo4syyTgNRn
         o2tL+CXNl7wWazfoHjHGDcZKfsuwFFlSplExJ+OHYlOKf6dIWOaLCxPiGyGa0uq+G1FH
         9QNQ==
X-Gm-Message-State: AJIora8fob90NxhCkIA5EKQUmW6cWRae/bAPfe+ODWsoxdNg8maDb3DJ
        /KcbzTqGdlbG68AqtI3yyQ0K+1RScW2gTApz8r18cA==
X-Google-Smtp-Source: AGRyM1vTicJO+szVHVNfKuAfRJ0zZgZaaiG7xOw2TtlxNbtKOPv5thsTbIRTuGpZMrgB8p9agM1Z4R7ryZ8gR+RtOrQ=
X-Received: by 2002:a05:6402:43c4:b0:43a:6309:6c9b with SMTP id
 p4-20020a05640243c400b0043a63096c9bmr22459868edc.91.1657133941113; Wed, 06
 Jul 2022 11:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com>
In-Reply-To: <20220516194730.1546328-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 14:58:50 -0400
Message-ID: <CAFd5g45ByGFAmoOAy=BBBXouk_h0hT13ZLHTzY_hv30B8KfL9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: drop unused load_config argument
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Mon, May 16, 2022 at 3:48 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> It's always set to true except in one test case.
> And in that test case it can safely be set to true anyways.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
