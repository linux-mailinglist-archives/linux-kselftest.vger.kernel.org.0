Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3D231266
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbgG1TTo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 15:19:44 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8824 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgG1TTn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 15:19:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f207a220000>; Tue, 28 Jul 2020 12:18:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jul 2020 12:19:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Jul 2020 12:19:43 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul
 2020 19:19:43 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 28 Jul 2020 19:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7xczPTIrdb2tBmwBFqqp2z17r7NxVe0mYoDSosdh713bkPeT1Y69+QDd/nf5g9MLQG6Jg71BYBf7DHfQhZ6I6cwJe85luj8r9j+BD/AXGIhUgRUd/MT6E/snmNUQyXzSNEtk3L7nTSVC48wm/35Tj01V46QbazpsVqdkhuqzbHYah2payQSni23V/Nj1+DBykL8vQozDBLaanbFU2Ie6AsdoxGk3E2Eq87yrlqQr4t1KqcL6XNZS+4slbYixyusT5/4nCzcS2jMBJpI+ss5IFhYog2NCZ0vARoJEnJYNgj5+etzTspHujK0gSi8N3Sz63LNG+iB4Vj4SvxvY5gMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIb88fB47ym3ieV7dn4/8WHqEoVsXlmU+Us+MOFdO04=;
 b=kAOW1m1EfCAi7r/pLc2n7l85Ilbr/HSkNRk2BgpLhY0ccJV7UFCrZ6QdphPQy0ZOMRjY8RV6yXdWHy35mV0eVLU/P4l25RsSiIJbgYpWUzXEYBwmyRn2D8wHJjzdaflNFQ4Y3mXrtllKh2bi9GJ1lRKW1sB/Byl/bAuCn+5G8MiAyxCs4pKe6p5R2yRN8w4YYJwBMRQ/PRqgu//mzaL1ofeDpDbc9xNYSHaS8TbBHLh937WrRjMy0iLBkxFiYJaDo2NVjsBYzMt03LOdEhVeeupoVktxsKWJ/LPSrd7znQKSZTmK/0mHyCffb6MbWbps4DvqEVgtlN/y5F0Rwo9Qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 19:19:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 19:19:42 +0000
Date:   Tue, 28 Jul 2020 16:19:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] mm/migrate: remove range invalidation in
 migrate_vma_pages()
Message-ID: <20200728191940.GB159104@nvidia.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
 <20200723223004.9586-7-rcampbell@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200723223004.9586-7-rcampbell@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:208:178::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:208:178::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 19:19:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0V8W-000fbL-7N; Tue, 28 Jul 2020 16:19:40 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476d43a1-5962-48c3-6922-08d8332b2df5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34035F2D32B8A5F653FF5D22C2730@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l155qzqTsU8UKV8l7o/b35tcL+JU1fiQPymTS4j/UxYwDGO5VSPEd/nV3GIzOKCz82VQKAtfNGEPL5zFbA3jCgJV5An57PPcQxUBbK+IKSC85PSSMJZmWNymkqPWfdicXl+Dy28Q2UPvQ7ezdWO3qzB27uV6Ob+LNffO4InUS9671umbMnMc5+taiFPyO5NcZbCMh0EG4e1bKO0Q/cEMqnKyQJO035lozJrxT71uHA2iutEBAMB7zJTYSy33w7oUua3DiT4q9H9uzMzw6Zh+kmrm6lceu+1qb0K3PjYgwY3SHS+oN8mCFWufNuTzLOh27wPsmjcAjXd1kAodOJY0Wb00Er38SYtNyOkTE9IBm4ewn9y/XiUHYTjACexDyf09
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(316002)(4326008)(36756003)(66946007)(26005)(8936002)(186003)(9786002)(66476007)(2616005)(66556008)(86362001)(9746002)(426003)(6862004)(8676002)(83380400001)(1076003)(33656002)(2906002)(7416002)(4744005)(6636002)(37006003)(54906003)(5660300002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hHvyWOkJToqhcXAHiMouituo8D1cpQKq78AhzHWR8xuKSBPOo2ZaIC+UNC1hawYjkpMbYCxRRVzBrVehOOpBXG5Sv7S53LHUgDsV08ddpcQG8IfwPxfrobMCLCm6ya/BCGhzhpIIUGfUgVsl0zgj5DFuhe2UIhjjew5utskNRZhGPFpDQ1gCkiQ677nPEHg25ocoozUqk//FKCaKo/2WZ4ADx+ecmLtipO/1QRyxPzwkb+ATeHLHlyI2veJRojwkSyk9bh9ZzuEXbLcfukeBthd9dKP2ViPOb2nLDlM9SMH/Kx26GPw2IfoHLTxMoQRc6emqDE6y4vBUSnn75/8t89wUsuXcQhmTcV1dNFNJrPzMHQacppF8nUx2mT4isAH5wDSO0XGYZt+v69BV4mKQzEjJCPBifGUS6OWowfpxTKCWW5YmpL5D8v3UWaPbjIJuJaQ8BdI/g/iU1CM1P0Y1UKsq+JvQOhNAuTzF1GRNSIs=
X-MS-Exchange-CrossTenant-Network-Message-Id: 476d43a1-5962-48c3-6922-08d8332b2df5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 19:19:42.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jSfcwUAeYsNIu07CmlXSmfdZXvBFivttJIhVf5JJ6UR1vJkBql6L/hEUWZXrmoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595963938; bh=aIb88fB47ym3ieV7dn4/8WHqEoVsXlmU+Us+MOFdO04=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=j9SFDCsSMmfi42b8AcdC18Tc4VNQIi3JT8PZ7mPnoDTT3poW00uK/SRcwEOod44Jy
         8E5sR6Hl7ZWELgifoEQxGMMNi4NDkSZK1vj10ZH/F0lagG3djQAyAJ5UTBE1COBbm7
         w9pGxCbQGjgLkEqWVN1oR02IlplgaeYDh/aIKRQbB8vKOgH5sEK3zdOlrbLuzhuhOU
         CJEr2eUqmlGowzt9mWhNbrCUivY2yV1T1zl8/WLLMKYAHfI+Wgpx6/XRPmte5QrUoe
         A62uNy3SlKZw2pEYpRDBjitoVgUT6ZND1TtimAuemUzynfmP/9yVi2BqsI9F5pkrmE
         7OFRVgFeJezVA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 23, 2020 at 03:30:04PM -0700, Ralph Campbell wrote:
> When migrating the special zero page, migrate_vma_pages() calls
> mmu_notifier_invalidate_range_start() before replacing the zero page
> PFN in the CPU page tables. This is unnecessary since the range was
> invalidated in migrate_vma_setup() and the page table entry is checked
> to be sure it hasn't changed between migrate_vma_setup() and
> migrate_vma_pages(). Therefore, remove the redundant invalidation.

I don't follow this logic, the purpose of the invalidation is also to
clear out anything that may be mirroring this VA, and "the page hasn't
changed" doesn't seem to rule out that case?

I'm also not sure I follow where the zero page came from?

Jason
