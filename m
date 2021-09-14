Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD740B422
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhINQGk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 12:06:40 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:21664 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbhINQGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 12:06:39 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2021 12:06:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631635156;
    s=strato-dkim-0002; d=xenosoft.de;
    h=Date:Message-ID:To:Subject:From:Cc:Cc:Date:From:Subject:Sender;
    bh=k9TIbzaI6YCzIIim5KA1yto+Q6vQDBo2qeUwWSXaJAY=;
    b=BjUFbC9IHKRz/mEX/uXthUk4lN1ChBd2iHCRaR8VepJ3H3lAfkD7yK3maQ51RTSZ4D
    Ls3MIruKK2ozwMKjSbxiZp+NrZVrnZHUlv6bZXxVNg9ktcR8CLL/gLgSlr3hL2zEPj8W
    7XSqdxKM99U0Ia3zC9u0ljpuv0OUlD89jBqLZEy4DoehYIqy9raC92Dmg8KAP5ASiJkV
    j6pFMkJR8RSL0Jvm1jsmb3uoq/XLdHrruKDxpSdH48ew8pIKqqNzuOPv5gbuNIs6LStP
    tGv4H3WlWFzEnk7afaSEF4m5Xw5lh4u/5KG8LUvA2or7FeAwhsRDsxNfHN+KGej8Q22h
    G+2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhQJ6mmIg736XZSO7Y3Xb2NMPx2Lg=="
X-RZG-CLASS-ID: mo00
Received: from Christians-iMac.fritz.box
    by smtp.strato.de (RZmta 47.33.3 AUTH)
    with ESMTPSA id a03989x8EFxEFP3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 14 Sep 2021 17:59:14 +0200 (CEST)
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Huacai Chen," <chenhuacai@kernel.org>,
        "Aleksandar Markovic," <aleksandar.qemu.devel@gmail.com>,
        "Thomas Bogendoerfer," <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt," <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Vitaly, Kuznetsov" <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH 2/2] kvm: rename KVM_MAX_VCPU_ID to, KVM_MAX_VCPU_IDS
To:     Juergen Gross <jgross@suse.com>
Message-ID: <6d3333b1-05cc-103b-4bdb-88bec5e3e9fd@xenosoft.de>
Date:   Tue, 14 Sep 2021 17:59:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Juergen,
Hello All,

Since the RC1 of kernel 5.13, -smp 2 and -smp 4 don't work with a 
virtual e5500 QEMU KVM-HV machine anymore. [1]
I see in the serial console, that the uImage doesn't load. I use the 
following QEMU command for booting:

qemu-system-ppc64 -M ppce500 -cpu e5500 -enable-kvm -m 1024 -kernel 
uImage -drive format=raw,file=MintPPC32-X5000.img,index=0,if=virtio 
-netdev user,id=mynet0 -device virtio-net,netdev=mynet0 -append "rw 
root=/dev/vda" -device virtio-vga -device virtio-mouse-pci -device 
virtio-keyboard-pci -device pci-ohci,id=newusb -device 
usb-audio,bus=newusb.0 -smp 4

The kernels boot without KVM-HV.

Summary for KVM-HV:

-smp 1 -> works
-smp 2 -> doesn't work
-smp 3 -> works
-smp 4 -> doesn't work

I used -smp 4 before the RC1 of kernel 5.13 because my FSL P5040 BookE 
machine [2] has 4 cores.

Does this patch solve this issue? [3]

Thanks,
Christian

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-May/229103.html
[2] http://wiki.amiga.org/index.php?title=X5000
[3] 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-September/234152.html
