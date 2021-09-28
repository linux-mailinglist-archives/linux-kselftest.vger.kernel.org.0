Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F741AF42
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 14:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbhI1Mpa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 08:45:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14982 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240768AbhI1Mp2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 08:45:28 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SCUXs2006854;
        Tue, 28 Sep 2021 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Gfcak3uzXPYfviovbRHWcc7Ddi7GfcXtXa7sKYzhPVg=;
 b=Gp2y3POBNKUXEmmzhaDOVLu1Ho5pZOYglfvyBiUtJwT7t1Da58RW+8ftKSHUifQCGt72
 cNCgzUgJcujyoDui3kP8Mwhlrulrz7/xehPIq8N5nhVRPR6vyy7zdXWH3tcOap1e9KbU
 +p8viR4lxFH7bEwxAqu349T35hMzrn93JORFC+SzquOpqDXQG6LrGxI88G8uotl68BKA
 IKst2SmNdENMPFwGWuYp+vcJciyeaAvlSmyz1+ZOlDyAio6DOu4qH3uxIcxvw/5K/N20
 e+OAFYnh0/+rwKLoipnXGD/F+zYU83o8K4XSy8iU/wf2aNd/uTp+PFJWEpULeWdQ6qy2 BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bbjbmv93m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 08:43:30 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18SCg8lA025089;
        Tue, 28 Sep 2021 08:43:30 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bbjbmv934-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 08:43:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18SCXrIe024301;
        Tue, 28 Sep 2021 12:43:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9ud9wxwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 12:43:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18SChNvH64684524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 12:43:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08E952057;
        Tue, 28 Sep 2021 12:43:23 +0000 (GMT)
Received: from [9.43.58.127] (unknown [9.43.58.127])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EC81252063;
        Tue, 28 Sep 2021 12:43:19 +0000 (GMT)
Subject: Re: [PATCH v8 1/2] powerpc/pseries: Interface to represent PAPR
 firmware attributes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        shuah@kernel.org, farosas@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
References: <20210928115102.57117-1-psampat@linux.ibm.com>
 <20210928115102.57117-2-psampat@linux.ibm.com> <YVMFvyGwfH+rxYPz@kroah.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <289d2081-7ae8-f76a-5180-49bc6061a05c@linux.ibm.com>
Date:   Tue, 28 Sep 2021 18:13:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVMFvyGwfH+rxYPz@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vwf_xQ6cIS_5hRHISxxjczunBF_eIAeK
X-Proofpoint-ORIG-GUID: q0s53NWh3wx8bgnggJPHiVj_PC4--YDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280071
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Greg,

Thank you for your review.

