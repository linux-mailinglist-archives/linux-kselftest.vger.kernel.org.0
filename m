Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C388D510BBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355668AbiDZWRu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiDZWRt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 18:17:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9529D3CA48
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 15:14:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220426221434euoutp01aa4668fbeb1bd289df51907fb9d1e98b~pkgHOisOT2791327913euoutp01D
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 22:14:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220426221434euoutp01aa4668fbeb1bd289df51907fb9d1e98b~pkgHOisOT2791327913euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651011274;
        bh=IPQk0Q4k6d8MBvUz+9ejX0OyAjlYSg/gyEoYmMCjOKQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=c89szdQsAqye3i3gDVOJO1ceZs0G4Roj86/10zF1ZeHL7T64MwRAteXyxr0pVOFL6
         5QSguS62LvxvkWerdy40ibDhR8vdLaiUdteN4DzevsNAEd3XbaVRUnE9cP6GzOloHn
         gWGi1QnvUd466neJs+QeNSvG1TbsuKTxV7Tq1Tnk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220426221434eucas1p2be4b0c6ae9323a3c69fb142dbe142e50~pkgG1t_-_1767917679eucas1p2q;
        Tue, 26 Apr 2022 22:14:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.A7.10009.ACE68626; Tue, 26
        Apr 2022 23:14:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220426221433eucas1p253f6350eacf87d8cac2c05adc903656e~pkgFoSNEn3138331383eucas1p2G;
        Tue, 26 Apr 2022 22:14:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220426221433eusmtrp217fa12bd618a4c127c3632bdcc4c5f61~pkgFm-M8u0332303323eusmtrp2k;
        Tue, 26 Apr 2022 22:14:33 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-51-62686ecad992
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.68.09404.8CE68626; Tue, 26
        Apr 2022 23:14:33 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220426221432eusmtip2bf09fbbbace97124dcdd7cd3e8aa62f7~pkgEvO3E10048000480eusmtip2h;
        Tue, 26 Apr 2022 22:14:32 +0000 (GMT)
Message-ID: <64573cca-4bd6-a65e-0ba2-867c6488e82c@samsung.com>
Date:   Wed, 27 Apr 2022 00:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v14 27/39] arm64/sme: Provide Kconfig for SME
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220419112247.711548-28-broonie@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djP87qn8jKSDDY3iVhMPGVtMX3lZTaL
        Nz0mFlMfPmGzeL+sh9Hi/r7lTBYfTx1nt9j0+BqrxfQ779kspjR3MFlMOTaF3WLnnJOsFkfW
        2ltMebmO3WLv9GWsFjNv32a0WHr8P5NFyx1TByGPNfPWMHpsWtXJ5rF/7hp2j/Ob1jB7bF5S
        7/F5k1wAWxSXTUpqTmZZapG+XQJXxv6OJ0wF8yUr9ix6ztzAeFGki5GTQ0LAROLHrOksXYxc
        HEICKxglrp49xAjhfGGUaGl/AuV8ZpQ4e+kOO0zLxz9PoVqWM0rMunuAHcL5CNSy5x0jSBWv
        gJ3EmU1tYB0sAqoS22afYYKIC0qcnPmEBcQWFUiSmLvvHnMXIweHsICjxNrP1SBhZgFxiVtP
        5jOBzBQRuMkocabxNzOIwyzwhFmi6+8NsGY2AUOJrrddbCA2p4CVxLclb5gguuUlmrfOBmuQ
        ENjMKfF8xhJmiLtdJPru9bFA2MISr45vgfpHRuL/TpB1HEB2vsTfGcYQ4QqJa6/XQLVaS9w5
        94sNpIRZQFNi/S59iGpHifffEiFMPokbbwUhDuCTmLRtOjNEmFeio00IYoaaxKzj6+BWHrxw
        iXkCo9IspDCZheT5WUhemYWwdgEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAdHf6
        3/FPOxjnvvqod4iRiYPxEKMEB7OSCO89xYwkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzJmRsS
        hQTSE0tSs1NTC1KLYLJMHJxSDUx2Jn94ptr13zBOiC/KVSk3avI7vivo+zn25C87qye6VG0s
        sT33amHpBuuWRX/fW13Zv2HdhNC4vQ6vPV5cUX3yLamAb66N0plD9gxnXer/6fJVFM3h9FwT
        7GW08+KD2bMWF0RMYGTYxuX3Jaf6s7L+Xc2Az95PP+RE6Kv53mT8Oyn8yr2VPKtn+QRNO3yp
        0sVemjXqgJz4z4b+LTOX/Nms/txN+83n/I/Pw7hMLqmXhLirvGuy5Ogva3D/776i865s9I1g
        Jrt/b3SS7CMe2b6ZU3DvWlN1mpjpmfkqly+/XZM9u+zqpPAFlusaw5duuK/QuDrzq+7MANYF
        ry6czNKasbWwZ29sV0hDQOHCz7uVWIozEg21mIuKEwHziR8a5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xe7on8zKSDH5tYrSYeMraYvrKy2wW
        b3pMLKY+fMJm8X5ZD6PF/X3LmSw+njrObrHp8TVWi+l33rNZTGnuYLKYcmwKu8XOOSdZLY6s
        tbeY8nIdu8Xe6ctYLWbevs1osfT4fyaLljumDkIea+atYfTYtKqTzWP/3DXsHuc3rWH22Lyk
        3uPzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9
        uwS9jP0dT5gK5ktW7Fn0nLmB8aJIFyMnh4SAicTHP09Zuhi5OIQEljJKXP4wlQkiISNxcloD
        K4QtLPHnWhcbRNF7RomP7zaxgCR4BewkzmxqYwexWQRUJbbNPsMEEReUODnzCViNqECSxItt
        zxm7GDk4hAUcJdZ+rgYJMwuIS9x6Mp8JZKaIwE1GiW39FxkhEi+YJXbeB5spJJAhcerLabA4
        m4ChRNdbkCM4OTgFrCS+LXnDBFFvJtG1tQuqV16ieets5gmMQrOQnDELyb5ZSFpmIWlZwMiy
        ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzDGtx37uWUH48pXH/UOMTJxMB5ilOBgVhLhvaeY
        kSTEm5JYWZValB9fVJqTWnyI0RQYFhOZpUST84FJJq8k3tDMwNTQxMzSwNTSzFhJnNezoCNR
        SCA9sSQ1OzW1ILUIpo+Jg1OqgWn3n7UnzyUV63lOlH72pzL3x+qcqEjOE62tU/+lfJkrvutQ
        8R2fDM9sF6kPd2/zl++T0zNlU/s1V+FCNJdFWKKJ2K/bM3dcX33svO5/ndLme7zrMnzWGW/s
        qp3XbSP26lxd/O9JShqTf97q7lfJFJ19KX3J6f3VXjafP18zf/kqufZ80tSkQHf/L6+DZ7O8
        DMmZ81Kl5VUHY/WpJHEb2euru/c9m5TtcfGWlf4ChoMHlt3/s1kqzvVx35N4C9k3PG7MKrs9
        hEp+Kmzu2PNm+t4THxY/vSvcYCYya/Gx/RFzeSZw1bDN26mmeL3u8U3v/UdXTT0gPHNLTH8w
        q/6HeyxctzbPveIu87og8GLOFE4OJZbijERDLeai4kQAQLSW4XoDAAA=
