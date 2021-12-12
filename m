Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA124717FC
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Dec 2021 04:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhLLD1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Dec 2021 22:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhLLD1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Dec 2021 22:27:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAE6C061751
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 19:27:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso11784126wms.3
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 19:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7/1LmjCfTtgsVJrg78e51ncNBaiTz2Dg0AiTO5MlKM=;
        b=hQpxgiJHMZ7fvto17xTxPEEXv+mc6K02qS5IBWfpAf6p8I7lJ/djNl35luCUGOxC5Z
         r39hDajmqrJUsboThSol9gxuCfg0z41Zb35a8+IdjU58j1kflwIJgIfVnWtL6+fWWA3H
         w4xLTk0bum9ELf5mOabwyQObhPXmtbaKY5GHMPuN+NL6CbopCnctnz/E2aSzjkPOB19J
         IlfQUGq0+9RHfsWtIAD6p4GpFpJ3+KioxfZcrmTUCvLxuvnmfMDB2eGRRkWbXXzLpSvi
         EUeWPtS68zyfWtKikVxuafhs/RaorRrYL0o+d3pcgVOQjEc/gdlxZSDqRxkIMpMQTgLp
         OnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7/1LmjCfTtgsVJrg78e51ncNBaiTz2Dg0AiTO5MlKM=;
        b=bYocvpxGEsEy1McSneqtgcVPQJYaE2zuSeW+M4024O8b4ufJEAoO7vSWIBTEbMNXzf
         VfamMVHD6fw7YQWp+bg5e/JPP1b7cTaor0CqAKpFaUDdBBfRGPuzDczGS2BIv43F6bTN
         8/gbz5E7j7zP5gpYrQAlTw9UVhxkorzu5vGs/fdCvOEji0tVufml+9Yd1k7Dmp7zPOjR
         XOZQM3RheEz04KHxrTCs1FqvZqBOLN9ve5TOs7wwvB6ONi2mwxoMnTCgErQTez/TOXd8
         9TBX6TFo6niSFGP0JjV03sPxKlEhm+R7zKx4JIGyKt7Pl2qKdwJLmyKyoN2T44TiX1Ka
         jMWA==
X-Gm-Message-State: AOAM5314conbqHf2AwZcA7LUvGLTQg+tJVs5HHXECSUPFGMrQiPQzpZ7
        y6VsBSgUGIEpHLjoBsA4bfHA9SwnonTNY0BARsvvf0/JsYIePA==
X-Google-Smtp-Source: ABdhPJwJauiW3GREmDRH7URpRAc3XJC8xMT6+XyA+IvtD4Q5jzrwsQEuxTOQumQj6SWJVMdbIEX3AfdJlwvESe+jb3g=
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr28317204wmq.8.1639279627133;
 Sat, 11 Dec 2021 19:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20211211084928.410669-1-davidgow@google.com> <CAGS_qxqAqnEo5iojk85uhuD9dcRNxTw030nfCMCsMADm9RsmbA@mail.gmail.com>
In-Reply-To: <CAGS_qxqAqnEo5iojk85uhuD9dcRNxTw030nfCMCsMADm9RsmbA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sun, 12 Dec 2021 11:26:55 +0800
Message-ID: <CABVgOS=QN4PPiveokb2tuJ70RD=SnHh1PPge2P30rmHDbE=uWA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Default --jobs to number of CPUs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 12, 2021 at 4:37 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Sat, Dec 11, 2021 at 12:49 AM David Gow <davidgow@google.com> wrote:
> >
> > The --jobs parameter for kunit_tool currently defaults to 8 CPUs,
> > regardless of the number available. For systems with significantly more
> > (or less), this is not as efficient. Instead, default --jobs to the
> > number of CPUs present in the system: while there are as many
> > superstitions as to exactly what the ideal jobs:CPU ratio is, this seems
> > sufficiently sensible to me.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reminder: the unit tests depend on this hard-coded value.
> $ ag '\b8\b' tools/testing/kunit/kunit_tool_test.py
> 422:
> self.linux_source_mock.build_kernel.assert_called_once_with(False, 8,
> '.kunit', None)
> 529:
> self.linux_source_mock.build_kernel.assert_called_once_with(False, 8,
> build_dir, None)
>

Gah: that's what I get for rushing this through at the end of the day.

v2 will have this no-longer hardcoded, but call a get_default_jobs()
function which calculates the default.

> > ---
> >  tools/testing/kunit/kunit.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 68e6f461c758..2cb6c7db5683 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -310,7 +310,7 @@ def add_build_opts(parser) -> None:
> >         parser.add_argument('--jobs',
> >                             help='As in the make command, "Specifies  the number of '
> >                             'jobs (commands) to run simultaneously."',
> > -                           type=int, default=8, metavar='jobs')
> > +                           type=int, default=os.cpu_count(), metavar='jobs')
>
> Just looking for edge cases:
> https://docs.python.org/3/library/os.html#os.cpu_count says
> > Returns None if undetermined
> and
> > This number is not equivalent to the number of CPUs the current process can use. The number of usable CPUs can be obtained with len(os.sched_getaffinity(0))
>
> I assume the None caveat is mainly for other operating systems and
> doubt it'll impact any users.
> The second point is a bit more interesting, but still niche.
> Up to you if you want to use that instead.
>
> Super unscientific comparison (n=1) running all on CPU #0
>
> $ taskset 0x1 ./tools/testing/kunit/kunit.py run --jobs=1
> Elapsed time: ... 155.978s building ...
>
> --jobs=2 (some people swear by the 2x ratio)
> Elapsed time: ... 158.891s building ...
>
> --jobs=8 (Old behavior)
> ...
> Elapsed time: ... 171.448s building
>
> --jobs=32
> Elapsed time: ...  170.765s building ...
>
> So the overhead of j being "too high" isn't that bad and it doesn't
> seem to matter much either way.
>
>

I'll go with len(os.sched_getaffinity(0)) in v2: it is technically
closer to what the intent is here, even if it's not a problem in
general. Putting it in a helper function will make the
len(os.sched_getaffinity(0)) call less unwieldy, IMHO, too.

> >
> >  def add_exec_opts(parser) -> None:
> >         parser.add_argument('--timeout',
> > --
> > 2.34.1.173.g76aa8bc2d0-goog
> >

Cheers,
-- David
