Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED249621258
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 14:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiKHN1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiKHN1S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 08:27:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A71834A;
        Tue,  8 Nov 2022 05:27:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so13325189pjd.4;
        Tue, 08 Nov 2022 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIylKV8PWi6a84OxrCbfA4LgZR7i3vwQqVnaY7JrrQU=;
        b=fQ0i8yqJcY3koYav4Xu6e+jcyhczfaD74ztJBEdo0oK6wDpgJIWBsmLnmK6qqt8ZRG
         47PweuTHXBg7aahpH6Y93qGecXp53AJKhO+HLRa428/qhO5WjecDS8ZnB2E1+iECX/EZ
         damthuBEya1P0YFv3Jg24HjaqPO4AwzEyl+zrN/TSl2gV+p9kexKz18UgoHEazS+yjD7
         s3x/FU8I8XMgZR1j+K9o3pLmBwuXMH3BU3Vfd9w22Xb+MaOfnjMpcKSrjwOrUi9MGeMb
         vH1FgOEnoeL32MtmlKS+jAGMo+ejfSXaBR4MN9K/941XlYE3F4ljKZIAIdvY6dCfLDwo
         LzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIylKV8PWi6a84OxrCbfA4LgZR7i3vwQqVnaY7JrrQU=;
        b=3KJ/M4yFscLh8RLpoxJpnqq4WUDLSJD+rdsMx4Dvrn/wxberZivs7dURSOupiFu8sQ
         BH49ayqtKogULKapJFLVRHmD/L9A52wSmFu+ArS81ZEYNJHt7Y7eXPKOT+KZC+XhIro4
         oAwLqISVI34fnA8tn4R8Ctr2mp5B08ePJA89+x4O6Lz6RVaNiCSDbicAXgJl/2c29cml
         AKUAR+LZtJQ3gULQBClLHl4kwmBX45ijintUAFI26Vk74rXYizk+AAAxuxuYZB/JQARb
         Q9sYcB4P1Ghdd2VIOR+eorSqc9SMdhuqscjbCmozyJItHi8Mu96u1G65HDQCLi/NPgS2
         gU2g==
X-Gm-Message-State: ACrzQf1NVmOzmrxuv3liMVHwmU4u/7qKKrKaLN3xqhnHbVElNQ27O9C8
        uNmX+KxmhjOJiZji/dX4okUtO6tpjpB89g==
X-Google-Smtp-Source: AMsMyM4PQWl6zvFHk/r0XiP9GAls4l2/cyFEMX1EMtka4bQZocGBBFHBEtIDcV8wFn9XDQVJ4X1sXQ==
X-Received: by 2002:a17:90b:4f45:b0:213:ccc6:87df with SMTP id pj5-20020a17090b4f4500b00213ccc687dfmr51987081pjb.227.1667914037053;
        Tue, 08 Nov 2022 05:27:17 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-66.three.co.id. [223.255.225.66])
        by smtp.gmail.com with ESMTPSA id x63-20020a626342000000b0056bcc744bdbsm6296700pfb.203.2022.11.08.05.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:27:16 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id D871A10403D; Tue,  8 Nov 2022 20:27:13 +0700 (WIB)
