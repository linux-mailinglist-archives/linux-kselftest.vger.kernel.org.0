Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7757B13FA7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 21:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgAPUV7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 15:21:59 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:61249
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbgAPUV7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 15:21:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLCr3tQeqmO4H6sckgm/nrIzGjYtcKHaEwyF+cia7NAmLZtq3o5eMN+dwM4FwjJayUyRSkD7lLiKUAaduBThxdMYaG/3uYm7x3AedyOgZjC9iYfSisK3RJGND8oOJmY9lWPOFcL4diy/+g5ts2qon1wP+/Cwhg8wO87qKJ+/BANuGoAYZgSMKHK6be0ophQqVZCvdPSucJ1zzDzcXyn1nXhYXTxE3Xpbp9apETG1FpGhFNTr7kkCwkGWCo65Fh7eed9EydjYFSs6VO6llnQZ+LDOlb7jyIRhmK4XS5cFtsq6GlUZXSvq9Oevn2RHmqQcmWmIAPEZInsgjho5kweOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpkfEskVOZdeXATBRaW56BGB86QEhceibZ9l+k2ap1A=;
 b=YaJQQHLXkGfIIQcWLJtKSfDCOtEARz5fq7RwRAef7/fLXAwQ0W26sCOkgKzG7cK/GUf2K480NTCYrfRB0u8xMNE1qPHC9d+1htLNQy+/1NYs+uuiJkHxZxhM2fs+D16aLobYa23lTtY+iXAyRWY185QACqPb3Y3upmUgTSJ2RAo5mx6qDeIDolT+Re+4VWgym4n8kGNJL6l0MT2WQuZ2ycN44CfhBXNSso5Zgu+J6BzYB2WLOjouBHt3e4Gef0ogdsJj5S1ZyUPMJW7WHgTMpRISH0mZMfWYbWQtQtDOefs1C7dE2i6+oCdUNvFHfeCz98SCDCFebc4ZH03PCA58pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpkfEskVOZdeXATBRaW56BGB86QEhceibZ9l+k2ap1A=;
 b=m843Bre0F83QGtg/HMtHr76yNubZepzA3hW0Yz+DWln+iOZwKbO+5imr6DjjYptvNtLGvYhd7sy4Dql0bVtL8nibqUtgS6jESESXpSRrO+aGzoX+xOkSMPtGb3ThjEdkS55qO3zX9ZYEzNqGgP6Ha4RuhblR3JbQCl7kOYEO0mA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4624.eurprd05.prod.outlook.com (20.176.7.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 20:21:55 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 20:21:55 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:207:3c::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend Transport; Thu, 16 Jan 2020 20:21:55 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1isBeJ-0001J6-KZ; Thu, 16 Jan 2020 16:21:51 -0400
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
Thread-Index: AQHVymNqjXzbt52uukWssUL4CQa1/qfqIESAgAIr9ICAASsGAIAAR6gAgAABf4A=
Date:   Thu, 16 Jan 2020 20:21:55 +0000
Message-ID: <20200116202151.GS20978@mellanox.com>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
 <20200113224703.5917-6-rcampbell@nvidia.com>
 <20200114125957.GO20978@mellanox.com>
 <5845f50e-8bc0-8068-ee21-4f910beb1255@nvidia.com>
 <20200116160002.GL20978@mellanox.com>
 <01adb7dd-589e-2cde-4fa9-68baa44c0976@nvidia.com>
In-Reply-To: <01adb7dd-589e-2cde-4fa9-68baa44c0976@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65f98c01-af34-4ec0-40e2-08d79ac1badc
x-ms-traffictypediagnostic: VI1PR05MB4624:
x-microsoft-antispam-prvs: <VI1PR05MB4624B48B705C514E6CAEB395CF360@VI1PR05MB4624.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(2906002)(52116002)(66556008)(2616005)(7416002)(86362001)(966005)(508600001)(1076003)(33656002)(26005)(6916009)(186003)(5660300002)(81166006)(8676002)(4326008)(81156014)(4744005)(9786002)(36756003)(9746002)(66476007)(316002)(66446008)(64756008)(66946007)(8936002)(71200400001)(54906003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4624;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eq3QmYdwbJoRstxm5GiBJeI0xr04HS8KQT2TpDZpiQJEWaMViovPclAyqdXBT0skwHAnhdmzv9v2h64KAkhsUDNBCravLdeXe9Z6K8r7Qr/3dbRQf22+WZ9YoCYy5IrL6X9yXbqDmuUVMf0ZIUzVd+YpUDJ0MNwKpBkXM2xHDdT/CUXR15Kx/GiiLaFHs5aypm7DykGAYsi7OuJwaesRAkBPEif+S+icNYXtKwJ9p+ygI/fjFaHBaVNfRxZUUl1J0j336QBR/GxpZ4ylBP8Q9POKNk0UnAiIk6FgHSnd9+a3pQPtTmiooSwhw2SpyMK/kI7+jTZuyr1uA6ckVFYWBGgxV3CNEg0DB4rrRn/pdT9xNtCicskh7QxZpfkdH5eJjuo9fYsjtJI9fjyuQYekJ3qqhb5RrUE4pK9q0AdirWiBNUgvdmpZg2UlxgV7cZzFMtOyJUOEhpZ85eFZJZ8bJj63RKQazX35MZWbf15GWIAQH8YuWnD7Meqtx9qoX04WiL8LPqAXrcAC0q6GXT4Md9SrpTIB/FSgVzO1wqbADmTohLkNNcMQpJCAfYllDW1i
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44E2456FEB759847AAF542E9DDA6A620@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f98c01-af34-4ec0-40e2-08d79ac1badc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 20:21:55.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0vwmZpR647i/FTRBaf6kCMKC7l89kXi+1hZA79sgPcd2QnfLxj6eEKAKVt+ykR1pgN4AuistmaCNT6/08Q6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4624
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 16, 2020 at 12:16:30PM -0800, Ralph Campbell wrote:
> Can you point me to the latest ODP code? Seems like my understanding is
> quite off.

https://elixir.bootlin.com/linux/v5.5-rc6/source/drivers/infiniband/hw/mlx5=
/odp.c

Look for the word 'implicit'

mlx5_ib_invalidate_range() releases the interval_notifier when there are
no populated shadow PTEs in its leaf

pagefault_implicit_mr() creates an interval_notifier that covers the
level in the page table that needs population. Notice it just uses an
unlocked xa_load to find the page table level.

The locking is pretty tricky as it relies on RCU, but the fault flow
is fairly lightweight.

Jason
