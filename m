Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C987DA1C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjJ0Ub1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 16:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0Ub0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 16:31:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC351AA;
        Fri, 27 Oct 2023 13:31:23 -0700 (PDT)
Received: from notapiano (unknown [146.70.117.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B25C6607388;
        Fri, 27 Oct 2023 21:31:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698438682;
        bh=x04e49XZ44kUWKuvH7Agm9r97YLxKz5Y0a4BLiq+mII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9r/VZO6NQCPNxFyaLFikbz8AbFVuTfxtMxI80nrDSuc2KZhvF9y/pVLrVqdyzFIL
         GnW26iZP32/7z+TCAsxX61tKhT2f7bDFcDbwcsS/b4Wp0BuodS8Ih6H3axTmZSBTNe
         DgvyFkYKKRgv/jARoP2D5Aml+n7B2+tkp4D2NE/hcb3VZGJYyZV8u4W5pgK9PB7ysw
         /36S2QwKgwJOiNXTpHBa2Z6twuIWs3/eFWCxOUPtox06CMbN3YR2AU+I3o5iMlSCiH
         /oyIkCLK0YAagsOkHoNPsrmTb8t3QKNxARhfCMtKnVD1bKHZidV4AWkmEG9M0wOWWN
         zFvFvp+WTHWvA==
Date:   Fri, 27 Oct 2023 16:31:13 -0400
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
Message-ID: <3bcd3794-cd19-4772-8da2-772821a756b5@notapiano>
References: <20231024211818.365844-1-nfraprado@collabora.com>
 <20231024211818.365844-3-nfraprado@collabora.com>
 <2023102546-filled-onboard-3dfb@gregkh>
 <e49c63c4-2b24-4428-801c-1f854a98c593@notapiano>
 <2023102747-conclude-backside-a579@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023102747-conclude-backside-a579@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023 at 12:48:35PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 25, 2023 at 08:32:42AM -0400, Nícolas F. R. A. Prado wrote:
> > On Wed, Oct 25, 2023 at 12:32:15PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 24, 2023 at 05:18:00PM -0400, Nícolas F. R. A. Prado wrote:
> > > > Add the list of devices expected to be probed from the USB and PCI
> > > > busses on the google,spherion machine. The USB host controller at
> > > > 11200000 is shared between two busses, for USB2 and USB3, so an
> > > > additional match is used to select the USB2 bus.
> > > > 
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > > 
> > > >  tools/testing/selftests/devices/boards/google,spherion | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/devices/boards/google,spherion
> > > > 
> > > > diff --git a/tools/testing/selftests/devices/boards/google,spherion b/tools/testing/selftests/devices/boards/google,spherion
> > > > new file mode 100644
> > > > index 000000000000..ba86ffcfe43c
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/devices/boards/google,spherion
> > > > @@ -0,0 +1,3 @@
> > > > +usb camera 11200000,PRODUCT=.*/2/.* 1.4.1 1 0,1
> > > > +usb bluetooth 11200000,PRODUCT=.*/2/.* 1.4.2 1 0,1
> > > > +pci wifi 11230000 0.0/0.0
> > > 
> > > USB busses (and PCI ids) are not determinisitic and can, and will,
> > > change values randomly.  So while it is nice to test "did the devices
> > > show up properly", you can not do that based on bus ids at all, sorry.
> > > 
> > > Unless I'm reading these values wrong?  What are the fields
> > > representing?  Perhaps a comment at the top to describe them so that we
> > > know how to parse them?
> > 
> > Hi Greg,
> > 
> > I have described the fields in the commit message of patch 1. Here they are:
> > 
> > usb <test_name> <controller_address>[,<additional_match>] <ports_path> <configuration> <interfaces>
> > 
> > pci <test_name> <controller_address> <device-function_pairs_path>
> 
> That's not a good place to document them, we'll never find them, and I
> obviously missed it as well.
> 
> Please put it in a comment at the top of this file _AND_ in a comment in
> the script that parses these files.

Fair enough, will do so in the next version.

> 
> > I'm aware that bus IDs are assigned at runtime, and that's exactly why I've
> > avoided those in the test definitions, instead describing the hardware topology,
> > which won't ever change.
> > 
> > And just to be extra clear, by hardware topology I mean:
> > 
> > For USB, we find the USB bus based on the address of its controller (and
> > optionally its productID if two busses share the same controller for USB2 and
> > USB3),
> 
> What exactly do you mean by "address" of a controller?  That will be
> unique per bus-type that the controller lives on, right?

Well, in its current form the test is targetted at DT-based platforms, so by
address I mean the MMIO address of the host controller, as defined in the
controller's node in the DT.

In order to expand the coverage of the test to non-DT platforms as well, yes,
we'll need to allow describing controllers that are under some bus, rather than
at a fixed memory address. I'm already planning to do that as a next step.

> 
> > and then find the device by following the ports at each hub. The
> > configuration number and interfaces then describe what interfaces to check for
> > presence and driver binding.
> 
> Ok, good, hub and port locations _should_ be stable, but note they have
> changed at times so you will have to deal with that for the next 20+
> years, are you ok with that?

If the locations changed it means we have a new hardware revision. I'd expect
most of those occurences to result in new compatible strings or DMI identifiers,
which we could then use to run a different set of tests, using the new hub and
port locations, since this is effectively a different piece of hardware.

> 
> > For PCI, we find the controller again based on its address, and follow the
> > device-function pairs at each level in the topology until we arrive at the
> > desired device.
> 
> "address"?  What exactly do you mean by this value?  For PCI, that will
> change.

Same as for USB.

> 
> > We don't rely on the USB bus number, nor on the PCI domain and bus number, since
> > these are all assigned at runtime.
> 
> You are relying on a specific sysfs tree as well, are you able to handle
> it when new devices get added to the middle of a device path?  That
> sometimes happens in sysfs too.

Right, I'm relying on the fact that the PCI topology is reflected into the sysfs
topology, meaning the sysfs directories for devices on a PCI bus are direct
descendants of the directory for the PCI bridge exposing that bus. That's the
only place I'm aware of which exposes the PCI topology.

In any case, although simplistic, this approach has worked well so far on the
platforms I've tested on.

Thanks,
Nícolas
