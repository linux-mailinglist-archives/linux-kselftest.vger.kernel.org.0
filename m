Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC67A6CDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 23:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjISVSw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjISVSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 17:18:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C54BF
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:18:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so5703a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695158321; x=1695763121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFbUVEyx9xFAaoaUBhgKpTEnsBdbnWty5nYMgOKKdeM=;
        b=PdZHH/GAAinrFGJ3mR48Z0x319C0jQBtHbh8UabVAUbPmnlKaYKqxvzu+7AqpNELPq
         5b9WMnaoBOU5GBU8w1Tzg1WyFJyVIRL9Z2/ZPQSuyJRS6vZ6yP7KRbu7n54BmW1becHD
         Cadc/BVgrwC8VBR77zTvHlop358KOPrK8kKKv4VndAMrOpOIRLklJOvr0t2PTh6xoC20
         L1Eb3/XnxoKyqdqGlZxdx/688ficfCrhrsCd1DsPS2hKhN5eUStyBzG+o8Y11K7Ao+kJ
         2NaIQP9UTxGwWtdFUSONCzvSO/cmfvjNXd62R1T5KgaiVOIfG5J4I+h0dATuAqw4ovNR
         zdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695158321; x=1695763121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFbUVEyx9xFAaoaUBhgKpTEnsBdbnWty5nYMgOKKdeM=;
        b=AJgVcehQgpWWyOO9phgP7aW+YpJekYYXdtTWT3RYRh0+/Bpi4uWhEXYz8D6WNwizhU
         cZsGcXlmytVQV3CgdDZSwuOdNnYvMGMR0gY0K86OshEF00ZvWk4NiAw9v730iJDNlWSH
         D5W2mzew8hxG8XXjQnb1tNycCweMeP7F5t33q2WhxWXTGAPNz6HUp49ixqfXL4iWCpV+
         brjxAIJUMybIBD6x8afQxvX4Jb9J8CiZLsB/Obp74eLt7nzcBaYfJ6pMhAmf2/Gk+WTb
         UAXekjQpYUx2IT0jnVklKbjTT64iJphRC9E777T/wXWRKpGaPR23HNNv5gyd4qzfCVr1
         AtFw==
X-Gm-Message-State: AOJu0Yy3472y33E8B29MzD5JM/QNUVP82BP4zcQf6W6GKcux+7ZeUHZB
        u/xH165JmQXs+u9zzNBEbza/HEjXE1mck6W++XJ3zA==
X-Google-Smtp-Source: AGHT+IEn8pcUnd1239or3kYNE3XJc/zcpNyY7aPWHqLGQsRCXyG9nyzE0Tfgn31v5DTzzjPWEj/x/sDbfv7o/ppEt/E=
X-Received: by 2002:a50:bae5:0:b0:530:4a6e:25a9 with SMTP id
 x92-20020a50bae5000000b005304a6e25a9mr30111ede.6.1695158321099; Tue, 19 Sep
 2023 14:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230914114629.1517650-1-ruanjinjie@huawei.com> <20230914114629.1517650-3-ruanjinjie@huawei.com>
In-Reply-To: <20230914114629.1517650-3-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 19 Sep 2023 17:18:28 -0400
Message-ID: <CA+GJov7GkioSj4AZ71b96yEs329qCZ7GKtimHVX6YEndO_4ToQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: Fix the wrong kfree of copy for kunit_filter_suites()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, dlatypov@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 7:47=E2=80=AFAM 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> If the outer layer for loop is iterated more than once and it fails not
> in the first iteration, the copy pointer has been moved. So it should fre=
e
> the original copy's backup copy_start.
>
> Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_sui=
tes()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

This looks good to me as well.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  lib/kunit/executor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index a037a46fae5e..9358ed2df839 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -243,7 +243,7 @@ kunit_filter_suites(const struct kunit_suite_set *sui=
te_set,
>
>  free_copy:
>         if (*err)
> -               kfree(copy);
> +               kfree(copy_start);
>
>         return filtered;
>  }
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230914114629.1517650-3-ruanjinjie%40huawei.com.
