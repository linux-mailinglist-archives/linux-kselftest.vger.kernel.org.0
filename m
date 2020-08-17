Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF43245AD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Aug 2020 04:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHQCy1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Aug 2020 22:54:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37501 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgHQCyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Aug 2020 22:54:25 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1k7VHz-0008Qu-SD
        for linux-kselftest@vger.kernel.org; Mon, 17 Aug 2020 02:54:23 +0000
Received: by mail-lj1-f198.google.com with SMTP id h5so2551381ljj.10
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Aug 2020 19:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2jjPmQel1pxO3MR/VLtINS4dkeaCDgPDRMj2nur9GY=;
        b=HY+8tngXPg4mlj7JIR4e3PrMmEmiZs6Oyc/G8dLmxJ4LVCiYnTJU3oI7fVa7A8oAsP
         kGkNPlB8HEZYtTrsHZmw5bkyW/DBKZH74G6NQkF03Lazlm+KqISDW1DZFzzNN1Uvn+X9
         DW0iDQDCc5sGd24YoNEvja6IgGcLmUsRnux+/BorR+5a8yGPlTfe/lE1O1vlhF+++L9U
         M8ldQkXq5iZAyBCWzWnh3+ppImU/QLcMy0b+ssBKGqo/k9tWnRLGoOdsSdczdzMx02WM
         043H6iNbDmtKqqcTOhg1EvakYkXjCpys725V39alaI5b/oUJbNvf6hurCEjcFjUlb3x8
         cXfw==
X-Gm-Message-State: AOAM533TX30/idBQ1GhLOQp7zkJptfvaN/mr/QvKmXx0lh6RGCSr/Lcy
        cMwBMmYcTcG2u6XPOGUEfppm0R9OBrGLXpf497B1/QXoYQB+JPJt/2YcbG16ERDLBUnMSrDi8Ff
        XDcuNlQiQiMduB7iyjcXhkD9u+BNVa3AWm14By5UPXlLicAAPtgi4hP5MHthf
X-Received: by 2002:a2e:5852:: with SMTP id x18mr5999010ljd.132.1597632863219;
        Sun, 16 Aug 2020 19:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKXtlo/YWR4lvo0OddtBB/rs+kUFiIctf6mWJJC51t+bciEX3/ht7hX9V6E1ApK6z9Nw/nUfoKWf/ZsXlQ39Q=
X-Received: by 2002:a2e:5852:: with SMTP id x18mr5999003ljd.132.1597632863006;
 Sun, 16 Aug 2020 19:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200813044422.46713-1-po-hsu.lin@canonical.com> <20200814.164354.1568500831741804705.davem@davemloft.net>
In-Reply-To: <20200814.164354.1568500831741804705.davem@davemloft.net>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 17 Aug 2020 10:54:12 +0800
Message-ID: <CAMy_GT8bnVCDEgDfDEbVexpV6vgmCBRPe+v6WVxnOYdCXft=nQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: rtnetlink: load fou module for kci_test_encap_fou()
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 15, 2020 at 7:43 AM David Miller <davem@davemloft.net> wrote:
>
> From: Po-Hsu Lin <po-hsu.lin@canonical.com>
> Date: Thu, 13 Aug 2020 12:44:22 +0800
>
> > diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> > index 3b42c06b..96d2763 100644
> > --- a/tools/testing/selftests/net/config
> > +++ b/tools/testing/selftests/net/config
> > @@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
> >  CONFIG_NET_SCH_NETEM=y
> >  CONFIG_TEST_BLACKHOLE_DEV=m
> >  CONFIG_KALLSYMS=y
> > +CONFIG_NET_FOU
>
> You need to assign it a value, not just add it to the file by itself.
Oops!
Patch re-submitted.
Thanks for catching this.
