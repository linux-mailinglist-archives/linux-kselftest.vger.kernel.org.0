Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89215692E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 21:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiGFTxZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiGFTxZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 15:53:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A0BB3E
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 12:53:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d2so28931974ejy.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d00ziUFyPDQ6I0nNLFmAgrCX7fUelcKHDlXhvLnYQpo=;
        b=nGUFuIUnY1qJpuG/cN4pf1seuY5n4iP9FUEzgUx3P+dK84mIqETulIB+ZB0jmJzUHu
         Y2061ysdXtXDBLFVfUJ4t0g1frRZFcyghbSEhrQlDOCnKEj3nJ3JMHBIums3AsKeXAtI
         AcYFhYOv18/V4aMyMmSWmGmWXqcVeysFlmgjvIXgSQJ3aDy1a8UxMARlkCQSdgUHL4Np
         NBJsIhpHurQ+U8HpEPcGOd0VCuSJE8yP4vvYix1ZhOj0PzzRSlF5g1aBjplh2Lfh6Hjd
         ZY4dX7OrdHUUuJzV0AyEujVpNUdlWbHnz8O79FTB/cq2dvi2chPZVuQ9D+aQlNBkg8jJ
         23SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d00ziUFyPDQ6I0nNLFmAgrCX7fUelcKHDlXhvLnYQpo=;
        b=4B0f0pKN952XUoxjkT1Uvu6wElFi86WlF3i4MsZI644vE/4NuXbCDHAmpW6UXfepeS
         oxx2lKekZRv+egcfMo0GcYbBxTJusnchLJRF41nxZXRGaw6cJCFsYCj0DWEy5dXxw5k7
         PZcu/T8L7xZ2vajSgP7gkf3ho8I2PHz26Yz7IShBPSXWun9tRBVIaXixmCCRTgucEkIx
         JUFlGwndSUmcnw+IWz+Xtp0MelRigXr0H0QqPzsWE+isU0siCoYAlUq7L69sJDmxTWpP
         yQRWaT3jlMLHf1UQHj1zHwWeQeJyqdYDqhryPL5rrq20lWEoQEM8alu/s7gieNDw7GFM
         FJbg==
X-Gm-Message-State: AJIora8MBgoSx1BIa4IUtJNfTawcjqGrBf1n+RpWw7yxf/eNkXTm3N00
        L2p6WxNBTvsWrJAZvP+LRZSrHh4+c+w/kqX9Wlg9CQ==
X-Google-Smtp-Source: AGRyM1v03Sn7R2smMxM/h/qafl2ey/P2pKgbxvGHL46VoS8zNPyvn3VyZ4Ec21viRGNgqymy1sya0+RmWaQXBBxdr7Q=
X-Received: by 2002:a17:906:cc96:b0:728:baf0:ba03 with SMTP id
 oq22-20020a170906cc9600b00728baf0ba03mr40145424ejb.52.1657137202253; Wed, 06
 Jul 2022 12:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
In-Reply-To: <20220518073232.526443-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:53:11 -0400
Message-ID: <CAFd5g47Jm78WxSo_A4syoUZApMHvRdXb2yNvdeu2BUDRpS75KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 18, 2022 at 3:32 AM David Gow <davidgow@google.com> wrote:
>
> Add a .kunitconfig file, which provides a default, working config for
> running the KCSAN tests. Note that it needs to run on an SMP machine, so
> to run under kunit_tool, the x86_64-smp qemu-based setup should be used:
> ./tools/testing/kunit/kunit.py run --arch=x86_64-smp --kunitconfig=kernel/kcsan
>
> Signed-off-by: David Gow <davidgow@google.com>

Ack, but I think Marco settled on removing CONFIG_KCSAN_STRICT=y and
CONFIG_KCSAN_WEAK_MEMORY=y.

Acked-by: Brendan Higgins <brendanhiggins@google.com>
