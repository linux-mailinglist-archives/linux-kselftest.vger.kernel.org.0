Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0205BC0E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 03:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiISBFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Sep 2022 21:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISBFm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Sep 2022 21:05:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFEC13EB2
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Sep 2022 18:05:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x23-20020a056830409700b00655c6dace73so16551744ott.11
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Sep 2022 18:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7Nln9o8+KgWXh20eCVhrCs8ZRIFITlFWDCJFyQHKKl4=;
        b=HZ5JQstOdyCuVV963ZooQpoyIaPxFimUQrEC+R/gZH/lIHi1rSMy4XixtpzdjH8IVN
         IVkMMP2OO0H5Buf8+jWiOlDZuJ9yy/8qCB66kindOVf71hZ6Yo8R9QQYGY1iQm+ZGU81
         FqHdC+XWokAbMRaxDHY2l1b6vmGUV+dDxIeFYHKTRqj75hJKEeomm66Vy7FW3eM/p9Ff
         wtJFjVqIbQLRnJrBdqirW73gj7lV4wzfrScnVjxYnhiLqduhq0zYWVH2pTJ12lkpcweD
         qK/IWwvrYrL9gfVbcXH/IhdeQEtoIqODDuMh0QVqBjzHT7gpyDBoB4P/HvOalDqRlLC7
         1n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7Nln9o8+KgWXh20eCVhrCs8ZRIFITlFWDCJFyQHKKl4=;
        b=FH1g9yCi21H9ZbDLNwLYPpHpCmDd8V/SvcR9I+Uw/rVAwjfkGvTQ/RO1uYeWX/pGD0
         4Kupjw3zfM4cfdnsVyE/Sd0LiiflnQIwue8Tt2vF5IsILDnxkC3ltuuI220shKwoYzWY
         QC4breYPtSZ7pl2OQg725yfrnwvbOiuZlmWaCUQT5e6EKkDgoimGvXAs4haKtiLLt5yp
         M6xUN35T1l7lINFIkqub5gLJzLK+Jt6yu+RMUyucECwLBn3aSBVsZFYrYZC9RLwoyvca
         uDXx8H6pDNwR8vbxgni10g//dYdIz4a55jNv5uYsBBAGLcIaLngd/CBr1R2O1onJ6JNa
         jouQ==
X-Gm-Message-State: ACrzQf3skrKkmTctp6t1UfQJR/xLiFtCi5uWODkfLXnsWBTce5h3hxu1
        3i4V0eQhgj6QW4kZmFGn6XbX5YZof0jsJk0QuxvoOA==
X-Google-Smtp-Source: AMsMyM6OazjHldIhOvSyzPAGt9W76ixoFWTADxVnkP4jasV5XE9fsHajWSzioFh5T2jypjokFzRcCm/zA1Bu6QNAlv8=
X-Received: by 2002:a9d:1b70:0:b0:658:cfeb:d221 with SMTP id
 l103-20020a9d1b70000000b00658cfebd221mr6955321otl.34.1663549540604; Sun, 18
 Sep 2022 18:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220916020251.190097-1-shaozhengchao@huawei.com> <f0fa2b91-cebf-0997-1074-d1ba35bf77a9@mojatatu.com>
In-Reply-To: <f0fa2b91-cebf-0997-1074-d1ba35bf77a9@mojatatu.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Sun, 18 Sep 2022 21:05:29 -0400
Message-ID: <CAM0EoMmcjfjg+7RsMtW_4YWb+4ewACGW=YVtzOU0Xqh=Kk_K-g@mail.gmail.com>
Subject: Re: [PATCH net-next,v4 0/9] refactor duplicate codes in the tc cls
 walk function
To:     Victor Nogueira <victor@mojatatu.com>
Cc:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 16, 2022 at 12:56 PM Victor Nogueira <victor@mojatatu.com> wrote:
>
>
> On 15/09/2022 23:02, Zhengchao Shao wrote:
> > The walk implementation of most tc cls modules is basically the same.
> > That is, the values of count and skip are checked first. If count is
> > greater than or equal to skip, the registered fn function is executed.
> > Otherwise, increase the value of count. So the code can be refactored.
> > Then use helper function to replace the code of each cls module in
> > alphabetical order.
> >
> > The walk function is invoked during dump. Therefore, test cases related
> >   to the tdc filter need to be added.
> >
> > Last, thanks to Jamal, Victor and Wang for their review.
> >
> > Add test cases locally and perform the test. The test results are listed
> > below:
> >

>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>

For the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
