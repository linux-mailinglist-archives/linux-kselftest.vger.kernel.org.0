Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27E43981
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfFMPON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:14:13 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43622 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbfFMNaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 09:30:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id t2so8319598ywe.10
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gpC/BcbJqZm/b199OKanFtWwuFNfn3Nh4TAP7OeO2NA=;
        b=BXofh382FGQ6XKPL2MfgAofF8BQm+/tgz4ml76l/iJkrG2E/+Dn2CcsfgfbiuEU3tj
         RuZDqTsDzm6ObH1XEtafWfBUf0me0bv7ELlRK/EDgBLTTgGPCN72PLbTY5I64v8joDPd
         vxEGj4K1laNQ4h//KZVXnpwBplBXDchGCJsiGY/LoSNyOPFsqamliqkc/auc6LnvDP6z
         NdYHf9KnTMvUsC+0FFJCOuLumZOWQWWFFm7EjGvUO1RF3FRQHmeF81IER2zJvyqqJvVa
         tYxikwp4VS73sfIlUIcSULdSIFQqhVNuqn4zfVaeOca9Eh6qh4k1yBfMCKcYh7/N9fdC
         cPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gpC/BcbJqZm/b199OKanFtWwuFNfn3Nh4TAP7OeO2NA=;
        b=bywO+qrCtzpoZiYyMGFUwP3YmCBbJ9eu0m1SZCvXSpECyJDJpiMrwvfmjLo/9v6lJ1
         L1MhUFmj4M3GXIsqvA7TrSuUnrOU0tPu8+Mttf49N7+ekWDU13H2xRXLPKGDf19WlUwH
         WT2GMmNFxRiAGpO5pJMLBZkxKL/Nl5Rq0Qrx+Sz4iR58aEtolM50DdFUItzUm6dOh75M
         xpSRrlkrKLb2yNPhaKKofrHD1StiS5CBiBMOzYejyoeutCzGaVJlzDGAojw69ky7rWIX
         OspBKXB9MKSqvOj68nVhBguVVZmg+L2D917FlMyLHSg37zDe9fwXnNEpQLdz1a/0qrmw
         HVVA==
X-Gm-Message-State: APjAAAWuiH95lJMxbPN2LLFU7nIM2lAhkD0FflpS0mRKPgoFqof9RlxL
        rE7H3k8IeF4bfRJGy8qrFd6OQ5ZjWRHcRq0x
X-Google-Smtp-Source: APXvYqxTssA/J+9V16+D44hORYBVXWzyfYlD4b0eRTXEkb7pd189qJsIUW5hoWZ7PNVmk1rzS/3Kzg==
X-Received: by 2002:a0d:ea10:: with SMTP id t16mr32493125ywe.221.1560432617677;
        Thu, 13 Jun 2019 06:30:17 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id p12sm742658ywg.72.2019.06.13.06.30.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:30:17 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:30:15 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
Subject: Re: [PATCH v5 00/10]  Support using MSI interrupts in ntb_transport
Message-ID: <20190613133014.GE1572@kudzu.us>
References: <20190523223100.5526-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523223100.5526-1-logang@deltatee.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 04:30:50PM -0600, Logan Gunthorpe wrote:
> This is another resend as there has been no feedback since v4.
> Seems Jon has been MIA this past cycle so hopefully he appears on the
> list soon.
> 
> I've addressed the feedback so far and rebased on the latest kernel
> and would like this to be considered for merging this cycle.
> 
> The only outstanding issue I know of is that it still will not work
> with IDT hardware, but ntb_transport doesn't work with IDT hardware
> and there is still no sensible common infrastructure to support
> ntb_peer_mw_set_trans(). Thus, I decline to consider that complication
> in this patchset. However, I'll be happy to review work that adds this
> feature in the future.
> 
> Also, as the port number and resource index stuff is a bit complicated,
> I made a quick out of tree test fixture to ensure it's correct[1]. As
> an excerise I also wrote some test code[2] using the upcomming KUnit
> feature.

Sorry for the delay.  The patch is now in the ntb-next branch.  We've
missed window for 5.2, but it will be in the 5.3 pull request (barring
last minute comments).

Thanks,
Jon

