Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415E41C607
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbhI2NvC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbhI2NvC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 09:51:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185CC06161C;
        Wed, 29 Sep 2021 06:49:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HKHmD52z9z4xR9;
        Wed, 29 Sep 2021 23:49:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1632923356;
        bh=P8tUw5K8mJPfUdTtcmpSczMFSPt2J9XUhevj94xlNt8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=GE7fnSSeObffNfTUpXmKHZyokpkz3gZc3FgYodi8dQJrZCn+NhvuvFa30vHwUNjyE
         aJ9NxDy2wTNeGTy/te9vJDzG/2YEOcJtztOCx27sZpMQLShBdf3jMfgojvOio1JxDF
         GIL+0BE7/wq2czEMgqGyWXakKzX457iXkMfAdYav+jdBQMjoPPZRODtAxPhySDeLFF
         0LZtyRkH+N6wLHexloA7KyrWAw27jI1e5Qh6P5R8CdNRNDgJ7PJ/euPGejBO4yvDPn
         MI8bqTRkW26W9LqQr+lbgULgWRmL/kNwgbhhutRuiwni6npSmkm9bQYpZGYDyU8wp0
         p9VgfHygslrgA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Pratik R. Sampat" <psampat@linux.ibm.com>,
        benh@kernel.crashing.org, paulus@samba.org, shuah@kernel.org,
        farosas@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: Re: [PATCH v8 1/2] powerpc/pseries: Interface to represent PAPR
 firmware attributes
In-Reply-To: <20210928115102.57117-2-psampat@linux.ibm.com>
References: <20210928115102.57117-1-psampat@linux.ibm.com>
 <20210928115102.57117-2-psampat@linux.ibm.com>
Date:   Wed, 29 Sep 2021 23:49:13 +1000
Message-ID: <87bl4b1oh2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pratik,

Some comments inline below ...

"Pratik R. Sampat" <psampat@linux.ibm.com> writes:
> Adds a generic interface to represent the energy and frequency related
> PAPR attributes on the system using the new H_CALL
> "H_GET_ENERGY_SCALE_INFO".

In Linux "generic" would usually mean something that is not architecture
specific, but this is architecture specific.

It's also not generic across different types of attributes, it's only
for information from this particular hcall (right?).

I think you mean generic in contrast to lparcfg, which I guess makes
some sense, this is more generic than lparcfg :)

But I think it'd be better to just say "a sysfs interface".

> H_GET_EM_PARMS H_CALL was previously responsible for exporting this
> information in the lparcfg, however the H_GET_EM_PARMS H_CALL
> will be deprecated P10 onwards.
>
> The H_GET_ENERGY_SCALE_INFO H_CALL is of the following call format:
> hcall(
>   uint64 H_GET_ENERGY_SCALE_INFO,  // Get energy scale info
>   uint64 flags,           // Per the flag request
>   uint64 firstAttributeId,// The attribute id
>   uint64 bufferAddress,   // Guest physical address of the output buffer
>   uint64 bufferSize       // The size in bytes of the output buffer
> );

As specified in PAPR+ v2.11, section 14.14.3.

> This H_CALL can query either all the attributes at once with
> firstAttributeId = 0, flags = 0 as well as query only one attribute
> at a time with firstAttributeId = id, flags = 1.
>
> The output buffer consists of the following
> 1. number of attributes              - 8 bytes
> 2. array offset to the data location - 8 bytes
> 3. version info                      - 1 byte
     (possible future expansion here)
> 4. A data array of size num attributes, which contains the following:
>   a. attribute ID              - 8 bytes
>   b. attribute value in number - 8 bytes
>   c. attribute name in string  - 64 bytes
>   d. attribute value in string - 64 bytes
>
> The new H_CALL exports information in direct string value format, hence
> a new interface has been introduced in
> /sys/firmware/papr/energy_scale_info to export this information to
> userspace in an extensible pass-through format.

I'm not really sure what "extensible pass-through format" means? Do you
mean the kernel doesn't interpret the values, so firmware can add new
values and they will just appear without any kernel changes required?

