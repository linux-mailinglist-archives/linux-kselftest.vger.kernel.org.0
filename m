Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4261A629208
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 07:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiKOGyv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 01:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKOGyt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 01:54:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774211FCD0;
        Mon, 14 Nov 2022 22:54:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12D06B810A6;
        Tue, 15 Nov 2022 06:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A637C433C1;
        Tue, 15 Nov 2022 06:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668495285;
        bh=7gXVLaF9SSgC1CVVSNKfs3pYMC81qxttPJW460I86pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8GUcOUellK3E28KqMU1eAVS2Qj2DJSrL1X4iRw8+7YWh2RpphygW3Tf1ybRcu5LZ
         MneV7abAgvMbDUPErdVvvkGX15GQ0nCcRNUn6lOuDenyZlmxSemprt9A/ud1vQinbX
         EGHkYA3hJfvMngFPoHBHCk6hzYqrzZpI02GHmvhA=
Date:   Tue, 15 Nov 2022 07:54:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y3M3sZSARXxLTKao@kroah.com>
References: <Y3L2Jx3Kx9q8Dv55@ziqianlu-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3L2Jx3Kx9q8Dv55@ziqianlu-desk1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 15, 2022 at 10:15:03AM +0800, Aaron Lu wrote:
> I came to the conclusion that this work is OK to submit with all of the
> steps I listed above (copyright notices, license terms and relicensing)
> by strictly following all of the processes required by my employer.
> 
> This does not include a Signed-off-by from a corporate attorney.

Please get that, as that is what I asked for in order for us to be able
to accept this type of change.

thanks,

greg k-h
