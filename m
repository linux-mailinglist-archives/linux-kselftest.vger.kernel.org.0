Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411173576F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 14:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjFSM6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjFSM6U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 08:58:20 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C091AC
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jun 2023 05:58:19 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63008f9293dso20933436d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jun 2023 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687179498; x=1689771498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EN8SHZPulgVB2NMCjQeN+NgcQzF+fy6eDxvPwaTnFU=;
        b=Dl0Yh3odU6Ibx3U0XI9gO01djO1boB8jD1cQR3R0NpzgPt5gPq9kihHCbswEzs3OYd
         03r5QSYG+lxEISoM2jRdnzGNx9ob6uaG61rTYKda/EyDE5OUeALFKJyKE6aRxEmqtMuT
         yq9zqGabHHd4TXbED/HDtpcORbbbp3Jla0hLbgo8RA4FwWaZ9I4u+bK3oDmxUf3qw4SE
         /6tHL/coP/TP6wYqZrSg+2tLJEV0+DPKoZNSpJOXcv047B3EDisC0wKL9JIHNiPJ4PL9
         fp3Es3PjT7hGqIIjPXQNJdzxvl5kP/uIXH9m3OZQg3WwYAGRQMJnyegfrhfSeGfNrXx4
         RuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179498; x=1689771498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EN8SHZPulgVB2NMCjQeN+NgcQzF+fy6eDxvPwaTnFU=;
        b=lzreaJ0sWUDlAJmoPRnhkpKjY3jTZGIKT3cXXdG1RsDn/xcYrrsduK4YsFM91hqsyW
         uGqilgvS7xLVXajbHa05ZMOVj37Pfmi4jVLpkT6x/2vRyqKcsHiXH5626S8eYZB1a2pd
         +7VFTU2d/4yFcWZbggdUybNtp4RsawiAU8NPBt9YOJDrGOWvbD9RL0cEv/3BShWSGPZr
         ReLQUD0ynI3HFZobnnRMl534oXfaqPPPc+gi1FH0Gqm3yzfKOfkcQh3GZJLnwXfwdAik
         oUnwUT52VdP4LtWJyCARWCEZeCKYqtgcLSNFuHT6T3QT5rzPiaCLbpponsZ3DARbgHLA
         X4Zg==
X-Gm-Message-State: AC+VfDzV5Q0E9X1CO5U262mmLs6pzbos8dAdWI4e8NiYWNZ6jGodZ1Zs
        5aSyc/bzljILkIswwzswJuvwOg==
X-Google-Smtp-Source: ACHHUZ7aEQ33ZOLHiW7qLtXGbpVR5w4OkoPZd7ZxPgLEVetaPWz6ZAVebnx2vcET93MTDfFQnhj3cw==
X-Received: by 2002:ad4:5cc8:0:b0:62f:fb4b:e28f with SMTP id iu8-20020ad45cc8000000b0062ffb4be28fmr12415239qvb.31.1687179498427;
        Mon, 19 Jun 2023 05:58:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id l5-20020a0ce085000000b0062439f05b87sm10534957qvk.45.2023.06.19.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:58:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qBESX-006pH5-Bv;
        Mon, 19 Jun 2023 09:58:17 -0300
Date:   Mon, 19 Jun 2023 09:58:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJBQ6Qeg+C5wkhmw@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <20230616113232.GA84678@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616113232.GA84678@myrica>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 16, 2023 at 12:32:32PM +0100, Jean-Philippe Brucker wrote:

> We might need to revisit supporting stop markers: request that each device
> driver declares whether their device uses stop markers on unbind() ("This
> mechanism must indicate that a Stop Marker Message will be generated."
> says the spec, but doesn't say if the function always uses one or the
> other mechanism so it's per-unbind). Then we still have to synchronize
> unbind() with the fault handler to deal with the pending stop marker,
> which might have already gone through or be generated later.

An explicit API to wait for the stop marker makes sense, with the
expectation that well behaved devices will generate it and well
behaved drivers will wait for it.

Things like VFIO should have a way to barrier/drain the PRI queue
after issuing FLR. ie the VMM processing FLR should also barrier the
real HW queues and flush them to VM visibility.

> with stop markers, the host needs to flush the PRI queue when a PASID is
> detached. I guess on Intel detaching the PASID goes through the host which
> can flush the host queue. On Arm we'll probably need to flush the queue
> when receiving a PASID cache invalidation, which the guest issues after
> clearing a PASID table entry.

We are trying to get ARM to a point where invalidations don't need to
be trapped. It would be good to not rely on that anyplace.

Jason
