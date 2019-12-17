Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991D2123817
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2019 21:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLQUv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 15:51:57 -0500
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:44830
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbfLQUv5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 15:51:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7+1bbrdowOopBNmwWs80/4jkajb6Bak/lSSbtqzQHrBNZB6Do0H9hPuzzhg99RQJVku1IS5BUMho/yHFK6cAlmXpPm5lN1uJ62T4TsDgvSGx3x44FPK22lkPzVDySpWOIEiPSz6HGBARJbo5VLe2IDJJtE/h5+wjt18MpmAFFmopeWZqPeLfLrPYNmWvZ6wmZWuxZuS85gC4sqbrOhW2ktL3gssXVhvt2Lh7PofW1lZj0cmQCNuQwYQK8EvbckZOWT4rbUOlOSMv/4vgHNgXLjmLlHjM03pIje+H4TOlmgPsL3qvXq7n/DjUMPP5yvCPDJMWZD51tJWuGT5fFgLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1CMvljqDvlT87841a7S3V0KeBkbDcag1+0RMhek1D8=;
 b=nROgWYfCVDKWOqH438Z5C5kWKYwlMKEHFZ/i5mnEsdcY+CGeEZt64xXnwwe2WYS155gvTEvfNVY5yivfNwyn34l6atus/j3JQn3Y7TYF6FMsewt8FCVUuGHf9A8Iu+1yZ8ZDHWmGKo7xfcEyjqrW6ofg5jmdUKeV1M4H/SlCyBXLbZcl7mpIyMPI/xWCNZzEMagEo7DellQhQZNoU75Prj55nSCT4spk1zG1ZQZe2K75srWXkDC/TdhFHcqwemC85wK77XWsRrHCmKgCEBV9O8Ry1MwkviHIMEpPXEK/SwBdq/gHUFcQnCUTe0dgLldZqfkSjx/tU/GQxoMeKqS8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1CMvljqDvlT87841a7S3V0KeBkbDcag1+0RMhek1D8=;
 b=YSL7chqk0GlyWvuc5w6RtB1pwT1gI1x6n+kooVXpaPkT7c9+aZy5CmTKvaOBMbJrNDfz2eZsLKKVfccXVT4hk4S5D7TGz/nDH0v1Mr2NykXuJAGMdKdLmOgGnzsRjky6vGJoPh/52gOf4JV3NMkn0JOC0ucy9EmZAUSRRWXnZfM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3375.eurprd05.prod.outlook.com (10.175.244.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 20:51:51 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b%6]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 20:51:51 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
Thread-Topic: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
Thread-Index: AQHVtEsczeksfKC51EmFDx7aa5U3hKe+zwGA
Date:   Tue, 17 Dec 2019 20:51:50 +0000
Message-ID: <20191217205147.GI16762@mellanox.com>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
 <20191216195733.28353-2-rcampbell@nvidia.com>
