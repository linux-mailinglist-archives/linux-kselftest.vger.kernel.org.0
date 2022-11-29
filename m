Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF42D63BB4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 09:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiK2IMy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 03:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiK2IMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 03:12:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F4317C0;
        Tue, 29 Nov 2022 00:12:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19459B810AD;
        Tue, 29 Nov 2022 08:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDA5C433C1;
        Tue, 29 Nov 2022 08:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669709568;
        bh=73X0MFzISF5UzhgwTQwFU+Rx3lykgnQsZe0OhMAonDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMvQKM88wbAXrJQAaVA9VeGzgSgW1WIvczeawaHJdV2x+1aS1tUfbKCUlyntMzQ1V
         MeAM9pcwD3q1sm0I1t6z2gqtdJh4NByfaeVKco1wBBe6SBBRkwz6BcaW2Se3ze4vDx
         Rzoy0FGELELo7l4is6iU16oTcke8pYE3s+NdMK/E=
Date:   Tue, 29 Nov 2022 09:12:45 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhou, Jie2X" <jie2x.zhou@intel.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: fw_fallback.sh test failed in Debian 11
Message-ID: <Y4W+/TfM4F9TdSnZ@kroah.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 29, 2022 at 02:35:12AM +0000, Zhou, Jie2X wrote:
> hi,
> 
> fw_fallback.sh test failed.
> The error may caused by failed to write /sys/devices/virtual/misc/test_firmware/trigger_request.

Are you sure you have the proper kernel code loaded with the test
firmware code that creates this sysfs file?  Without that, this test
will not work.

thanks,

greg k-h