> 
> Logan
> 
> [1] https://repl.it/repls/ExcitingPresentFile
> [2] https://github.com/sbates130272/linux-p2pmem/commits/ntb_kunit
> 
> --
> 
> Changes in v5:
> 
> * Rebased onto v5.2-rc1 (plus the patches in ntb-next)
> 
> --
> 
> Changes in v4:
> 
> * Rebased onto v5.1-rc6 (No changes)
> 
> * Numerous grammar and spelling mistakes spotted by Bjorn
> 
> --
> 
> Changes in v3:
> 
> * Rebased onto v5.1-rc1 (Dropped the first two patches as they have
>   been merged, and cleaned up some minor conflicts in the PCI tree)
> 
> * Added a new patch (#3) to calculate logical port numbers that
>   are port numbers from 0 to (number of ports - 1). This is
>   then used in ntb_peer_resource_idx() to fix the issues brought
>   up by Serge.
> 
> * Fixed missing __iomem and iowrite calls (as noticed by Serge)
> 
> * Added patch 10 which describes ntb_msi_test in the documentation
>   file (as requested by Serge)
> 
> * A couple other minor nits and documentation fixes
> 
> --
> 
> Changes in v2:
> 
> * Cleaned up the changes in intel_irq_remapping.c to make them
>   less confusing and add a comment. (Per discussion with Jacob and
>   Joerg)
> 
> * Fixed a nit from Bjorn and collected his Ack
> 
> * Added a Kconfig dependancy on CONFIG_PCI_MSI for CONFIG_NTB_MSI
>   as the Kbuild robot hit a random config that didn't build
>   without it.
> 
> * Worked in a callback for when the MSI descriptor changes so that
>   the clients can resend the new address and data values to the peer.
>   On my test system this was never necessary, but there may be
>   other platforms where this can occur. I tested this by hacking
>   in a path to rewrite the MSI descriptor when I change the cpu
>   affinity of an IRQ. There's a bit of uncertainty over the latency
>   of the change, but without hardware this can acctually occur on
>   we can't test this. This was the result of a discussion with Dave.
> 
> --
> 
> This patch series adds optional support for using MSI interrupts instead
> of NTB doorbells in ntb_transport. This is desirable seeing doorbells on
> current hardware are quite slow and therefore switching to MSI interrupts
> provides a significant performance gain. On switchtec hardware, a simple
> apples-to-apples comparison shows ntb_netdev/iperf numbers going from
> 3.88Gb/s to 14.1Gb/s when switching to MSI interrupts.
> 
> To do this, a couple changes are required outside of the NTB tree:
> 
> 1) The IOMMU must know to accept MSI requests from aliased bused numbers
> seeing NTB hardware typically sends proxied request IDs through
> additional requester IDs. The first patch in this series adds support
> for the Intel IOMMU. A quirk to add these aliases for switchtec hardware
> was already accepted. See commit ad281ecf1c7d ("PCI: Add DMA alias quirk
> for Microsemi Switchtec NTB") for a description of NTB proxy IDs and why
> this is necessary.
> 
> 2) NTB transport (and other clients) may often need more MSI interrupts
> than the NTB hardware actually advertises support for. However, seeing
> these interrupts will not be triggered by the hardware but through an
> NTB memory window, the hardware does not actually need support or need
> to know about them. Therefore we add the concept of Virtual MSI
> interrupts which are allocated just like any other MSI interrupt but
> are not programmed into the hardware's MSI table. This is done in
> Patch 2 and then made use of in Patch 3.
> 
> The remaining patches in this series add a library for dealing with MSI
> interrupts, a test client and finally support in ntb_transport.
> 
> The series is based off of v5.1-rc6 plus the patches in ntb-next.
> A git repo is available here:
> 
> https://github.com/sbates130272/linux-p2pmem/ ntb_transport_msi_v4
> 
> Thanks,
> 
> Logan
> 
> --
> 
> Logan Gunthorpe (10):
>   PCI/MSI: Support allocating virtual MSI interrupts
>   PCI/switchtec: Add module parameter to request more interrupts
>   NTB: Introduce helper functions to calculate logical port number
>   NTB: Introduce functions to calculate multi-port resource index
>   NTB: Rename ntb.c to support multiple source files in the module
>   NTB: Introduce MSI library
>   NTB: Introduce NTB MSI Test Client
>   NTB: Add ntb_msi_test support to ntb_test
>   NTB: Add MSI interrupt support to ntb_transport
>   NTB: Describe the ntb_msi_test client in the documentation.
> 
>  Documentation/ntb.txt                   |  27 ++
>  drivers/ntb/Kconfig                     |  11 +
>  drivers/ntb/Makefile                    |   3 +
>  drivers/ntb/{ntb.c => core.c}           |   0
>  drivers/ntb/msi.c                       | 415 +++++++++++++++++++++++
>  drivers/ntb/ntb_transport.c             | 169 ++++++++-
>  drivers/ntb/test/Kconfig                |   9 +
>  drivers/ntb/test/Makefile               |   1 +
>  drivers/ntb/test/ntb_msi_test.c         | 433 ++++++++++++++++++++++++
>  drivers/pci/msi.c                       |  54 ++-
>  drivers/pci/switch/switchtec.c          |  12 +-
>  include/linux/msi.h                     |   8 +
>  include/linux/ntb.h                     | 196 ++++++++++-
>  include/linux/pci.h                     |   9 +
>  tools/testing/selftests/ntb/ntb_test.sh |  54 ++-
>  15 files changed, 1386 insertions(+), 15 deletions(-)
>  rename drivers/ntb/{ntb.c => core.c} (100%)
>  create mode 100644 drivers/ntb/msi.c
>  create mode 100644 drivers/ntb/test/ntb_msi_test.c
> 
> --
> 2.20.1
