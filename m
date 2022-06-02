Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95E53B727
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 12:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiFBKaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 06:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiFBKaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 06:30:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC96522CA
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Jun 2022 03:30:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id rq11so9104248ejc.4
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jun 2022 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iabOKt8Lt4ClyBb4r4Q/KqHn7Cps1qrTWhdLROC0vws=;
        b=VQCl9uRJ1U9yzv+giXqEkz6Z1yMCqEp3hD2gW4Jaw5s1Ewt13S9ZakS15xCYWgi3dv
         xayD1UAWLjkxDApMnNgrFpkP1w09bQiGAG1jDOT96JEC8CsV4tlBXUJHtyiCTPMsiDZx
         Ayt7KUdq8NRJLYDz2WlL2v8d2xGg5Kc1SDjshNLy/xPvE3M4zaxkKtVQdbvoCpaT8Fwp
         zD8In4NBTo53lm8LB1BxmK9EXteWssgCifKEmDLsDDB4VC2y7OtAmcxx/TCoq8dQR+2r
         9Ma6Txx/6cNyejFL24zKary5+Wajx7zFRWu44J5LchvKYmsCy0hhGgqcVVhxQ0Qdw/dh
         EJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iabOKt8Lt4ClyBb4r4Q/KqHn7Cps1qrTWhdLROC0vws=;
        b=ty36d9juAjpU2vjJZbg1DOLmwcqHbAqqjgNmnxxWqgS2mbQsDg+gi/uaDGHtuSkjIG
         Gh0ztm0zaw2BbNDYp0rjUl7m7iIPdcu/vDcbT+Z1Gwfcu4dDMszZhePH/hoZIbNtRWVy
         Svf1C1U/Yw9DuLoDk4izm0TczHBat4+QI/Vh3W/UsoKj7+U7bjb7NGBL0UOSMMRgjmPR
         +lfS2s/j9bbf9aA93X9UhrJ5wTKw90ScYwdGwRxK3olgXRBSzp6VD4U9XIzTBeLH9TDu
         tT10hgxaviGreFj8NuOKvTvfxsDbgl4N4cGUR/DIJcB2Jc6YanEQywKnDGDVAaK1ZJoM
         CTCQ==
X-Gm-Message-State: AOAM533w7BrDtvU87eEMIl7dImWBb/OiG4R30HDxbZvreSkUtj+m5RHz
        GjIvlXi2v3jFKDDEXIfStaNSZA==
X-Google-Smtp-Source: ABdhPJy5pwOku+BM+CDHZx5dxzOvjqNeMSrLQbz9dkgce9cywc4H7D1hWfs/mduin6qoqUr7KiN1hQ==
X-Received: by 2002:a17:907:3e07:b0:6fe:fdf9:2c2e with SMTP id hp7-20020a1709073e0700b006fefdf92c2emr3609612ejc.378.1654165808343;
        Thu, 02 Jun 2022 03:30:08 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id oy9-20020a170907104900b006fe99b66198sm133279ejb.60.2022.06.02.03.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 03:30:07 -0700 (PDT)
Message-ID: <3d93d46d-c484-da0a-c12c-80e83eba31c9@blackwall.org>
Date:   Thu, 2 Jun 2022 13:30:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 net-next 1/4] net: bridge: add fdb flag to extent
 locked port feature
Content-Language: en-US
To:     Hans Schultz <schultz.hans@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>
Cc:     Ido Schimmel <idosch@idosch.org>, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder> <86sfov2w8k.fsf@gmail.com>
 <YpCgxtJf9Qe7fTFd@shredder> <86sfoqgi5e.fsf@gmail.com>
 <YpYk4EIeH6sdRl+1@shredder> <86y1yfzap3.fsf@gmail.com>
 <d88b6090-2ac8-0664-0e38-bb2860be7f6e@blackwall.org>
 <86sfonjroi.fsf@gmail.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <86sfonjroi.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/06/2022 13:17, Hans Schultz wrote:
> On tor, jun 02, 2022 at 12:33, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> On 02/06/2022 12:17, Hans Schultz wrote:
>>> On tis, maj 31, 2022 at 17:23, Ido Schimmel <idosch@nvidia.com> wrote:
>>>> On Tue, May 31, 2022 at 11:34:21AM +0200, Hans Schultz wrote:
> 
>>> Another issue is that
>>> bridge fdb add MAC dev DEV master static
>>> seems to add the entry with the SELF flag set, which I don't think is
>>> what we would want it to do or?
>>
>> I don't see such thing (hacked iproute2 to print the flags before cmd):
>> $ bridge fdb add 00:11:22:33:44:55 dev vnet110 master static
>> flags 0x4
>>
>> 0x4 = NTF_MASTER only
>>
> 
> I also get 0x4 from iproute2, but I still get SELF entries when I look
> with:
> bridge fdb show dev DEV
> 

after the above add:
$ bridge fdb show dev vnet110 | grep 00:11
00:11:22:33:44:55 master virbr0 static

>>> Also the replace command is not really supported properly as it is. I
>>> have made a fix for that which looks something like this:
>>>
>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>> index 6cbb27e3b976..f43aa204f375 100644
>>> --- a/net/bridge/br_fdb.c
>>> +++ b/net/bridge/br_fdb.c
>>> @@ -917,6 +917,9 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>>>                 if (flags & NLM_F_EXCL)
>>>                         return -EEXIST;
>>>  
>>> +               if (flags & NLM_F_REPLACE)
>>> +                       modified = true;
>>> +
>>>                 if (READ_ONCE(fdb->dst) != source) {
>>>                         WRITE_ONCE(fdb->dst, source);
>>>                         modified = true;
>>>
>>> The argument for always sending notifications to the driver in the case
>>> of replace is that a replace command will refresh the entries timeout if
>>> the entry is the same. Any thoughts on this?
>>
>> I don't think so. It always updates its "used" timer, not its "updated" timer which is the one
>> for expire. A replace that doesn't actually change anything on the entry shouldn't generate
>> a notification.
> 
> Okay, so then there is missing checks on flags as the issue arose from
> replacing locked entries with dynamic entries. I will do another fix
> based on flags as modified needs to be true for the driver to get notified.

