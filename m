Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0546846ED19
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhLIQgY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 11:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhLIQgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 11:36:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF305C061746;
        Thu,  9 Dec 2021 08:32:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07D43B8253D;
        Thu,  9 Dec 2021 16:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D9EC004DD;
        Thu,  9 Dec 2021 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639067566;
        bh=Hfp5b3v+XA/5IbK5LdC4TC8Lj3uCVLepSRSC6eo2XOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BD7+YWxCPnrx0AevCZXoBB0cD13QqzwkZV3TzG/yNMIBNdKtBTvKPnGo6liXV6rBr
         Dk4mlyxC2FjLh2RTb90SjL7D5O4efldrfDOh2Hx6zOw/Muvmt6HCNKpY72FyxyRDoq
         uHEr+aLYBPf2PSVsG6CJ0bVnHkeDpzyi4svZNXZZI0lUjgMjOebtKkR83tV0z1g41U
         xMw+O4aj6ZsN9Y6yW/j7fi+YAJwG+59WG1hyXvCU0kT9WaUa+JjvkoBiHbCA59rNu8
         0VfayzowRRDBB7cr5Lu/Ll7nN4jYvc+pVyMn4IQ/wKMJH7iZl/D/MgzVprihiUDodK
         sjPemY3cJFpLA==
Date:   Thu, 9 Dec 2021 10:32:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <20211209163245.GA245119@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbBxPPPaQwlcgz/c@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[+cc Rafael, since I used generic PM as an example]

On Wed, Dec 08, 2021 at 09:47:56AM +0100, Greg KH wrote:
> On Wed, Dec 08, 2021 at 08:43:53AM +0000, Lee Jones wrote:
> > On Wed, 08 Dec 2021, Greg KH wrote:
> > > On Wed, Dec 08, 2021 at 09:03:16AM +0200, Leon Romanovsky wrote:
> > > > On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> > > > > Adds get/set driver data helpers for auxiliary devices.
> > > > > 
> > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > Reviewed-by: Mark Gross <markgross@kernel.org>
> > > > > ---
> > > > > V2
> > > > >   - No changes
> > > > > 
> > > > >  include/linux/auxiliary_bus.h | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > I would really like to see an explanation why such obfuscation is really
> > > > needed. dev_*_drvdata() is a standard way to access driver data.
> > 
> > I wouldn't call it obfuscation, but it does looks like abstraction for
> > the sake of abstraction, which I usually push back on.  What are the
> > technical benefits over using the dev_*() variant?
> 
> See my response at:
> 	https://lore.kernel.org/r/YbBwOb6JvWkT3JWI@kroah.com
> for why it is a good thing to do.
> 
> In short, driver authors should not have to worry about mixing
> bus-specific and low-level driver core functions.

In the very common situation of PCI drivers that use generic power
management, authors *do* have to use both (example from [1]):

  ioh_gpio_probe(struct pci_dev *pdev)   # pci_driver.probe()
    pci_set_drvdata(pdev, chip);

  ioh_gpio_remove(struct pci_dev *pdev)  # pci_driver.remove()
    struct ioh_gpio *chip = pci_get_drvdata(pdev);

  ioh_gpio_suspend(struct device *dev)   # pci_driver.driver.pm.suspend()
    struct ioh_gpio *chip = dev_get_drvdata(dev);   <--

The pci_driver methods receive a struct pci_dev and use the
pci_get_drvdata() wrapper.

The generic power management methods receive a struct device and use
the underlying dev_get_drvdata().

It's kind of ugly that readers have to know that pci_get_drvdata()
gives you the same thing as dev_get_drvdata().

I guess the generic PM methods could do something like:

  pci_get_drvdata(to_pci_dev(dev));

but that seems a little bit circuitous.  It's slightly wordier, but I
might prefer to just use this everywhere and skip the pci_* wrappers:

  dev_get_drvdata(&pdev->dev);

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpio-ml-ioh.c?id=v5.15#n505
