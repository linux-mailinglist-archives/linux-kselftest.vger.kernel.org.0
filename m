Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764447E4396
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjKGPiT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 10:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjKGPiI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 10:38:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70AF30FD;
        Tue,  7 Nov 2023 07:18:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD475C433C9;
        Tue,  7 Nov 2023 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699370328;
        bh=uVJ645+VuEHxOP8w8Z+6y5IMCcpafxtnwjwVfF8N4mU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dKF+RYhHYzGOqcc1tWqUcEHmYDXpwsOrbAPC0yyuBAC+FmY+KiW8k1twqUiw9zVM/
         4NszSo7oeGlhDJ0QDUWeEroGyvH39RSeYtNxEKjLYspDnM+9TFfn2P+8eawyLYwDLV
         rkJ0wmZY7CTaXE8Af37cxvAJpKgbq2OS2aYNuW1wIfpM+k4RldibtyBVTIiaLMDua3
         idleeFra2A2zzNvhvhOus0gA+WQq52RQ0NzrWnhoRNyxQ43/bPTbehHVmGOhK3mXoZ
         ZoqUp6BHE0tGlbhtCwApBg0oH0UHqHK+OwY7GoCwzTbr8n78uD8uXyGTN6P05KicNz
         UwDkCXNYumttw==
Message-ID: <bbdedbf7-efad-48a2-8e27-53d03156fe17@kernel.org>
Date:   Tue, 7 Nov 2023 08:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/12] Device Memory TCP
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
        Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20231106024413.2801438-1-almasrymina@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Is there a policy about cc'ing moderated lists on patch sets? I thought
there was, but not finding anything under Documentation/. Getting a
'needs moderator approval response' on every message is rather annoying.
