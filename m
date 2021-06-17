Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA53AAD78
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhFQH0j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 03:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFQH0i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 03:26:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5C0A61241;
        Thu, 17 Jun 2021 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623914671;
        bh=kNxTxEwPcYv3NN2DfpZ8GnBN8QRikI5mGsAdJMShdj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vmjn0HbF4vDkLycAFVfFgocX33s32jQVUNaGP0J3DSVKZAgg2IaQrobYDvDawDma7
         x3ikJMr5SuhJwFPLP6HEpPDeER5nEM2UPQEAeKtSe//vF6YDonr90WBlk5yNgc90ZN
         Ffb7TLPNWmUzQseIO/Xbs7cENsIfzLUJos/2MPo0=
Date:   Thu, 17 Jun 2021 09:24:28 +0200
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
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary
 stats data
Message-ID: <YMr4rArKvj3obDEM@kroah.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-3-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617044146.2667540-3-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 04:41:43AM +0000, Jing Zhang wrote:
> Provides a file descriptor per VM to read VM stats info/data.
> Provides a file descriptor per vCPU to read vCPU stats info/data.

Shouldn't this be two separate patches, one for each thing as these are
two different features being added?

Anyway, an implementation question for both of these:

> +static ssize_t kvm_stats_read(struct _kvm_stats_header *header,
> +		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
> +		char __user *user_buffer, size_t size, loff_t *offset)
> +{
> +	ssize_t copylen, len, remain = size;

You are "burying" the fact that remain is initialized here, not nice, I
totally missed it when reading this the first time.

This should be:
	ssize_t copylen;
	ssize_t len;
	ssize_t remain = size;
to be obvious.

Remember you will be looking at this code for the next 20 years, make it
easy to read.

> +	size_t size_header, size_desc;
> +	loff_t pos = *offset;
> +	char __user *dest = user_buffer;
> +	void *src;
> +
> +	size_header = sizeof(*header);
> +	size_desc = header->header.count * sizeof(*desc);
> +
> +	len = size_header + size_desc + size_stats - pos;
> +	len = min(len, remain);
> +	if (len <= 0)
> +		return 0;
> +	remain = len;
> +
> +	/* Copy kvm stats header */
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

I thought you said that you would not provide the header for each read,
if you keep reading from the fd.  It looks like you are adding it here
to each read, or is there some "magic" with pos happening here that I do
not understand?

And if there is "magic" with pos, you should document it as it's not
very obvious :)

> +	/* Copy kvm stats descriptors */
> +	copylen = header->header.desc_offset + size_desc - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)desc + pos - header->header.desc_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm stats values */

New lines between code blocks of doing things?

And again, why copy the decriptor again?  or is it being skipped
somehow?  Ah, I think I see how it's being skipped, if I look really
closely.  But again, it's not obvious, and I could be wrong.  Please
document this REALLY well.

Write code for the developer first, compiler second.  Again, you are
going to be maintaining it for 20+ years, think of your future self...


> +	copylen = header->header.data_offset + size_stats - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = stats + pos - header->header.data_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +
> +	*offset = pos;
> +	return len;
> +}

thanks,

greg k-h
