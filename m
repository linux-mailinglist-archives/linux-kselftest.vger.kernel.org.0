Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D160C28B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 06:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJYETh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 00:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJYETg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 00:19:36 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9723157
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 21:19:35 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k67so9828683vsk.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 21:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pf7wkcC7iPnj3Wj2WVEiFeAdVo6I4Lt2rCey31zYSEg=;
        b=eDpexlX7/8tvihfvI1yicRHVW6la9sqnkfObpCYoNMf1g78OW981vVN3gyrympNDGT
         XwruU9mNzHJ0xVkCI6YZb73QE51WBUPIF5+4iStXLtaQh/kEKwW3SBlVjZZ9DIi+tRac
         dVGUXgDlNnV614ZPSnp6Qbs7JQ3pTTV+va8rUEeCL30DlC5GO0iFvYyN3RVHbVCjhVWB
         PFI+xmFu4HJwGbIb26Fw9g76uiYSTwWAa68xbLA2w29piCNcbeUFvtjaNJYfVMM4MmHA
         9ltAbv0/F2LBP6GvPUZ+Y1ReuINQ+DmOGoXoCa2101Q7F9XibCjHT5uL/8Qbs0Vgrz3D
         1V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf7wkcC7iPnj3Wj2WVEiFeAdVo6I4Lt2rCey31zYSEg=;
        b=6ElwX3aL13LHmzJ6T3KVKs4muEFbwEPbP/Cw434tW1XbllNvSvVHP1Lrw+ZUHsGMPm
         rP64rVgG5auCDMmBXlV9N3I6RE+KLC30pgLSGQMuEOwGEZ0THFD7tXhfkN5AO586TS5Y
         6sVfReRcMA8YuY2VWru+21VTWPaFkeMlKSDxbSz2jMjCs+Zah3Qrhsxf75tP6TuAato7
         dqZJqph0LnCx7ozHHeqmc4/w3T7/Obs+xciorSCXYoJrcLrH11d+4x3QXfdXpLDEJ6ov
         MhRSnQQGq2IklWmy3mlLRAfWfxqA+foJyYHXe9RKU6RX/R2Zx57Apo2ERU80DXHaH51j
         I74Q==
X-Gm-Message-State: ACrzQf29VHJDEs51d29Pu9RQz68GSd6gJYAB/CKlmKeD7k+0hidJYEWB
        T7evlD9MQWCaXxlVcbaM9ct2PcxzON2NgqESa+WQRQ==
X-Google-Smtp-Source: AMsMyM506rM6b6qpNGFQZrnj6cX0FPwizftO/P0L8m59H9BQGXzJ0ahGKDmG4wBvKGCzHua5jUbrkJWcQaKbALRSyAs=
X-Received: by 2002:a67:e093:0:b0:3aa:14af:50cc with SMTP id
 f19-20020a67e093000000b003aa14af50ccmr6158581vsl.71.1666671574113; Mon, 24
 Oct 2022 21:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221025015946.3186777-1-her0gyugyu@gmail.com>
In-Reply-To: <20221025015946.3186777-1-her0gyugyu@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 Oct 2022 12:19:22 +0800
Message-ID: <CABVgOSnjMKMAXT_6Kk_OGnF4J=gPwnYiaKUSafONwc7ZA4-2Gg@mail.gmail.com>
Subject: Re: [PATCH] kunit: remove unused structure definition
To:     "YoungJun.park" <her0gyugyu@gmail.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Tue, Oct 25, 2022 at 9:59 AM YoungJun.park <her0gyugyu@gmail.com> wrote:
>
> remove unused string_stream_alloc_context structure definition.
>
> Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
> ---

Thanks for catching this! It looks like we remembered to get rid of
the related struct string_stream_fragment_alloc_context, but missed
this one.

Reviewed-by: David Gow <davidgow@google.com>
Fixes: 78b1c6584fce ("kunit: string-stream: Simplify resource use")

Cheers,
-- David

>  lib/kunit/string-stream.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index f5ae79c37400..72659a9773e3 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -131,11 +131,6 @@ bool string_stream_is_empty(struct string_stream *stream)
>         return list_empty(&stream->fragments);
>  }
>
> -struct string_stream_alloc_context {
> -       struct kunit *test;
> -       gfp_t gfp;
> -};
> -
>  struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
>  {
>         struct string_stream *stream;
> --
> 2.25.1
>
