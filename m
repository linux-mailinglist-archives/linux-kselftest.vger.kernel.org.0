Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE71C7D5861
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjJXQbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjJXQbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 12:31:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E34B1B3;
        Tue, 24 Oct 2023 09:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaDscwwXjEWNUQnzoTFcAId2RLGBv0ReEL6NDJX7FT3K9m6ifpPl7hYbLLkyQ7EJ35wc9qU2/2Xz2le1n4P9EsPiaHFe1AqbMXrPADkMxiu2pVdJqBuuTdagqBG65FuUTD6EYgVWfxBUydtOJgrZAG3vinpclKiXIG9Hfok5VGqqHdiFvx+ZzLkAHigI46+ygt+W18gjaH87bJsdHyh44FgNSVvJFS36QBqdV6bE33efD/I1UZdP5IJcTI4UbhB1QyynKvywU64sY8SYZ4+ob1mMKl/eLjk78Y1MXAFjDwYxoPX9SnXW6hS4LYa/QXNqO1TvENnVi1mvoF3p+HbwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjZEdiirtYBSxvJvgn//0j05xm1W/fOYUZtkEVaP2MM=;
 b=CZYzWFXtKARglJeRHicIemu2Xkyt8gAdWWVA6biRD1Tzcqk4zEAH3MurdtUW2mAZ057VEHsxf794Mtdclw0OMKuisTYq7Gsu+8f9QMSWuUvVS2zP96s7pFuLxixc9aTGzrVDjoL1m0b/nNdFDi6aJdQ74g5oLi9Q6CnjWQEqXYuhxgfFcfMHGH1Z3AWBr4BGr8kBqFJ/cbzIB15DZS7IICBC7l5wvTSuDDjPsvzsFXnm5TH2daf5uium+NJWeoA9dyiamOIuGdWSqujrak27FEi8vBOagY+hmWgc5cpsinwpi5SvuEGjsXneKYpwWe9QqPkcMNpvGcaFGvfb+a+gVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjZEdiirtYBSxvJvgn//0j05xm1W/fOYUZtkEVaP2MM=;
 b=XUZdt1oHwFl4vki43j4fqeZ9+keNd8iyHhrtmF/99sdJrjB8eTpr6N2YiCWs3QjY+aduaWm/x9eKAnb0azO2J1aZXVyNZu0o3FYtf9V1LGJqjdBFl5Ssw9sj+dT7BKsQI8aBab9sOJ5kmUmPsp8c+yfQH0QsIp8Jzqhr4+WVLSxNT3ylsZ/4Wkj+gof/jAfVEyadxXcVh3hySy0FulJKBosR2lJ6SRo/r8YGbKDykLYJoKGZXMK3KM/JeFsfUjUy4wFRdztLWsFzGbeR83MC+QnrZCsX0ioX8qHE63cBmfMUlwJIx4PfiTPKv3rCAVzkzENoyJFTTpPg3PRF5FXbAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 16:31:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 16:31:32 +0000
Date:   Tue, 24 Oct 2023 13:31:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 05/10] iommufd: Derive iommufd_hwpt_paging from
 iommufd_hw_pagetable
