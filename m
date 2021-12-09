Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C8846EE64
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbhLIRAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 12:00:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:27927 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241588AbhLIQ7v (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 11:59:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="236887011"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="236887011"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:55:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="564887994"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:55:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvMgS-004Arq-7Q;
        Thu, 09 Dec 2021 18:54:16 +0200
Date:   Thu, 9 Dec 2021 18:54:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        bhelgaas@google.com, srinivas.pandruvada@intel.com,
        shuah@kernel.org, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbI0t2D5ute46Ty2@smile.fi.intel.com>
References: <YbBxPPPaQwlcgz/c@kroah.com>
 <20211209163245.GA245119@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209163245.GA245119@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 09, 2021 at 10:32:45AM -0600, Bjorn Helgaas wrote:
> [+cc Rafael, since I used generic PM as an example]
> On Wed, Dec 08, 2021 at 09:47:56AM +0100, Greg KH wrote:

...

Okay, more bikeshedding :-)

> In the very common situation of PCI drivers that use generic power
> management, authors *do* have to use both (example from [1]):
> 
>   ioh_gpio_probe(struct pci_dev *pdev)   # pci_driver.probe()
>     pci_set_drvdata(pdev, chip);
> 
>   ioh_gpio_remove(struct pci_dev *pdev)  # pci_driver.remove()
>     struct ioh_gpio *chip = pci_get_drvdata(pdev);
> 
>   ioh_gpio_suspend(struct device *dev)   # pci_driver.driver.pm.suspend()
>     struct ioh_gpio *chip = dev_get_drvdata(dev);   <--
> 
> The pci_driver methods receive a struct pci_dev and use the
> pci_get_drvdata() wrapper.
> 
> The generic power management methods receive a struct device and use
> the underlying dev_get_drvdata().
> 
> It's kind of ugly that readers have to know that pci_get_drvdata()
> gives you the same thing as dev_get_drvdata().
> 
> I guess the generic PM methods could do something like:
> 
>   pci_get_drvdata(to_pci_dev(dev));
> 
> but that seems a little bit circuitous.  It's slightly wordier, but I
> might prefer to just use this everywhere and skip the pci_* wrappers:
> 
>   dev_get_drvdata(&pdev->dev);

Strictly speaking the

   <$BUS)_get_drvdata(<$CONTAINER>) != dev_get_drvdata(dev)

it's completely up to the container handling code what to do.
In 99% (or 100%?) cases it's equal, but it's not obliged to be so.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpio-ml-ioh.c?id=v5.15#n505

-- 
With Best Regards,
Andy Shevchenko


