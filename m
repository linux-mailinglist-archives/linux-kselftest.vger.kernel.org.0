Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8C728ACE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjFHWCm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHWCl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 18:02:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08AA1BE4;
        Thu,  8 Jun 2023 15:02:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so1432714e87.1;
        Thu, 08 Jun 2023 15:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686261758; x=1688853758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5KKRzmBzOKqm2z8tAEDfQa10e/C19M+QQIiqm4uKw8=;
        b=m68m1ujJRGDqm5h5uysjsl5kXho3QN7dU53etI5gdpxuXmYI0ghMiWABgO5Ix53CIj
         MKdXiAgPo+ImaCtXbPjOuIh78eAZHT7ScaytWQws9o43nrOcPeQy9j0vFuJiCMhc60Xi
         EFKEQBW+ckHkiIgVDMa+pifJW2hESPt485WSO7tr+JeARamfXwl2eMrAF6q4Mb0tu8hz
         quSkccXUxFXXMQb8cLKO9jmlTNrasACBWUb66pI9gWPx+oAVC/4CCqLJGlOph/2XhLPi
         9uar0npYthBkGLXcyNc3XioE9SWw5Md/dCKRsZBXAZBE2OAf9ufR3vkSxpIcUJaDGaFZ
         mjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686261758; x=1688853758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5KKRzmBzOKqm2z8tAEDfQa10e/C19M+QQIiqm4uKw8=;
        b=c0Cv48+niEfa6EhoKNU6eVcC2lScdOk7EJQe0OfeqTBGIfTECgN6CJn3i1QR57MTqD
         D5DQqlYPe0pGsNRmm83CmPTjazMqhTHKVSzzsgVIzT7am7484yXB4LTwUK9qdte6Pi5X
         yoyh5owQktEgoJSwPA3UOtmBE1C9R6mwOtR+/LpLi+5t8LQePlc2mcVrzZGeGc3YLyz7
         P0MqfdQwQlAzMCoZJ4QIliif+UXKFBzbP2YrB1jI8eFYIAjGxm5s2HpjVdvwfaiB65Rq
         JEcuCsvsjCpvlMS6qFlurzQhP1lNJJRgRCHuXl10l9cNOKdeFfFjAQZVknSbQIgXcMdh
         ZAwQ==
X-Gm-Message-State: AC+VfDy+2CUfvaPoYLkTe+Bs8JOx5ZjNnctHztmPN6pbhtPEGSXQMPTA
        exPtFTG3OmW4oC9lNPmDgGFZTJg/N2av892u2QY=
X-Google-Smtp-Source: ACHHUZ6/6jSZSt6ax2bFu/vDu68+UujonpNAFo2ClX0MzqdKqlXBKZ2V+ZEty9FFdldqmq1yOWQENKotYjfXCP0RVho=
X-Received: by 2002:a05:6512:39c2:b0:4f6:56ca:36fc with SMTP id
 k2-20020a05651239c200b004f656ca36fcmr129190lfu.6.1686261758005; Thu, 08 Jun
 2023 15:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686166633.git.kjlx@templeofstupid.com> <c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx@templeofstupid.com>
 <04c149d2-4b7d-f1ee-28b7-3a7ff0c7aa51@meta.com>
In-Reply-To: <04c149d2-4b7d-f1ee-28b7-3a7ff0c7aa51@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Jun 2023 15:02:26 -0700
Message-ID: <CAADnVQL0qNQqoFAXq9NJ5-QR4wPtSruaeJ70q6DKv4z1iv3x8w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] selftests/bpf: add a test for subprogram extables
To:     Yonghong Song <yhs@meta.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 8, 2023 at 10:40=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/7/23 2:04 PM, Krister Johansen wrote:
> > In certain situations a program with subprograms may have a NULL
> > extable entry.  This should not happen, and when it does, it turns a
> > single trap into multiple.  Add a test case for further debugging and t=
o
> > prevent regressions.  N.b: without any other patches this can panic or
> > oops a kernel.
>
> Also, it would be great if you can show the kernel oops stack trace.

+1

Also please reorder the patches.
patch 1 - fix
patch 2 - test for the fix.
