Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4EB2A8397
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 17:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgKEQf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 11:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbgKEQf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 11:35:28 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2FDC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 08:35:28 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r10so1727104pgb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m72lO8z3zwf9UFfzfvm3Frh0loQt3QgONyL9X/CcoOU=;
        b=hOQcF4Ss8fMUepwlrmExH6v4e4d4M6MQRnoPPNrVWaCIk6HtN5RPz4k1EGAgfnAe6U
         verD+M7f9JSwVUNJhFOGUODL86erh5sCADzegamwvoCfc4bptqDCO188kgvniVwQxUhV
         0DjMu66UhAqgQQf3lXpFs4v9eeHeasrV4bccbtrrLWacwh0ouAwH5wm/RLa+kgnIhuJd
         qywZH8f3lJ53F3R8CKT02erTlekbIStJFmGZkQ2XXRd5KLUip2IPttOnatLLZyGOken5
         QkfRaZnYSmcLqGcrNbpxvUbyFQlWQWsWw70OXpm18cu4qJt6KUo09tmQH/QRfGpbb3vo
         6hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m72lO8z3zwf9UFfzfvm3Frh0loQt3QgONyL9X/CcoOU=;
        b=igv4dc4UFf7q+lSugZV9saIJfLlD6Htm+Gc2a6SeFvUiUcFQXp5DELon+g6CPDLZ3j
         Hw7B9j/plYlztV+wYievorWulVwLYTIR9vTqOLlC6Qc7b0V13jZFhq7Ii60a15af8Y15
         kDyyzPmt79FseT3u8vrqqyaHjdyBbJuManbkx750joc58CxN52JHvH4CvpBtmOvytS7n
         o9/+m7fzF9XdTLbxRF5i9A7eQ5rfrG7dcjgiDN+/Fa/NkD3UaUBEoEqjviWCIgxmX0Yh
         x72DPsoQcNiljH+btFb+BEUEpyuBEGptuU7qY/olmHl3GNUVYjUTxqvNOKaSw1Z9DO+r
         yfQw==
X-Gm-Message-State: AOAM532p81cpjE83/4L2qHQkEeQOvlZhXYPFemq77CaHl6OPWx44gxCF
        I1T0V3uVlbR9xdEBGFwT7aqyKkTz8IjI/rRBJrj/wEIXzMd3Dw==
X-Google-Smtp-Source: ABdhPJxuppJoHbDk+iUrihP3BeHQwm+n0b9VSKEA5jOIj88ug5Hwe009XTIDJzx5njop30+CjxfV8/d63xZkUCavPlw=
X-Received: by 2002:a63:495d:: with SMTP id y29mr3085949pgk.384.1604594127815;
 Thu, 05 Nov 2020 08:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20201026165927.19020-3-andriy.shevchenko@linux.intel.com>
 <20201028092915.8053-1-sjpark@amazon.com> <20201103112512.GZ4077@smile.fi.intel.com>
In-Reply-To: <20201103112512.GZ4077@smile.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Nov 2020 08:35:16 -0800
Message-ID: <CAFd5g44dLoUwfNPsMqavU_KrJ5+xoLgKT0Ec2_-pxVYxjMHiWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: Introduce get_file_path() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 3, 2020 at 3:24 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 28, 2020 at 10:29:15AM +0100, SeongJae Park wrote:
> > On Mon, 26 Oct 2020 18:59:27 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Helper allows to derive file names depending on --build_dir argument.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Reviewed-by: SeongJae Park <sjpark@amazon.de>
>
> Thanks!
>
> Brendan, Shuah, can we get this series applied, please?

I'm not actually sure that this qualifies as a fix. I certainly don't
mind if this goes in 5.10, in fact, I would prefer it.

In any case, I added it to Shuah's queue. I will leave it up to Shuah
whether it goes in as a fix in 5.10, or needs to wait for the next
merge window.
