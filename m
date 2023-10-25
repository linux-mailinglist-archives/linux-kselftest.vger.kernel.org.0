Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1B7D6BC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjJYMcy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjJYMcy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 08:32:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32FA129;
        Wed, 25 Oct 2023 05:32:49 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 203A466057B6;
        Wed, 25 Oct 2023 13:32:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698237168;
        bh=/4dXk3Un/vaxtCsUQZxzPGs3gNA8QPr1cZShAvmvMvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpzRZNViuoPfy7pkhZLcZ03fqKpTu+dsSqM9MQFDtpjGQyMoOn9XNNgSR3yW5xeWJ
         VvlYQx4lfunbCLN45YIQDePd+aSfBWTbuBFCgsLnlpQH+Uy78/j1kxgfk1z725LrXb
         zgVxxfEFsTnBRas8zpPnoKMfD0DRYx3zER6C640CW1xL+u3fhUc9YVVKByT0f86vf1
         KsAjoZLnve4eBIv3pf2AEwtWdVKg8KrnBklzts0mBAmsLo3XncB2sMQsD8b7NQHDg2
         Nns0czgK5QvlF3sugJbQDTG6WRr5aiyVDlxMSADoR5BJRCsWimtLRr32Y5pxtMBOhI
         AgKvgG2i7zuKQ==
Date:   Wed, 25 Oct 2023 08:32:42 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kselftest: devices: Add board file for
 google,spherion
Message-ID: <e49c63c4-2b24-4428-801c-1f854a98c593@notapiano>
References: <20231024211818.365844-1-nfraprado@collabora.com>
 <20231024211818.365844-3-nfraprado@collabora.com>
 <2023102546-filled-onboard-3dfb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023102546-filled-onboard-3dfb@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 25, 2023 at 12:32:15PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 24, 2023 at 05:18:00PM -0400, Nícolas F. R. A. Prado wrote:
> > Add the list of devices expected to be probed from the USB and PCI
> > busses on the google,spherion machine. The USB host controller at
> > 11200000 is shared between two busses, for USB2 and USB3, so an
> > additional match is used to select the USB2 bus.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> >  tools/testing/selftests/devices/boards/google,spherion | 3 +++
> >  1 file changed, 3 insertions(+)
> >  create mode 100644 tools/testing/selftests/devices/boards/google,spherion
> > 
> > diff --git a/tools/testing/selftests/devices/boards/google,spherion b/tools/testing/selftests/devices/boards/google,spherion
> > new file mode 100644
> > index 000000000000..ba86ffcfe43c
> > --- /dev/null
> > +++ b/tools/testing/selftests/devices/boards/google,spherion
> > @@ -0,0 +1,3 @@
> > +usb camera 11200000,PRODUCT=.*/2/.* 1.4.1 1 0,1
> > +usb bluetooth 11200000,PRODUCT=.*/2/.* 1.4.2 1 0,1
> > +pci wifi 11230000 0.0/0.0
> 
> USB busses (and PCI ids) are not determinisitic and can, and will,
> change values randomly.  So while it is nice to test "did the devices
> show up properly", you can not do that based on bus ids at all, sorry.
> 
> Unless I'm reading these values wrong?  What are the fields
> representing?  Perhaps a comment at the top to describe them so that we
> know how to parse them?

Hi Greg,

I have described the fields in the commit message of patch 1. Here they are:

usb <test_name> <controller_address>[,<additional_match>] <ports_path> <configuration> <interfaces>

pci <test_name> <controller_address> <device-function_pairs_path>

I'm aware that bus IDs are assigned at runtime, and that's exactly why I've
avoided those in the test definitions, instead describing the hardware topology,
which won't ever change.

And just to be extra clear, by hardware topology I mean:

For USB, we find the USB bus based on the address of its controller (and
optionally its productID if two busses share the same controller for USB2 and
USB3), and then find the device by following the ports at each hub. The
configuration number and interfaces then describe what interfaces to check for
presence and driver binding.

For PCI, we find the controller again based on its address, and follow the
device-function pairs at each level in the topology until we arrive at the
desired device.

We don't rely on the USB bus number, nor on the PCI domain and bus number, since
these are all assigned at runtime.

Thanks,
Nícolas
