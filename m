Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B988CEEC5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 00:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJGWEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 18:04:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36667 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGWEl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 18:04:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so7524895plk.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixInCzHTHuGPoMvc/4LEqiBnoIwsvH2ChHMVP5v+VmY=;
        b=uOe86C3vj6CaS6uwMW2GJRTthVEBShtNmMQn6K5ZgQOd13S77DKyAScS4t5Sp05CAr
         frkcDaQ0fR3BQn5RCygrrLLnk/8iVh9zI6nJ0h3oKPxTH2KD8QT8wcCJwD5c/+XzVjdQ
         0ni6r7S0CGsFBqLR5kowdiHW0a9wPlQc7M5r4Pcyub+6185zjMkKPrjGVE5PaR5qKf5X
         fBMtY8GbTPyrb1j8iRMXeMKURnv9Puz17sJEnNLlBeSKjR0ZuNRpRGq5nFrEzeOSRDmq
         QUFwXjVrGYTYw1/HYi7C+LfirFMTRYkfOyjo+j8JgZPXOs+2VOHV4baVcsTSXzea3MmO
         iR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixInCzHTHuGPoMvc/4LEqiBnoIwsvH2ChHMVP5v+VmY=;
        b=Hsn6bhkGrw3m1prSlSgRFsUZQnb/AIZauV+RT9hdlCMvAWMojE8FEDdKKXv6DrFNGs
         ZKWty6RInseXi4BsjyVGV+BytgGLZMMzLuh5Rvh/zLOeVHRV6DPT6r8ddzMWtwdcrtG0
         XmPtF1CJTLpFFu2N+sd6ZDVB5Y7RDEXyqulGWyncV2iZ+2FvSjsystIEXbSdQHDzmhYV
         z1PTsLfYiYhmPOh80zIybqO7xgMiz12wS4+IRZSrMLZ7CxKB5bcrzwclGIyFaJtItfse
         eJQdmTuf3RT4Hf4WUvVo+30OTIc/khUzqfpqBRTeD3QEIAgmCz/Bix2vXPuPIa0n9yh5
         ZJdg==
X-Gm-Message-State: APjAAAUxA3jKcsEBaWXgFj+qG8rFsBd+4DAexHn+U6J0fMn36sK5YOFq
        zNpFCaDWsnnGZlB03L801An3vWJL8iTirLc9za2wlA==
X-Google-Smtp-Source: APXvYqxdfUw8NUeJtuRGGEzEqvtnI3iP4U3bEOpjmRAhZp4oxYNIfoAO20zZhTj+4G8d6lAZz65Epk8t27NgaZEGRYg=
X-Received: by 2002:a17:902:d887:: with SMTP id b7mr30655303plz.297.1570485879868;
 Mon, 07 Oct 2019 15:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <1567890091-9712-1-git-send-email-sj38.park@gmail.com> <CAFd5g46MNYcY-o8Z-1tSi0Kva02CjhcWC-xwkeNc6kfiDzLpLQ@mail.gmail.com>
In-Reply-To: <CAFd5g46MNYcY-o8Z-1tSi0Kva02CjhcWC-xwkeNc6kfiDzLpLQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Oct 2019 15:04:28 -0700
Message-ID: <CAFd5g47sUx6ZRxcH4KdKjftv=wo9HmWn+bZukd8gU-YcJv24zQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Fix verification command
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 8, 2019 at 4:40 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Sat, Sep 7, 2019 at 2:01 PM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > kunit wrapper script ('kunit.py') receives a sub-command (only 'run' for
> > now) as its argument.  If no sub-command is given, it prints help
> > message and just quit.  However, an example command in the kunit
> > documentation for a verification of kunit is missing the sub-command.
> > This commit fixes the example.
> >
> > Signed-off-by: SeongJae Park <sj38.park@gmail.com>
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Shuah, can you apply this to the kselftest KUnit branch? This should
not require a resend.