In-Reply-To: <20191216195733.28353-2-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:408:80::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 094c5636-ac31-4315-4d41-08d78332f055
x-ms-traffictypediagnostic: VI1PR05MB3375:
x-microsoft-antispam-prvs: <VI1PR05MB33758F6EFD67C96F15AC10B2CF500@VI1PR05MB3375.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(52116002)(7416002)(86362001)(8936002)(81166006)(81156014)(8676002)(6512007)(66476007)(5660300002)(64756008)(66446008)(4326008)(316002)(66946007)(66556008)(54906003)(2906002)(478600001)(71200400001)(15650500001)(2616005)(36756003)(6916009)(1076003)(6486002)(33656002)(26005)(186003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3375;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrwH/zYWoT0JRAREzByKmPBLa+evEa/W6NJ50SBfh+blOSxM4Z/ZqX24Fbqk64qP+Kz7b7z7/jQ2uNnQeziWrBqtR97Co4EYDDHfPUzjZJ6BS/eS2B662z6UiNxndWx2KpuL6UfaqtEXJ3FNdmFWLYHban40XaIAYUkVzdgxwAPaUJ3htgTv6zfxjlGOED64z4De3eHFOOzwO3gVBXNOBGTJgydetQUZlmUI+Hpx6JJcSyqBl4T1yvl2a73pOaLIvIXWXVF9p1lY0H6qkAvelWzD1vnwSOgVEQX3ykeDZW2jpBzJShowGkFUljb4rCCm7G5bhtdQw6GafhOWCq4r0qWBDIUuN06Fc1b+1P9mtkCa3v4sM92Jy0DYhxmPmTWXpNw3Vq68YsxJSt0juRZIoctSwyK5WHq/KIWxZ8TzUWpfzGexipUYsAqaOhR7wBPS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79EE60004729144E9D508620086137F8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094c5636-ac31-4315-4d41-08d78332f055
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 20:51:51.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Op09DmgL2oEwa8ZOHUfhRd82XVCL4wgYOQ9S1eWdjixrcpUcXWdkZdTg4DCtwTGhtNUkqqT83UJycbv2ey31HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3375
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 11:57:32AM -0800, Ralph Campbell wrote:
> mmu_interval_notifier_insert() and mmu_interval_notifier_remove() can't
> be called safely from inside the invalidate() callback. This is fine for
> devices with explicit memory region register and unregister calls but it
> is desirable from a programming model standpoint to not require explicit
> memory region registration. Regions can be registered based on device
> address faults but without a mechanism for updating or removing the mmu
> interval notifiers in response to munmap(), the invalidation callbacks
> will be for regions that are stale or apply to different mmaped regions.

What we do in RDMA is drive the removal from a work queue, as we need
a synchronize_srcu anyhow to serialize everything to do with
destroying a part of the address space mirror.

Is it really necessary to have all this stuff just to save doing
something like a work queue?

Also, I think we are not taking core kernel APIs like this with out an
in-kernel user??

> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 9e6caa8ecd19..55fbefcdc564 100644
> +++ b/include/linux/mmu_notifier.h
> @@ -233,11 +233,18 @@ struct mmu_notifier {
>   * @invalidate: Upon return the caller must stop using any SPTEs within =
this
>   *              range. This function can sleep. Return false only if sle=
eping
>   *              was required but mmu_notifier_range_blockable(range) is =
false.
> + * @release:	This function will be called when the mmu_interval_notifier
> + *		is removed from the interval tree. Defining this function also
> + *		allows mmu_interval_notifier_remove() and
> + *		mmu_interval_notifier_update() to be called from the
> + *		invalidate() callback function (i.e., they won't block waiting
> + *		for invalidations to finish.

Having a function called remove that doesn't block seems like very
poor choice of language, we've tended to use put to describe that
operation.

The difference is meaningful as people often create use after free
bugs in drivers when presented with interfaces named 'remove' or
'destroy' that don't actually guarentee there is not going to be
continued accesses to the memory.

>   */
>  struct mmu_interval_notifier_ops {
>  	bool (*invalidate)(struct mmu_interval_notifier *mni,
>  			   const struct mmu_notifier_range *range,
>  			   unsigned long cur_seq);
> +	void (*release)(struct mmu_interval_notifier *mni);
>  };
> =20
>  struct mmu_interval_notifier {
> @@ -246,6 +253,8 @@ struct mmu_interval_notifier {
>  	struct mm_struct *mm;
>  	struct hlist_node deferred_item;
>  	unsigned long invalidate_seq;
> +	unsigned long deferred_start;
> +	unsigned long deferred_last;

I couldn't quite understand how something like this can work, what is
preventing parallel updates?

> +/**
> + * mmu_interval_notifier_update - Update interval notifier end
> + * @mni: Interval notifier to update
> + * @start: New starting virtual address to monitor
> + * @length: New length of the range to monitor
> + *
> + * This function updates the range being monitored.
> + * If there is no release() function defined, the call will wait for the
> + * update to finish before returning.
> + */
> +int mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
> +				 unsigned long start, unsigned long length)
> +{

Update should probably be its own patch

Jason
