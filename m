Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53065226F6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 22:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgGTT7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 15:59:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17957 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGTT7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 15:59:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f15f7740000>; Mon, 20 Jul 2020 12:58:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 12:59:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Jul 2020 12:59:45 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 19:59:45 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 20 Jul 2020 19:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd+pYszM1SyD1KVg66iRCKyN7LG9O98q7U6BLmC+BFS7q3P0Osbez1ntIqKun2RAWejjzNv1EZynU/vja03ZS43YJv79rARGYL1nCSPMkWbmPQgYLcMGV4kwDAOEgOr+RDgYd901y+1i8/AIKdsUmMMqo9e2zA7YrfH/IaIWrpVe//00zUN2SCo8DjUdcFDiUcP5QricvFZD2BSu0oASc0n2NV4l2FI08CekVquo1KD0+nac8hbcxpngykzmaR4DFjK95BXzQaT35C2KgCRrBDSKwrByZUrcnJu2V9WK4+IC3//oBtqhGYsFkpZANlhWU6t8nllS8pCiXT+OgxvqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUfd7wccwejYJaa940EGkBKcxqqS4gjNNqXzTfJ0aQQ=;
 b=kLy1zykvoUAL/97vZ2wKldWACDkCDGJvrKHeZGVpnuaVI4ZLAB4LhG1XQUeRX1igM3mS0fkEcRfQPJFxCQmvD2lF0NnFM6wVFC95F4R/C0JuwDnN/McZ8x9ryjGHMr0j9eJChlmY5DdC6acA586inOBx0I8y70ZwFv4WUQD2M9w8kKynRFVv1JePHMNTiuq3eq71B991XU0bztpaMjEpAJjKj7ID9fNoSiU3LyANlvi2pOkhfInocziFhY1kU4X30juFJ75HnLtxo72Ib6h+i7zu7ChoHmaQHXsWXi0WdK604+yAeFLDzUUFQw8qOz82Nw1ehDo4SsJvAeKj4d1J+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 19:59:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 19:59:44 +0000
Date:   Mon, 20 Jul 2020 16:59:43 -0300
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
Subject: Re: [PATCH v2 2/5] mm/migrate: add a direction parameter to
 migrate_vma
Message-ID: <20200720195943.GH2021234@nvidia.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
 <20200713172149.2310-3-rcampbell@nvidia.com>
 <20200720183643.GA3028737@nvidia.com>
 <2e775a5d-9d62-de52-6799-3bbb09c88c5a@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e775a5d-9d62-de52-6799-3bbb09c88c5a@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:207:3d::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0067.namprd02.prod.outlook.com (2603:10b6:207:3d::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 19:59:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jxbwt-00Cr1V-3u; Mon, 20 Jul 2020 16:59:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e3258b9-331d-4ff3-9b25-08d82ce77263
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4250493765A3BDDFB00838A8C27B0@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hk4Aule/HPc12q4amoN2kZekyryMSW2AGeDdCwiWjkyha6st9khTKJqvYSYwlQP8xhO3chfcnS4xutUFKZMrI4XWZX2kQIZEzpm5+ucFWmM/De4d2Bn/r19c3efYNROSh/kGEYRTd6tRd9mcLTxBZ7sMfN1BWVMOJckebelH9Ni2A8KBgKvYVNqwm4EUTQM2y6rCsYVyHL8MY2td/msXkMXH4hQ/dSid3H26uQf3/GEqU2U+uaKQzejCZm0rj7dk+o6lVgKIGHAlkm5Qikmjey3miOEYzC547nQos9yS2PZDOV34WrNuZwGKGFwhwgX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(36756003)(6862004)(6636002)(316002)(8936002)(426003)(186003)(2906002)(86362001)(37006003)(26005)(54906003)(2616005)(8676002)(478600001)(9786002)(1076003)(9746002)(66946007)(66556008)(66476007)(5660300002)(7416002)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 72/lgBbYtJgjUZm0U2QfLOGFGNWjX0VN4gVOxJnmd3Uab+xPLrzaggf7BjqASMijplUPvQYxSL8sbYZu8CYjN6HtLBgbxillRIl8osvjM4ObAqOSsORGnKOjPTrvFLaR+w2c3yJgfqNF+bvfmnnuUJfug6wn+Q1nrTaQvOS5R3o6ATxCftRPeAwU85WBHOU2iaPZDZot2tZDjsvwVXhFN5SSlOZ1Tzdx0DsOtxKWZ1Z7u7ENw0pjbt+EzR7wZFklxtHieC0+5SRlPycmZukE6HiwdCAQxcp4WCtaXodojLqTlU9759HZk0f+xQIY2zcJ1IMa/p/crh1hLDIsc6c27anVY6GeKyv5iFeGotG0qO4613fx8fqpgA0uHpGWCB0pI56X9vZcqwcTZV9U4wVWBjo9o7o5SwwreDlogXOM/bFc0GvnjolBQ4ExnysC6D0bVy9mDGdiowzcSXc4RKMU5IMtw7hSBUUPDUi4s4VW+0I=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3258b9-331d-4ff3-9b25-08d82ce77263
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 19:59:44.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SOLb5YH5JLqEY5pOSrM25fE+NqC1Hpj3/F59/b+Tr39EVZZEDnsRaQ+ZNVLyBJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595275124; bh=aUfd7wccwejYJaa940EGkBKcxqqS4gjNNqXzTfJ0aQQ=;
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
        b=nzqkYCKtHjTHne6jj7lFexU4PmgOLhFKL7GbbU5W0M2gCXopYj6+eAF+ZuflVLdtX
         uGN26L5rFInXFM1ieErFfujPCaVtktnd9imY2ZGKSxGdbtroAGCeIn/byTzII6NkWr
         h4svGPTB96A4U0BzGtFCNR2rqMGcfOv9CSpXV1Swi92+MZUwO62CkASDpAgClTcQAT
         Z6P5pILgKfrx60hK3UeovqpBPq8jKm0vnMlK5CG31+mMdmw9oNv5CzSydHzMViwE5m
         2ZPQ0Nt52aPCpWoRvNxoac9slHSRR1RljyUZu8oKYG4KgCjPmk+RBy6GJbZwgq0PqH
         BfcPisnnJWBJQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 20, 2020 at 12:54:53PM -0700, Ralph Campbell wrote:
> > > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > > index 3e546cbf03dd..620f2235d7d4 100644
> > > +++ b/include/linux/migrate.h
> > > @@ -180,6 +180,11 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
> > >   	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
> > >   }
> > > +enum migrate_vma_direction {
> > > +	MIGRATE_VMA_FROM_SYSTEM,
> > > +	MIGRATE_VMA_FROM_DEVICE_PRIVATE,
> > > +};
> > 
> > I would have guessed this is more natural as _FROM_DEVICE_ and
> > TO_DEVICE_ ?
> 
> The caller controls where the destination memory is allocated so it isn't
> necessarily device private memory, it could be from system to system.
> The use case for system to system memory migration is for hardware
> like ARM SMMU or PCIe ATS where a single set of page tables is shared by
> the device and a CPU process over a coherent system memory bus.
> Also many integrated GPUs in SOCs fall into this category too.

Maybe just TO/FROM_DEIVCE then? Even though the memory is not
DEVICE_PRIVATE it is still device owned pages right?

> So to me, it makes more sense to specify the direction based on the
> source location.

It feels strange because the driver doesn't always know or control the
source?

Jason
