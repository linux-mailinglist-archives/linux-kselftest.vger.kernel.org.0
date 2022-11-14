Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A996628AD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiKNUwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 15:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiKNUwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 15:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300EB15706
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668459066;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/YJv37yRjo5ACwfT3yKKFW4DrSCcOFuv19x/jgkIVU=;
        b=HRkuPQdxcRnbxB3k5hDfFggoGJ1cbI+3CGSkciAatDqAiQ5ZjY6YyJRCithxaEcpJqXwb9
        v7Dt63lxn0UFUnzEmdO3xJ9m/lCgDcPOg2Eoodt1EKDOk5PcAKmsLHkf+u5ns3SI9Qtyaa
        KD7w1NDcKmnw8AtFXo/vxN3p1YHHCbI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-JTpDIIkgMUihVVmcVK018Q-1; Mon, 14 Nov 2022 15:51:05 -0500
X-MC-Unique: JTpDIIkgMUihVVmcVK018Q-1
Received: by mail-qv1-f69.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so9197263qva.10
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 12:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/YJv37yRjo5ACwfT3yKKFW4DrSCcOFuv19x/jgkIVU=;
        b=f6g23llo743rmg77M067GnoUDTzCrih6PxY9FZwLNgzfwFLWzXUko73EwQdmAv8AXK
         z82g4eUFaNdn4DL+Yi+W8NuhSKDwWOj2j2454QxEUhPIwt3CY+3TZ0tlZ4swvb6bUJO/
         liOUvvvxbhrBvXduP94tzsRQ5OsxXUgjKmRDC2UAt63wdztOmHyilGGU2b3ZJmxlTbk9
         u9bh/FEMkPW+AV7biNG5wvyth5FGbx8AUH2jTPWoFogtztD4gZZvSU5NITMRPXrCFaa1
         y2NJvf4mgSStNuVPpxfy7esdv4U7Ik7spPpN9BEn3dBaxVg1V+SJuafi2cW4zaSo4+tx
         YJVg==
X-Gm-Message-State: ANoB5pmHkQbPPQFxp2kjLAfC7c+Vjp9VW5t4JGrosJoAk3tBu6mPkmg2
        bzPAX701Wwxt+RGDO3/Mw9pJ2tL9iqP+mvJxaBp44G+sMqQlZT8mm1vMwufSjX1y70gXN4r+rV+
        LYBNw8ZZCWhikMx6UE+/H4jPmZVKB
X-Received: by 2002:a05:6214:a61:b0:4b3:e0de:6e5a with SMTP id ef1-20020a0562140a6100b004b3e0de6e5amr14028201qvb.116.1668459064501;
        Mon, 14 Nov 2022 12:51:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6e/azmbTdK1OZ72h1IOmU0Jo9tESYe18+hG5xNlVI0FhpCldoqcYsaU9R/8EmzpWv/XeDHpA==
X-Received: by 2002:a05:6214:a61:b0:4b3:e0de:6e5a with SMTP id ef1-20020a0562140a6100b004b3e0de6e5amr14028162qvb.116.1668459064104;
        Mon, 14 Nov 2022 12:51:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b0039d02911555sm6108783qtp.78.2022.11.14.12.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 12:51:03 -0800 (PST)
