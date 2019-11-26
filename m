Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8550D10A513
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 21:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfKZUHd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 15:07:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42066 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKZUHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 15:07:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id i5so1264823pgj.9
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6GxmKDvAw1vLMbaYf9F6fSma425avbz24o+1odQiW8=;
        b=kYQJO1E4W2uuHPL5Xt55wCQ3MWajDBCrm0jA7QZ4dZUbiy0qykLO8o+veIsaLEoxXt
         pfjt817CQHNp6x+6IYPeeQmlFOtcfeIKHgQNugJd3twsD93I50yh8E0fYn0cLrJ1rlPn
         sooicOrr2ZAZmlh8o1KYEIqSBd2YEObh3DNg304EXxtvw3bYk3FywkGYpp3pFvdooshg
         TDdpxONLvxs5yE9jjCutSaWrN4ZdvyZgBr2G6TI/LMbhmdftq3K+5rpVuCHgb3pzkqcF
         iICNCzYY5a3tDZpRBnNgpXtApSnFF15lDLdvJwSQ9aZ/NBFBxA/NMHBa+gnXAFtkRS61
         AuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6GxmKDvAw1vLMbaYf9F6fSma425avbz24o+1odQiW8=;
        b=bBFPAV4nYw5+mI397tQR5p+nL+ShtpORdBkxs+CrtY1Ph1Raf8Zes6jz7n1IPTfKi2
         QeZaNIVfnMxJQUHUSBSuDIiUk3V0CYUluDbNwCsrZE5CJ/LSx/UDk1oxrhJSQfAP8SSV
         9aQD4msCwErJPp7E7/QLvf/yOH+shHgo5GIEGkYWs3sNy5grJyA6XVXan7wKpsYOh3cR
         IXotgizkd5xkih50ut0LGiWMeJd6AvU5Cd3g5Gi632OdaneJru3k9BSiSOP995ZRT+qa
         cVKMHw0gF7tDV+2tW19x4beZVhuMSQiXnubDWgNDOijulzgDZJFgStYSiSCbuivTKvSu
         h1mw==
X-Gm-Message-State: APjAAAVtmgIrMlX23/2o1GsRUE4VfTiMPU73BjTeojxNOYhf37C4MFMr
        /ky1wKu61zvd7n5P7VpXJEkwLytehhHHsw7dIj4fgymdshI=
X-Google-Smtp-Source: APXvYqzhtGrx/0AcsUJbNg7CQUdEUUrMdQwSTawPgXjZzKBWJVP5yRg+BPnmr84AYEutaBxY/BaDAxaZQcbnb3V98uw=
X-Received: by 2002:a63:4721:: with SMTP id u33mr274648pga.159.1574798851462;
 Tue, 26 Nov 2019 12:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20191126193313.44181-1-heidifahim@google.com>
In-Reply-To: <20191126193313.44181-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 26 Nov 2019 12:07:20 -0800
Message-ID: <CAFd5g450f1Ds1oeEKoVxmcA1Demxx3jDH5QJ4vpmk8JpkhgDZA@mail.gmail.com>
Subject: Re: [PATCH] kunit: test: Improve error messages for kunit_tool when
 kunitconfig is invalid
To:     Heidi Fahim <heidifahim@google.com>,
        David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+David Gow

On Tue, Nov 26, 2019 at 11:33 AM 'Heidi Fahim' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Previous error message for invalid kunitconfig was vague. Added to it so
> that it lists invalid fields and prompts for them to be removed.  Added
> validate_config function returning whether or not this kconfig is valid.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Looks good to me other than one minor nit below.

> ---
>  tools/testing/kunit/kunit_kernel.py | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index bf3876835331..010d3f5030d2 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -93,6 +93,19 @@ class LinuxSourceTree(object):
>                         return False
>                 return True
>
> +       def validate_config(self, build_dir):
> +               kconfig_path = get_kconfig_path(build_dir)
> +               validated_kconfig = kunit_config.Kconfig()
> +               validated_kconfig.read_from_file(kconfig_path)
> +               if not self._kconfig.is_subset_of(validated_kconfig):
> +                       invalid = self._kconfig.entries() - validated_kconfig.entries()
> +                       message = 'Provided Kconfig is not contained in validated .config. Invalid fields found in kunitconfig: %s' % (

nit: Rather than "Invalid fields found in kunitconfig", how about
something like "Following fields found in kunitconfig, but not
.config:"?

> +                               ', '.join([str(e) for e in invalid])
> +                       )
> +                       logging.error(message)
> +                       return False
> +               return True
> +
>         def build_config(self, build_dir):
>                 kconfig_path = get_kconfig_path(build_dir)
>                 if build_dir and not os.path.exists(build_dir):

Thanks for the patch!
