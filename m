Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFB715288
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjE3ARi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 20:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE3ARh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 20:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9ED9
        for <linux-kselftest@vger.kernel.org>; Mon, 29 May 2023 17:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685405809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBl3q2i812Jlu/HY8zePZKnZZJeg4miQ7XeIUUOuIUs=;
        b=EC8IjAlaEJeGBXv9msEe2PdkvOHjVXRikyqJlItGhZoe36YjqmxzdlK8Xusjb+bAPiqU1d
        Pd9R5CwwQwv14isZMokhEHJtOQjvrhAPxvS1sHuCbIeSEv2NQf3GNmqS4NICocYOWj0MWH
        gtau7H3FlWceDAlkbuGcACATVJVvFhI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-SiEXZEtGMB2A_uegZ8il2g-1; Mon, 29 May 2023 20:16:47 -0400
X-MC-Unique: SiEXZEtGMB2A_uegZ8il2g-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33b4cbdd21aso22877895ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 May 2023 17:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685405807; x=1687997807;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBl3q2i812Jlu/HY8zePZKnZZJeg4miQ7XeIUUOuIUs=;
        b=iq4A0lzODNdLBSsd2bB5G4FDYmhTBPjaNmnW4Hr9RiHWKGAPzbvQxFb9J0aD1S1m5p
         cJOCd/rT25B72PxgVK/2TvN+D4ouMxq5msiJANqlEZlrpA5+r8IY6CaqKEQooaYKpOxc
         aNp1Ivg8HSLNlgMAJlDXf4oMXB7bZs6wUAkAuHD4bIHAaxpxt4vQfVv4estQ031pD1/g
         NTk/0p8VLQ96Q4JiUzBcWMbr1S7Ibe7Zny7+Rm06g2G3vwLv/J+yRYd8/IFWAds0n6Pc
         II/FX6zwWPNSGZ97qxHgHq3fCEe1sPScNx7sVDcW+NwoA8m+/0mmUS9p0w8oqq4NzINL
         7J5A==
X-Gm-Message-State: AC+VfDzE+SYtLbChZhliod+L2GkkIhsuRnXkbgtrWrevb9ieQvhbm7ch
        yFpO2+Y2TVjYctBaM6doR+wQ/wWCJoOPwLExOGCGJDFgwSJOAXnEcqh0Re7yXsnMYev2dv3gIQv
        4YHzZGNvh1Cp/v1qUCKm+WWZLvHT8
X-Received: by 2002:a92:dcc1:0:b0:328:8770:b9c2 with SMTP id b1-20020a92dcc1000000b003288770b9c2mr507362ilr.14.1685405807097;
        Mon, 29 May 2023 17:16:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73yMhHh+AVUWd+tWnEm39ZtbwzqfO2AHakkj3n4fptb2pthTIWuj5Tj1tTy9hAry5+QAej4w==
X-Received: by 2002:a92:dcc1:0:b0:328:8770:b9c2 with SMTP id b1-20020a92dcc1000000b003288770b9c2mr507347ilr.14.1685405806881;
        Mon, 29 May 2023 17:16:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d6-20020a926806000000b003248469e5easm590655ilc.43.2023.05.29.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 17:16:46 -0700 (PDT)
Date:   Mon, 29 May 2023 18:16:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 00/10] Add Intel VT-d nested translation
Message-ID: <20230529181644.3a6a5c7b.alex.williamson@redhat.com>
In-Reply-To: <ZHTyNgnjj/bOkIgi@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
        <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZHTyNgnjj/bOkIgi@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 May 2023 15:43:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 24, 2023 at 08:59:43AM +0000, Tian, Kevin wrote:
> 
> > At least this looks a reasonable tradeoff to some proprietary VMMs
> > which never adds RO mappings in stage-2 today.  
> 
> What is the reason for the RO anyhow?
> 
> Would it be so bad if it was DMA mapped as RW due to the errata?

What if it's the zero page?  Thanks,

Alex

