Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CDE389C6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 06:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETEXQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 May 2021 00:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhETEXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 May 2021 00:23:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99FC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 21:21:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x188so11419190pfd.7
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DoLjvzR9Ycpjqcta0VpSiJR4Bdnq46dPXdEKwxdkZyE=;
        b=KhAuP9uJ0n9pmyTFOxYfvk0m31c9RU1ZSXij+ksAklnEMQOxYzFB8F2NghHrxa0v/q
         wL/kdDf2JVSyJJnvOnZAZnOHIQwbe3g3IwaONeGKzObQDxihAExXUsj1UNM+FeUaxaCB
         cs3C6C6BObrMp27EBsoNGKxVfSeEpoLskJddVXnFZCV4+9TX18AgZvLNSOzUDsw9nUkg
         P0OgZzuc4/aPq+MHVU37o5Rsxp6/Gh/tbpXovUKYmvQmUWUws3uSDkvk9k13v3DQr1VX
         qJrP3ehBjk3P/TTsuttFjfSyzxtdq7PiNymDcP30iofWSZVHWs4jHZoUb0uN7/oXndKL
         vkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DoLjvzR9Ycpjqcta0VpSiJR4Bdnq46dPXdEKwxdkZyE=;
        b=TwDQlnLwLNR28tQecC9XPgxiTgZh+PRLHuuqhEebb3XSvkR2TFu3WHnmhCMkDrqog/
         gYVite5n7S37DRrdfywDY/2kK8/WQYUyPB0ZhvwZ9M6ViDawGaLGMBVX22OLSMEVAv58
         sf1drfx4bdJq/B2023v+CojbXOsOJCfGuorJjheOl/rzMVmLPXRzVyOpZ0wOJt7DXova
         INmQ4hqI9DLhhHH8QxOtQX8U/MRglcsyvSNJ5ge93tnJZ+c8zKovXB4zaUlzNeBzRAV3
         Ea8tieklQSDmPiFjBjT5I/8hIorL+IvdV64zF1mZZ1jOUNTp9QWVSv/sysw1RtQ7ymGX
         PYMw==
X-Gm-Message-State: AOAM53072GXAGuud5uqrLxZSApg3Wn0tHl5DqTMK6OLejG778CTr0hoF
        qfiqN63t9TAUOblwvT+B1SkBKw==
X-Google-Smtp-Source: ABdhPJyUT/W5KKf6QPkIVjnToQh3ryfQCsYn+WRFe/r3PlLYmoitMteeLZgd2ATqkGcuRlOqcbdSDw==
X-Received: by 2002:a62:860b:0:b029:28e:d45b:4d2e with SMTP id x11-20020a62860b0000b029028ed45b4d2emr2616829pfd.70.1621484514603;
        Wed, 19 May 2021 21:21:54 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with ESMTPSA id j23sm738541pfh.179.2021.05.19.21.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 21:21:53 -0700 (PDT)
Date:   Wed, 19 May 2021 21:21:50 -0700
From:   Ricardo Koller <ricarkol@google.com>
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [PATCH v5 2/4] KVM: stats: Add fd-based API to read binary stats
 data
Message-ID: <YKXj3gHvUoLnojzB@google.com>
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-3-jingzhangos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517145314.157626-3-jingzhangos@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 17, 2021 at 02:53:12PM +0000, Jing Zhang wrote:
> Provides a file descriptor per VM to read VM stats info/data.
> Provides a file descriptor per vCPU to read vCPU stats info/data.
> 
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  arch/arm64/kvm/guest.c    |  26 +++++
>  arch/mips/kvm/mips.c      |  52 +++++++++
>  arch/powerpc/kvm/book3s.c |  52 +++++++++
>  arch/powerpc/kvm/booke.c  |  45 ++++++++
>  arch/s390/kvm/kvm-s390.c  | 117 ++++++++++++++++++++
>  arch/x86/kvm/x86.c        |  53 +++++++++
>  include/linux/kvm_host.h  | 127 ++++++++++++++++++++++
>  include/uapi/linux/kvm.h  |  50 +++++++++
>  virt/kvm/kvm_main.c       | 223 ++++++++++++++++++++++++++++++++++++++
>  9 files changed, 745 insertions(+)
> 
  
> +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> +			      size_t size, loff_t *offset)
> +{
> +	char id[KVM_STATS_ID_MAXLEN];
> +	struct kvm_vcpu *vcpu = file->private_data;
> +	ssize_t copylen, len, remain = size;
> +	size_t size_header, size_desc, size_stats;
> +	loff_t pos = *offset;
> +	char __user *dest = user_buffer;
> +	void *src;

Nit. Better to do pointer arithmetic on a "char *".  Note that gcc and
clang will do the expected thing.

> +
> +	snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> +			task_pid_nr(current), vcpu->vcpu_id);
> +	size_header = sizeof(kvm_vcpu_stats_header);
> +	size_desc =
> +		kvm_vcpu_stats_header.count * sizeof(struct _kvm_stats_desc);
> +	size_stats = sizeof(vcpu->stat);
> +
> +	len = sizeof(id) + size_header + size_desc + size_stats - pos;
> +	len = min(len, remain);
> +	if (len <= 0)
> +		return 0;
> +	remain = len;

