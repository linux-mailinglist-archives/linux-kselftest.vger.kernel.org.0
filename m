Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0A41B16D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbhI1OAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 10:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240898AbhI1OAk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 10:00:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2544860041;
        Tue, 28 Sep 2021 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632837540;
        bh=dENtZyeL5O1vxrdXUljq/re2h9gN1ZPS4UBK/GKPKZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlIo7uDMkfRt0dK3+FFyGyJieSw7QeJgHL7gOcAhT/Ob9wzx6ipm1fmTbozHE9RY8
         Gya2abm+dJkMRuMMbRZlafQkoe2CEKz1Ft8dc2CnInlRZFL/ybURwdkNtUjbVi0psR
         cfd9Q/6HT4AZk6S7L1E1yZG4lFsOV4915wYMiM0s=
Date:   Tue, 28 Sep 2021 15:58:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        shuah@kernel.org, farosas@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
Subject: Re: [PATCH v8 1/2] powerpc/pseries: Interface to represent PAPR
 firmware attributes
Message-ID: <YVMfonwjmbgL/ZCX@kroah.com>
References: <20210928115102.57117-1-psampat@linux.ibm.com>
 <20210928115102.57117-2-psampat@linux.ibm.com>
 <YVMFvyGwfH+rxYPz@kroah.com>
 <289d2081-7ae8-f76a-5180-49bc6061a05c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289d2081-7ae8-f76a-5180-49bc6061a05c@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 28, 2021 at 06:13:18PM +0530, Pratik Sampat wrote:
> Hello Greg,
> 
> Thank you for your review.
> 
> On 28/09/21 5:38 pm, Greg KH wrote:
> > On Tue, Sep 28, 2021 at 05:21:01PM +0530, Pratik R. Sampat wrote:
> > > Adds a generic interface to represent the energy and frequency related
> > > PAPR attributes on the system using the new H_CALL
> > > "H_GET_ENERGY_SCALE_INFO".
> > > 
> > > H_GET_EM_PARMS H_CALL was previously responsible for exporting this
> > > information in the lparcfg, however the H_GET_EM_PARMS H_CALL
> > > will be deprecated P10 onwards.
> > > 
> > > The H_GET_ENERGY_SCALE_INFO H_CALL is of the following call format:
> > > hcall(
> > >    uint64 H_GET_ENERGY_SCALE_INFO,  // Get energy scale info
> > >    uint64 flags,           // Per the flag request
> > >    uint64 firstAttributeId,// The attribute id
> > >    uint64 bufferAddress,   // Guest physical address of the output buffer
> > >    uint64 bufferSize       // The size in bytes of the output buffer
> > > );
> > > 
> > > This H_CALL can query either all the attributes at once with
> > > firstAttributeId = 0, flags = 0 as well as query only one attribute
> > > at a time with firstAttributeId = id, flags = 1.
> > > 
> > > The output buffer consists of the following
> > > 1. number of attributes              - 8 bytes
> > > 2. array offset to the data location - 8 bytes
> > > 3. version info                      - 1 byte
> > > 4. A data array of size num attributes, which contains the following:
> > >    a. attribute ID              - 8 bytes
> > >    b. attribute value in number - 8 bytes
> > >    c. attribute name in string  - 64 bytes
> > >    d. attribute value in string - 64 bytes
> > > 
> > > The new H_CALL exports information in direct string value format, hence
> > > a new interface has been introduced in
> > > /sys/firmware/papr/energy_scale_info to export this information to
> > > userspace in an extensible pass-through format.
> > > 
> > > The H_CALL returns the name, numeric value and string value (if exists)
> > > 
> > > The format of exposing the sysfs information is as follows:
> > > /sys/firmware/papr/energy_scale_info/
> > >     |-- <id>/
> > >       |-- desc
> > >       |-- value
> > >       |-- value_desc (if exists)
> > >     |-- <id>/
> > >       |-- desc
> > >       |-- value
> > >       |-- value_desc (if exists)
> > > ...
> > > 
> > > The energy information that is exported is useful for userspace tools
> > > such as powerpc-utils. Currently these tools infer the
> > > "power_mode_data" value in the lparcfg, which in turn is obtained from
> > > the to be deprecated H_GET_EM_PARMS H_CALL.
> > > On future platforms, such userspace utilities will have to look at the
> > > data returned from the new H_CALL being populated in this new sysfs
> > > interface and report this information directly without the need of
> > > interpretation.
> > > 
> > > Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
> > > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > > Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
> > > Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> > > ---
> > >   .../sysfs-firmware-papr-energy-scale-info     |  26 ++
> > >   arch/powerpc/include/asm/hvcall.h             |  24 +-
> > >   arch/powerpc/kvm/trace_hv.h                   |   1 +
> > >   arch/powerpc/platforms/pseries/Makefile       |   3 +-
> > >   .../pseries/papr_platform_attributes.c        | 312 ++++++++++++++++++
> > >   5 files changed, 364 insertions(+), 2 deletions(-)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> > >   create mode 100644 arch/powerpc/platforms/pseries/papr_platform_attributes.c
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> > > new file mode 100644
> > > index 000000000000..139a576c7c9d
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
> > > @@ -0,0 +1,26 @@
> > > +What:		/sys/firmware/papr/energy_scale_info
> > > +Date:		June 2021
> > > +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> > > +Description:	Directory hosting a set of platform attributes like
> > > +		energy/frequency on Linux running as a PAPR guest.
> > > +
> > > +		Each file in a directory contains a platform
> > > +		attribute hierarchy pertaining to performance/
> > > +		energy-savings mode and processor frequency.
> > > +
> > > +What:		/sys/firmware/papr/energy_scale_info/<id>
> > > +		/sys/firmware/papr/energy_scale_info/<id>/desc
> > > +		/sys/firmware/papr/energy_scale_info/<id>/value
> > > +		/sys/firmware/papr/energy_scale_info/<id>/value_desc
> > > +Date:		June 2021
> > > +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> > > +Description:	Energy, frequency attributes directory for POWERVM servers
> > > +
> > > +		This directory provides energy, frequency, folding information. It
> > > +		contains below sysfs attributes:
> > > +
> > > +		- desc: String description of the attribute <id>
> > > +
> > > +		- value: Numeric value of attribute <id>
> > > +
> > > +		- value_desc: String value of attribute <id>
> > Can you just make 4 different entries in this file, making it easier to
> > parse and extend over time?
> 
> Do you mean I only create one file per attribute and populate it with 4
> different entries as follows?
> 
> # cat /sys/firmware/papr/energy_scale_info/<id>
> id:
> desc:
> value:
> value_desc:

