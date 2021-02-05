Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A906831188A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhBFCk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhBFChu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:37:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8E3C08EC2F
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 14:28:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so4625699pjj.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 14:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9Vg/6Y6014A/4yyhkeEbYIw9mlQkZEORNcu2Rw0bog=;
        b=wI2uVBwS5PbFdoFG+KbacEaeNBxCQ3oyY64EOGPG5AcFvJZ4olpJbXtMEASZWkg2B6
         geXh938YPsD8dUaGtFkQ5n4biXCnp9lK6mA6whQo1OhJ99s9+Dc+4kzk858AzxKG57/p
         LkBTtJOmjUw4VHpCbvxJIGSnNNj+FYfYi3CrZN//nW1CzlKhLQVe3QEveEH50iHQM1Kx
         CEHHp+xuWZc/10S/cr2+lisNuKqP2HgbsBug90mre6aJiQvxbBgr52liXmmP4d9GhWTn
         3gZnYxx5WsCtdUuZ4FmivqOoY/5vWDKNJ3bG2MZ0YVQWerYOL9ncWQ6QhbFTs8BpJ2oI
         C1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9Vg/6Y6014A/4yyhkeEbYIw9mlQkZEORNcu2Rw0bog=;
        b=Mud1KgqkDWaOXcQT4n7ULtP+iTMs3tIrLOoaM2WItjlTKtTHVt/V2Ibevhaw3Qqz0Q
         okJ/16ivwcmqQBuvhLRHQY9EBqnxfPU8nSvEAcy4xvKm6eAyszvMK1MiAqkbP9OWAGdr
         bsGA9KXTCnm1a8TBjb2elvRHEsHypP6MLhDSrdF+cZqfP6y95/tgtNdIl0a9eGaDzUJ6
         cIPsrszDlvDEA+AWqNunOqfBOamwhnvFVWVnolt5W2CIzfOaBhuOacB4FNgsemACZI1s
         pcge60w/5ApaWRAQT6YRzkBxclws8m4CR2xI/5tqKhfB3Nsrt/uNx7IooDHUdYrPC4y6
         zkeA==
X-Gm-Message-State: AOAM53347E6UXHWB6YcF47Wl1ATC8Dm6qyWec/AcGfvlPZ8KKGLuloUv
        s54lbs/hInn4bGKGkeENI7rmerrCL99qyslSB365ZA==
X-Google-Smtp-Source: ABdhPJyVIPrAcFHOnglt8XDNInhZpcNOqOkXnbSdoBOR5tsENhqfuHfWCoO8PScTHv2GRVbNVQ+yAJxh0MQLPmROmC0=
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id
 l6-20020a170902f686b02900de18c741f8mr6048292plg.65.1612564107195; Fri, 05 Feb
 2021 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20201208232102.339587-1-dlatypov@google.com>
In-Reply-To: <20201208232102.339587-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 14:28:16 -0800
Message-ID: <CAFd5g456hj7D_xQkYQZbSD4yhKxaJNY0iF1LjjkzLYgiB8avAA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: simplify kconfig is_subset_of() logic
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 8, 2020 at 3:21 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Don't use an O(nm) algorithm* and make it more readable by using a dict.
>
> *Most obviously, it does a nested for-loop over the entire other config.
> A bit more subtle, it calls .entries(), which constructs a set from the
> list for _every_ outer iteration.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
