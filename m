Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D8777F4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 19:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjHJRmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHJRmO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 13:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F182700
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 10:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04BB965BD4
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 17:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4514C433C8;
        Thu, 10 Aug 2023 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691689333;
        bh=Kb5aaFpzQN9oVjA6jAch1Ze7xXj2uPE8xEabWrDEROY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHWo5eKb4A5lJxVViPx3IymLLaOfyS5RjJ0zYHTfkFNhiz7vCzu/H/UNzOSRf8t/I
         TkIwaSBH8eVlE+PMWlY/uakyqGE1DvRsqQN/jsk8G1eF+ihFcHDRt5elv9N30o76ve
         o2hx0gxiSAXT6m20M7VzjOMFVCZWsNP98EuBjpR4wi8+eeMGPIetUgB2+qz0MHwq/+
         UQsZDsAF8actX/qcnBkwNDopgVRtR9oUB+evUyzTPxpXaFT7rE47hnuQ4igEqgN8Nn
         sQVqbfW7GQWcori/EdkDrwJbHL5mC8Eg8yToi4SbCI8vM3JGwm3R+ZOBTnZ7RFGhTF
         Wy+zIy2kZYu0A==
Date:   Thu, 10 Aug 2023 19:42:08 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 1/6] tls: remove tls_context argument from
 tls_set_sw_offload
Message-ID: <ZNUhcNAX8ENOUOwY@vergenet.net>
References: <cover.1691584074.git.sd@queasysnail.net>
 <49bb1e97ace3d18c7b57b2ae6a5011643d351f0a.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bb1e97ace3d18c7b57b2ae6a5011643d351f0a.1691584074.git.sd@queasysnail.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 02:58:50PM +0200, Sabrina Dubroca wrote:
> It's not really needed since we end up refetching it as tls_ctx. We
> can also remove the NULL check, since we have already dereferenced ctx
> in do_tls_setsockopt_conf.
> 
> v2: reverse xmas tree
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>
