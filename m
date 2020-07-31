Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D0233EC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 07:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgGaFuu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 01:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgGaFuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 01:50:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649DC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jul 2020 22:50:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so16392368pls.4
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jul 2020 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPQTMMuUie6XJgopmwRnDGUbsFO8oXkWbGOWjLGiBQo=;
        b=Os677kuuNvMKQYx2pXT/cjvVadrtcqtx9pUBxd76a5AQsJuD7IXHqglgWnx4ml0RuS
         mgynRnZcACLF6szDB3raYg3Bga416fU/r90Q4NnJlRsPGANHjc7gpdqh+vtxHijU8u0B
         3lTwGRJxqoUfBi7kLAyQ/Z45PXxBCNrQGWu3seGH30CeW5/d7rIqqRprhJAWsqVPbyeq
         zFcT9ljJbdXFRy12xu2ssJYeVyi/1z12UcaN4xszgG4oR3ynQFQkQ8iodBfsQi8mc52Z
         goRLFkCzZQS4w/B8K8n+L8P8k/xtjz9D9p97VQHCHjSrBfDCr3s3IWGyi/O8jADOgVdv
         AjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPQTMMuUie6XJgopmwRnDGUbsFO8oXkWbGOWjLGiBQo=;
        b=khpurXn3/JOkpNHxC6EvZpm5QL/4W5YFfo4J47zmEtfuBFtsDWTkYUVDTFosim5l/c
         ZTr/oW6SXaFGqxggaSRFjSLswVQr+RTLv2IvR4QeI8jLn5zz7JrQOwzYPbBhVSmX3yNg
         q6mxTpTKqWrj76ODADp22qoeslI+DF20xddXD6x5BvJDdPSd9UEJ+uPnQBuYMXn5Pcs5
         GAv/9mEBPRmZX1TaPI71vexei+QV1sRTYQhvtegdkzseENlqU1YcgLPYZpXfICz1YhxU
         xa1p/w1/vY/ffejOR+axSFUnPviq8ovkjxfv4z6bBISLxWpg+zBN1KWolEE4ijW9HynK
         DkhA==
X-Gm-Message-State: AOAM533sVGlDka9+5IuX/K6wrxdWgunVETpBCIo7oQ7VOOS5xGk0JHEk
        zVQEmV7jTUR++gg6W6W8SJPYuLIJF3dRMSKEMA5phg==
X-Google-Smtp-Source: ABdhPJxKv2g8sKZeB55V/Np8ZzNtHyGySCg0eNp27a92WFk7ob3lUVGsyrtY2NRfNBuyj2fhT8mxdMZAjDxcjKfw5VU=
X-Received: by 2002:a63:d501:: with SMTP id c1mr2185919pgg.159.1596174649335;
 Thu, 30 Jul 2020 22:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200730121656.45302-1-98.arpi@gmail.com>
In-Reply-To: <20200730121656.45302-1-98.arpi@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jul 2020 22:50:38 -0700
Message-ID: <CAFd5g46wpYxF1=bs3LvXeVg6mPHrT6Ggp=QxScaf87O=yqcpBA@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert test_uuid.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 30, 2020 at 5:18 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Converts test lib/test_uuid.c to KUnit

Can you add some more detail to the commit message? Maybe link to
KUnit and say something about why this change is beneficial.

> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>

Change mostly looks good to me.
