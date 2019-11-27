Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA43110AFC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfK0MqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 07:46:14 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:46975 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfK0MqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 07:46:13 -0500
Received: by mail-qv1-f51.google.com with SMTP id w11so8780480qvu.13
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2019 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh/vBERm/TbGM+yKl5SoCFkCcaIxa+50MOn7rbgBP8Q=;
        b=gkyvth1/Mbl64/TJUNIuUxJnbtlh5omWv1qlqK95S5J7cYBXdi05gUzZBljO3jOOcb
         HqEHMrZG/RmkV85nz7Yx4rZl1Jt53AtzzPaneyjPwSRKTJU2syvy170bWmvbWkzdQVWa
         DYiB77Gxhziqu90y/UTPGDggPTj7u5l6r1SZCSDOJSLMWldtA1LMX2yCGoFzxPvFGpGL
         Iu6kTOYu347m34fMmuuKuQ6KFlXEgX1LSHGIa72Ko70Ewh0IcOplDsh2WzzpLwL392gd
         oO7rEwZ6sun1jv2g5Qh1UzzGd+OFJydJmNRGMk+8O3HFB1dzUg2MRi34BWcKZiM1dNId
         YYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh/vBERm/TbGM+yKl5SoCFkCcaIxa+50MOn7rbgBP8Q=;
        b=uRYT3ry0ftoQW4L/oe/hD2+y7JSFdjwztTGfjOldAijjiNczHH1lCa0Oql5Y85uyW/
         O+qTyE9jWOniYKGWGxUc/EKeHSuvNjrkTzBwtnX0MH8uyD3nGtLnmGrSgalREEEcEn7K
         b1GtvkGyimRCIPRmZ1Vvip6eWYfYSQlBb0Y9gKMlHmY6VEPvORmwsOdL1T5Gde6ZxM7f
         IDJ+RELxbc1rHwqlycO5ulkcCAlapFBtoIMLC/DuMXcFFK4FBVP5DqV7uNFZvBk0nmnd
         FPYlrr7s/NMwmuKtRkKeo4qt+03MMBfcdYf8hqeiy2o4T9UC22SKf4VDaeOT8yUI0ufV
         ubmQ==
X-Gm-Message-State: APjAAAWfwKPDsFj/SxWuM7HgQhDdzDu7G/9nZfei4Q3KKU8ihWZCfeSU
        pLpcR8JUrw+aXSfg/Qo+CgUedc+AWMMZamFxLr4Eqw==
X-Google-Smtp-Source: APXvYqzYfa89PkENwWgrr+lbnyQptNxwjQ2eMJwZTVJ9xXPkWzFPnmQzwgOahRvkhhc1AO6G3I1PdkrXLAcRysHEqrU=
X-Received: by 2002:a0c:9bd1:: with SMTP id g17mr4504471qvf.59.1574858770657;
 Wed, 27 Nov 2019 04:46:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtgEfa=bq5C8yZeF6P563Gw3Fbs+-h_oy1e4G_1G0jrgw@mail.gmail.com>
 <20191126155632.GF795@breakpoint.cc> <20191127001931.GA3717@debian>
In-Reply-To: <20191127001931.GA3717@debian>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 27 Nov 2019 18:15:34 +0530
Message-ID: <CAG=yYwnm4vRLRpjT2VOj5fynPhBfhvpVjfbSOvPrs-bwv09mTA@mail.gmail.com>
Subject: Re: selftests:netfilter: nft_nat.sh: internal00-0 Error Could not
 open file \"-\" No such file or directory
To:     Florian Westphal <fw@strlen.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>, horms@verge.net.au,
        yanhaishuang@cmss.chinamobile.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 5:49 AM Jeffrin Jose
<jeffrin@rajagiritech.edu.in> wrote:
> Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
i do


-- 
software engineer
rajagiri school of engineering and technology
