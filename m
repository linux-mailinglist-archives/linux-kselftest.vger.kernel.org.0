Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F0712C67
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEZS1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEZS1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 14:27:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BED3;
        Fri, 26 May 2023 11:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77E2E60ACA;
        Fri, 26 May 2023 18:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52505C433EF;
        Fri, 26 May 2023 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685125649;
        bh=B9a2+71TulzKBO9c2ZxBPHtYPJB9s9lgR7ZlY+O6qkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yzH6gnNir81Oov6JCgRSOSjBEmZ4NR3JxsObBl2m+Rm4Oc3/T1dpci6YSkL4MohI/
         lHmxJgwFGQFguSb3LbMIZpV81P/lUP+Ni3f3YUTam9ZFR0JwwTx4Ki6KfVN278UulY
         KQbZ6akaW78CjenlW0TLGwlTt9hTzrieTn/zIynU=
Date:   Fri, 26 May 2023 19:27:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragos-Marian Panait <dragos.panait@windriver.com>
Cc:     stable@vger.kernel.org, wenxu <wenxu@ucloud.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        William Zhao <wizhao@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5.10 0/3] Fix for CVE-2022-4269
Message-ID: <2023052617-preorder-universal-1b5d@gregkh>
References: <20230516190040.636627-1-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516190040.636627-1-dragos.panait@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 16, 2023 at 10:00:37PM +0300, Dragos-Marian Panait wrote:
> The following commits are needed to fix CVE-2022-4269:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa6d639930ee5cd3f932cc314f3407f07a06582d
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78dcdffe0418ac8f3f057f26fe71ccf4d8ed851f
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca22da2fbd693b54dc8e3b7b54ccc9f7e9ba3640

All now queued up, thanks.

greg k-h
