Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3F681AD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 20:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjA3TwS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 14:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjA3TwR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 14:52:17 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59C4617A;
        Mon, 30 Jan 2023 11:52:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m2so34654471ejb.8;
        Mon, 30 Jan 2023 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sSc4g7nvJKandIv/rMf9SszIbfj3jQh7I5IHKjdlPVs=;
        b=SxEpUCfK9Oqj2XYYB6c/P+mZcr9oXylUbJfrvqrAQg5TAe8djCKBliswqP8D3jelkZ
         aKLAkv0SkyDGkJsSniATXnyYwGQ9KfGpDNTrILlxXuluFsVT2epqbtqnN3XTD4/JaMO+
         uWJ0HsRUPFe5n2YBimAivCTYEUZjgNmshaMlLeZsoN9h/EGh9snc6KMOolS0WNgMWywt
         4YdaeoyqFRTcQ5rJmF4i1sNOYLv5GgDA+KWcynfsXComcdsNisou7TydkMIzJ+f87rrx
         qUZ9DprgLB+x70vv18//RVhmE2O/c+OVeqSPXS3Z8j/uO2/2Ps9+MzIdylqYBRIjUM0s
         Dwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSc4g7nvJKandIv/rMf9SszIbfj3jQh7I5IHKjdlPVs=;
        b=oWsAbo8ik8l6ozlV5te2hVQnjGlw/Xun7x8XWtSO3TyQTXF0V2Rc3TsAH8XwqmZ4Q4
         /B242/A8T4H903pv1BQaWMfn9nW1RIVi3ynQJrfHlly3mXFO+hVYO1/yMkbBCGgCThyK
         uMYoLv3IATEiI3tuw7MbQie9Z+fnzuG8DfRe7hmKkH5oMkwY3h81d4nAx8XyzEqNp+Zq
         OzIEoo+LBsce4pcUn7VXOh4D0m+Y8m5wbfShZut+ARgSBy4wMzMnPpvgY5w2AF2bXECu
         wlnkLmeNY6yNFZ9QB5XkQ5gsQ89g238JznnZ2hkq3gp2TLb9reAxnG63hw1HIQHviSvc
         +vMw==
X-Gm-Message-State: AFqh2kpFZ9jRAMGE2wfgC0GPM2pw0aHS2vOR5KGx3mp9HSh036iECKdk
        ZLqaSxusFkmT0zIOYaeUtLfS0ouGMVau4nhfXManNDVm4zk=
X-Google-Smtp-Source: AMrXdXudTqgdM3+I8mgvgkYxiO4cmG/GpQA2LBqWtWyKEb7WoFRmj1FeTe8fWoVxZ92AbUm1q4YUsT92cIYd2WqVcM0=
X-Received: by 2002:a17:906:380e:b0:877:5b9b:b426 with SMTP id
 v14-20020a170906380e00b008775b9bb426mr8031462ejc.12.1675108334423; Mon, 30
 Jan 2023 11:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20230130181915.1113313-1-zwisler@google.com> <20230130181915.1113313-4-zwisler@google.com>
In-Reply-To: <20230130181915.1113313-4-zwisler@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Jan 2023 11:52:03 -0800
Message-ID: <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] selftests/bpf: use canonical ftrace path
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 30, 2023 at 10:19 AM Ross Zwisler <zwisler@chromium.org> wrote:
>
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
>
> But, from Documentation/trace/ftrace.rst:
>
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
>
>   /sys/kernel/debug/tracing
>
> Many tests in the bpf selftest code still refer to this older debugfs
> path, so let's update them to avoid confusion.

I wish that was the case, but in reality there are still systems
out there where tracefs is only mounted in that old location.
For example in one my VMs:

$ cat /proc/mounts |grep tracefs
tracefs /sys/kernel/debug/tracing tracefs rw,relatime 0 0
$ ls /sys/kernel/tracing/
$ uname -r
6.2.0-rc5-01030-gc1a3daf7363b

So this change will break the tests. We cannot do it.
