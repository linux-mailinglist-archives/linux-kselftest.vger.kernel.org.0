Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2E59CA71
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 22:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiHVU5p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiHVU5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 16:57:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C784F6B3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:57:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j21so18263518ejs.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8+w/4wN4Kn9IuMC++iFFlzp2WwbxqZ59X9FUeGfwhBk=;
        b=fYYniBxHiVwcF2BmK3KQ22wU18o0DH33kdvQM6owzc54phQZrADAhsB0KUNjBTW/4n
         KFBdJhx6Z5RaGTornUDAQGK5YUy58LxrDcvf420f1nAiTx++9ViqxzcvJqQsJNUw+OuF
         GihnHM+cOFx0Bv4xBwPad9Q6w8qsZXl+zK3E8dEzelty1iphcn04DW5GEBDCm/jMeb4T
         OCw+eBlz1p2gFFX0SxO7PjXrHiITKW14F8RKRy6DSuilWy1GqjXtCI89SfVsfhw9CCyK
         DGGfE9xAoFSC4CvnXV0F96uY1FSfdgkWzbv3QuRmkEntsc8VzqjjkBN3m9rUrHC9t1aB
         jtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8+w/4wN4Kn9IuMC++iFFlzp2WwbxqZ59X9FUeGfwhBk=;
        b=NZHtAJVTNzgfqDryYfXPh8WwjZ9/onz+V3K3ykpD2i7us44VKtHvTzXv5RDVBUIdvS
         emoqYBLO/OxIR7lBMKapcBiDPESkhkQJunfhPsMAcJYQ/s8SlSndrZjSvQHVXe76AL1n
         OHtQQuc87OV3dUuD7hx+my+sKjjrtbU0wNM98aD3qc4pt5BXGRQf/SNFEBAZFCWyCINk
         JNgHWFwwc65hRnghmK4LyWZiqAL+xy+OIXDDTX6n1X37NetHVHZj/1gWojqZfhPLKIdK
         CRDE1RA+79JFsnT0XufUA7RwWh09Oqg91o4SKZCKTRNXTkk/rj0X8VPCzk/u/yYmhja1
         oHEQ==
X-Gm-Message-State: ACgBeo2UOr5qIqmtP2MMn0YPP3kYFUk3E87F1EzuxJhtsCdG3KWIz9GD
        OHSp9KJe9kZn7aQF5OgA7V9IfGgEbAQltaBlAXTA+g==
X-Google-Smtp-Source: AA6agR5pxXGlEMxNRs7Z2OKkdwJ6xNz0jSc1iyTiUnWSENLuvFQ1tVkv1QnGjApffh+raGhWW64rAVp/Am8ZXS94LrI=
X-Received: by 2002:a17:907:971d:b0:73d:78c8:77b5 with SMTP id
 jg29-20020a170907971d00b0073d78c877b5mr5455613ejc.631.1661201860966; Mon, 22
 Aug 2022 13:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220817164851.3574140-1-joefradley@google.com> <20220817164851.3574140-3-joefradley@google.com>
In-Reply-To: <20220817164851.3574140-3-joefradley@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 22 Aug 2022 16:57:29 -0400
Message-ID: <CAFd5g47Wm=CSa1T-ySxrvOsE8VzVwOstsfus=_52EX7gvLgvyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: no longer call module_info(test, "Y") for
 kunit modules
To:     Joe Fradley <joefradley@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Wed, Aug 17, 2022 at 12:49 PM 'Joe Fradley' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Because KUnit test execution is not a guarantee with the kunit.enable
> parameter we want to be careful to only taint the kernel only if an
> actual test runs. Calling module_info(test, "Y") for every KUnit module
> automatically causes the kernel to be tainted upon module load. Therefore,
> we're removing this call and relying on the KUnit framework to taint the
> kernel or not.
>
> Signed-off-by: Joe Fradley <joefradley@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
