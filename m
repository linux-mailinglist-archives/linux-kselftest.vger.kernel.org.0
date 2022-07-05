Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219375673DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jul 2022 18:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiGEQKr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jul 2022 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGEQKq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jul 2022 12:10:46 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 09:10:44 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B44D140E3;
        Tue,  5 Jul 2022 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657037239;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PtHy6OokJPrFtoDS0Whqy3V68GshIBOfC24cNcVepSk=;
    b=RBfOBOXzrCI63W9Rvbhf5BanvIUqHt/d3ZmxcpQi0btZObe9VDQ4qLRQatssvXPhxn
    V+UCMvezi0yUYjf4cSxB4rfa1hsm26ImuJzoIvJ7z+u0z9DX46bty7ZdpaxTG2L7cn/F
    CFh/hAygHC0+JkceAg0Elcw8W66VUsYAsgzJFoPBMkqB4Cfb8e37L5lUu+Hbyg+5gnYE
    QTaODKOKflh3J4Ipd6TQCGCAUX0uYiBOK3IbY3AVDxSHE/JZds7B5MX9HGUgIFNXPUho
    3MeKiOUah1xoxTXXQ06fptaDeHybL7e5Kz4VOixx9EANdMULh6UUw5jggXTGLPFNbYJ+
    kvlg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfio0GngadwjW4dqgkobcHPYDc/BNBepImPPJ"
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a02:8109:8980:4474:3840:b132:e6ea:146]
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id icdf6dy65G7HK68
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 5 Jul 2022 18:07:17 +0200 (CEST)
Message-ID: <76d0db0f-57fe-2985-4916-175d913d99e4@xenosoft.de>
Date:   Tue, 5 Jul 2022 18:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] kvm: rename KVM_MAX_VCPU_ID to, KVM_MAX_VCPU_IDS
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Juergen Gross <jgross@suse.com>
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
References: <6d3333b1-05cc-103b-4bdb-88bec5e3e9fd@xenosoft.de>
In-Reply-To: <6d3333b1-05cc-103b-4bdb-88bec5e3e9fd@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14 September 2021 at 05:59 pm, Christian Zigotzky wrote:
> Hello Juergen,
> Hello All,
>
> Since the RC1 of kernel 5.13, -smp 2 and -smp 4 don't work with a 
> virtual e5500 QEMU KVM-HV machine anymore. [1]
> I see in the serial console, that the uImage doesn't load. I use the 
> following QEMU command for booting:
>
> qemu-system-ppc64 -M ppce500 -cpu e5500 -enable-kvm -m 1024 -kernel 
> uImage -drive format=raw,file=MintPPC32-X5000.img,index=0,if=virtio 
> -netdev user,id=mynet0 -device virtio-net,netdev=mynet0 -append "rw 
> root=/dev/vda" -device virtio-vga -device virtio-mouse-pci -device 
> virtio-keyboard-pci -device pci-ohci,id=newusb -device 
> usb-audio,bus=newusb.0 -smp 4
>
> The kernels boot without KVM-HV.
>
> Summary for KVM-HV:
>
> -smp 1 -> works
> -smp 2 -> doesn't work
> -smp 3 -> works
> -smp 4 -> doesn't work
>
> I used -smp 4 before the RC1 of kernel 5.13 because my FSL P5040 BookE 
> machine [2] has 4 cores.
>
> Does this patch solve this issue? [3]
>
> Thanks,
> Christian
>
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-May/229103.html
> [2] http://wiki.amiga.org/index.php?title=X5000
> [3] 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-September/234152.html
Hello,

Since the RC5 of kernel 5.19, -smp 2 and -smp 4 work again. I don't know 
which patch has solved the issue.

Cheers,
Christian

