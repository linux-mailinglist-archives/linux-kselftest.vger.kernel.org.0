Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457A4777FB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 19:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHJR6z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjHJR6y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 13:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F99ED
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 10:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BEF76653A
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 17:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04745C433C7;
        Thu, 10 Aug 2023 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691690333;
        bh=9xNnw9MlZHZXh+TQnt3n9ftd1NAsQ8YRcPHv37zvicU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xy6mfQx+q8eginJvxvN+k8QTIk80WTJBIsBz+TRvxiiuwmRxTvz8b04/CpPP1LDdU
         AKuJFDGch4wuE3Jp8Vu4+lfGkah5uYmPykwnfhoWJYmmpshBHUlJelXgeTGu7Dd51l
         s4OTIX07ZWZfOCleyQvqY3rUOZ0yarjWDweq1Ik6A9GL2JHptciMMNsxMRQVOmYTbE
         tVbSj7Ez2kx1+09yQX636Rw3rU0oBThUBCJlkTuRfdQwrRTme6nqLiIOQ+87JAYor0
         aD01Ujngz/t7awtglLSKHNlwJkdjaIpS3aXHUy6k4AIo/yHfXrUXjsBt4kl1uOnKQH
         FzqHvn78Og/UQ==
Date:   Thu, 10 Aug 2023 19:58:48 +0200
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
Subject: Re: [PATCH net-next v3 6/6] selftests: tls: add rekey tests
Message-ID: <ZNUlWDvyOal1p5OY@vergenet.net>
References: <cover.1691584074.git.sd@queasysnail.net>
 <b66c17d650e970c40965041df97357d28e05631d.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66c17d650e970c40965041df97357d28e05631d.1691584074.git.sd@queasysnail.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 02:58:55PM +0200, Sabrina Dubroca wrote:

nit: Ideally a patch description would go here.

> v2: add rekey_fail test (reject changing the version/cipher)
> v3: add rekey_peek_splice (suggested by Jakub)
>     add rekey+poll tests
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

...
