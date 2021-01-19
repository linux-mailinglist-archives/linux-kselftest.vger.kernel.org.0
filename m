Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B666F2FAE16
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 01:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbhASAfn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 19:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbhASAfm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 19:35:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07FCC061573;
        Mon, 18 Jan 2021 16:35:01 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o20so2777722pfu.0;
        Mon, 18 Jan 2021 16:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A+w50Vih7bh7r6NhMfLHjI3rJuvTXBao84Pg+b5ACWw=;
        b=asRzq3PbTXsbN36BQeFWyDx8o2hc/nmTp1JxvQ04asBOV6I8CorQKP6mKqf4un4z31
         /xq/XeKzmWxREskEI/JrNhKNzHs85oem6cLyZTM20vDrPSa6aLz3MV/ongHOLKzB1iww
         q64XSS+o/FuvwelGnaHlkArzbGml4nZNPoNEGmUAothzOunCZuO6m1fHSCgomJTWC6ts
         bLEAW/bQ8Bj6YCzKMlDy55E4ZxXBDeDjNBKXdPB3C+LJ2cmZUAgwTvBTB6cOwtNdXtt5
         Ko2c5CPqzTV76LgCm5rkuO1HFUVC9feXfvfhqARVs2cwlaPeFEzpo/wRzm+z79/xRnOh
         o0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+w50Vih7bh7r6NhMfLHjI3rJuvTXBao84Pg+b5ACWw=;
        b=jvoazLi5N6vzUj2BEFv20ignhlRyEto/6vYcb3lwaMn+As/qjJFX0uW7Y4O0dNDNyJ
         JTxb+N4GMt2kT8kKesElWl++wmLwkyICa8KNDuofZVnFKBD3V7fRfNb7yq+USCYxr7Va
         NzerplekQaa0LL4VnhFzZebO4KlJHdl3lHJwUeRpjSYD/R6eUPA7ZsuzlIrDQDhoV56T
         mBNVySDh18JyAO7DDlD91x9FNUlUcxpSbiQTc5NgL1j1InfHGDq+GlHfoLegYcS8qcNM
         xl0ME5rjSB6ORQ3xYGBZqqAHd7gxEvSzIbSKu3y1GMzJUr5ZZvmMzFc7i6xuzM4kGmgd
         yapA==
X-Gm-Message-State: AOAM531sakipoWQT1z3DafvQnRQK8AeMltDtQTwMSeHJg/UUotXI8R/E
        +ithDxdQY7SnqYFv/HXX2Jkr/nePbu8=
X-Google-Smtp-Source: ABdhPJwOJ+oDIl4+eeCArKn2hOOYdUE4j2JdQ33vMT9R+El9S+RT+FzKxeldExwX0y4jXSDrq75nrw==
X-Received: by 2002:a63:7503:: with SMTP id q3mr2048035pgc.318.1611016501393;
        Mon, 18 Jan 2021 16:35:01 -0800 (PST)
Received: from sol (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id x11sm4544431pfj.99.2021.01.18.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 16:35:00 -0800 (PST)
Date:   Tue, 19 Jan 2021 08:34:55 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Subject: Re: [PATCH v2 0/7] selftests: gpio: rework and port to GPIO uAPI v2
Message-ID: <20210119003455.GB5169@sol>
References: <20210107025731.226017-1-warthog618@gmail.com>
 <CACRpkdZf2GhScg=sUG35nA5P6jXH93uuK0Fq_uhz29wBQLHOKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZf2GhScg=sUG35nA5P6jXH93uuK0Fq_uhz29wBQLHOKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 04:04:51PM +0100, Linus Walleij wrote:
> On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
> 
> >   selftests: gpio: rework and simplify test implementation
> >   selftests: gpio: remove obsolete gpio-mockup-chardev.c
> >   selftests: remove obsolete build restriction for gpio
> >   selftests: remove obsolete gpio references from kselftest_deps.sh
> >   tools: gpio: remove uAPI v1 code no longer used by selftests
> >   selftests: gpio: port to GPIO uAPI v2
> >   selftests: gpio: add CONFIG_GPIO_CDEV to config
> 
> Bartosz I think you can just merge these patches into the GPIO tree, at least
> I think that is what I have done in the past.
> 

Could you touch up that Fixes tag in patch 1 if you merge v2?

Thanks,
Kent.
