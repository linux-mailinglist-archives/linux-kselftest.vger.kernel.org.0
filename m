Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2860DA35
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 06:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiJZERe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 00:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiJZERc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 00:17:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE7AACF57;
        Tue, 25 Oct 2022 21:17:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso1252971pjg.5;
        Tue, 25 Oct 2022 21:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NbVbw8xjX6wgDQBUiV1O2M4ZaYY37ZEyE6pB7Rl4lLY=;
        b=bUMV+pvXzXkMuWYXEKiFkpeqWpyA+QqbueE+T3REqYyCATIVCrA4ZpuQxhV9r3VQZR
         vE1Dal43oFw1I0i+tEYzZz2bqzhWaydshJZm6WFpvIWj1wSrGlza9pjb+0r9dKv5CqfK
         cXrhdUZuuPX51FUOkyoWQR1gsunJ8p3bnJqMmR6JAtGsWNAoAu6p7e434ib3TUDc31j1
         3icb24uZpZ+65AEkwaGJdLlhxUFdNXnYN5N06xvZ0KOvu6CzoZ+BSbvEcyrX0RUSRmcd
         MgqkTj5OCg8VAdmPg01SK3vnZUrI4/MZGiKyggfXRc1vLGkyJqY9Z5pAFa6E+csmhLvW
         72Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbVbw8xjX6wgDQBUiV1O2M4ZaYY37ZEyE6pB7Rl4lLY=;
        b=x0DNiDLwmi1W4vVc3IYCfl/Xh+GuhvbKA1giSF5WtSMyLytaqwT3+RFg1NIg7rmcrN
         xZSjvVtFNMe/OnO7svDOAxeKdWCTq7+dOLo+TUmIOvx9oZOh/vRNaElIaT99G016OOz7
         anVvLeftEudQd30+wqVxdRqC3R1OqOL0LbhehpQqTRBEdMjqdbpVAaw920CPa+ifYfdf
         4+/C1NAUsk4WMmy5MhQ/q4huGa6x++RS+bSjG/Z07G1Mu0r+QAOYwbwqofc6hByv3ZjO
         XXjk9/2oK3Vp2Svz39Mml8MyZsuNUwr+nTkPtbjSQY+Bb0dxwC8NcrretMyUaM8qxYZn
         eUhw==
X-Gm-Message-State: ACrzQf2FbgfhkjdGLi8L1/ERZmODiORC1ceXSgyq76gz/8t3N6+7Mjfi
        Dg4sI4s1sGuGyKLDLarsx8M=
X-Google-Smtp-Source: AMsMyM5N2OT1A5D0cECe0inPX5hJ6sPwNZyN7ri5i5NfkWoU8iYg2xMNsv5kL8oOs964fH9SF+yu1Q==
X-Received: by 2002:a17:902:8542:b0:179:eb8d:f41d with SMTP id d2-20020a170902854200b00179eb8df41dmr40859800plo.62.1666757849094;
        Tue, 25 Oct 2022 21:17:29 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7940b000000b0056be7ac5261sm2124098pfo.163.2022.10.25.21.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 21:17:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 90309100565; Wed, 26 Oct 2022 11:17:24 +0700 (WIB)
Date:   Wed, 26 Oct 2022 11:17:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v3 04/15] iommufd: Overview documentation
Message-ID: <Y1i01MA4hfAC6+QF@debian.me>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <4-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Satf9+G4bCrY7567"
Content-Disposition: inline
In-Reply-To: <4-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Satf9+G4bCrY7567
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 03:12:13PM -0300, Jason Gunthorpe wrote:
> From: Kevin Tian <kevin.tian@intel.com>
>=20
> Add iommufd to the documentation tree.
>=20

Better say "Document overview to iommufd".

> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/user=
space-api/iommufd.rst
> new file mode 100644
> index 00000000000000..3e1856469d96dd
> --- /dev/null
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -0,0 +1,222 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +=3D=3D=3D=3D=3D=3D=3D
> +IOMMUFD
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Jason Gunthorpe
> +:Author: Kevin Tian
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +IOMMUFD is the user API to control the IOMMU subsystem as it relates to =
managing
> +IO page tables that point at user space memory. It intends to be general=
 and
> +consumable by any driver that wants to DMA to userspace. These drivers a=
re
> +eventually expected to deprecate any internal IOMMU logic, if existing (=
e.g.
> +vfio_iommu_type1.c).
> +
> +At minimum iommufd provides a universal support of managing I/O address =
spaces
> +and I/O page tables for all IOMMUs, with room in the design to add non-g=
eneric
> +features to cater to specific hardware functionality.
> +
> +In this context the capital letter (IOMMUFD) refers to the subsystem whi=
le the
> +small letter (iommufd) refers to the file descriptors created via /dev/i=
ommu to
> +run the user API over.
> +
> +Key Concepts
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +User Visible Objects
> +--------------------
> +
> +Following IOMMUFD objects are exposed to userspace:
> +
> +- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS) allowing ma=
p/unmap
> +  of user space memory into ranges of I/O Virtual Address (IOVA).
> +
> +  The IOAS is a functional replacement for the VFIO container, and like =
the VFIO
> +  container copies its IOVA map to a list of iommu_domains held within i=
t.
> +
> +- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by =
an
> +  external driver.
> +
> +- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page tab=
le (i.e.
> +  a single struct iommu_domain) managed by the iommu driver.
> +
> +  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping =
and the
> +  IOAS will synchronize its mapping with each member HW_PAGETABLE.
> +
> +All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
> +
> +Linkage between user-visible objects and external kernel datastructures =
are
> +reflected by the arrows, with numbers referring to certain
> +operations creating the objects and links::
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
> +1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. One iommuf=
d can
> +   hold multiple IOAS objects. IOAS is the most generic object and does =
not
> +   expose interfaces that are specific to single IOMMU drivers. All oper=
ations
> +   on the IOAS must operate equally on each of the iommu_domains that ar=
e inside
> +   it.
> +
> +2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMU=
FD kAPI
> +   to bind a device to an iommufd. The external driver is expected to im=
plement
> +   proper uAPI for userspace to initiate the binding operation. Successf=
ul
> +   completion of this operation establishes the desired DMA ownership ov=
er the
> +   device. The external driver must set driver_managed_dma flag and must=
 not
> +   touch the device until this operation succeeds.
> +
> +3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the=
 IOMMUFD
> +   kAPI to attach a bound device to an IOAS. Similarly the external driv=
er uAPI
> +   allows userspace to initiate the attaching operation. If a compatible
> +   pagetable already exists then it is reused for the attachment. Otherw=
ise a
> +   new pagetable object (and a new iommu_domain) is created. Successful
> +   completion of this operation sets up the linkages among an IOAS, a de=
vice and
> +   an iommu_domain. Once this completes the device could do DMA.
> +
> +   Every iommu_domain inside the IOAS is also represented to userspace a=
s a
> +   HW_PAGETABLE object.
> +
> +   NOTE: Future additions to IOMMUFD will provide an API to create and
> +   manipulate the HW_PAGETABLE directly.
> +
> +One device can only bind to one iommufd (due to DMA ownership claim) and=
 attach