On 28/09/21 5:38 pm, Greg KH wrote:
> On Tue, Sep 28, 2021 at 05:21:01PM +0530, Pratik R. Sampat wrote:
>> Adds a generic interface to represent the energy and frequency related
>> PAPR attributes on the system using the new H_CALL
>> "H_GET_ENERGY_SCALE_INFO".
>>
>> H_GET_EM_PARMS H_CALL was previously responsible for exporting this
>> information in the lparcfg, however the H_GET_EM_PARMS H_CALL
>> will be deprecated P10 onwards.
>>
>> The H_GET_ENERGY_SCALE_INFO H_CALL is of the following call format:
>> hcall(
>>    uint64 H_GET_ENERGY_SCALE_INFO,  // Get energy scale info
>>    uint64 flags,           // Per the flag request
>>    uint64 firstAttributeId,// The attribute id
>>    uint64 bufferAddress,   // Guest physical address of the output buffer
>>    uint64 bufferSize       // The size in bytes of the output buffer
>> );
>>
>> This H_CALL can query either all the attributes at once with
>> firstAttributeId = 0, flags = 0 as well as query only one attribute
>> at a time with firstAttributeId = id, flags = 1.
>>
>> The output buffer consists of the following
>> 1. number of attributes              - 8 bytes
>> 2. array offset to the data location - 8 bytes
>> 3. version info                      - 1 byte
>> 4. A data array of size num attributes, which contains the following:
>>    a. attribute ID              - 8 bytes
>>    b. attribute value in number - 8 bytes
>>    c. attribute name in string  - 64 bytes
>>    d. attribute value in string - 64 bytes
>>
>> The new H_CALL exports information in direct string value format, hence
>> a new interface has been introduced in
>> /sys/firmware/papr/energy_scale_info to export this information to
>> userspace in an extensible pass-through format.
>>
>> The H_CALL returns the name, numeric value and string value (if exists)
>>
>> The format of exposing the sysfs information is as follows:
>> /sys/firmware/papr/energy_scale_info/
>>     |-- <id>/
>>       |-- desc
>>       |-- value
>>       |-- value_desc (if exists)
>>     |-- <id>/
>>       |-- desc
>>       |-- value
>>       |-- value_desc (if exists)
>> ...
>>
>> The energy information that is exported is useful for userspace tools
>> such as powerpc-utils. Currently these tools infer the
>> "power_mode_data" value in the lparcfg, which in turn is obtained from
>> the to be deprecated H_GET_EM_PARMS H_CALL.
>> On future platforms, such userspace utilities will have to look at the
>> data returned from the new H_CALL being populated in this new sysfs
>> interface and report this information directly without the need of
>> interpretation.
>>
>> Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
>> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>   .../sysfs-firmware-papr-energy-scale-info     |  26 ++
>>   arch/powerpc/include/asm/hvcall.h             |  24 +-
>>   arch/powerpc/kvm/trace_hv.h                   |   1 +
>>   arch/powerpc/platforms/pseries/Makefile       |   3 +-
>>   .../pseries/papr_platform_attributes.c        | 312 ++++++++++++++++++
>>   5 files changed, 364 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
>>   create mode 100644 arch/powerpc/platforms/pseries/papr_platform_attributes.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
>> new file mode 100644
>> index 000000000000..139a576c7c9d
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
>> @@ -0,0 +1,26 @@
>> +What:		/sys/firmware/papr/energy_scale_info
>> +Date:		June 2021
>> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
>> +Description:	Directory hosting a set of platform attributes like
>> +		energy/frequency on Linux running as a PAPR guest.
>> +
>> +		Each file in a directory contains a platform
>> +		attribute hierarchy pertaining to performance/
>> +		energy-savings mode and processor frequency.
>> +
>> +What:		/sys/firmware/papr/energy_scale_info/<id>
>> +		/sys/firmware/papr/energy_scale_info/<id>/desc
>> +		/sys/firmware/papr/energy_scale_info/<id>/value
>> +		/sys/firmware/papr/energy_scale_info/<id>/value_desc
>> +Date:		June 2021
>> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
>> +Description:	Energy, frequency attributes directory for POWERVM servers
>> +
>> +		This directory provides energy, frequency, folding information. It
>> +		contains below sysfs attributes:
>> +
>> +		- desc: String description of the attribute <id>
>> +
>> +		- value: Numeric value of attribute <id>
>> +
>> +		- value_desc: String value of attribute <id>
> Can you just make 4 different entries in this file, making it easier to
> parse and extend over time?

Do you mean I only create one file per attribute and populate it with 4
different entries as follows?

# cat /sys/firmware/papr/energy_scale_info/<id>
id:
desc:
value:
value_desc:

