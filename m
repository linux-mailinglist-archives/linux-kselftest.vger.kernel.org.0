Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3EA4C212
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2019 22:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFSUGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jun 2019 16:06:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34034 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFSUGR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jun 2019 16:06:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JK3j9u107770;
        Wed, 19 Jun 2019 20:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=T5/3kAdAeR6zFBROUWJvfOGR6wpTe6uJBD03+FJjR7Q=;
 b=JfZGTb/9vsPuTMYS8TLwO4D8maqLtaN37PWBviJWNWHwVHs6MQchbjnbIgEyT7QH5fPr
 RQaEqPDd4BLrljBr3UdRftu3+JLtrIljjKd9fnV8AG4CN4o7VCmxFBu3Cl8nvesNwCWz
 WIX9fL7RM27yvN1yXBV2ffc84cSXssCtprnFBx9JT9Dxvzwcw9BbBpKWzQE6w959cX3m
 0wLk2hF0v2PhKsE/QLpTHqn5AFlUdUziXjHErCwZzqKM7mXOXE9LWChgFdAX1ktGhG2H
 kWc5j8nTubxy0mEzTZ/LFPGY/UPGDf6lLKUj2qzGz2XAU0UI7iXrVbiRGgfjIjj0yqPG dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t7809dft1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 20:05:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JK5FSV002705;
        Wed, 19 Jun 2019 20:05:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t7rdwu63d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 20:05:26 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JK5NFI017703;
        Wed, 19 Jun 2019 20:05:23 GMT
Received: from [10.65.164.174] (/10.65.164.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 13:05:23 -0700
Subject: Re: [PATCH v17 12/15] media/v4l2-core, arm64: untag user pointers in
 videobuf_dma_contig_user_get
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <cover.1560339705.git.andreyknvl@google.com>
 <7fbcdbe16a2bd99e92eb4541248469738d89a122.1560339705.git.andreyknvl@google.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <5ea75db0-20e9-7423-8670-967eedd56440@oracle.com>
Date:   Wed, 19 Jun 2019 14:05:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7fbcdbe16a2bd99e92eb4541248469738d89a122.1560339705.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190165
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/19 5:43 AM, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow=
 to
> pass tagged user pointers (with the top byte set to something else othe=
r
> than 0x00) as syscall arguments.
>=20
> videobuf_dma_contig_user_get() uses provided user pointers for vma
> lookups, which can only by done with untagged pointers.
>=20
> Untag the pointers in this function.
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

Patch looks good, but commit log should be updated to not be specific to
arm64.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>



>  drivers/media/v4l2-core/videobuf-dma-contig.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> exact_copy_from_user
> diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/me=
dia/v4l2-core/videobuf-dma-contig.c
> index e1bf50df4c70..8a1ddd146b17 100644
> --- a/drivers/media/v4l2-core/videobuf-dma-contig.c
> +++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
> @@ -160,6 +160,7 @@ static void videobuf_dma_contig_user_put(struct vid=
eobuf_dma_contig_memory *mem)
>  static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_mem=
ory *mem,
>  					struct videobuf_buffer *vb)
>  {
> +	unsigned long untagged_baddr =3D untagged_addr(vb->baddr);
>  	struct mm_struct *mm =3D current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long prev_pfn, this_pfn;
> @@ -167,22 +168,22 @@ static int videobuf_dma_contig_user_get(struct vi=
deobuf_dma_contig_memory *mem,
>  	unsigned int offset;
>  	int ret;
> =20
> -	offset =3D vb->baddr & ~PAGE_MASK;
> +	offset =3D untagged_baddr & ~PAGE_MASK;
>  	mem->size =3D PAGE_ALIGN(vb->size + offset);
>  	ret =3D -EINVAL;
> =20
>  	down_read(&mm->mmap_sem);
> =20
> -	vma =3D find_vma(mm, vb->baddr);
> +	vma =3D find_vma(mm, untagged_baddr);
>  	if (!vma)
>  		goto out_up;
> =20
> -	if ((vb->baddr + mem->size) > vma->vm_end)
> +	if ((untagged_baddr + mem->size) > vma->vm_end)
>  		goto out_up;
> =20
>  	pages_done =3D 0;
>  	prev_pfn =3D 0; /* kill warning */
> -	user_address =3D vb->baddr;
> +	user_address =3D untagged_baddr;
> =20
>  	while (pages_done < (mem->size >> PAGE_SHIFT)) {
>  		ret =3D follow_pfn(vma, user_address, &this_pfn);
>=20


