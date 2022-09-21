Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183A5BFB28
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiIUJkn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIUJkm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 05:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D97D1C5
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663753241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhUuJRx2gpuIfpjZ2+oW6pFTAAKEReUIPyoUMqiGOJU=;
        b=UegRa+toGY07CKW8hPGP7yyYKJZFuLLnMH07QEEAgQtHRiLr7Fml7BlNYC58X0lAk4GFZB
        DpNwNaUWVFvJiu5geGRRHxTkp2festxGRndftaTRaruUwczUrvPOZdgPhy5wPcsuK55vnS
        b3h/79wbQH3yX7L4IMLK4Um7+CaA4sw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-212-BBhtOCFXOwisQmieUhE1mg-1; Wed, 21 Sep 2022 05:40:40 -0400
X-MC-Unique: BBhtOCFXOwisQmieUhE1mg-1
Received: by mail-ed1-f69.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so3989302edd.11
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 02:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LhUuJRx2gpuIfpjZ2+oW6pFTAAKEReUIPyoUMqiGOJU=;
        b=mWbnoYZHm62iojQcMklCxIUPaqz1O2piorx7xlduSjfNoJK3c22TawBS9gDS5C03dq
         ssP6fVeYMWkn1zTUEEZHYRMnzaQ4/Mm15ndh4kuEnNqJoZ7Im5oBqWFiJOqEfE00+5jR
         nh+wCCCfM0//lLUi7JU1TP5HXRqZ6vXsnLhGD9EcLRek4yBQ86Ub2Z0utLOkNX79WlFl
         wJChvj7p9hhrm+33A3EKKm7gnWkuA2SxmODPlhOISw5fdJqfH3k2b4a5cfpe7eUX0BsC
         NDWHIehotstPp8e4IHTeUFMUa+AsbMWNzbVQypY2RqV+KPbObD75m9gOW6PGSYqz8kML
         BnTw==
X-Gm-Message-State: ACrzQf05DAhlcVtgo+J02TxMjuQ7Qy2fI2pjd2xJcWZkeGtIQBasdDuv
        IDQDGkxT+7leRMT5mf1ZEwsLwNqJT+mNAoh8o4LHCs2F17j8J1jQifFvCCvEGaboo4ynDwjc4Le
        7dLZBB2ZrcLo4Te4RVuFp88dpHBli
X-Received: by 2002:a17:906:328c:b0:780:7574:ced2 with SMTP id 12-20020a170906328c00b007807574ced2mr1001457ejw.634.1663753238397;
        Wed, 21 Sep 2022 02:40:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7iNkNZ8NEmA5Eef9rWoDRK8RoLdOhrzxoLCprjnhClTrEJcAvc5D5cN9ZzokYS37vb9rCXsg==
X-Received: by 2002:a17:906:328c:b0:780:7574:ced2 with SMTP id 12-20020a170906328c00b007807574ced2mr1001327ejw.634.1663753236035;
        Wed, 21 Sep 2022 02:40:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906538600b0077f324979absm1069305ejo.67.2022.09.21.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:40:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 574AD61C4E1; Wed, 21 Sep 2022 11:40:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        cake@lists.bufferbloat.net, linux-kselftest@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vinicius.gomes@intel.com,
        stephen@networkplumber.org, shuah@kernel.org, victor@mojatatu.com
Cc:     zhijianx.li@intel.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, shaozhengchao@huawei.com
Subject: Re: [PATCH net-next,v3 02/18] net/sched: use tc_qdisc_stats_dump()
 in qdisc
In-Reply-To: <20220921024118.386700-1-shaozhengchao@huawei.com>
References: <20220921024118.386700-1-shaozhengchao@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 21 Sep 2022 11:40:34 +0200
Message-ID: <87leqdvze5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Zhengchao Shao <shaozhengchao@huawei.com> writes:

> use tc_qdisc_stats_dump() in qdisc.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>

For sch_cake:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

