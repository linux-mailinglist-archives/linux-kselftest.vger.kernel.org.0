Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0286439D032
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jun 2021 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFFRec (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Jun 2021 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFFReb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Jun 2021 13:34:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB3C061766;
        Sun,  6 Jun 2021 10:32:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so10450769pjz.3;
        Sun, 06 Jun 2021 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cRPepCTS6zgzWUNR1A/pDqzrNSJcYoBgYKnfTBAwU2s=;
        b=eK2nRLBec2pVJQtCqMIfpIsU5SSncVBjK+jLTXHp5xYRkEVTtNKpwDgS+iYIEtp81w
         ynNFxNCRfEu4qARTV9AT3t/YWnMVtkS5lGmAQ4a4Elzl8EJJ09RrTsCkGP2T0EUPlIrU
         8oVewjsqYChLPlG2WjRfk3L7Mv5ZvtTQlC8kgtkoQ2KvME3vxb/UsfGmkVh88OzWONCq
         X5scpsLAFx6mcfCPjSMydB8IcoameDS0OTh2vdwHOR/dEVU0FmCrCIr/T7Qler96onLK
         WNtBpioomzFtdibwJpGimt3dPWZQGo4nCdrASq85D6VtRjuyQyw6NN5g27gSHYojvkSQ
         T3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cRPepCTS6zgzWUNR1A/pDqzrNSJcYoBgYKnfTBAwU2s=;
        b=XxA8iflt5c1EUXGr0HYTII90GzPOfw2Y/jFNZlOxuaNpk387aKiDoVcY8O5VIBrNyZ
         k95n4MAUGXSleMG2E/4aJfdPcezxM/sZgiu6G1WYflQSlVygLJiNWGjWZfuz67k7ajyv
         Aiwvp2HnDchTtjXtBWc+z777/eUUQoXxoom3ZYByxZvH9ZFVne+8+4y7OK5p3SZiXcc7
         TRVwCz36b3qUgSwq5ILhvft9r6MwMjG7CHBSzNSxDNONcNtrLOFoN6Br8pW5wiEkmo5g
         ICbAwasu+z5RFVwjFgby+6xyZBcTsxw/HmPfFJ58q5MR3SeQAlf0WorTzWF++zsidnxv
         AMtg==
X-Gm-Message-State: AOAM530hZk67XMZ9tVuOMgSfM8Ba3R1QE5Onak++ZEazU2mgDx2S6/Ky
        NYOxggEf4hlUVjl4IxayP9BHd/S6N5PE6m5VeyQ=
X-Google-Smtp-Source: ABdhPJxsq0mOS1qpRZ81nJSUUUuAwLr8X8jQ+tah7IjEZ35KbttqRrCVBgqRcV8rQPTXSP5G0lqQ4yDRSt84sp8bb7w=
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr28576767pjw.129.1623000744412;
 Sun, 06 Jun 2021 10:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210605215215.171165-1-andrealmeid@collabora.com>
In-Reply-To: <20210605215215.171165-1-andrealmeid@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 6 Jun 2021 20:32:08 +0300
Message-ID: <CAHp75VcM_ikg26cs724rsTBz1Vc6HVcycQShWRtq_viFrX0AYw@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert UUID runtime test to KUnit
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 6, 2021 at 12:53 AM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> Remove custom functions for testing and use KUnit framework. Test cases
> and test data remains the same.

Can you provide the output in OK and non-OK runs before and after your patc=
h?

--=20
With Best Regards,
Andy Shevchenko
