Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA511786CD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjHXKcQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjHXKb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 06:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F389F199A
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692873069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gpjf/YZm7tfcPZCca7L2sv1Wv8PZiaW/olle5+rMMQE=;
        b=XpVr2hWyoohuQc1Na3o9jd+9hf9exdi7gnvrubFyokNzLN3hYCKYmA1gUvzzFYtmmoHqoJ
        7BwVQBTGdhPrYIpxGCtDKhhdSp7I3W3Y5s4m0mI787wpKZcMyDE0nD+XTfo/dmNQdyVihr
        WMdTbaXi+H8URT/E9oln5G7w9fNt67c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-SBVV5UePMwu3mVlOXpMN0g-1; Thu, 24 Aug 2023 06:31:07 -0400
X-MC-Unique: SBVV5UePMwu3mVlOXpMN0g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe246ec511so13234405e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 03:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873067; x=1693477867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gpjf/YZm7tfcPZCca7L2sv1Wv8PZiaW/olle5+rMMQE=;
        b=NY/h7WHomKUfr6l018MMR2tGFtGzZ9D/IldK6dJeLAvyyFjZ/VMKfZ3zbtZD6HAvf7
         r6k9A7+6Lk4eNBHmg+eRT/89d5HLhpSbWqAnbwuO18EAc9Q9iylFdd2ZjEw/r5dBwh/4
         unx9pkozR8eAwMKN4lcj6cPUuwYytlOTXDqeKax1ejoWStPzxsFKUJDR9JsihgU9ndYD
         nXU3JDlwGfI45+X83KMOPrc4vUT2gvcmll+mQ2uQBv6AQEDfMlok1w6+qjyKP8jDkguV
         h/WNcJR1OS3qAMXWhHY5ScuGO966FUBuGQXaGhcmX0La3zgMP05ygQhMNNHwYvTzz1iI
         G8Zg==
X-Gm-Message-State: AOJu0YyAiCbvZSlFnNv+UcWnCyrrBU69VKIFEGYLKtGFLMToG0oqPDxr
        CraGmwRF35eSWR4APnm216ppK3dSFQpWhAlABEetcc59tC36GnqjsPAr05TCc7fC36NQd2YGYjQ
        RJ0oI7puRRoxOyuw9iSxog4sp/pzx
X-Received: by 2002:a05:600c:5185:b0:3fe:d46a:ef4b with SMTP id fa5-20020a05600c518500b003fed46aef4bmr11818119wmb.1.1692873066833;
        Thu, 24 Aug 2023 03:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZtwK14eR28M+W3iJ2f6nXo7erBL0kYURufI72Y2JY32Cs5kl5Iq/OMSPYFBH31/x9KQNrUw==
X-Received: by 2002:a05:600c:5185:b0:3fe:d46a:ef4b with SMTP id fa5-20020a05600c518500b003fed46aef4bmr11818104wmb.1.1692873066484;
        Thu, 24 Aug 2023 03:31:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003fed78b03b4sm2233452wmi.20.2023.08.24.03.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:31:06 -0700 (PDT)
Message-ID: <c25141405ba52eb0eee96317407376ef68802198.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests: bonding: delete link1_1 in the
 cleanup path
From:   Paolo Abeni <pabeni@redhat.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Date:   Thu, 24 Aug 2023 12:31:04 +0200
In-Reply-To: <20230823032640.3609934-1-shaozhengchao@huawei.com>
References: <20230823032640.3609934-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-08-23 at 11:26 +0800, Zhengchao Shao wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So delete link1_1 in the cleanup path and
> drop any warning message.

I think the same could happen also for the link1_2 device.

It would probably be safer creating directly the devices in the target
namespaces, with the 'final' name

ip link add dev eth0 netns client type veth peer name eth0 netns server

Cheers,

Paolo

