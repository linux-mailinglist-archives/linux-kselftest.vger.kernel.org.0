Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205A42F6FB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbhAOAuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbhAOAuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:50:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04663C061575
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:50:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b5so4222996pjl.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ho8tSDsbdMAWcbSQB7qHxvHQ7RCwwJXQ02ScAO8i3AM=;
        b=Il+H0IdlHx+Lyp8zSGM53G/jn4/7xbTnE+2Demqok7EY/gK/WfneQ6exvbg106bIeF
         csDUKTZ20buUc/EiyY3md0VHWSHOUK0lpQPqz1iILJWxAgQHN8jBYJh35TOHEW5wUzmO
         NF36+kIWU6HXEU6UAtg31efn2grT0uQn+dRUG6kmsH3F/JY9fxrwFI48CdosOMI4iuRz
         DVyvuFT6FypMOx7VhLzcp8qvUL4WmPBDpE4XCKzQZUDEJksZdQHuwiPIP9qo+AGmR/ru
         sYtkHa8Rz2QkcRg2NtshhbYhcogDCWf47GXhsDeklhlqjvTZn5ieAzalmuxWhI3QpgME
         bPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ho8tSDsbdMAWcbSQB7qHxvHQ7RCwwJXQ02ScAO8i3AM=;
        b=E3ieVXNUYi8e5JasRkEllBNwbie1YFZG410jEu/YPHDNIPnrJ2zvnjG8foD9/ey1OR
         V8KOHNvJ2EdpIWQFqWaY00aTZpOaqxJ9tch61PKcJri5PfriPimHBvUxf0GUXsJONibF
         lN90cgpWNlZx5Lowu5tUgPVrAxUN17ibRXWdZQyRTL9SrDslCeCBKwtF68KZ7Mxk3Q9J
         RwaqfHZOG6cs9YDDxUxk/+F+W5SwwaMuhx2v/Z64UNxtl1T0HaK0ecE9axrvgpAK2vqY
         Wm7n5vpL29Bg9o/Yt2m/UuPuT41rolq1A7jC6CtnbHrXJMaq9Wq+gFXmbBcpeDeDntKa
         Ee6Q==
X-Gm-Message-State: AOAM533pLwroEJeiruLldRbHBxpc0XdqhAmQNs4lz2FP4/uBAYR+yMMA
        SKyyTXeI6hFO4uX27QcHSQqaenZ1tMFnkClT3s2LGQ==
X-Google-Smtp-Source: ABdhPJzzgUNTHTMpkmUDZV/M1d1sVdV/CRCSTU9bkp6207tjwCDmrA+Zo3kMMLqRTlLoMjsGW+9s9yiCDyGoJ0mw0+M=
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id
 x7-20020a170902fe87b02900da5d3b4a84mr10135815plm.51.1610671813265; Thu, 14
 Jan 2021 16:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20210115003913.1406896-1-dlatypov@google.com> <20210115003913.1406896-3-dlatypov@google.com>
In-Reply-To: <20210115003913.1406896-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:50:02 -0800
Message-ID: <CAFd5g47TVzNHYjm_HiBFWsF-WLA3Sa+GFhJMka29T8Hoes_YgQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] kunit: tool: move kunitconfig parsing into
 __init__, make it optional
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

On Thu, Jan 14, 2021 at 4:39 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> LinuxSourceTree will unceremoniously crash if the user doesn't call
> read_kunitconfig() first in a number of functions.
>
> And currently every place we create an instance, the caller also calls
> create_kunitconfig() and read_kunitconfig().
> Move these instead into __init__() so they can't be forgotten and to
> reduce copy-paste.
>
> The https://github.com/google/pytype type-checker complained that
> _config wasn't initialized. With this, kunit_tool now type checks
> under both pytype and mypy.
>
> Add an optional boolean that can be used to disable this for use cases
> in the future where we might not need/want to load the config.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
