Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251966C8682
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 21:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCXUIB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 16:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCXUIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 16:08:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F21B445;
        Fri, 24 Mar 2023 13:07:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so12203306edb.10;
        Fri, 24 Mar 2023 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679688478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwDdbXQ+Kq3hsMLWwf0D7a7P6qWxTGqxL0bP6Pa+IhM=;
        b=J+UaawPiJmMi7uhnTrF9yyvXI4oPYzXk+B7f7zlP7Z/XjkkNGDNM7O/BIVrKXqnMLB
         oMHpezXAsxorxYJBpIePgj72FfEEGK5dEJTmgoGI0zwRl9lMxPaglrNH/GBjhNkA/d09
         wY6eZRGiq5A8Ihmhqssqo4xt7BMiEu24az3eZ1/JmgJMT48nvdzMpVSQUUZ8mV4U1Imh
         JMwbHhESbUAYPZ/rL9mHbE+Fskv/X0hBE4OKpYjaUr+v7QoYO39GvuY5y/KAGlvBmPp+
         G4yi4YCiu0eAw9x3A4l9tcCF0ZgLzxumrQ9YlRyTe23cUOpJoZy+D6daNjaNyejPTFp5
         KiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679688478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwDdbXQ+Kq3hsMLWwf0D7a7P6qWxTGqxL0bP6Pa+IhM=;
        b=zHINZTiuUc6yCf0J/bmXwlTkH1dNMFMWZRdhIWz2HmIHlOkulqJCNTiMR0wpUUn+db
         UGM0Bmlkgpix6N6RCIcJgL69HMhnenMrV2w8Y9pTuhGH8VY2YPUWG0mKNUP9pCCSEkDt
         ByOrJL0QjzlYnx4ybc+dhm+j/KftfszxCPuiEEGrH/oKajgrcRUaGW4cb3a1Sbl9inO8
         Y8DA5Ay0ldVtOpCrnrq4ibIli0okiww7dCx+3LnCRGGddcB17ZbBJhei/aYGvlmCgfV+
         /oXpcmfOuFdt/4BzMOivhOUhiIiuyei+4XxkDDrMr4Df+0kdtMosTmyw+dezULuKr9uy
         HA9A==
X-Gm-Message-State: AAQBX9cD60nqBr+c2AKtQk8r36k+8pDbvyY5+lqUiACcEE6l5bCJeOSw
        UWJVeWbDcBjkFbM8Kvd76KTAeBlLw9OSO+l/CPg=
X-Google-Smtp-Source: AKy350bw1yO8Awn13tAOWWEnh9YWbI9QxUzylFg2TH7Rj6K2NfRLMeoAbyrJYGZOr2oNNRiQeSpw8NqAuS97k7kVibk=
X-Received: by 2002:a17:906:ee89:b0:92e:a234:110a with SMTP id
 wt9-20020a170906ee8900b0092ea234110amr2060398ejb.3.1679688477723; Fri, 24 Mar
 2023 13:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <9e0a7e6c-484d-92e0-ddf9-6e541403327e@web.de>
In-Reply-To: <9e0a7e6c-484d-92e0-ddf9-6e541403327e@web.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Mar 2023 13:07:46 -0700
Message-ID: <CAADnVQKEivv6t+v9evOWptt=i4ddte4OmV=o-BNWPm-ZQ9YfdQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Improve exception handling in rbtree_add_and_remove()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        David Vernet <void@manifault.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023 at 7:13=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> Date: Fri, 24 Mar 2023 14:54:18 +0100
>
> The label =E2=80=9Cerr_out=E2=80=9D was used to jump to another pointer c=
heck despite of
> the detail in the implementation of the function =E2=80=9Crbtree_add_and_=
remove=E2=80=9D
> that it was determined already that a corresponding variable contained
> a null pointer.
>
> 1. Thus return directly after the first call of the function
>    =E2=80=9Cbpf_obj_new=E2=80=9D failed.
>
> 2. Delete two questionable checks.
>
> 3. Omit an extra initialisation (for the variable =E2=80=9Cm=E2=80=9D)
>    which became unnecessary with this refactoring.
>
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: 215249f6adc0359e3546829e7ee622b5e309b0ad ("selftests/bpf: Add rbtr=
ee selftests")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Nack.
Please stop sending such "cleanup" patches.
