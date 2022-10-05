Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40A85F5B24
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJEUlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJEUlI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:41:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32762A95
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:41:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z97so133651ede.8
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wezMY0HcT+UXrF/Kp1mqgrelTmjrv48aVuFmQkT0QkM=;
        b=pMRkqZuA0XwgD1ltGokKvQ/xSa9jAL8/1q6ZYlVAdIz48r82ogNpa+9g+ARAOTz0xm
         QVsTbAqCecamtq6Rn1+jQJE8fdQklZzaJOTkX+iMZ0l2y0N5cRRTLNIUlzJU+BjwgRVZ
         SjKPpaDirLtUtwnJQg/PfqJvzasGa04p8Wcs7WnG3ItKuWX3RA4HkWBlxGBUkCkZok+k
         ENITADfYS53EvKj3Loc0kSfkkcv8K3YQs8ucD89brYvI0mieIzei8S6fnBBdCbsgmqEi
         oyrLqPZ0WzOmh0zLajlgbUTVdlV+UHtIPCaNKmtqoz9QFkR55ma6PrmspEgT78kUuhPq
         y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wezMY0HcT+UXrF/Kp1mqgrelTmjrv48aVuFmQkT0QkM=;
        b=JjO1qVYP3m+tA5LLWtnXoKLNh4a6wxzK6DVnPlJdfBGrMR01mkqVnjpStaO6JiUEL3
         N/8Gg76mqZ2nVnpfbp+mwBRuINF4hNA3Mf1c9sj/rj+ILklvxav205lQ2fZmm6im0jto
         MgBufZWEpbcZiTlCsBN2o0x9q3/AcVW64hqfeAfrGJv2iHfZieBH8C8h+Q8galKVPcR7
         UwHoOTaTEWiR0Q/R6B3+Rj+/mBpLzT+QbXrpeCl6ncKCt9TJDmFE/oxJcPM4xjXo6pe0
         c+26CxKkOFwIn7JgeXuIfqkO8SJjFFG9WrgnMdah2IDnDvXfehSh5fYwJ8pneFgsoyEO
         0Pfg==
X-Gm-Message-State: ACrzQf0xX0DWBZJjlOkO5X3PMv+PSPOMBk/ZOB52ICVoAC+s9fATl9aP
        5KJInVLbvmDv8t7AU6ctdsEMPYcdfB8yvYUh9RJMBw==
X-Google-Smtp-Source: AMsMyM5ZqR/Q+hN0/JlujBTlWbuTUIYpAXZac8OwJLMYeXl9GqBRApH2XD/qoCRHNW3cxtqfK2j8RjRm9ES4wJFR788=
X-Received: by 2002:a05:6402:4310:b0:459:7806:8ee6 with SMTP id
 m16-20020a056402431000b0045978068ee6mr1504103edc.198.1665002465512; Wed, 05
 Oct 2022 13:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com> <20220722171534.3576419-5-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:40:54 -0400
Message-ID: <CAFd5g47oBwrxFeKHKrppxaLCAPqLa=r-zNvs0QJEXiqu8ZYhYg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kunit: make kunit_kfree(NULL) a no-op to match kfree()
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 22, 2022 at 1:15 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The real kfree() function will silently return when given a NULL.
> So a user might reasonably think they can write the following code:
>   char *buffer = NULL;
>   if (param->use_buffer) buffer = kunit_kzalloc(test, 10, GFP_KERNEL);
>   ...
>   kunit_kfree(test, buffer);
>
> As-is, kunit_kfree() will mark the test as FAILED when buffer is NULL.
> (And in earlier times, it would segfault).
>
> Let's match the semantics of kfree().
>
> Suggested-by: David Gow <davidgow@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
