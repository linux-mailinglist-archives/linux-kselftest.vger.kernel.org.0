Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC13A792B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFOIkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 04:40:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFOIkD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 04:40:03 -0400
Received: from [192.168.1.155] ([95.115.9.120]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MYcy3-1lpPX61RGl-00VeCh; Tue, 15 Jun 2021 10:37:39 +0200
Subject: Re: [PATCH v9 0/5] KVM statistics data fd-based binary interface
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
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
References: <20210614212155.1670777-1-jingzhangos@google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <b86aa6df-5fd7-d705-1688-4d325df6f7d9@metux.net>
Date:   Tue, 15 Jun 2021 10:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210614212155.1670777-1-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vod45xLxHxZ5p8qYKvuWym3LEAiarmlv0Xbt34OpNBV9uy1sBdE
 IRftON+oudc8QVSK3OpycOl49aHJfySAgkANRqrTI39LcdQIXpjA7mxltjpeNzUcQSldpbN
 9MatQnRvvRMJJ8elPHcd2BkxKXtnpLxALuiGllUwQeIJ/pSfjl/1Ju+2MmxGm86GlBu1W06
 ZMtU7WHK45h2IdXcp/e8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+53FXRRHLqc=:mz+uz7bhnpeydAZf0N2025
 PzwGuvUWyPVQfHIrPDNsiRUyENR8k8pU+IrQTGZS1wnh9dAW8iuHrnc1m2pJ3oMjaQSkDQfYE
 CitMcMEor434oAPJQjN+scqfRgySjAt2AMJpYyCkXEnjuNLL435UQVMezynLHSeRwuZ3mbYhv
 wwNIBxhtwjP7SVCR9sHWQMJzG+1zH/4+qxGxAb9sDf80fkBI07uRQz5xuvmLVq7WGoWF74/Us
 BQiBgnydw4wY4V1J5Y5yEAwuoKhnbDEyPZHgJvQT1w1FMWuELbaEz6VH6F+SXOPaAlywjQe7q
 WGTk8EjDeLtaCIS9fu2JoA0zWjjS4a4EEo684bMWJScBce+ezZ/9MV7YfgKmdb16Tr0FIJWya
 +bz0ZJ5j2y6JQlx5SiGGMEUCnQUBNS7Fm5VA0Sa3ZK1jXEY5/DPcdideck40Dn+2OPAZuXtU9
 ESR5huX3pYZYRU/wFSEiLE4jZIbf867UrKIgkQCDL+90WY3iyjt/tICjAmssa+jDfqp5+UZuZ
 2L9tw9OzjAAntKVmcEinnI=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14.06.21 23:21, Jing Zhang wrote:

Hi,

> This patchset provides a file descriptor for every VM and VCPU to read
> KVM statistics data in binary format.

I've missed the discussions of previous versions, so please forgive my
stupid questions:

* why is it binary instead of text ? is it so very high volume that
   it really matters ?
* how will possible future extensions of the telemetry packets work ?
* aren't there other means to get this fd instead of an ioctl() on the
   VM fd ? something more from the outside (eg. sysfs/procfs)
* how will that relate to other hypervisors ?

Some notes from the operating perspective:

In typical datacenters we've got various monitoring tools that are able
to catch up lots of data from different sources (especially files). If
an operator e.g. is interested in something in happening in some file
(e.g. in /proc of /sys), it's quite trivial - just configure yet another
probe (maybe some regex for parsing) and done. Automatically fed in his
$monitoring_solution (e.g. nagios, ELK, Splunk, whatsnot)

With your approach, it's not that simple: now the operator needs to
create (and deploy and manage) a separate agent that somehow receives
that fd from the VMM, reads and parses that specific binary stream
and finally pushes it into the monitoring infrastructure. Or the VMM
writes it into some file, where some monitoring agent can pick it up.
In any case, not actually trivial from ops perspective.

In general I tend to like the fd approach (even though I don't like
ioctls very much - I'd rather like to have it more Plan9-like ;-)).
But it has the drawback of acquiring those fd's by separate processes
isn't entirely easy and needs a lot of coordinated interaction.

That issue would be much easier if we had the ability to publish
existing fd's into the file system (like Plan9's srvfs does), but we
don't have that yet. (actually, I've hacked up some srvfs for Linux,
but ... well ... it's just a hack, nowhere near to production).

Why not putting this into sysfs ?

I see two options:

a) if it's really kvm-specific (and no chance of using the same
    interface for other hypervisors), we could put it under the
    kvm device (/sys/class/misc/kvm).

b) have a generic VMM stats interface that theroretically could work
    with any hypervisor.



--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
