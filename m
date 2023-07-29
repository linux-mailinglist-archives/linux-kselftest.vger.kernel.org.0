Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF716767951
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 02:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjG2AFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 20:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2AFI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 20:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99421724;
        Fri, 28 Jul 2023 17:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E41962214;
        Sat, 29 Jul 2023 00:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6758C433C7;
        Sat, 29 Jul 2023 00:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690589106;
        bh=SbsIutA3EYfCHZX2YXoEtpa3eEx2jhmXyh9aYEIouMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P2p0jXVzukCImrkX1DQXgjyh+d8sRiAsXX6j7CB9xIgQzN09iA3IrGkeMt5MZOQK7
         f7iYXVEfQqo4ovWcxaBCGAUMd+GEfsUTpV6RgzVg0m25mxDGgppwRd60UkBkkA1fnB
         fm+qdfout19EJ3Yvs8mimNHBBhWvphPpNe35uCkDIRLVb0n3FqFC7gDCg8Se1zCr87
         M45Vk+e8hwwY/nJbVZHT4NIoo8weyVv8eULHIN0AVHoIT09zwvuGqB9AztBoLK4Cnx
         JffQXC0+jSonz9EnmKotFeSSkMtw/1AQw6YQSNB9eWZCXe+NuY5N5hpB1ZC5W2dyYU
         Rq6i4PT0/KWXA==
Date:   Fri, 28 Jul 2023 17:05:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, davem@davemloft.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests:connector: Fix input argument error paths
 to skip
Message-ID: <20230728170505.4bbe3ea9@kernel.org>
In-Reply-To: <7b7b8acc-5db2-5e6a-e803-e054ec7e1ab0@linuxfoundation.org>
References: <20230728225357.5040-1-skhan@linuxfoundation.org>
        <20230728162144.3db7dbac@kernel.org>
        <7b7b8acc-5db2-5e6a-e803-e054ec7e1ab0@linuxfoundation.org>
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

On Fri, 28 Jul 2023 17:58:01 -0600 Shuah Khan wrote:
> > netdev was not CCed on this or patch 3 of the previous series :S
> > Which is a bit odd 'cause it was CCed on patches 1 and 2 =F0=9F=A4=B7=
=EF=B8=8F =20
>=20
> Odd. get_maintainers.pl didn't give me netdev. I added netdev
> and others to the first patch from the bug report.
>=20
> Would you like me to resend this with netdev on the cc?

If you don't mind that'd be quite helpful, all our local tooling
depends on the patch being in netdev's patchwork.
