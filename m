Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3125C2CCCFD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 04:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgLCDGV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 22:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgLCDGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 22:06:21 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE1C061A4D
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 19:05:35 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u19so578381lfr.7
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 19:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZfjFj0HnOPxDFc3+iS8mDidBdv6khuB8oFfMET/GKI=;
        b=u66lDIvqTNO9kjjQ2rLurjG7k042fHc8I+LGB1GaopW0Wzq1fo68Lg3tYclhHdyyj+
         P/b6j9/SPhuBsfvwZNf0XBrTUkAYj5pfUF6ENf+tlTqrpvqdXx7MCEz+QeLVVTPE8+7Q
         oFgVPiC3gs7AonDTk2bMELyj8+2wuT/wxZGJMMD5xr1V/u+N16BlC2rYt38C3tbdRqOq
         xtvqpT0kEoJLGU+Y8g+IyvUXsfOq/8QTSpUnr4fuBqiKiDQCQB6Us6Zo8pbKdKyUT3M9
         JSBdb1ElHz23dZ0dhi8V1ZPsPRNbq9n+RbsQ0nGD5oToWIcR6VJNUh5BhQhVTR2T1A3Y
         jlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZfjFj0HnOPxDFc3+iS8mDidBdv6khuB8oFfMET/GKI=;
        b=ai5W95RMJ1gqCCfkOk0L0jLeTRvnVxsWeuXxK+/Gcv4wCyJG0rAzFkfog6t8BnYpQy
         7Kpdu7mC6lhBG6sfp00uLvVO0a1F7Z0O1jilRyXOu6Gc2d5mmpSdaiScGtmm/Gp8DFsj
         jYxwNvDeYz3fdhZirpFVOwfR6RM8Cye+E4EJQp4mTctObiVa4Dx2ld5opoZcQ+OWjv25
         AZHF8Fn56atqNEfXzqKdfzSZU5sGE50btXednxgCFWVyqE87OSN2KaJ6uX1DzAV0hTPM
         TARA4En5zVBMSpuWXBOoUsSbT92zCfGCAGYYAvhY3+jmsxHiViq+lWSnoqKJ+wTFdtom
         /KlQ==
X-Gm-Message-State: AOAM532AtjrL1XwE5+3TwikZuDRYRPbonovyuYPdn0bZOSKIi93AOqgN
        QxBW0mZXzgkEqi6dXUl1CMpjTm54Om8W2McW6Jd95g==
X-Google-Smtp-Source: ABdhPJz3uwU3OoJjqR4+1l9Ui0xIUrD2q3MRpQ1iNbJ8+r/KWnAmLW7YkvTQKvIjA1nhCoGe/AGb1DFSfK1tv9zaaCo=
X-Received: by 2002:a19:246:: with SMTP id 67mr420225lfc.234.1606964733349;
 Wed, 02 Dec 2020 19:05:33 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Dec 2020 11:05:21 +0800
Message-ID: <CABVgOSnqhes_Lu+4BRq74get5D3ya3S6XxMLqFKamqahU5-RRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: tool: fix unit test cleanup handling
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 3, 2020 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> * Stop leaking file objects.
> * Use self.addCleanup() to ensure we call cleanup functions even if
> setUp() fails.
> * use mock.patch.stopall instead of more error-prone manual approach
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This patch hasn't changed since v1, right?

It's still:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
