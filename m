Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705BF5BE775
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiITNpg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 09:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiITNpf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 09:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03409100C
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663681530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxHKjrVMawJTVmFBN2tlPLoDEtk3zoTr+D6pCmrZ1R0=;
        b=C/pB3WVUa2Sb68lSmi17VZ3I+PSIjkS10fwFqZJrU307MTmuB7QTuMnB+81iT0d/QDuoQg
        sD9PEZaqleS+eEZ2su7iyVTGJ11y48uiNP6YsJtl4XOFE12vGUyTzyGzjrr1FvCuUHc85Z
        k3gtrez1ozRZn1LQ2znV7ZUkVPafwCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-QYzZe-YePE-c-YmWAEBzPQ-1; Tue, 20 Sep 2022 09:45:29 -0400
X-MC-Unique: QYzZe-YePE-c-YmWAEBzPQ-1
Received: by mail-ej1-f72.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso1416673ejb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 06:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=DxHKjrVMawJTVmFBN2tlPLoDEtk3zoTr+D6pCmrZ1R0=;
        b=VOlMqEACLRC+9uTvH/zP7mZ5HIEx/IakbCQrLqJ0CVQ8yOEGhKa13ALEj2GElUJRyN
         UD1PJbgJf16YyavjlmiL/JtAsZoictqmnMrJPWEQSWC+iJfwNWvKGFQj/NgZIn+Pjeht
         b8rc2ipsEVlf6U3S0S14bQhjkzEF7ESl5D4GvWx6n3WHRQK7llILN05mCgjeUDFU1DuV
         PBECaBxvkHazAnjoOMQQxqDyaulPL94vdcExniOFfnLcspdG2XMjBEHycFHBToPIL6IX
         yli3cpNlkj8EeZDnnZWWHhy/9+uvkW8naDlvUspyqEIWWARy1PVuH74ehsR1vFoYxxqb
         ujdA==
X-Gm-Message-State: ACrzQf03sc/4NcEsB0vf7xMO6emjT7DZQTT1377qbsDuQ/YJoTQFUke7
        CvlA7oMZ4nSwe2UqgfRyQLu4x3bp0Qvr9dosn6EtQL6kHfzBckd9fe2cgXpkB/QpdADmLxcmJvI
        8fZV2Gm/dP3aHg+HbjSq24TVXCAJd
X-Received: by 2002:a17:906:ef8c:b0:77c:8d9a:9aed with SMTP id ze12-20020a170906ef8c00b0077c8d9a9aedmr17889347ejb.704.1663681527174;
        Tue, 20 Sep 2022 06:45:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7E33JWAP3AhjFxcYXywbXSv1ZvnnxSk+uY3JXkypwF5KGToMYJwipqmJ/n7IuetlIHtn+W/Q==
X-Received: by 2002:a17:906:ef8c:b0:77c:8d9a:9aed with SMTP id ze12-20020a170906ef8c00b0077c8d9a9aedmr17889281ejb.704.1663681526444;
        Tue, 20 Sep 2022 06:45:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906c18d00b0078015cebd8csm905122ejz.117.2022.09.20.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 06:45:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4842D61C33C; Tue, 20 Sep 2022 15:45:25 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        cake@lists.bufferbloat.net, linux-kselftest@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vinicius.gomes@intel.com,
        stephen@networkplumber.org, shuah@kernel.org, victor@mojatatu.com
Cc:     zhijianx.li@intel.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, shaozhengchao@huawei.com
Subject: Re: [PATCH net-next,v2 01/18] net/sched: sch_api: add helper for tc
 qdisc walker stats dump
In-Reply-To: <20220917050217.127342-1-shaozhengchao@huawei.com>
References: <20220917050217.127342-1-shaozhengchao@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Sep 2022 15:45:25 +0200
Message-ID: <87sfkmw45m.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> ---
>  include/net/pkt_sched.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 29f65632ebc5..243e8b0cb7ea 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -222,4 +222,17 @@ static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
>  	return cb;
>  }
>  
> +static inline bool tc_qdisc_stats_dump(struct Qdisc *sch,
> +				       struct qdisc_walker *arg,
> +				       unsigned long cl)
> +{
> +	if (arg->count >= arg->skip && arg->fn(sch, cl, arg) < 0) {

Seems a bit confusing that tc_qdisc_stats_dump() reverses the order of
the 'cl' and 'arg' parameters relative to the callback?

-Toke

