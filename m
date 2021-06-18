Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05FD3AC451
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 08:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFRG7Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 02:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFRG7P (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 02:59:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30D360BBB;
        Fri, 18 Jun 2021 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623999426;
        bh=OpRB/syoWzmdb29I/v2+BhPjDBLNqxmh7heWVRF0lJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lUayyXL/vVX5/hSQzVm+ZrRA7eTkrQ8ZZUMVM+o3xwBGz8rUPisuGQyVyWWJrzgr
         EpyxMDjENopYOPBtAYjH7Ebsd9MK4jNeCQEhKCiFCUiRkfKGtnpok9astNDuEBbBvj
         P9EDcKp78CwrYzW+weXo3YWcljQXnMuOhiz/jgjE=
Date:   Fri, 18 Jun 2021 08:57:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary
 stats data
Message-ID: <YMxDv5BgfdMn2Y9b@kroah.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-3-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618044819.3690166-3-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Minor comment nits:

On Fri, Jun 18, 2021 at 04:48:14AM +0000, Jing Zhang wrote:
> +/*
> + * Common vm/vcpu stats read function to userspace.

Should you use a real kernel-doc style here?  You almost are, might as
well do it "right" :)

> + * @id: identification string of the stats
> + * @header: stats header for a vm or a vcpu
> + * @desc: start address of an array of stats descriptors for a vm or a vcpu
> + * @stats: start address of stats data block for a vm or a vcpu
> + * @size_stats: the size of stats data block pointed by @stats
> + * @user_buffer: start address of userspace buffer
> + * @size: requested read size from userspace
> + * @offset: the start position from which the content will be read for the
> + *          corresponding vm or vcp file descriptor
> + *
> + * The file content of a vm/vcpu file descriptor is now defined as below:
> + * +-------------+
> + * |   Header    |
> + * +-------------+
> + * | Descriptors |
> + * +-------------+
> + * | Stats Data  |
> + * +-------------+

Where is the "header id string"?  In the header?

> + * Although this function allows userspace to read any amount of data (as long
> + * as in the limit) from any position, the typical usage would follow below
> + * steps:
> + * 1. Read header from offset 0. Get the offset of descriptors and stats data
> + *    and some other necessary information. This is a one-time work for the
> + *    lifecycle of the corresponding vm/vcpu stats fd.
> + * 2. Read descriptors from its offset and discover all the stats by parsing
> + *    descriptors. This is a one-time work for the lifecycle of the
> + *    corresponding vm/vcpu stats fd.
> + * 3. Periodically read stats data from its offset.

You forgot "2.5.  rewind fd pointer position", see below...

> + */
> +ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
> +		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
> +		char __user *user_buffer, size_t size, loff_t *offset)
> +{
> +	ssize_t len;
> +	ssize_t copylen;
> +	ssize_t remain = size;
> +	size_t size_desc;
> +	size_t size_header;
> +	void *src;
> +	loff_t pos = *offset;
> +	char __user *dest = user_buffer;
> +
> +	size_header = sizeof(*header);
> +	size_desc = header->count * sizeof(*desc);
> +
> +	len = KVM_STATS_ID_MAXLEN + size_header + size_desc + size_stats - pos;
> +	len = min(len, remain);
> +	if (len <= 0)
> +		return 0;
> +	remain = len;
> +
> +	/* Copy kvm stats header.
> +	 * The header is the first block of content userspace usually read out.
> +	 * The pos is 0 and the copylen and remain would be the size of header.
> +	 * The copy of the header would be skipped if offset is larger than the
> +	 * size of header. That usually happens when userspace reads stats
> +	 * descriptors and stats data.
> +	 */

Looks like this is the networking "style" of multi-line comments, not
the rest of the kernel.  You might want to fix this up to be the normal
style which would be:

	/*
	 * Copy kvm stats header.
	 * The header is the first block of content userspace usually read out.
	 * The pos is 0 and the copylen and remain would be the size of header.
	 * The copy of the header would be skipped if offset is larger than the
	 * size of header. That usually happens when userspace reads stats
	 * descriptors and stats data.
	 */

I do not know how picky the kvm maintainers are about this, that's up to
them :)


> +	copylen = size_header - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)header + pos;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	/* Copy kvm stats header id string.
> +	 * The id string is unique for every vm/vcpu, which is stored in kvm
> +	 * and kvm_vcpu structure.
> +	 */

This header too is skipped if necessary, so you should say that as well.


> +	copylen = size_header + KVM_STATS_ID_MAXLEN - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = id + pos - size_header;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	/* Copy kvm stats descriptors.
> +	 * The descriptors copy would be skipped in the typical case that
> +	 * userspace periodically read stats data, since the pos would be
> +	 * greater than the end address of descriptors
> +	 * (header->header.desc_offset + size_desc) causing copylen <= 0.
> +	 */

But you say that it is skipped here.

> +	copylen = header->desc_offset + size_desc - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)desc + pos - header->desc_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	/* Copy kvm stats values */
> +	copylen = header->data_offset + size_stats - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = stats + pos - header->data_offset;

This lets you sync to the end of the header and read just the stats, but
does that mean that userspace keeps needing to "rewind" back to the end
of the header to read the stats again?

Or can it just keep reading off the end of the previous read?

It's not quite obvious here, and I mention that above in step "2.5", so
maybe I am wrong, which is fine, but then I'm confused :)


thanks,

greg k-h
