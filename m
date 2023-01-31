Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEC682DD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 14:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjAaN1I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 08:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjAaN1F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 08:27:05 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D44F85D
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:27:03 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id g24so2906894uap.13
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfS17ZsZf/XGjm2u6f2FzTjc0hMl0etPEncmPApzois=;
        b=Wb36UBmbhS+WqAz7txl8yXQCUTlj6ppRvBGqjFrTMw6hAnW+zQNaZayCPUn7Cyi6mP
         SRQq6FIVi0+KKddcP/X2TLN2GVKEEGXP7GnSONi4UIZISYltZLgcWMyTB+tg9L4qSAUQ
         5ioImuNRvBZjMRXVA+qGZAM7M9x7PkgYxPGfAbHfrRjxL5b2zNR/KKMI1YpUtqBfYoWR
         MVBolnjoIACZ8Z+safk/ZKF1MW3iBumBc4xUrPfPvTOJ32DpSXfxOPQqkObcA7WjTwH5
         xW4pYXWieilM7qit5sB+VXx+/pFt22t5NVGR3owhsxbm4KQTreMK6dTLqUDucdksizwj
         YAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfS17ZsZf/XGjm2u6f2FzTjc0hMl0etPEncmPApzois=;
        b=0QKppgUxMNUxcbnJI3O3aLjq+yd5OIxJvLZrJwjrUC7HNeMcmTky3iKP/LezA40Q1n
         akPWfUF947Pr95TUU9006UkGnaKB1uBx0+N3C9QUObToFLe3CkNMc/6hBkFp7maP6c9O
         K5/bvIGMZtvJkYJPEqRcsu1hDPk9qp/uGrwweznWFmIew85dfrRyUs7Tzp0RI97g7xwR
         nHBZMn9z9x+EYtAXdMtZN20I3LRRRHeTQQyaewjMw0tpFNLDWSems3ftqYvO2eY9gq7e
         ONQ+/fCZibSmfWH/EkLDcCiqmKQwKD5ETzx0BvFe+bHQGk6zZxrJ65VuXiYLn7+dqFkY
         bLuw==
X-Gm-Message-State: AO0yUKUmtxXzy4BXlihFGBdlYBsHf6bUaayfSEXXDU97xAHTnjYOjelW
        BIpupquu68eYJAE3o4wm+5spgbLHVFSCExTxsvhziQ==
X-Google-Smtp-Source: AK7set+tU4T1j3AbvjYWH81S2+9ulJezSl5aE+CptZjtz5YU7IekXvouVxl8K3K2RyIMAMcgGFkPkci7S+A1LVR1iDk=
X-Received: by 2002:ab0:2841:0:b0:662:b4d9:ff5f with SMTP id
 c1-20020ab02841000000b00662b4d9ff5fmr1268412uaq.46.1675171623007; Tue, 31 Jan
 2023 05:27:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6007:0:b0:661:69f8:2c75 with HTTP; Tue, 31 Jan 2023
 05:27:02 -0800 (PST)
In-Reply-To: <20230131023503.1629871-1-davidgow@google.com>
References: <20230131023503.1629871-1-davidgow@google.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 31 Jan 2023 10:27:02 -0300
Message-ID: <CAKgze5YQnQUPZFpy2h_CObB8zhwmKzGFUQ7tnC3_LqNZVW+-+A@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix kunit_test_init_section_suites(...)
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/30/23, David Gow <davidgow@google.com> wrote:
> From: Brendan Higgins <brendan.higgins@linux.dev>
>
> Looks like kunit_test_init_section_suites(...) was messed up in a merge
> conflict. This fixes it.
>
> kunit_test_init_section_suites(...) was not updated to avoid the extra
> level of indirection when .kunit_test_suites was flattened. Given no-one
> was actively using it, this went unnoticed for a long period of time.
>
> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in
> .kunit_test_suites")
> Signed-off-by: Brendan Higgins <brendan.higgins@linux.dev>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  include/kunit/test.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 87ea90576b50..716deaeef3dd 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -303,7 +303,6 @@ static inline int kunit_run_all_tests(void)
>   */
>  #define kunit_test_init_section_suites(__suites...)			\
>  	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
> -			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
>  			    ##__suites)
>
>  #define kunit_test_init_section_suite(suite)	\
> --
> 2.39.1.456.gfc5497dd1b-goog
>
>

Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>

Thanks!
