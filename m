Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E711D894
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 22:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfLLVcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 16:32:08 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34030 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfLLVcI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 16:32:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id j11so83415pjs.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2019 13:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdnrKmYHg3rqlYKrPyGNdA80VNXD4QHBqrQKSlfqXu4=;
        b=hPUHH8bUVCGxkRby3K/7Nthk2Eps/0oLgx09HgklkKuHZt+nffawHoFzA160FeMZIl
         pxvMCwIGVTZFsAamVeAAB3svzSIw1PmpwkyRsN+IFB6ytzDghbzuzS1ZX5HX4v6/0M7W
         psdmalKL81H4zc5kH8biWKnN3noOXLfM7L63dwUgf8kKe3tGy1fiYLO6Y59Zkxkz7EVb
         cpqGJNIc2hXAHkSFU7vx+L4Vp5aZEe67iSRAWpVmWstsaa014SUvC39LP6u03lCvfhRK
         kxXrsE+bqum2sTOHsoDzKDn3kToTTgvLTvF1Go/gbOvQDextuuwGSVt/SMfzTX9tssML
         Ft3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdnrKmYHg3rqlYKrPyGNdA80VNXD4QHBqrQKSlfqXu4=;
        b=Db5B8x8eNkXQcOYIdha/MZssRkDCkVg0qImz520Wb5xAOiyxmFAn5GpaAxEnf4/Ng/
         X2WzUQk/WNKj8NaHTDqehOzhlN5gZeL5m3tpNL/1ZSxztt9dp/SQb0qppOWxUtteb6v7
         L9pbcv3y86GnIdnAnUTHbe9KeKm4GHRlJ8OusOwueQrd9cZ9vE5yHWl5ZkA6BgST5y2e
         wD4D5x1+6TYIZrIdzFiK5JyJ/ittFcQm/wUmQwSJL3xLQhmcpxXt2rUvkmJ7WOuNmH4R
         Yj00TYC7LZQDxrBT0LNda3p6FLjalGpegBVaIDDhcztgk9+OVgZmzNrWBBRJNT9LSmjK
         WUMw==
X-Gm-Message-State: APjAAAXg7LZC56NtQCFNZKRH7VAmL/dJsDUQ97zBbYJDUfP7zcIQtGqn
        IVOp5dkmuZ4lAkldX0Al0RWvw5OMr86LZkLEx5ky3g==
X-Google-Smtp-Source: APXvYqzwOznHvwcAzPlPgFG7b7H85IVLuyJJkOiOiEbk8Mj2lKz9dvNEnegmIADQ/vEUPC6bM+R3OBz8Ae3hFTbHraY=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr12563660pjt.131.1576186327744;
 Thu, 12 Dec 2019 13:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20191212022711.10062-1-sjpark@amazon.de>
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 Dec 2019 13:31:56 -0800
Message-ID: <CAFd5g46HjimaZB+_TJdy627p_jrBOrdav6+qDa4i_t4Kzmy8rQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, SeongJae Park <sjpark@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 11, 2019 at 6:27 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> This patchset contains trivial fixes for the kunit documentations and
> the wrapper python scripts.
>
>
> Baseline
> --------
>
> This patchset is based on 'kselftest/fixes' branch of
> linux-kselftest[1].  A complete tree is available at my repo:
> https://github.com/sjp38/linux/tree/kunit_fix/20191205_v6

Everything looks good to me. Shuah, feel free to pick this up at your
convenience.

SeongJae, Thanks for all your hard work on this. I really appreciate it!
