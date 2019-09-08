Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47AAD141
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2019 01:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfIHXkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Sep 2019 19:40:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36650 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbfIHXkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Sep 2019 19:40:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so5717309plr.3
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Sep 2019 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LohfG3rkkHl8bureWEJkUvhdbDGFWW8YgBUzOLjQodY=;
        b=Fqe9X1qllKs5enf5FC3P4j5w8zG3QiuUGfXHor2b6R811HjACIddysCpE5pQtTJsbu
         SoiWUs2RboFfg1mm0G8XfeWXwKybjnISHzhYZmH26MOBUbc/2FZeIZosjLwXl8uj8wZT
         kix6cH9yj/f87Et7cEIUZIRUB/Q+fxiq+IIl48S0t7ez7FdF9RzbXX5aSovS2mUEoC57
         hMUkz8DtSM5HPz4TZbuf+ohR/zzwKt/oqvUGDeyAov+PXg/eJLe20jY/eoyLwLrMEG9q
         +m2a42Z8XgGDrzxFTom6qWYM1rCw6tm7jRTZ6duum4yp5jRj0CdR0FrUO18fE/8ZHxXn
         +90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LohfG3rkkHl8bureWEJkUvhdbDGFWW8YgBUzOLjQodY=;
        b=LZd6m1bG2ABFuzfssW5/BWgLApBtkj1tN5VnhjKoynJvSKuuQTJRPkmWsIGCQjZUzJ
         pe89XrBGHTmpFYyq+avTMDrdSNFjRL+L3tApen12J9hgzLl9F7wkEsN31N92Z3CV7QIS
         yTT9rykx7uoCWMyBjwoamTED/vXZ9o0VSEaZhsd407P+BHPuLasX5GkpfUSolAca1+ny
         PLQlwF4E4BPvWwvPAsBf8msDmji4p1SNEcwbkXw5nCBnOlFI7l1wk1nTBXGeqjY9rGjj
         oAOY5zzOLe1WJhKoHq9GA4KzVkxk9L6VyajG6BWX9c1/LZTNqPY7ei0GBRYuUrtcqH/A
         gnfw==
X-Gm-Message-State: APjAAAV8K6TOAw+w4amVLbYDRsOpL0cTCfvEgRNJVzoqUgMM2GxSP80S
        EMk8CNPUL43c5WVaGQH+ictjsAASAX09ngXtQZ1X7kGxeOrbxA==
X-Google-Smtp-Source: APXvYqyrH785kn4aLZQoAcdk/b4CYqJIOXgDPzV+kfYglrL5OB9k2ceCWlG1luir/5qE+eNXHMdRoV6KPjOZAP4ArkY=
X-Received: by 2002:a17:902:169:: with SMTP id 96mr20334010plb.297.1567986021747;
 Sun, 08 Sep 2019 16:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <1567890091-9712-1-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1567890091-9712-1-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sun, 8 Sep 2019 16:40:10 -0700
Message-ID: <CAFd5g46MNYcY-o8Z-1tSi0Kva02CjhcWC-xwkeNc6kfiDzLpLQ@mail.gmail.com>
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

On Sat, Sep 7, 2019 at 2:01 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> kunit wrapper script ('kunit.py') receives a sub-command (only 'run' for
> now) as its argument.  If no sub-command is given, it prints help
> message and just quit.  However, an example command in the kunit
> documentation for a verification of kunit is missing the sub-command.
> This commit fixes the example.
>
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 6dc229e..aeeddfa 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -43,7 +43,7 @@ wrapper from your kernel repo:
>
>  .. code-block:: bash
>
> -       ./tools/testing/kunit/kunit.py
> +       ./tools/testing/kunit/kunit.py run

Ooops, that's embarrassing; I have the right command a couple lines above.

In anycase, thanks for finding and fixing this!

>  .. note::
>     You may want to run ``make mrproper`` first.
> --
> 2.7.4
>
