Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0436E13A9DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgANNAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 08:00:08 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:23886
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgANNAI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 08:00:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHSPiGZHIPq2zEnMP9OxbQZz1Cl+whcFuAIIEKH9EpNwdw2s+l6C/OCqfrxfhf97j/8LbAY76nA7lGzM5VHSQEsvALV4C+r27oAlHX82+bWK/H162zUQjcZJ5S6XTS7qs85hJnAWQec2etaJcY/qroUNzzEvS4QYzAobtzeq4Jx0UcSVDRCurt2fbgKc/KhCZpDmChNfISqQuJYSYELP1jAwQ9F+ivvMyjGov2lQNmm6uPz4Lw3L/md9Qo+IcHZJr3MH0GCGGuPGVdgA61CTP2/VdJt1Zu8dBo+KVmplA6XBgHqpA44ujoz1iiONr9+ky6HZvLPFgjEvKtAVx4pagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/gWNLTm0Bg99BL11bnO/stYz+/1JchO/jTy+XL2VJs=;
 b=BtVZb8BlBjAFb2iGDppOjb2BvyUqSlU/qBFTNuOFz2doqBalNJ/NSXiW9QZBaYr0mlLAYj4NRTKjXeqxMcylTlxPm5bgPTHcINwKR6AVj+NPXHB4k6UNqQ1z48V7sOhXxyt2p+XF/31FoSqOFEgzJCOaQpDhtvcPdh4fKNyjiTQWlnKKIP5h2iCgmtveELSUnUg2tvbIobK8QYZjEUBmYhbuuxIGcpdMW0kkp24aI4A9ytgTcQn5Pp7KU5bzqQcomzb+qFALKP8zmh9lZ2heqq7jFs2iB0nu6R22h7ORXCeRp525spdZ6/aZo8B1M0ljLq8Z5QS6476p2x/TeqdueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/gWNLTm0Bg99BL11bnO/stYz+/1JchO/jTy+XL2VJs=;
 b=if1gfKSgXEYHIB4V3+xZeYB6aXr3OKNiJ7MAZX+r5cFY+KAOHFo47BZ2foUjSkJUP4Ga5CkF4m55Evi1PaG4fs4liNJktotYZiQGfxMkEBhSbd4/69bBnqIjZxjI0bf90iJlautREHA2npfcp4UF2ll/Rxpsuxk6Vkv109fMSYI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5246.eurprd05.prod.outlook.com (20.178.11.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 13:00:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 13:00:01 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0052.prod.exchangelabs.com (2603:10b6:208:25::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.17 via Frontend Transport; Tue, 14 Jan 2020 13:00:01 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1irLnZ-00061U-Ue; Tue, 14 Jan 2020 08:59:57 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 5/6] nouveau: use new mmu interval notifiers
Thread-Topic: [PATCH v6 5/6] nouveau: use new mmu interval notifiers
Thread-Index: AQHVymNqjXzbt52uukWssUL4CQa1/qfqIESA
Date:   Tue, 14 Jan 2020 13:00:01 +0000
Message-ID: <20200114125957.GO20978@mellanox.com>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
 <20200113224703.5917-6-rcampbell@nvidia.com>
In-Reply-To: <20200113224703.5917-6-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0052.prod.exchangelabs.com
 (2603:10b6:208:25::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2a0244a-8d2b-4f80-b5a9-08d798f1aaa9
x-ms-traffictypediagnostic: VI1PR05MB5246:
x-microsoft-antispam-prvs: <VI1PR05MB524695D5EF6B0B597A6AE086CF340@VI1PR05MB5246.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(2906002)(33656002)(86362001)(54906003)(478600001)(4326008)(7416002)(52116002)(316002)(6916009)(81166006)(81156014)(8676002)(26005)(186003)(9746002)(9786002)(8936002)(5660300002)(36756003)(6666004)(1076003)(66556008)(71200400001)(66946007)(66446008)(64756008)(2616005)(66476007)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5246;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvQQtZPUiG4bclNH9Tt7x0sTU1Md1Diy5tHVQ53oHLnPDXkLocETyPDmGIIuQnXQbY3VkcLfA4pbAHMaRimrXwKreOEtAqVBa+imikN6idDutMBCP5+s2YgAyiMgsp+HrPWVmnnDAi0sPI6kccbFTYru3+F+QOK5tUPdAxkO59Ha8Z260pa+JaWqIGeV7OXUEem/3+WpkJTDLI9Zt5gA5gJ+oEJGiV/DIj+da0u9+YyeS3iqHxtN6GYKo1QtDF1iIdIrNaesSIq7EKxAwM/x21qVSRRBp8nPHuKcR5XB97spO3H5LOUVQoYn4wF9E65t/f0nbu+AMmFTD0qbkAyTSCodRhE0Q/mOEcne4at8HVju20ND2rLGXWbTQMO2NjC66KhDx6X0wxyGOOkPQydXnHYfC8yfHAHsMw5TtqicForY3b/jKloBT6a7sfQ/4v8liDqZjpITiaeNrE82B9OPrBwcJm6XWFgdbugYNvNWk6grxPKNonSdH9bTxYe0EmgJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A033709EA4F95043BAEBE4C09070BEF0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a0244a-8d2b-4f80-b5a9-08d798f1aaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 13:00:01.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bgh9Ew85x3ulatcEDnJxq6DbeJBFsw52GEPyw5r25gZSv9ntsBsXlm82uov131gKVpglN2vIpdtGn0kgatz43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5246
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 02:47:02PM -0800, Ralph Campbell wrote:
>  void
>  nouveau_svmm_fini(struct nouveau_svmm **psvmm)
>  {
>  	struct nouveau_svmm *svmm =3D *psvmm;
> +	struct mmu_interval_notifier *mni;
> +
>  	if (svmm) {
>  		mutex_lock(&svmm->mutex);
> +		while (true) {
> +			mni =3D mmu_interval_notifier_find(svmm->mm,
> +					&nouveau_svm_mni_ops, 0UL, ~0UL);
> +			if (!mni)
> +				break;
> +			mmu_interval_notifier_put(mni);

Oh, now I really don't like the name 'put'. It looks like mni is
refcounted here, and it isn't. put should be called 'remove_deferred'

And then you also need a way to barrier this scheme on driver unload.

> +		}
>  		svmm->vmm =3D NULL;
>  		mutex_unlock(&svmm->mutex);
> -		mmu_notifier_put(&svmm->notifier);

While here it was actually a refcount.

> +static void nouveau_svmm_do_unmap(struct mmu_interval_notifier *mni,
> +				 const struct mmu_notifier_range *range)
> +{
> +	struct svmm_interval *smi =3D
> +		container_of(mni, struct svmm_interval, notifier);
> +	struct nouveau_svmm *svmm =3D smi->svmm;
> +	unsigned long start =3D mmu_interval_notifier_start(mni);
> +	unsigned long last =3D mmu_interval_notifier_last(mni);

This whole algorithm only works if it is protected by the read side of
the interval tree lock. Deserves at least a comment if not an
assertion too.

>  static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  			       struct nouveau_drm *drm, void *data, u32 size,
> -			       u64 *pfns, struct svm_notifier *notifier)
> +			       u64 *pfns, u64 start, u64 end)
>  {
>  	unsigned long timeout =3D
>  		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>  	/* Have HMM fault pages within the fault window to the GPU. */
>  	struct hmm_range range =3D {
> -		.notifier =3D &notifier->notifier,
> -		.start =3D notifier->notifier.interval_tree.start,
> -		.end =3D notifier->notifier.interval_tree.last + 1,
> +		.start =3D start,
> +		.end =3D end,
>  		.pfns =3D pfns,
>  		.flags =3D nouveau_svm_pfn_flags,
>  		.values =3D nouveau_svm_pfn_values,
> +		.default_flags =3D 0,
> +		.pfn_flags_mask =3D ~0UL,
>  		.pfn_shift =3D NVIF_VMM_PFNMAP_V0_ADDR_SHIFT,
>  	};
> -	struct mm_struct *mm =3D notifier->notifier.mm;
> +	struct mm_struct *mm =3D svmm->mm;
>  	long ret;
> =20
>  	while (true) {
>  		if (time_after(jiffies, timeout))
>  			return -EBUSY;
> =20
> -		range.notifier_seq =3D mmu_interval_read_begin(range.notifier);
> -		range.default_flags =3D 0;
> -		range.pfn_flags_mask =3D -1UL;
>  		down_read(&mm->mmap_sem);

mmap sem doesn't have to be held for the interval search, and again we
have lifetime issues with the membership here.

> +		ret =3D nouveau_svmm_interval_find(svmm, &range);
> +		if (ret) {
> +			up_read(&mm->mmap_sem);
> +			return ret;
> +		}
> +		range.notifier_seq =3D mmu_interval_read_begin(range.notifier);
>  		ret =3D hmm_range_fault(&range, 0);
>  		up_read(&mm->mmap_sem);
>  		if (ret <=3D 0) {

I'm still not sure this is a better approach than what ODP does. It
looks very expensive on the fault path..

Jason
