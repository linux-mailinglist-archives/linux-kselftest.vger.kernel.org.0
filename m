Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0580D57A521
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbiGSRXw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiGSRXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 13:23:51 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DC4BD0A
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 10:23:50 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id c185so5822915vkh.12
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZHXeSC1VmUCH9mNj9AUW2Bo/31nO6EiUjVsM1VfENw=;
        b=ikvjELr0mzcMkn646f2t6h9IlMjR09ulcKtvWFk/oWNTPozHVqYPx+SW/ifC4rI2sx
         yZi7GLcy8hYxA+j+iOCXmvSR68JdlHCZKn/N2jfg2NP9cn87ynbzQdH8zZ7t+m0E0+I0
         xPQYmESAsohp07c5tI5Ma8lop3ZA5mNwVkFBNNhAHGaGWJYpl1AS6giiJiD4QdEN4EgX
         X3zG02YbEW/wGfTAdCCnFene34bTqUYtu9jQLo4d7KKuMFClqe7CaNqVRLCqK1eHN7SS
         rAENRyrmOOgjLiHtv+N8sLo9ZF7zBeK0zG1O5dMACPQQvEkGo6V0fcffjpIdeBhLfag2
         y76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZHXeSC1VmUCH9mNj9AUW2Bo/31nO6EiUjVsM1VfENw=;
        b=N/ulNSYJY5xZBDA+8bZas4a1UwtTbkTmHkP3zZq5Au8GYVm7DAJbj5yIV8Q6eZOSov
         2Kjas5GSanwwsFl0iiWqoVcumdBPDhtvyFBclczVF9DdZeHGeZNE75AQ7a0XF3dc/kbA
         /Qyywx9UB0kZVkU3zB5EbvJQMn/9+SUYwE2E075f0evFuVjwp0hceL6CCHq6fpoz9Mlr
         QltoOuHNt00nuZM8bI8dJzx3FN/uXtUwrvU2lak1EZR+xI/lac3dCL58qqXWVd3I1IDH
         oNq9lQrCAVedQk3/wW+/Q+xe3Vpp1zxEkDgSJMpirERhTSoNm0nzZEGqLvZ/CffemXFQ
         wi0w==
X-Gm-Message-State: AJIora+Xl1sgV6eS7hRdo9ChZaOYp5bB0Li3lzyQM2DLNEYhuifbUwld
        D8yCTp5Swc8gQ1tnKixxA2KfepVmaRL/yWXcnOqQnQ==
X-Google-Smtp-Source: AGRyM1u5HyuOvFvEtgCsNy8CtDhCYpla6Olw81Yjc2ion524GkJopvGxeDi/yB/uUSHFIlGYU/28nWH7TVqIT0Zq7wQ=
X-Received: by 2002:a1f:a08b:0:b0:375:9914:4f06 with SMTP id
 j133-20020a1fa08b000000b0037599144f06mr4282192vke.14.1658251429478; Tue, 19
 Jul 2022 10:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <YtZzjvHXVXMXxpXO@kili>
In-Reply-To: <YtZzjvHXVXMXxpXO@kili>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 19 Jul 2022 10:23:35 -0700
Message-ID: <CAHS8izPXZx7htkby3j78RAqoHn2hXJqCiDP25XdsuTwj34AX4w@mail.gmail.com>
Subject: Re: [PATCH] selftest/vm: uninitialized variable in main()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 2:04 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Initialize "length" to zero by default.
>
> Fixes: ff712a627f72 ("selftests/vm: cleanup hugetlb file after mremap test")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks,

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
> index 585978f181ed..e63a0214f639 100644
> --- a/tools/testing/selftests/vm/hugepage-mremap.c
> +++ b/tools/testing/selftests/vm/hugepage-mremap.c
> @@ -107,7 +107,7 @@ static void register_region_with_uffd(char *addr, size_t len)
>
>  int main(int argc, char *argv[])
>  {
> -       size_t length;
> +       size_t length = 0;
>
>         if (argc != 2 && argc != 3) {
>                 printf("Usage: %s [length_in_MB] <hugetlb_file>\n", argv[0]);
> --
> 2.35.1
>
