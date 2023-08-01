Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D948876C022
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 00:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjHAWJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjHAWJN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 18:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935292D65;
        Tue,  1 Aug 2023 15:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C419F6175A;
        Tue,  1 Aug 2023 22:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9F7C433C8;
        Tue,  1 Aug 2023 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690927708;
        bh=Fprg9A7lqx6rZCFEElImiV0nfq2ndvAMquua7Y1GBYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VmtF1xVixlC/10SuowzThM4JnSZSyoXyeMnbPfptuZbeTUxYWK/VHQfsuEeEsuFzT
         xN7SdwW3xB1/LvEe/Ysdla9MnFDqFltreJv0u4N1uWW/6ZD2CWTuHKYxnGdh3QjbPw
         WgnfCbAve7ahVq3DLbGxj/JriRkOzYNv1uqba6jZwd9wF3Ko8PGRxRHWcoSBPZUdjL
         k8B5SvYOj5cONSg2muK3wzWASNO1R1cC6RKPdy2XgVCupYwvfYtxEiz52Y83CFTfED
         at7ot5/TcMBi26kaOhEUgAxt3OQiyksvAUfC5i2TouuUtZhyEkkIZCA2UMGn4kup3Y
         HWr6qnmWazCWA==
Date:   Tue, 1 Aug 2023 15:08:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Hwang <hffilwlqm@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        hawk@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mykolal@fb.com, shuah@kernel.org, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] bpf, xdp: Add tracepoint to xdp
 attaching failure
Message-ID: <20230801150826.6f617919@kernel.org>
In-Reply-To: <20230801142621.7925-2-hffilwlqm@gmail.com>
References: <20230801142621.7925-1-hffilwlqm@gmail.com>
        <20230801142621.7925-2-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue,  1 Aug 2023 22:26:20 +0800 Leon Hwang wrote:
> When error happens in dev_xdp_attach(), it should have a way to tell
> users the error message like the netlink approach.
> 
> To avoid breaking uapi, adding a tracepoint in bpf_xdp_link_attach() is
> an appropriate way to notify users the error message.
> 
> Hence, bpf libraries are able to retrieve the error message by this
> tracepoint, and then report the error message to users.

Whatevered-by: Jakub Kicinski <kuba@kernel.org> ?
