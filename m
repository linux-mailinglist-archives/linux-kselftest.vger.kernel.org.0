Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4D71727A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 02:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjEaAdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 20:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjEaAdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 20:33:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A211C
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 17:33:35 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f6b20ad49dso29027441cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685493214; x=1688085214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxfeX6CjU1T6VFT6WQGkkGRNUy8IJFRL+Q8oTwikiYE=;
        b=NSprOvANr8rmmNMRfGUGQhrlbjOY3VNneKCREemdYMFsq+wZseIXs4cVn2cfctqTC4
         l/Fex2UztpB64Sv6bVKzNW2Qn0dqqb5NbD1cJWjIOn75Zk0NXfpMON7ItM9ydFy5Ew5U
         s1hUijdnCq5qu7Zs5EJmJe13GN3xQ65TBxqudO3SU+vn3Sqj6RrsWVsk2oCYcnPG3p84
         jQDN28rHXrMKZ637sGrN6F/CCcU4XEcphoJElhcnaXxrFBaFj8p/dlxWO0sR9zCxF7Dn
         z3eQ+08mRG3B2cvqFNdTFZputqdjR8OXMmJun0qCmRxWBxzTeKu07oZNguwRyhjTnf+2
         ghdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493214; x=1688085214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxfeX6CjU1T6VFT6WQGkkGRNUy8IJFRL+Q8oTwikiYE=;
        b=bpjcXXsg7WwYJWjJBLBjgI4kL/5722H0gD7X0+01JMJPOBqM3vnv0KU38Ayy/S85+d
         zUGM192aqtaH0neKUwogBL1W/y64ArZl+hNTVY0wfEs+LV4Ew0hQQx4HX2NkEnNv9ONF
         2EK41SkitndM+nvT+uLVR5kZ4oBgQ0fq71/KXiDk49dg50ZjWk9Bhla9UyWQnnbTwt9u
         OUSleBJgURcvosyvIypR5lOcqce8KL+np8JnDanrRcYMWlW8zDIXp2AvK+2Q07NGwaJL
         G8ILmwxasSkS/O7sqpedFch7q3mu2pOQXSwHUVfd57GaVO1PEFRXKD3nHWIInPeJoGU1
         L+/g==
X-Gm-Message-State: AC+VfDwXri0i9wn4Knajjv8QeVjTYoG+46T/+6XMRiDOwy0Ftj+Rl2AC
        zUQZJ8FkiTEOI5dpdMmOmvByJQ==
X-Google-Smtp-Source: ACHHUZ76cGYRoxD2nR+OVC7+AsKBaaMRBv2OxrvCIPruwBslaqJO8TAA8q2yEjn3iVhl/m095jOZyA==
X-Received: by 2002:a05:622a:198f:b0:3f6:c52e:21bc with SMTP id u15-20020a05622a198f00b003f6c52e21bcmr4111272qtc.19.1685493214434;
        Tue, 30 May 2023 17:33:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id ff27-20020a05622a4d9b00b003f6bbd7863csm5256617qtb.86.2023.05.30.17.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:33:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q49mO-000kYe-OG;
        Tue, 30 May 2023 21:33:32 -0300
Date:   Tue, 30 May 2023 21:33:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZHaV3GwYXCvfNUBn@ziepe.ca>
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

On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. The use case is nested
> translation, where modern IOMMU hardware supports two-stage translation
> tables. The second-stage translation table is managed by the host VMM
> while the first-stage translation table is owned by the user space.
> Hence, any IO page fault that occurs on the first-stage page table
> should be delivered to the user space and handled there. The user space
> should respond the page fault handling result to the device top-down
> through the IOMMUFD response uAPI.
> 
> User space indicates its capablity of handling IO page faults by setting
> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
> will then setup its infrastructure for page fault delivery. Together
> with the iopf-capable flag, user space should also provide an eventfd
> where it will listen on any down-top page fault messages.
> 
> On a successful return of the allocation of iopf-capable HWPT, a fault
> fd will be returned. User space can open and read fault messages from it
> once the eventfd is signaled.

This is a performance path so we really need to think about this more,
polling on an eventfd and then reading a different fd is not a good
design.

What I would like is to have a design from the start that fits into
io_uring, so we can have pre-posted 'recvs' in io_uring that just get
completed at high speed when PRIs come in.

This suggests that the PRI should be delivered via read() on a single
FD and pollability on the single FD without any eventfd.

> Besides the overall design, I'd like to hear comments about below
> designs:
> 
> - The IOMMUFD fault message format. It is very similar to that in
>   uapi/linux/iommu which has been discussed before and partially used by
>   the IOMMU SVA implementation. I'd like to get more comments on the
>   format when it comes to IOMMUFD.

We have to have the same discussion as always, does a generic fault
message format make any sense here?

PRI seems more likely that it would but it needs a big carefull cross
vendor check out.

Jason
