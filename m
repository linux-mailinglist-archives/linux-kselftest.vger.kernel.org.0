Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1127B0C37
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI0SxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 14:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SxT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 14:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F8E6
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695840757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kq5Qg2bQQlEqkI6mgl+PBDF3TD7HEyYrhhIx1gLZrcg=;
        b=eDWnEDa08UjIOp072Z8kURuihNsmqYZ8UqlfdWSQ29/LgaLhrWmOcC1me+u8LjgM3iSqbo
        uuutoHa32iKKhuRHTf5Ack4SZiFk4Uv27WNJZoAoGKKj5+L8PO0NZQnrxQPUhp4m3s0RbM
        2SKJfthpPr0WNoowvK3N8HAXug4ym/w=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-SFNpSrepMP2aq2gqpPqLlg-1; Wed, 27 Sep 2023 14:52:35 -0400
X-MC-Unique: SFNpSrepMP2aq2gqpPqLlg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57be2b0e95cso11236685eaf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 11:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695840755; x=1696445555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq5Qg2bQQlEqkI6mgl+PBDF3TD7HEyYrhhIx1gLZrcg=;
        b=C1bNLVbQvm4sOEdGkoU6Wp+5FYGwvPbhCqDBZzfxH8Rri9xQ+Y3VFJ28PSZhlRBCk9
         Cf3ICzwWw9/FwX0+IGn38DHYllyADJkLf3K+jmEc0RS6wyvpdlUpH9TZKPTmTRusRC+k
         Oa3LA4QC4hcGHnUvOAP5EkpomE/NptfuUHU7IN5klytyK/6wsjhgiUn87EORWu5e4Jbw
         wZ0XTRmPEI3JvbBs3qYbEOYvGpnsENpWJJMhAj5DyUSrO3sLg7vh43HVwpdlj1vm4Ns+
         aEDmW8dxrwfrGikVtX26AQK3T5Uwex4kEz/ZuRM8FgBVqPWMAQsdsbnfnGu2A2N0dFh2
         Qtcg==
X-Gm-Message-State: AOJu0Yyo0UQ3Rmdf+N36t6R4Z4GiTpDxr83XJqk1IYuMca2/NKWjfofB
        6ckkz5AeBqxaHbmHZAhjvafWaArqwLooIBJUkT0GU+JGi5XpWKnZuNfXYO2UDHVzY7dNm5RW61q
        LL1CtKBum5kyyV+SZulld9GGg9ZGL
X-Received: by 2002:a4a:6246:0:b0:57b:6a40:8a9e with SMTP id y6-20020a4a6246000000b0057b6a408a9emr3241149oog.7.1695840755193;
        Wed, 27 Sep 2023 11:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3cPePjgR+735wrJbNOWlgYYeVheIM5ALo2dqBObMKFrQpCrxuu4qqIaRtOinyevyLL0/Zfw==
X-Received: by 2002:a4a:6246:0:b0:57b:6a40:8a9e with SMTP id y6-20020a4a6246000000b0057b6a408a9emr3241122oog.7.1695840754919;
        Wed, 27 Sep 2023 11:52:34 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id p187-20020a4a48c4000000b0054f85f67f31sm2878334ooa.46.2023.09.27.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:52:34 -0700 (PDT)
Date:   Wed, 27 Sep 2023 12:52:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [RFC 3/3] vfio/pci: Expose PCIe PASID capability to userspace
Message-ID: <20230927125231.3aacde62.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276375C4BE33AC0632321A68CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926093121.18676-1-yi.l.liu@intel.com>
        <20230926093121.18676-4-yi.l.liu@intel.com>
        <BN9PR11MB5276375C4BE33AC0632321A68CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Sep 2023 08:07:54 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Tuesday, September 26, 2023 5:31 PM
> > 
> > This exposes PCIe PASID capability to userspace and where to emulate this
> > capability if wants to further expose it to VM.
> > 
> > And this only exposes PASID capability for devices which has PCIe PASID
> > extended struture in its configuration space. While for VFs, userspace
> > is still unable to see this capability as SR-IOV spec forbides VF to
> > implement PASID capability extended structure. It is a TODO in future.
> > Related discussion can be found in below links:
> > 
> > https://lore.kernel.org/kvm/20200407095801.648b1371@w520.home/
> > https://lore.kernel.org/kvm/BL1PR11MB5271A60035EF591A5BE8AC878C01A
> > @BL1PR11MB5271.namprd11.prod.outlook.com/
> >   
> 
> Yes, we need a decision for VF case.
> 
> If the consensus is to continue exposing the PASID capability in vfio-pci
> config space by developing a kernel quirk mechanism to find offset for
> VF, then this patch for PF is orthogonal to that VF work and can go as it is.
> 
> But if the decision is to have a device feature for the user to enumerate
> the vPASID capability and let the VMM take care of finding the vPASID
> cap offset, then better we start doing that for PF too since it's not good
> to have two enumeration interfaces for PF/VF respectively.

Note also that QEMU implements a lazy algorithm for exposing
capabilities, the default is to expose them, so we need to consider
existing VMs seeing a new read-only PASID capability on an assigned PF.

That might support an alternate means to expose the capability.

> My preference is via device feature given Qemu already includes lots of
> quirks for vfio-pci devices. Another reason is that when supporting vPASID
> with SIOV there are some arch constraints which the driver needs to
> report to the user to follow (e.g.  don't assign ENQCMD-capable sibling
> vdev's to a same guest, etc.).

?!

> A device feature interface can better
> encapsulate everything related to vPASID in one place.

Sorry if I don't remember, have you posted a proposal for the device
feature interface?  Thanks,

Alex

