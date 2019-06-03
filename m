Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19D33600
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfFCRFp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 13:05:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfFCRFp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 13:05:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53H3xSn100496;
        Mon, 3 Jun 2019 17:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=OfBlugxBOMTUJDS5Fta0E067EXIuFHrIc+KiOftycQo=;
 b=jX8igtAtwdGWEcSQ15NbliZz+NGIxv22eo7wYyRnuuYQ7I4J/bIEqkjIMzg4nRkoaTHN
 Izj1eZ3FVe1MPbsF1dYsa+JsLP+4qEQVawH6/fkC1cv94PTeQa/skgeNAkL7L8E1wd20
 4RGoi2Jt3aFi4/U0wmvd4vrnsadD0wKIeZChrG/bw4MRrCFb484s4PEYw6yASdqlW7XP
 gY1T8XQl48DrdBh2Zl0WHDVvzFQRmVP7va2HFIKL3rd5QdAY2VUdmHvX1AdMNXXvrYIN
 hq/n16LS6BO3VJFXQsI955s6dUO0v4GGeGgILk3iJmQi8y78QUC3NMgSdO1Vb3Lpd7Pa rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2suj0q87ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 17:04:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53H25KX001162;
        Mon, 3 Jun 2019 17:02:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2supp77nea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 17:02:42 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x53H2beP015785;
        Mon, 3 Jun 2019 17:02:37 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Jun 2019 10:02:37 -0700
Subject: Re: [PATCH v16 01/16] uaccess: add untagged_addr definition for other
 arches
To:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
References: <cover.1559580831.git.andreyknvl@google.com>
 <097bc300a5c6554ca6fd1886421bb2e0adb03420.1559580831.git.andreyknvl@google.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <8ff5b0ff-849a-1e0b-18da-ccb5be85dd2b@oracle.com>
Date:   Mon, 3 Jun 2019 11:02:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <097bc300a5c6554ca6fd1886421bb2e0adb03420.1559580831.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906030117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906030118
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/3/19 10:55 AM, Andrey Konovalov wrote:
> To allow arm64 syscalls to accept tagged pointers from userspace, we mu=
st
> untag them when they are passed to the kernel. Since untagging is done =
in
> generic parts of the kernel, the untagged_addr macro needs to be define=
d
> for all architectures.
>=20
> Define it as a noop for architectures other than arm64.
>=20
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0e8834ac32b7..949d43e9c0b6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> =20
> +#ifndef untagged_addr
> +#define untagged_addr(addr) (addr)
> +#endif
> +
>  #ifndef __pa_symbol
>  #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
>  #endif
>=20

Andrey,

This patch has now become part of the other patch series Chris Hellwig
has sent out -
<https://lore.kernel.org/lkml/20190601074959.14036-1-hch@lst.de/>. Can
you coordinate with that patch series?

--
Khalid