> The H_CALL returns the name, numeric value and string value (if exists)
>
> The format of exposing the sysfs information is as follows:
> /sys/firmware/papr/energy_scale_info/
>    |-- <id>/
>      |-- desc
>      |-- value
>      |-- value_desc (if exists)
>    |-- <id>/
>      |-- desc
>      |-- value
>      |-- value_desc (if exists)
> ...
>
> The energy information that is exported is useful for userspace tools
> such as powerpc-utils. Currently these tools infer the
> "power_mode_data" value in the lparcfg, which in turn is obtained from
> the to be deprecated H_GET_EM_PARMS H_CALL.
> On future platforms, such userspace utilities will have to look at the
> data returned from the new H_CALL being populated in this new sysfs
> interface and report this information directly without the need of
> interpretation.

I don't see anything here or in PAPR about how/if the values change over
time.

Are we expected to always read the values from the hypervisor, or are we
allowed to cache them for any period of time?

The reason I ask is currently we're doing 3 hcalls for each attribute,
once for desc, value and value_desc. Is there any issue with the
consistency of the values given we're doing 3 separate calls?

Or are the values static? Or static except for LPM? In which case we
could read them once at boot/LPM. Or maybe we not know if/how the values
will change, especially in future?

> diff --git a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> new file mode 100644
> index 000000000000..139a576c7c9d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> @@ -0,0 +1,26 @@
> +What:		/sys/firmware/papr/energy_scale_info
> +Date:		June 2021
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	Directory hosting a set of platform attributes like
> +		energy/frequency on Linux running as a PAPR guest.
> +
> +		Each file in a directory contains a platform
> +		attribute hierarchy pertaining to performance/
> +		energy-savings mode and processor frequency.
> +
> +What:		/sys/firmware/papr/energy_scale_info/<id>
> +		/sys/firmware/papr/energy_scale_info/<id>/desc
> +		/sys/firmware/papr/energy_scale_info/<id>/value
> +		/sys/firmware/papr/energy_scale_info/<id>/value_desc
> +Date:		June 2021
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	Energy, frequency attributes directory for POWERVM servers
> +
> +		This directory provides energy, frequency, folding information. It
> +		contains below sysfs attributes:
> +
> +		- desc: String description of the attribute <id>
> +
> +		- value: Numeric value of attribute <id>
> +
> +		- value_desc: String value of attribute <id>
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index 9bcf345cb208..38980fef7a3d 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -323,7 +323,8 @@
>  #define H_SCM_PERFORMANCE_STATS 0x418
>  #define H_RPT_INVALIDATE	0x448
>  #define H_SCM_FLUSH		0x44C
> -#define MAX_HCALL_OPCODE	H_SCM_FLUSH
> +#define H_GET_ENERGY_SCALE_INFO	0x450
> +#define MAX_HCALL_OPCODE	H_GET_ENERGY_SCALE_INFO
>  
>  /* Scope args for H_SCM_UNBIND_ALL */
>  #define H_UNBIND_SCOPE_ALL (0x1)
> @@ -641,6 +642,27 @@ struct hv_gpci_request_buffer {
>  	uint8_t bytes[HGPCI_MAX_DATA_BYTES];
>  } __packed;
>  

None of the following needs to be in this header AFAICS. It can all go
in the C file.

> +#define ESI_VERSION	0x1
> +#define MAX_ESI_ATTRS	10

Where does that max come from? I don't see it mentioned in PAPR.

PAPR implies any number of attributes up to 2^64 can be returned, and if
the buffer is too small H_PARTIAL is returned.

We really mustn't hard code a limit of 10 attributes. We need a loop that
reads N attributes, and if we receive H_PARTIAL, we repeat the hcall,
until we've received all the attributes.

To test that is working on an existing system, which presumably only has
a small number of attributes, you should shrink the buffer to the size
of 1 attribute, to make sure the loop logic works.

