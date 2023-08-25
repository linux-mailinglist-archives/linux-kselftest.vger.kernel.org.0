Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A41788E26
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjHYR7U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjHYR7Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 13:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32DE54;
        Fri, 25 Aug 2023 10:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645C662257;
        Fri, 25 Aug 2023 17:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988DFC433C8;
        Fri, 25 Aug 2023 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692986352;
        bh=hpbJdR25m1QXnq31MNqMvBDRlA1RB0g3/1vKfKZm4Ag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NlPW+i6MO8wk5RnmJ6ewRqV3uF77qw4+tDysHCSgfE62FSGITEKoaTm7ITa5R/epp
         ggJ0UpTAKVDwMmyddP9KV8r3XqasB3ZzHAMv+y1y/4MuvqRrvhol0QE+PDBe1ogd3g
         ETvaMG5fRfhr7eAMtNez5c9YjO5O762P9xSpEnZAQprxvDXg5E61UZ70onxRpZ9QPM
         8M2UbjQzXf/5DBWrAO5KJ7gOiQnxCp+T875FHXFKXmNIhPS3Rn4QB8QnBl01xsIWVQ
         FG7Xv1y+56n1U18dz2xE9RW6p/9yeYD35BTdIAJOS0h0KOOHAUUP7jchbV7WcFMapr
         qudeTGgg01zOg==
Message-ID: <0ed7d3dc-90b5-52e0-747e-5d8712a71a05@kernel.org>
Date:   Fri, 25 Aug 2023 11:58:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ANNOUNCE/CFP] Kernel Testing & Dependability Micro-conference at
 LPC 2023
Content-Language: en-US
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        shuah <shuah@kernel.org>
References: <e04d1d5b-518b-bebd-aa7a-70b87bc4e867@kernel.org>
From:   shuah <shuah@kernel.org>
In-Reply-To: <e04d1d5b-518b-bebd-aa7a-70b87bc4e867@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello all,

On 7/19/23 15:34, shuah wrote:
> Hello,
> 
> I am reaching out to announce that we are once again planning to
> gather to discuss testing and dependability related topics at the
> Kernel Testing & Dependability Micro-conference at LPC 2023.
> 
> We invite you to submit proposals for discussion:
> - https://lpc.events/event/17/abstracts/1430/
> 
> Proposals can be submitted here, by August 20th:
> - https://lpc.events/event/17/abstracts/
> 

Reminding you to submit proposals for the upcoming Kernel Testing &
Dependability Micro-conference.

> Please reach out to MC leads:
>       Shuah Khan (shuah@kernel.org)
>       Sasha Levin <sashal@kernel.org>
>       Guillaume Tucker <guillaume.tucker@collabora.com>
> 

thanks,
-- Shuah