If 'desc_offset' is not right after the header, then the 'len'
calculation is missing the gap into account. For example, assuming there
is a gap of 0x1000000 between the header and the descriptors:

	desc_offset = sizeof(id) + size_header + 0x1000000

and the user calls the ioctl with enough space for the whole file,
including the gap:

	*offset = 0
	size = sizeof(id) + size_header + size_desc + size_stats + 0x1000000

then 'remain' gets the wrong size:

	remain = sizeof(id) + size_header + size_desc + size_stats

and ... (more below)

> +
> +	/* Copy kvm vcpu stats header id string */
> +	copylen = sizeof(id) - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)id + pos;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm vcpu stats header */
> +	copylen = sizeof(id) + size_header - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)&kvm_vcpu_stats_header;
> +		src += pos - sizeof(id);
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm vcpu stats descriptors */
> +	copylen = kvm_vcpu_stats_header.desc_offset + size_desc - pos;

This would be the state at this point:

	pos	= sizeof(id) + size_header
	copylen	= sizeof(id) + size_header + 0x1000000 + size_desc - (sizeof(id) + size_header)
		= 0x1000000 + size_desc
	remain	= size_desc + size_stats

> +	copylen = min(copylen, remain);

	copylen = size_desc + size_stats

which is not enough to copy the descriptors (and the data).

> +	if (copylen > 0) {
> +		src = (void *)&kvm_vcpu_stats_desc;
> +		src += pos - kvm_vcpu_stats_header.desc_offset;

Moreover, src also needs to take the gap into account.

	src	= &kvm_vcpu_stats_desc + (sizeof(id) + size_header) - (sizeof(id) + size_header + 0x1000000)
		= &kvm_vcpu_stats_desc - 0x1000000

Otherwise, src ends up pointing at the wrong place.

> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm vcpu stats values */
> +	copylen = kvm_vcpu_stats_header.data_offset + size_stats - pos;

The same problem occurs here. There is a potential gap before
data_offset that needs to be taken into account for src and len.

Would it be possible to just ensure that there is no gap? maybe even
remove data_offset and desc_offset and always place them adjacent, and
have the descriptors right after the header.

> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)&vcpu->stat;
> +		src += pos - kvm_vcpu_stats_header.data_offset;
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
> +
>  



> +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> +			      size_t size, loff_t *offset)
> +{

Consider moving the common code between kvm_vcpu_stats_read and this one
into some function that takes pointers to header, desc, and data. Unless
there is something vcpu or vm specific besides that.

> +	char id[KVM_STATS_ID_MAXLEN];
> +	struct kvm *kvm = file->private_data;
> +	ssize_t copylen, len, remain = size;
> +	size_t size_header, size_desc, size_stats;
> +	loff_t pos = *offset;
> +	char __user *dest = user_buffer;
> +	void *src;
> +
> +	snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> +	size_header = sizeof(kvm_vm_stats_header);
> +	size_desc = kvm_vm_stats_header.count * sizeof(struct _kvm_stats_desc);
> +	size_stats = sizeof(kvm->stat);
> +
> +	len = sizeof(id) + size_header + size_desc + size_stats - pos;
> +	len = min(len, remain);
> +	if (len <= 0)
> +		return 0;
> +	remain = len;
> +
> +	/* Copy kvm vm stats header id string */
> +	copylen = sizeof(id) - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)id + pos;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm vm stats header */
> +	copylen = sizeof(id) + size_header - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)&kvm_vm_stats_header;
> +		src += pos - sizeof(id);
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm vm stats descriptors */
> +	copylen = kvm_vm_stats_header.desc_offset + size_desc - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)&kvm_vm_stats_desc;
> +		src += pos - kvm_vm_stats_header.desc_offset;
> +		if (copy_to_user(dest, src, copylen))
> +			return -EFAULT;
> +		remain -= copylen;
> +		pos += copylen;
> +		dest += copylen;
> +	}
> +	/* Copy kvm vm stats values */
> +	copylen = kvm_vm_stats_header.data_offset + size_stats - pos;
> +	copylen = min(copylen, remain);
> +	if (copylen > 0) {
> +		src = (void *)&kvm->stat;
> +		src += pos - kvm_vm_stats_header.data_offset;
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
> +
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
