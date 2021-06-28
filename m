Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74E3B694F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhF1Tx6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhF1Tx6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 15:53:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F4CC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 12:51:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 21so15119875pfp.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHpa4g9TKR0tPEueK+aK8Oh4qk2Bv9F9XU2nTVb+7lA=;
        b=NTH1E0zA4dF3OY5NrFaaYVeR1JiSFyJr1vNS5rrEPxOAQZCgO3id06bc9KdYg6owlL
         4QmR3bGU+wZlnpKBYbXwWvY4Xt4eQyAO/yky6ELwPtyccgZfLI3J5pnTPogbW9OVUkvA
         +CK0bpFVczEhPszGgi9WaJX+dRRkP+FNh/txYVxWvbBPSVjIuB+gaX4Ak/wyU5sH92L2
         XG92ffM3H2/ZYKyD/XXexHvK+VRCdL7BFZalVLzg5iL58jH1DoezOg1SgupI+O8HjyyO
         FpCHrEzryVZpxXMmrvmyrqG8C8JyIs2TFz6idwogMdQyGnGMqhwEGoc1XoLTA1D2xXHX
         3yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHpa4g9TKR0tPEueK+aK8Oh4qk2Bv9F9XU2nTVb+7lA=;
        b=itL2/QjQznkLhnPgpAWGnGR5Aqqyr0683b2oq5iX0/VRChxPT/j2KkuhU1qoQLZ6Ti
         5kMuBGu5SIisvXwWVQDFbOqW0accBOUweh53xqJhVS3E7hFcvMhIhslAWTB73+RS8ZwR
         NtnhaAgu7byX6kXzC6E3yrg4XO7A+8chLh3L6GfYCL2fWFwWKt5LxwP/0FZ8NoWoYuqM
         pa38Spm2ZCFQHNbKqkOiVBmuKrWnb3FmzB4lAhez55raOAOtmv4vI29CayDxEVaO32eA
         844Z1Ps0PAnCXmBnBXB4XoUzHIjKIeP8K3oVuIr7p8e0D5de0wVeQYidBBXwsPwn1Znw
         x7oQ==
X-Gm-Message-State: AOAM530kw141VMlWZJ48x6UwqAggO0QBTnw2OQPUJMPE5k1H9o/xVlVT
        2zhYUgszY0hShvfzN5UGRsaAIjwn8ULY++dMWm5iyQ==
X-Google-Smtp-Source: ABdhPJyHHpZvpe+IYH0TflVQpJ+KM9S5ReGK6CLRgNRqhN6JayGO/iZRI4adgZEpJenQToYziLL5loc+2wazSsK1kz4=
X-Received: by 2002:a05:6a00:85:b029:309:afcf:7919 with SMTP id
 c5-20020a056a000085b0290309afcf7919mr18133135pfj.1.1624909889541; Mon, 28 Jun
 2021 12:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGS_qxoPq1f+dcaf43xyjbDhW-ASG3gZez-b0Pv_s17JU3hePw@mail.gmail.com>
 <20210628133759.18659-1-sjpark@amazon.de>
In-Reply-To: <20210628133759.18659-1-sjpark@amazon.de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Jun 2021 12:51:18 -0700
Message-ID: <CAFd5g46j=xpSVBCkZ0c8N1dxkUBJHnJe_0p7Jcncfh8WhDR74Q@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 28, 2021 at 6:38 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> Hello Brendan, could I ask you opinion for this patch?

Yep, sorry, I just wanted to make sure everything else (there were a
lot of things in the queue) was in order for the 5.14 merge window
first.

Looks good!

Thanks
