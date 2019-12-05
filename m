Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326E01144FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 17:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfLEQki (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 11:40:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37366 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLEQkf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 11:40:35 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so4289903ioc.4
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2019 08:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnSZ1HocZmFXibZc/RmleTCK7QzGnhXUqE2Wqe01NTg=;
        b=WVUhFM/Gu50kF5obPXp291eiDa3l4PfApYvEAiDm+pzyIVPqSFwEvdshHnE49VWUtV
         0sxHOexRG8QRvCbiheB/EO7/MV32WnC2flHRnrWoKjYhEsxjhPWB+CmnYEpWJjjslWXY
         JbNCfR5Ddm3do9T9YzQyeAGUjLjRvcbc0gz2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnSZ1HocZmFXibZc/RmleTCK7QzGnhXUqE2Wqe01NTg=;
        b=heeEaJTyVNDhVVToclOQEeE6rLtwvvJ6qEyzLgU9+U89crQ6qT0hKXCJPkFM0XTmi4
         pnwWifraRDu0oMOrAUtdZrFG2hC+5tVklfAT4Ctyofvh6QJM5wJ+PMoYgA8w9+w8NgSa
         WvWUly1YJ5MB+ILm9OJS8Sm7lMOz9ThdcuZCggwLZhclLTaWsi5dPX2dIvCIb+6B1lvd
         mx9QpcFAQjIN7YqkdxJjQe+8wJZ5a9jlRJZkLjN2rLvHgq+EsRbKDsVk0UuYNAlTHsPp
         ZQe5DU53UbAY47wCturYL17EnMbF5RvlHFoHToJmoabF4AOcjJqD7qcK5BEMldWM6K6z
         9NmQ==
X-Gm-Message-State: APjAAAVA4EiOv4Y6tuf3cm1K+vbITNz7WAqCu19u/I/+/Td8GO/qmAGz
        QYjnYJkyoOx0711J/2Rhl9PY/SqXcaUH1Aw0OUI0Hw==
X-Google-Smtp-Source: APXvYqwvrkf93Tp7ZF+8isPCaGzNcsH1taXJLgkRqEuBouTDgW9mh284rB06SYQo3eRERN3v/u2u6S4p0JdI9cJgNBQ=
X-Received: by 2002:a02:9f09:: with SMTP id z9mr8866500jal.119.1575564034137;
 Thu, 05 Dec 2019 08:40:34 -0800 (PST)
MIME-Version: 1.0
References: <157554844882.11018.13436399905210284553.stgit@devnote2>
In-Reply-To: <157554844882.11018.13436399905210284553.stgit@devnote2>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 5 Dec 2019 08:40:23 -0800
Message-ID: <CAJ-EccNKk30b_wtvz=PUVmMVfF8YNagXMcy3Uhj53DzFbgmb6A@mail.gmail.com>
Subject: Re: [BUGFIX PATCH v2 0/3] selftests: safesetid: Fix some bugs in
 safesetid test
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jaswinder.singh@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 5, 2019 at 4:20 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the v2 series to fix build warnings and erorrs on
> kselftest safesetid.
> This version includes a fix for a runtime error.
>
> Thank you,
>
> ---
>
> Masami Hiramatsu (3):
>       selftests: safesetid: Move link library to LDLIBS
>       selftests: safesetid: Check the return value of setuid/setgid
>       selftests: safesetid: Fix Makefile to set correct test program

These 3 fixes look good, thanks. Were you thinking they would go
through my SafeSetID tree or is there a dedicated one for selftests? I
guess if you're not sure someone else on here can chime in, or I can
just take them through my tree if I don't hear anything.

>
>
>  tools/testing/selftests/safesetid/Makefile         |    5 +++--
>  tools/testing/selftests/safesetid/safesetid-test.c |   15 ++++++++++-----
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