Date:   Tue, 8 Nov 2022 20:27:13 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: Re: [PATCH v4 10/17] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y2pZMSejF7nHinIr@debian.me>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <10-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0xuIlMeiFoV5n7Yi"
Content-Disposition: inline
In-Reply-To: <10-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--0xuIlMeiFoV5n7Yi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 08:49:03PM -0400, Jason Gunthorpe wrote:
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 2ad06b27a35fe5..a872a50d800a41 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -37,6 +37,13 @@
>  enum {
>  	IOMMUFD_CMD_BASE =3D 0x80,
>  	IOMMUFD_CMD_DESTROY =3D IOMMUFD_CMD_BASE,
> +	IOMMUFD_CMD_IOAS_ALLOC,
> +	IOMMUFD_CMD_IOAS_ALLOW_IOVAS,
> +	IOMMUFD_CMD_IOAS_COPY,
> +	IOMMUFD_CMD_IOAS_IOVA_RANGES,
> +	IOMMUFD_CMD_IOAS_MAP,
> +	IOMMUFD_CMD_IOAS_UNMAP,
> +	IOMMUFD_CMD_OPTION,
>  };
> =20
>  /**
> @@ -52,4 +59,238 @@ struct iommu_destroy {
>  };
>  #define IOMMU_DESTROY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DESTROY)
> =20
> +/**
> + * struct iommu_ioas_alloc - ioctl(IOMMU_IOAS_ALLOC)
> + * @size: sizeof(struct iommu_ioas_alloc)
> + * @flags: Must be 0
> + * @out_ioas_id: Output IOAS ID for the allocated object
> + *
> + * Allocate an IO Address Space (IOAS) which holds an IO Virtual Address=
 (IOVA)
> + * to memory mapping.
> + */
> +struct iommu_ioas_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 out_ioas_id;
> +};
> +#define IOMMU_IOAS_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_ALLOC)
> +
> +/**
> + * struct iommu_iova_range
> + * @start: First IOVA
> + * @last: Inclusive last IOVA
> + *
> + * An interval in IOVA space.
> + */
> +struct iommu_iova_range {
> +	__aligned_u64 start;
> +	__aligned_u64 last;
> +};
> +
> +/**
> + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
> + * @size: sizeof(struct iommu_ioas_iova_ranges)
> + * @ioas_id: IOAS ID to read ranges from
> + * @num_iovas: Input/Output total number of ranges in the IOAS
> + * @__reserved: Must be 0
> + * @allowed_iovas: Pointer to the output array of struct iommu_iova_range
> + * @out_iova_alignment: Minimum alignment required for mapping IOVA
> + *
> + * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these=
 ranges
> + * is not allowed. num_iovas will be set to the total number of iovas and
> + * the allowed_iovas[] will be filled in as space permits.
> + *
> + * The allowed ranges are dependent on the HW path the DMA operation tak=
es, and
> + * can change during the lifetime of the IOAS. A fresh empty IOAS will h=
ave a
> + * full range, and each attached device will narrow the ranges based on =
that
> + * device's HW restrictions. Detatching a device can widen the ranges. U=
serspace
> + * should query ranges after every attach/detatch to know what IOVAs are=
 valid
> + * for mapping.
> + *
> + * On input num_iovas is the length of the allowed_iovas array. On outpu=
t it is
> + * the total number of iovas filled in. The ioctl will return -EMSGSIZE =
and set
> + * num_iovas to the required value if num_iovas is too small. In this ca=
se the
> + * caller should allocate a larger output array and re-issue the ioctl.
> + */
> +struct iommu_ioas_iova_ranges {
> +	__u32 size;
> +	__u32 ioas_id;
> +	__u32 num_iovas;
> +	__u32 __reserved;
> +	__aligned_u64 allowed_iovas;
> +	__aligned_u64 out_iova_alignment;
> +};
> +#define IOMMU_IOAS_IOVA_RANGES _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_IOVA_R=
ANGES)
> +
> +/**
> + * struct iommu_ioas_allow_iovas - ioctl(IOMMU_IOAS_ALLOW_IOVAS)
> + * @size: sizeof(struct iommu_ioas_allow_iovas)
> + * @ioas_id: IOAS ID to allow IOVAs from
> + * @num_iovas: Input/Output total number of ranges in the IOAS
> + * @__reserved: Must be 0
> + * @allowed_iovas: Pointer to array of struct iommu_iova_range
> + *
> + * Ensure a range of IOVAs are always available for allocation. If this =
call
> + * succeeds then IOMMU_IOAS_IOVA_RANGES will never return a list of IOVA=
 ranges
> + * that are narrower than the ranges provided here. This call will fail =
if
> + * IOMMU_IOAS_IOVA_RANGES is currently narrower than the given ranges.
> + *
> + * When an IOAS is first created the IOVA_RANGES will be maximally sized=
, and as
> + * devices are attached the IOVA will narrow based on the device restric=
tions.
> + * When an allowed range is specified any narrowing will be refused, ie =
device
> + * attachment can fail if the device requires limiting within the allowe=
d range.
> + *
> + * Automatic IOVA allocation is also impacted by this call. MAP will only
> + * allocate within the allowed IOVAs if they are present.
> + *
> + * This call replaces the entire allowed list with the given list.
> + */
> +struct iommu_ioas_allow_iovas {
> +	__u32 size;
> +	__u32 ioas_id;
> +	__u32 num_iovas;
> +	__u32 __reserved;
> +	__aligned_u64 allowed_iovas;
> +};
> +#define IOMMU_IOAS_ALLOW_IOVAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_ALLOW_=
IOVAS)
> +
> +/**
> + * enum iommufd_ioas_map_flags - Flags for map and copy
> + * @IOMMU_IOAS_MAP_FIXED_IOVA: If clear the kernel will compute an appro=
priate
> + *                             IOVA to place the mapping at
> + * @IOMMU_IOAS_MAP_WRITEABLE: DMA is allowed to write to this mapping
> + * @IOMMU_IOAS_MAP_READABLE: DMA is allowed to read from this mapping
> + */
> +enum iommufd_ioas_map_flags {
> +	IOMMU_IOAS_MAP_FIXED_IOVA =3D 1 << 0,
> +	IOMMU_IOAS_MAP_WRITEABLE =3D 1 << 1,
> +	IOMMU_IOAS_MAP_READABLE =3D 1 << 2,
> +};
> +
> +/**
> + * struct iommu_ioas_map - ioctl(IOMMU_IOAS_MAP)
> + * @size: sizeof(struct iommu_ioas_map)
> + * @flags: Combination of enum iommufd_ioas_map_flags
> + * @ioas_id: IOAS ID to change the mapping of
> + * @__reserved: Must be 0
> + * @user_va: Userspace pointer to start mapping from
> + * @length: Number of bytes to map
> + * @iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IOVA i=
s set
> + *        then this must be provided as input.
> + *
> + * Set an IOVA mapping from a user pointer. If FIXED_IOVA is specified t=
hen the
> + * mapping will be established at iova, otherwise a suitable location ba=
sed on
> + * the reserved and allowed lists will be automatically selected and ret=
urned in
> + * iova.
> + */
> +struct iommu_ioas_map {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 ioas_id;
> +	__u32 __reserved;
> +	__aligned_u64 user_va;
> +	__aligned_u64 length;
> +	__aligned_u64 iova;
> +};
> +#define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
> +
> +/**
> + * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
> + * @size: sizeof(struct iommu_ioas_copy)
> + * @flags: Combination of enum iommufd_ioas_map_flags
> + * @dst_ioas_id: IOAS ID to change the mapping of
> + * @src_ioas_id: IOAS ID to copy from
> + * @length: Number of bytes to copy and map
> + * @dst_iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IO=
VA is
> + *            set then this must be provided as input.
> + * @src_iova: IOVA to start the copy
> + *
> + * Copy an already existing mapping from src_ioas_id and establish it in
> + * dst_ioas_id. The src iova/length must exactly match a range used with
> + * IOMMU_IOAS_MAP.
> + *
> + * This may be used to efficiently clone a subset of an IOAS to another,=
 or as a
> + * kind of 'cache' to speed up mapping. Copy has an effciency advantage =
over
> + * establishing equivalent new mappings, as internal resources are share=
d, and
> + * the kernel will pin the user memory only once.
> + */
> +struct iommu_ioas_copy {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dst_ioas_id;
> +	__u32 src_ioas_id;
> +	__aligned_u64 length;
> +	__aligned_u64 dst_iova;
> +	__aligned_u64 src_iova;
> +};
> +#define IOMMU_IOAS_COPY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_COPY)
> +
> +/**
> + * struct iommu_ioas_unmap - ioctl(IOMMU_IOAS_UNMAP)
> + * @size: sizeof(struct iommu_ioas_unmap)
> + * @ioas_id: IOAS ID to change the mapping of
> + * @iova: IOVA to start the unmapping at
> + * @length: Number of bytes to unmap, and return back the bytes unmapped
> + *
> + * Unmap an IOVA range. The iova/length must be a superset of a previous=
ly
> + * mapped range used with IOMMU_IOAS_MAP or IOMMU_IOAS_COPY. Splitting or
> + * truncating ranges is not allowed. The values 0 to U64_MAX will unmap
> + * everything.
> + */
> +struct iommu_ioas_unmap {
> +	__u32 size;
> +	__u32 ioas_id;
> +	__aligned_u64 iova;
> +	__aligned_u64 length;
> +};
> +#define IOMMU_IOAS_UNMAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_UNMAP)
> +
> +/**
> + * enum iommufd_option
> + * @IOMMU_OPTION_RLIMIT_MODE:
> + *    Change how RLIMIT_MEMLOCK accounting works. The caller must have p=
rivilege
> + *    to invoke this. Value 0 (default) is user based accouting, 1 uses =
process
> + *    based accounting. Global option, object_id must be 0
> + * @IOMMU_OPTION_HUGE_PAGES:
> + *    Value 1 (default) allows contiguous pages to be combined when gene=
rating
> + *    iommu mappings. Value 0 disables combining, everything is mapped to
> + *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOAS
> + *    option, the object_id must be the IOAS ID.
> + */
> +enum iommufd_option {
> +	IOMMU_OPTION_RLIMIT_MODE =3D 0,
> +	IOMMU_OPTION_HUGE_PAGES =3D 1,
> +};
> +
> +/**
> + * enum iommufd_option_ops
> + * @IOMMU_OPTION_OP_SET: Set the option's value
> + * @IOMMU_OPTION_OP_GET: Get the option's value
> + */
> +enum iommufd_option_ops {
> +	IOMMU_OPTION_OP_SET =3D 0,
> +	IOMMU_OPTION_OP_GET =3D 1,
> +};
> +
> +/**
> + * @size: sizeof(struct iommu_option)
> + * @option_id: One of enum iommufd_option
> + * @op: One of enum iommufd_option_ops
> + * @__reserved: Must be 0
> + * @object_id: ID of the object if required
> + * @val64: Option value to set or value returned on get
> + *
> + * Change a simple option value. This multiplexor allows controlling a o=
ptions
> + * on objects. IOMMU_OPTION_OP_SET will load an option and IOMMU_OPTION_=
OP_GET
> + * will return the current value.
> + */
> +struct iommu_option {
> +	__u32 size;
> +	__u32 option_id;
> +	__u16 op;
> +	__u16 __reserved;
> +	__u32 object_id;
> +	__aligned_u64 val64;
> +};
> +#define IOMMU_OPTION _IO(IOMMUFD_TYPE, IOMMUFD_CMD_OPTION)
>  #endif

