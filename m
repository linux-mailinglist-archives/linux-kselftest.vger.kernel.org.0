Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB246C496
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhLGUaE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 15:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhLGUaE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 15:30:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84768C061574
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 12:26:33 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so2744047pjb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 12:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQpK64bn98594YeNAogic3YHGdCcFqkqDbQ4M9QznsM=;
        b=mkOHqqj1M+Rj54ng6bYWnsAnf5EJ47fY3pEggwZ2KlmcEWI+BiH5TaqNOtjVcmiVOT
         mdx7nTE8AVBMAQAhnQZP/XbLugAM1s/D6E4AE35tqGh5mM7bc9RZ7N2Kf3/FRgoZywM5
         ikBikOD8FeIuJ0i3q9fEcAKRkNS0dR+xfThaWypE4peWOjXNqotuFAgKkL2nMkFhI9Qy
         oRcnw2oo2SANffVkCz1+wtZghh9dZHfMHRxAHFWkkg0mE8ArbZv/KUx5m+AgJ/v/z0vW
         1sZngZgxFvDHQenaWnn1YfjkVw8xF7TUekIGQvmLZN3iyoW8mmbEL2LLlCLaIboUPuoI
         HM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQpK64bn98594YeNAogic3YHGdCcFqkqDbQ4M9QznsM=;
        b=tb7xdReREwCrtO7dEiWeRSHIrI4KE9C6aHjxuQXvibwyX5c7mx7tUFP/Xg6FeM6OXq
         78MbpbcCVzXkQHUmeXAaaLbAABYxJCDaUFPzMepzMe7xKRMG6HCswZ2YcMcui/kiySpS
         YMW1AVU/n8XehZ3IaO1c96wXFdMEzXqe6BG7zTpDlULHVA2cM65aH05SzV7kUOsKLCmT
         qYeeKk3nAJixoJYqwC1JdyO0cKvtdGkVwXww4XRzP5AKE0Ng7aph4BuSKDP98bTADYzs
         XkWpXVe6DGszz0VGAiWNbCwoO/h3Hw74Y+xBpaeGXkXLCSLtMmp6XxKQuC5SQFScDQAm
         /jCw==
X-Gm-Message-State: AOAM533ZOWM636N/L1kij9m7LDj5OM/WAnihQnSfI5G/XxL57qBkx5nt
        Vc15K5xoBlpRbjzQ/PK+wZnDc1AZMp8AZgdf4eEzdA==
X-Google-Smtp-Source: ABdhPJw683y5aqkLT66MwASREjBlo4XJZ/HgFIcv78uJAF8kOE6LwpBeKAkbwl2ansBG6PgONV6StZ3wkhBQ8jiADJ8=
X-Received: by 2002:a17:90b:230c:: with SMTP id mt12mr1742521pjb.63.1638908792867;
 Tue, 07 Dec 2021 12:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com> <20211102073014.2901870-3-davidgow@google.com>
In-Reply-To: <20211102073014.2901870-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:26:21 -0500
Message-ID: <CAFd5g46jjo-2DUSNRi5=VHhdpq0e1tz=PqyvL_p1cxB0TQr3sA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] kunit: Don't crash if no parameters are generated
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmr167@gmail.com>, Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 2, 2021 at 3:30 AM David Gow <davidgow@google.com> wrote:
>
> It's possible that a parameterised test could end up with zero
> parameters. At the moment, the test function will nevertheless be called
> with NULL as the parameter. Instead, don't try to run the test code, and
> just mark the test as SKIPped.
>
> Reported-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
