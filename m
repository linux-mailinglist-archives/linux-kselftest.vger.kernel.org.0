Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E07678E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 01:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjG1XVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjG1XVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 19:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E130CF;
        Fri, 28 Jul 2023 16:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5168962208;
        Fri, 28 Jul 2023 23:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B7AC433C7;
        Fri, 28 Jul 2023 23:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690586505;
        bh=b6KKk6ynEZY9NIWXLEA+pE7J+0IC2W9jZtn5LDXEigA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M8DGiPldJe2Ytf0kTW1mnJboGDRetp5rgM276I71dDzcXg51k1lJNDr1agsw43ael
         u68BzokidUHkDJWfN4T63XIoPjFgbSVeBrAozXPlUMMrahUMrOXgt/HZOe7Repp/42
         qVE4OYyd4mbvHlXdBzxDhwaSXghNnGFfJHoQEqYWsgvQj2XHC9IxXYJ8gy3ibp4B2p
         ewmgaMbMFqj1K/AGQjA2k6+3bIfYLclRx0ZKAvtdstw/pj4lTJaVPoUEuUjJ3QOCw1
         L8pW6+KnbslKdrYaEHVZGY3FhFRfXRkklKX4E4xrcGbSW+OFmbfZsym7s5/DJsvFnV
         cofUP15oFHD1w==
Date:   Fri, 28 Jul 2023 16:21:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, davem@davemloft.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests:connector: Fix input argument error paths
 to skip
Message-ID: <20230728162144.3db7dbac@kernel.org>
In-Reply-To: <20230728225357.5040-1-skhan@linuxfoundation.org>
References: <20230728225357.5040-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Jul 2023 16:53:57 -0600 Shuah Khan wrote:
> Fix input argument parsing paths to skip from their error legs.
> This fix helps to avoid false test failure reports without running
> the test.
>=20
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

netdev was not CCed on this or patch 3 of the previous series :S
Which is a bit odd 'cause it was CCed on patches 1 and 2 =F0=9F=A4=B7=EF=B8=
=8F
