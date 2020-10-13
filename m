Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9508928C749
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 04:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgJMCsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 22:48:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37279 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgJMCsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 22:48:15 -0400
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kSAMG-0007wS-H2
        for linux-kselftest@vger.kernel.org; Tue, 13 Oct 2020 02:48:12 +0000
Received: by mail-lj1-f200.google.com with SMTP id g15so1185436ljj.12
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 19:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9YMzKKemL4yEtTpZq3swTQnWFUcuccAdAOgQPyZkCE=;
        b=EhDN34wEjTjCSmhNi9AU/9JFTIcWHJt/XcipuZkCH490brX39RHXgPMAR/Ikl15v6x
         w860BbAvBA0fuSTDVTRVDz5CIhsthLO1D4hF59uVjE94eNYYS+1rycc58VzzfGUHwUC/
         AxKu1koJ3z+HvydENIe9yvsLQ5CZf2MnyJSMSGIV07Q+JiW1E8ky0tOBDgnJzvb65VJP
         yB6h5IvhJ+aV0HGdxCFpe/RrOuW3OHJEOzqacOtEOxJTmBh9cbtEoPbGiEwdL7Bex+5Q
         1biLG8e1SSWsEIGhBWBWKla56H27aSDDVVEyqwPiNJFvzzvWmYXWfedapZXiQyAYrJZH
         TAsg==
X-Gm-Message-State: AOAM532diuYmktXzg7C2It8qFzzc8FTAhKnEzJmFFgfObWQ15ledwV17
        VQm7qW6sX06ZjLPsOUzkn/kKTtSgl89W+rRJ1WguEm2rfa6twt6TTlzA47JrMnUbH4yUa7WiM9K
        5vwNhalNckW/FQ+J3y8eHNaI/EFh6Do4D/nLtuhbbCeXMID8ogflCtJ3e5O5x
X-Received: by 2002:a2e:b610:: with SMTP id r16mr2368432ljn.145.1602557291846;
        Mon, 12 Oct 2020 19:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrY7bJ1GyblOrZbBZ/9DUes654EWYmtWMOXL+aPPrxh6huWVRZ0454gyfaETS768LcE/4Wi7MmDRY5X70GNrk=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr2368423ljn.145.1602557291594;
 Mon, 12 Oct 2020 19:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200907035010.9154-1-po-hsu.lin@canonical.com>
 <20200907131217.61643ada@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMy_GT-kaqkcdR+0q5eKoW3CJn7dZSCfr+UxRf6e5iRzZMiKTA@mail.gmail.com>
 <CAMy_GT-0ad7dnWZ=sVt7kZQSMeKQ-9AXdxTe+LqD4uuFnVd+Vw@mail.gmail.com>
 <CAMy_GT9hALtE9-qBU95QCR7=VN8hwRps4U=hDjsWeKzssnMbKg@mail.gmail.com> <20201012082819.1c51b4cf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201012082819.1c51b4cf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 13 Oct 2020 10:48:01 +0800
Message-ID: <CAMy_GT-_7oh_fwsN4-9VMdf=cSBNL0jwE9AWa9-Dr09x_zam1A@mail.gmail.com>
Subject: Re: [PATCHv3] selftests: rtnetlink: load fou module for
 kci_test_encap_fou() test
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 12, 2020 at 11:28 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 12 Oct 2020 13:56:15 +0800 Po-Hsu Lin wrote:
> > Is there any update on this patch?
>
> You received feedback. Don't remove modules after tests, something else
> could be using them.

Hello Jakub,
I have my feedback regarding your input [1], so I guess it's not
persuasive enough?
Thanks

[1] https://marc.info/?l=linux-kernel&m=159954826414645&w=2