Message-ID: <eef35bbc-f977-3e0d-60ac-5b0a0a30894f@redhat.com>
Date:   Mon, 14 Nov 2022 21:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 11/8/22 01:48, Jason Gunthorpe wrote:
> From: Kevin Tian <kevin.tian@intel.com>
>
> Add iommufd into the documentation tree, and supply initial documentation.
> Much of this is linked from code comments by kdoc.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/userspace-api/index.rst   |   1 +
>  Documentation/userspace-api/iommufd.rst | 222 ++++++++++++++++++++++++
>  2 files changed, 223 insertions(+)
>  create mode 100644 Documentation/userspace-api/iommufd.rst
>
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index c78da9ce0ec44e..f16337bdb8520f 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -25,6 +25,7 @@ place where this information is gathered.
>     ebpf/index
>     ioctl/index
>     iommu
> +   iommufd
>     media/index
>     netlink/index
>     sysfs-platform_profile
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> new file mode 100644
> index 00000000000000..64a135f3055adc
> --- /dev/null
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -0,0 +1,222 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +=======
> +IOMMUFD
> +=======
> +
> +:Author: Jason Gunthorpe
> +:Author: Kevin Tian
> +
> +Overview
> +========
> +
> +IOMMUFD is the user API to control the IOMMU subsystem as it relates to managing
> +IO page tables from userspace using file descriptors. It intends to be general
> +and consumable by any driver that wants to expose DMA to userspace. These
> +drivers are eventually expected to deprecate any internal IOMMU logic if exists
they may already/historically implement (eg. vfio_iommu_type1.c)?
> +(e.g. vfio_iommu_type1.c).
> +
> +At minimum iommufd provides universal support of managing I/O address spaces and
> +I/O page tables for all IOMMUs, with room in the design to add non-generic
> +features to cater to specific hardware functionality.
> +
> +In this context the capital letter (IOMMUFD) refers to the subsystem while the
> +small letter (iommufd) refers to the file descriptors created via /dev/iommu for
> +use by userspace.
> +
> +Key Concepts
> +============
> +
> +User Visible Objects
> +--------------------
> +
> +Following IOMMUFD objects are exposed to userspace:
> +
> +- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS), allowing map/unmap
> +  of user space memory into ranges of I/O Virtual Address (IOVA).
> +
> +  The IOAS is a functional replacement for the VFIO container, and like the VFIO
> +  container it copies an IOVA map to a list of iommu_domains held within it.
> +
> +- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by an
> +  external driver.
> +
> +- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page table
> +  (i.e. a single struct iommu_domain) managed by the iommu driver.
> +
> +  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping and
> +  it will synchronize its mapping with each member HW_PAGETABLE.
> +
> +All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
> +
> +The diagram below shows relationship between user-visible objects and kernel
> +datastructures (external to iommufd), with numbers referred to operations
> +creating the objects and links::
> +
> +  _________________________________________________________
> + |                         iommufd                         |
> + |       [1]                                               |
> + |  _________________                                      |
> + | |                 |                                     |
> + | |                 |                                     |
> + | |                 |                                     |
> + | |                 |                                     |
> + | |                 |                                     |
> + | |                 |                                     |
> + | |                 |        [3]                 [2]      |
> + | |                 |    ____________         __________  |
> + | |      IOAS       |<--|            |<------|          | |
> + | |                 |   |HW_PAGETABLE|       |  DEVICE  | |
> + | |                 |   |____________|       |__________| |
> + | |                 |         |                   |       |
> + | |                 |         |                   |       |
> + | |                 |         |                   |       |
> + | |                 |         |                   |       |
> + | |                 |         |                   |       |
> + | |_________________|         |                   |       |
> + |         |                   |                   |       |
> + |_________|___________________|___________________|_______|
> +           |                   |                   |
> +           |              _____v______      _______v_____
> +           | PFN storage |            |    |             |
> +           |------------>|iommu_domain|    |struct device|
> +                         |____________|    |_____________|
> +
> +1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
> +   hold multiple IOAS objects. IOAS is the most generic object and does not
> +   expose interfaces that are specific to single IOMMU drivers. All operations
> +   on the IOAS must operate equally on each of the iommu_domains inside of it.
> +
> +2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMUFD kAPI
> +   to bind a device to an iommufd. The driver is expected to implement proper a
s/proper/properly?
> +   set of ioctls to allow userspace to initiate the binding operation.
> +   Successful completion of this operation establishes the desired DMA ownership
> +   over the device. The driver must also set the driver_managed_dma flag and
> +   must not touch the device until this operation succeeds.
> +
> +3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the IOMMUFD
> +   kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
> +   allows userspace to initiate the attaching operation. If a compatible
> +   pagetable already exists then it is reused for the attachment. Otherwise a
> +   new pagetable object and iommu_domain is created. Successful completion of
> +   this operation sets up the linkages among IOAS, device and iommu_domain. Once
> +   this completes the device could do DMA.
> +
> +   Every iommu_domain inside the IOAS is also represented to userspace as a
> +   HW_PAGETABLE object.
> +
> +   .. note::
> +
> +      Future IOMMUFD updates will provide an API to create and manipulate the
> +      HW_PAGETABLE directly.
> +
> +A device can only bind to an iommufd due to DMA ownership claim and attach to at
> +most one IOAS object (no support of PASID yet).
> +
> +Currently only PCI device is allowed to use IOMMUFD.
is it still true? device_bind() now takes a struct device *

In [PATCH v4 12/17] iommufd: Add kAPI toward external drivers for
physical devices "PCI" is used at several places
but shouldn't it be removed now?