Message-ID: <20231024163130.GM3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150609.46884-6-yi.l.liu@intel.com>
X-ClientProxiedBy: DM6PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:5:15b::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb70415-7be8-4a9f-f30d-08dbd4aeae95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7rShTxNLCROwSQFczErMLQQjb+LvYO2Z+rhyn8kw+zzqxdSFlkmt5IIxu2MmBpGbO/+Z9ZQpAbWmBM8VZsShWqx1smVC3n6l1iRZSbLT5wnvL4FC3vMDQ/Jz4SikPbS1nBJkFMdOZ7qUwVpJO0P7lf9/Um4kRekKOyLlfsP1qcrlgkYK9BG1qL3ARntE0Y06XD3OXZNcgxCQ/zqcbBX6qKJaK5m81pdk6fT+aquIx/zEXRPcpRburJrKxYScCWNKko8cJgq6XBn5I9GzO0vIsdVcGgZ5Jlev4PbJzVzoYSdzCcc5BITQBYpN9ppJrSQYo1FQJ4ciI/q+xjf755WEl1jcpme5Syre5iPCyVXqJuxxuqLRpXqkV6rC3vKf6C14qBW1fUe7lZeGedhzd0JgwL4OvI9uZTcvQNbhw6qDZ0NMfXCD6IRhweitU2LvyuU98L1AHrG6zn9RrE81ycUl+R1mFPCpGPQylLpGsRfrxxYSP+dJqgz5vblqcbqWNFjqlzRaNaJwWPzLoaDc5o1WQy3ZK7ohYqpfKx+9MidgaQ7KYzTBvMvYqJUhlwyjXvl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(2616005)(1076003)(26005)(33656002)(66946007)(8676002)(83380400001)(6916009)(316002)(6486002)(4326008)(66556008)(66476007)(8936002)(36756003)(478600001)(41300700001)(6506007)(6512007)(5660300002)(7416002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Its1zLgU3rNDp4pXIbq/Z0Uhtcg/Xgj8QV5ntj4NdSI3TlDpMryCEQ8bXmH?=
 =?us-ascii?Q?lkrWoVPPT82G3/j8yFvhZZcHeIRGeUmWSTmaiAo9JHSDRAjBerJfPKoJxzlk?=
 =?us-ascii?Q?4Z0xoqAUALYolRJKXQjA6YTCEfD3NzU5f2eAYviQeXH8VPUNKtpZwxEDbHbM?=
 =?us-ascii?Q?0OBZ9evpzyWcOuPiIzB1lZZp0EVZjA/zo0vp2g09zaOC/2AVejDzuqND3q3Q?=
 =?us-ascii?Q?tmwXyVS+5A3SekpfmRY7KJWphkMp87gvCQ0/vIueUwI6wIDYQzAKx9Zl2Pck?=
 =?us-ascii?Q?aln39ibtwJpVjD6LZCRh/wwK182K7z9zACP/tYZ3I8bAiUTe8AG0nkM3PQB8?=
 =?us-ascii?Q?Mw11jC54YJTKsBxP0gYGajO/Py2sFc50PabCg6UaqO/c2CHQrwFToMsrSkfk?=
 =?us-ascii?Q?1G0MYUniED3e6WcgGyScSpCXvFrCznzi+9SBLj3fRx8Rs/nFIrRzb40btqi/?=
 =?us-ascii?Q?td+oSkH7U+tBztaICYvtd1wiraR5bgRWNYfVzXL0BMJtS2tz6zJFQrrRr8vT?=
 =?us-ascii?Q?2svcYk6SckptvKPGN2hyEv3Az0QWBK02j+461K30uuqbSA+AwcLQRVZoe4U2?=
 =?us-ascii?Q?aaRHdn8iAqFY2wuMlErlNJelevXoujaZQJQKUB16NMIzsx3QY0ogM6psZYLt?=
 =?us-ascii?Q?U0dC0wiXbODT7m92skkcpdfRtwr0YQ6rCwzVpUkT7fIlRf4m4C+ZlTt5Ccfr?=
 =?us-ascii?Q?7EWli3TEZHIGdPgpJRBswrE8zWDtPtBytxnuq5p8YJ8Zhk0QWt921mTDWsTn?=
 =?us-ascii?Q?nD8RChsWF02Zo9hjNmHxs7qGMEfmpmxV1U0284XAz2Uec6nRg4vtZtnRKhMZ?=
 =?us-ascii?Q?PHV5v7dGlPdYbxPHAeEjTHSJgwbf7Y66/5W+rVsWEaxY5kVc7eTg2VBM4UTj?=
 =?us-ascii?Q?/ovsMaDpE56fZYc8fJdF3vZZoeF4o8e7c5EyBygkSKlZvc0dPEamgYKLjPlM?=
 =?us-ascii?Q?qZ3QxoKjeD0UsZcR4LV/Kpqx1gr5R7dEflB3Hi8kSJxLHxCpCFvzQ1E7dgkY?=
 =?us-ascii?Q?XvItX4sWQKxw2AmuxpbW1vAq2JzRowmvpGW/0dnZPTB6JDnKH2sBHmPlOciQ?=
 =?us-ascii?Q?XCKhuKrwIbCxC3o+/mLAdg+VL2+cK3WZsP2BMfXRfy2sEYY1LKPNdlW8PFIN?=
 =?us-ascii?Q?kARktNWS26mcJZTevvIhdYrs71bhgdtDIOw4MdF8sLNmeYHgyP7Sm/z4saYJ?=
 =?us-ascii?Q?Qf+Yq+xQY9ymJ2eHLGYPBmpdTkV4XAZrxI6b9uCu7Qkeaj8sohsBGlkbnhng?=
 =?us-ascii?Q?VFiBR+ss+H4cLSNUHfj/oJjCX81dtlb+yXMugbw6GCBXFuyv/7oipzEV4mp+?=
 =?us-ascii?Q?3zkfanzcxme9xUCLP/aH8SJBsm8/p19odkZDuVs3vaXlglyWAs1ILLWfWVK9?=
 =?us-ascii?Q?U86bPcJqVgDcdlcBusiw+LgGiOIMpJ1HJobsDf8hSM5TAMPQWI9ZqlIqBBbW?=
 =?us-ascii?Q?mP69Hd3Z7zyZneO5NgKVHIYZAVkqY4qcGU7EfngWo+auDIixfPz9WoaYwrcP?=
 =?us-ascii?Q?UgmjM1RUb4vmnX0J0aFhJRTt+Et2YCVM8Ju/GK+KvYt2Fj5aNNwoF+7C06KW?=
 =?us-ascii?Q?rilFZdqkcE/rXMwSIESVyllsG3sEdH6fnG6ArLSk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb70415-7be8-4a9f-f30d-08dbd4aeae95
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:31:32.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUOBIsuj5wD7/KkOirHPpi7jSgfogAJJa0l+beFXhUIH3YJp6cJu7VIidDFsJf1D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:06:04AM -0700, Yi Liu wrote:

>  static int iommufd_group_do_replace_paging(struct iommufd_group *igroup,
> -					   struct iommufd_hw_pagetable *hwpt)
> +					   struct iommufd_hwpt_paging *hwpt_paging)
>  {
>  	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
>  	struct iommufd_device *cur;
> @@ -441,22 +447,23 @@ static int iommufd_group_do_replace_paging(struct iommufd_group *igroup,
>  
>  	lockdep_assert_held(&igroup->lock);
>  
> -	if (hwpt_is_paging(old_hwpt) && hwpt->ioas != old_hwpt->ioas) {
> +	if (hwpt_is_paging(old_hwpt) &&
> +	    hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
>  		list_for_each_entry(cur, &igroup->device_list, group_item) {
>  			rc = iopt_table_enforce_dev_resv_regions(
> -				&hwpt->ioas->iopt, cur->dev, NULL);
> +				&hwpt_paging->ioas->iopt, cur->dev, NULL);
>  			if (rc)
>  				goto err_unresv;
>  		}
>  	}
>  
> -	rc = iommufd_group_setup_msi(igroup, hwpt);
> +	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
>  	if (rc)
>  		goto err_unresv;
>  	return 0;
>  
>  err_unresv:
> -	iommufd_group_remove_reserved_iova(igroup, hwpt);
> +	iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
>  	return rc;
>  }
>  
> @@ -482,7 +489,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>  	}
>  
>  	if (hwpt_is_paging(hwpt)) {
> -		rc = iommufd_group_do_replace_paging(igroup, hwpt);
> +		rc = iommufd_group_do_replace_paging(igroup,
> +						     to_hwpt_paging(hwpt));
>  		if (rc)
>  			goto err_unlock;
>  	}
> @@ -493,8 +501,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>  
>  	old_hwpt = igroup->hwpt;
>  	if (hwpt_is_paging(old_hwpt) &&
> -	    (!hwpt_is_paging(hwpt) || hwpt->ioas != old_hwpt->ioas))
> -		iommufd_group_remove_reserved_iova(igroup, old_hwpt);
> +	    (!hwpt_is_paging(hwpt) ||
> +	     to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))
> +		iommufd_group_remove_reserved_iova(igroup,
> +						   to_hwpt_paging(old_hwpt));
>  
>  	igroup->hwpt = hwpt;
>  
> @@ -513,7 +523,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>  	return old_hwpt;
>  err_unresv:
>  	if (hwpt_is_paging(hwpt))
> -		iommufd_group_remove_reserved_iova(igroup, hwpt);
> +		iommufd_group_remove_reserved_iova(igroup,
> +						   to_hwpt_paging(old_hwpt));

This gets a compiler warning:

../drivers/iommu/iommufd/device.c:527:25: warning: variable 'old_hwpt' is uninitialized when used here [-Wuninitialized]
                                                   to_hwpt_paging(old_hwpt));
                                                                  ^~~~~~~~
../drivers/iommu/iommufd/device.c:475:39: note: initialize the variable 'old_hwpt' to silence this warning
        struct iommufd_hw_pagetable *old_hwpt;
                                             ^
                                              = NULL

I fixed it with:

--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -488,6 +488,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
                return NULL;
        }
 
+       old_hwpt = igroup->hwpt;
        if (hwpt_is_paging(hwpt)) {
                rc = iommufd_group_do_replace_paging(igroup,
                                                     to_hwpt_paging(hwpt));
@@ -499,7 +500,6 @@ iommufd_device_do_replace(struct iommufd_device *idev,
        if (rc)
                goto err_unresv;
 
-       old_hwpt = igroup->hwpt;
        if (hwpt_is_paging(old_hwpt) &&
            (!hwpt_is_paging(hwpt) ||
             to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))

Jason
