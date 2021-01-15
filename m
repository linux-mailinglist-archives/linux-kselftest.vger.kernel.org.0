Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1440D2F6F76
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbhAOA3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbhAOA3R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:29:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCC5C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:28:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id t6so3805152plq.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DadB4dMZfg/PLRa3chi8uXwQiVldY6EMSgs5DP9rrBo=;
        b=oXVhkH6dCM2gjm68QD6+hm1iRHcUxyvZs11zaQG/5mJgPOO8GR49OJrTw524YZnZlp
         Bl+oUUNXRkg7Xx2mWaPt057iWZOyu6k3+FDJj99pMxYxYG2ro4+oxBu6DixH9mt8A7ej
         kM+uSP6DaP8wcLBhk9vRhS/V3UGdx/E/V101DJZXFmhyGdHLkjRGzbzhXYiHZDg9uoNG
         uteInz7XDpl33zyPHiHjKP6FwbnXO6m7M6ZO3rIAh63T/KeX1cHXrk7zCNR+DqDU/yOJ
         AEVjqKHCg548bfKMuUUQPQjljnozesgvlkROwrp4GHWKWNHMXa56SwY81i00wW0f3lVF
         8Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DadB4dMZfg/PLRa3chi8uXwQiVldY6EMSgs5DP9rrBo=;
        b=DzTos6r1CfjATrPxepbRO3vVptqLN0ocEuQuHsXqTaNyt7k/EmnZ7sAKJCEsCDxLIh
         UuIfmygtz7VJyrxnaMYc4Arnr6mlHFndErKWTCLLLvyrGoDdGnx/I1C+hofBlOod5K36
         +nEvRLirnIdO+sB2vkosQGsGqHD2d0rxum5w3qXZGxUjGex4PayTiX6WjynL6xuhg3q3
         +ZvJhqyJh+BAZM17Ujsd9mVBuSY9o6XH83xczQ5ehtmW91MKBfZKgsw0on8P+7JYJ+97
         hdpL8hQJ0PyLw69Cm/8H5PyPJVIzC+5GjrxVR3WgQ5thRp0lCxpdqhGbfCP03dFpr4QK
         0t8g==
X-Gm-Message-State: AOAM530HO3JhB3u4rBJXpRA7upuZ1aOxAjZUE4znz20gb7U0BkYGOmye
        pX7NKpixIgX5a/C5QYaptXV2piV2LiZvO6O8WCrBfg==
X-Google-Smtp-Source: ABdhPJys+dJ+QBolCgxszC0GuoEzeOYfrtCrTYKp3dTkUKqnqu5sT8cfZ4T2ZXf8z3EY7Bil7K/cw3b3eNX5WXD7Ojw=
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id
 x7-20020a170902fe87b02900da5d3b4a84mr10049761plm.51.1610670516665; Thu, 14
 Jan 2021 16:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20201211223232.697679-1-davidgow@google.com>
In-Reply-To: <20201211223232.697679-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:28:25 -0800
Message-ID: <CAFd5g46UQtLeLoJYtOC=F1zhfz9FaHkYxUcqPjhC+7CQjshz_Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix spelling of "diagnostic" in kunit_parser
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11, 2020 at 2:32 PM David Gow <davidgow@google.com> wrote:
>
> Various helper functions were misspelling "diagnostic" in their names.
> It finally got annoying, so fix it.
>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
