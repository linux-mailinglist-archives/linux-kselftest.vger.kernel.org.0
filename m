Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7D21BDA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 21:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGJT1J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 15:27:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13951 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJT1J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 15:27:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08c09f0002>; Fri, 10 Jul 2020 12:25:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 12:27:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Jul 2020 12:27:08 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 19:27:08 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 10 Jul 2020 19:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq7VuaKEMFPcsmnTOVK9Ry2kF7BTohB/+Qyc1Sy7D3HuoOvpP1btgleXDGQtzNKOo8Z3XYlLnk+0WYcS35nO6EdArT2SIDZaH1RNKOC7CVIh7KH6PUCzZm2ooY9ZmODgAD0b1s3RiLzAmtimEHpuQhHjIe20iMGqGLsqdhAIh7YJXP/axjrIjDFa/6xSKxZPjVrLn08058/URbeqtF4DIIq50Hwx5EXnYPHRbT3K+8UAt6qXODZCtC8V8qBZn5ZaMtHDEKtYeRuJBTn69izKI18J08xLHXfw1SkRPVyx/NghusVyCWl6w1h8PKY50i5ZMFQyZR15w7ukFfVBKjnSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsl+3s7kxr7SMHNDGo4LHQjuAXbCM0wy7MBqQM85g1I=;
 b=nThigix6nu+a0UUI2ZbNlvo++I8Mk6+2u5UjpqkDYjWp9onaKUD/+UmesfNMWo/WgMsIhVB4/zDqHqDMpsjrWy4BQkCVtf5KYnnNafyLKFWL5cmFg/V9LBuj5LZJ6Q4thLbfpcpaMEV+lYcsdasENFfj6/s1FSR3aZaqrqt1kUKHyTSIzzXhLpAzUXbthYf0iA6O1AnS4+oTVnzZUcSqvyLW82Q+oHTRjRo/LI5fMXdozN+2NabuN8tbqoTeZ8ErIfMNOhsHZz1VL50mdfS/Nig63pcbTnkmOWpYF6M4Xx8TJ9no4sFtugH5RepPaedzHrJWnuc6fKJ4UjQt8Jarew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 19:27:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 19:27:06 +0000
