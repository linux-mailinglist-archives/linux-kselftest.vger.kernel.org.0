Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FE583251
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Jul 2022 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiG0SsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Jul 2022 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiG0SsC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Jul 2022 14:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35D654C8F;
        Wed, 27 Jul 2022 10:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F526187E;
        Wed, 27 Jul 2022 17:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62224C433D6;
        Wed, 27 Jul 2022 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658943912;
        bh=ofSex9ZixWih+BVhYWaCm0zqEzSVXQxFANe0milbxcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EoyCsElmqKjQC0hmIueef6la0moU74Xqbdlwc1MpXXk0rNK0tVwwQoAsaIc27lO70
         gKMZvhHs+PnLLfnaqsm5oY+kfmWTfAPmErkdiAg43IDoFj9SFCmwarb/BLKD5uM3n/
         p4FZrvDd64+c1V2Rtol9aJg6MZ1tMmJpAyn1tDIDjpxcJSTrxisCUYlwlpIQhNPuIL
         EHCQ00vuYSgcCdkBv/mcJvrHpnZFtD3wZk3hX7FIEmBLWRRP5YLdNUOkhQwCy8SMTX
         +kC3cUsTpcncEj1oVPYTQ38iAuNGEifl/pFeW/0dFgO69r+mfysyX12tPyaDkSfLkM
         6wCLkgQ/+52Jg==
Date:   Wed, 27 Jul 2022 10:45:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kleber Sacilotto de Souza <kleber.souza@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Justin Iurman <justin.iurman@uliege.be>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] selftests: net: fix IOAM test skip return code
Message-ID: <20220727104511.1509e237@kernel.org>
In-Reply-To: <20220727093742.115882-1-kleber.souza@canonical.com>
References: <20220727093742.115882-1-kleber.souza@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Jul 2022 11:37:42 +0200 Kleber Sacilotto de Souza wrote:
> The ioam6.sh test script exits with an error code (1) when tests are
> skipped due to lack of support from userspace/kernel or not enough
> permissions. It should return the kselftests SKIP code instead.
> 
> Signed-off-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>

Please repost CCing netdev@ (keep Justin's Review tag)
