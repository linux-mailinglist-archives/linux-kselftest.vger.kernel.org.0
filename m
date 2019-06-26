Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777AB56FF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2019 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfFZRvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jun 2019 13:51:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44468 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfFZRvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QHd3BJ070052;
        Wed, 26 Jun 2019 17:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pJtn37VVzLHGgxTNqg1ZlS6RKLrOq382izwrBCZb3DI=;
 b=EcEEEMWgDEbMDuMxTOR2oYeCSXUOQKHZ4+B/a0CiekDLmP8Z1U885QaSBhgXo+/oVJZ3
 SGbnV6cXs+U0YG4HT3njZ/iUUzFIuHHOFK70cZEOdOGApbgKUYX3eCJLdfQ3dKwGSNIl
 owHPVd1m79tjE2KLbk7nGdMWhkLr/F3ZBkkDI9hHrhy/y/e6IptZoUUgS8HTk7grA8Ud
 Bf4hJAICEUZKsbR/1JYmjjWhp4n+uI1QfmV/GKfsvqZ6rJZc12bBVgqeF5v8xkJ16pFz
 7wdP2Bakv0UvCbjPcmfUTGeqmf+Xk2K6+wWohnQ4b4rai+Y/+koOAVyMxoOJaa/ojH8K NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyqks50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 17:50:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QHolV1005117;
        Wed, 26 Jun 2019 17:50:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t9p6uwkss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 17:50:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QHofTs013200;
        Wed, 26 Jun 2019 17:50:42 GMT
Received: from [10.65.138.107] (/10.65.138.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 10:50:41 -0700
Subject: Re: [PATCH v18 10/15] drm/radeon: untag user pointers in
 radeon_gem_userptr_ioctl
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
References: <cover.1561386715.git.andreyknvl@google.com>
 <61d800c35a4f391218fbca6f05ec458557d8d097.1561386715.git.andreyknvl@google.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <28554e21-04b8-2461-e576-5abe0b53cd59@oracle.com>
Date:   Wed, 26 Jun 2019 11:50:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <61d800c35a4f391218fbca6f05ec458557d8d097.1561386715.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260208
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260208
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/24/19 8:32 AM, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pa=
ss
> tagged user pointers (with the top byte set to something else other tha=
n
> 0x00) as syscall arguments.
>=20
> In radeon_gem_userptr_ioctl() an MMU notifier is set up with a (tagged)=

> userspace pointer. The untagged address should be used so that MMU
> notifiers for the untagged address get correctly matched up with the ri=
ght
> BO. This funcation also calls radeon_ttm_tt_pin_userptr(), which uses
> provided user pointers for vma lookups, which can only by done with
> untagged pointers.
>=20
> This patch untags user pointers in radeon_gem_userptr_ioctl().
>=20
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>


>  drivers/gpu/drm/radeon/radeon_gem.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/rade=
on/radeon_gem.c
> index 44617dec8183..90eb78fb5eb2 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -291,6 +291,8 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev=
, void *data,
>  	uint32_t handle;
>  	int r;
> =20
> +	args->addr =3D untagged_addr(args->addr);
> +
>  	if (offset_in_page(args->addr | args->size))
>  		return -EINVAL;
> =20
>=20