I see kernel-doc warnings (missing short descriptions) when making
htmldocs, so I have applied the fixup:

---- >8 ----

=46rom 5643b202ae9853c11434466c76aeaaa044e88b07 Mon Sep 17 00:00:00 2001
=46rom: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Tue, 8 Nov 2022 20:14:25 +0700
Subject: [PATCH] iommufd: Add missing ioctl short descriptions

Checking kernel-doc comments in iommufd.h header with scripts/kernel-doc
produces missing short description warnings:

include/uapi/linux/iommufd.h:80: warning: missing initial short description=
 on line:
 * struct iommu_iova_range
include/uapi/linux/iommufd.h:250: warning: missing initial short descriptio=
n on line:
 * enum iommufd_option
include/uapi/linux/iommufd.h:267: warning: missing initial short descriptio=
n on line:
 * enum iommufd_option_ops
include/uapi/linux/iommufd.h:277: warning: Cannot understand  * @size: size=
of(struct iommu_option)
 on line 277 - I thought it was a doc line
include/uapi/linux/iommufd.h:299: warning: missing initial short descriptio=
n on line:
 * enum iommufd_vfio_ioas_op

One of them is reported by Stephen Rothwell when merging iommufd tree for
linux-next.

Describe these ioctl structs and enums to fix above warnings.