Date:   Fri, 10 Jul 2020 16:27:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v3 0/5] mm/hmm/nouveau: add PMD system memory mapping
Message-ID: <20200710192704.GA2128670@nvidia.com>
References: <20200701225352.9649-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200701225352.9649-1-rcampbell@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:91::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10 via Frontend Transport; Fri, 10 Jul 2020 19:27:06 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jtyfo-008vmv-KO; Fri, 10 Jul 2020 16:27:04 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9177b145-75c2-4049-4736-08d825073b35
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812B6B56045DD6A1F58C927C2650@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 305Ufw90HhBFMT/1GPUc6uSet826Wvu296nfQyq6gnqQ8cYQD1Bnt3ooX1itvMdOl42zVCZpP5g8nWtNFpLma/hl0Rn8fQZjnrRs6AWVFknE4bZoyIdTPVgQT6CSWiXdxFifX+pin7IGYSnJmKzEBTNsqjhMN5DjfFl9/VLkPjVoB1Zkfe7+oMjUVSHbHDGBWL7SOiWBLHwy0upORL+obtA1szjDpUwQNbFc7IXNvo5FU2UyKPCzrDDip7v887awH5MMXFiW7KJUSdos0rMuCpdJ7PCW0IhwwGPjZXDTiZXCxtCwYBlQPAqMskniTZ+ppRtPQfKb/YefzPtShxbqEYaJ4Dapse7Hht6NgEUqS3YU5PObx7QtfPqOoYyguxHeCz9CUWEAK162LslJIceikg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(66946007)(33656002)(8676002)(66476007)(478600001)(966005)(66556008)(4326008)(54906003)(37006003)(5660300002)(316002)(83380400001)(6636002)(1076003)(9786002)(9746002)(36756003)(2906002)(8936002)(426003)(2616005)(26005)(86362001)(7416002)(186003)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A8BzdaAH9jnqq65Bw4sgRrR92lhlzNxUpzBZwAcuKzfwG1LrTamH04HuvBd7Uh4lP+izRYH8wc31C3YF0d7H5HrD4GYh0ubJ9yPGtl8y4usVXQ8wYu3AKvYaT4Sr7oiuRysanBjiz8vQLfz14d/AUNZ4ycUxu4Ohkr76NayzBRCgGV7lTZLy0dYkKWUCgv1Hkbsb+HDPePKUyIkq7g6aStPs/N9vqNiG1C1rFNF7a69rj2BuKJuYAjcsPeOTGoPD9B7cMP0Z7bdtBFppbZ66deQYRoz+DpKuWwsg/daF2aBhmC1QUK2Ly/byRGcsBOj3s6fqmQObiXeG9OM+BNKH9kzUPau9/uOf72WAXMDkcqiKypmH5TcLx4eeDwFgKg06dX7LN/aQbkyv9p5PIqNcmzmhGnloWvH+IERZbP2U+vZuciu4gq2AfNX2O+E23Z9OUL98Ho7sGz+rdynD1L6rYe95dM4+oHlbvX7XWjXCINg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9177b145-75c2-4049-4736-08d825073b35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 19:27:06.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwtRop608c1tIPU5Y1bLlyg2UDTtg0EAPjw0br3nS0wM332sqc0GGXmv698NzaQP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594409119; bh=Dsl+3s7kxr7SMHNDGo4LHQjuAXbCM0wy7MBqQM85g1I=;
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
        b=F2cDmiZtLmH9W++upqh2NucKtPkjA5uv6T8/zJuGaGPvrBsjlahofAXHrAENe7eaY
         g6Y0HULgjxF1shyI6IFcKrQFFglrq5js11q53Zh0hN6oJux23A6+gR1HQDNVTyiH49
         GetNPIwrKLtd9ra1/MHNOsLpdfW4yMAxJ1EIeQS2ZJr4IXOR1UZbetfr+YpNW9Hq1U
         4kWykxxX/pyJq+YTMfJDPEslAcxMUbt8WZLlYgTM9EcQwMjz0q48U8TIiEyzVCsJFY
         BuH6SBMi1aaGBDmD+uGpgi9JvKQ2M+SpA86biCIiIAXz0kKFHXMerdKbK1VniJ58UY
         Sg3UrcvvKoNWg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 01, 2020 at 03:53:47PM -0700, Ralph Campbell wrote:
> The goal for this series is to introduce the hmm_pfn_to_map_order()
> function. This allows a device driver to know that a given 4K PFN is
> actually mapped by the CPU using a larger sized CPU page table entry and
> therefore the device driver can safely map system memory using larger
> device MMU PTEs.
> The series is based on 5.8.0-rc3 and is intended for Jason Gunthorpe's
> hmm tree. These were originally part of a larger series:
> https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidia.com/
> 
> Changes in v3:
> Replaced the HMM_PFN_P[MU]D flags with hmm_pfn_to_map_order() to
> indicate the size of the CPU mapping.
> 
> Changes in v2:
> Make the hmm_range_fault() API changes into a separate series and add
>   two output flags for PMD/PUD instead of a single compund page flag as
>   suggested by Jason Gunthorpe.
> Make the nouveau page table changes a separate patch as suggested by
>   Ben Skeggs.
> Only add support for 2MB nouveau mappings initially since changing the
> 1:1 CPU/GPU page table size assumptions requires a bigger set of changes.
> Rebase to 5.8.0-rc3.
> 
> Ralph Campbell (5):
>   nouveau/hmm: fault one page at a time
>   mm/hmm: add hmm_mapping order
>   nouveau: fix mapping 2MB sysmem pages
>   nouveau/hmm: support mapping large sysmem pages
>   hmm: add tests for HMM_PFN_PMD flag

Applied to hmm.git. 

I edited the comment for hmm_pfn_to_map_order() and added a function
to compute the field.

Thanks,
Jason