> +#define MAX_BUF_SZ	(sizeof(struct h_energy_scale_info_hdr) + \
> +			(sizeof(struct energy_scale_attribute) * MAX_ESI_ATTRS))
>
> +struct energy_scale_attribute {
> +	__be64 id;
> +	__be64 value;
> +	unsigned char desc[64];
> +	unsigned char value_desc[64];

I prefer u8.

> +} __packed;
> +
> +struct h_energy_scale_info_hdr {
> +	__be64 num_attrs;
> +	__be64 array_offset;
> +	__u8 data_header_version;

You can use u8 here, __u8 is only needed in uapi headers.

> +} __packed;

So because of array_offset, we don't actually know what the size of the
header plus a single attribute will be.

Because the header tells us the offset to the first attribute, when the
header expands in a future version of the hcall, sizeof(hdr) +
sizeof(energy_scale_attribute) will not necessarily be large enough to
fit a single attribute. I guess maybe that's why you're always
allocating space for 10 of them (MAX_BUF_SZ).

To be truly forward compatible we should do the hcall at startup with
the current known size of the structs, and if we receive H_P4 try again
with increasing sizes until it succeeds.

That's probably overly complex though, given we'd probably only expect
the header to grow by a few 10s of bytes in future.

Maybe we should just allocate 2KB for the buffer, which is still small
as far as allocations go, but gives us a huge amount of headroom for the
header to grow.


> +/* /sys/firmware/papr */
> +extern struct kobject *papr_kobj;
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_HVCALL_H */
> diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
> index 830a126e095d..38cd0ed0a617 100644
> --- a/arch/powerpc/kvm/trace_hv.h
> +++ b/arch/powerpc/kvm/trace_hv.h
> @@ -115,6 +115,7 @@
>  	{H_VASI_STATE,			"H_VASI_STATE"}, \
>  	{H_ENABLE_CRQ,			"H_ENABLE_CRQ"}, \
>  	{H_GET_EM_PARMS,		"H_GET_EM_PARMS"}, \
> +	{H_GET_ENERGY_SCALE_INFO,	"H_GET_ENERGY_SCALE_INFO"}, \
>  	{H_SET_MPP,			"H_SET_MPP"}, \
>  	{H_GET_MPP,			"H_GET_MPP"}, \
>  	{H_HOME_NODE_ASSOCIATIVITY,	"H_HOME_NODE_ASSOCIATIVITY"}, \
> diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
> index 4cda0ef87be0..c4c19f6a5975 100644
> --- a/arch/powerpc/platforms/pseries/Makefile
> +++ b/arch/powerpc/platforms/pseries/Makefile
> @@ -6,7 +6,8 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
>  			   of_helpers.o \
>  			   setup.o iommu.o event_sources.o ras.o \
>  			   firmware.o power.o dlpar.o mobility.o rng.o \
> -			   pci.o pci_dlpar.o eeh_pseries.o msi.o
> +			   pci.o pci_dlpar.o eeh_pseries.o msi.o \
> +			   papr_platform_attributes.o

I don't really mind, but is there a reason we're calling it
papr_platform_attributes.c and not energy_info.c or something?

Is the plan to support more attributes in future?

>  obj-$(CONFIG_SMP)	+= smp.o
>  obj-$(CONFIG_SCANLOG)	+= scanlog.o
>  obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
> diff --git a/arch/powerpc/platforms/pseries/papr_platform_attributes.c b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
> new file mode 100644
> index 000000000000..84ddce52e519
> --- /dev/null
> +++ b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Platform energy and frequency attributes driver
> + *
> + * This driver creates a sys file at /sys/firmware/papr/ which encapsulates a
> + * directory structure containing files in keyword - value pairs that specify
> + * energy and frequency configuration of the system.
> + *
> + * The format of exposing the sysfs information is as follows:
> + * /sys/firmware/papr/energy_scale_info/
> + *  |-- <id>/
> + *    |-- desc
> + *    |-- value
> + *    |-- value_desc (if exists)
> + *  |-- <id>/
> + *    |-- desc
> + *    |-- value
> + *    |-- value_desc (if exists)
> + *
> + * Copyright 2021 IBM Corp.
> + */
> +
> +#include <asm/hvcall.h>
> +#include <asm/machdep.h>
> +
> +#include "pseries.h"
> +
> +/*
> + * Flag attributes to fetch either all or one attribute from the HCALL
> + * flag = BE(0) => fetch all attributes with firstAttributeId = 0
> + * flag = BE(1) => fetch a single attribute with firstAttributeId = id
> + */
> +#define ESI_FLAGS_ALL		0
> +#define ESI_FLAGS_SINGLE	PPC_BIT(0)

