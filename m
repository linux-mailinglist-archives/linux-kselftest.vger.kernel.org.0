Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFDD5BB68F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Sep 2022 07:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIQFjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Sep 2022 01:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQFjl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Sep 2022 01:39:41 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42ED12AB2;
        Fri, 16 Sep 2022 22:39:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3321c2a8d4cso283000927b3.5;
        Fri, 16 Sep 2022 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=jtchFBzH++GNnoEIjx4Ntdk5N32UzL43DOyjEpT0F40=;
        b=dJxoQglJeLOCooo0FT4B+QraWQ1bXsy25QL/vTl84rT1Gni03SmGjzePHDWpT4fM8K
         ErqVf8DevI7SYHzNgpwnX6iZPijhshFz2z5NDNTPTRoqB0anBfoW/svWx1XzMMCHSe4o
         iTggvuOqeiN4NmseghWJMkvm5hcqNMgOUsrU0q6Gr0A6aACjELxbVowgrZfcXRB/vtjh
         L7HVIXt5XVZxYMoq4NCoXjwIv0sCfImJg39GYIhO/8/mpAjyTaEHCnCIGGWHxsJpT+3Z
         U3Zl/T6WZH8ZbavoF0LxOD+27l1x5cbR7aDIFgb61MiQ+YQptj1YF0VM5oqgUjIAp39+
         0V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jtchFBzH++GNnoEIjx4Ntdk5N32UzL43DOyjEpT0F40=;
        b=6VkIoTXiXAqxnmQqDkhscajY8mdx7140tQOXWR7ZihXk6hXMMScqILQ5UyUknf+L7O
         BUzJGrboIcD/M1LVyivudOsvWyQeTzo1r6BOmk06Rac6aECD3gplMBjyyRed+9qJL+5p
         ubEnWuxXZ8/b8PwCq0+NTI31IO8ZnzlBtU4Sp9VpHWOxx4jmdf/+lXVmmn9/yNwOv4lM
         oQD1TqZ9tNyIlBHSiNw831AkSSJKrHe2a+2Pv5DlCrojqh604D9IaeKr/9TZtGUsdWhF
         zcdYYX4b8RPQY4n1hTE1JcQWLIAfA8sDBMLUwjvaANiuHuL8KwIQLXdeKVYwKcsPAqwC
         G0ng==
X-Gm-Message-State: ACrzQf0tE4DaxQdyPplKXoP7UpW2mzyi6OWA4TU+ADUJfhN30hsvryGB
        XA7FSHoPR3pFE3AIUj41snqSpk2a8odsPDkLNvY=
X-Google-Smtp-Source: AMsMyM6DmOxto5DLfQbbd3bh0eCeqHW2bVoVaCR+dUroG7Bnno9/axoOfGN+QI8A5K+MHF1/+jmm/GMIrhHLv10Mx+M=
X-Received: by 2002:a0d:e6cf:0:b0:349:ef2b:1940 with SMTP id
 p198-20020a0de6cf000000b00349ef2b1940mr7052010ywe.331.1663393179003; Fri, 16
 Sep 2022 22:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220915085757.258608-1-zhaogongyi@huawei.com> <20220915085757.258608-2-zhaogongyi@huawei.com>
In-Reply-To: <20220915085757.258608-2-zhaogongyi@huawei.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 17 Sep 2022 14:39:27 +0900
Message-ID: <CAC5umyhUteOFg1Q+rxU01axu_Rt2gadTqi9NxLESiqNyLtHaZA@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/5] docs: notifier-error-inject: fix non-working
 usage of negative values
To:     Zhao Gongyi <zhaogongyi@huawei.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, david@redhat.com,
        osalvador@suse.de, shuah@kernel.org
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

2022=E5=B9=B49=E6=9C=8815=E6=97=A5(=E6=9C=A8) 18:01 Zhao Gongyi <zhaogongyi=
@huawei.com>:
>
> Fault injection uses debugfs in a way that the provided values via
> sysfs are interpreted as u64. Providing negative numbers results in
> an error:
>
>   # cd sys/kernel/debug/notifier-error-inject/memory
>   #  echo -12 > actions/MEM_GOING_ONLINE/error
>   -bash: echo: write error: Invalid argument
>
> Update the docs and examples to use "printf %#x <val>" in these cases.

I'd rather fix the notifier-error-inject module than change the user interf=
ace.
I'll send a patch, so could you check if that solves the problem.
