Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B403A7D29
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 13:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFOLdX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 07:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhFOLdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 07:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623756675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQ2nOAspl2AGDi9hsIXoVirS49xlNLfSm3ZVd3FKUiQ=;
        b=MhniVwOZ4jcNpZ+mqxKjf5LQBwxwaczLjeLmwKfG00lfyJWXA283NbUyXeSiVuVKJS1V39
        BwReT4PqVs264NJ9V1Ugx5yk/xplmhsx/ZnIPsmd2XReq+Lt8cvbX+A9O7aSUejN6083tE
        +JYo7i1RIPGjC8kSXo9Buh6Nq+1MTyc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Uw9QRGDyPMuCijFKCPmdtw-1; Tue, 15 Jun 2021 07:31:14 -0400
X-MC-Unique: Uw9QRGDyPMuCijFKCPmdtw-1
Received: by mail-ed1-f70.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso13458043edc.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 04:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQ2nOAspl2AGDi9hsIXoVirS49xlNLfSm3ZVd3FKUiQ=;
        b=VRqXfYsGM8xJ2m5bfViyY3OpbLWqNW7N+wcqnAhEoAiHJoh649M+P05p2He6jNpUeX
         1v6NueY6G2Q08cqzoyloypVtFoA1HqSfN8kYFk6JRxfE8K2d9XP2E9sAk1144/yVIbtz
         YUvo+uIcidv2c7mRp9Nwt0HEqCbuJfcap4XHmvy5jdG5TeVy+4GdSrNW2OI7u783rtS1
         oYtkBZuxB6GN0URPQk7bZ0fcUTlc7qKgOEw1J0YLS6EvgYm5OllWXwFktJkZDbWXecNz
         dOduxzkIj3YTkRzziQfgMl4eGapfmxV9IZtLPv2f+wnGU/AyDwv6L8TBZlRVIZ9YtN7E
         O8xg==
X-Gm-Message-State: AOAM530d3sAjmXlwIbO36xVyJ/2GCWyNLBG8mic4CfqrePLvBll4e8u5
        /d0g4ry+IgCgGGF75tEQI8954ffJep+Nkd2qjDxv/hnf9MrYnwKPRMSjjxsQHwoQxfhI7Ix/ce5
        E2zIRvybOiq20HFTqKv3RDNirwCIM
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr20563668ejs.286.1623756673664;
        Tue, 15 Jun 2021 04:31:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKlp02kMxK2rO+S69nIrAnTgSLt5X2p2XEkmw4RDKa1lrb0dqopq+Tz3VP4q2ZjtECG1DKNg==
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr20563625ejs.286.1623756673461;
        Tue, 15 Jun 2021 04:31:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u21sm7110928eja.59.2021.06.15.04.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 04:31:12 -0700 (PDT)
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
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
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <b86aa6df-5fd7-d705-1688-4d325df6f7d9@metux.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v9 0/5] KVM statistics data fd-based binary interface
Message-ID: <ad7905f9-8338-382a-b1df-9b3352bbd2f8@redhat.com>
Date:   Tue, 15 Jun 2021 13:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b86aa6df-5fd7-d705-1688-4d325df6f7d9@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/06/21 10:37, Enrico Weigelt, metux IT consult wrote:
> * why is it binary instead of text ? is it so very high volume that
>    it really matters ?

The main reason to have a binary format is not the high volume actually 
(though it also has its part).  Rather, we would really like to include 
the schema to make the statistics self-describing.  This includes stuff 
like whether the unit of measure of a statistic is clock cycles, 
nanoseconds, pages or whatnot; having this kind of information in text 
leads to awkwardness in the parsers.  trace-cmd is another example where 
the data consists of a schema followed by binary data.

Text format could certainly be added if there's a usecase, but for 
developer use debugfs is usually a suitable replacement.

Last year we tried the opposite direction: we built a one-value-per-file 
filesystem with a common API that any subsystem could use (e.g. 
providing ethtool stats, /proc/interrupts, etc. in addition to KVM 
stats).  We started with text, similar to sysfs, with the plan of 
extending it to a binary format later.  However, other subsystems 
expressed very little interest in this, so instead we decided to go with 
something that is designed around KVM needs.

Still, the binary format that KVM uses is designed not to be 
KVM-specific.  If other subsystems want to publish high-volume, 
self-describing statistic information, they are welcome to share the 
binary format and the code.  Perhaps it may make sense in some cases to 
have them in sysfs, even (e.g. /sys/kernel/slab/*/.stats).  As Greg said 
sysfs is currently one value per file, but perhaps that could be changed 
if the binary format is an additional way to access the information and 
not the only one (not that I'm planning to do it).

> * how will possible future extensions of the telemetry packets work ?

The format includes a schema, so it's possible to add more statistics in 
the future.  The exact list of statistics varies per architecture and is 
not part of the userspace API (obvious caveat: https://xkcd.com/1172/).

> * aren't there other means to get this fd instead of an ioctl() on the
>    VM fd ? something more from the outside (eg. sysfs/procfs)

Not yet, but if there's a need it can be added.  It'd be plausible to 
publish system-wide statistics via a ioctl on /dev/kvm, for example. 
We'd have to check how this compares with stuff that is world-readable 
in procfs and sysfs, but I don't think there are security concerns in 
exposing that.

There's also pidfd_getfd(2) which can be used to pull a VM file 
descriptor from another running process.  That can be used to avoid the 
issue of KVM file descriptors being unnamed.

> * how will that relate to other hypervisors ?

Other hypervisors do not run as part of the Linux kernel (at least they 
are not upstream).  These statistics only apply to Linux *hosts*, not 
guests.

As far as I know, there is no standard that Xen or the proprietary 
hypervisors use to communicate their telemetry info to monitoring tools, 
and also no standard binary format used by exporters to talk to 
monitoring tools.  If this format will be adopted by other hypervisors 
or any random software, I will be happy.

> Some notes from the operating perspective:
> 
> In typical datacenters we've got various monitoring tools that are able
> to catch up lots of data from different sources (especially files). If
> an operator e.g. is interested in something in happening in some file
> (e.g. in /proc of /sys), it's quite trivial - just configure yet another
> probe (maybe some regex for parsing) and done. Automatically fed in his
> $monitoring_solution (e.g. nagios, ELK, Splunk, whatsnot)

... but in practice what you do is you have prebuilt exporters that 
talks to $monitoring_solution.  Monitoring individual files is the 
exception, not the rule.  But indeed Libvirt already has I/O and network 
statistics and there is an exporter for Prometheus, so we should add 
support for this new method as well to both QEMU (exporting the file 
descriptor) and Libvirt.

I hope this helps clarifying your doubts!

Paolo

> With your approach, it's not that simple: now the operator needs to
> create (and deploy and manage) a separate agent that somehow receives
> that fd from the VMM, reads and parses that specific binary stream
> and finally pushes it into the monitoring infrastructure. Or the VMM
> writes it into some file, where some monitoring agent can pick it up.
> In any case, not actually trivial from ops perspective.