I dislike PPC_BIT(). It's obscure and not helpful for people reading the
code compared to a simple (1ull << 63).

> +
> +#define MAX_ATTRS		3
> +
> +struct papr_attr {
> +	u64 id;
> +	struct kobj_attribute kobj_attr;
> +};
> +struct papr_group {
> +	struct attribute_group pg;
> +	struct papr_attr pgattrs[MAX_ATTRS];
> +} *pgs;

pgs is not a great name for a global.

Can it be static?

Also would be more normal to define the structure separately from
declaring *pgs.

> +
> +/* /sys/firmware/papr */
> +struct kobject *papr_kobj;

static?

> +/* /sys/firmware/papr/energy_scale_info */
> +struct kobject *esi_kobj;

static?


The following three functions are almost exactly the same, except they
print a different field with a different format string. Seems like there
could be some shared code.

> +/*
> + * Extract and export the description of the energy scale attributes
> + */
> +static ssize_t papr_show_desc(struct kobject *kobj,
> +			       struct kobj_attribute *kobj_attr,
> +			       char *buf)
> +{
> +	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
> +					       kobj_attr);
> +	struct h_energy_scale_info_hdr *t_hdr;
> +	struct energy_scale_attribute *t_esi;

What's the "t_", temp? I don't really like it. hdr and esi would be fine IMHO.

> +	char *t_buf;
> +	int ret = 0;

That's initialisation is pointless, you override it below.

> +	t_buf = kmalloc(MAX_BUF_SZ, GFP_KERNEL);
> +	if (t_buf == NULL)
> +		return -ENOMEM;
> +
> +	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_SINGLE,
> +				 pattr->id, virt_to_phys(t_buf),
> +				 MAX_BUF_SZ);
> +
> +	if (ret != H_SUCCESS) {
> +		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
> +		goto out;

Here you're going to return ret back to userspace. But ret currently
holds a hcall return value, hcall return values are not necessarily
valid Linux error codes.

eg. H_PARTIAL is 5, H_BUSY is 1, etc. Those are potentially read as
success by your caller.

You must never return a hcall error back to Linux code that's not
expecting it.

Here it should probably just return -EIO I guess.

> +	}
> +
> +	t_hdr = (struct h_energy_scale_info_hdr *) t_buf;
> +	t_esi = (struct energy_scale_attribute *)
> +		(t_buf + be64_to_cpu(t_hdr->array_offset));

You should check that array_offset + sizeof(attribute) doesn't point
past the end of your buffer.

