Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695B1F6F65
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 23:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFKVW1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgFKVW1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 17:22:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DFDC08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 14:22:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so2805825plo.12
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2WL77hiAzb90wuEqJ5UyE+b+qKfSpj9bKKe0Q8kvd8=;
        b=WpZItS0vXXqlMWB8ryeAOCq74Job8TOExQ5dkpfjAlF5u8sbOTyw2RHRoXgj3vyL+i
         ziuhIJipaNvWBKFxaaU8ULv79UnqNkk/hdSdgsbzPIDMvIs/zDKiJf3UhrPyFS0udtlz
         of4eOmyBCC6SJ4Oj1sptd4RGCP1Oywa7H2udyXh32hyAZi+bTXs5g6cASTp3Xoj4z4rJ
         6ojnEev9FzwemoFNm2MURW5PMNbkGpQ1YvpsplPbEv4R9uZfdFqtwtZrFF2F5PErLIEF
         CoMoj19FHpYgr0FQUaJjlOuhpXD0yLQtEkO+3UbYYiDMTra0chfwArtoWSXeW5NfjdAA
         rWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2WL77hiAzb90wuEqJ5UyE+b+qKfSpj9bKKe0Q8kvd8=;
        b=anPWqhDPLFsYPt7hqJaDfytZmhWxYri4O3/7eQXDSWk53I/5MSj2uiIcOHrWXjdXph
         Hnzy3PH5NX+cSHIzzoL4HhIXgNMiURSVTmKPoXGMoH+D131lbUnVVMoeDek48HTEpTfR
         lnzDhBFl8uyc3mkXnxv8H2U5A1ksA1acN5OTaHC1/qzxteyEhAp0UOSoCbst/dxIY3OS
         wXJroyBk8qtvdxFysMVNrpf3DqqFRH7jeOaAmUj2TFlXTOt0+PJmTerEgggwNJG2okzw
         T1GCOHuq1BgfvEnUwcRgGI5CNuKNGGwLii3urPI9av1VAkh7X/z30F/+8pb1tczXszC5
         tt4g==
X-Gm-Message-State: AOAM530Gy3hYl71x1gdFVgVZkriMnuQrYpHn6V94lzEAiQSYst/KjVqL
        GigVF2awGXg82glaCbxA7wlrbakVC09cFiQ9xAHfSQ==
X-Google-Smtp-Source: ABdhPJzc9BjwWRB35loqLZC1e1TrbrLfLfcMj8L5zj+R49P0QegJX42IfCg2XZ7QwBCv9yz22w/xfIypD77Q5i2FdA0=
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr9849633pjb.20.1591910546427;
 Thu, 11 Jun 2020 14:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200611210545.173886-1-urielguajardojr@gmail.com>
In-Reply-To: <20200611210545.173886-1-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 11 Jun 2020 14:22:15 -0700
Message-ID: <CAFd5g465Srr04ToYC76P3QGH6eYbQMeCN5jBLiNLo=A_soMNYA@mail.gmail.com>
Subject: Re: [PATCH] kunit: show error if kunit results are not present
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 11, 2020 at 2:17 PM Uriel Guajardo
<urielguajardojr@gmail.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> Currently, if the kernel is configured incorrectly or if it crashes before any
> kunit tests are run, kunit finishes without error, reporting
> that 0 test cases were run.
>
> To fix this, an error is shown when the tap header is not found, which
> indicates that kunit was not able to run at all.
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
