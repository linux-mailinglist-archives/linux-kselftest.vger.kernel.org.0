Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205DD43D3AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 23:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbhJ0VSq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 17:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbhJ0VSR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 17:18:17 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D67CC061570
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 14:15:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i26so4433642ila.12
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm0+nNU7+O9MfXmzPflhpy32QYmyc8kaxNev2lDAAEs=;
        b=QkZG2K8bVwvVE7egaAt2KoM2ozNWqnXnRYCDiO58eC/yTXl8qb52o9wIZwiEo5g82G
         bccuMjBMX6s2/H00mP+Fr4qT57h9Uvc53WJXiMmwn/o5rOlpjbPpRCkoq6lDMvFiLf5M
         Mn5WuZvMESLsr+yShl4950U8mxzBbei0DvPwtD4+tGwSShXC7YBnfa4bwCxG8yzvVmD9
         ZWQzhlnZgrRF38+as+UM1Z5B3CgzFBucx490mDEgN/LQQOr5EPSwcVKAwJjxaors8Y2R
         Rw7IGFcGLS8D7eew/S4U2b8sGZ7yETg9YaMlTaGrL0Kw4t4XBNIT+7a4JOw/7ThIseQ4
         4gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm0+nNU7+O9MfXmzPflhpy32QYmyc8kaxNev2lDAAEs=;
        b=3y9IICXUzC9vS05nJC83hYhEY64EnFwzsgrNvu8J/ErEslCFmlMjpWQxThaOn2HIC3
         DHH5mcJIaoYGXHCkzO+E3Pro1nh6lvHQX3XDYGxeS9GfVcqp/0r9MfdIKT2vrxNZUSQf
         Si2K4l7w99WZx3LjozwoyQJCxeIjJV8sZuXOKfQf/Xce8GQJzjC679Pbax5aE8g6ABVH
         GfU3rYnTgox2vdKzEIFMmDGNCnZ0mI+8AolrrOZ1NugKzvdGfdKCN6zLPbFq+ls9+2MZ
         GJwa5w08JxIRjUt0O7LHSVENSU9qFSZv4iScWtQSRA9tWnDrr/WVpMncHdxydGyr6Fw8
         IHUQ==
X-Gm-Message-State: AOAM531+uOhsfk0IywJ7oFOECXtGw0+Q79TxFfGfjY66MxFtjbe840Eb
        hSyaNgB7ceJuJDma6FbFJjHs0JNoShcp7fgvcVExQw==
X-Google-Smtp-Source: ABdhPJwFlVdGBs6/ghTfnA4EXQvfoHz1gslNeIB/tO5KGqaiLemu7UQV0bF5r1t7c+peB8KbFaYyT1obO1kHcSnGPSg=
X-Received: by 2002:a92:2812:: with SMTP id l18mr181346ilf.239.1635369350499;
 Wed, 27 Oct 2021 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210930212309.4001967-1-axelrasmussen@google.com>
 <20210930212309.4001967-3-axelrasmussen@google.com> <CAJHvVcj9FpJgC5EsB1_6yfgDA8p5-=Oakccg+TUrGUWZB5nHzA@mail.gmail.com>
 <YXDCagVgh2O2YdIW@xz-m1.local>
In-Reply-To: <YXDCagVgh2O2YdIW@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 27 Oct 2021 14:15:13 -0700
Message-ID: <CAJHvVchb1XyQiu6=0d+viG04Qe4LV3Z6dmCLRxGNqKPxriULFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 20, 2021 at 6:29 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Oct 20, 2021 at 11:28:49AM -0700, Axel Rasmussen wrote:
> > Just a friendly bump for review. :) Peter, any objections to this
> > version? I think it fairly closely matches your suggestions from v1.
>
> Isn't the whole patchset already queued by Andrew? :)

Ah, true, but I was worried he might hold it there until it got a R-B?
The process is still a bit fuzzy to me. :) Thanks for taking a look in
any case!


>
> Anyway,
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Thanks for the change!
>
> --
> Peter Xu
>
