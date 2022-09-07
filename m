Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0FC5B07BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIGO6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIGO6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 10:58:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C105723B;
        Wed,  7 Sep 2022 07:58:35 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p187so11668026iod.8;
        Wed, 07 Sep 2022 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UYoV6lACJxTZHGkj9WSsFQois6n/KilMymp2vYe4Djk=;
        b=N14ELD6J03DJOp1u7J8N9CDZYA1UJl30H6MZSP1ro0LUfYb03sSZzHlx5heAW61Cpz
         dv30ZiWH3qHigi8/PaT8H8fhbsfuNNoV5jOJMW9YmcdloxGj8UPWHPYiyuey5vX2nVrr
         qS+uVTcHVbL9gFTKqtP4SxvsGKffZVl1+vJhO3DBoTJ6NnjdsfKxXGnPIBTucaG0Miue
         Jyg1AXPcz9IAN3BPluHD16byjUFCkwOvXRwz5mO7NXGVNwy9RaHTa42A8xz/XKdal7i5
         bWCI9lzicUfvipABqP920TqivxB5e3g7iX+SuwZYnajtVerui0DPsnhuJsG8DFuQx5z9
         4HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UYoV6lACJxTZHGkj9WSsFQois6n/KilMymp2vYe4Djk=;
        b=ODdhPouiTepyaCx2hLzzqnBcroCR8+3RTBXB9MJDRZmb3J0qT/UUlNdg65MjWIZ0A6
         L9Fhs3fVqQjEZwZJTuTpywzl7GG+544FTYEjjiLOMi65XG6xAxYkI/gtOU1Zew/q3wCd
         rJnkm0sP8DoeZ+ahow5zNgrPjXV4t+uJXMZ7Ej8iNjysEGyba0MJP3tdlzOxMyTjv1OK
         s8ArxrVt2WWkI+2iBEsyV8nw1OFkKrdJbOS8Y60PHP4udT3zdV12V96fjSN9S8SR0PnB
         O0HVaAQsefweA0yhOxKGcSuaiukJ7KF6zJJiM3v/OMlVbymUUKbU3EHpz+yrOb63sHhM
         6cWA==
X-Gm-Message-State: ACgBeo0+nYByIbZ73t+j8GunsglSMwXe9AR8JnYFWicRqYaJcUKIqBk0
        q7hSQSG1mEIDLcI8ClmpLeXo5mT+liIqowLKpp/euLqZ5+k=
X-Google-Smtp-Source: AA6agR7rn3vjpC/MurFyLxG08yrX7ZjhZA6SRUunTu+TNMfEj9FlTVY9nglwbjHtCgf2go9eZusSPxCSDHjIsb6A360=
X-Received: by 2002:a05:6638:3802:b0:351:d8a5:6d58 with SMTP id
 i2-20020a056638380200b00351d8a56d58mr2401344jav.206.1662562714982; Wed, 07
 Sep 2022 07:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
 <CAP01T77aq-UP02JYp1Vu-LE--K1ieCyfKfyZPw-a7DDKQ7_F+g@mail.gmail.com>
 <b846cedb14235db6950a55e7eec2eff9e9ab56ec.camel@huaweicloud.com> <57cedc7a3008248b5147d03e2f4bd0b33ad9a146.camel@huaweicloud.com>
In-Reply-To: <57cedc7a3008248b5147d03e2f4bd0b33ad9a146.camel@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 7 Sep 2022 16:57:57 +0200
Message-ID: <CAP01T764z59qczE37=jf-zPkS2zPuzDyCjdngBDnG-GOovG-rQ@mail.gmail.com>
Subject: Re: [PATCH v16 00/12] bpf: Add kfuncs for PKCS#7 signature verification
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
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

On Wed, 7 Sept 2022 at 16:49, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2022-09-06 at 09:35 +0200, Roberto Sassu wrote:
> > On Mon, 2022-09-05 at 21:26 +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Mon, 5 Sept 2022 at 16:34, Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >
> > > > One of the desirable features in security is the ability to
> > > > restrict import
> > > > of data to a given system based on data authenticity. If data
> > > > import can be
> > > > restricted, it would be possible to enforce a system-wide policy
> > > > based on
> > > > the signing keys the system owner trusts.
> > > >
> > > > This feature is widely used in the kernel. For example, if the
> > > > restriction
> > > > is enabled, kernel modules can be plugged in only if they are
> > > > signed with a
> > > > key whose public part is in the primary or secondary keyring.
> > > >
> > > > For eBPF, it can be useful as well. For example, it might be
> > > > useful
> > > > to
> > > > authenticate data an eBPF program makes security decisions on.
> > > >
> > > > [...]
> > >
> > > CI is crashing with NULL deref for test_progs-no_alu32 with llvm-
> > > 16,
> > > but I don't think the problem is in this series. This is most
> > > likely
> > > unrelated to BPF, as the crash happens inside
> > > kernel/time/tick-sched.c:tick_nohz_restart_sched_tick.
> > >
> > > This was the same case in
> > > https://lore.kernel.org/bpf/CAP01T74steDfP6O8QOshoto3e3RnHhKtAeTbnrPBZS3YJXjvbA@mail.gmail.com.
> > >
> > > So,
> > > https://github.com/kernel-patches/bpf/runs/8194263557?check_suite_focus=true
> > > and
> > > https://github.com/kernel-patches/bpf/runs/7982907380?check_suite_focus=true
> > >
> > > look similar to me, and may not be related to BPF. They only
> > > trigger
> > > during runs compiled using LLVM 16, so maybe some compiler
> > > transformation is surfacing the problem?
> >
> > Yes, I saw that too. Not sure what the cause could be.
> >
>
> Another occurrence, this time with gcc:
>
> https://github.com/robertosassu/vmtest/runs/8230071814?check_suite_focus=true
>

... and it seems like this run does not even have your patches, right?

> Roberto
>
