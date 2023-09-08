Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F76798825
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 15:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjIHNxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 09:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjIHNxr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 09:53:47 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85121BF4
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 06:53:42 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bf66a32f25so14592101fa.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694181221; x=1694786021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk5RLnrnvhNAIkRA+BMVhrpIi3v+xSod2h+zzv+FwRU=;
        b=E6FTV/ARJc1sPI9xs3Qz7wXyJCizcsvUj/Wqt9MiNd/8fi3EG1YvRDeDLltZ+AFy1K
         Z2KENS9zv9mjSmuhv8Jws2d5an3r72iIMpyLeTY1bbe2u+HXIJIYitAqHBv2CLTd6PJh
         VYW+0TSsh+ibTgejXdch2PBNU9ufU3gNCksdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694181221; x=1694786021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk5RLnrnvhNAIkRA+BMVhrpIi3v+xSod2h+zzv+FwRU=;
        b=TB7OYM/bgdWRHOeo57VCmKuIiFYWrXfSiRDLco4Blr38yB59bafu4CTmHC+RufZQOe
         7ObrB4HOzSdBQJnAF1NI90Wdq9hjzJrOk88lhjC16ssf6dxLNnsjcKK/nUjLv7Lyf9id
         KfTeesnGCrCqgpFIzSLpF9m3kyd2AWVJUBxDN6H8FDOBgu06r5ZT0TGyvsXljnLiOLqa
         Z8TqvCSTbXK3DI9VATqZnFMgjI+23f4l8162mpIomg5nD+cy2Hev7c5vAgR7yrAvW39u
         C0lNO7FDVugDyhEOAx9dlMjT34GHGrD3lMyKjhxec5m0PA0z/VfuZbuccA8Mz1rQGtzf
         yWJQ==
X-Gm-Message-State: AOJu0YzbQBNWjpsDcUljVzOn3TAgm4XjiIRbK7oirzwyZv30qhoJgDcJ
        w4ugPKGUZcMgbTIu6gyzhMnyf81VF3EZP1m4Qn42kUk6DYsT0HlN
X-Google-Smtp-Source: AGHT+IEIHTIzxn4/TggJPFsx2XF99VqeSdnxqqoXJAUrJV1HapjE/VT2B66m9pwyvnmkKIa4qoDwrI1qc7nClGYo53s=
X-Received: by 2002:a2e:86c4:0:b0:2bd:beb:4aca with SMTP id
 n4-20020a2e86c4000000b002bd0beb4acamr1950228ljj.13.1694181220873; Fri, 08 Sep
 2023 06:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230908033047.2537010-1-joel@joelfernandes.org> <df66924b-d484-457f-8c79-21aadc4c13ec@paulmck-laptop>
In-Reply-To: <df66924b-d484-457f-8c79-21aadc4c13ec@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 09:53:30 -0400
Message-ID: <CAEXW_YTjDM9LWKiupgOXwfsz7RnNT24UEQ=RZB+3n1VdJRNqvw@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/torture: Improve badness extraction from console logs
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 8, 2023 at 8:08=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Sep 08, 2023 at 03:30:46AM +0000, Joel Fernandes (Google) wrote:
> > Currently console.log.diags contains an output like follows:
> > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_t=
asks_trace_pregp_step+0x4a/0x50
> > [ 2457.542385] Call Trace:
> >
> > This is not very useful and easier access to the call trace is desired.
> > Improve the script by extracting more lines after each grep match.
> > Provide a summary in the beginning like before, but also include detail=
s
> > below. Limit the total number of issues to a maximum of 10. And limit
> > the lines included after each issue to a maximum of 20.
>
> Much better!
>
> The above commit log would be better something as follows:

Looks good to me, I will update it to use your version, thanks.

> ------------------------------------------------------------------------
>
> Plus please see one simplification below.
>
>                                                         Thanx, Paul
>
> > With these changes the output becomes:
> >
> > Issues found:
> > Line 6228: [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h=
:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> > Line 6245: [ 2457.542385] Call Trace:
> >
[...]
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > v1->v2: Limit number of issues reported and include summary on the top.
> >
> >  .../rcutorture/bin/console-badness.sh         | 42 ++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh =
b/tools/testing/selftests/rcutorture/bin/console-badness.sh
> > index aad51e7c0183..2612a4931723 100755
> > --- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
> > @@ -9,10 +9,50 @@
> >  # Copyright (C) 2020 Facebook, Inc.
> >  #
> >  # Authors: Paul E. McKenney <paulmck@kernel.org>
> > +INPUT_DATA=3D$(< /dev/stdin)
>
> Long runs can have extremely large console.log files, which might not
> play well with shell variables.  So this really needs to go into a file.

Thanks a lot for this feedback. Just for completeness -- it is the
grepped lines (containing bad strings) that go into a shell variable,
not the whole file. That can still be quite large so your suggestion
is well taken and I will make the changes as you suggested!

[...]
> One issue here is that if a number of badness strings occur in console.lo=
g
> in quick succession, there will be overlapping output, as in a given line
> from console.log might be printed many times.  For example, "WARNING"
> is often almost immediately followed by "Call Trace".
>
> In that case, is there a nice way to print the lines starting with the
> line containing "WARNING" though the 20 lines following "Call Trace"?

Yes, maybe I can coalesce them somehow since we do have the line
numbers. Thanks for the suggestion! I did notice that too but now that
you mention, I will improve on that.

Will post another version soon, thanks!

 - Joel
