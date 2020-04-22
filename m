Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460B11B4DE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDVUBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 16:01:00 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:38468
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbgDVUBA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 16:01:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPNq6tEP1s8plBNMbiozNjX4RcAzHplKRJVTzu5TzsnVixhU8mvL15vz/YFuXQ6SfTjYUF3lYVO8aDYpIj2WiXoAYZHJGKDIYeMc1CDP3WWrH86ZAygGnguyRy8zBRKit4iez8bWAAFtZ0S0iZQ5+CvKP7lq4cwaHCelrafounxEylWQs0h6MVnK25g3Uq3G/jkFBKe7qVTNnDwzVMkMvabVG6dlq5HJzdLCNjf/GmjSfvtPcn+6EUze6c8tiPUc+1vcR/NtzaxLKhJoZisUp4jltHchrcphHButRLbu3J3xQmcluMDOkF7+gfCnl25C2qDfNamvVY3P4QjN3Gzyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO98Z+sb2SmXHHMbGr7+4mDdqtz/s1x9agyLkz0bhyo=;
 b=Z0LIB6c8ypwem0lEncnRGvkzvUSAGe9mwRSYk/tGhFRyMBU4U4T0o0pKCr5Y7HXUnfc6x5VPJ/5zI5hwKZOfqtzBkvKv9ZUV76xUkZ0eFZu47SusaBooJZ+ItvC1BHaq18e4nRKo+egbjhnOMwadQYJkfJY4bT+b86h5GTJtCfpyOTcy2z0RDJVpzoemKpGOd5fQ9RmiiZrX2PREwTcoYaRf/Rv/g7NzculYokYtusbFwF2IiliBS9ucENXUbxe5sZddScsNxzCMUrzeu62hGufiZJURNjZECV2e7Bwgxvhaa2U9PaJuo99b7sJxVa21ZMZPURim1SUTqYqhK3J4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO98Z+sb2SmXHHMbGr7+4mDdqtz/s1x9agyLkz0bhyo=;
 b=fw5FP8P2o8PZymB7wtvimLshkm1WkH/A7Gr4IBFCDF9kogTVKXYjSX7QJl69woKeaWiLxRsfhjDqZCXstgUCgJYPsTLLUAQE8Czak4AryP3lUxHKfTuOcwjKr2pOG8bVvhCY+dc86DDRvILWUabzLYOFsrJXjlvCK5xdbY535NE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4207.eurprd05.prod.outlook.com (2603:10a6:803:45::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 20:00:55 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 20:00:55 +0000
Date:   Wed, 22 Apr 2020 17:00:52 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200422200052.GU11945@mellanox.com>
References: <20200422195028.3684-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422195028.3684-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:207:3c::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:207:3c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend Transport; Wed, 22 Apr 2020 20:00:55 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jRLYC-0003aN-BD; Wed, 22 Apr 2020 17:00:52 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3276d4f2-e7d9-487e-726d-08d7e6f7de29
X-MS-TrafficTypeDiagnostic: VI1PR05MB4207:
X-Microsoft-Antispam-PRVS: <VI1PR05MB420749F9C382818BC7542A70CFD20@VI1PR05MB4207.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(54906003)(52116002)(26005)(36756003)(478600001)(316002)(4326008)(66556008)(66476007)(186003)(8676002)(66946007)(81156014)(110136005)(2616005)(7416002)(2906002)(33656002)(86362001)(4744005)(5660300002)(1076003)(8936002)(9786002)(9746002)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xflFX/hoE4JQdyeON3AlGzUgwNU/cHAhnY2StPwIyHd08+aIL1Ia0X6Ghc5SXivWSK4V9OLzk2u397W4c7+tshDhD9lqrJtXAoQ1meXJvqiTpMm0cgjkZ8mb6h98pM6gR39uvt04ucTP58pkyPKO2V7+yAxGXUlKLB2Ip9grNJ30tFY/V0CGHSGT3+Y3pXCJ7FIH/bmf63bV7sVVrtCIhUG88ySQWem0y4r+kURExjBYAdytkeIAK9llaO0JjB7D8SYUiCx4xSWp8OTQxAiYH4fY6eNN2Ymzt1+GmtLfQXO6hYFNBRK56DaWX3RP7GC2rOgFbO8JhuoSqwGNuTczMDHimsFhAAmM03H0ka/QvmV21VP+tTml+IgO5Uh+9nxaRAILtG4yiV0A888nVYlI4BveGAoMTxWhOlyIWKZ9f/1u2dxtiupJB7Wwh6oBcFuMgJ7gRrl+LyfB2YsyZq19A3xnJp/bYGalktJD3aSgmXshzJ52JHA5IIZ/D6gnIb2
X-MS-Exchange-AntiSpam-MessageData: R3PEbmZ56oKZ1FXFGU71EhU0ZusOErOTqnP/TOhO4iOHlcvpYXzg8hTVMUibKLF9HgBdAFONAS897iaYBS8mQX82wMwdhEFNVWHKNp6WMXYXFA2CoHbyuhuJXH/hQeq+dSGrDrao1t+GYpYqoVG5Cw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3276d4f2-e7d9-487e-726d-08d7e6f7de29
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 20:00:55.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHaFFlooFliOsf8YZPHnDMJrtkrUBYCjM4tvruacSRkhqI+a/k6EXIwnctmEPNBIJRQ+ALcWTJhh+LeyZX8riw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4207
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 22, 2020 at 12:50:25PM -0700, Ralph Campbell wrote:
> This series adds basic self tests for HMM and are intended for Jason
> Gunthorpe's rdma tree since he is making some HMM related changes that
> this can help test.

This all seems pretty fine to me, if nobody from the selftest world
has remarks I will apply it after the api change to hmm_range_fault()

Jason
