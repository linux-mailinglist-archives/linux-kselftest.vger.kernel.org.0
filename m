Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE03577FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhDGWv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDGWv5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 18:51:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA5C061760;
        Wed,  7 Apr 2021 15:51:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so3798967pjb.0;
        Wed, 07 Apr 2021 15:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgPfAhHXqMoy6vJnPfG5IIOlPZRwNfuNehQ3+fiErZg=;
        b=WBPzgtBaGILmG5MWe1cdPTLspW1zWPgzBxOHeRFyI9oNgTBRoOzxlnCjHPxfxsOC1/
         m5xMiCcbeIlSQhSeBCZvi3j1iz8OwIZbuVA9308Nzf8lh3p9CtlaneD4kLEtFK5QISVF
         etkA/4s5UMX0nod2rmWZCCNOvfHlIjnSs8wLjHDMGht5idehxHRlvY4Yo7yCssj68Q6G
         sCnbxhLo+tydgph4Pt3/NWPmoez+FUc0fayrCVydlixpjkCV8/1cnDr45HwexuOHTEKM
         mVNFyAz6Nk8SxoTYEnwavg9uAqYm7mxdcper0f3ut4YLX0d9+sma51NWlKp/uQ3uqfZe
         IMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgPfAhHXqMoy6vJnPfG5IIOlPZRwNfuNehQ3+fiErZg=;
        b=YlHnMRcT5G6Ft52FucN7M+hJ3MNoIeCH16Hxa6mBY0YdtlFXUiJlfFEtXHyci417AZ
         qK52UKedcWe1D91dihapKSGCdM3bNISiY0Q8ehPlBfuLM9EDcLEamZyS6v0Bx1JUvjt1
         vPt2bp8aKt2n6P+oj86QjqtjVDX3v7hX4pVM1n28mry+PGQY301s7PHwDjFn6SN0gLxl
         A48O4wEoxQphugl2Ls7HY1Dge7dZhaUcGT/i6H3Sc3oK7OTiL3LmZI3aV77UBC70tvtO
         26xEesFrbLgR3k5WngT8qIX/spmbLL93goqaicyJJDFWysJNeQth1xZvxHUsKM186xnx
         WYzQ==
X-Gm-Message-State: AOAM53332I/ySdXlQQDrvY+Phx9eiD9IdMxpeoHdTvpd+GCGdpzJGRQU
        lbruDVTDB1ZNKzpA91p5PwQvgGS1sK1PBYsr5BM=
X-Google-Smtp-Source: ABdhPJy9stg3QYcMaqURxTma45eWavwwq9g44GznI2BjzG6qp/K16EWCe6Sb/5WyxsV3R7ja14c87YL720P9Ph2eWzU=
X-Received: by 2002:a17:90a:5407:: with SMTP id z7mr5559293pjh.228.1617835906867;
 Wed, 07 Apr 2021 15:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsiRYaE+y44ApDkvPvbDCdiJ+nnCMhiiaPVsg6p8m4+1Q@mail.gmail.com>
In-Reply-To: <CA+G9fYsiRYaE+y44ApDkvPvbDCdiJ+nnCMhiiaPVsg6p8m4+1Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Apr 2021 01:51:28 +0300
Message-ID: <CAHp75VdJ7kGXN6sk8HTeSfAKQtHDGSmtdVPn7CSkK5=yfDizuA@mail.gmail.com>
Subject: Re: [next] [arm64] [gpio] BUG: key has not been registered! DEBUG_LOCKS_WARN_ON:
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Colin King <colin.king@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 8, 2021 at 12:38 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While running kselftest recently added gpio gpio-sim.sh test case the following
> warning was triggered on Linux next tag 20210330 tag running on arm64 juno
> and hikey devices.
>
> GOOD: next-20210326
> BAD: next-20210330
>
> This is still happening today on Linux next tag 20210407.

Can you add the following

  sysfs_attr_init(attrs[i]);

to the end of the loop in gpio_sim_setup_sysfs()?

If it fixes an issue I'll send a formal patch.

-- 
With Best Regards,
Andy Shevchenko