> +to at most one IOAS object (no support of PASID yet).
> +
> +Currently only PCI device is allowed.
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
> +- Automatic domain, referring to an iommu domain created automatically w=
hen
> +  attaching a device to an IOAS object. This is compatible to the semant=
ics of
> +  VFIO type1.
> +
> +- Manual domain, referring to an iommu domain designated by the user as =
the
> +  target pagetable to be attached to by a device. Though currently no us=
er API
> +  for userspace to directly create such domain, the datastructure and al=
gorithms
> +  are ready for that usage.
> +
> +- In-kernel user, referring to something like a VFIO mdev that is access=
ing the
> +  IOAS and using a 'struct page \*' for CPU based access. Such users req=
uire an
> +  isolation granularity smaller than what an iommu domain can afford. Th=
ey must
> +  manually enforce the IOAS constraints on DMA buffers before those buff=
ers can
> +  be accessed by mdev. Though no kernel API for an external driver to bi=
nd a
> +  mdev, the datastructure and algorithms are ready for such usage.
> +
> +iommufd_ioas serves as the metadata datastructure to manage how IOVA ran=
ges are
> +mapped to memory pages, composed of:
> +
> +- struct io_pagetable holding the IOVA map
> +- struct iopt_areas representing populated portions of IOVA
> +- struct iopt_pages representing the storage of PFNs
> +- struct iommu_domain representing the IO page table in the IOMMU
> +- struct iopt_pages_access representing in-kernel users of PFNs
> +- struct xarray pinned_pfns holding a list of pages pinned by
> +   in-kernel Users
> +
> +Each iopt_pages represents a logical linear array of full PFNs.  The PFN=
s are
> +ultimately derived from userspave VAs via an mm_struct. Once they have b=
een
> +pinned the PFN is stored in an iommu_domain's IOPTEs or inside the pinne=
d_pages
> +xarray if they are being "software accessed".
> +
> +PFN have to be copied between all combinations of storage locations, dep=
ending
> +on what domains are present and what kinds of in-kernel "software access=
" users
> +exists. The mechanism ensures that a page is pinned only once.
> +
> +An io_pagetable is composed of iopt_areas pointing at iopt_pages, along =
with a
> +list of iommu_domains that mirror the IOVA to PFN map.
> +
> +Multiple io_pagetable's, through their iopt_area's, can share a single
> +iopt_pages which avoids multi-pinning and double accounting of page cons=
umption.
> +
> +iommufd_ioas is sharable between subsystems, e.g. VFIO and VDPA, as long=
 as
> +devices managed by different subsystems are bound to a same iommufd.
> +
> +IOMMUFD User API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/uapi/linux/iommufd.h
> +
> +IOMMUFD Kernel API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The IOMMUFD kAPI is device-centric with group-related tricks managed beh=
ind the
> +scene. This allows the external driver calling such kAPI to implement a =
simple
> +device-centric uAPI for connecting its device to an iommufd, instead of
> +explicitly imposing the group semantics in its uAPI (as VFIO does).
> +
> +.. kernel-doc:: drivers/iommu/iommufd/device.c
> +   :export:
> +
> +VFIO and IOMMUFD
> +----------------
> +
> +Connecting a VFIO device to iommufd can be done in two approaches.
> +
> +First is a VFIO compatible way by directly implementing the /dev/vfio/vf=
io
> +container IOCTLs by mapping them into io_pagetable operations. Doing so =
allows
> +the use of iommufd in legacy VFIO applications by symlinking /dev/vfio/v=
fio to
> +/dev/iommufd or extending VFIO to SET_CONTAINER using an iommufd instead=
 of a
> +container fd.
> +
> +The second approach directly extends VFIO to support a new set of device=
-centric
> +user API based on aforementioned IOMMUFD kernel API. It requires userspa=
ce
> +change but better matches the IOMMUFD API semantics and easier to suppor=
t new
> +iommufd features when comparing it to the first approach.
> +
> +Currently both approaches are still work-in-progress.
> +
> +There are still a few gaps to be resolved to catch up with VFIO type1, as
> +documented in iommufd_vfio_check_extension().
> +
> +Future TODOs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Currently IOMMUFD supports only kernel-managed I/O page table, similar t=
o VFIO
> +type1. New features on the radar include:
> +
> + - Binding iommu_domain's to PASID/SSID
> + - Userspace page tables, for ARM, x86 and S390
> + - Kernel bypass'd invalidation of user page tables
> + - Re-use of the KVM page table in the IOMMU
> + - Dirty page tracking in the IOMMU
> + - Runtime Increase/Decrease of IOPTE size
> + - PRI support with faults resolved in userspace

