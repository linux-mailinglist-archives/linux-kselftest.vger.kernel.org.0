Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B97D4BE74
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2019 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFSQmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jun 2019 12:42:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSQmL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jun 2019 12:42:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGZ3BA139193;
        Wed, 19 Jun 2019 16:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4T5a0glbRa2aBSKkc/pjnTjMsTPHECFT1E9bbL1l2HM=;
 b=iM3Ngn2x6aaNg+8wMaz2TYv3kwfBr7esbrJ8PsegJPNksN4Z/YjPTI3TmHcIUAH5xIxd
 gAnjdNn//nUURYK/24P/Mz+8CWzLw/ldkJ0Ah8cTKTN8TsQstYz7Wc1JokBHslvlpojt
 t58Ckn54FcLS6JnUQMgNT/8sCvOqKf+qXUPK2SC5pwHYaAG2DxzZEfDTOmnxSxjRlk17
 81k1k3JZIHS9isv6MaXvl6eghbedIhy09UL0UJZ7M5tLa9EvLThKgTnTshAaPgND2Tmz
 VORmseouIshgIQ+DfXX2+2Cq67n27+huaukcohM59RMNDmLVIT4WZNeTT5o/4WBjQ22r Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t7809ckb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 16:41:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGeTfm168992;
        Wed, 19 Jun 2019 16:41:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t77ynxysy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 16:41:18 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JGfFiP008310;
        Wed, 19 Jun 2019 16:41:16 GMT
Received: from [10.65.164.174] (/10.65.164.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 09:41:15 -0700
Subject: Re: [PATCH v17 05/15] mm, arm64: untag user pointers in mm/gup.c
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
References: <cover.1560339705.git.andreyknvl@google.com>
 <8f65548bef8544d49980a92d221b74440d544c1e.1560339705.git.andreyknvl@google.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <dbf2dd46-0240-f8a9-203c-4f1234c16825@oracle.com>
Date:   Wed, 19 Jun 2019 10:41:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8f65548bef8544d49980a92d221b74440d544c1e.1560339705.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190134
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
> mm/gup.c provides a kernel interface that accepts user addresses and
> manipulates user pages directly (for example get_user_pages, that is us=
ed
> by the futex syscall). Since a user can provided tagged addresses, we n=
eed
> to handle this case.
>=20
> Add untagging to gup.c functions that use user addresses for vma lookup=
s.
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>


>  mm/gup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..c37df3d455a2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -802,6 +802,8 @@ static long __get_user_pages(struct task_struct *ts=
k, struct mm_struct *mm,
>  	if (!nr_pages)
>  		return 0;
> =20
> +	start =3D untagged_addr(start);
> +
>  	VM_BUG_ON(!!pages !=3D !!(gup_flags & FOLL_GET));
> =20
>  	/*
> @@ -964,6 +966,8 @@ int fixup_user_fault(struct task_struct *tsk, struc=
t mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	vm_fault_t ret, major =3D 0;
> =20
> +	address =3D untagged_addr(address);
> +
>  	if (unlocked)
>  		fault_flags |=3D FAULT_FLAG_ALLOW_RETRY;
> =20
>=20