Link: https://lore.kernel.org/linux-next/20221108165125.3bf96028@canb.auug.=
org.au/
Fixes: 5a013b3b3b2f02 ("iommufd: IOCTLs for the io_pagetable")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/uapi/linux/iommufd.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c7109d7e5e09a9..66e9fb104bde5a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -77,7 +77,7 @@ struct iommu_ioas_alloc {
 #define IOMMU_IOAS_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_ALLOC)
=20
 /**
- * struct iommu_iova_range
+ * struct iommu_iova_range - ioctl(IOMMU_IOVA_RANGE)
  * @start: First IOVA
  * @last: Inclusive last IOVA
  *
@@ -247,7 +247,8 @@ struct iommu_ioas_unmap {
 #define IOMMU_IOAS_UNMAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_UNMAP)
=20
 /**
- * enum iommufd_option
+ * enum iommufd_option - ioctl(IOMMU_OPTION_RLIMIT_MODE) and
+ *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
  * @IOMMU_OPTION_RLIMIT_MODE:
  *    Change how RLIMIT_MEMLOCK accounting works. The caller must have pri=
vilege
  *    to invoke this. Value 0 (default) is user based accouting, 1 uses pr=
ocess
@@ -264,7 +265,8 @@ enum iommufd_option {
 };
=20
 /**
- * enum iommufd_option_ops
+ * enum iommufd_option_ops - ioctl(IOMMU_OPTION_OP_SET) and
+ *                           ioctl(IOMMU_OPTION_OP_GET)
  * @IOMMU_OPTION_OP_SET: Set the option's value
  * @IOMMU_OPTION_OP_GET: Get the option's value
  */
@@ -274,6 +276,7 @@ enum iommufd_option_ops {
 };
=20
 /**
+ * struct iommu_option - iommu option multiplexer
  * @size: sizeof(struct iommu_option)
  * @option_id: One of enum iommufd_option
  * @op: One of enum iommufd_option_ops
@@ -296,7 +299,7 @@ struct iommu_option {
 #define IOMMU_OPTION _IO(IOMMUFD_TYPE, IOMMUFD_CMD_OPTION)
=20
 /**
- * enum iommufd_vfio_ioas_op
+ * enum iommufd_vfio_ioas_op - IOMMU_VFIO_IOAS_* ioctls
  * @IOMMU_VFIO_IOAS_GET: Get the current compatibility IOAS
  * @IOMMU_VFIO_IOAS_SET: Change the current compatibility IOAS
  * @IOMMU_VFIO_IOAS_CLEAR: Disable VFIO compatibility


Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0xuIlMeiFoV5n7Yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2pZLgAKCRD2uYlJVVFO
o9K9AQCtNLE0xZ4ykEU7h5R+o1v92cceQfeYnkmrVQNzE5kxXQEA6jiZ2dFAtqfp
HH10hjLTREXUf/udDwJ8ajJufP7Gdww=
=mS8C
-----END PGP SIGNATURE-----

--0xuIlMeiFoV5n7Yi--
