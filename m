Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97C873E97F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 20:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjFZSgo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjFZSgn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 14:36:43 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93181DC;
        Mon, 26 Jun 2023 11:36:40 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635eb3a1d93so2932506d6.1;
        Mon, 26 Jun 2023 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687804599; x=1690396599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Saqf++aQwl6xF1LIXzZ525kejntUO5u9ymt5w3hstmY=;
        b=fpgUN78PxoSf3SHWfU+rQIstNMm8SoAgc/D4eyzw7ccrhk/N+hCHQoH1RDvO9QZvX5
         wsS3sC81RRWdQ2Yir7FvCT0yR+2KeSvGOxAGtkjCrNT5gR8sjEruP4T5qJ9jNvzCI0TN
         tM7dvvUEgkx014kNb8HU6A+dP+xUDQ5aqd20Nq7/vuOt+ODRchFr28bPnHMmfXym83L1
         yPRBoO13oanyALmq2EQdLeoFV7C6h0U+6ezAeY4pQ64mwCPs9ZKaiYFtAm07FVVhuPJF
         NrsYP8B5C/IFr/SXcItD93LOown9efVlMcxv0019N8JR+yBcFrArfTR8858XKGjeMAkB
         wkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804599; x=1690396599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Saqf++aQwl6xF1LIXzZ525kejntUO5u9ymt5w3hstmY=;
        b=EKIdl37acyP5gE5GRilRN6mnqZCdl9ZQMp7HqYJ1i4zp8MXSM2HCZQQuEBM7npIrl3
         Zpl94glG1aumckbbunecGW6VnDuF/s5BTDT4rwvzPe42uvDgT5G5PUcaPVpn58wwYzwR
         Cr9+Y0ah8aSABbe6kPhI5fO2OSQ8drKoRUYwFW43tHomS73sm5cetvnTMYU1Cfo5NhRS
         6Qoxl6EbUXEtPsChalH6mlmA9lIc4/arrD4lUV1vJHNKXGFGvJFaJzCe+/erWVFvU0eU
         FIhxHm1S0Wj5V3DU+JbaGuL7v3eC2t+ofGrTmvS/LvQkxIO7XKW2jG1EJ2cQCla+v1j7
         J/2A==
X-Gm-Message-State: AC+VfDxDPpdp+o2fWYAKZt/oI3Bt5/XZvGLbEAyyGUYj9/zzqZSuI3hL
        C7eFRuKQqxDfCJVf2i5sdDs9gRJadUNMKqUI+lceCZ8p
X-Google-Smtp-Source: ACHHUZ6i/NdcLdpqQu19Scj3mAVZNhAacTX/czYtDFNCf1fchd/sIG4Wsw/6Uwzu5g7qwlGE4ZGaMks0gGYPpfcRcuQ=
X-Received: by 2002:a05:6214:493:b0:62f:ffcc:337a with SMTP id
 pt19-20020a056214049300b0062fffcc337amr42466272qvb.25.1687804599337; Mon, 26
 Jun 2023 11:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230607153600.15816-1-osmtendev@gmail.com> <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
 <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com>
 <3c03e28b-8006-a4ac-30bc-6aaf83ccb5d5@linuxfoundation.org> <CAK6rUAObT-kQVGddhvxxtaKPcuaDddM6ipEDXuECCFtpR-GV6w@mail.gmail.com>
In-Reply-To: <CAK6rUAObT-kQVGddhvxxtaKPcuaDddM6ipEDXuECCFtpR-GV6w@mail.gmail.com>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Mon, 26 Jun 2023 23:36:28 +0500
Message-ID: <CAK6rUAMuYTUhqcGmDrmeEWnigy3X4OxNb4zmHc0TmcVJ79MyHg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Any feedback on this patch?.

Thanks,
Osama


On Sat, 17 Jun 2023 at 18:01, Osama Muhammad <osmtendev@gmail.com> wrote:
>
> Hi,
>
> Yes, I did install the latest kernel headers and TASK_COMM_LEN is not
> accessible in userspace.
>
> I looked into the test which uses TASK_COMM_LEN but the test defines
> it in its own header file.
>
> Example:  https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/pyperf.h#L13
>
> TASK_COMM_LEN is defined in include/linux/sched.h, but this header
> file is not exposed to userspace.
>
> TASK_COMM_LEN is not defined in /include/uapi/linux/sched.h which is
> exposed to userspace kernel headers.
> Please find the link to the header file exposed to user space :-
> -https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h
>
> As for arm64/abi/tpidr2.c It includes linux/sched.h which will be
> /include/uapi/linux/sched.h because the user space program is
> including it.
> So it also cannot use TASK_COMM_LEN directly.
>
> Regards,
> Osama
>
> On Tue, 13 Jun 2023 at 02:56, Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > On 6/10/23 07:01, Osama Muhammad wrote:
> > > Hi all,
> > >
> > > I looked into it and tried to use TASK_COMM_LEN in the test. Even
> > > though I included "linux/sched.h '', I was not able to compile the
> > > test because it couldn't find it in the header file.
> > > I dived deep into the issue and turns out header file mapped in
> > > /usr/include/linux/sched.h is actually mapped to
> > > /include/uapi/linux/sched.h[1] in linux source,
> > > where TASK_COMM_LEN is not even defined. Instead TASK_COMM_LEN is
> > > defined in /include/linux/sched.h which is not mapped to any header
> > > files in
> > > userspace(/(/usr/include/linux).
> > > I also tried to find the TASK_COM_LEN in /usr/include/linux/ but I
> > > couldn't find it. Following are the search results.
> > > grep -rnw '/usr/include/linux/' -e 'TASK_COMM_LEN"
> > > RESULTS OF COMMAND :- /usr/include/linux/taskstats.h:38:#define
> > > TS_COMM_LEN 32 /* should be >= TASK_COMM_LEN
> > > Based on this information, I have two questions:
> > > 1. Would this require a fix to move 'TASK_COMM_LEN' macro from
> > > /include/linux/sched.h to UAPI headers /include/uapi/linux/sched.h.
> > > 2. Is there any other way to access TASK_COMM_LEN in the selftest that
> > > I'm not aware of?
> > >
> > > [1]:-https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h
> > >
> >
> > The best source is Linux mainline.
> >
> > Take a look at test files that include linux/sched.h
> >
> > arm64/abi/tpidr2.c is one of them.
> >
> > Did you install headers before compiling the test?
> >   make headers_install
> >
> > thanks,
> > -- Shuah
> >
> >
