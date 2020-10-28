Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59529DBB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 01:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgJ2ALZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 20:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389128AbgJ1Wqn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:46:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42466C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:46:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w1so771403wrm.4
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7oTJO2URUwicNq+0grzgb1zKL3aTp37KAP9mWzmEfQ=;
        b=RkhCJEMWAEf7CVCbwgNDcxiCFZe0Xv7wwi+BltG+iMI5kMEjVy/m2EmIKaONUI2RMA
         Ycp+UFF3l1p3R5IMVnT5JM5eMP5fy252Z6+MpJJtLTvb8iRfisWApn/vt0x0Zm9qGZCo
         POIeGL2eNfXmxCbQ6lS3mbW8m6TyVrRZCVacmFp/hm116lWmRmJJnyq5xm8amva3rMBC
         srRJHUd7P5DYX4A4MzBBuQi8Rlug/FgoWkmom595iq9u2DWNUxXiDfSuUwNDqBrY4mX8
         hs5FiI9k3AZ2jT076DQbTEVsctmgwby4QdHysruvDXXMDjhR+YaWES96Q9CYkjn3YHn8
         SkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7oTJO2URUwicNq+0grzgb1zKL3aTp37KAP9mWzmEfQ=;
        b=bpIfQY65A6AFUBqzYOgsGLz2YbBGnk/E8TjMZXW/NtWxMvNMRBdvKzrl6/0JFzptUN
         UIcLhMF+dtHGGmCyhgDV6bfHmW8Au+Sj4IEEfN0H0LqY3JQD8bgmlJoJwXSlC1jJWVxB
         6oGppopwDuX8RHBqk7P99L3OrUFwsO50uhiQhH2xUxM/hC5b5RfJ5dBuD0EldP0iOcvm
         6j/hLwczNTLiT64a5u/maMxapLR0i7IBvOPWb7v3kB2XF8MP0yXQsnogQZL9Tbxnf3Rs
         U8MuBwDq1/SnIYqD0djQUQOEGj4jGSVpSg3J5iqEQZlNjmsE0nsJIIlfrVqRfQbEo5YE
         vS9A==
X-Gm-Message-State: AOAM532WSnaeXDuZRjclHZ1H8g5WVA5u/XvfXaGlalGUYj2e4e0UIMTO
        ssvXaR5FosaHvgH1mKtkTmQpG85zajHpaiporNtEQ8+qenJS7g==
X-Google-Smtp-Source: ABdhPJxYQ06WGTZk46k4E/0eoYf7OxVvvCI/IdrKL3cRLQySxmBc/1I92RL+kWyoNBkiKL38Kx023QuH+wpRCkVhJfI=
X-Received: by 2002:a19:241:: with SMTP id 62mr2067105lfc.165.1603854125720;
 Tue, 27 Oct 2020 20:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201027184853.20830-1-rdunlap@infradead.org>
In-Reply-To: <20201027184853.20830-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 28 Oct 2020 11:01:54 +0800
Message-ID: <CABVgOSkz60Dhrfg2ffXkejdE7Xbn4RkvEF=-6OmJTTQP9hrhwA@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: fix a wording typo
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 28, 2020 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a wording typo (keyboard glitch).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> ---

Whoops! Thanks for catching this!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
