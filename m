Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850F514ACE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2020 01:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgA1ADB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 19:03:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33810 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgA1ADB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 19:03:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so6006006pgf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2020 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/+22tuCgv/c7pzmNa8hMOqSD4cnYp/OANcRNx6S0OE=;
        b=gfeoTWeeEpelq2VhnCxceWKTgALWOfvaDYWNXG3I3R+mR60voLJm2xVMRyEQ61FmMG
         /zmvCPAW3FXmZlOCpzGJmlT3H8XVJ1HNtAq7EJ+7cfVI/4/EvouJfNllrUiqfWodaVAJ
         eoo/iwDocujDURl/NjLnM9iRzs+gDxRmV5Zxa8fEoyx+H4/wN97Jh5xDq1TdNwajO7yC
         HyhNSs6EJ/MQlXYgYuyJ5DzA6F9gOLwQBlbSVH/56G+ERq0eF3AnCdtwZUvaHzEfHmA+
         FvlQA0K9iI4aJBPKMxLfbGZtGcUAMKt3+R8gzNeDFGXU2HZHfLkio7yyG59acg1Q41Sw
         n/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/+22tuCgv/c7pzmNa8hMOqSD4cnYp/OANcRNx6S0OE=;
        b=bqy6ncrhZChx7/njgGA1R41qozu6CRyy38Cz+lURoMW1miWjFOt0rbl+kjDXxKSX+O
         dGpBEyIoepOpOgSGRF0mbx893/718S97XWgvWK1T2TlScEKqIKyG2ferrBEsDVZe9raz
         Urd+/52uxuRWg76Pzu5XrvJLYYXQvlHXIy/ogv7/n95kVOGw8ocxw/XY8f30g2Sy7ldM
         8iaV8a3xtAq5rtNCxZLahzgHIzBk8L3gTJ9HNqOl1EPrQYYX7YsRq6UT9aza6buCVK9F
         zez9ouKjmYfLnWHiMO/jCR9vUCcmwcth6eJ/2yu89aTfI0du9ldzpvquF4uLku0j7aVi
         MV4w==
X-Gm-Message-State: APjAAAVIaZZqXNMqnPBSMw8SWD3D/t+hysjfnJpZyv4Z/bVPNNizAZzS
        0LJ/+RIHQ63RJzWAiBvTPn3TLE/pSxMAbaoRzH43hgxi
X-Google-Smtp-Source: APXvYqz/hjm742JY6RjWU2IOn2Ej9B6rcY0LoAXJ2VgFjuz+q8joZGQ/0HiGIAuKCITVgNP9RIrNn8FDBLLA1vMjcqs=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr1155291pfg.23.1580169780179;
 Mon, 27 Jan 2020 16:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20200126015924.4198-1-sj38.park@gmail.com>
In-Reply-To: <20200126015924.4198-1-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 27 Jan 2020 16:02:48 -0800
Message-ID: <CAFd5g46v-RyNMP7GROn4bUEAATOPZ=w5AyO+tvuTG25aqt6oAg@mail.gmail.com>
Subject: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if .kunitconfig is modified
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 25, 2020 at 5:59 PM <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Deletions of configs in the '.kunitconfig' is not applied because kunit
> rebuilds '.config' only if the '.config' is not a subset of the
> '.kunitconfig'.  To allow the deletions to applied, this commit modifies
> the '.config' rebuild condition to addtionally check the modified times
> of those files.

The reason it only checks that .kunitconfig is a subset of .config is
because we don't want the .kunitconfig to remove options just because
it doesn't recognize them.

It runs `make ARCH=um olddefconfig` on the .config that it generates
from the .kunitconfig, and most of the time that means you will get a
.config with lots of things in it that aren't in the .kunitconfig.
Consequently, nothing should ever be deleted from the .config just
because it was deleted in the .kunitconfig (unless, of course, you
change a =y to a =n or # ... is not set), so I don't see what this
change would do.

Can you maybe provide an example?

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/kunit/kunit_kernel.py | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index cc5d844ecca1..a3a5d6c7e66d 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -111,17 +111,22 @@ class LinuxSourceTree(object):
>                 return True
>
>         def build_reconfig(self, build_dir):
> -               """Creates a new .config if it is not a subset of the .kunitconfig."""
> +               """Creates a new .config if it is not a subset of, or older than the .kunitconfig."""
>                 kconfig_path = get_kconfig_path(build_dir)
>                 if os.path.exists(kconfig_path):
>                         existing_kconfig = kunit_config.Kconfig()
>                         existing_kconfig.read_from_file(kconfig_path)
> -                       if not self._kconfig.is_subset_of(existing_kconfig):
> -                               print('Regenerating .config ...')
> -                               os.remove(kconfig_path)
> -                               return self.build_config(build_dir)
> -                       else:
> +                       subset = self._kconfig.is_subset_of(existing_kconfig)
> +
> +                       kunitconfig_mtime = os.path.getmtime(kunitconfig_path)
> +                       kconfig_mtime = os.path.getmtime(kconfig_path)
> +                       older = kconfig_mtime < kunitconfig_mtime
> +
> +                       if subset and not older:
>                                 return True
> +                       print('Regenerating .config ...')
> +                       os.remove(kconfig_path)
> +                       return self.build_config(build_dir)
>                 else:
>                         print('Generating .config ...')
>                         return self.build_config(build_dir)
> --
> 2.17.1
>
