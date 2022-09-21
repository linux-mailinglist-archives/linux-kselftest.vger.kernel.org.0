Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6BD5BFB2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIUJkw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIUJkv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 05:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB7915CE
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663753249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfl/st5m8Se6ltL60JY32xTNgdDLAMTh+1ursFMAnnc=;
        b=YWt3eM0woOQOdt6OfPJDgSvs+0dcEp6Sy9Xctak38BDL4pycpmN32Yc1h8ZV7PSg0qeWO6
        AtUo++zzORAVZAXcL393gsGlqgHJETaZ2MIdrbAtHd7X/OZweNiQ1+PerH43iSgkomjLT+
        BTzGxwnI0pXWfIh1l7dHvcgvvjK/ETo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-60-QPFa3kgHMIWMAW0uzfcCbQ-1; Wed, 21 Sep 2022 05:40:48 -0400
X-MC-Unique: QPFa3kgHMIWMAW0uzfcCbQ-1
Received: by mail-ed1-f70.google.com with SMTP id y1-20020a056402358100b00451b144e23eso3926283edc.18
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 02:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vfl/st5m8Se6ltL60JY32xTNgdDLAMTh+1ursFMAnnc=;
        b=zrzNS5u2itELCMjep6zRwXYkWZz1HF6upp07iKhMs5uXj8POASSchGvfTbnqvQvZfv
         80NQ36mVcOkfaoGhG0fF+KQhCEO4oPjV36Uc0liYBYxS+qc4f1vjqJKWddlYTUmH5lVB
         J7Q3+pCd+kqXyWgQoFHGuNuITV7YmBxRhJ101915BVs5SSedD5k1EkJ4aB43ykZ1yfuk
         PhoiPPMYzq2njcilCjXxmYCb4WNXK3/DIuWjtWGSqK3ffO+EZQYigFS+6C/Jwv9yJz3j
         QjBIzfFXyBOVlbUwz0c/S/6ovEvZfSHIihQMWghTddIR24reBomCX25b3ZdSiuHqsle+
         oi7g==
X-Gm-Message-State: ACrzQf3WHumP1g1JRcl8cJF/lG/4iZx4rvVMnUvW8j+VWqP80tKCZtjB
        GOr4ww0i7nhFgIoGkQSfJniCWtbFm4PEMNKe/CJdrfzb9BJjRlJw03D5ConXSuJL1BvXjx4aIF6
        496NYv2V7pJ+IGVfNMKFD164caPPA
X-Received: by 2002:a17:907:94ca:b0:77b:542a:4cc4 with SMTP id dn10-20020a17090794ca00b0077b542a4cc4mr19302858ejc.257.1663753247300;
        Wed, 21 Sep 2022 02:40:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4hDKaFsXcDpGvBW7qsS7g0afcmMVDNPrIWCK+FY0bzS4JRPiUwSLUK8z2QrUwdSGY7qf4/BA==
X-Received: by 2002:a17:907:94ca:b0:77b:542a:4cc4 with SMTP id dn10-20020a17090794ca00b0077b542a4cc4mr19302826ejc.257.1663753247016;
        Wed, 21 Sep 2022 02:40:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gj22-20020a170906e11600b0073dd1ac2fc8sm1016556ejb.195.2022.09.21.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:40:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D17D861C4E3; Wed, 21 Sep 2022 11:40:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        cake@lists.bufferbloat.net, linux-kselftest@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vinicius.gomes@intel.com,
        stephen@networkplumber.org, shuah@kernel.org, victor@mojatatu.com
Cc:     zhijianx.li@intel.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, shaozhengchao@huawei.com
Subject: Re: [PATCH net-next,v3 01/18] net/sched: sch_api: add helper for tc
 qdisc walker stats dump
In-Reply-To: <20220921024104.386242-1-shaozhengchao@huawei.com>
References: <20220921024104.386242-1-shaozhengchao@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 21 Sep 2022 11:40:45 +0200
Message-ID: <87illhvzdu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Zhengchao Shao <shaozhengchao@huawei.com> writes:

> The walk implementation of most qdisc class modules is basically the
> same. That is, the values of count and skip are checked first. If
> count is greater than or equal to skip, the registered fn function is
> executed. Otherwise, increase the value of count. So we can reconstruct
> them.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

