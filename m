Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA353BAECB
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jul 2021 22:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGDU2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jul 2021 16:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhGDU2u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jul 2021 16:28:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D1BC061765
        for <linux-kselftest@vger.kernel.org>; Sun,  4 Jul 2021 13:26:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v14so3042061lfb.4
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jul 2021 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sharpeleven-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlUnqqhwGO2ss5CdIs4O+XCoeOXjYNdtyzXcVD3xri0=;
        b=XgKgDo6l95RCCdzJlIBW/z4zT5vKBNadDp8QG5dOQjynV0boSEhPF0UrBcurESS5Wq
         /X3IB2crM3pzM5qfh/JLt+LNIAQNGZOMOC1Od+DhnZkYZ3wkdAeL57Miz81y/A7ou/wE
         8MyBDCwpg0p25eCclaO0UhbvyN9T1LkQkUyBhVPYJUt5hoirEt8SS237XRHjNCoH4Szp
         Hon7C3jCttNWS6nbQZLsGHQYqLs5odKq/iJYB7y4q+gSWHqsjMSN5xzTktuJ7EVEmOHn
         aDJJDUpRAk9siQDdYqLCtQoa2OMuBs1VVvZORi0nEdwEZSOnVWEqmgJpLjiDjnWyB5yP
         XyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlUnqqhwGO2ss5CdIs4O+XCoeOXjYNdtyzXcVD3xri0=;
        b=nNaYFtKM86FL1gfYTasr1EhmG9+GtFR38MsEvRvh48HBkOOn5nniI8Zq+IjQr4w/UX
         Ho2wKiSuQYNS7rnVk5LZdce+r/06ZhzWgyyVbGfl6xL/+Q2It1k+VhYjUqPpTlxtMwWW
         fSpxdGOR54/sJs7JvoL8C7yxjxAaZqdiU3XzWkYtafpCccAT4MlkgiUNpaeOYlNLYr79
         rMFCTNdsVHWlq3TMeBngHyRZ5Vxm0lLTeXnt4DkpiddByhMRtWCwiXa8LNYHeVrPQLz7
         qnxEQMOO6EPd+04ePDldvJ85JcUfCZZPIcJq09+iwhX2lcNL5AgcTWjktdQH7dWnRqBF
         MAZg==
X-Gm-Message-State: AOAM530aZ+jOqposrHvkpV5WWnoHpAaHnZoFxmovPTMfbE35fnDsyjys
        tGELm88fGbtpd+811uwQU74S434vGlqlnCN3GtpGYJPZQoz4EAtq
X-Google-Smtp-Source: ABdhPJzT4kCTCfR+J5F2nu+OMI1Ah16dq9+EEowoXNfH4FF0nxjuR02KGz8ayP4IUw9c584xVK5UlyqW6aRMgEVaF1E=
X-Received: by 2002:ac2:55a7:: with SMTP id y7mr7943415lfg.179.1625430371579;
 Sun, 04 Jul 2021 13:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210702050543.2693141-1-mcgrof@kernel.org> <20210702050543.2693141-2-mcgrof@kernel.org>
 <YN6iSKCetBrk2y8V@kroah.com> <20210702190230.r46bck4vib7u3qo6@garbanzo>
 <YN/rtmZbd6velB1L@kroah.com> <20210703155203.uvxcolrddswecco6@garbanzo>
In-Reply-To: <20210703155203.uvxcolrddswecco6@garbanzo>
From:   Richard Fontana <fontana@sharpeleven.org>
Date:   Sun, 4 Jul 2021 16:26:00 -0400
Message-ID: <CAGT84B1fdypvndxk97wS59=5VgQ80LhWxxs_Yx33169P9WvKZg@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests: add tests_sysfs module
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tj@kernel.org,
        shuah@kernel.org, akpm@linux-foundation.org, rafael@kernel.org,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        andriin@fb.com, daniel@iogearbox.net, atenart@kernel.org,
        alobakin@pm.me, weiwan@google.com, ap420073@gmail.com,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 On Sat, Jul 3, 2021 at 11:52 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We don't have spdx license tag yet for copyleft-next,

https://spdx.org/licenses/copyleft-next-0.3.0.html
https://spdx.org/licenses/copyleft-next-0.3.1.html

Richard
