Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660D359CBF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 01:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiHVXPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 19:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiHVXPj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 19:15:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C525E2FFEB
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 16:15:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sd33so2853327ejc.8
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8E+K6gykmt5HP8xbcrfszwAPbr68WHWZ89nSZ7TLGjA=;
        b=qQnH48Vg2mr9fAr6mdHfAYhM67mDLLqJNlyCn5vge8mrX+oJjFhDF2v+vwxActNKqi
         j1D1/8cPTn1/cYP/wQnMVTK/U66s/XKvGBKMz0J72UxY5wy5N0ztLhY/b9tCWvooVVdA
         jEhbXPGc8R0i2p8beRGuL6/Q1vIyvNUj0q7XyAIc78BlAtZrmnjvKHI39oXPObYBdcQu
         wNgh0yvCI4xv2gve5JAJX0e66YbxjCTN01m347a6mOwAjkFjfTrDLR/DMOL8c9zTxzLu
         8vHnfIh/ylawpqKoY2PzbIqFDTdyES2EQAX7Ol0XCyd+DvRXlGcDkBftSSxqIoxWQx3B
         ghJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8E+K6gykmt5HP8xbcrfszwAPbr68WHWZ89nSZ7TLGjA=;
        b=KEztg5p/TOejyN8wD2Q7jHY29AblJrBOkFplv7Ai+AHpyoIV2+XQHxROBFWkIMZmCA
         ZFq/bl0D1yHO6DLGwRyl+kPqDnS4lNkOgEps3Y9LLq9AJ9RbTkg8sVxmdvDiE7IAqgk/
         JGSZ9sBk7ZPXbRiDfgtaXBFpMGIvGiP6j/YK5VYeqOBMRmaZU87ol60VSzk3X8kr8gx3
         Y9ljaANZMhkshotGrez1pwwFKVUnevbmXJqpGPSzYVASvsRQxxtRyd0ASGBQI0dy+uRZ
         41b9sTHoXBka9d6kvNm2+xWhoBj+T5baGK1IktTQF1h1pFaoFmwosH5b0rO7U3wGLAuK
         1ehA==
X-Gm-Message-State: ACgBeo2yMCCn2+te59vsahXu/tm+f6g+CnvYfWUjVy+aS+Ph+76eIcHR
        6IZGulA6qY24jDL1TrIUaUHb+0C9jJ7PylNMPdzm3Io/a/mWKQ==
X-Google-Smtp-Source: AA6agR4JjnExpRv4n1eMrsmIhVFafos2xFR3ioo2FP/EbwS6COrjicjMxE6HQPBIngZa6LV8TiXhRU83ZloWX1Tellw=
X-Received: by 2002:a17:907:6e9f:b0:73d:8c60:9ec5 with SMTP id
 sh31-20020a1709076e9f00b0073d8c609ec5mr2875419ejc.542.1661210136172; Mon, 22
 Aug 2022 16:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com> <CAGS_qxoVuRPF39kcVBWGuhnmaixfLAkPN6HaDRyuXmDHqmWPXg@mail.gmail.com>
 <CAGVoLp6CQO=Vw20GYYoYUEZr4BJM5FS8H8Fi3TgS0aXWVie4Lg@mail.gmail.com>
 <CAGS_qxrGVHWiEQz5b+zWz0JYmUwxnsVaoa_8SYOxb7nsRZ=iSw@mail.gmail.com> <CAGVoLp5zv5CR_Jo-dboaYF+7_8whV=rvfJHRGeVhNRTn6LzMoA@mail.gmail.com>
In-Reply-To: <CAGVoLp5zv5CR_Jo-dboaYF+7_8whV=rvfJHRGeVhNRTn6LzMoA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Aug 2022 16:15:24 -0700
Message-ID: <CAGS_qxqeJAMVBif0RVHZd=aiZZNm_io_LK4F3=bxUMa=Kkop1A@mail.gmail.com>
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
To:     Tales <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        Melissa Wen <mwen@igalia.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>,
        Magali Lemes <magalilemes00@gmail.com>,
        linux-hardening@vger.kernel.org
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

On Mon, Aug 22, 2022 at 4:12 PM Tales <tales.aparecida@gmail.com> wrote:
>
> I can bring your patches in my V3, if you don't mind! :D

Sounds good to me!
Thanks a lot for picking this up.

Daniel
