Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D231B7F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 12:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBOLZn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 06:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBOLZm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 06:25:42 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22429C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 03:25:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id y26so10449095eju.13
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q5xS7lRux6r5/KQvjd1uY1boLs2WXO4iuyD7LvYL194=;
        b=Av0x+TovCBGNsShSsqo8bGJVmFKdmLndJmjOpXZnG9qmNZtwPfDL0Dfav69fNbOkgb
         9aA0LkIRdsveAAjxNajIYQhPzOAxjjFxt3lkzYIdpoDnlZR0LPhyD/lYNvEHilYDDbxw
         JTJqqsB0Mvfrj8QNZqf4FdqAYFEI+PCggCiY8TnW4Vh3WuWjrDswgErtah90VufGQUEW
         hQSitqSl3y+dmm7Ows3hJfHj2BuMTSwX+/pFAnyAjhMzH68Z7Ti22Lneu8Ao8mTMLa4O
         lp4hteoCyGRoHjfA6+FjG2LHEvA0pMlCQxWiuxjlfs04B54GjbNrsX5ctwGPNU/JFMDT
         OwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q5xS7lRux6r5/KQvjd1uY1boLs2WXO4iuyD7LvYL194=;
        b=terwYeyxcd96h+xQA4juV3DMKNlXrgbfeAmG0oRpRLXCI6yOszYzk76cWg3HMt+I8O
         Z+Vuk2roiSZOrNlu+IngVx7c74BRCnnEz/Xdi3wcSXs1xD29+JPq8TVrWFZA57YRGBLf
         dASGE2D0OFruOnZzEonX5T6Fy4HeVV9ROhauVkqV2+OH7ipzTUEjq1GeK9cxLv+B472M
         qGyvgIh/Wg92R6+dnlbxFnPFhNZvX3HF8IDQm7XaJI6bzZQvJldzpWLIi0skyrXjOeFP
         h3HmHGf6H/M95+LKPLXw671DD27cRDCO8QI1PimbpiP+LwyBdQOv5Ueb/SPRRWAi1syF
         OsnA==
X-Gm-Message-State: AOAM533UFEa8TqVQkbUrquLr+r35/E4Mow+hC1xwc+zWufsuunONMio5
        TGqQWynkf6BiwuHNqXxhHgA=
X-Google-Smtp-Source: ABdhPJxEc02iG2VSGpNQ1SXZJWX4Ni77JgEoCA8jqMRCkBmc89PcrZTV9rZzM/0PKhyZUOcn27h7kQ==
X-Received: by 2002:a17:906:ae50:: with SMTP id lf16mr15299319ejb.66.1613388300895;
        Mon, 15 Feb 2021 03:25:00 -0800 (PST)
Received: from skbuf (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id h10sm9543167edk.45.2021.02.15.03.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 03:25:00 -0800 (PST)
Date:   Mon, 15 Feb 2021 13:24:59 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     shuah@kernel.org, richardcochran@gmail.com, davem@davemloft.net,
        vincent.cheng.xh@renesas.com, christian.riesch@omicron.at,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] testptp: Fix compile with musl libc
Message-ID: <20210215112459.rykixckksyb33qmc@skbuf>
References: <20210214170940.32358-1-hauke@hauke-m.de>
 <20210214173716.hxzb2nk6f7cx262n@skbuf>
 <07b844e0-ea27-8607-b631-f946fe8af7f9@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b844e0-ea27-8607-b631-f946fe8af7f9@hauke-m.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 14, 2021 at 07:00:39PM +0100, Hauke Mehrtens wrote:
> glibc 2.14 was released 1. June 2011 and musl libc also supports this
> function since version v0.9.7 28. October 2012. I would just assume that the
> libc has this function.

Considering that somebody wanted it to work with a GNU libc prior to
2011, why would we not assume that somebody will eventually want it to
work with a musl libc prior to 2012?

> musl also does some special handling, probably for the 64 bit time handling,
> in this function:
> https://git.musl-libc.org/cgit/musl/tree/src/linux/clock_adjtime.c#n37
> I am not sure if this will also work fine with the compat function.

I've stared at commit
https://git.musl-libc.org/cgit/musl/commit/src/linux/clock_adjtime.c?id=2b4fd6f75b4fa66d28cddcf165ad48e8fda486d1
which added the conversion logic between struct ktimex64/struct ktimex
and struct timex, and sadly I don't understand what is the point of
wrapping the clock_adjtime function around the SYS_clock_adjtime64
syscall, when the struct timex::time member will still not be Y2038 safe
on 32-bit systems...

That being said, I didn't know that musl libc provides any wrappers
around these syscalls.
