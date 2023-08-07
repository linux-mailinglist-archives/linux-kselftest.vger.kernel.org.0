Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD92771CF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjHGJPW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 05:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGJPV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 05:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8722E68;
        Mon,  7 Aug 2023 02:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8CE616EA;
        Mon,  7 Aug 2023 09:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC2C433C8;
        Mon,  7 Aug 2023 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691399719;
        bh=WxAh8iW+258bwzaDgHMpc14XPRfhm/gtCpiInP6uO78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQ5kz3l1kCG1seHKBJtn2Nvn6Jl47GPL2qmAppv0jy4/SCW8whxLwLLVphOO84sBD
         zuXgb/eoKwxiv1AyShNwmy1kf8bmFSrETaAgzyJ+7d4guemGZtAFogE1BqVyvkIE/2
         hhLQk0XmGL1uF2N7kHGUnqViaKBB2LiDhnXE/1/w=
Date:   Mon, 7 Aug 2023 11:15:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 4.14 1/1] test_firmware: fix the memory leaks with the
 reqs buffer
Message-ID: <2023080705-poet-nickname-5e08@gregkh>
References: <20230804170017.92671-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804170017.92671-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 07:00:18PM +0200, Mirsad Todorovac wrote:
> [ commit be37bed754ed90b2655382f93f9724b3c1aae847 upstream ]
> 
> Dan Carpenter spotted that test_fw_config->reqs will be leaked if
> trigger_batched_requests_store() is called two or more times.
> The same appears with trigger_batched_requests_async_store().
> 
> This bug wasn't triggered by the tests, but observed by Dan's visual
> inspection of the code.
> 
> The recommended workaround was to return -EBUSY if test_fw_config->reqs
> is already allocated.
> 
> Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Colin Ian King <colin.i.king@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: stable@vger.kernel.org # v4.14
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> [ This fix is applied against the 4.14 stable branch. There are no changes to the ]
> [ fix in code when compared to the upstread, only the reformatting for backport.  ]

Thanks for all of these, now queued up.

greg k-h
