Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0082B26AA8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 19:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgIOR13 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgIOR1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B7C061222
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Sep 2020 10:25:22 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so4977872ioe.5
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Sep 2020 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+B6SfTmbRLE/LfIRwMpjpXfXUi1jL1qvGc+N8ykkERI=;
        b=Ok9Da4Vf/W1wPTsr/vAXSayisJPsO041Aeg3Igtr8glIIqRJt13m1NF6tPwRYNSyaZ
         iiTvf20x/9ZAQtB1M1kujLkF7tqDVbkoDwsZTekDgSXBaDzhW1p2eKHRqCoKdwL2d/7s
         XzWHl8zJsur5ohdCESQBYpqRdfc+2wwomEbfXvGyIszSa4B45soiTt9SFJgPRi0Q76ED
         qfAS2TSpEK2sGKvFtM4j6+i3SaAVyBEIN1hXmzFLRQj7Lv1LCcRtDjKnYd3fnDnIRMhS
         2SZeVMIiISGpuIhWMk3kt/5kprWN4GOxoIy3KXmQ6jYumkll88xi/x6NYBVocXk+CfXN
         cEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+B6SfTmbRLE/LfIRwMpjpXfXUi1jL1qvGc+N8ykkERI=;
        b=g1pPnAuhe7T5YVaACPKCNZD4RkkxcznD4y1IMI1RBA920Nr3TApFw2dAVSXFXS0q/7
         J8snPrg+io71g7g/CVrGW8B5HbgLEKSooj2AC2HapEwhTkYjA7JbEmpq1QIkrYepA6BJ
         vhLfbYDKH/dPyBlF+RMYXOdIWlr8wK2iwDXy4DdOW8I1c/ZZm8ry0lFbPtIfqGEqyD8l
         aa+uOyvkivzaWf1jRCrbcejyZXzKIVlt55MgfiRM1gIS45WJTlmrWSkX2mECvZcVRwKg
         6+OoJHImxzMkl32VQQJBQsfNF42IvO/P9dKOBRFyk16A5cIMAf6xQvrs3cB1x9xSUZcw
         X+CQ==
X-Gm-Message-State: AOAM531Vq8FKpOFWu4GVnDGlgfFNclB3P11vPCaf+PPAVeZdDnTTlgT4
        auKHT5pq7dOsVoa+zoWMUrQGfg==
X-Google-Smtp-Source: ABdhPJymvc5riRPwnED++gXip8Ks7OVyQSEGj+RzOI/P4r0s4LZBjXreZCcZFsoRDRY5VijDMlIrMw==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr15724555iod.82.1600190721636;
        Tue, 15 Sep 2020 10:25:21 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t10sm8071240iog.49.2020.09.15.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:25:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIEhj-006WFS-Fg; Tue, 15 Sep 2020 14:25:19 -0300
Date:   Tue, 15 Sep 2020 14:25:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/vm: fix incorrect gcc invocation in some
 cases
Message-ID: <20200915172519.GL1221970@ziepe.ca>
References: <20200915012901.1655280-1-jhubbard@nvidia.com>
 <20200915012901.1655280-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915012901.1655280-3-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 14, 2020 at 06:29:01PM -0700, John Hubbard wrote:
> Avoid accidental wrong builds, due to built-in rules working just a
> little bit too well--but not quite as well as required for our situation
> here.
> 
> In other words, "make userfaultfd" (for example) is supposed to fail to
> build at all, because this Makefile only supports either "make" (all),
> or "make /full/path". However,  the built-in rules, if not suppressed,
> will pick up CFLAGS and the initial LDLIBS (but not the target-specific
> LDLIBS, because those are only set for the full path target!). This
> causes it to get pretty far into building things despite using incorrect
> values such as an *occasionally* incomplete LDLIBS value.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/vm/Makefile | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

I hit this too when fiddling with the hmm tests! Would be happy to see
better errors

Jason
