Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3456793084
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbjIEU6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 16:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjIEU6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 16:58:02 -0400
X-Greylist: delayed 273 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:57:59 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FBB2;
        Tue,  5 Sep 2023 13:57:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E837EC433C8;
        Tue,  5 Sep 2023 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693947239;
        bh=rPD3WYvBqg9PWkPEMXs+yj80x0SnlrDTEIJPptThAxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NqWVB2b+z6W60vXKcAyJOlNDeQSZjzea/uXqVnYc7iCgDpebHFjnDD367NrZOd+B+
         w7ITI3lz/UMcj/AKpm7M3+eoWxmN2y6/ouzwOGt8niR40hI1BXX2fGle8KQvrKu8Nm
         ZqWlmszQ2c8UrWNeROdO2qslZlSKz7w09EFm+KeRCeFVgGTfNDvrb/5zX7otstp3n+
         GLV2tQYnFRud7FsTFz9JiQ9OFnq8SvdRlOaZRFxtS+cpK9zP6W8gfYwvjwIBAk461T
         CVQ3BMJ2c7Uad7kkOaER3hDLYA1GEBDyt0Hg5M7CAA6t3XLgsKotxFvSqCB5iXDGoe
         iuHy49aD1XwTw==
Date:   Tue, 5 Sep 2023 13:53:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
Message-ID: <20230905135357.78b57cde@kernel.org>
In-Reply-To: <20230905-fdb_limit-v3-6-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
        <20230905-fdb_limit-v3-6-7597cd500a82@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 05 Sep 2023 13:47:23 +0200 Johannes Nixdorf wrote:
> Add a suite covering the fdb_n_learned_entries and fdb_max_learned_entries
> bridge features, touching all special cases in accounting at least once.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>  .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++

Please add it to the Makefile so it gets run by automation.
