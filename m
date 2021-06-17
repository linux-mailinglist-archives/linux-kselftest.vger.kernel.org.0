Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B53AB66E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhFQOu3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhFQOu3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 10:50:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB4C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 07:48:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f30so11020421lfj.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xTcig9u+ckmAK7F7nxFSbFSF3LG6qPs6DaQp7FLrvY=;
        b=bygYJMkfBrOTcD5rgvdu2TqpUYCHPRA5N7W6suhW34MjzQ7Q41hSSaiV4p4h1kSB8B
         wtVqMlTitgQM18JdvB7h9Q+oFDUtZ5+vI4b0NNHWxiQOyhK6wSHPrWESvV/RMicAbEB2
         JONdfC82tVgGDbroHeVLo3Zu06osDZZ2CimkJypcMPXAcRddVw5QsLGliJLlP3ZRnfRW
         QBMeN4RVmbyQ6GXkM4cATYRg3sKqyvnFP/9pSO3RCyzzxmSghU06nl6L+xfZxsQeCtwA
         OxuR8KUTSn5/6zjnAcYoWUmGsLpODf/TMKL/SNbBxB4gcI/KyOtgXGVUlZqe9XP1j3C1
         Cw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xTcig9u+ckmAK7F7nxFSbFSF3LG6qPs6DaQp7FLrvY=;
        b=kUANw3gzv6dVGkeuRUhI1uZDfmlsysFVf2RSNUfAZImRbAVcxHv2Zh1No/z2Mjk9nn
         YYKhO/jb+c8jeqMoge0ZPquTPCVt3aJCy6VWE2KnjPppSVlIvb0uon1Ube3x4aSAUqPQ
         ruu3yrrgSD/IE2JIPOyDfgbtbeJc1OvUzf6wCEixmW5MLbQBK1+r9ijXH78F9oziusrh
         Ef3AdIfKQ4T6I6YyiU6aJO1mMA+AFL0MTQBwDgd0ktGf6jZElvi7Hqz2Z1t7LK+6Gc4I
         fqW2W6DhUysi4QNNXozwDL49f392XYenfXv/X5+iTJBixfWZEngaKleaQkKJY6byOWkF
         Dlyg==
X-Gm-Message-State: AOAM533O5caAHx4+k9QPBLUNw9lgDW+IQqfDt2P54ylSznYkrR6hljOQ
        iv+7J+rBUTz9KVl21V+IjsvQT63o71YZWQnGOoAY2w==
X-Google-Smtp-Source: ABdhPJyAGNi+2863i+xt6PnvN+8SqM67FY0o8ilXr0tbP46MEwKu1YD9BBtN+J/dXZivkcBRgfa36w81fk2G41mFTyg=
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr4438454lfe.407.1623941299197;
 Thu, 17 Jun 2021 07:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-3-jingzhangos@google.com> <YMrzzYEkDQNCpnP7@kroah.com>
In-Reply-To: <YMrzzYEkDQNCpnP7@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 09:48:07 -0500
Message-ID: <CAAdAUtibbp4y_Ju4E+EeQ6HmRsEGXycjK-Y_P78xGVySYkftSQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary stats data
To:     Greg KH <greg@kroah.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

On Thu, Jun 17, 2021 at 2:03 AM Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jun 17, 2021 at 04:41:43AM +0000, Jing Zhang wrote:
> > Provides a file descriptor per VM to read VM stats info/data.
> > Provides a file descriptor per vCPU to read vCPU stats info/data.
> >
> > The KVM stats now is only accessible by debugfs, which has some
> > shortcomings this change are supposed to fix:
> > 1. Debugfs is not a stable interface for production and it is
> >    disabled when kernel Lockdown mode is enabled.
>
> debugfs _could_ be a stable interface if you want it to be and make that
> rule for your subsystem.  Disabling it for lockdown mode is a different
> issue, and that is a system-wide-policy-decision, not a debugfs-specific
> thing.
>
> > 2. Debugfs is organized as "one value per file", it is good for
> >    debugging, but not supposed to be used for production.
>
> debugfs IS NOT one-value-per-file, you can do whatever you want in
> there.  sysfs IS one-value-per-file, do not get the two confused there.
>
> > 3. Debugfs read/clear in KVM are protected by the global kvm_lock.
>
> That's your implementation issue, not a debugfs issue.
>
> The only "rule" in debugfs is:
>         There are no rules.
>
> So while your subsystem might have issues with using debugfs for
> statistics like this, that's not debugfs's fault, that's how you want to
> use the debugfs files for your subsystem.
>
You are right. The issues are from how the debugfs is used in KVM stats.
Will fix the text accordingly.
> > Besides that, there are some other benefits with this change:
> > 1. All KVM VM/VCPU stats can be read out in a bulk by one copy
> >    to userspace.
> > 2. A schema is used to describe KVM statistics. From userspace's
> >    perspective, the KVM statistics are self-describing.
> > 3. Fd-based solution provides the possibility that a telemetry can
> >    read KVM stats in a less privileged situation.
>
> "possiblity"?  Does this work or not?  Have you tested it?
>
I should've said "We are able to read KVM stats in a less privileged process".
> > +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> > +                           size_t size, loff_t *offset)
> > +{
> > +     struct kvm *kvm = file->private_data;
> > +
> > +     snprintf(&kvm_vm_stats_header.id[0], sizeof(kvm_vm_stats_header.id),
> > +                     "kvm-%d", task_pid_nr(current));
>
> Why do you write to this static variable for EVERY read?  Shouldn't you
> just do it once at open?  How can it change?
>
> Wait, it's a single shared variable, what happens when multiple tasks
> open this thing and read from it?  You race between writing to this
> variable here and then:
>
> > +     return kvm_stats_read(&kvm_vm_stats_header, &kvm_vm_stats_desc[0],
> > +             &kvm->stat, sizeof(kvm->stat), user_buffer, size, offset);
>
> Accessing it here.
>
> So how is this really working?
>
You are right. We only need to do it once at the open. Will fix it according to
Paolo's suggestion.
> thanks,
>
> greg k-h

Thanks,
Jing