What are "external driver"? Device drivers (most likely)? This is the
first time I hear the term.

What about this wordings below instead?

---- >8 ----

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/usersp=
ace-api/iommufd.rst
index 3e1856469d96dd..49fda5f706ff58 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -10,19 +10,19 @@ IOMMUFD
 Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
-IOMMUFD is the user API to control the IOMMU subsystem as it relates to ma=
naging
-IO page tables that point at user space memory. It intends to be general a=
nd
-consumable by any driver that wants to DMA to userspace. These drivers are
-eventually expected to deprecate any internal IOMMU logic, if existing (e.=
g.
+IOMMUFD is the user API to control the IOMMU subsystem as it relates to
+managing IO page tables using file descriptors. It intends to be general a=
nd
+consumable by any driver that wants to expose DMA to userspace. These driv=
ers
+are eventually expected to deprecate any internal IOMMU logic if exists (e=
=2Eg.
 vfio_iommu_type1.c).
=20
-At minimum iommufd provides a universal support of managing I/O address sp=
aces
+At minimum iommufd provides universal support of managing I/O address spac=
es
 and I/O page tables for all IOMMUs, with room in the design to add non-gen=
eric
 features to cater to specific hardware functionality.
=20
 In this context the capital letter (IOMMUFD) refers to the subsystem while=
 the
-small letter (iommufd) refers to the file descriptors created via /dev/iom=
mu to
-run the user API over.
+small letter (iommufd) refers to the file descriptors created via /dev/iom=
mu
+for use by uAPI.
=20
 Key Concepts
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -32,26 +32,26 @@ User Visible Objects
=20
 Following IOMMUFD objects are exposed to userspace:
=20
-- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS) allowing map/=
unmap
-  of user space memory into ranges of I/O Virtual Address (IOVA).
+- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS), allowing
+  map/unmap of user space memory into ranges of I/O Virtual Address (IOVA).
=20
-  The IOAS is a functional replacement for the VFIO container, and like th=
e VFIO
-  container copies its IOVA map to a list of iommu_domains held within it.
+  The IOAS is a functional replacement for the VFIO container, and like the
+  VFIO container it copies IOVA map to a list of iommu_domains held within=
 it.
=20
-- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by an
+- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by the
   external driver.
=20
-- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page table=
 (i.e.
-  a single struct iommu_domain) managed by the iommu driver.
+- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page table
+  (i.e. a single struct iommu_domain) managed by the iommu driver.
=20
-  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping an=
d the
-  IOAS will synchronize its mapping with each member HW_PAGETABLE.
+  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping and
+  it will synchronize its mapping with each member HW_PAGETABLE.
=20
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
=20
-Linkage between user-visible objects and external kernel datastructures are
-reflected by the arrows, with numbers referring to certain
-operations creating the objects and links::
+The diagram below shows relationship between user-visible objects and kern=
el
+datastructures (external to iommufd), with numbers referred to operations
+creating the objects and links::
=20
   _________________________________________________________
  |                         iommufd                         |
@@ -82,37 +82,38 @@ operations creating the objects and links::
            |------------>|iommu_domain|    |struct device|
                          |____________|    |_____________|
=20
-1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. One iommufd =
can
+1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. A iommufd can
    hold multiple IOAS objects. IOAS is the most generic object and does not
    expose interfaces that are specific to single IOMMU drivers. All operat=
ions
-   on the IOAS must operate equally on each of the iommu_domains that are =
inside
-   it.
+   on the IOAS must operate equally on each of the iommu_domains inside of=
 it.
=20
 2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMUFD=
 kAPI
-   to bind a device to an iommufd. The external driver is expected to impl=
ement
-   proper uAPI for userspace to initiate the binding operation. Successful
-   completion of this operation establishes the desired DMA ownership over=
 the
