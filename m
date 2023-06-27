Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7473F76F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjF0Ifl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 04:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjF0Ie3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 04:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0BB5;
        Tue, 27 Jun 2023 01:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87876108C;
        Tue, 27 Jun 2023 08:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D4BC433C8;
        Tue, 27 Jun 2023 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687854867;
        bh=LpYzTTgFSg3p+saxrHUHIACgeU0lbQpU2jiX71kgerE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7euaNk9N65WbQ3C7243wEXopSEpdCt14ep7fgnZH5QH6dn6ByCaRLx13uv1bcy7x
         TeHXaKaPrHb61TEAO7kvisDsb6OEv4nQwNi9QtqkfoquBzU5UaZ21Rve97llkr4m+0
         rfXUyhlWCGaRsF5TovJRuUDPJuwu6huuJycJei8s=
Date:   Tue, 27 Jun 2023 10:34:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     baomingtong001@208suo.com
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: timers: set-timer-lat: Remove unneeded
 semicolon
Message-ID: <2023062702-trusting-thorn-419e@gregkh>
References: <2a1861f16769deb2f831b6daf14a1e8d@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1861f16769deb2f831b6daf14a1e8d@208suo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 27, 2023 at 04:10:42PM +0800, baomingtong001@208suo.com wrote:
> ./tools/testing/selftests/timers/set-timer-lat.c:83:2-3: Unneeded semicolon

What does this mean?

> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>

Does not match your From: line in your email client :(

