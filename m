Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9079513A995
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 13:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgANMpa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 07:45:30 -0500
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:6069
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbgANMpa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 07:45:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq1u2P1stFd2kBKMjR+A+ynd4ZbIzucggXLk4sx33mf+mr1lNxXoS6WFIbE+lOkSmrHCB+GcLRlADejQofORFtGNRX7gTzMyQ3fIn/SD9fPfTOYPa012Izum35wyMX5vWFWYm0pJnRJlLyLgI4Fee+z/+CuzWir3hYsglYyZEqhPlIXbdG3wtFDHnEuAgw2m6b3wen8tnhGP1aZDKVD9v+0SvokzbFFF+pIiLbxDN1JVEh6KLEFlUAWAHFnJF2S0zKQ9AosAEZS3rQaiW4eQ0O+DAcjD7osgfUHgbHiuD0O1ihr+qkvtrUNW3biR+Y2AagELf9Q2dwXR7nJw9X0+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spg3lBFjL6jFBypta8RI6PxCBcLRGJsQGd8+tPOhcE8=;
 b=SHlCqxrwxxzUVbQBq71v8bZtO6iaxGfVHBvmYAoL0faxnAkrPjaGR690eQ2lSArMOwUrtboXxJ92DiPvrqvRi7YLWwd+7jehyBC8VKc78PoNzrJRjUqkTt/RTS3Eyf+qP+BBZ6BagXCukEVdUStnTVNTsyz3hX8ahPO5lMM/32ziLTGgtC0ByBLGfg+vE6tkFnnIkBKyF1U74ceNZMBHQoWju7KTd4AwOLmEg+4VIvpI+XCH80kpRWES6lrGJ3b7+6KI15NZ9FoYbdgFG1YElKzRgto0P3RPDS8Smj/D07YxRE7hSw+oKsmXf2jgpW0NwDe3oRkfaKDxzww2bTdKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spg3lBFjL6jFBypta8RI6PxCBcLRGJsQGd8+tPOhcE8=;
 b=jXUvgtW67v//eJI9L5w5tLLNTdg4qlJKD5WGn3VyE0zw0JxKcA/XUZjMgvSjineArmQfdNgePfbW7+pYo/HX7N6dwIYt25INi9KqOuBU7otLUZ8NlSbd2QW3eFO5fh5Vr1IiNDK94hF9F1KC7nG8ecNRWpPMGB/PtBTKpBMvVJY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4303.eurprd05.prod.outlook.com (52.133.15.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 12:45:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 12:45:26 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:23a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11 via Frontend Transport; Tue, 14 Jan 2020 12:45:26 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1irLZT-0005oa-5y; Tue, 14 Jan 2020 08:45:23 -0400
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
Thread-Index: AQHVtEsczeksfKC51EmFDx7aa5U3hKfi4tSAgAAlPICAABeZAIAGPeMAgADq14A=
Date:   Tue, 14 Jan 2020 12:45:26 +0000
Message-ID: <20200114124523.GM20978@mellanox.com>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
 <20191216195733.28353-2-rcampbell@nvidia.com>
 <20200109194805.GK20978@mellanox.com>
 <73225ded-c22d-33f2-ebcb-b9e9aa95266b@nvidia.com>
 <20200109232548.GO20978@mellanox.com>
 <633a3dda-d4d7-1233-b290-53d36fb8fda1@nvidia.com>
In-Reply-To: <633a3dda-d4d7-1233-b290-53d36fb8fda1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae819793-7c8f-46f6-77d2-08d798efa101
x-ms-traffictypediagnostic: VI1PR05MB4303:
x-microsoft-antispam-prvs: <VI1PR05MB43037E89488D4CB3E666BCB1CF340@VI1PR05MB4303.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(8676002)(52116002)(66446008)(1076003)(2616005)(558084003)(186003)(26005)(54906003)(8936002)(5660300002)(9746002)(9786002)(7416002)(86362001)(81156014)(81166006)(15650500001)(33656002)(66476007)(2906002)(4326008)(6916009)(66946007)(66556008)(71200400001)(36756003)(498600001)(64756008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4303;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1dYYNySpS/5ZJY6Zso55nL6KzvZMA5rJ+IPzZUYfCy0ZZW5W94kTIHBukDBA0njVhVFeXQGMlTTTmOKj1cIIKmjThY5DZEiPqwpx5B2eJQ1GUwNS3M5U7d5nGWT8efKkRqAeMlXREiSJ/T7NXLQ8p1bdBRY4jTA6gd77lPjqUyC1VmsiWw+NoVGmr6eYjCFm9Kqr7f9PNxCblyYtwmLoz1G8Ast9SWjHFvDNnn0DfAO1QItqy8JfLCnFfCVclw9f05niyRjxgJ6fxJtRsF9UyLIAsq+6NHCEsPV4K+64Uskvp2RnOOdAE/GWlNUQNMAy6uMOpx4KUmQSYd8mkyLPyPg/MJdWYWm2IabD/IxKQjy+5sXYUhE6KP0VfjeO7hk3bkU6pG7ANL5hCaN2zMr/fC/rtZc1iiWLCwaLOWf9QhUst2nwpUCLzNqB0OhGIHJgi15q8yui3Nh9otLt9G/sVV4I82/wUgC0odsYYB+B7T8LsCZCHdZptz3EKVjS+C2E
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52D9FE7B2FA91941B468D6267DA6CA97@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae819793-7c8f-46f6-77d2-08d798efa101
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 12:45:26.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WG8snBU0whMrxb8KX6wF6m8c6bzM1eXPhDH5VZHhHl73HClbzcm/KK1Qblb9H/SpA40sYK8ziaDvtweXk7lpYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4303
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 02:44:52PM -0800, Ralph Campbell wrote:

> I'm using the device driver lock to serialize find/insert/update/remove
> changes to the interval tree.

The device driver lock can't really fully serialize this as it doesn't
effect how the intersection lookup runs.

Jason
