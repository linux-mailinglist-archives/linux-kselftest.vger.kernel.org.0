Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A401491A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2020 00:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAXXNo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 18:13:44 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33205 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgAXXNn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 18:13:43 -0500
Received: by mail-wr1-f44.google.com with SMTP id b6so4003606wrq.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 15:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWxAa5bHJ6PMK9NxJf+sotV/H1bquBNTcrRDY2YcrUw=;
        b=JFwEgiMlTVLpCCLAcgaTLVUSaehg81QYgNPM3b1Ym2b5z/nL3KqJQF88KbVz9cdk9r
         CTzjE5+aAMbtk7ELcq2bgO9K+zAzqamtgzbJUMhCE2UtMUId4YJmmt8mZWGNI/msC6uq
         Ib2YT51CLEO/CBYA44ZPxKkuKAAj6vBBknHK61TX41z50xOOv718Q16vwHsm9sWXlCtL
         Wyur4nSjXjUJVz9SkntFxcVa3uFr0o7zR5qlVSxRfX4/BM8/LGrXcy5sKU76ruA40fB6
         +iMCJl1NxAIJAt+H+0XVBK1FOWDcMk82vh+AGN1kASIytgA9VaVBpwknfn4st2dVzmG9
         UfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWxAa5bHJ6PMK9NxJf+sotV/H1bquBNTcrRDY2YcrUw=;
        b=fTgh4ni+8+8cnt1ju3/DImuuO+dh4k+EkqNntOe/NF9WfL9XyQAlSbfhFugzeQleut
         wBPfcyHL5JZi8bmhaf27wXu3XTAQOyXpGYXMcNZehT3jBLpDByN5xLKzPWVAA8XfwRSZ
         h+maS7wsmXkFdM6XytjWy95/AQATBoplfXSZgjiou6L5PmdKuuZ84s7ROC34mOA3XQ9E
         34J3qytaS/SNJ5Hb/ZwDiaUSZznR69Gse2H5yjyxhWpi9L6vIoAswAPk2INvHYpTjS3s
         v/I0xQAY7gcb7KdvKEgKiStIwr6Mx5jCbtGte/7b9jpS4w7rhpOhxyJA2+ZkN3UQ8PyN
         TtKQ==
X-Gm-Message-State: APjAAAXN5VVRcJ4o9xNXRzCVO7dw/7r7IgveEZYHJJsQjZohjKEK0bVk
        DU42ZOz6JZKbnctgD+x5n0MHjLvMEvkXnjiGIlDMvQ==
X-Google-Smtp-Source: APXvYqxN872w0DTvxW+Wn3EovolGmqBFSzUcrBBwdJKbLKF5OkwRRiPnROfW46WxRCPlK/8cwRgFRMGQxMTCJGencF4=
X-Received: by 2002:a5d:6344:: with SMTP id b4mr6722428wrw.414.1579907619941;
 Fri, 24 Jan 2020 15:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20200124194507.34121-1-davidgow@google.com> <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
In-Reply-To: <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Jan 2020 15:13:28 -0800
Message-ID: <CABVgOSnVLyOAYMi2eFaOXtm96SdmrO8hmJ4f2gKbDJ7wS_8d5w@mail.gmail.com>
Subject: Re: [PATCH] Fix linked-list KUnit test when run multiple times
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 2:01 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
> Oh good, I am glad we are getting rid of those static variables. (I
> thought we already dropped those - whoops.) I think this drops this
> last of them, can you confirm David?

Yeah, this is the last of them.

I vaguely recall a suggestion that it may be worth testing that the
LIST_HEAD() macro works with static, but as mentioned in the
description, the for_each_entry_* tests probably aren't the best place
to do that anyway...

-- David
