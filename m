Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD173DBC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjFZJv7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFZJv6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 05:51:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B99D9
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 02:51:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69a48368fso18562321fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687773110; x=1690365110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ggM1N3+w7ImiNtAZHXArGd84Z6U6HJ8t/slQ492qkA=;
        b=FqHsMQ5vsBUDTg8Qu45FvgnX3xqTLM97k8uX6dT/yu2Eb3hdcwpsoETC22q1iX2xjI
         fdRw4/PINKAYt0ptvLnXp8jq3UXTYTqk2hePWziqEWMDUpQ9ZL94UKNH5uYuleyzC/E0
         WQ4YJVsU1d9unRENNAHKCjlXBr24hGZ1ZgGFMvJcHD0JDn0611kKx0hHNFhKOXALI+go
         iEdWMF5DbOsUA476EvEUvA6sEu+NtNHD+XLeq4+UAwclbBkkMCW2fX8wi5gShPXUTayH
         iShaJjMDyqVrAsSbcbwWrtHlvR3MkGOf7N5/MZguV3gX8fs9AFBigPXxMjNo8xmmIux4
         pfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687773110; x=1690365110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ggM1N3+w7ImiNtAZHXArGd84Z6U6HJ8t/slQ492qkA=;
        b=aRpqLtN0DE7Jif83Dr0yrKG7jYBrofHFpFinb0t2XjVT4s4VEE/hjx0w+cuTSFa1fW
         2wnIgbkinRnjh41PgT8oXTQZIauPw+caHIjVA/GjWDyqdE3k9IkOnOsmCTQcotf0o9NX
         /3Sg+l/s1dhIAWv1uuaDFueihzKpufBZbylZoHSwpTZsuIiqv58rEh4dc2G8pccOv2vZ
         jGCNgYazHSHIQ+lO8TJD5v9cWGfDYXExTlpxkXW4FKA/8M7169ik5PMtBcb5ivBA9iDk
         7U9wqaNwjpfhNd0tBrf7hfFN15vyTk4OECB8q3oCdHUqkIsW/c5F7+0ZOcpatq3Gk88X
         E4KQ==
X-Gm-Message-State: AC+VfDxzWAhmsMHvyVaFmi8tkZoFcAvrRUxjxikAW6VG0r0jC7dkPQeV
        JN8SB1nyZ5HKD0itFJSezCsccA==
X-Google-Smtp-Source: ACHHUZ6z1CFWIkB585T4AsGvxgWrYm0aA3bqu065Ypw3q/WfLWUkxYhOjK8FkfMVQVPSogtwBbHaIQ==
X-Received: by 2002:a2e:948b:0:b0:2b4:491d:8d53 with SMTP id c11-20020a2e948b000000b002b4491d8d53mr17150106ljh.45.1687773110465;
        Mon, 26 Jun 2023 02:51:50 -0700 (PDT)
Received: from larix ([2a02:8428:1671:f801:5eff:2156:7b9f:50c2])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b00307a86a4bcesm6879642wrz.35.2023.06.26.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 02:51:50 -0700 (PDT)
Date:   Mon, 26 Jun 2023 11:51:48 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Message-ID: <ZJlftJF9ufnBMjHi@larix>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <20230616113232.GA84678@myrica>
 <bc963573-f4d3-1467-daaf-2d85f6befe3f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc963573-f4d3-1467-daaf-2d85f6befe3f@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 19, 2023 at 11:35:50AM +0800, Baolu Lu wrote:
> > Another outstanding issue was what to do for PASID stop. When the guest
> > device driver stops using a PASID it issues a PASID stop request to the
> > device (a device-specific mechanism). If the device is not using PRI stop
> > markers it waits for pending PRs to complete and we're fine. Otherwise it
> > sends a stop marker which is flushed to the PRI queue, but does not wait
> > for pending PRs.
> > 
> > Handling stop markers is annoying. If the device issues one, then the PRI
> > queue contains stale faults, a stop marker, followed by valid faults for
> > the next address space bound to this PASID. The next address space will
> > get all the spurious faults because the fault handler doesn't know that
> > there is a stop marker coming. Linux is probably alright with spurious
> > faults, though maybe not in all cases, and other guests may not support
> > them at all.
> > 
> > We might need to revisit supporting stop markers: request that each device
> > driver declares whether their device uses stop markers on unbind() ("This
> > mechanism must indicate that a Stop Marker Message will be generated."
> > says the spec, but doesn't say if the function always uses one or the
> > other mechanism so it's per-unbind). Then we still have to synchronize
> > unbind() with the fault handler to deal with the pending stop marker,
> > which might have already gone through or be generated later.
> 
> I don't quite follow here. Once a PASID is unbound from the device, the
> device driver should be free to release the PASID. The PASID could then
> be used for any other purpose. The device driver has no idea when the
> pending page requests are flushed after unbind(), so it cannot decide
> how long should the PASID be delayed for reuse. Therefore, I understand
> that a successful return from the unbind() function denotes that all
> pending page requests have been flushed and the PASID is viable for
> other use.

Yes that's the contract for unbind() at the moment

> 
> > 
> > Currently we ignore all that and just flush the PRI queue, followed by the
> > IOPF queue, to get rid of any stale fault before reassigning the PASID. A
> > guest however would also need to first flush the HW PRI queue, but doesn't
> > have a direct way to do that. If we want to support guests that don't deal
> > with stop markers, the host needs to flush the PRI queue when a PASID is
> > detached. I guess on Intel detaching the PASID goes through the host which
> > can flush the host queue. On Arm we'll probably need to flush the queue
> > when receiving a PASID cache invalidation, which the guest issues after
> > clearing a PASID table entry.
> 
> The Intel VT-d driver follows below steps to drain pending page requests
> when a PASID is unbound from a device.
> 
> - Tear down the device's pasid table entry for the stopped pasid.
>   This ensures that ATS/PRI will stop putting more page requests for the
>   pasid in VT-d PRQ.

Oh that's interesting, I didn't know about the implicit TLB invalidations
on page requests for VT-d.

For Arm SMMU, clearing the PASID table entry does cause ATS Translation
Requests to return with Completer Abort, but does not affect PRI. The SMMU
pushes page requests directly into the PRI queue without reading any table
(unless the queue overflows).

We're counting on the device driver to perform the PASID stop request
before calling unbind(), described in PCIe 6.20.1 (Managing PASID Usage)
and 10.4.1.2 (Managing PASID Usage on PRG Requests). This ensures that
when unbind() is called, no more page request for the PASID is pushed into
the PRI queue. But some may still be in the queue if the device uses stop
markers.

> - Sync with the PRQ handling thread until all related page requests in
>   PRQ have been delivered.

This is what I'm concerned about. For VT-d this happens in the host which
is in charge of modifying the PASID table. For SMMU, the guest writes the
PASID table. It flushes its virtual PRI queue, but not the physical queue
that is managed by the host.

One synchronization point where the host could flush the physical PRI
queue is the PASID config invalidation (CMD_CFGI_CD). As Jason pointed out
the host may not be able to observe those if a command queue is assigned
directly to the guest (a theoretical SMMU extension), though in that case
the guest may also have direct access to a PRI queue (like the AMD vIOMMU
extension) and be able to flush the queue directly.

But we can just wait for PRI implementations and see what the drivers
need. Maybe no device will implement stop markers.

Thanks,
Jean

> - Flush the iopf queue with iopf_queue_flush_dev().
> - Follow the steps defined in VT-d spec section 7.10 to drain all page
>   requests and responses between VT-d and the endpoint device.
