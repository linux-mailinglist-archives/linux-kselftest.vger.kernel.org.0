Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0633C5EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 19:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCOSmd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhCOSmL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 14:42:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B9BC06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 11:42:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u4so58520510lfs.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8V+rz6dHaPmJOhTso7qaASysVmTy2044POg4ldMfuo4=;
        b=jRLwWt7H0Pi4ZkUjPDCFeT16PhziKfzVweJicDH6BGT2nG7Cy/kRDUnJPioZ/JnWAn
         bwgHa+chUnQvk59xxIJpUbENzw99d0R9GTDLDRPnq7XHtxvvh3s8n3EEsGXJXEYlq4et
         hqPq8AqYf1iKq9yb7kfKB8SBpScpb+CMlOGq43zaknms2PxRynqWw9cnj6tOZeMOT/OZ
         S+yqa58GRS2ncCJBI4rmykPvMeuhGIZ2yVsPGzrLNG/8dlSApnPsJSZAnMtr+s8t+P89
         QdohGlPsG8m0y7+qonqrmrEV7aad2z3vPHEkCLlF91M5LRQEe63Df/Tq1qlBqlp2pPGp
         8J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8V+rz6dHaPmJOhTso7qaASysVmTy2044POg4ldMfuo4=;
        b=Ljk1wLkG9awXT3Gst3Ax5+0vzzA3MR2TQnChp4QJBLQ1DVP9esjXa3oRzjl1N0yWzj
         Uh1oI+o8Qr+iKn3VlzUPTkVHPhYzWBmrsy3xudGLL24kBB4dpxWfvR7ueWl/5Gg4qKsK
         FGXOFTaLXXvMFwdvknvYDSkZQR2zjUo2cUi5mdOOfR2K50rVl/qI3/c2hEMu3CPmfHqL
         vA+lHgvA3iBaoh5gSJf5t3gpGGceq/02ICXT+COXSJWMVi8pJcc5X/HmtNmFkgRT8+4x
         gD5UztBB7CY5qHqqYUY1zkovH7wLSqNXMD+CLmQGq5poJvMkvpJE8lsxPGnp8vt2JEZy
         zy/g==
X-Gm-Message-State: AOAM533/URn6CsCEAq8TUJAp6I2zOSyIpRSa0EsZOnGKNNrLHYCXlQZD
        xMA+nB/N2OzcNhREmtkCWDtrdPLoDRRpH29e4iQnNg==
X-Google-Smtp-Source: ABdhPJz2wKAyWfvmM0JOI48gzt1V0Qdip+vbLcJCzgXWjWu8sJ4chylMWs3OtOsW0Qw0gKwjeJnLXJ3gpBLK9eXKm2M=
X-Received: by 2002:ac2:549c:: with SMTP id t28mr8490298lfk.7.1615833728903;
 Mon, 15 Mar 2021 11:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210315123303.10218-1-colin.king@canonical.com>
In-Reply-To: <20210315123303.10218-1-colin.king@canonical.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 15 Mar 2021 11:41:58 -0700
Message-ID: <CALAqxLW1VaMTVx3piKnLcEqWxMcQFG9LujH1ijHP2dbXBQaxqA@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers: Fix spelling mistake "clocksourc" -> "clocksource"
To:     Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 15, 2021 at 5:33 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a comment. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Akcde-yb: John Stultz <john.stultz@linaro.org>

I kid, I kid!  My apologies and thanks!

Acked-by: John Stultz <john.stultz@linaro.org>