X-CMS-MailID: 20220426221433eucas1p253f6350eacf87d8cac2c05adc903656e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220426221433eucas1p253f6350eacf87d8cac2c05adc903656e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220426221433eucas1p253f6350eacf87d8cac2c05adc903656e
References: <20220419112247.711548-1-broonie@kernel.org>
        <20220419112247.711548-28-broonie@kernel.org>
        <CGME20220426221433eucas1p253f6350eacf87d8cac2c05adc903656e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

On 19.04.2022 13:22, Mark Brown wrote:
> Now that basline support for the Scalable Matrix Extension (SME) is present
> introduce the Kconfig option allowing it to be built. While the feature
> registers don't impose a strong requirement for a system with SME to
> support SVE at runtime the support for streaming mode SVE is mostly
> shared with normal SVE so depend on SVE.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

This patchset landed in linux next-20220426. By default SME is enabled 
and it breaks CPU hot-plug on all my arm64 test systems. Bisect points 
this patch, because it finally enables this feature. Here is a report 
from QEMU's arm64 virt machine:

# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
psci: CPU1 killed (polled 0 ms)
# cat /proc/cpuinfo | grep processor | wc -l
1
# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 1 >$i/online; done
------------[ cut here ]------------
kernel BUG at arch/arm64/kernel/cpufeature.c:1353!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in: bluetooth ecdh_generic ecc rfkill ipv6
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.18.0-rc3+ #4891
Hardware name: linux,dummy-virt (DT)
pstate: 200001c5 (nzCv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __read_sysreg_by_encoding+0x350/0x354
lr : has_cpuid_feature+0x6c/0xe0
...
Call trace:
  __read_sysreg_by_encoding+0x350/0x354
  has_cpuid_feature+0x6c/0xe0
  verify_local_cpu_caps+0x98/0x130
  check_local_cpu_capabilities+0x2c/0x270
  secondary_start_kernel+0xc0/0x170
  __secondary_switched+0xa0/0xa4
Code: d53802d3 17ffff49 d5380233 17ffff47 (d4210000)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
SMP: stopping secondary CPUs
Kernel Offset: 0x4e81fb600000 from 0xffff800008000000
PHYS_OFFSET: 0xffff98f240000000
CPU features: 0x440,00033c08,00001086
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Disabling SME on top of next-20220426 hides this issue.

> ---
>   arch/arm64/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 57c4c995965f..0897984918e8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1939,6 +1939,17 @@ config ARM64_SVE
>   	  booting the kernel.  If unsure and you are not observing these
>   	  symptoms, you should assume that it is safe to say Y.
>   
> +config ARM64_SME
> +	bool "ARM Scalable Matrix Extension support"
> +	default y
> +	depends on ARM64_SVE
> +	help
> +	  The Scalable Matrix Extension (SME) is an extension to the AArch64
> +	  execution state which utilises a substantial subset of the SVE
> +	  instruction set, together with the addition of new architectural
> +	  register state capable of holding two dimensional matrix tiles to
> +	  enable various matrix operations.
> +
>   config ARM64_MODULE_PLTS
>   	bool "Use PLTs to allow module memory to spill over into vmalloc area"
>   	depends on MODULES

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

