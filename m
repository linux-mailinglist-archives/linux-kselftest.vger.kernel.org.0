Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27D41B1C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhI1OOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 10:14:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240908AbhI1OOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 10:14:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SC8E2m006152;
        Tue, 28 Sep 2021 10:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3wsbUkqmrx13+n8Rxa7S2JfyWOpm1Ji/LvMcjMremB0=;
 b=AuEchPTcsc87wIF6Opmsi0DaJE6HqQXQ8QmUmYDcZGW/ekMhfwQWs75njIoHisdC7S1I
 TaHse76i1WXW6Lim9ZGOTU1PBean8EzluHshrmpwERZ/V/b4IotzeapcCnmqwBFntXAB
 /ptuAtCveC/BTjGlVftIAgLmZLvIam0hycJpS1OtfMOox1I5knUnuXdLrSeS+ijFSJns
 aWbRmymRHCgy50KHEEGySnHQzDYOc6P2w0LK/1+eQHp9t32/pAFKJ4hmJ61avOvMQBi3
 0OLV1yPaa2sWWHfq6RzWijnNML/J1fg+kQmq8+g2hMGacF9c+JEc3dgIIANmao897Dl8 zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bc092ebnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 10:12:04 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18SDe4bA003559;
        Tue, 28 Sep 2021 10:12:03 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bc092ebkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 10:12:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18SE3Gta021696;
        Tue, 28 Sep 2021 14:12:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3b9u1jeunq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 14:12:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18SEBqWF46137710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 14:11:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC83E52065;
        Tue, 28 Sep 2021 14:11:52 +0000 (GMT)
Received: from [9.43.58.127] (unknown [9.43.58.127])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3872352054;
        Tue, 28 Sep 2021 14:11:45 +0000 (GMT)
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
 <289d2081-7ae8-f76a-5180-49bc6061a05c@linux.ibm.com>
 <YVMfonwjmbgL/ZCX@kroah.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <1d8e82ab-fab7-d014-c812-2c086dd7a63f@linux.ibm.com>
Date:   Tue, 28 Sep 2021 19:41:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVMfonwjmbgL/ZCX@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: apBFcd0aGB2zWRr9xoHDNOJkogDDUscS
X-Proofpoint-GUID: 7ThZpnyAIZBb16ZL2TgNz6ueBR9BpeJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280081
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 28/09/21 7:28 pm, Greg KH wrote:
> On Tue, Sep 28, 2021 at 06:13:18PM +0530, Pratik Sampat wrote:
>> Hello Greg,
>>
>> Thank you for your review.
>>
>> On 28/09/21 5:38 pm, Greg KH wrote:
>>> On Tue, Sep 28, 2021 at 05:21:01PM +0530, Pratik R. Sampat wrote:
>>>> Adds a generic interface to represent the energy and frequency related
>>>> PAPR attributes on the system using the new H_CALL
>>>> "H_GET_ENERGY_SCALE_INFO".
>>>>
>>>> H_GET_EM_PARMS H_CALL was previously responsible for exporting this
>>>> information in the lparcfg, however the H_GET_EM_PARMS H_CALL
>>>> will be deprecated P10 onwards.
>>>>
>>>> The H_GET_ENERGY_SCALE_INFO H_CALL is of the following call format:
>>>> hcall(
>>>>     uint64 H_GET_ENERGY_SCALE_INFO,  // Get energy scale info
>>>>     uint64 flags,           // Per the flag request
>>>>     uint64 firstAttributeId,// The attribute id
>>>>     uint64 bufferAddress,   // Guest physical address of the output buffer
>>>>     uint64 bufferSize       // The size in bytes of the output buffer
>>>> );
>>>>
>>>> This H_CALL can query either all the attributes at once with
>>>> firstAttributeId = 0, flags = 0 as well as query only one attribute
>>>> at a time with firstAttributeId = id, flags = 1.
>>>>
>>>> The output buffer consists of the following
>>>> 1. number of attributes              - 8 bytes
>>>> 2. array offset to the data location - 8 bytes
>>>> 3. version info                      - 1 byte
>>>> 4. A data array of size num attributes, which contains the following:
>>>>     a. attribute ID              - 8 bytes
>>>>     b. attribute value in number - 8 bytes
>>>>     c. attribute name in string  - 64 bytes
>>>>     d. attribute value in string - 64 bytes
>>>>
>>>> The new H_CALL exports information in direct string value format, hence
>>>> a new interface has been introduced in
>>>> /sys/firmware/papr/energy_scale_info to export this information to
>>>> userspace in an extensible pass-through format.
>>>>
>>>> The H_CALL returns the name, numeric value and string value (if exists)
>>>>
>>>> The format of exposing the sysfs information is as follows:
>>>> /sys/firmware/papr/energy_scale_info/
>>>>      |-- <id>/
>>>>        |-- desc
>>>>        |-- value
>>>>        |-- value_desc (if exists)
>>>>      |-- <id>/
>>>>        |-- desc
>>>>        |-- value
>>>>        |-- value_desc (if exists)
>>>> ...
>>>>
>>>> The energy information that is exported is useful for userspace tools
>>>> such as powerpc-utils. Currently these tools infer the
>>>> "power_mode_data" value in the lparcfg, which in turn is obtained from
>>>> the to be deprecated H_GET_EM_PARMS H_CALL.
>>>> On future platforms, such userspace utilities will have to look at the
>>>> data returned from the new H_CALL being populated in this new sysfs
>>>> interface and report this information directly without the need of
>>>> interpretation.
>>>>
>>>> Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
>>>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>>>> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
>>>> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
>>>> ---
>>>>    .../sysfs-firmware-papr-energy-scale-info     |  26 ++
>>>>    arch/powerpc/include/asm/hvcall.h             |  24 +-
>>>>    arch/powerpc/kvm/trace_hv.h                   |   1 +
>>>>    arch/powerpc/platforms/pseries/Makefile       |   3 +-
>>>>    .../pseries/papr_platform_attributes.c        | 312 ++++++++++++++++++
>>>>    5 files changed, 364 insertions(+), 2 deletions(-)
>>>>    create mode 100644 Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
>>>>    create mode 100644 arch/powerpc/platforms/pseries/papr_platform_attributes.c
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
>>>> new file mode 100644
>>>> index 000000000000..139a576c7c9d
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
>>>> @@ -0,0 +1,26 @@
>>>> +What:		/sys/firmware/papr/energy_scale_info
>>>> +Date:		June 2021
>>>> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
>>>> +Description:	Directory hosting a set of platform attributes like
>>>> +		energy/frequency on Linux running as a PAPR guest.
>>>> +
>>>> +		Each file in a directory contains a platform
>>>> +		attribute hierarchy pertaining to performance/
>>>> +		energy-savings mode and processor frequency.
>>>> +
>>>> +What:		/sys/firmware/papr/energy_scale_info/<id>
>>>> +		/sys/firmware/papr/energy_scale_info/<id>/desc
>>>> +		/sys/firmware/papr/energy_scale_info/<id>/value
>>>> +		/sys/firmware/papr/energy_scale_info/<id>/value_desc
>>>> +Date:		June 2021
>>>> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
>>>> +Description:	Energy, frequency attributes directory for POWERVM servers
>>>> +
>>>> +		This directory provides energy, frequency, folding information. It
>>>> +		contains below sysfs attributes:
>>>> +
>>>> +		- desc: String description of the attribute <id>
>>>> +
>>>> +		- value: Numeric value of attribute <id>
>>>> +
>>>> +		- value_desc: String value of attribute <id>
>>> Can you just make 4 different entries in this file, making it easier to
>>> parse and extend over time?
>> Do you mean I only create one file per attribute and populate it with 4
>> different entries as follows?
>>
>> # cat /sys/firmware/papr/energy_scale_info/<id>
>> id:
>> desc:
>> value:
>> value_desc:
> No, I mean in this documentation file, have 4 different "What:" entries,
> don't lump 4 of them together into one larger Description for no reason
> like you did here.
>
> The sysfs files themselves are fine.

