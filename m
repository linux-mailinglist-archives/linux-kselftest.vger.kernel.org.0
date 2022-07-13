Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051EF572F49
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiGMHfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 03:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiGMHfd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 03:35:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF28E2A37
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 00:35:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l42so5923874wms.5
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xmwj0FJYVe2kvuEZdnKAuQrT7WT3/va56wKqpdcIMJY=;
        b=a7gaUg5EluWT7WnHptZ2seera5VoKwFruQ0XKY5GVaUpD3uc5TobC6y/vhrhlsJcJe
         CaqQhyoNPicJ7WUBMySm3K3WBhpekblAYkVI/rN0Y8orL+V/dqhFR/Q+9gkoiWCi+Vri
         yIgBACyvkWQPKlLjW6pioJsA3GHOLXNlersW3JqWwzKzXKfKpq4D2do4l/XJ3JA+Y5bC
         ZgAC3Tv5xg/8gnLRoJzT8UFUEFH8KZkdcFQJ2curxcqG1Eh8y4LH8GneQ0gIFo+bG/nA
         fghADDe1RNtj5URAdxEnO3VE3N23V/CRAocbEXeaC5xDxBKxgkNsDfl5q1/BGdOC+epK
         u7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=xmwj0FJYVe2kvuEZdnKAuQrT7WT3/va56wKqpdcIMJY=;
        b=t+xuvdEj/XzXzZtniTy4ygkCQu3KwrwU+XyEEI/5AT5k/i7yXKphyJRG1xqhj/0IvY
         ApJcmrRSYjVFV9UDiez0qN3nEeL2O41VUTTPBu6GSLGrlyX/fwfM36bhwczZQBWeRVq0
         i+9S2HuzBtlhEX1N+JtARz/xHpkqBf4ywEMCrFvxPwgSSppXrPbHSFWdw0tTuXH9acDH
         3ha8+8A4Hv6ircxZATBfyDpV06Aqj8/lQw7ltAXv5X4zANEyrTVfSgP/K94q5VNecaNY
         UK+5/ub6eqk+ja6yQu0wUzZz2MTLG40A0QC/7SS+hiaAWQ2OEFZhMBA66lxVI+LPLuzr
         0e/A==
X-Gm-Message-State: AJIora/pp20chp5cBdUPIvgF3o8dr+aTB/xPE2Og3T82minCsO0zSbYw
        VG/8LcZEwYMap8vNWfSKzjjtkI2dY6j9QA==
X-Google-Smtp-Source: AGRyM1vOUFQJfiECXJgGPNnz/HUcmCbd1AYhuXSXdo5kT365pp315yFdFAmKBBMct78NUZDVbQ3WpQ==
X-Received: by 2002:a05:600c:1d1b:b0:3a2:ef8b:1478 with SMTP id l27-20020a05600c1d1b00b003a2ef8b1478mr6570305wms.103.1657697731038;
        Wed, 13 Jul 2022 00:35:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:d92e:476:25ee:30ed? ([2a01:e0a:b41:c160:d92e:476:25ee:30ed])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b003a2d87aea57sm69440wmq.10.2022.07.13.00.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:35:30 -0700 (PDT)
Message-ID: <ef0862aa-105c-9a0f-aeb9-ba66322d90ea@6wind.com>
Date:   Wed, 13 Jul 2022 09:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/2] selftests/net: test nexthop without gw
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <9fb5e3df069db50396799a250c4db761b1505dd3.camel@redhat.com>
 <20220712095545.10947-1-nicolas.dichtel@6wind.com>
 <20220712095545.10947-2-nicolas.dichtel@6wind.com>
 <Ys1JefI+co1IFda4@kroah.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <Ys1JefI+co1IFda4@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Le 12/07/2022 à 12:14, Greg KH a écrit :
> On Tue, Jul 12, 2022 at 11:55:45AM +0200, Nicolas Dichtel wrote:
>> This test implement the scenario described in the previous patch.
> 
> "previous patch" does not work well when things are committed to the
> kernel tree.  Please be descriptive.
Ok, no problem.
Note that patches order of a series is preserved, in network tree at least. And
because I don't have a sha1 right now, it seemed to me the best way to uniquely
identify a commit ;-)


Regards,
Nicolas
