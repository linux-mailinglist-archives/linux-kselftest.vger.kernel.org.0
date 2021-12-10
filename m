Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA2346FB2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 08:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhLJHT4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 02:19:56 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37868
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237181AbhLJHTz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 02:19:55 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61E043F1F2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639120580;
        bh=2764l/FzSwXeYJBJfnIJ7mPXfvJ4eSHSnEqn470ay2c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uy8m62a0yq0xcC8tCuc9cE394i/q4m/QkCJsnzo+BKL1Fz9Xngm41JbPTcaI8kyHj
         QV3mdT0uRmLRaxiE7wQvKrj04EbXfYFkU7qbeOvqjK/hDxlOGCzYW5T1hD6oiwh5N9
         BkEJhSJkwXpAeeiKAU7UmwjFmbLNl2v2IeI1jq7iK3T9ytTK5ty+2RKmYDWmggxGFI
         hsmf2/+zY7gZAk1wgY83bhF0V331K5cnFsDXM3fBylB0Ti4s9IHxSzUqRMNLywNxKQ
         5lgZzhQfl2NKnOSZIcrubHWtDxNO2RzW64Y0i+lpoAFUCUbK8OJCtfRgnXmFBTby9Q
         9oRz2D2NRbAFg==
Received: by mail-pl1-f199.google.com with SMTP id a4-20020a170902ecc400b00142562309c7so3691566plh.6
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 23:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2764l/FzSwXeYJBJfnIJ7mPXfvJ4eSHSnEqn470ay2c=;
        b=zegrZiAGuCBWW4t7iWLudrRb5m0Dls4MgQsd3DlY6ikx0YxbVA2ax6xwJQLCxSgMHJ
         Oq9P4CwNvhCeCUOyTSHogBkEU/MjOHZ+qbRLU48Z8i4iaenqaUCTNGt8OIXTT2CnhkLh
         e2l87V0R3jAU/YRgFyaYKkmkmm8Zj5/nH4DtLNwedQlkJELEjiIbKFfhkbblpvfnuKfN
         TQChvPYnDbUUWPRbZyK39dIg6/dfJbs42AbmzinvcVnUC0w3O1Wb4yKYzHl1/OvyFEzo
         dyCeZoCuqyPXQCNXl3bZ19T74y83YsaCpvoN95dLJPRTN5ZCKrmDlrTpxoPpP6je9Ymf
         EGag==
X-Gm-Message-State: AOAM533GxozhHgifNdrv3SEdeuBogw2wBffNjqtTNhSNUtaS3cFGCqSb
        GjcowV2qPlvciQGQrRQ+9BfMywuyToaGJzUG4z4usZ1dC6WB6H54GNc+IQxzrpE+a9lVr6z9avV
        f7xXVprZSnSGvQJ8e6Smrguz2MQImN4jJkMeK48RO8+tktIBwtDiZlj9m3uY4
X-Received: by 2002:a65:5ac7:: with SMTP id d7mr38292557pgt.590.1639120579063;
        Thu, 09 Dec 2021 23:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+s7PFvxrHr53QhbelxbodbgXrBhlzOozGF4llEt9d+qmmZIomlREAXFfGFzaw5ezGmkpkoM79krzcgVfu/AA=
X-Received: by 2002:a65:5ac7:: with SMTP id d7mr38292532pgt.590.1639120578732;
 Thu, 09 Dec 2021 23:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20211208071151.63971-1-po-hsu.lin@canonical.com> <20211209184620.78d02085@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211209184620.78d02085@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Fri, 10 Dec 2021 15:16:06 +0800
Message-ID: <CAMy_GT-qqhgHFzW7wuzz__Ly3Eu4oEHx-RrA9KO-mhVqO2AokA@mail.gmail.com>
Subject: Re: [PATCH] selftests: icmp_redirect: pass xfail=0 to log_test() for
 non-xfail cases
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 10, 2021 at 10:46 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  8 Dec 2021 15:11:51 +0800 Po-Hsu Lin wrote:
> > If any sub-test in this icmp_redirect.sh is failing but not expected
> > to fail. The script will complain:
> >     ./icmp_redirect.sh: line 72: [: 1: unary operator expected
> >
> > This is because when the sub-test is not expected to fail, we won't
> > pass any value for the xfail local variable in log_test() and thus
> > it's empty. Fix this by passing 0 as the 4th variable to log_test()
> > for non-xfail cases.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Thanks, could you please add a fixes tag (even if the breakage is only
> present in linux-next) and CC David Ahern on v2?

Sure thing,
I will add fixes tag for this commit:
0a36a75c selftests: icmp_redirect: support expected failures

thanks for the feedback.
