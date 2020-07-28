Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB842231241
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgG1TP2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 15:15:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:5140 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgG1TP1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 15:15:27 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f20794b0000>; Wed, 29 Jul 2020 03:15:23 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jul 2020 12:15:23 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 28 Jul 2020 12:15:23 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul
 2020 19:15:22 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 28 Jul 2020 19:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRV6Fh7GziUTIDNjoxDzAay+PsG17PL5fliqyyzIdz/bn2zKBBqgegfbHJ0EcCBEAJg3Qq7BThHJ/u5AO8PUqkIzFg2/qNNmbFZ0mB9YWRK7hD1Tue58zcQ6ohmF10UnbH7O6WKNjDPWQcC58yDsC6DuySXgATAVBfj/Pvvx1Oe6DaFfHr0RahitGde8DROltFvA12xMEjjxlNLOJ+JyA/l/ZiE3YC5YZXH3sr9ap9aKZ0Hit67Sr7zVFECSCkUVww+beDMkXD3vXrzUgup/0Zs8duPCJ2LZgnnKB0g8LryAFGBamT8pTXkD7iSvmzH+j/3oQyjqFidqNlagtTS/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeNoQhlOF2fFxSAftUqt6fC0NQGDE04LF8LzMamEzdc=;
 b=Yvp5Ims5WVGYu929HEMxOy8m/xLqLKs0H3hasW2cqvjxMILfCRXoZXIOL0iR7CzSvO9RXcasceRnrmkHhUsPOrA7Q3uPalteRJ7twx0gkSz9EG+TUzKYBFTn0SS2kOt8RHH5DY8Sg6KyeZVQTYyNCbiIL7OZ2r5RXTJ3zmR8cDHio2BFRMqdoxiJHOU4+4YSi+eqs1JnKKJ7e9pJ5o8U9qjqqRYDssD6VBUP9GsW6E6PcHsHvXQ56c5TH89GINy+v/LI1hTb1yl3st72gzZ89lgIsrlM3hTUQ5cd0nYuILDEy94IqOmue67qb1y7tfDRjV8OOGLVNNNFZYVGYOJQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Tue, 28 Jul 2020 19:15:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 19:15:20 +0000
Date:   Tue, 28 Jul 2020 16:15:18 -0300
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
Subject: Re: [PATCH v4 3/6] mm/notifier: add migration invalidation type
Message-ID: <20200728191518.GA159104@nvidia.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
 <20200723223004.9586-4-rcampbell@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200723223004.9586-4-rcampbell@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:208:134::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:208:134::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 19:15:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0V4I-000fXl-Tm; Tue, 28 Jul 2020 16:15:18 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cdaeee0-0c4b-40c1-c44f-08d8332a91ca
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1515E35511089C096E10ACBCC2730@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVChklyLQAyK48pWtA7+W/aB2dtYvKefZjzBifLv5lptZlBpekJdcCIneoov1izqbZIDNEC8Yw5pihYH/d4G8pXOtO4hDGOkFHyrmPnrrOToOfFBib4meb6gubuZJ+kiCX8yGHjsEBPDEF6vyCsfda/Ozs2hz8uplWnjNGFQA0BbvOoCgtgSFyGS1GDUq//1zMDwUcCvc97lfQ8V+sFqxCR/HJb8kTfaTYqX5/c7tMKI1SXExB+r10nm5RCmA1N6nlsoquICtcprc9ZiGXOgt/g8rdQyTQbeAf5lNUmgzozWmESTCh/bfI9XbEFCvYTON2r4+iQYKA2RwnKW2/sjsA+ZbXdru4Sc5d2aCPgk2e26rRY9825AVNtyJML/KV62
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(4744005)(1076003)(54906003)(37006003)(6636002)(2906002)(316002)(7416002)(8936002)(5660300002)(8676002)(9746002)(9786002)(33656002)(478600001)(66556008)(66476007)(26005)(186003)(66946007)(86362001)(2616005)(6862004)(4326008)(426003)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RBJrtRMwBoRVmLRUwWoCl7FTp/VclOwxmFS0uC7wDOidKik0e/ZSXxLb+zo2VtLplcCEqdSg1TFzTJmJZMqlR7UsTpqk/kBlNIyvwVNz/Tz9wCtze06j4rgH3mreyD3zqRucOSyTX91cR3FXCfGzxBvsctzE1js0edgD5Lmin8G397jClog0tMxyPnsj/LC8iVp16ZEocxiWRuKhP1UxWcRMSJd2u43ZlBgucbWorud94NPyYtRN4bTAs5IE6y25r5rJan+zdADXYllzd3+0Nap+qLJwh4Hwi1wlkScNhwEzyKdYEM5WxAw8Arxd3WdfGW6BE2LkbKeipNClhgll4J2StGyG4Uo2gDD8zkhtckEpZKtyS4Ki5tuojOCMmKF4R16O/JR5MoBo1/W1BdRemYkd548q0T7ci7Prg0MAKSw55D8AtH7rQtmhEU65Qc8po36KCWPntrCz5J7fNhc+/fofn8KQ7pODuhIeZOf3Hq4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdaeee0-0c4b-40c1-c44f-08d8332a91ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 19:15:20.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUfALy/QnfGcZM+xyqvpwFi8hbl38bfcI6Jr6V91sFxA+dhlfqt5yj/7Mlya7F/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595963723; bh=oeNoQhlOF2fFxSAftUqt6fC0NQGDE04LF8LzMamEzdc=;
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
        b=DTR5ZyDsmlBfs+dpERGF38p/VUECPe9XoeFd+SmVGKvEJkjLMVZGtXIwyM9lUJefe
         ZGunyqmQeuBmhcfGVWKkJMI8e96RfHBx1ZTJ49ZMO+B67Uvz4zmpLDwT9W4dlYRyHR
         lpENFb3/PVtw8FUYf9uNo/cPW7qbMJXw1D6lOdK/mPxuO0VUH8/NTevQTLK5ZPYEYD
         IWazd1Tk6/0419EnMc2s5l0KvBKeXXFRfWSnMh5e3x0xJ0X95lbjcUD7DaumQYVHiG
         33sijOyBp/aMz5mfp8IAev+KVvnVd6n9D+2+LnexUWY9tQpe4EEQ2z6spwdGCq+H57
         Uu1i6RHxia4Lw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 23, 2020 at 03:30:01PM -0700, Ralph Campbell wrote:
>  static inline int mm_has_notifiers(struct mm_struct *mm)
> @@ -513,6 +519,7 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
>  	range->start = start;
>  	range->end = end;
>  	range->flags = flags;
> +	range->migrate_pgmap_owner = NULL;
>  }

Since this function is commonly called and nobody should read
migrate_pgmap_owner unless MMU_NOTIFY_MIGRATE is set as the event,
this assignment can be dropped.

Jason
