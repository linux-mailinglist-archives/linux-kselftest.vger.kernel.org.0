Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7980672AB99
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjFJNCG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJNCF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 09:02:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2D3AB5;
        Sat, 10 Jun 2023 06:02:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9b7345fb1so21319611cf.1;
        Sat, 10 Jun 2023 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686402123; x=1688994123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sid9PPnebkV661LCkg884rwv7/EfHsWnCoqGwZtAuUM=;
        b=fhxZj4OkS8aCcj55qX+CEOfaluClflEKfym7Jqt7izDQ98GoAzcgVfN8X6JMvooPZK
         0ta/WHHbhJEfBXjb1+e3wXKlw736PQX3wYQWAXt5z8cUL5snHW8aSouxy/cacofEfXWA
         c39ENWDsvlInvQupPQ8aTho52yKUyt8OibHo7uMR1AFG/vX4MA2/jyC/kJoiclI6MdRn
         11LRm4iSyPaBmRQ+C3ahGdej2hrrs2LS/dj9oJszuK8SoNwxqGD2aL2hkXJflXoLZRcM
         kjlrnbW+NZbwQv3NzMHbLArhwUDsMVc1TZI36Ib4cJnsX4n5rN8KuUCMfioBukQAw/ak
         PUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686402123; x=1688994123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sid9PPnebkV661LCkg884rwv7/EfHsWnCoqGwZtAuUM=;
        b=cq20WDFAOUY/w38uPUvgndBJIltTad/3142JUFvQ8zfoyE9/BsLKVtX3x3MRVrr8Qb
         uCNObSPWuNrZJCKzEMC2EWZ21IdMfM7cn+zJbBCn13wE0v6f5S3kLpgIdDEf8LqONZRr
         vz2Uyx5KePkYCzosJuzdt16I78b1yLx7MgKC1ibN/n64sfNzxRf8jA1CdLhO9/97ujUt
         HOVhGKHjTgDPz4W9/YqBVsA9cXw0rsXsXyoHrx+3O4ZYTU4edY1kAywEoITF3f7a/Zf5
         /IaqF0kPE+Q6FXxw/r/lcMQzgOOGm0YQXA/rrPLOhYkJwDX2/IraBOVJQ8eXjos1SyL3
         EgWw==
X-Gm-Message-State: AC+VfDxpnLfF+WD1TJVdQy52v0TJpD98HdzmlD86KdzfcMxqK4oVJRTl
        oYSNjKs+mpECpQjm3GSCyQj6D+eHgsJSLyXppFmc1TOEO2Y=
X-Google-Smtp-Source: ACHHUZ6LKdPbTm5X31ZA/PsQ9OBswkcS6SK0d8zfA6V4BWnNfU7VbMmoITTr1LD2gSomxZ3X7g2Knha0VevdFa6pgHc=
X-Received: by 2002:a05:6214:268e:b0:621:78a:dd84 with SMTP id
 gm14-20020a056214268e00b00621078add84mr5238735qvb.47.1686402122252; Sat, 10
 Jun 2023 06:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230607153600.15816-1-osmtendev@gmail.com> <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
In-Reply-To: <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Sat, 10 Jun 2023 18:01:51 +0500
Message-ID: <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

I looked into it and tried to use TASK_COMM_LEN in the test. Even
though I included "linux/sched.h '', I was not able to compile the
test because it couldn't find it in the header file.
I dived deep into the issue and turns out header file mapped in
/usr/include/linux/sched.h is actually mapped to
/include/uapi/linux/sched.h[1] in linux source,
where TASK_COMM_LEN is not even defined. Instead TASK_COMM_LEN is
defined in /include/linux/sched.h which is not mapped to any header
files in
userspace(/(/usr/include/linux).
I also tried to find the TASK_COM_LEN in /usr/include/linux/ but I
couldn't find it. Following are the search results.
grep -rnw '/usr/include/linux/' -e 'TASK_COMM_LEN"
RESULTS OF COMMAND :- /usr/include/linux/taskstats.h:38:#define
TS_COMM_LEN 32 /* should be >= TASK_COMM_LEN
Based on this information, I have two questions:
1. Would this require a fix to move 'TASK_COMM_LEN' macro from
/include/linux/sched.h to UAPI headers /include/uapi/linux/sched.h.
2. Is there any other way to access TASK_COMM_LEN in the selftest that
I'm not aware of?

[1]:-https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h

Thanks,
Osama

On Sat, 10 Jun 2023 at 02:43, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/7/23 09:36, Osama Muhammad wrote:
> > This patch will add the new test, which covers the prctl call
> > PR_SET_NAME command. The test tries to give a name using the PR_SET_NAME
> > call and then confirm it that it changed correctly by using  PR_GET_NAME.
> > It also tries to rename it with empty name.In the test PR_GET_NAME is
> > tested by passing null pointer to it and check its behaviour.
> >
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> >
> > ---
> > changes since v1:
> >       -Used TASK_COMM_LEN instead of using numerical value 16.
>
> Please add linux/sched.h here as an include to pull this.
> It is good to add an explicit include as opposed taking
> a chance on it being included from another include.
>
> thanks,
> -- Shuah
