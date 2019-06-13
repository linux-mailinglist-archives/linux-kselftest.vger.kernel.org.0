Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E777F43E08
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbfFMPrA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:47:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55788 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389461AbfFMPrA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 11:47:00 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hbRwA-0008JX-LL; Thu, 13 Jun 2019 09:46:51 -0600
To:     Jon Mason <jdmason@kudzu.us>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190523223100.5526-1-logang@deltatee.com>
 <20190613133014.GE1572@kudzu.us>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <985a41a9-80c2-7b60-da98-4ea92085319b@deltatee.com>
Date:   Thu, 13 Jun 2019 09:46:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613133014.GE1572@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: epilmore@gigaio.com, fancer.lancer@gmail.com, dave.jiang@intel.com, allenbh@gmail.com, bhelgaas@google.com, joro@8bytes.org, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, jdmason@kudzu.us
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v5 00/10] Support using MSI interrupts in ntb_transport
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2019-06-13 7:30 a.m., Jon Mason wrote:
> On Thu, May 23, 2019 at 04:30:50PM -0600, Logan Gunthorpe wrote:
>> This is another resend as there has been no feedback since v4.
>> Seems Jon has been MIA this past cycle so hopefully he appears on the
>> list soon.
>>
>> I've addressed the feedback so far and rebased on the latest kernel
>> and would like this to be considered for merging this cycle.
>>
>> The only outstanding issue I know of is that it still will not work
>> with IDT hardware, but ntb_transport doesn't work with IDT hardware
>> and there is still no sensible common infrastructure to support
>> ntb_peer_mw_set_trans(). Thus, I decline to consider that complication
>> in this patchset. However, I'll be happy to review work that adds this
>> feature in the future.
>>
>> Also, as the port number and resource index stuff is a bit complicated,
>> I made a quick out of tree test fixture to ensure it's correct[1]. As
>> an excerise I also wrote some test code[2] using the upcomming KUnit
>> feature.
> 
> Sorry for the delay.  The patch is now in the ntb-next branch.  We've
> missed window for 5.2, but it will be in the 5.3 pull request (barring
> last minute comments).

Thanks Jon!

Logan