Ah okay, I understand what you're saying. I just need to make 4 different
entries in the documentation.
Thanks for that clarification.

>>>> +struct papr_attr {
>>>> +	u64 id;
>>>> +	struct kobj_attribute kobj_attr;
>>> Why does an attribute have to be part of this structure?
>> I bundled both an attribute as well as its ID in a structure because each
>> attributes value could only be queried from the firmware with the corresponding
>> ID.
>> It seemed to be logically connected and that's why I had them in the structure.
>> Are you suggesting we maintain them separately and don't need the coupling?
> The id is connected to the kobject, not the attribute, right?
> Attributes do not have uniqueness like this normally.
>
>
>>>> +static struct papr_ops_info {
>>>> +	const char *attr_name;
>>>> +	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *kobj_attr,
>>>> +			char *buf);
>>>> +} ops_info[MAX_ATTRS] = {
>>>> +	{ "desc", papr_show_desc },
>>>> +	{ "value", papr_show_value },
>>>> +	{ "value_desc", papr_show_value_desc },
>>> What is wrong with just using the __ATTR_RO() macro and then having an
>>> array of attributes in a single group?  That should be a lot simpler
>>> overall, right?
>> If I understand this correctly, you mean I can have a array of attributes in a
>> flat single group?
> Yes.
>
>> I suppose that would be a simpler, given your earlier suggestion to wrap
>> attribute values up in a single file per attribute.
>>
>> However, the intent of grouping and keeping files separate was that each sysfs
>> file has only one value to display.
> That is correct, and not a problem here at all.
>
>> I can change it to using an array of attributes in a single group too if you
>> believe that is right way to go instead.
> You have 3 variables for your attributes:
>
> static struct kobj_attribute papr_desc = __ATTR_RO(desc);
> static struct kobj_attribute papr_value = __ATTR_RO(value);
> static struct kobj_attribute papr_value_desc = __ATTR_RO(value_desc);
>
> and then your attribute group:
> static struct attribute papr_attrs[] = {
> 	&papr_desc.attr,
> 	&papr_value.attr,
> 	&papr_value_desc.attr,
> 	NULL,
> };
>
> ATTRIBUTE_GROUPS(papr);
>
> Then take that papr_groups and register that with the kobject when
> needed.
>
> But, you seem to only be having a whole kobject for a subdirectory,
> right?  No need for that, just name your attribute group, so instead of
>
> ATTRIBUTE_GROUPS(papr);
>
> do:
> static const struct attribute_group papr_group = {
> 	.name = "Your Subdirectory Name here",
> 	.attrs = papr_attrs,
> };
>
> Hope this helps,

Yes, this does!
I understand now that a whole kobject for a sub-directory is futile.
The approach you suggested for having papr_groups register with the kobject
whenever needed is more cleaner.

Thanks for the help, I'll rework my current logic according to that.

Pratik

> greg k-h

