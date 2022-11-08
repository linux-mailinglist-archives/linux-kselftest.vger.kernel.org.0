Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D0621B42
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiKHR5Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiKHR5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:57:14 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95161A80A;
        Tue,  8 Nov 2022 09:57:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azwt/z0z0F+vvhs+qrMw3snhOeTOWZKc4bLqlM1mOv30U8BU3kaSY8sikWisy5cFXHZgXPbYG/5dXto/QvTxBPHGVgT4sHeNvaUhNqOaherfOrwKIAzGYz/dzKiFKlFqD8D7QXho8n7xerb/0Cl04VsOPv/d7SxprdlhEPq3b0ii5GBtoJn+tRllrwEL5uIu4yM5euGIh/vP3SnPNtsTOIAcBTMcsGNgh1+b404MOW9ZaHC8tgRAUzxtTPUZGZHAb/SGBBFkITMhVQWja1YiFTPUIMLOfUL8160PySl3lzHL3jWVSmmyA3GwhfqH0+edkbIqHc53j9+U7wX6vgEpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eB6UXbeCUZbPbpsR6COyGhET08rXi95JQRmA8dXsQQ=;
 b=WpikBDAXm/LHv2pGjZQXkaOcT67+R6Her2StkxmxmQZP9joPWuW4Jq7ifNVtZZnkrxCNcFSW4A3HGwhuXzEQf26ULf03g3vSbn5tobOriejFl5pYgwpJZr07SsZ+Dyc6OAL8nlhcgIGTz7IWAATiFxifKZ0hU0Me0CuOuEdm8959ZZp+P/n9xewQOddgeU07+L5n8e5+idPKbO4GjvdExWP0/1XG9/MkFW4o1LLs9Ds5zSkOjVJJPg0hDtKPTFIERp6xuWX3tV8Nv3kJuYhmSBSmckgnfuWwBH56kA+DHFrhcHTbMlz3Ybs4myNSx0NRv6idd0CsUtNOHySgkqMAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eB6UXbeCUZbPbpsR6COyGhET08rXi95JQRmA8dXsQQ=;
 b=m7zmbKXGCBcnzvARHmgMqwPn2WsDsEJzrk0LIb3dJP7B0T3LERLNNl7mAJFXZk0ESuwbvJ3KXT3xtJdpUNCI1+HzqI7t+rlEY81vLXU3jVc+Ah6B2KgvGFHHEgQNZ6ZTaTSp1WzEBBPu+ljzMwZDREz4bAcyoYVf57+rqGr+/Frixdoi5N2NLbXvKyhc/mNfI29BSsXDtDIkpE8AMTdSh4vQvE+8jua76oECnlJqlKfgbTA6eLhiu2k1j2NV+ook52tlLkKfRmJYWE7xwt7UY3TfIXZgTHSNkisyAEyteqpUIFxhp39yDXFV6pjRCJI0EVchU5+jKspzhzW+MJbX0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:31d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 17:57:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 17:57:12 +0000
Date:   Tue, 8 Nov 2022 13:57:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 12/17] iommufd: Add kAPI toward external drivers for
 physical devices
