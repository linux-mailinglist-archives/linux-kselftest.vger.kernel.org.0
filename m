Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3A7D6888
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjJYKcW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 06:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjJYKcV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 06:32:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D0DDD;
        Wed, 25 Oct 2023 03:32:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252C9C433C8;
        Wed, 25 Oct 2023 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698229938;
        bh=vNN9DPigqC+hKzjaSndwzdiygOwncYidnqYzky0PYe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylCHevjOJPafGi/0cIAeFWBGS0pKafnyfSo/rA83+IwKOaAvnjaB+G2BJpKSsRdOg
         VY//T1Nw02NxYhSpFdBoiq2OUZ0R2O2i1atUPPrM5fKqEoQOv+2OTZyeNqwyPyehVT
         hdMOP9w1IOfqJi/mhGZJzDtmaTAQdrcJgWUS8vR8=
Date:   Wed, 25 Oct 2023 12:32:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kselftest: devices: Add board file for
 google,spherion
Message-ID: <2023102546-filled-onboard-3dfb@gregkh>
References: <20231024211818.365844-1-nfraprado@collabora.com>
 <20231024211818.365844-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024211818.365844-3-nfraprado@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 05:18:00PM -0400, Nícolas F. R. A. Prado wrote:
> Add the list of devices expected to be probed from the USB and PCI
> busses on the google,spherion machine. The USB host controller at
> 11200000 is shared between two busses, for USB2 and USB3, so an
> additional match is used to select the USB2 bus.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  tools/testing/selftests/devices/boards/google,spherion | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 tools/testing/selftests/devices/boards/google,spherion
> 
> diff --git a/tools/testing/selftests/devices/boards/google,spherion b/tools/testing/selftests/devices/boards/google,spherion
> new file mode 100644
> index 000000000000..ba86ffcfe43c
> --- /dev/null
> +++ b/tools/testing/selftests/devices/boards/google,spherion
> @@ -0,0 +1,3 @@
> +usb camera 11200000,PRODUCT=.*/2/.* 1.4.1 1 0,1
> +usb bluetooth 11200000,PRODUCT=.*/2/.* 1.4.2 1 0,1
> +pci wifi 11230000 0.0/0.0

USB busses (and PCI ids) are not determinisitic and can, and will,
change values randomly.  So while it is nice to test "did the devices
show up properly", you can not do that based on bus ids at all, sorry.

Unless I'm reading these values wrong?  What are the fields
representing?  Perhaps a comment at the top to describe them so that we
know how to parse them?

thanks,

greg k-h
