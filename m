Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F60732FE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 13:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFPLce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFPLcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 07:32:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1092713
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 04:32:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f642a24568so745309e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686915151; x=1689507151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nuyRQlcqUJ1I+sHmU3UQhaVpsWzNHbMeXA40SLBfto=;
        b=DH5R7s1yTiVsAJI1g99s6OalFVFW9cM5DAnNDqJJfwlRotOUA96IF3DT5skABPinz5
         E4IcsKOQ3I0Rl1kStGkLFAxRCwwg624eQLqtopcQdxXR3xBLUA2PpbggQ7ZzEgEqRcbe
         zLF4TFVCygtMwuugGFfMrYnwW9LYL8yD4irsAG/DyJmz0CufETPyYE1jSdmH8wJwQ6tx
         vSjOiWjZxCKLbz+1fw0d11obwbqVVFSHTsLjqc7E95c4rZrMb4MBr8n0fUJ+UFj2gDls
         a5bE+ElDJi7ADNbMc9uGiuwj+Q1wcaJHUu12vHRDhSs8Nb7M2gleCC8WcLdhD9mV7s2o
         YiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686915151; x=1689507151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nuyRQlcqUJ1I+sHmU3UQhaVpsWzNHbMeXA40SLBfto=;
        b=CCgUIj28y0vT5REj1JOQG+eWrzt6DRIokoiGtPre8RjYlzhHW6O5JgbhxdY/IdcMMS
         eVZokX4+cF1dxpfUqXh4xf/tZGDjoHtOUvHIQqgvThDCidBT7i21+Z3QCdcfE5dhFeMo
         deCwH8CO7DsXSC8/PzH3rqCtuUNKiJQ64jgOjygRQPwJz727r97Wt7xhUUNCsDyqDs4l
         Luqc9ZwOU89+65agELz05srKa0EWeXwhOkvOTme3l15OIRFoY05Re+pqshAHy9BzUVkk
         lvYd2cQ5qXa9X/jnaUjIXa9aqinCHkkqilMlY6V+1fcp0gPRDhqRxcD4Ep4YkWElT4yv
         uqxg==
X-Gm-Message-State: AC+VfDzQVzlm6iNxWAolghG1BEQ2q5kbuDxm4GSFy9In0912spHT6ufC
        E07VYf9JqQDeqniCiInCZv9E2w==
X-Google-Smtp-Source: ACHHUZ4vwQur9icwi+r14RxKea4abemDipKgtryepasg7loeFJIpKxEcaQTsVhSGPpckiB9/VJ/YOA==
X-Received: by 2002:a19:4409:0:b0:4f3:b07e:7eb8 with SMTP id r9-20020a194409000000b004f3b07e7eb8mr1138136lfa.29.1686915150597;
        Fri, 16 Jun 2023 04:32:30 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003f8126bcf34sm1879491wmc.48.2023.06.16.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:32:29 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:32:32 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20230616113232.GA84678@myrica>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Baolu,

On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
> - The timeout value for the pending page fault messages. Ideally we
>   should determine the timeout value from the device configuration, but
>   I failed to find any statement in the PCI specification (version 6.x).
>   A default 100 milliseconds is selected in the implementation, but it
>   leave the room for grow the code for per-device setting.

If it helps we had some discussions about this timeout [1]. It's useful to
print out a warning for debugging, but I don't think completing the fault
on timeout is correct, we should leave the fault pending. Given that the
PCI spec does not indicate a timeout, the guest can wait as long as it
wants to complete the fault (and 100ms may even be reasonable on an
emulator, who knows how many layers and context switches the fault has to
go through).


Another outstanding issue was what to do for PASID stop. When the guest
device driver stops using a PASID it issues a PASID stop request to the
device (a device-specific mechanism). If the device is not using PRI stop
markers it waits for pending PRs to complete and we're fine. Otherwise it
sends a stop marker which is flushed to the PRI queue, but does not wait
for pending PRs.

Handling stop markers is annoying. If the device issues one, then the PRI
queue contains stale faults, a stop marker, followed by valid faults for
the next address space bound to this PASID. The next address space will
get all the spurious faults because the fault handler doesn't know that
there is a stop marker coming. Linux is probably alright with spurious
faults, though maybe not in all cases, and other guests may not support
them at all.

We might need to revisit supporting stop markers: request that each device
driver declares whether their device uses stop markers on unbind() ("This
mechanism must indicate that a Stop Marker Message will be generated."
says the spec, but doesn't say if the function always uses one or the
other mechanism so it's per-unbind). Then we still have to synchronize
unbind() with the fault handler to deal with the pending stop marker,
which might have already gone through or be generated later.

Currently we ignore all that and just flush the PRI queue, followed by the
IOPF queue, to get rid of any stale fault before reassigning the PASID. A
guest however would also need to first flush the HW PRI queue, but doesn't
have a direct way to do that. If we want to support guests that don't deal
with stop markers, the host needs to flush the PRI queue when a PASID is
detached. I guess on Intel detaching the PASID goes through the host which
can flush the host queue. On Arm we'll probably need to flush the queue
when receiving a PASID cache invalidation, which the guest issues after
clearing a PASID table entry.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20180423153622.GC38106@ostrya.localdomain/
    Also unregistration, not sure if relevant here
    https://lore.kernel.org/linux-iommu/20190605154553.0d00ad8d@jacob-builder/
