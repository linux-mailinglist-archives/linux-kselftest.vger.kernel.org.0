Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1118E21E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Mar 2020 15:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCUOn6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Mar 2020 10:43:58 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:58543
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbgCUOn6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Mar 2020 10:43:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvzPcWw4mzJIU7/WWvwqx4dg3cqz6NkRiBShPucNxokCU4pIcLjDYypqvvHDomO7ISu26u/O0UINmTaB9Twnme0T/pWwzc9qrIkC8RPGFiM6PhVk7N/G+PfY7Ikke0+ZGHDv6gUX3a8BeXd2oTIOxeTnrUdrMOZvYIgOBXoKF8E7PBeE6ZvlA2RzncoYNOjBrx0T5CneBQjMsmb3QGCKCB0AFissBYDv2hrbbAPPsRNZXLffIbCm/+vTnk6uEjtUkcAQOAYQY2Te0ski105klmYU7h2rJ52qIr13cOBMRR70JmhZMp1bt8ITOmtf6L3E7a4ieyz1uFP4TU96vDJYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsIr2ekW0R51VS/6AHX5yRVGYfFXg13LZwAZJbk24U4=;
 b=dfaljEf5npx8EhIllL3FbXhXQ4uWE8IyOhtmacPKcrt57MTsC9hBD2m+aYgc6525x7K3HxNATPX92LipSx/rEMK5vqtE8bBNLSW8NaUlUul96lOqpk3z3tPPhJIV3Wlb2EA3Gi6AGZtqJZKytdP9mCX7Y6DAbl6hk0mmTHY0TcFnXfJp8vpJmGUG343MpZXVuNeSlD5g+c40S+jz+OuZ2NtmLAwW7+IciS+MLI6scu5McK+5DtxOp8vXHn0QntH0FQfCCBzYDdSBdj80XyX5iXUCmYbhEFbINxZuJxCHeq+5NlXX6CD989hFzEKbzoj3AsllE3WWIjJ5Cj24qevDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsIr2ekW0R51VS/6AHX5yRVGYfFXg13LZwAZJbk24U4=;
 b=bjtYPXj+bAXpTj6icuBELVod4s2bHCP02hAToW2K9h8GVUaJD8zHSJfYGh4q6m2gYQ4I+E3VdOFmBkGv3T8BUFmj6pCQ95tByO8fcXYoN8hMVMWFvTn6/GMWQpSyOejjtbR1lHo1nPOaPsNGI1HCsDSU4iUUMrTomeyZCJE9hmQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6445.eurprd05.prod.outlook.com (20.179.27.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Sat, 21 Mar 2020 14:43:55 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Sat, 21 Mar 2020
 14:43:55 +0000
Date:   Sat, 21 Mar 2020 11:43:50 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200321144350.GQ13183@mellanox.com>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321003108.22941-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:208:23e::13) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:208:23e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.21 via Frontend Transport; Sat, 21 Mar 2020 14:43:54 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jFfLq-000165-H1; Sat, 21 Mar 2020 11:43:50 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c084b2c-be47-4303-8fe1-08d7cda6476c
X-MS-TrafficTypeDiagnostic: VI1PR05MB6445:
X-Microsoft-Antispam-PRVS: <VI1PR05MB64450885217BB0E68AA5F6CECFF20@VI1PR05MB6445.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 034902F5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39850400004)(136003)(376002)(199004)(4744005)(33656002)(478600001)(7416002)(86362001)(81166006)(36756003)(4326008)(2906002)(8676002)(186003)(81156014)(66946007)(54906003)(2616005)(52116002)(1076003)(66556008)(66476007)(316002)(5660300002)(110136005)(9786002)(9746002)(8936002)(26005)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6445;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9EYXBASJV2HuEOs6wy1qdOGqRMK/E+B9EHQpwR2E3UVisuf18osV3F+Q6DU59UpU0PoUpzL+oQzOaKDMgwumXb4aQCzTdbKgr5Y+umdRwHSbQhD5u1B1lwA5OWPDlgU+qRNGiCp8TshGn71thJVaom4s0+YCGIjtPkJbNXNjgKyp5+5rREeaqHsMSkfMXUp0x/dDyTfsBTny4stB6OzA9F8b4/3fl2BUwMn1jFJXmo7eyBHN3RkVatm1BfL2THdUiTQ13hFfS9zNQxcE9eEC18P1TUS4jMDaOtBQvseiSlV/ci0h3vZMdxn/vayCAnK5bItXS7+RaICXVbo/uHich49JKkjm/RS2FyYaVIVBNyVK01mrdulBZpTee0937H0gKmxi7cS8QcAFE4t9f4RHkAcyBJoIGh5MLesXdZsXFeK0uJxp6zUhwUGDjt7erLdwDBBqRq78X2fmt+KBORS+71tzYF6Nnjcd+B4yi3QuhuhKTAZfBewdnNLcXXLzsKG
X-MS-Exchange-AntiSpam-MessageData: MrSUyNwbvrFZdCUrXZdzivE4VVaWdkhRvcigtIOzQ2+PEP/EtH9hxCQl8PuwoKuFxglz1qN+cGKdZYzbi9Kh+iWIq0+oNF9n+Z5jVmRkI5WzMx+L8CCbSHIihrm6RxoVZwObRYL9Tiq/heiYK019gg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c084b2c-be47-4303-8fe1-08d7cda6476c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2020 14:43:54.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXA3FfXXFJX0osuojluQcStV0beeW/P8ALaRJTPqcLpdaxa5miBMtJDxhpxXfaBaSCWVu76faR4uT/b2xU1w8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6445
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> This series adds basic self tests for HMM and are intended for Jason
> Gunthorpe's rdma tree which has a number of HMM patches applied.

We are at v8 of this series and noboy from the selftests land has
commented, can someone help?

Jason
