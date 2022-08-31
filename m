Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234F15A814D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiHaPdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiHaPdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 11:33:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4032FD75B0;
        Wed, 31 Aug 2022 08:33:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kk26so29110557ejc.11;
        Wed, 31 Aug 2022 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ySlGrlk1/qae8TbwPoGGtLZ4RY6cb/qJdCyFNUKnw4k=;
        b=O5aHbfC4ftLEYuWR2lKoTnlB+EEHkTYbNxiLgifnfeWI3p77cSrJHGA0CATa5yilgV
         MoODiwPODnMk7W5nC5YKiPm9IKa67WmAIPQBYtOgmiwUORrlaHXmUwPhA+o/6aYGaoiv
         hb8C3UcA5vpHaVrM3hLYSoAyEjeplyRY9wURdBjfmTEEyVKB9DjLf5RyVLE5ynZd3DYv
         r20zrd/PQrYhHknPCtvb+CIeOS9s7Udu5VkwECjus+J7gC9ym1OzZqO5FB4WaVFxArmd
         K++h6IlBnmPe6qFAT8o1EJKD2fR/jCXnADy6rV8/jgU93M+HYz8AzW9NGzK4JbeCiTO3
         pi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ySlGrlk1/qae8TbwPoGGtLZ4RY6cb/qJdCyFNUKnw4k=;
        b=emcqlF+tS5pxtez3dDFkVsQvIFnNDREX8SWVaZLYfI++ggw2CUXrf24lgVdLefe/Vi
         ULyJEakeB3DJ46IEfcSkWSnWW9mgkDTRlsNhV6DOsGPd5Zl3FgczOlTAlH2hMIQ0rLJJ
         qvffWGSzzRcSuIm3AnICrYCrJ7jE0otBfOnTyCFsWhQRbSwZm+0+67fV54hhs6Lggviz
         FK8I+fMDTs0QeEhcEXmvhe49fO9B3wS5Sr2JpFw6UZ7yqIC2v/j3c/pmu1o6kBbyZz4V
         HaTOj9iCeR56TlKiNKPsodzPmWK7soyEmde+If1RK57hnyYvosHWSKxhNkFV+k3aO2/z
         Az6w==
X-Gm-Message-State: ACgBeo0lKieegsLDtpqj2oTni1IGC97WRKSX8PLe+nA1WWKITZb1kbNy
        kkjdX1qO7RjI4lXgbcyMkHwRG+gaJNgRHhkjk00=
X-Google-Smtp-Source: AA6agR6zLzQyHzCh0SYGCtJ2iVRCCcor95L8jxGfZu91b7yD5fNTVfUcKhZC1aLkvbiIxkBeOxSeLLv1K5tiwN/gUzY=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr21418881ejc.676.1661960029590; Wed, 31
 Aug 2022 08:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
 <20220830161716.754078-6-roberto.sassu@huaweicloud.com> <Yw7NKJfhyJqIWUcx@kernel.org>
 <Yw7o43Ivfo3jRwQg@kernel.org> <cad9a20cadc074cf15dcd0d8eb63b43c98a2f13d.camel@huaweicloud.com>
In-Reply-To: <cad9a20cadc074cf15dcd0d8eb63b43c98a2f13d.camel@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 31 Aug 2022 08:33:38 -0700
Message-ID: <CAADnVQLCyts0JZ7_=rTp8vP67ET4PjVsZ0Cis0XKUpeCdC13LA@mail.gmail.com>
Subject: Re: [PATCH v14 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and set KEY_LOOKUP_FLAGS_ALL
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        David Howells <dhowells@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
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

On Wed, Aug 31, 2022 at 2:24 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> > > >
> > > > +#define KEY_LOOKUP_CREATE        0x01
> > > > +#define KEY_LOOKUP_PARTIAL       0x02
> > > > +#define KEY_LOOKUP_FLAGS_ALL     (KEY_LOOKUP_CREATE |
> > > > KEY_LOOKUP_PARTIAL)
> > >
> > > IMHO this could be just KEY_LOOKUP_ALL.

Since this is supposed to be kernel internal flags
please make them enum, so that bpf progs can auto-adjust
(with the help of CORE) to changes in this enum.
With #define there is no way for bpf prog to know
when #define changed in the future kernels.
