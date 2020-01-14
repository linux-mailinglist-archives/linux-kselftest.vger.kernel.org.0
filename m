Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5C13A9AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 13:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgANMuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 07:50:44 -0500
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:63174
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbgANMun (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 07:50:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7XUEtCloHtSh0XzjJPY2iuHjI/dhgoU+50rOU+MjKhBL9YZedHQHh+bJyiy3WUBghtfYxWfH1Pd+/cmHrZ9Dw9R0WYS1mIatwjNssxU/FFeEz+ATUOubgnAzwR/ViMPZT98/qwLwCdYCkBj5277UQN+vFyiOFQQt4u2WytkN19awJT28OPg08a3HohZaHRefJQ5dhUpCPJctQg71b+sA6JyOOUcBQDhEy0YeY5U+BwFcBt3H2ndPQsdZ8LhNvnRS9YEBicy5tF8Q9fFgSThCC5hJL3licZW6nd2pPorXrE4p7K59+BW/6ttbZo8k+Cq049SROQdRmi/9p12SevsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTtqHBu2VdjbylevMt0AQNQF7yVbZgiL0JygfOIc/ow=;
 b=EfjbB7pZ2aeSZaWxbzqJ0TH3k35TC/EnBq09wuA238o8efcU5hnLLdtLJLfwX0CdKnqI0HJUzsIrakb1IUHjvu2xoLBpkdoIE0JolaF58uAg4v2HZbg87jFR1HEwI8m0A4WIAVIc9JJyxpuQyn2A4WQ8RpRzhFHJ/gLvqkYr3n18BFLvmkT88fxDZ5nsJ1DCCMmIYntVR1fCnfMFqfysCzrXeReiXk1Slpw9jCwArBKROsq2G/cKU/OdcFvTNjMCy0vfUCyrfBSF4knikKgZg7OY0jltXMk6qFzT9awtPCizWIqhG65Up+QRBXiMp72PkDKBvmrmOCm1QPXxXONhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTtqHBu2VdjbylevMt0AQNQF7yVbZgiL0JygfOIc/ow=;
 b=t6+6HO04qDyRQ5hwG+vtXMeXLVdbrqxyngOimnwCJqC7scs6CNqtkFVSzjbOPuVufrDY4u7/xIR0wpNhNeoMRwoRrA4228peXtk7o0sRcO2QCH5hBbIQ1cM3xXjGzWLC873yg+5MCuHGc5ux3GtkO7licSq0T27WUI+2OcjAt7Y=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5200.eurprd05.prod.outlook.com (20.178.12.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 12:49:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 12:49:59 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:207:3d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend Transport; Tue, 14 Jan 2020 12:49:58 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1irLds-0005sv-3m; Tue, 14 Jan 2020 08:49:56 -0400
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
Subject: Re: [PATCH v6 4/6] mm/mmu_notifier: add mmu_interval_notifier_find()
Thread-Topic: [PATCH v6 4/6] mm/mmu_notifier: add mmu_interval_notifier_find()
Thread-Index: AQHVymNoKcMh6TMtf0C4WlvfajKIrqfqHXcA
Date:   Tue, 14 Jan 2020 12:49:59 +0000
Message-ID: <20200114124956.GN20978@mellanox.com>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
 <20200113224703.5917-5-rcampbell@nvidia.com>
In-Reply-To: <20200113224703.5917-5-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:207:3d::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 816823df-e936-45cc-bc69-08d798f04399
x-ms-traffictypediagnostic: VI1PR05MB5200:
x-microsoft-antispam-prvs: <VI1PR05MB520031A04545558BB2990B67CF340@VI1PR05MB5200.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(189003)(199004)(2906002)(52116002)(33656002)(71200400001)(54906003)(316002)(5660300002)(86362001)(66476007)(66446008)(64756008)(6916009)(66946007)(478600001)(7416002)(186003)(66556008)(26005)(9746002)(9786002)(2616005)(36756003)(4326008)(81156014)(81166006)(8936002)(8676002)(1076003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5200;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59XjDx6Fk2lghkk/xzKy94/rWyy6FmtFdNmhJkE0JsHJM0zNslQU1u2Q9wJD1tzEGd4EfKG/2nzBMV5XzmSdEPS2JW6sAjvystm8XyFcE9sD4BfpTz2LUqv8T0H59wCw6pW3MV1A3Sa+5t4VECBgXxSSSwWr3bVpYk3rHz+bG51nCJ/aLsRvAIhlEiW1Qlq+regYVj3KK5vkLW3YrS68yg6ke0LpgH1JM93Yd7WzDy0qNV1NIzGRAnaFqvk6qjDcW8DwFh+u/gUND1r6vXx7FGXNp4MQVctuzLhy9p29zI2Dof9bfgeDfw8vlWuW2v7/OBWyBoXE3dCv9vacV8O2A1E7zQ8yGHtmmYYfgbTNdoOkQmJ+xfLQBzCyEsPI+bteNi7jhVZCyOcse+r7RUtUzvYr1nKebilwgw+Z8G3fcXikJSZ4ppGbNBTvavA814bT0rEFodx/9jTisNwl4T0xPJkGd3GrH5/l87TlOvFK6VC+iRTMsLfaJ4WBeCUbU7p/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A257C7D2E6E81A488462C5DDE02DD0C5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816823df-e936-45cc-bc69-08d798f04399
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 12:49:59.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DE0G0UmX7vB/BR4k73qcS1UNsyhjOIZdtt6cjRV+P72ONGUYS/pQ1P2LCptAAzf5z4mJVdeRGhfyBRIADWbCsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5200
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 02:47:01PM -0800, Ralph Campbell wrote:
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 47ad9cc89aab..4efecc0f13cb 100644
> +++ b/mm/mmu_notifier.c
> @@ -1171,6 +1171,39 @@ void mmu_interval_notifier_update(struct mmu_inter=
val_notifier *mni,
>  }
>  EXPORT_SYMBOL_GPL(mmu_interval_notifier_update);
> =20
> +struct mmu_interval_notifier *mmu_interval_notifier_find(struct mm_struc=
t *mm,
> +				const struct mmu_interval_notifier_ops *ops,
> +				unsigned long start, unsigned long last)
> +{
> +	struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
> +	struct interval_tree_node *node;
> +	struct mmu_interval_notifier *mni;
> +	struct mmu_interval_notifier *res =3D NULL;
> +
> +	spin_lock(&mmn_mm->lock);
> +	node =3D interval_tree_iter_first(&mmn_mm->itree, start, last);
> +	if (node) {
> +		mni =3D container_of(node, struct mmu_interval_notifier,
> +				   interval_tree);
> +		while (true) {
> +			if (mni->ops =3D=3D ops) {
> +				res =3D mni;
> +				break;
> +			}
> +			node =3D interval_tree_iter_next(&mni->interval_tree,
> +						       start, last);
> +			if (!node)
> +				break;
> +			mni =3D container_of(node, struct mmu_interval_notifier,
> +					   interval_tree);
> +		}
> +	}
> +	spin_unlock(&mmn_mm->lock);

This doesn't seem safe at all, here we are returning a pointer to
memory from the interval tree with out any kind of lifetime
protection.

If the interval tree is read it must be left in the read lock state
until the caller is done with the pointer.

.. and this poses all sorts of questions about consistency with items
on the deferred list. Should find return an item undergoing deletion?

Should find return items using the old interval tree values or their
new updated values?

Jason
