Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6851B4E5A7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 22:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiCWVNz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 17:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbiCWVNw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 17:13:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B338CD9C
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:12:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so3364237edw.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7J+zvKOI6x01hl/yYGK7ZfqaUiakMK1iiu9VlloF/xA=;
        b=KagHArbQWMnC62J5bHWEZLOiF19D7tr8A2cgwfSkmdtoauix6WdHlIAPYdqgzjDYSk
         TOStz9GWpPOLbQMii4Q3jTOXhqld+Qc/cvFaqno3dtfQNUB1HY34nM+1JowbNE3Pofex
         L3ZQmtIXd22iHpRSw6b6L2L2YReWb5ramwnElciUhAieMfk83MNluUSRzaYkrWC7rPoe
         e6bqB4qyoFDEg4ZMZzK7C6R5RkGacJvpiCYWBkt3db6SfyP7dxVI0zrXSVIBc3NurMGB
         UuZHesTjgAOzMD8dVzVHOu/g+i4sewCyVIbA8yvOOXMpebUXiXbrKNOFgZ4ja8AVu5B9
         2CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7J+zvKOI6x01hl/yYGK7ZfqaUiakMK1iiu9VlloF/xA=;
        b=X+lV/I9TDWDg1+xvAjcwytANWLDgV4GUysBGp/fM9FPInXl8y+NRVdcjvX8lOimZTL
         zdNP3s0ogfZbxJzJasPcuSO9dO6zaeHuDs45fz2f+G9RN6fa/ng5NbNr5JnDWWNEs0Qt
         rSsw8NQyZXKalkXk35pQhFtbAYtBJqyTw93OxPoe2abrEaswcAajYn6cTV7lutNvxYz+
         MAo4ppJQjpyXTc0bA0mrCXd7OVGl8WEXGmyTTq4aycwZslkZu94IvpYDJBOaC/M1MMNZ
         sb0Z5PNTmfmra8aV/vN8oyhjQEaKG1nv1PAVh0uER7xDlpKHS/u4aWfX+HFKqVms3q4z
         xoPA==
X-Gm-Message-State: AOAM531yCAyb6snOjRnh/gDi3dKgFPtlw5VY4Vp+rCDNM37MuC+RKuF/
        0Pjm7tdlDW9jQSfPkONAcHnnYSbi9d3Hy1QwxTYX/w==
X-Google-Smtp-Source: ABdhPJzClDGT0PomJaUcrNzKQb8hBK8bHF37apCaIpgGtSLAW0/s+R3CPsO0GPmqFDpgLUEOM9ZsBpCvYKeaA3IwT8Q=
X-Received: by 2002:a50:d949:0:b0:418:ecfe:8c25 with SMTP id
 u9-20020a50d949000000b00418ecfe8c25mr2709073edj.156.1648069941134; Wed, 23
 Mar 2022 14:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220211164246.410079-1-ribalda@chromium.org> <20220211164246.410079-4-ribalda@chromium.org>
In-Reply-To: <20220211164246.410079-4-ribalda@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 17:12:09 -0400
Message-ID: <CAFd5g450=jBk51-4wMBxEA+VVQnOyxqtF5WV-J0dCW3j-eAfkg@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] kasan: test: Use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
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

On Fri, Feb 11, 2022 at 11:42 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace PTR_EQ checks with the more idiomatic and specific NULL macros.
>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
