Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4DD779C56
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 03:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjHLBnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjHLBnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 21:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B4170E
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 18:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 652C160B4A
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 01:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8BAC433C9;
        Sat, 12 Aug 2023 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691804628;
        bh=MM59sm1574YJX/wQxrOJddi3KcUVRF4hQEW0KTlr9a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bqt0gCmHLsG/lnNH+tzAQK1w5R7G1V8F6FOUqBsMJPdSRbMHA05LO/+ZyQfyORkWb
         iWGgt8+1hJ1EMszWDxHV0x/a+MJ+7eMdxUlJ6c3RqbfNLSp19Na+LJkDjewiUfkuyt
         2cJvLS9usR9UxH2zus0Ec9I7wldoNVICAKFb26pqpIRuV6pC9nvd0WJg8MqpT8aRMZ
         Kph8QEkBDbUOk0S0eLNSDCtZdNNQp6Fab/y96Z/cInC2pak+HwuFAIyW9SPZEHg4Ft
         7clYTbGLBKuKfrST3805kIRO5mFx2EfNNv3h6wA90Ezi7tBj2A0TZor7OITDO4j2sr
         1eFduiqqPUZMA==
Date:   Fri, 11 Aug 2023 18:43:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Message-ID: <20230811184347.1f7077a9@kernel.org>
In-Reply-To: <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
        <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
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

On Wed,  9 Aug 2023 14:58:52 +0200 Sabrina Dubroca wrote:
>  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
>  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
>  			conf = TLS_SW;

Should we add a statistic for rekeying?

> +int tls_set_sw_offload(struct sock *sk, int tx,
> +		       struct tls_crypto_info *new_crypto_info)
>  {

This function is already 300 LoC and we're making longer with 
a not-so-pretty goto skip;

Any way we can refactor it first? I think someone had a plan
to at least make the per-algo stuff less verbose?
