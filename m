Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378FE6F34EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 19:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjEARQt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjEARNJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 13:13:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A100118
        for <linux-kselftest@vger.kernel.org>; Mon,  1 May 2023 10:12:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaea43def7so12247035ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 May 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1682961138; x=1685553138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQwEZsGQFV67e/W2VFI+LrpVt3WArWhFRwFL5ebHaQk=;
        b=e+KrwVJAc6NZ0nXgs+cIDZKWtSS89J3cggICOyEJoH9exKAT/RIjSmOqtQRxGotl/N
         4kPSh0nzNpwq89nc7+JUFRIecg8a+1CqprVAcaaTe+YB3wJvmBeA3AojL8EH0MEItJ5o
         VHdZj/Nfl97eSpYM/WS2srYTfHvoeq19e2hPSAi3GV6NsPMegxuY+9RU9GeuFv23qhoV
         WiLBx3TrpHc5WNz2dmrV5rCYeFGXkTQXQiZn/5dLMpbTxHV9sR9sB4W/iMzp28Cam3HF
         jY34wHljdWEonUY1r40TGGhIPsZZMauodnR+cgUSm5hJOoqXKLuRSaSU2lkx3gdELoKz
         Xd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961138; x=1685553138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQwEZsGQFV67e/W2VFI+LrpVt3WArWhFRwFL5ebHaQk=;
        b=UwkT+Ydx7aLxkqotZZHmlNJN1D5Nak1tnuaOhVslm5RqfpTaDtm24tt0R86H15qVIo
         EKJOeCYiN0xesteySR32MDbjX94Rz3TQKfZkr/gUshIp5HJ71TQADXB0fYKXM6wYOv73
         ULp74kT88LFbET35x0dvP+Gei5txeZQVGP8tFMk1DASjTT/y84mZhOAYxq5rw0J179JB
         0i2Q4ywyWdSIbld8stpOVPRTc/kQl99fTJ56tpJGF/pZ0Xgug9Z3IXBVhCU0SB6WGhMC
         GbdB8pnujnZpN1OX3OzREe4IO96PLlw4JuzkEPRcRfGreLU64J6Z13KRkB5dECqVZkxA
         wYmA==
X-Gm-Message-State: AC+VfDz5NieXDBaMrqT3y8+bQr2jO0BFk7oZYzYJSP5V0c04qvtGAlsG
        axl4K5b+HTgg3nrExvzqQf5wFg==
X-Google-Smtp-Source: ACHHUZ79H0UViLK2azuwg73og7DYOPZK6DoYz+wNbjdaV4bZRrofJWNAUtheKScoqwtGrXTBT8m83w==
X-Received: by 2002:a17:903:32c1:b0:1aa:f43e:f21d with SMTP id i1-20020a17090332c100b001aaf43ef21dmr4779183plr.63.1682961138156;
        Mon, 01 May 2023 10:12:18 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b001aad4be4503sm4401568plh.2.2023.05.01.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:12:17 -0700 (PDT)
Date:   Mon, 1 May 2023 10:12:15 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vladimir Nikishkin <vladimir@nikishkin.pw>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/2] Add nolocalbypass option to vxlan.
Message-ID: <20230501101215.46682967@hermes.local>
In-Reply-To: <20230501162530.26414-1-vladimir@nikishkin.pw>
References: <20230501162530.26414-1-vladimir@nikishkin.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue,  2 May 2023 00:25:29 +0800
Vladimir Nikishkin <vladimir@nikishkin.pw> wrote:

> If a packet needs to be encapsulated towards a local destination IP and
> a VXLAN device that matches the destination port and VNI exists, then
> the packet will be injected into the Rx path as if it was received by
> the target VXLAN device without undergoing encapsulation. If such a
> device does not exist, the packet will be dropped.
> 
> There are scenarios where we do not want to drop such packets and
> instead want to let them be encapsulated and locally received by a user
> space program that post-processes these VXLAN packets.
> 
> To that end, add a new VXLAN device attribute that controls whether such
> packets are dropped or not. When set ("localbypass") these packets are
> dropped and when unset ("nolocalbypass") the packets are encapsulated
> and locally delivered to the listening user space application. Default
> to "localbypass" to maintain existing behavior.
> 
> Signed-off-by: Vladimir Nikishkin <vladimir@nikishkin.pw>

Is there some way to use BPF for this. Rather than a special case
for some userspace program?
