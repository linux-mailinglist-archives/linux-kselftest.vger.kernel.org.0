Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CC76C856E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCXS6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXS6U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 14:58:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A41910D
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 11:58:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b20so11749140edd.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679684297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aM5HxqOV+QtMfuclBgHJH7lTiijH/4O4dxNBYYZxrqc=;
        b=07sSmpXBzc0QBHuyWMaRsKOFNZH+77XWwt9mjxzInZ4xzv3Coh3Sw4irKDABzDLCFj
         +mTqvA6iqrQUaci32rukAbuZY1WfmglHxTkHy4fnvXtg4y8laYEyDyFysnjjUdF0t23P
         xXgDSs+fhVNG6OS5qlNdojtmpMnVHfcIaJ0r7/CK9kvjKcDxeWsy46GgY3tzLUgNLnQg
         bfjn4Qohul6/HLinfXeEFwpNUu08X6BI1tACKZdjUWnIGzi8cIOCl1JWh+OYSIOxkMro
         tgWQ8UJlK6H8YrL6982/5lwTA1mgtrFfzWnKYhEGDCkhQcBtNnVC88LfC2mW4sZDdTZ9
         3svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679684297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aM5HxqOV+QtMfuclBgHJH7lTiijH/4O4dxNBYYZxrqc=;
        b=6F+EFLceSZtTx4j8kcWWmWFMoBn/6TNIRh6M1Z/9eABhGTOPvB7+MNngi1cWkXDmNy
         0TD7Imb/yszc+amJ33sriaOIo8B4kDymMhV6hgIvzQPStF+lA/7kg7tJnLujYNO0Edys
         q3axIwgJFzGQVexbwnNdGdS8kOY9DHVC2o2s/oKVn361cuSdwEMo8BZ/zy+L6mZgEuch
         txd1j1nUohmoa2x/SIWAFq8wG5Oko7U49p4DWAmT2AnXwMUBwJnYxVv0EeiRo5Ze4Tda
         pQ9bMKOR7dOwNtVgW8HqDLx7bXhiW7tlaCfk5Q7YsfqUzDiZDdbziQCSk/HlgkSL8xpi
         nWqw==
X-Gm-Message-State: AAQBX9f0xNhUEEP9JIyzI1nEIuHRQ+JgaiA1EU33uCwCMDjWyp/P07fk
        iU29+t1m0ERlhZq9yAzA+OcTGQ==
X-Google-Smtp-Source: AKy350YcZXDla4Hwm6jLoOnN+sfMm9+gny+dpA+m4FqxyhLDp9/Pi5Ax324Y3zTe/o1SX4ktCc/cKg==
X-Received: by 2002:a17:907:6d24:b0:93e:9362:75fa with SMTP id sa36-20020a1709076d2400b0093e936275famr2165161ejc.47.1679684297136;
        Fri, 24 Mar 2023 11:58:17 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709064e0d00b009351565d1f5sm7092980eju.52.2023.03.24.11.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:58:16 -0700 (PDT)
Message-ID: <3100c8b2-4576-03eb-52a5-10d6ddf0fedc@tessares.net>
Date:   Fri, 24 Mar 2023 19:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH net-next 3/4] mptcp: do not fill info not used by the PM
 in used
Content-Language: en-GB
To:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230324-upstream-net-next-20230324-misc-features-v1-0-5a29154592bd@tessares.net>
 <20230324-upstream-net-next-20230324-misc-features-v1-3-5a29154592bd@tessares.net>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230324-upstream-net-next-20230324-misc-features-v1-3-5a29154592bd@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On 24/03/2023 18:11, Matthieu Baerts wrote:
> Only the in-kernel PM uses the number of address and subflow limits
> allowed per connection.
> 
> It then makes more sense not to display such info when other PMs are
> used not to confuse the userspace by showing limits not being used.
> 
> While at it, we can get rid of the "val" variable and add indentations
> instead.
> 
> It would have been good to have done this modification directly in
> commit 3fd4c2a2d672 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")

I'm sorry, I just noticed I picked the wrong SHA for this commit and my
scripts only checked the ones mentioned in the "Fixes" tags. We should
have this instead:

> commit 4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")

I can send a v2 later to fix the SHA if there is no other comments.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