> +
> +Kernel Datastructure
> +--------------------
> +
> +User visible objects are backed by following datastructures:
> +
> +- iommufd_ioas for IOMMUFD_OBJ_IOAS.
> +- iommufd_device for IOMMUFD_OBJ_DEVICE.
> +- iommufd_hw_pagetable for IOMMUFD_OBJ_HW_PAGETABLE.
> +
> +Several terminologies when looking at these datastructures:
> +
> +- Automatic domain - refers to an iommu domain created automatically when
> +  attaching a device to an IOAS object. This is compatible to the semantics of
> +  VFIO type1.
> +
> +- Manual domain - refers to an iommu domain designated by the user as the
> +  target pagetable to be attached to by a device. Though currently there are
> +  no uAPIs to directly create such domain, the datastructure and algorithms
> +  are ready for handling that use case.
> +
> +- In-kernel user - refers to something like a VFIO mdev that is using the
> +  IOMMUFD access interface to access the IOAS. This starts by creating an
> +  iommufd_access object that is similar to the domain binding a physical device
> +  would do. The access object will then allow converting IOVA ranges into struct
> +  page * lists, or doing direct read/write to an IOVA.
> +
> +iommufd_ioas serves as the metadata datastructure to manage how IOVA ranges are
> +mapped to memory pages, composed of:
> +
> +- struct io_pagetable holding the IOVA map
> +- struct iopt_areas representing populated portions of IOVA
> +- struct iopt_pages representing the storage of PFNs
> +- struct iommu_domain representing the IO page table in the IOMMU
> +- struct iopt_pages_access representing in-kernel users of PFNs
> +- struct xarray pinned_pfns holding a list of pages pinned by in-kernel users
> +
> +Each iopt_pages represents a logical linear array of full PFNs. The PFNs are
> +ultimately derived from userspave VAs via an mm_struct. Once they have been
> +pinned the PFN is stored in IOPTEs of an iommu_domain or inside the pinned_pages
s/is/are
> +xarray if they have been pinned through an iommufd_access.
> +
> +PFN have to be copied between all combinations of storage locations, depending
> +on what domains are present and what kinds of in-kernel "software access" users
> +exists. The mechanism ensures that a page is pinned only once.
> +
> +An io_pagetable is composed of iopt_areas pointing at iopt_pages, along with a
> +list of iommu_domains that mirror the IOVA to PFN map.
> +
> +Multiple io_pagetable-s, through their iopt_area-s, can share a single
> +iopt_pages which avoids multi-pinning and double accounting of page
> +consumption.
> +
> +iommufd_ioas is sharable between subsystems, e.g. VFIO and VDPA, as long as
> +devices managed by different subsystems are bound to a same iommufd.
> +
> +IOMMUFD User API
> +================
> +
> +.. kernel-doc:: include/uapi/linux/iommufd.h
> +
> +IOMMUFD Kernel API
> +==================
> +
> +The IOMMUFD kAPI is device-centric with group-related tricks managed behind the
> +scene. This allows the external drivers calling such kAPI to implement a simple
> +device-centric uAPI for connecting its device to an iommufd, instead of
> +explicitly imposing the group semantics in its uAPI as VFIO does.
> +
> +.. kernel-doc:: drivers/iommu/iommufd/device.c
> +   :export:
> +
> +VFIO and IOMMUFD
> +----------------
> +
> +Connecting a VFIO device to iommufd can be done in two ways.
> +
> +First is a VFIO compatible way by directly implementing the /dev/vfio/vfio
> +container IOCTLs by mapping them into io_pagetable operations. Doing so allows
> +the use of iommufd in legacy VFIO applications by symlinking /dev/vfio/vfio to
> +/dev/iommufd or extending VFIO to SET_CONTAINER using an iommufd instead of a
> +container fd.
> +
> +The second approach directly extends VFIO to support a new set of device-centric
> +user API based on aforementioned IOMMUFD kernel API. It requires userspace
> +change but better matches the IOMMUFD API semantics and easier to support new
> +iommufd features when comparing it to the first approach.
> +
> +Currently both approaches are still work-in-progress.
> +
> +There are still a few gaps to be resolved to catch up with VFIO type1, as
> +documented in iommufd_vfio_check_extension().
> +
> +Future TODOs
> +============
> +
> +Currently IOMMUFD supports only kernel-managed I/O page table, similar to VFIO
> +type1. New features on the radar include:
> +
> + - Binding iommu_domain's to PASID/SSID
> + - Userspace page tables, for ARM, x86 and S390
> + - Kernel bypass'd invalidation of user page tables
> + - Re-use of the KVM page table in the IOMMU
> + - Dirty page tracking in the IOMMU
> + - Runtime Increase/Decrease of IOPTE size
> + - PRI support with faults resolved in userspace
Thanks

Eric

