Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4241AE76
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 14:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbhI1MKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 08:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240458AbhI1MKM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 08:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF717611CA;
        Tue, 28 Sep 2021 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632830913;
        bh=GuHoaThe7NuL3NX8na212WAQm4jkyWPq9tMCWE/W50s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRvRPu74JoKK6gjRArcHEIvJfdQ4TnpraGQgC5mBGTUcUBBgBTU0xOHMNZ7xfWjEX
         jOVDVo5OOcJDATt9saH0h5eJtYP5VUEgmulXH9YynwMTwNjMeqfQ9TagJozRXbzzL5
         4VKJFs40nrzZ10lrctlLLaIkO01mOaz6paYD248I=
Date:   Tue, 28 Sep 2021 14:08:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Pratik R. Sampat" <psampat@linux.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        shuah@kernel.org, farosas@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
Subject: Re: [PATCH v8 1/2] powerpc/pseries: Interface to represent PAPR
 firmware attributes
Message-ID: <YVMFvyGwfH+rxYPz@kroah.com>
References: <20210928115102.57117-1-psampat@linux.ibm.com>
 <20210928115102.57117-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928115102.57117-2-psampat@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 28, 2021 at 05:21:01PM +0530, Pratik R. Sampat wrote:
> Adds a generic interface to represent the energy and frequency related
> PAPR attributes on the system using the new H_CALL
> "H_GET_ENERGY_SCALE_INFO".
> 
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
> 
> This H_CALL can query either all the attributes at once with
> firstAttributeId = 0, flags = 0 as well as query only one attribute
> at a time with firstAttributeId = id, flags = 1.
> 
> The output buffer consists of the following
> 1. number of attributes              - 8 bytes
> 2. array offset to the data location - 8 bytes
> 3. version info                      - 1 byte
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
> 
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
> 
> Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  .../sysfs-firmware-papr-energy-scale-info     |  26 ++
>  arch/powerpc/include/asm/hvcall.h             |  24 +-
>  arch/powerpc/kvm/trace_hv.h                   |   1 +
>  arch/powerpc/platforms/pseries/Makefile       |   3 +-
>  .../pseries/papr_platform_attributes.c        | 312 ++++++++++++++++++
>  5 files changed, 364 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
>  create mode 100644 arch/powerpc/platforms/pseries/papr_platform_attributes.c
> 
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

Can you just make 4 different entries in this file, making it easier to
parse and extend over time?


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
> +#define ESI_VERSION	0x1
> +#define MAX_ESI_ATTRS	10
> +#define MAX_BUF_SZ	(sizeof(struct h_energy_scale_info_hdr) + \
> +			(sizeof(struct energy_scale_attribute) * MAX_ESI_ATTRS))
> +
> +struct energy_scale_attribute {
> +	__be64 id;
> +	__be64 value;
> +	unsigned char desc[64];
> +	unsigned char value_desc[64];
> +} __packed;
> +
> +struct h_energy_scale_info_hdr {
> +	__be64 num_attrs;
> +	__be64 array_offset;
> +	__u8 data_header_version;
> +} __packed;
> +
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
> +
> +#define MAX_ATTRS		3
> +
> +struct papr_attr {
> +	u64 id;
> +	struct kobj_attribute kobj_attr;

Why does an attribute have to be part of this structure?

> +};
> +struct papr_group {
> +	struct attribute_group pg;
> +	struct papr_attr pgattrs[MAX_ATTRS];
> +} *pgs;
> +
> +/* /sys/firmware/papr */
> +struct kobject *papr_kobj;
> +/* /sys/firmware/papr/energy_scale_info */
> +struct kobject *esi_kobj;
> +
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

sysfs_emit() for when writing out to a sysfs file please.  Same
elsewhere in this file.

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

What is wrong with just using the __ATTR_RO() macro and then having an
array of attributes in a single group?  That should be a lot simpler
overall, right?

> +};
> +
> +static void add_attr(u64 id, int index, struct papr_attr *attr)
> +{
> +	attr->id = id;
> +	sysfs_attr_init(&attr->kobj_attr.attr);
> +	attr->kobj_attr.attr.name = ops_info[index].attr_name;
> +	attr->kobj_attr.attr.mode = 0444;
> +	attr->kobj_attr.show = ops_info[index].show;

If you do the above, no need for this function at all.

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

Again, if you just have a list of attributes, there's no need for this
function either.

I think this can be a lot simpler than you are currently making it.

thanks,

greg k-h
