Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56F3768640
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjG3Pm0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjG3PmZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 11:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2D1A6;
        Sun, 30 Jul 2023 08:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F410160C90;
        Sun, 30 Jul 2023 15:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3635EC433C7;
        Sun, 30 Jul 2023 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690731743;
        bh=JR32eOsoska7WehA4yWwRMQ+wOTMGHFvNU7Io4yZsjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gfjo+GHtRvXFjipD0P5HmsTpC4wjW12gGL25nQMiHV0/0XJwQOWywC0Jyy5zBzeLL
         H74HlyV0MJcnJJzXiEQlkUpjzOLFlktH1gNfG0otHdyxEMDidc/1XBv+2yVLVUdxtN
         gHVc+EP52TPR8ZIRKlmrMH76IPvnTm8tr46rotni8dfMsgTv3d6iDO4a2D7c/0ONGi
         f7f0CF0SWJ9KOWGc08eOmhPGFZC7/wO4FaXNNUwllr5QcO6Z3eSkKWZCW5Zn5SDdYM
         0YTg5M2w70atVm/b+4NeaLl/hUxNvdvE8aGTvFI+C6dpleAc/tzBJ6mTlkeBuJSxHQ
         ikhBhBGk6803A==
Date:   Sun, 30 Jul 2023 17:42:19 +0200
From:   Simon Horman <horms@kernel.org>
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH v2 net-next 2/5] selftests: openvswitch:
 support key masks
Message-ID: <ZMaE24XVEcs5SBgq@kernel.org>
References: <20230728115940.578658-1-aconole@redhat.com>
 <20230728115940.578658-3-aconole@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728115940.578658-3-aconole@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 07:59:37AM -0400, Aaron Conole wrote:
> From: Adrian Moreno <amorenoz@redhat.com>
> 
> From: Adrian Moreno <amorenoz@redhat.com>
> 
> The default value for the mask actually depends on the value (e.g: if
> the value is non-null, the default is full-mask), so change the convert
> functions to accept the full, possibly masked string and let them figure
> out how to parse the differnt values.

nit: differnt -> different
