Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7C7684C8
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjG3KNP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 06:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjG3KNP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 06:13:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4587010C1;
        Sun, 30 Jul 2023 03:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6FF66068F;
        Sun, 30 Jul 2023 10:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38A0C433C8;
        Sun, 30 Jul 2023 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690711991;
        bh=WpJsh3fyEuGUo6PH6fN0EFyznVrVxs5GaJUXkqK1ArM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nV8ShlEG/+v+bYW2/rSVxdi5O9PKWdmulDttqQLptSkQKdhOrhN6JtjF/AlJxQYn7
         XjYFwCQ50FZ0eNPZuUC3rAJldMdm9CknM3CBwNCYCsxngQMZ0giD0DbnK1Fwcp6Sbr
         l0nVDirecyQtuyW4/aUFXyz2B8Vk2jqc68PzEsxA=
Date:   Sun, 30 Jul 2023 12:13:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] selftests: rtc: Improve rtctest error handling
Message-ID: <2023073058-uncurled-leverage-4045@gregkh>
References: <20230722060706.79759-1-atulpant.linux@gmail.com>
 <9d51f21d-04e8-3dd2-91b9-9ab0cf848760@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d51f21d-04e8-3dd2-91b9-9ab0cf848760@web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
