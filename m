Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D766F69B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 May 2023 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEDLVD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 May 2023 07:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDLVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 May 2023 07:21:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446D358A;
        Thu,  4 May 2023 04:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C5263360;
        Thu,  4 May 2023 11:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE69C433EF;
        Thu,  4 May 2023 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683199261;
        bh=hybRD3LzWWwrXh4tz4OecEXOXA1NNGRV2IJ6rTlmilg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/M9vtyCIaloVsQQ7qC2PlwaGxxVE+Gw4K7eSdcb5z2jDrLmZx2AT3F8KXdAN9GVi
         7FaunzkKj2HFy7rjrgsGW2PMA4NeeN3JsN4CxZnFwbxjWpEEmVzSiC5fZM2fNmdtAi
         WXksc8FLTc8s7GIUw305hyKilAus/Eb/PMWeRJV2v9+d1WlD9B6SjOCsnNpT0L+wRM
         MOke4UrkAa3+y25RAFuLxMmKFsOTir9y4AM88XqgHEqeH1z+P2v397/5pUQ9QRVuox
         z+RPjJMp8FRP6iiscVeIMg2C3yEtNgRtuBsiO6nTEBbl7/3LpSnS/JubZC0HWhSyq2
         9g9/fxHPGYRCA==
Date:   Thu, 4 May 2023 13:20:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/clone3: test clone3 with exit signal in flags
Message-ID: <20230504-nacken-infostand-352ec9a6cda7@brauner>
References: <20230504085930.23842-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504085930.23842-1-tklauser@distanz.ch>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 04, 2023 at 10:59:30AM +0200, Tobias Klauser wrote:
> Verify that calling clone3 with an exit signal (SIGCHLD) in flags will
> fail.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Thanks. Should probably go through the selftest tree,
Reviewed-by: Christian Brauner <brauner@kernel.org>
