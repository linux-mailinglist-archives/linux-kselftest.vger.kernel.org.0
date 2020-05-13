Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879481D1D95
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbgEMSfV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389702AbgEMSfU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 14:35:20 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADFEC061A0C
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:35:20 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id u190so156017ooa.10
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxsOrff83X5kH8Esl9D7x9/SN/VH294qlWJEccaifZI=;
        b=Ez4fJoO3Edus7e3zqupzFZZVABBKc423N4orJgH94JqAZoGmc1kiYyV5OO55x16kdJ
         mxaxM/XnXIMv7Obxy3W2mEUOwwdb0kTQ+i7xufl9JgRYwsYsuaEf/J0UgA9yORrQ/fYs
         CqFBSh0jz+aeYHTj84jRKcQnrlYm5h0NI1zHKq3n18m42mBoRGan+sPiKM4Xudvkv9ns
         hQbuLsHcq5PBCCnLZymgOrT2wXn/vjQVJYn7BjAn80/wqLBpsalG9X2acreV9l3Zl3wZ
         e7bUrYnw2bMV9LQ8ImtQBJWqVitfDSEV8pgWiYKpqEX7kItbPCCnCS8+1bBORvI/fFH1
         DlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxsOrff83X5kH8Esl9D7x9/SN/VH294qlWJEccaifZI=;
        b=bkuZA4y0hPJVGqlA9QneS/6gEi24X3AYNGOstm5w6XKOOwKZ6xQuXt6s4zgAoNGQV5
         011RZ01oArCtR68YLB4HtXBLP9fPmH6iINrlzQ3bgo0jYGgfezAraSV7x+/3ru3mtXJl
         3iR64USWtvJ7gHn4nVHC0lRsQwtM5HM7wkFXcBjJGcpOU+lvyFXYLv5/Nr574OKdeJyX
         0/LanbZS2lUPOzdl97w0Nn2XLFvO2/6pZTM9r0NxlBk8smA0aIaA0kHaSYhjx+xurLKy
         FCHMYWVVYZ9OxEm4dYR0vhcld+ifExB7NsLzxL8E3jsDe/CZ7MXcHoL9hP7gq3NjR3a8
         VpHA==
X-Gm-Message-State: AOAM530eyDwatEvZmmGeFUgKQvz49QQPZKVn2cWH55lWpDDCpD42pqXF
        DhAdf5DUDKYhaXQgt5rKP9KcRaqVoHvCnjms+1E=
X-Google-Smtp-Source: ABdhPJzguhtzJbhs/BPxasYtv7jX07zZBV7HYvWfgLpcx8ipjZLG9+hTct6DyvMynx2ek9gqjDYHGiGR9m+zDVQZpWg=
X-Received: by 2002:a4a:5147:: with SMTP id s68mr612654ooa.86.1589394919328;
 Wed, 13 May 2020 11:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200513175746.7294-1-vladbu@mellanox.com>
In-Reply-To: <20200513175746.7294-1-vladbu@mellanox.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 13 May 2020 11:35:08 -0700
Message-ID: <CAM_iQpX2nBc3ppmvxJPoECCfZY1v1bhiYC_7fjAbXKCqdA3nLg@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: fix flower parent qdisc
To:     Vlad Buslov <vladbu@mellanox.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 13, 2020 at 10:58 AM Vlad Buslov <vladbu@mellanox.com> wrote:
>
> Flower tests used to create ingress filter with specified parent qdisc
> "parent ffff:" but dump them on "ingress". With recent commit that fixed
> tcm_parent handling in dump those are not considered same parent anymore,
> which causes iproute2 tc to emit additional "parent ffff:" in first line of
> filter dump output. The change in output causes filter match in tests to
> fail.

My commit simply restores the old behavior prior to 4.15, so are you
saying these tests never work correctly on kernels <= 4.15? If so,
they must be fixed no matter of my commit, right?

Thanks.