-   device. The external driver must set driver_managed_dma flag and must n=
ot
-   touch the device until this operation succeeds.
+   to bind a device to an iommufd. The driver is expected to implement
+   proper uAPI to initiate the binding operation. Successful completion of
+   this operation establishes the desired DMA ownership over the device. T=
he
+   driver must also set driver_managed_dma flag and must not touch the dev=
ice
+   until this operation succeeds.
=20
-3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the I=
OMMUFD
-   kAPI to attach a bound device to an IOAS. Similarly the external driver=
 uAPI
-   allows userspace to initiate the attaching operation. If a compatible
-   pagetable already exists then it is reused for the attachment. Otherwis=
e a
-   new pagetable object (and a new iommu_domain) is created. Successful
-   completion of this operation sets up the linkages among an IOAS, a devi=
ce and
-   an iommu_domain. Once this completes the device could do DMA.
+3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the
+   IOMMUFD kAPI to attach a bounded device to an IOAS. Similarly the exter=
nal
+   driver uAPI allows userspace to initiate the attaching operation. If a
+   compatible pagetable already exists then it is reused for the attachmen=
t.
+   Otherwise a new pagetable object and iommu_domain is created. Successful
+   completion of this operation sets up the linkages among IOAS, device and
+   iommu_domain. Once this completes the device could do DMA.
=20
    Every iommu_domain inside the IOAS is also represented to userspace as a
    HW_PAGETABLE object.
=20
-   NOTE: Future additions to IOMMUFD will provide an API to create and
-   manipulate the HW_PAGETABLE directly.
+   .. note::
=20
-One device can only bind to one iommufd (due to DMA ownership claim) and a=
ttach
+      Future IOMMUFD updates will provide an API to create and
+      manipulate the HW_PAGETABLE directly.
+
+A device can only bind to an iommufd due to DMA ownership claim and attach
 to at most one IOAS object (no support of PASID yet).
=20
-Currently only PCI device is allowed.
+Currently only PCI device is allowed to use IOMMUFD.
=20
 Kernel Datastructure
 --------------------
@@ -125,21 +126,21 @@ User visible objects are backed by following datastru=
ctures:
=20
 Several terminologies when looking at these datastructures:
=20
-- Automatic domain, referring to an iommu domain created automatically when
+- Automatic domain - refers to an iommu domain created automatically when
   attaching a device to an IOAS object. This is compatible to the semantic=
s of
   VFIO type1.
=20
-- Manual domain, referring to an iommu domain designated by the user as the
-  target pagetable to be attached to by a device. Though currently no user=
 API
-  for userspace to directly create such domain, the datastructure and algo=
rithms
-  are ready for that usage.
+- Manual domain - refers to an iommu domain designated by the user as the
+  target pagetable to be attached to by a device. Though currently there a=
re
+  no uAPIs to directly create such domain, the datastructure and algorithms
+  are ready for handling that use case.
=20
-- In-kernel user, referring to something like a VFIO mdev that is accessin=
g the
-  IOAS and using a 'struct page \*' for CPU based access. Such users requi=
re an
+- In-kernel user - refers to something like a VFIO mdev that is accessing =
the
+  IOAS and using a 'struct page \*' for CPU based access. Such users requi=
re
   isolation granularity smaller than what an iommu domain can afford. They=
 must
   manually enforce the IOAS constraints on DMA buffers before those buffer=
s can
-  be accessed by mdev. Though no kernel API for an external driver to bind=
 a
-  mdev, the datastructure and algorithms are ready for such usage.
+  be accessed by mdev. Although there are no kernel drivers APIs to bind a
+  mdev, the datastructure and algorithms are ready for handling that use c=
ase.
=20
 iommufd_ioas serves as the metadata datastructure to manage how IOVA range=
s are
 mapped to memory pages, composed of:
@@ -149,13 +150,12 @@ mapped to memory pages, composed of:
 - struct iopt_pages representing the storage of PFNs
 - struct iommu_domain representing the IO page table in the IOMMU
 - struct iopt_pages_access representing in-kernel users of PFNs
