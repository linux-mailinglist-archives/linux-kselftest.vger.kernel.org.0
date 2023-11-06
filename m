Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD57E31AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 00:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjKFXzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 18:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjKFXzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 18:55:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFB99;
        Mon,  6 Nov 2023 15:55:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEBDC433C7;
        Mon,  6 Nov 2023 23:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699314944;
        bh=CBVsDjLpDh3DqO53Z7jB5PodqXv0dqoRE1VTibicHDk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tHDu7NE3mpkr1DOFckfUWx88lr1g8NMqtWJ6eVQjt6YtxEJtB3MzRhMAqpHUCOOnu
         HERcGnFrYBktSD8DKkbyE8ek8H9VHw/wEzhcjIKOE9tdi5RIBdczye7+hnXGI4KJKu
         S0rpAERxYf/jKoXVcPPVq6PuYBkI20g7/zRTur41oqPVeJXe+V/38zMNofUypZYzSp
         O3mGYMyQzkQzdasVHQ+sN5vodbH7gZFWgfyYemzHaE/bdy2CusoZbtwSH6Pqk3dywZ
         jimVApXC5UDwmcNUMEwKAOS0k67+Rh55jzHYDZxhXJeV0Yn4t1vShofBTTCgeHKn43
         cIasqiU647M3A==
Message-ID: <93eb6a2b-a991-40ca-8f26-f520c986729a@kernel.org>
Date:   Mon, 6 Nov 2023 16:55:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com>
 <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
 <ZUlp8XutSAScKs_0@google.com>
 <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
 <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/6/23 4:32 PM, Stanislav Fomichev wrote:
>> The concise notification API returns tokens as a range for
>> compression, encoding as two 32-bit unsigned integers start + length.
>> It allows for even further batching by returning multiple such ranges
>> in a single call.
> 
> Tangential: should tokens be u64? Otherwise we can't have more than
> 4gb unacknowledged. Or that's a reasonable constraint?
> 

Was thinking the same and with bits reserved for a dmabuf id to allow
multiple dmabufs in a single rx queue (future extension, but build the
capability in now). e.g., something like a 37b offset (128GB dmabuf
size), 19b length (large GRO), 8b dmabuf id (lots of dmabufs to a queue).
