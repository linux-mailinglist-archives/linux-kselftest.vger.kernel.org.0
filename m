Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007922E020
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2019 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE2OuV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 May 2019 10:50:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37242 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfE2OuV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 May 2019 10:50:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TEmj59055774;
        Wed, 29 May 2019 14:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=bdiE7HWyHmzeDdhgcpTkxNwVwsKMW5J4u0bwenhkW2I=;
 b=vAYGK9KOQKh1ci+61dIXEhKr/6PuEl3w9nerHoG2o6KZcTmroHCycrPlXsSVYoCc1D9e
 u53Af15v96j6SPmPoJ+syGA6mCGI1yCiY2PcW+gMzZiVseWDKwRqdfQ/vA5LKK20Ou6S
 qqH1kgPXhEpgNiGNUtFLQ9cNrcGvNjpxe3Gfdd5qauvpSfl3hiaspyOm5mJhBkWRqvwm
 IYx2v4CAD32zNH3jZdsRIlmsjtuapA8CQI+GAGIf1qsl+aD1+DqMFhyfxIFAGNXJW+cz
 9a5PK1sw72WXYdjOuDHWee7Q0Jai2TlWbMJfUWHm89DxiTdsjrZTZi400nmT0P2EZndw JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2spu7djgus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 14:49:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TEnL0O140618;
        Wed, 29 May 2019 14:49:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ss1fngsh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 14:49:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4TEnF2L021623;
        Wed, 29 May 2019 14:49:16 GMT
Received: from concerto-wl.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 07:49:15 -0700
Message-ID: <3ade20696cc772772f5362fea02ede81c4a0fad3.camel@oracle.com>
Subject: Re: [PATCH v15 01/17] uaccess: add untagged_addr definition for
 other arches
From:   Khalid Aziz <khalid.aziz@oracle.com>
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
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Date:   Wed, 29 May 2019 08:49:09 -0600
In-Reply-To: <67ae3bd92e590d42af22ef2de0ad37b730a13837.1557160186.git.andreyknvl@google.com>
References: <cover.1557160186.git.andreyknvl@google.com>
         <67ae3bd92e590d42af22ef2de0ad37b730a13837.1557160186.git.andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290098
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2019-05-06 at 18:30 +0200, Andrey Konovalov wrote:
> To allow arm64 syscalls to accept tagged pointers from userspace, we
> must
> untag them when they are passed to the kernel. Since untagging is
> done in
> generic parts of the kernel, the untagged_addr macro needs to be
> defined
> for all architectures.
> 
> Define it as a noop for architectures other than arm64.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)

As discussed in the other thread Chris started, there is a generic need
to untag addresses in kernel and this patch gets us ready for that.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6b10c21630f5..44041df804a6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
>  
> +#ifndef untagged_addr
> +#define untagged_addr(addr) (addr)
> +#endif
> +
>  #ifndef __pa_symbol
>  #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
>  #endif

