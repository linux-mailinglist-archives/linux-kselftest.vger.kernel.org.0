Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B6523F4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 23:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348030AbiEKVMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344470AbiEKVMV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 17:12:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C931FE3C9
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:12:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w24so4019761edx.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vedd45PRf2+Xo8c6OsqnUkpgGBMP9HrslXfPQTpksLM=;
        b=o4XgHW/eQvyLkn0OiaY0jWQYNlV20EZ7Y5sYSUf0HYKMP+a10peDXlxnY84XxGWqh8
         nNMp19DLTphTgs5xWbx1Qe9EBpqQSAydw1XEyLVzAHqLsfTIBRkRPnyGmUakAJZJg3hm
         hBzUTuSe/s3AspjpUNo+90cycKENP0RH+UdfFSn+LVlO4gyOrI1xXgPgAX+iqPX6XEAv
         Nsmkis7I2LgR+aNKg1w3OHZWAFSa7vGDCMOczVi3Qe/DUvJYk4Qip4VzJsUrBjx8qrpX
         tcT+4lSFjznjtGmN6mZegiMTBxD9Op1aG++N58DevJiv63Vu08qS6GtP/H75IPN+kJsr
         L8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vedd45PRf2+Xo8c6OsqnUkpgGBMP9HrslXfPQTpksLM=;
        b=JSmQkZgZ/ADZQjjNz4ryATRfzNlpML3FZQ1Ay7Fxr+D7La040oKQVxPtleUFSXz9Jc
         xVr66t/PXXAmhx08SHKOH1YbMmInDSe1SDGi0XbLGYTa6ux8OoEfRvn53AQFi8xC5ocm
         sk00gJWfW8ktOq/PzVhxZU6x5AsOwTEIiK7+nBU3e59l52gc5LRMa4vFHN5QygRPz1do
         tLgvaTQNYX/9uMoYKMgu1HB9nfi2z60aTTMC6e2kgMSat9WUz02gfDKtY9HVAoukBLqA
         qEGYUobVGpC8VppJBiIjMfQma4xX1I1EkiptMH+qvao8YIAGZz1xPsNW6rgW9Kh/lScA
         6eJA==
X-Gm-Message-State: AOAM532nAUgy2WOsx0MTO77UnnoDnzrh6n7xqGSSaaIgSTSyRBxtdvoP
        4Je1NemSRKi8l/oChGqAAzzYwM+by9HPN+t8R96NKw==
X-Google-Smtp-Source: ABdhPJyjS4bI0dU86NcfjLMxwPmPyS68/HykMn1ZHxMKd3r98Uu86YV1u4fTycuI6W435S6bNga4K0L32hJ5saZ15WY=
X-Received: by 2002:aa7:c54d:0:b0:425:d8c9:efc6 with SMTP id
 s13-20020aa7c54d000000b00425d8c9efc6mr31293437edr.48.1652303538019; Wed, 11
 May 2022 14:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220406232240.1825048-1-dlatypov@google.com>
In-Reply-To: <20220406232240.1825048-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 May 2022 17:12:05 -0400
Message-ID: <CAFd5g44aO9KOhxuM7NF_=D2QoA3gTDv8cQ+3qqq+zYA4C54L_Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: bail out of test filtering logic quicker if OOM
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Zeal Robot <zealci@zte.com.cn>,
        Lv Ruyi <lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 6, 2022 at 7:22 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> When filtering what tests to run (suites and/or cases) via
> kunit.filter_glob (e.g. kunit.py run <glob>), we allocate copies of
> suites.
>
> These allocations can fail, and we largely don't handle that.
> Note: realistically, this probably doesn't matter much.
> We're not allocating much memory and this happens early in boot, so if
> we can't do that, then there's likely far bigger problems.
>
> This patch makes us immediately bail out from the top-level function
> (kunit_filter_suites) with -ENOMEM if any of the underlying kmalloc()
> calls return NULL.
>
> Implementation note: we used to return NULL pointers from some functions
> to indicate either that all suites/tests were filtered out or there was
> an error allocating the new array.
>
> We'll log a short error in this case and not run any tests or print a
> TAP header. From a kunit.py user's perspective, they'll get a message
> about missing/invalid TAP output and have to dig into the test.log to
> see it. Since hitting this error seems so unlikely, it's probably fine
> to not invent a way to plumb this error message more visibly.
>
> See also: https://lore.kernel.org/linux-kselftest/20220329103919.2376818-1-lv.ruyi@zte.com.cn/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
