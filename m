Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF25FC443
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJLLV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 07:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJLLV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 07:21:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE675C1DA9;
        Wed, 12 Oct 2022 04:21:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pq16so15020279pjb.2;
        Wed, 12 Oct 2022 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfmxjn/LZkgnLjis62IDg/akcgQ4TS7vGQhjsSjGmP8=;
        b=Vk5Ep31Y1I+ZHXfXE0RqMVDcHrFvikzjCmT9qCNvpbPJ/HO0Ai95f6bzJ/51gSKVUO
         CEknAU9eM6Wbn6byJTZ2N2bv84tsoCJL0IK2eN1h24N97Ie5US4USt/GGakEAO2pEn+R
         Tkm/j0GsLprV2YZkG3jiSJw/YvCn35MoMeN81Vz3RcPJzCVvjzQBtEvaxetLQlzljSJS
         TfYA7XMbrGipRRaF+YS2sxVhJSRM1ESRZf6LwZvgXXcTRI/mGtvH//TaA9TXhgiQ9aQZ
         BqRHkvCjPTDu6z/qboMaexZuXmqwsF4CmkfiuLyf1gkIy4rQHtEI3rzK5pbYUXCaDu3Q
         v4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfmxjn/LZkgnLjis62IDg/akcgQ4TS7vGQhjsSjGmP8=;
        b=wdHTkUbEslIAOLeag/itGUJ85u15X1Ti0gmSEvol5A+UgbsO0gTCM2eSQtSs7zUi7M
         rzE512XCnpHn6K22cVWoL7oAWyQRqditIQ4NOZsRA+4nttAA8YB5GWqPA0Cp1VH3PO6o
         AdK6ZpgvUbe1X3hlEuK9e28tJYtbh/QV5X0BZE+xUPF6ChG7Vbg0y40myQYJS8sToXXy
         ya17sWtwCRbgryzM7IceAZ5UXijwaalNWyRJNtW3Af2A4gk6P/y8QT9FnUE6gI7IQ2cS
         vUBcftDhZIB7zbq35qsmEqKKJE56syW7KvvICKfZBN2n5D7AtkblfLjlfavRj9ix9oMX
         qoXw==
X-Gm-Message-State: ACrzQf0vM3ZNZFujhgPqdDkrD1uEqOLm9kzjkqHIvdg6q4aKqirVuK/6
        dKBRWHBohvAIlCmreb7cHXRntduda1dl0JvNpGshExYBZ+s=
X-Google-Smtp-Source: AMsMyM7SQVj6RBkIGx8NILCYqdxZpmcLDg8U+rrj+NjTTnWbB5axiXaSE2wK7ZYRmCO0IE2Wqvh5etesI8kO1egl1cs=
X-Received: by 2002:a17:903:120e:b0:179:fe49:a952 with SMTP id
 l14-20020a170903120e00b00179fe49a952mr29396866plh.21.1665573683310; Wed, 12
 Oct 2022 04:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221010074207.714077-1-svens@linux.ibm.com>
In-Reply-To: <20221010074207.714077-1-svens@linux.ibm.com>
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
Date:   Wed, 12 Oct 2022 12:21:11 +0100
Message-ID: <CADyE4xEkQo+AEEbRwcsQDcU_tWAH_m-XE6iZYRnw97Hz9ZHxYA@mail.gmail.com>
Subject: Re: [PATCH] selftests/ftrace: fix dynamic_events dependency check
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sven,

2022=E5=B9=B410=E6=9C=8810=E6=97=A5(=E6=9C=88) 8:42 Sven Schnelle <svens@li=
nux.ibm.com>:
>
> commit 95c104c378dc ("tracing: Auto generate event name when creating a
> group of events") changed the syntax in the ftrace README file which is
> used by the selftests to check what features are support. Adjust the
> string to make test_duplicates.tc and trigger-synthetic-eprobe.tc work
> again.
>
> Fixes: 95c104c378dc ("tracing: Auto generate event name when creating a g=
roup of events")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Thanks for fixing it!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  .../testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc | 2 +-
>  .../test.d/trigger/inter-event/trigger-synthetic-eprobe.tc      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicat=
es.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> index db522577ff78..d3a79da215c8 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Generic dynamic event - check if duplicate events are cau=
ght
> -# requires: dynamic_events "e[:[<group>/]<event>] <attached-group>.<atta=
ched-event> [<args>]":README
> +# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<at=
tached-event> [<args>]":README
>
>  echo 0 > events/enable
>
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/tr=
igger-synthetic-eprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/i=
nter-event/trigger-synthetic-eprobe.tc
> index 914fe2e5d030..6461c375694f 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-s=
ynthetic-eprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-s=
ynthetic-eprobe.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger eprobe=
 on synthetic event
> -# requires: dynamic_events synthetic_events events/syscalls/sys_enter_op=
enat/hist "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]=
":README
> +# requires: dynamic_events synthetic_events events/syscalls/sys_enter_op=
enat/hist "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args=
>]":README
>
>  echo 0 > events/enable
>
> --
> 2.34.1
>


--=20
Masami Hiramatsu
mailto:masami.hiramatsu@gmail.com
