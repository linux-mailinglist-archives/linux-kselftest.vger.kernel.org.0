Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96693AACE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhFQHFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 03:05:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45215 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhFQHFy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 03:05:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 477165804CA;
        Thu, 17 Jun 2021 03:03:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Jun 2021 03:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=bHJT5oI183t6jXiLX3QAsM6ZuOC
        /RnAjhVkdaNoMjms=; b=tNE1qdbTe2Iwk79XEmxLKNQf/ULyBRs71UgcvFxUPws
        /UOhvLwidIeXxlIssIen9uT+20PVORO+X+Xftl6QQsh/Qq03jAFW6CAhEUX05vv+
        /2ktx/H0Q80COXId5hOFulpBxdXVCx+PiQZ5+Vv1VCCat9WNJpywo/v9MOgsQQrU
        dp/bDGiT5lMYInMG1NPsEsKJe1bc95oYES8TsfSwAGWrwVXcgS2oO1Bg5C2olSxe
        QncDeB9Xa0Z6uv38Q30vFFnWV9ps++M7v5mRgD328yjY/YB5nPLq/vrLaf7yMPnn
        Fz+MfbFTfpjwp9koJfvdOt+DiElCaEtiomO8I+lq6bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bHJT5o
        I183t6jXiLX3QAsM6ZuOC/RnAjhVkdaNoMjms=; b=AMnxMQ0MQLmH+F4tyjDGo5
        tqoJYLL3+fnBDD8a3zA+iMmAOJQPH2s4vdbvcF2fntElefcnM1M1DCo1RQdwVqrr
        noleuZOcVZpgQqJbPUy7u7Imsg3gggcEPGeC/RF0SJ0dhyiO9rEfGiiUQ7KOnJti
        9XWRQDLK6LBzMdHPrrpr/ek7HEfydxfWW6mi+fFvQz3hLj7KSByizRYeRJg+9ptB
        GKE223xx1moa/6rL98j4OOOk1xByNrVnPFYsaTkDhWrag4sU3fTwxPY0IbVmeOZe
        6DfWnJXuyjNlqyKynjhusDUByZgytQMRAN0ZdJrej4wgj4xaptYP8vKpalfFpBuA
        ==
X-ME-Sender: <xms:0PPKYJb4cPZMmeNkJS6hNkBCYqaAXTY8FDRKVyAUWZfO9tFMGaxB4Q>
    <xme:0PPKYAa4rvMOF7kvq4LAPcqOpUFWbZJkRgfeb2sfhJolxArQjeL1JixLjilzjBTbo
    fuDVcX5epR6dA>
X-ME-Received: <xmr:0PPKYL8WoovLaP38NszhOiKK_7Zqlk7gUkvybi-NzcLHKDu5v_tDTHlNxbbyZAoN5_el6eq44Qr1kHTADaDun43-iiwScCrJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeftddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:0PPKYHq1avN6BNEi8vANMkXkqGdQtWEjShfRtV0HMbZf6_OqzR_F1A>
    <xmx:0PPKYEqlNtjyglw52nt_5dKHSTkxKGSQDE69euR7foPlqrSwmgIdMg>
    <xmx:0PPKYNR44zTgO-kpi3UXJ09C5vcWGpVR0mD0YOBytqO5JzNHBAtFDg>
    <xmx:0vPKYHAHy81HipZYNm0Q2g22K9_KDTebTao77ccsKsEu5mpjCw5S-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jun 2021 03:03:44 -0400 (EDT)
Date:   Thu, 17 Jun 2021 09:03:41 +0200
From:   Greg KH <greg@kroah.com>
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
Message-ID: <YMrzzYEkDQNCpnP7@kroah.com>
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
> 
> The KVM stats now is only accessible by debugfs, which has some
> shortcomings this change are supposed to fix:
> 1. Debugfs is not a stable interface for production and it is
>    disabled when kernel Lockdown mode is enabled.

debugfs _could_ be a stable interface if you want it to be and make that
rule for your subsystem.  Disabling it for lockdown mode is a different
issue, and that is a system-wide-policy-decision, not a debugfs-specific
thing.

> 2. Debugfs is organized as "one value per file", it is good for
>    debugging, but not supposed to be used for production.

debugfs IS NOT one-value-per-file, you can do whatever you want in
there.  sysfs IS one-value-per-file, do not get the two confused there.

> 3. Debugfs read/clear in KVM are protected by the global kvm_lock.

That's your implementation issue, not a debugfs issue.

The only "rule" in debugfs is:
	There are no rules.

So while your subsystem might have issues with using debugfs for
statistics like this, that's not debugfs's fault, that's how you want to
use the debugfs files for your subsystem.

> Besides that, there are some other benefits with this change:
> 1. All KVM VM/VCPU stats can be read out in a bulk by one copy
>    to userspace.
> 2. A schema is used to describe KVM statistics. From userspace's
>    perspective, the KVM statistics are self-describing.
> 3. Fd-based solution provides the possibility that a telemetry can
>    read KVM stats in a less privileged situation.

"possiblity"?  Does this work or not?  Have you tested it?

> +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> +			      size_t size, loff_t *offset)
> +{
> +	struct kvm *kvm = file->private_data;
> +
> +	snprintf(&kvm_vm_stats_header.id[0], sizeof(kvm_vm_stats_header.id),
> +			"kvm-%d", task_pid_nr(current));

Why do you write to this static variable for EVERY read?  Shouldn't you
just do it once at open?  How can it change?

Wait, it's a single shared variable, what happens when multiple tasks
open this thing and read from it?  You race between writing to this
variable here and then:

> +	return kvm_stats_read(&kvm_vm_stats_header, &kvm_vm_stats_desc[0],
> +		&kvm->stat, sizeof(kvm->stat), user_buffer, size, offset);

Accessing it here.

So how is this really working?

thanks,

greg k-h