>
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>> index 9bcf345cb208..38980fef7a3d 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -323,7 +323,8 @@
>>   #define H_SCM_PERFORMANCE_STATS 0x418
>>   #define H_RPT_INVALIDATE	0x448
>>   #define H_SCM_FLUSH		0x44C
>> -#define MAX_HCALL_OPCODE	H_SCM_FLUSH
>> +#define H_GET_ENERGY_SCALE_INFO	0x450
>> +#define MAX_HCALL_OPCODE	H_GET_ENERGY_SCALE_INFO
>>   
>>   /* Scope args for H_SCM_UNBIND_ALL */
>>   #define H_UNBIND_SCOPE_ALL (0x1)
>> @@ -641,6 +642,27 @@ struct hv_gpci_request_buffer {
>>   	uint8_t bytes[HGPCI_MAX_DATA_BYTES];
>>   } __packed;
>>   
>> +#define ESI_VERSION	0x1
>> +#define MAX_ESI_ATTRS	10
>> +#define MAX_BUF_SZ	(sizeof(struct h_energy_scale_info_hdr) + \
>> +			(sizeof(struct energy_scale_attribute) * MAX_ESI_ATTRS))
>> +
>> +struct energy_scale_attribute {
>> +	__be64 id;
>> +	__be64 value;
>> +	unsigned char desc[64];
>> +	unsigned char value_desc[64];
>> +} __packed;
>> +
>> +struct h_energy_scale_info_hdr {
>> +	__be64 num_attrs;
>> +	__be64 array_offset;
>> +	__u8 data_header_version;
>> +} __packed;
>> +
>> +/* /sys/firmware/papr */
>> +extern struct kobject *papr_kobj;
>> +
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* __KERNEL__ */
>>   #endif /* _ASM_POWERPC_HVCALL_H */
>> diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
>> index 830a126e095d..38cd0ed0a617 100644
>> --- a/arch/powerpc/kvm/trace_hv.h
>> +++ b/arch/powerpc/kvm/trace_hv.h
>> @@ -115,6 +115,7 @@
>>   	{H_VASI_STATE,			"H_VASI_STATE"}, \
>>   	{H_ENABLE_CRQ,			"H_ENABLE_CRQ"}, \
>>   	{H_GET_EM_PARMS,		"H_GET_EM_PARMS"}, \
>> +	{H_GET_ENERGY_SCALE_INFO,	"H_GET_ENERGY_SCALE_INFO"}, \
>>   	{H_SET_MPP,			"H_SET_MPP"}, \
>>   	{H_GET_MPP,			"H_GET_MPP"}, \
>>   	{H_HOME_NODE_ASSOCIATIVITY,	"H_HOME_NODE_ASSOCIATIVITY"}, \
>> diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
>> index 4cda0ef87be0..c4c19f6a5975 100644
>> --- a/arch/powerpc/platforms/pseries/Makefile
>> +++ b/arch/powerpc/platforms/pseries/Makefile
>> @@ -6,7 +6,8 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
>>   			   of_helpers.o \
>>   			   setup.o iommu.o event_sources.o ras.o \
>>   			   firmware.o power.o dlpar.o mobility.o rng.o \
>> -			   pci.o pci_dlpar.o eeh_pseries.o msi.o
>> +			   pci.o pci_dlpar.o eeh_pseries.o msi.o \
>> +			   papr_platform_attributes.o
>>   obj-$(CONFIG_SMP)	+= smp.o
>>   obj-$(CONFIG_SCANLOG)	+= scanlog.o
>>   obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
>> diff --git a/arch/powerpc/platforms/pseries/papr_platform_attributes.c b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
>> new file mode 100644
>> index 000000000000..84ddce52e519
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
>> @@ -0,0 +1,312 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Platform energy and frequency attributes driver
>> + *
>> + * This driver creates a sys file at /sys/firmware/papr/ which encapsulates a
>> + * directory structure containing files in keyword - value pairs that specify
>> + * energy and frequency configuration of the system.
>> + *
>> + * The format of exposing the sysfs information is as follows:
>> + * /sys/firmware/papr/energy_scale_info/
>> + *  |-- <id>/
>> + *    |-- desc
>> + *    |-- value
>> + *    |-- value_desc (if exists)
>> + *  |-- <id>/
>> + *    |-- desc
>> + *    |-- value
>> + *    |-- value_desc (if exists)
>> + *
>> + * Copyright 2021 IBM Corp.
>> + */
>> +
>> +#include <asm/hvcall.h>
>> +#include <asm/machdep.h>
>> +
>> +#include "pseries.h"
>> +
>> +/*
>> + * Flag attributes to fetch either all or one attribute from the HCALL
>> + * flag = BE(0) => fetch all attributes with firstAttributeId = 0
>> + * flag = BE(1) => fetch a single attribute with firstAttributeId = id
>> + */
>> +#define ESI_FLAGS_ALL		0
>> +#define ESI_FLAGS_SINGLE	PPC_BIT(0)
>> +
>> +#define MAX_ATTRS		3
>> +
>> +struct papr_attr {
>> +	u64 id;
>> +	struct kobj_attribute kobj_attr;
> Why does an attribute have to be part of this structure?

I bundled both an attribute as well as its ID in a structure because each
attributes value could only be queried from the firmware with the corresponding
ID.
It seemed to be logically connected and that's why I had them in the structure.
Are you suggesting we maintain them separately and don't need the coupling?

>> +};
>> +struct papr_group {
>> +	struct attribute_group pg;
>> +	struct papr_attr pgattrs[MAX_ATTRS];
>> +} *pgs;
>> +
>> +/* /sys/firmware/papr */
>> +struct kobject *papr_kobj;
>> +/* /sys/firmware/papr/energy_scale_info */
>> +struct kobject *esi_kobj;
>> +
>> +/*
>> + * Extract and export the description of the energy scale attributes
>> + */
>> +static ssize_t papr_show_desc(struct kobject *kobj,
>> +			       struct kobj_attribute *kobj_attr,
>> +			       char *buf)
>> +{
>> +	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
>> +					       kobj_attr);
>> +	struct h_energy_scale_info_hdr *t_hdr;
>> +	struct energy_scale_attribute *t_esi;
>> +	char *t_buf;
>> +	int ret = 0;
>> +
>> +	t_buf = kmalloc(MAX_BUF_SZ, GFP_KERNEL);
>> +	if (t_buf == NULL)
>> +		return -ENOMEM;
>> +
>> +	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_SINGLE,
>> +				 pattr->id, virt_to_phys(t_buf),
>> +				 MAX_BUF_SZ);
>> +
>> +	if (ret != H_SUCCESS) {
>> +		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
>> +		goto out;
>> +	}
>> +
>> +	t_hdr = (struct h_energy_scale_info_hdr *) t_buf;
>> +	t_esi = (struct energy_scale_attribute *)
>> +		(t_buf + be64_to_cpu(t_hdr->array_offset));
>> +
>> +	ret = snprintf(buf, sizeof(t_esi->desc), "%s\n", t_esi->desc);
>> +	if (ret < 0)
>> +		ret = -EIO;
>> +out:
>> +	kfree(t_buf);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Extract and export the numeric value of the energy scale attributes
>> + */
>> +static ssize_t papr_show_value(struct kobject *kobj,
>> +				struct kobj_attribute *kobj_attr,
>> +				char *buf)
>> +{
>> +	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
>> +					       kobj_attr);
>> +	struct h_energy_scale_info_hdr *t_hdr;
>> +	struct energy_scale_attribute *t_esi;
>> +	char *t_buf;
>> +	int ret = 0;
>> +
>> +	t_buf = kmalloc(MAX_BUF_SZ, GFP_KERNEL);
>> +	if (t_buf == NULL)
>> +		return -ENOMEM;
>> +
>> +	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_SINGLE,
>> +				 pattr->id, virt_to_phys(t_buf),
>> +				 MAX_BUF_SZ);
>> +
>> +	if (ret != H_SUCCESS) {
>> +		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
>> +		goto out;
>> +	}
>> +
>> +	t_hdr = (struct h_energy_scale_info_hdr *) t_buf;
>> +	t_esi = (struct energy_scale_attribute *)
>> +		(t_buf + be64_to_cpu(t_hdr->array_offset));
>> +
>> +	ret = snprintf(buf, sizeof(t_esi->value), "%llu\n",
>> +		       be64_to_cpu(t_esi->value));
> sysfs_emit() for when writing out to a sysfs file please.  Same
> elsewhere in this file.

