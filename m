Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F33757DB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjGRNfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjGRNfO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 09:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801BDE0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 06:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFEC461594
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 13:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABEAC433C9;
        Tue, 18 Jul 2023 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689687312;
        bh=87x/ZiICR+wjR2rxh0LCkN4th6j+MlFTVrqott7G8JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gw9YXTCxOIGRmdlzFeIxvMZpmglLv3KMDBtgMHMqX5xa+LT3ujlhNLKB1AUCE2LCW
         shvyT4eaxIqTQoU/fhQGMOEZNc/Lv9+kNA0ZSXQQRxCHI3jbiKA+fmQ5r2irqSIbTR
         PTwXRkrdu1EQoVygN47SgtA3iexsKIeQvxXu6I/A=
Date:   Tue, 18 Jul 2023 15:35:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/5] platform: Provide stubs for !HAS_IOMEM builds
Message-ID: <2023071855-decimal-sarcastic-65b9@gregkh>
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
 <20230718-asoc-topology-kunit-enable-v2-2-0ee11e662b92@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-asoc-topology-kunit-enable-v2-2-0ee11e662b92@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 01:28:43AM +0100, Mark Brown wrote:
> The various _ioremap_resource functions are not built when
> CONFIG_HAS_IOMEM is disabled but no stubs are provided. Given how
> widespread IOMEM usage is in drivers and how rare !IOMEM configurations
> are in practical use let's just provide some stubs so users will build
> without having to add explicit dependencies on IOMEM.
> 
> The most likely use case is builds with UML for KUnit testing.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/platform_device.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