> +
> +	ret = snprintf(buf, sizeof(t_esi->desc), "%s\n", t_esi->desc);
> +	if (ret < 0)
> +		ret = -EIO;
> +out:
> +	kfree(t_buf);
> +
> +	return ret;
> +}
> +
> +/*
> + * Extract and export the numeric value of the energy scale attributes
> + */
> +static ssize_t papr_show_value(struct kobject *kobj,
> +				struct kobj_attribute *kobj_attr,
> +				char *buf)
> +{
> +	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
> +					       kobj_attr);
> +	struct h_energy_scale_info_hdr *t_hdr;
> +	struct energy_scale_attribute *t_esi;
> +	char *t_buf;
> +	int ret = 0;
> +
> +	t_buf = kmalloc(MAX_BUF_SZ, GFP_KERNEL);
> +	if (t_buf == NULL)
> +		return -ENOMEM;
> +
> +	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_SINGLE,
> +				 pattr->id, virt_to_phys(t_buf),
> +				 MAX_BUF_SZ);
> +
> +	if (ret != H_SUCCESS) {
> +		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
> +		goto out;
> +	}
> +
> +	t_hdr = (struct h_energy_scale_info_hdr *) t_buf;
> +	t_esi = (struct energy_scale_attribute *)
> +		(t_buf + be64_to_cpu(t_hdr->array_offset));
> +
> +	ret = snprintf(buf, sizeof(t_esi->value), "%llu\n",
> +		       be64_to_cpu(t_esi->value));
> +	if (ret < 0)
> +		ret = -EIO;
> +out:
> +	kfree(t_buf);
> +
> +	return ret;
> +}
> +
> +/*
> + * Extract and export the value description in string format of the energy
> + * scale attributes
> + */
> +static ssize_t papr_show_value_desc(struct kobject *kobj,
> +				     struct kobj_attribute *kobj_attr,
> +				     char *buf)
> +{
> +	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
> +					       kobj_attr);
> +	struct h_energy_scale_info_hdr *t_hdr;
> +	struct energy_scale_attribute *t_esi;
> +	char *t_buf;
> +	int ret = 0;
> +
> +	t_buf = kmalloc(MAX_BUF_SZ, GFP_KERNEL);
> +	if (t_buf == NULL)
> +		return -ENOMEM;
> +
> +	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_SINGLE,
> +				 pattr->id, virt_to_phys(t_buf),
> +				 MAX_BUF_SZ);
> +
> +	if (ret != H_SUCCESS) {
> +		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
> +		goto out;
> +	}
> +
> +	t_hdr = (struct h_energy_scale_info_hdr *) t_buf;
> +	t_esi = (struct energy_scale_attribute *)
> +		(t_buf + be64_to_cpu(t_hdr->array_offset));
> +
> +	ret = snprintf(buf, sizeof(t_esi->value_desc), "%s\n",
> +		       t_esi->value_desc);
> +	if (ret < 0)
> +		ret = -EIO;
> +out:
> +	kfree(t_buf);
> +
> +	return ret;
> +}
> +
> +static struct papr_ops_info {
> +	const char *attr_name;
> +	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *kobj_attr,
> +			char *buf);
> +} ops_info[MAX_ATTRS] = {
> +	{ "desc", papr_show_desc },
> +	{ "value", papr_show_value },
> +	{ "value_desc", papr_show_value_desc },
> +};
> +
> +static void add_attr(u64 id, int index, struct papr_attr *attr)
> +{
> +	attr->id = id;
> +	sysfs_attr_init(&attr->kobj_attr.attr);
> +	attr->kobj_attr.attr.name = ops_info[index].attr_name;
> +	attr->kobj_attr.attr.mode = 0444;
> +	attr->kobj_attr.show = ops_info[index].show;
> +}
> +
> +static int add_attr_group(u64 id, struct papr_group *pg, bool show_val_desc)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_ATTRS; i++) {
> +		if (!strcmp(ops_info[i].attr_name, "value_desc") &&
> +		    !show_val_desc) {
> +			continue;
> +		}
> +		add_attr(id, i, &pg->pgattrs[i]);
> +		pg->pg.attrs[i] = &pg->pgattrs[i].kobj_attr.attr;
> +	}
> +
> +	return sysfs_create_group(esi_kobj, &pg->pg);
> +}
> +
> +static int __init papr_init(void)
> +{
> +	struct h_energy_scale_info_hdr *esi_hdr;
> +	struct energy_scale_attribute *esi_attrs;
> +	uint64_t num_attrs;
> +	int ret, idx, i;
> +	char *esi_buf;
> +
> +	if (!firmware_has_feature(FW_FEATURE_LPAR))
> +		return -ENXIO;
> +
> +	esi_buf = kmalloc(MAX_BUF_SZ, GFP_KERNEL);
> +	if (esi_buf == NULL)
> +		return -ENOMEM;
> +	/*
> +	 * hcall(
> +	 * uint64 H_GET_ENERGY_SCALE_INFO,  // Get energy scale info
> +	 * uint64 flags,            // Per the flag request
> +	 * uint64 firstAttributeId, // The attribute id
> +	 * uint64 bufferAddress,    // Guest physical address of the output buffer
> +	 * uint64 bufferSize);      // The size in bytes of the output buffer
> +	 */
> +	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_ALL, 0,
> +				 virt_to_phys(esi_buf), MAX_BUF_SZ);
> +	if (ret != H_SUCCESS) {
> +		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
> +		goto out;

This prints a warning on all existing systems (that don't support the
new hcall), which is not ideal :)

