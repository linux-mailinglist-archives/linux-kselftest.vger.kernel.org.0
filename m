Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918868BB0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfHMOCq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 10:02:46 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23032 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfHMOCp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 10:02:45 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x7DE2LBr008312;
        Tue, 13 Aug 2019 23:02:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x7DE2LBr008312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565704942;
        bh=z65fPGDahcnryu8DhIatCdFIBN0i5WPEfMnwm+YXA4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CI39gKp3izRC6qSGFBNX/kCIo5zgwhcHNjJ0klwyhnrPKDe70/O+hr0H0NAEI+kmH
         I/BcqgEknJ5q3Iat9Pvs9Pz4WY1DCCUwuwQ5UYuJytIBBYuLLQ0cfgbj8UAk5h7Xua
         OI6/a/EzUjQTx0TgtRh1KNgXwU1F8Mdsv4PldBFWjVswQZ0Ys80IGDGEBerwy+WrwN
         Kq5Gc+2NDwqyWvUvsA6jp+kNhyGgryADdwCTTK0IFiuKJ45yRqkX6SZuMaZOxLwtQp
         MhNVqr/ZygQcS/T+WCZMlPCxydJZinc5VDZsqeDIFPNr0RrbXksEFbMMvnPVscA24A
         gQFUvg95pt//w==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id b69so21478385vkb.3;
        Tue, 13 Aug 2019 07:02:22 -0700 (PDT)
X-Gm-Message-State: APjAAAVPobbB7OiPvcBIaUSZH0PVAPSnz7E7qNnDGRpBlFk3VXdXrj71
        IzfNOXt5kbFRjUV6LZDzck7HIGqHqq9Y+JPRb/0=
X-Google-Smtp-Source: APXvYqz3aFljvtlpAD72NHlQRrKDuY3wG9MXnKaFwqB+6BzT7mQJE2e654j7yBwvhbrjtVpBWbbnXPRoD2cX9MXmRDs=
X-Received: by 2002:a1f:5dc2:: with SMTP id r185mr8458472vkb.64.1565704940854;
 Tue, 13 Aug 2019 07:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <be2c361eac49ded2848b2a555b75e30cc3c24e71.1565676440.git-series.knut.omang@oracle.com>
In-Reply-To: <be2c361eac49ded2848b2a555b75e30cc3c24e71.1565676440.git-series.knut.omang@oracle.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 13 Aug 2019 23:01:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASX4jPRxRxD+JafAfKqjck=x27HuHZgPV1VFfW8MzcwZA@mail.gmail.com>
Message-ID: <CAK7LNASX4jPRxRxD+JafAfKqjck=x27HuHZgPV1VFfW8MzcwZA@mail.gmail.com>
Subject: Re: [RFC 01/19] kbuild: Fixes to rules for host-cshlib and host-cxxshlib
To:     Knut Omang <knut.omang@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 13, 2019 at 3:13 PM Knut Omang <knut.omang@oracle.com> wrote:
>
> C++ libraries interfacing to C APIs might sometimes need some glue
> logic more easily written in C.
> Allow a C++ library to also contain 0 or more C objects.
>
> Also fix rules for both C and C++ shared libraries:
> - C++ shared libraries depended on .c instead of .cc files
> - Rules were referenced as -objs instead of the intended
>   -cobjs and -cxxobjs following the pattern from hostprogs*.
>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>


How is this patch related to the rest of this series?


This patch breaks GCC-plugins.
Did you really compile-test this patch before the submission?



--
Best Regards

Masahiro Yamada