Message-ID: <Y2qYd4W2zlvHLfJ7@nvidia.com>
References: <12-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <2cbd00ff-a51f-bd0f-1bd9-67db5f5d22f4@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbd00ff-a51f-bd0f-1bd9-67db5f5d22f4@intel.com>
X-ClientProxiedBy: MN2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:208:134::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b077e7c-f595-4420-649b-08dac1b2a97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhYNGrLY27xyJxvq1mMqfFAX3DPyHyipRi3gLTT3qESUGaTpqMkwpXBkICQ2dldvpMIIAcD9nLLBDw6kFuVHK695qh04rZpGJC1kb0j8pkhsQFRhA+pn9tkivPj5a3JqdaJWte/Nyzm7h/9eNcrJfJknLyCqxvmvomytqACOLFxQfnbFPSByeXqQl5WYiDLZT8+9slJ0iKBXvsHzTAx58fUfCLw+Q4umvs4E0ki5hp6DRd1z9EmW/HL2EDXervVi3oChh0PzjYnzrnrELFoJjKFSjjIHZDdQRDj4tRGeZYwiMfpAf47EUhxXQA+/oujKAraBQ5V3kI6pR1B742KR+HQcNVAPKHUQ4sUjiY7OEfZaGkamtYYQ7/7aQvaFGYueJwybqv85qsMQOSIe3fUHt65jrX4BQHOed3lSf52rIXYAMaRXBVYcJu6Hs95zG0GklrA+YF/yLJ8r7X0H2zumwzD7q4xlHLdL8acGO7tr3SG77e/XA71tSfySob0YybNNgaUo9I4WcGkcMqCJmZhWFkrM2AKiISxwqZqLkIBrceF+/XgPf2TyRUdEaL3InN+dxHeBnUP7V+XW3CLQAwkSm8IAymQxznmWEGDuN23XiZO06bUzEqple+G28NudaQwWyHq1bro0uHjkwLMTuxQvAhzWCnHlrDiEkkEi+g+Lf3L2T6EDo1n3mBQr2crNbZFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(26005)(38100700002)(2616005)(6506007)(6512007)(186003)(83380400001)(7416002)(5660300002)(2906002)(7406005)(478600001)(6916009)(316002)(6486002)(41300700001)(66476007)(4326008)(8936002)(66556008)(8676002)(54906003)(66946007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9nqBZGL3TiFn8nvqhYqBbai/pXfLbkXR1BXftWQuSduNgeN1a7MnoysRk9y7?=
 =?us-ascii?Q?FspPwacFJQS3OobGs9y7yEMhTvVxWsJSFaiHsacuakKKgVELLH5qFOSbEKmG?=
 =?us-ascii?Q?LQGabKYmnqIBb7Fxl3fZ+wG6fD5P6az1TMkMpVEHasP0ElIq2jqENLYKnDxV?=
 =?us-ascii?Q?cEnldZaPBMiem/YFW7KC0b046iRsPwr0Rak8rMMyyKaRElforuZLZSyh4zAU?=
 =?us-ascii?Q?QypATIkhD6fhTj/su5PIlxcDjz3ZD2bnWRghxorkcOf7ZDoPyUFWFt9dj8NL?=
 =?us-ascii?Q?3aJrCXlJdKE+Y41wct1ykAOohpnNdejVFU9z1OqhJmup51wqjnqwoDR76dwP?=
 =?us-ascii?Q?ogg8UDNEN/0gOFXNufuAqkvkqEZ21qTduYcF+w/wlgPgCw0ILdyR2X284srg?=
 =?us-ascii?Q?idZlLAYDH2+W+wLGDk/CZzHlCtUKHfxZexPXIPPt1jPa8TUI3aFPLQfvFZb0?=
 =?us-ascii?Q?i2/ThoqIcmZxhDHOhyhIborvjc+zDZs2AnE31d+jjgYR/ejwidm/y1xKPpRD?=
 =?us-ascii?Q?kFhLXRC/T+GXtFmoTd723JXWaF0TusTfjw1K4VD23kkg7E50JJOVJG7NdeQ3?=
 =?us-ascii?Q?e9z3a/daC8gYe4PJ98nieT+CpkhBaGXhXpASFw5hZKA5gkdN77+AzrB73gLG?=
 =?us-ascii?Q?f4251Lbh4IukVUnLIqFw6Ma/a1zWh4wbnW40Z3mtup614Y1PCOgXz7n8JEPo?=
 =?us-ascii?Q?MxV10Tmwj6gtQTHQJF6h0PSWviMrPcQVEdKJ9BEYouM6cT9lMBo8puYPh7RZ?=
 =?us-ascii?Q?Z+ff0ZG/kcW52zOa/xlMr+XrfHDBHB9UlW7nmsfA3dH4Y0rBBw+bsvhwEm8A?=
 =?us-ascii?Q?j0IAeUu5705xWriC+kjiC9Ne3bG2m1meDa757Gmkl4p1YSJ2E/R4m7uj+U4w?=
 =?us-ascii?Q?dEGsZHHn6rVDdTx++uFG2XiSzd/2FOgh16NgGTlc9Qkn56A/XfarSLcm2fgR?=
 =?us-ascii?Q?m8PXD0M4iXbW3oIx6NPXXN3TBTIAXAj4+1hoUxTBTKksnEIGhEBP1rBqRdX4?=
 =?us-ascii?Q?dxRwJIT/yR5L2mnE/fqx1GbA/sQRX1hURFCl/TPM2oTCOLa3+FrilGI8B8DU?=
 =?us-ascii?Q?OGn8B+sa9IdJMT8uqj6VWbPjIOOCmrR/Q+0Y/gajrqcLyUJeXF3zEK0g8mgt?=
 =?us-ascii?Q?DA6389tnZ3VhdFXTj2M4meGNYjw08ypGlgL5KKFof+09ZZ0MpC56g4WKf0ca?=
 =?us-ascii?Q?XVLfgLifKj6p31cGXJQM+UVbaw9iz55xGZ4PWKSAat5kdgU3oavzc7K7kDfs?=
 =?us-ascii?Q?JFoxnfCGmcyxvxe93uXsR+kCxgLWvqu+FAUYeOdetvTN9+PJMawfk8P9CU6E?=
 =?us-ascii?Q?aAAMyIC7rExMxFTwNMj3o870J7hmFelwJfKgBI1EPg+AKG/Zj1K9foDMdLdP?=
 =?us-ascii?Q?+zdpTn+cFkLzbbLWv8nZVZNmHJDjjZ1GoWTId38Py8jPRfmrKEWJs1QXWuk/?=
 =?us-ascii?Q?0Z/1MA3gtcaRN3af5byiURtM6ZJrHofLSgOXA9u3wv3GNHEYfV3Me7XISsxA?=
 =?us-ascii?Q?E6vXsKEBCi4gzcnIPfxfPzF5gtjLmdGb31JJLeS5p5qDf1N1stqNN9sHNEby?=
 =?us-ascii?Q?9gAnZljRmngA5eD7leA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b077e7c-f595-4420-649b-08dac1b2a97b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:57:11.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzcioPbbA5Glyc1btNeAb/KNQI28X9LE4HPjxl+xfhQQYs+IsV17GsLMQlZTzgTc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 08, 2022 at 10:34:05PM +0800, Yi Liu wrote:
> > +/**
> > + * iommufd_device_bind - Bind a physical device to an iommu fd
> > + * @ictx: iommufd file descriptor
> > + * @dev: Pointer to a physical PCI device struct
> > + * @id: Output ID number to return to userspace for this device
> > + *
> > + * A successful bind establishes an ownership over the device and returns
> > + * struct iommufd_device pointer, otherwise returns error pointer.
> > + *
> > + * A driver using this API must set driver_managed_dma and must not touch
> > + * the device until this routine succeeds and establishes ownership.
> > + *
> > + * Binding a PCI device places the entire RID under iommufd control.
> > + *
> > + * The caller must undo this with iommufd_unbind_device()
> 
> it should be iommufd_device_unbind() now.

Done

> > +static int iommufd_device_do_attach(struct iommufd_device *idev,
> > +				    struct iommufd_hw_pagetable *hwpt,
> > +				    unsigned int flags)
> > +{
> > +	phys_addr_t sw_msi_start = 0;
> > +	int rc;
> > +
> > +	mutex_lock(&hwpt->devices_lock);
> > +
> > +	/*
> > +	 * Try to upgrade the domain we have, it is an iommu driver bug to
> > +	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
> > +	 * enforce_cache_coherency when there are no devices attached to the
> > +	 * domain.
> > +	 */
> > +	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
> > +		if (hwpt->domain->ops->enforce_cache_coherency)
> > +			hwpt->enforce_cache_coherency =
> > +				hwpt->domain->ops->enforce_cache_coherency(
> > +					hwpt->domain);
> > +		if (!hwpt->enforce_cache_coherency) {
> > +			WARN_ON(list_empty(&hwpt->devices));
> > +			rc = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +	}
> > +
> > +	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
> > +						   idev->group, &sw_msi_start);
> > +	if (rc)
> > +		goto out_unlock;
> > +
> > +	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start, flags);
> > +	if (rc)
> > +		goto out_iova;
> 
> aren't the above two operations only once for a group? I remember you did
> the two after iommu_attach_group().

No, with the new attach logic per-device is simpler.

iopt_table_enforce_group_resv_regions() tags all the reserved ranges
with:

		rc = iopt_reserve_iova(iopt, resv->start,
				       resv->length - 1 + resv->start,
				       device);

So they are all undone as each device detaches

And iommufd_device_setup_msi() keeps track of what has happened to the
domain via:

		if (hwpt->msi_cookie)
			return 0;
		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
		if (rc)
			return rc;
		hwpt->msi_cookie = true;

So it is OK to call it multiple times

Thanks,
Jason