-- struct xarray pinned_pfns holding a list of pages pinned by
-   in-kernel Users
+- struct xarray pinned_pfns holding a list of pages pinned by in-kernel us=
ers
=20
-Each iopt_pages represents a logical linear array of full PFNs.  The PFNs =
are
+Each iopt_pages represents a logical linear array of full PFNs. The PFNs a=
re
 ultimately derived from userspave VAs via an mm_struct. Once they have been
-pinned the PFN is stored in an iommu_domain's IOPTEs or inside the pinned_=
pages
-xarray if they are being "software accessed".
+pinned the PFN is stored in IOPTEs of the iommu_domain or inside the
+pinned_pages xarray if they are being "software accessed".
=20
 PFN have to be copied between all combinations of storage locations, depen=
ding
 on what domains are present and what kinds of in-kernel "software access" =
users
@@ -164,8 +164,9 @@ exists. The mechanism ensures that a page is pinned onl=
y once.
 An io_pagetable is composed of iopt_areas pointing at iopt_pages, along wi=
th a
 list of iommu_domains that mirror the IOVA to PFN map.
=20
-Multiple io_pagetable's, through their iopt_area's, can share a single
-iopt_pages which avoids multi-pinning and double accounting of page consum=
ption.
+Multiple io_pagetable-s, through their iopt_area-s, can share a single
+iopt_pages which avoids multi-pinning and double accounting of page
+consumption.
=20
 iommufd_ioas is sharable between subsystems, e.g. VFIO and VDPA, as long as
 devices managed by different subsystems are bound to a same iommufd.
@@ -179,9 +180,9 @@ IOMMUFD Kernel API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The IOMMUFD kAPI is device-centric with group-related tricks managed behin=
d the
-scene. This allows the external driver calling such kAPI to implement a si=
mple
+scene. This allows the external drivers calling such kAPI to implement a s=
imple
 device-centric uAPI for connecting its device to an iommufd, instead of
-explicitly imposing the group semantics in its uAPI (as VFIO does).
+explicitly imposing the group semantics in its uAPI as VFIO does.
=20
 .. kernel-doc:: drivers/iommu/iommufd/device.c
    :export:
@@ -189,7 +190,7 @@ explicitly imposing the group semantics in its uAPI (as=
 VFIO does).
 VFIO and IOMMUFD
 ----------------
=20
-Connecting a VFIO device to iommufd can be done in two approaches.
+Connecting a VFIO device to iommufd can be done in two ways.
=20
 First is a VFIO compatible way by directly implementing the /dev/vfio/vfio
 container IOCTLs by mapping them into io_pagetable operations. Doing so al=
lows
@@ -197,10 +198,9 @@ the use of iommufd in legacy VFIO applications by syml=
inking /dev/vfio/vfio to
 /dev/iommufd or extending VFIO to SET_CONTAINER using an iommufd instead o=
f a
 container fd.
=20
-The second approach directly extends VFIO to support a new set of device-c=
entric
-user API based on aforementioned IOMMUFD kernel API. It requires userspace
-change but better matches the IOMMUFD API semantics and easier to support =
new
-iommufd features when comparing it to the first approach.
+The second approach directly extends VFIO to support a new set of
+device-centric user API based on aforementioned IOMMUFD kernel API. It req=
uires userspace change but better matches the IOMMUFD API semantics and eas=
ier to
+support new iommufd features when comparing it to the first approach.
=20
 Currently both approaches are still work-in-progress.
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Satf9+G4bCrY7567
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1i0ywAKCRD2uYlJVVFO
ox69AP0d5WM/RHsSbLBUbW/uSp/MdpHR3jC4HUUQf3xLRUpDvAD9HOStkoSSQ8nN
IsJB9dyezCHEmJtPDigCh4V63ZZUZAY=
=FkLZ
-----END PGP SIGNATURE-----

--Satf9+G4bCrY7567--