No, I mean in this documentation file, have 4 different "What:" entries,
don't lump 4 of them together into one larger Description for no reason
like you did here.

The sysfs files themselves are fine.

> > > +struct papr_attr {
> > > +	u64 id;
> > > +	struct kobj_attribute kobj_attr;
> > Why does an attribute have to be part of this structure?
> 
> I bundled both an attribute as well as its ID in a structure because each
> attributes value could only be queried from the firmware with the corresponding
> ID.
> It seemed to be logically connected and that's why I had them in the structure.
> Are you suggesting we maintain them separately and don't need the coupling?

The id is connected to the kobject, not the attribute, right?
Attributes do not have uniqueness like this normally.


> > > +static struct papr_ops_info {
> > > +	const char *attr_name;
> > > +	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *kobj_attr,
> > > +			char *buf);
> > > +} ops_info[MAX_ATTRS] = {
> > > +	{ "desc", papr_show_desc },
> > > +	{ "value", papr_show_value },
> > > +	{ "value_desc", papr_show_value_desc },
> > What is wrong with just using the __ATTR_RO() macro and then having an
> > array of attributes in a single group?  That should be a lot simpler
> > overall, right?
> 
> If I understand this correctly, you mean I can have a array of attributes in a
> flat single group?

Yes.

> I suppose that would be a simpler, given your earlier suggestion to wrap
> attribute values up in a single file per attribute.
> 
> However, the intent of grouping and keeping files separate was that each sysfs
> file has only one value to display.

That is correct, and not a problem here at all.

> I can change it to using an array of attributes in a single group too if you
> believe that is right way to go instead.

You have 3 variables for your attributes:

static struct kobj_attribute papr_desc = __ATTR_RO(desc);
static struct kobj_attribute papr_value = __ATTR_RO(value);
static struct kobj_attribute papr_value_desc = __ATTR_RO(value_desc);

and then your attribute group:
static struct attribute papr_attrs[] = {
	&papr_desc.attr,
	&papr_value.attr,
	&papr_value_desc.attr,
	NULL,
};

ATTRIBUTE_GROUPS(papr);

Then take that papr_groups and register that with the kobject when
needed.

But, you seem to only be having a whole kobject for a subdirectory,
right?  No need for that, just name your attribute group, so instead of

ATTRIBUTE_GROUPS(papr);

do:
static const struct attribute_group papr_group = {
	.name = "Your Subdirectory Name here",
	.attrs = papr_attrs,
};

Hope this helps,

greg k-h
