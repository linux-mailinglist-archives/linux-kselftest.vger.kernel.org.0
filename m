Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCBA2317CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 04:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgG2Cz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 22:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2Cz2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 22:55:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A2C0619D2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jul 2020 19:55:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so1326180wmd.4
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jul 2020 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ln9vWFQ/R74p2MABDMNrBE8755UppvYDgTP+VF5FnfY=;
        b=As1cLWvjMWIb8eYeBcN+UOPdKjgux7/c9qT+PwRSvDOtEpdrzZ7k0cjGME45WL4C2l
         IjTsPWpeM65JmZWEJWkNUNgKM4fmEyNSiCBNuF6cWifnQRvuMsa315jznyOoArIPg6y/
         WWDhkvCqim2MSOevJgFas6W8w5QXmGEpf8tskRzUqGljtxsNZWm7U9QO5ZQbst4PgAwI
         8/xXX5IdpK9Es+qz8B/5HeCWQAS9PTy2NajE2O1lYDvviFHhZGnq8xGws81kJanxq3oc
         CuxTW6jFIsIucM7XBtcZNt3sFDD2ywmgh6c4bGVNWhmhEg7hC/jhPGYcMxbVSaMQpgQU
         8s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ln9vWFQ/R74p2MABDMNrBE8755UppvYDgTP+VF5FnfY=;
        b=RPnQvp14XoC810FJRBVQU89etwLjGnS6R+PjBpU+sFUm4FvHvRP+yvVYunOWNI1pbI
         7uqIdELPL/RzCxebEU1Na0fF9jg6WaKDVMq6nixQKxvQIoYp0MUKS6oYsTJMnmvgLGEz
         Zz0/lzxQzbwpK4fkjUTwigxWLcB0AtqBiVHrALRwotoF13bbnkodmnZ3Rd8xl9QcbgVM
         LaryrXsefx/6KiuWtfge2siWuZtoBLDJBmq88XRxeVcdLOgkwF2NVgiUlvZpw7DbFiIN
         k9a/sNcnVmvgjGQLT2q9IKELvr8NJmoDUfj7Cus+kY7SxmJa6/UccX3lzuvYph9Fx1IL
         JLfQ==
X-Gm-Message-State: AOAM531GVz9bxjkq+2IowzsHB7/XJ258x68lLA255wkYGJiFn7/ONCBV
        i0d4Jdbx69+oKvoOo5L9rgAc/eascPe6Dy1bsie47w==
X-Google-Smtp-Source: ABdhPJxT3j5WynGVuW0VuoY8qY/5Amc/7kfSdWeRsPvEvMDgZGYVIzeOtUQvTj9hYexyARXZu48S57GO/r051ILiNu8=
X-Received: by 2002:a1c:7d81:: with SMTP id y123mr6189574wmc.87.1595991326463;
 Tue, 28 Jul 2020 19:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <3f437939521cea1157b6803acd312e1a04399474.1595990061.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <3f437939521cea1157b6803acd312e1a04399474.1595990061.git.marcelo.schmitt1@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 29 Jul 2020 10:55:15 +0800
Message-ID: <CABVgOS=FaHb6QLCcSnNBfXAHha+hRPkgQZD0GKxnWjPWuSb2Dg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: adjust parse regex
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        felixguoxiuping@gmail.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 10:42 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> kunit config subcommand terminates with error if .config has a
> configuration assigned with a string, for instance:
>
> CONFIG_CC_VERSION_TEXT="gcc (distro package version) ..."
>
> This patch adjusts the parse regex to consider such string assignments.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---

Thanks, Marcelo.

I think we've actually already got a fix for this upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3f37d14b8a3152441f36b6bc74000996679f0998

Cheers,
-- David
