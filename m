Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BDD4A78DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 20:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiBBTqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiBBTqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 14:46:13 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F61FC061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 11:46:13 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id h7so437519iof.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vt3isMlW6ttVsQJABAGNqW4La/pKobL1/1SkIM0CXj0=;
        b=Ykc6xHweurUlhClVjJyQxJk2LPsS8tPboKepabrQrVLOUfbbzq0Mr2M9pL1hGItwZ5
         Qo2GlCFkWxgFHu4GjXdPflw78dmkLSxaRx+naBgyNQAoB19IQnKK4y7FfI0/1HcMIp3k
         3dkmaiIzYxj9Dkb/RL5xmSOctULBwUK59BgWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vt3isMlW6ttVsQJABAGNqW4La/pKobL1/1SkIM0CXj0=;
        b=K7MymkLS84lyDOVQ3N6dV1s1YxPCFKhl/F4C8pjWO22daNGdQc91amS86niAe4WHnO
         XXzKJImKGQVKJkrRBJqHzSSXJv3b++yqyYhlLXBmpu9bINzxUcdueRprcS/TyqI6p0iX
         EaO1qUx1C4spa1Mn0VQU6p0jSftAXNfYk3mDfWIdzltbtdDr1400bl12Uf7lSpdNRlT6
         /MmCxTqknMEY2z8eItuGssCBQHsXZvwg/hiEODOsMqKh0xthY04rm2xoqvVLBPf570xA
         9y3RZx8/+bS9kUjMncS0k1e18DjOqih/3sG5l6CEE5/sU/ALl4bEswAP+zVva0UaXOWz
         5uNQ==
X-Gm-Message-State: AOAM532mRpDaejsEfN1+bMbDIbYKFSlqyHjEm1n7CuyAECZFmy3XwTPB
        wpV0NSZnXL04mdPIwKeWIO7X3w==
X-Google-Smtp-Source: ABdhPJzutUWweN2ZQe0jdrQWkLNljYhOx57TKumMkNAsoHbsw/Dli7kW/F7RJwKzi8yIyt16bzl59A==
X-Received: by 2002:a6b:3b8a:: with SMTP id i132mr17522487ioa.85.1643831172924;
        Wed, 02 Feb 2022 11:46:12 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k2sm9305443iow.7.2022.02.02.11.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 11:46:12 -0800 (PST)
Subject: Re: [PATCH net-next] selftests: fib offload: use sensible tos values
To:     Guillaume Nault <gnault@redhat.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <5e43b343720360a1c0e4f5947d9e917b26f30fbf.1643826556.git.gnault@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <54a7071e-71ad-0c7d-ccc4-0f85dbe1e077@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 12:46:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5e43b343720360a1c0e4f5947d9e917b26f30fbf.1643826556.git.gnault@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/2/22 11:30 AM, Guillaume Nault wrote:
> Although both iproute2 and the kernel accept 1 and 2 as tos values for
> new routes, those are invalid. These values only set ECN bits, which
> are ignored during IPv4 fib lookups. Therefore, no packet can actually
> match such routes. This selftest therefore only succeeds because it
> doesn't verify that the new routes do actually work in practice (it
> just checks if the routes are offloaded or not).
> 
> It makes more sense to use tos values that don't conflict with ECN.
> This way, the selftest won't be affected if we later decide to warn or
> even reject invalid tos configurations for new routes.

Wouldn't it make sense to leave these invalid values in the test though.
Removing these makes this test out of sync withe kernel.

thanks,
-- Shuah
