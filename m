Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECFC505F58
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Apr 2022 23:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiDRVcp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 17:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiDRVco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 17:32:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF62CCB6
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 14:29:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z12so18908875edl.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7LTWo0OPBrGCZjHYoN1cmnPJEUpa4jNozIjdW1Tjhc=;
        b=En4TB4U44B8KkvJ/oE6YRz8ktzHBFO2hSHQvrSQgM/I7HmDnWkoLceq8ho8OUiCv3e
         E5mWA0s4dFFlcwHdf18d6P/398+fXbLU3vorFjZjmSoyICv0siRicj2wlfEcXsi8nUG4
         u4gsxmjXMnIZAbFF7qKRl5GlhpeDJFS3t/aU6rEG16IG8yrQAJyfN/O33LGJ0qPLd94C
         UpWhiPZuaHS5uRDRVMLeteofq3HLTT6BrnUzikZt50XLXM3bo5xrBZKWfXGjc/48H6Be
         do5u0dX1oc4P60EgwzwKUeCUA/BRmcYkAID84Hidmcdxag7E4TNazut9vePsJXPnefVw
         S6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7LTWo0OPBrGCZjHYoN1cmnPJEUpa4jNozIjdW1Tjhc=;
        b=HRCkGADr8LJ53j5Kq3lu63O80Gnvg0qSI9TftGg7I/R3BZH8wg51yF6NoUPstARg4b
         yAaf/6iLLfzDbH6o3Up17jhkr8brfSiQR66hYP8LzP7wOLoBBPvNTR5bvLfeEmjPLdFW
         K4d4fNOWMOad9JVTChgTQZNBR62qeu2Uce6m7EKduhs0BSE3YDptCAAfUq14YPH41Zfb
         VvMJv/zdkmVdx8ulNamC9W/tVwL3xNOf1+YyxerAqLKu1yKvHl7f7qqYhGLwMIFjW1zd
         VOHP+GR178h7hb07ry3fadRgRjuvefiwtCSZn3yHOVqGx/SHG/pdb6fKQs8f3OtioAIC
         HYzw==
X-Gm-Message-State: AOAM531xP/3h02FN7tTpv5ui18HNrMiGTJnghi5zQBfFFh4rmtwfqUXq
        ZB+5jk3BWBbENrIGsxMKitdtzE4rAAyztiLAP2nRigWrsVHuZg==
X-Google-Smtp-Source: ABdhPJyV9fmS+hwdvvRUN2r//PwngZikr7xomDByGbznu+vO3elnnfiwHQRO9t3F2pz2zrmStYKSa7R9cdyG24KOkxQ=
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id
 f11-20020a0564021e8b00b0041c59f62c26mr14349493edf.156.1650317394544; Mon, 18
 Apr 2022 14:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220417102807.10b91497ed@19d04f311a0a9de>
In-Reply-To: <20220417102807.10b91497ed@19d04f311a0a9de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 18 Apr 2022 17:29:43 -0400
Message-ID: <CAFd5g46iNr_EnQ1zQGiXk34mND8-Xo3vTykpgKfbr-8_e5OOCw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: change complete_and_exit to kthread_complete_and_exit
To:     Andreas-Christian Hagau <ach@hagau.se>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 17, 2022 at 4:37 AM Andreas-Christian Hagau <ach@hagau.se> wrote:
>
> Commit cead18552660 ("exit: Rename complete_and_exit to
> kthread_complete_and_exit") renamed complete_and_exit to
> kthread_complete_and_exit.
>
> Signed-off-by: Andreas-Christian Hagau <ach@hagau.se>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
