Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA4E7E3190
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 00:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjKFXot (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 18:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjKFXot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 18:44:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1AE8F;
        Mon,  6 Nov 2023 15:44:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9A3C433C7;
        Mon,  6 Nov 2023 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699314286;
        bh=t0BwAmAb144cG2eL0TnYT2JWy9BOS2OIlHQw4E5qN9k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s53NL0fUZ9FBNFCipYjRnFb3FG746CBTXqochlWbarCvEwzcoPCcYJ2NLfA4wdIki
         E2onJ2+3Cat4oLe552PHcA0d/oghgDT6US1+1ZbqNtHDkCIk/vCQ7t4MUFs3vwUmyW
         GcqQu1qbBd/O2KS+fus8SxOzrPruj0rVCt+jAFArPK/tZLUGb7SkPNnRW6sk+Eains
         esV82j+7jylgEynsJGVUcmnLlSgYnDEvo+cbue1jD8SPe0/Qa6ngdKOy889KT/cxx7
         pfSfv4Qsoko6kf4Bo6MWJmfBUaQdUibdsazVbyUz/uOT8YXHCELcsmcTx4ukNRCa0d
         6fzgAAIDOTpGQ==
Message-ID: <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
Date:   Mon, 6 Nov 2023 16:44:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231106024413.2801438-6-almasrymina@google.com>
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

On 11/5/23 7:44 PM, Mina Almasry wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index eeeda849115c..1c351c138a5b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>  };
>  
>  #ifdef CONFIG_DMA_SHARED_BUFFER
> +struct page_pool_iov *
> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
> +void netdev_free_devmem(struct page_pool_iov *ppiov);

netdev_{alloc,free}_dmabuf?

I say that because a dmabuf can be host memory, at least I am not aware
of a restriction that a dmabuf is device memory.