The proper way to handle discovery of the hcall is by looking at
ibm,hypertas-functions and setting a FW_FEATURE flag based on that.

See fw_hypertas_feature_init().

> +	}

Also the hcall can return H_PARTIAL if the buffer isn't big enough.

> +	esi_hdr = (struct h_energy_scale_info_hdr *) esi_buf;
> +	if (esi_hdr->data_header_version != ESI_VERSION) {
> +		pr_warn("H_GET_ENERGY_SCALE_INFO VER MISMATCH - EXP: 0x%x, REC: 0x%x",
> +			ESI_VERSION, esi_hdr->data_header_version);

That shouldn't be a warning. PAPR says any changes will be backward
compatible. If we need to check the version at all, it would be to make
sure the hypervisor version is >= the version we expect. But I'm not
sure it's necessary to check at all?

> +	}
> +
> +	num_attrs = be64_to_cpu(esi_hdr->num_attrs);
> +	esi_attrs = (struct energy_scale_attribute *)
> +		    (esi_buf + be64_to_cpu(esi_hdr->array_offset));
> +
> +	pgs = kcalloc(num_attrs, sizeof(*pgs), GFP_KERNEL);
> +	if (!pgs)
> +		goto out;
> +
> +	papr_kobj = kobject_create_and_add("papr", firmware_kobj);
> +	if (!papr_kobj) {
> +		pr_warn("kobject_create_and_add papr failed\n");
> +		goto out_pgs;
> +	}
> +
> +	esi_kobj = kobject_create_and_add("energy_scale_info", papr_kobj);
> +	if (!esi_kobj) {
> +		pr_warn("kobject_create_and_add energy_scale_info failed\n");
> +		goto out_kobj;
> +	}
> +
> +	for (idx = 0; idx < num_attrs; idx++) {
> +		bool show_val_desc = true;
> +
> +		pgs[idx].pg.attrs = kcalloc(MAX_ATTRS + 1,
> +					    sizeof(*pgs[idx].pg.attrs),
> +					    GFP_KERNEL);
> +		if (!pgs[idx].pg.attrs) {
> +			goto out_pgattrs;
> +		}
> +
> +		pgs[idx].pg.name = kasprintf(GFP_KERNEL, "%lld",
> +					     be64_to_cpu(esi_attrs[idx].id));
> +		if (pgs[idx].pg.name == NULL) {
> +			goto out_pgattrs;
> +		}
> +		/* Do not add the value description if it does not exist */
> +		if (strnlen(esi_attrs[idx].value_desc,
> +			    sizeof(esi_attrs[idx].value_desc)) == 0)
> +			show_val_desc = false;
> +
> +		if (add_attr_group(be64_to_cpu(esi_attrs[idx].id), &pgs[idx],
> +				   show_val_desc)) {
> +			pr_warn("Failed to create papr attribute group %s\n",
> +				pgs[idx].pg.name);
> +			goto out_pgattrs;
> +		}
> +	}
> +
> +	kfree(esi_buf);
> +	return 0;
> +
> +out_pgattrs:

Is this right? If you failed the allocation for i = 1, then the attrs
for i = 0 would already be registered with sysfs, and then you free them
while they're still in use?

To simplify it you can probably do all the allocations first before
registering anything.

> +	for (i = 0; i < idx ; i++) {
> +		kfree(pgs[i].pg.attrs);
> +		kfree(pgs[i].pg.name);
> +	}
> +	kobject_put(esi_kobj);
> +out_kobj:
> +	kobject_put(papr_kobj);
> +out_pgs:
> +	kfree(pgs);
> +out:

If you're freeing something the label should be "out_free_thing". So in
this case out_free_esi_buf.

> +	kfree(esi_buf);
> +
> +	return -ENOMEM;
> +}
> +
> +machine_device_initcall(pseries, papr_init);
> -- 
> 2.31.1


cheers
