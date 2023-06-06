Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21272386D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFFHJo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFFHJm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:09:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44280C5
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 00:09:40 -0700 (PDT)
Received: from [IPV6:2a0c:5a83:9203:ad00:6f2e:82dd:9a04:a2e5] (unknown [IPv6:2a0c:5a83:9203:ad00:6f2e:82dd:9a04:a2e5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AF986602242;
        Tue,  6 Jun 2023 08:09:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686035378;
        bh=cYoWDMoDcjTeMLvh8Xz6kkQiQ4ez9mh85N9FBggJspY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=INKnr224ZO1Z0tefrx+dmy9dfwLqgX3re5MXGhgPthhQGWIio+g2hiWybcQGSjz9h
         l8G/GEMDEwNFt4fG+IQPPu8vKPJ9zfsg7JJvMf8I0ECryN0SbJN1zFvADGu6DF1Wsd
         K7EqkBW5b20E+d6UGjVGDzh68/vjtDWu36HytTTLJr7Ot+1WPKuDlxMVO/4mSK4Wwe
         kmX3mBe2bwscL6qPHMmxzSgecn3aez1s41sR80X8xCLhwu3HMT5L6nOx6lN3Gop7Zg
         ei6K8ZWITmW6OcFlOaYrQwTqv8ofBoePzAA8jekNOy8d2UrbDdg/1otMM3Hc3UMeVk
         Y5/n7NLxgLy0g==
Message-ID: <f11ad370-62f5-9437-5b65-7ed515de17b9@collabora.com>
Date:   Tue, 6 Jun 2023 09:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests/mincore: fix skip condition for
 check_huge_pages test
Content-Language: en-US
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kernel@collabora.com,
        naresh.kamboju@linaro.org, dan.carpenter@linaro.org
References: <20230515132643.119809-1-ricardo.canuelo@collabora.com>
In-Reply-To: <20230515132643.119809-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 15/5/23 15:26, Ricardo Cañuelo wrote:
> The check_huge_pages test was failing instead of skipping on qemu-armv7
> because the skip condition wasn't handled properly. Add an additional
> check to fix it.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com

Gentle ping about this, I still haven't seen it merged.

Cheers,
Ricardo