Sure, I can use sysfs_emit for writing to a sysfs file.

>> +	if (ret < 0)
>> +		ret = -EIO;
>> +out:
>> +	kfree(t_buf);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Extract and export the value description in string format of the energy
>> + * scale attributes
>> + */
>> +static ssize_t papr_show_value_desc(struct kobject *kobj,
>> +				     struct kobj_attribute *kobj_attr,
>> +				     char *buf)
>> +{
>> +	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
>> +					       kobj_attr);
>> +	struct h_energy_scale_info_hdr *t_hdr;
>> +	struct energy_scale_attribute *t_esi;
>> +	char *t_buf;
>> +	int ret = 0;
>> +
>> +	t_buf = kmalloc(MAX_BUF_SZ, GFP_KERNEL);
>> +	if (t_buf == NULL)
>> +		return -ENOMEM;
>> +
>> +	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_SINGLE,
>> +				 pattr->id, virt_to_phys(t_buf),
>> +				 MAX_BUF_SZ);
>> +
>> +	if (ret != H_SUCCESS) {
>> +		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
>> +		goto out;
>> +	}
>> +
>> +	t_hdr = (struct h_energy_scale_info_hdr *) t_buf;
>> +	t_esi = (struct energy_scale_attribute *)
>> +		(t_buf + be64_to_cpu(t_hdr->array_offset));
>> +
>> +	ret = snprintf(buf, sizeof(t_esi->value_desc), "%s\n",
>> +		       t_esi->value_desc);
>> +	if (ret < 0)
>> +		ret = -EIO;
>> +out:
>> +	kfree(t_buf);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct papr_ops_info {
>> +	const char *attr_name;
>> +	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *kobj_attr,
>> +			char *buf);
>> +} ops_info[MAX_ATTRS] = {
>> +	{ "desc", papr_show_desc },
>> +	{ "value", papr_show_value },
>> +	{ "value_desc", papr_show_value_desc },
> What is wrong with just using the __ATTR_RO() macro and then having an
> array of attributes in a single group?  That should be a lot simpler
> overall, right?

If I understand this correctly, you mean I can have a array of attributes in a
flat single group?
I suppose that would be a simpler, given your earlier suggestion to wrap
attribute values up in a single file per attribute.

However, the intent of grouping and keeping files separate was that each sysfs
file has only one value to display.

I can change it to using an array of attributes in a single group too if you
believe that is right way to go instead.

>> +};
>> +
>> +static void add_attr(u64 id, int index, struct papr_attr *attr)
>> +{
>> +	attr->id = id;
>> +	sysfs_attr_init(&attr->kobj_attr.attr);
>> +	attr->kobj_attr.attr.name = ops_info[index].attr_name;
>> +	attr->kobj_attr.attr.mode = 0444;
>> +	attr->kobj_attr.show = ops_info[index].show;
> If you do the above, no need for this function at all.
>
>> +}
>> +
>> +static int add_attr_group(u64 id, struct papr_group *pg, bool show_val_desc)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_ATTRS; i++) {
>> +		if (!strcmp(ops_info[i].attr_name, "value_desc") &&
>> +		    !show_val_desc) {
>> +			continue;
>> +		}
>> +		add_attr(id, i, &pg->pgattrs[i]);
>> +		pg->pg.attrs[i] = &pg->pgattrs[i].kobj_attr.attr;
>> +	}
>> +
>> +	return sysfs_create_group(esi_kobj, &pg->pg);
> Again, if you just have a list of attributes, there's no need for this
> function either.
>
> I think this can be a lot simpler than you are currently making it.

I agree, if the groups are eliminated, then all the complexity of adding a
attribute groups vanishes as well.

Thanks for your feedback again.
Pratik

> thanks,
>
> greg k-h

