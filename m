Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C976A71D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHACnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 22:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHACnk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 22:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A3C10C3;
        Mon, 31 Jul 2023 19:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FF2612CA;
        Tue,  1 Aug 2023 02:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9319AC433C8;
        Tue,  1 Aug 2023 02:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690857818;
        bh=n4dsEw0hO1hhcpvbUzRfjMJlHkCbxkrsloRNUT6H/t4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=akFDDuctuT3hHiEMB/+rQBPuCORBi0BotJ2zv0hr8+Wuk4y98aTP6CmXMw6z7tc8v
         EL423fcpqi+iEBQYH7tcO8+SIRVpRo2F+x2CsiEQDr2AnrnBEbzBqkiq/IH4MqOrkQ
         17mCW9HJ70Mwb+iISagAUZix/g5dHrWRvX/XuRkUOrhstxgByzP5dnkbHVBByl5L1R
         CsPlzcwctPldJb77u/+Cs4VNzfoTovj+QB8JJOKxmmhnNePn83SFgoiv6UzPIcMun4
         3b4YyJoT8mG8OQ6xCNaVS0iGqWPhvOWyFQRjgGGsgTLZkzSm05xdpXa+4+/tAhmY6m
         gFrcg2qMBADWg==
Date:   Mon, 31 Jul 2023 19:43:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Hwang <hffilwlqm@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org, tangyeechou@gmail.com, kernel-patches-bot@fb.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf, xdp: Add tracepoint to xdp
 attaching failure
Message-ID: <20230731194336.5b4bd065@kernel.org>
In-Reply-To: <20230730114951.74067-2-hffilwlqm@gmail.com>
References: <20230730114951.74067-1-hffilwlqm@gmail.com>
        <20230730114951.74067-2-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 30 Jul 2023 19:49:50 +0800 Leon Hwang wrote:
> @@ -9472,6 +9473,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	struct bpf_link_primer link_primer;
>  	struct bpf_xdp_link *link;
>  	struct net_device *dev;
> +	struct netlink_ext_ack extack;

This is not initialized. Also, while fixing that, move it up 
to maintain the line order by decreasing line length.

>  	int err, fd;
>  
>  	rtnl_lock();
> @@ -9497,12 +9499,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  		goto unlock;
>  	}
>  
> -	err = dev_xdp_attach_link(dev, NULL, link);
> +	err = dev_xdp_attach_link(dev, &extack, link);
>  	rtnl_unlock();
>  
>  	if (err) {
>  		link->dev = NULL;
>  		bpf_link_cleanup(&link_primer);
> +		trace_bpf_xdp_link_attach_failed(extack._msg);
