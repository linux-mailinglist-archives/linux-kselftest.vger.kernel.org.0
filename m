Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4195456BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 23:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiFIVvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiFIVvQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 17:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF5CC31DD3
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654811473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GmYtaQLv1m6AJWe/7StrNTTypt8bklBHRRA6RHL2h34=;
        b=g8mTo9g46m7K/0/1UmQBKez2SQ7NNJ5JqWgmgxRHgIsmV9vtnY+PwSuY0PZU0zxvPXvptr
        0VKnQXG3a7Xg56a2+IxMCb1zo+6XUy3MJ5NsYvulVhYOs5HubAk9dgp3yWz3EVZw7fOAT6
        FPK/pbh7cu6KZi/wicKW3laahetO+5s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-dcq3WjLMMJCo2Fx-C5WF1A-1; Thu, 09 Jun 2022 17:51:11 -0400
X-MC-Unique: dcq3WjLMMJCo2Fx-C5WF1A-1
Received: by mail-ed1-f70.google.com with SMTP id cy18-20020a0564021c9200b0042dc7b4f36fso17822517edb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 14:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmYtaQLv1m6AJWe/7StrNTTypt8bklBHRRA6RHL2h34=;
        b=v4CMLM9DfUqWB2i+at5odQHb5mgl0TuZkkkq3abL+KUetrq1N6B6h0q8r0f7tsQ7wD
         lI/If7erSfUpao3I3T449A4UxJNTKuYTDHhIWueP1dzjICdPJauwFM7OHdZ2fDjpPIOK
         gQULRKIl4YG+qcBP22clJqeUDETvEesgNez/xG6a8UmcgiSCiPgVrZEpgcKl3cZJ7u7P
         OdimIijFo/DlO19mnTJJTF4B8amXTZ6a2WF7nO37VBlQXY+YdQykRTzC2capfwhnrW3/
         V5k/KmGNM5OrM6EF+B1MOUwwkv6VvIPNKz/u3ptW+MH6UYXx4X28kBa/5z43uDGtfsph
         Hveg==
X-Gm-Message-State: AOAM5322ItRbU6E4Lrk91M2hxM6zCYpIG20cOCgI5f79HBqX9gAFyYYq
        MUlTcYVVwBn6lDEr19bUDe3FhyVuAdM6rwVxcfJbgSqrCfipIKpZjPiC8cNzSplJZAOTRVAxQCV
        gyt3sYF5KgNS6qouRYBQleS5BS8kN8z8YT/yambjBfMcw
X-Received: by 2002:a05:6402:4252:b0:42e:13d4:4f4c with SMTP id g18-20020a056402425200b0042e13d44f4cmr45220214edb.92.1654811470682;
        Thu, 09 Jun 2022 14:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgfohrCsONWHPnjM7ZXVDR6JY0sWZrG3K4u6Txy0MsPzphhqyPqqWjb2xYiQ1ApKHNUv0Q0rpmqtixQooDpvE=
X-Received: by 2002:a05:6402:4252:b0:42e:13d4:4f4c with SMTP id
 g18-20020a056402425200b0042e13d44f4cmr45220193edb.92.1654811470494; Thu, 09
 Jun 2022 14:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220609203217.3206247-1-jsavitz@redhat.com>
In-Reply-To: <20220609203217.3206247-1-jsavitz@redhat.com>
From:   Nico Pache <npache@redhat.com>
Date:   Thu, 9 Jun 2022 17:50:44 -0400
Message-ID: <CAA1CXcARipJgCW4PrxxUqf9fyCcD7+M1B0NRRZpdCfPXfrzrdQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: make use of GUP_TEST_FILE macro
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

LGTM! Good catch :)

Acked-by: Nico Pache <npache@redhat.com>

On Thu, Jun 9, 2022 at 4:37 PM Joel Savitz <jsavitz@redhat.com> wrote:
>
> Commit 17de1e559cf1 ("selftests: clarify common error when running
> gup_test") had most of its hunks dropped due to a conflict with another
> patch accepted into Linux around the same time that implemented the same
> behavior as a subset of other changes.
>
> However, the remaining hunk defines the GUP_TEST_FILE macro without
> making use of it. This patch makes use of the macro in the two relevant
> places.
>
> Furthermore, the above mentioned commit's log message erroneously describes
> the changes that were dropped from the patch.
>
> This patch corrects the record.
>
> Fixes: 17de1e559cf1 ("selftests: clarify common error when running gup_test")
>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  tools/testing/selftests/vm/gup_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> index 6bb36ca71cb5..a309876d832f 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -209,7 +209,7 @@ int main(int argc, char **argv)
>         if (write)
>                 gup.gup_flags |= FOLL_WRITE;
>
> -       gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> +       gup_fd = open(GUP_TEST_FILE, O_RDWR);
>         if (gup_fd == -1) {
>                 switch (errno) {
>                 case EACCES:
> @@ -224,7 +224,7 @@ int main(int argc, char **argv)
>                         printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
>                         break;
>                 default:
> -                       perror("failed to open /sys/kernel/debug/gup_test");
> +                       perror("failed to open " GUP_TEST_FILE);
>                         break;
>                 }
>                 exit(KSFT_SKIP);
> --
> 2.31.1
>

