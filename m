Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C105ADD4B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiIFC3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFC25 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 22:28:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5436A4B0;
        Mon,  5 Sep 2022 19:28:56 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id d16so5337922ils.8;
        Mon, 05 Sep 2022 19:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EVFz7Snz7wNBPA0IRAcw8NAeZu8JeFGc8bhvLijNe68=;
        b=Lmlb/JhMlBqxERnYMJ8xSM+tQfW/dY5Q27/zRIGeDuPRz4ABJisLKzdisqy5Jvs06X
         WmFvYxnJn+ULydDg0lZty9ZEKN/kPkvzaS1IQ+EZuRhmpoHdBcJkLe6xcCQ0on4bAodO
         Dl6Bf6onWU7tIlUud7ejRxIN4YOr01XWC16nfqjJfB9pQvRGC9GsxKBvofMT0kIS1JHi
         owaeyTup6MfQkO0PrWHUrEH12xVEJggGL2l9+5AnyMFr3ywP/41dy4xpwWFUbu7AeZie
         x6tpwH+XIJhnUv+LrNEGJjmJqvUDZvl0as1f/VLKBeLwBL95jeIWGB9AjCMUbpmj7+/o
         84Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EVFz7Snz7wNBPA0IRAcw8NAeZu8JeFGc8bhvLijNe68=;
        b=erQ2gDepAgcu8bbSHhJqqSgLppZqGlI0uN5hzjLkm2hh7t3lCOczHf6kyQTQiYZFJt
         x3i9eajoq+fJ4ctENp/lkIRUOI5yUr36P2gvOhS1mpFTWKSbL6TQFreMLetgmDueOVcm
         DaM4/ah49qjjIB/AcxI3OUU7g4UdrblCQ7/5I7y7EQajkTW94gDqWaNaI49wUsBxffKE
         kTsEXHu8ep1vMuse5o1nq55utf07oBHyerY7PlSXoXwaL8SANweRYa1I2hMxPsWvD3V6
         kGEBrJz4jNTRO3dH/aXELZPAjcQSjOGVubEOYgNbKaWg9ephFjfdMZFKM6O7UHQltJzS
         t4rg==
X-Gm-Message-State: ACgBeo3vtV6Njiynl8cyrqwkuJ8Zk0sauqBia6w2yeCAfaAeypkPvruP
        o7rXSLwceSmMgXXL/SSLEnz4XChm/rIrSKKeoE+ccXK4SJE=
X-Google-Smtp-Source: AA6agR54DVLjK+sXLtyBp0zuCC8wQY+NbjiMCEnQx6tLIjpLuD4/sp+QIJcXwS68s1riFM3yhVq+Okziu7FVbH8weUo=
X-Received: by 2002:a05:6e02:190a:b0:2ee:9e75:ae4b with SMTP id
 w10-20020a056e02190a00b002ee9e75ae4bmr9134684ilu.219.1662431335360; Mon, 05
 Sep 2022 19:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-2-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 04:28:19 +0200
Message-ID: <CAP01T76CNmuh6qzewzafoZrSX1WCs6YsCBiEDkSr-1Oi+th0aw@mail.gmail.com>
Subject: Re: [PATCH v16 01/12] bpf: Allow kfuncs to be used in LSM programs
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

On Mon, 5 Sept 2022 at 16:34, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: KP Singh <kpsingh@kernel.org>
>
> In preparation for the addition of new kfuncs, allow kfuncs defined in the
> tracing subsystem to be used in LSM programs by mapping the LSM program
> type to the TRACING hook.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 903719b89238..e49b3b6d48ad 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7243,6 +7243,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>         case BPF_PROG_TYPE_STRUCT_OPS:
>                 return BTF_KFUNC_HOOK_STRUCT_OPS;
>         case BPF_PROG_TYPE_TRACING:
> +       case BPF_PROG_TYPE_LSM:
>                 return BTF_KFUNC_HOOK_TRACING;
>         case BPF_PROG_TYPE_SYSCALL:
>                 return BTF_KFUNC_HOOK_SYSCALL;
> --
> 2.25.1
>
