Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A146ACF2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCFUbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFUbM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:31:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE244FAB5;
        Mon,  6 Mar 2023 12:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWzQBVerrabJL/umRrR8FRaZ6CX1XJzz/XEPGSDvcJNJZeHYenC6I+KpKYFWStbvib0GNWJUTR9OfBrbwgIQmjoSiv+GCKFpwcrQTEYPzTDpK8QwDo9T5VboulGU8u6LFFI3elpru8MExzNjsEki0Mr0bGA4uWVFrdqNP+EtrPOeZNl+v1gEYwm11+jeQHYLZgErm/L69s2b5clRsIJaFpSR+FzKyEgFaXZNGoOHz2xB2bj0OsznfWsxhZlqZ+el6hDffUo7wT9PqoQC9jekxBvfC1AEzweuRFP599c6xRSKjjxVJHtdhNh/XuC0kFNSHeH6/9+T65ByQDuZUIeB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEfSabtcj2mUmzRa+dyCXHoU8CI9hZBZEsSbRqw9GDU=;
 b=Ek/y+h3yteD49Gm27Z6Q8sRSiQI6Ea8870ms7sGGLqfKy2vtqG9hDZKMwoJNR3Au+TDeMLL33vzxtCHa66l/hWbMivfXVhB1qxPLIkQnX1TjvwocKghni0Cq86CnT9lHiUMbnVJmiBkO5Vlk3CN85S88Lo80gcHjcsnAmBQQe3+pLi06uyMYR9UwsxhJjHbZw5Tj+ChEFS7x/BuSdG/uVC1LrKzR4ij1FObG6h3QePmUUizE68Cxm45gJJQ2wzNqwpGym9HorxvvxLmbrn1ZsLyOjqFplCcW7q5ceHkM6nDJVZD1bIV/vY68HfYnKLWXx4KcdRLX6w2vHDkbU2qKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEfSabtcj2mUmzRa+dyCXHoU8CI9hZBZEsSbRqw9GDU=;
 b=kjdHEB4RFUxuiecSDmKX6UfO5rqzSq+xO31gFCDxHN8wQfQKniZ/8Kj0lGdFRrigSnQby7h5gxEpU8XVd9XVt6MxvQEtggwQBDAPHKB1BkN0ScgYgYx3XsyPcikznw4fOIpzhwpYn6b1TzxToXpOtyzklVbtJJ4q5EoXaz/boSWLIEg3PjJfp7g4Ih64gfmZvbG1dNKYdEUV0Rx4EN5/nDcle6j1b7ndVdU32sMv+WNR41WGEOl+lARf8a0ro0Hv/K0lxHHlk9DhoxcnNd21AM0DCpKgLM8vTf1EcCh2/GrvMMV114iiyPLPD8bBD+K5/QkcBmFV3xYBA3rwmVy6oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 20:31:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 20:31:08 +0000
Date:   Mon, 6 Mar 2023 16:31:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Message-ID: <ZAZNiiih8k4sAtK/@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <ZAVFIMCHBcv4pJjW@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAVFIMCHBcv4pJjW@Asurada-Nvidia>
X-ClientProxiedBy: CH0PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:610:33::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 217eae29-2933-41d5-2e24-08db1e81b781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dil/xIVbGI6QGpYBmmpQFx7R8hhRESa5y5zOictbOxwzRv2jtMNFpjT3BO0+ZBf4RbrlLHQQTl2lqfDUlmzRScaR1LHWFkMPgQEm4y4dgHt5qE6+G37c8e/XS7AGG95twbYgELAQOtpZo7yaQHAHOeyG7pFnf7omxf6HLyUNbg3K5RXkKEsR25fyx/FyAWEFauA+vdFacdgnmBYrrDWKVrBnDi2VD8K76W2O7twXQzYgnzg3khjKHSlY9KF1Av/MCZ5nE96wOIzzdrZPAuqxsWF0OPPaXLdqpqxjThKJMnArBT8+VA4HvzvFsI0bKTCMsIqxdN8cciqX92/QTRClr6v+hBSCMsCQDATpS4SrZxs1PS3FjZ3mWJVZznb/hQReqdsieki0St+Jgit/bhAuKt5smCiCi5/hYkzGg44adRtZ13VtvbCsjievkUj79sheo8ysAPJTrUkn2dyQh+MqkD/NlgqdK5BOM7GWtq82njgs9bKOXMC/ECeaDzhpJDLFxuFg2FZBWesFvKur8s/UtIG2vo8Lb2CmRJOwdI7tIbiZ0wIBx2x91b8pY6UuEXnQ0qeNVvsMP9W3ugEXIkRSZJUSOeoE3Q9hIV5Pcz+O0lgfh/se1n1yCpytdQ9JTQQktYqhEpZdiutopZjIBPKv5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199018)(6506007)(6512007)(6486002)(36756003)(83380400001)(86362001)(38100700002)(186003)(26005)(2616005)(41300700001)(66946007)(66556008)(4326008)(8676002)(2906002)(66476007)(8936002)(6862004)(4744005)(5660300002)(37006003)(54906003)(6636002)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?En8FeI0r6Z/XE2ZWTrTKfiv6o/7OOO2p01T3bYm/Cu5x5CVSPeDPM1WIFeTw?=
 =?us-ascii?Q?InFt6gg83EnhXQxKO2wKQV7tGwWA42ILSAFkBk9fr9OX9WHAuQMrCihzMIcH?=
 =?us-ascii?Q?JfRcHxMcMB6iJ/s4fHqAknXIRFJwAvewxkws+1vH9vCj87vigHQfL2DGIvGS?=
 =?us-ascii?Q?+vYeyMCWInYpfqNAZ1w1qcekRn7pBQourhflj9V+Pm/7x7uX9ApuYuzrgTK4?=
 =?us-ascii?Q?XM2DcXilsqUXxmHeFrNgDR2QcMhE5KitvJ/UiYV9H8rYy+E59FI1EN8vDPmC?=
 =?us-ascii?Q?mngAQEY+9hH3YsSd6/q5Pg7FPrGYOgLzPG75iVEr1y6a43FjrQSdd/oHPpCR?=
 =?us-ascii?Q?0Lx0G0Vw1XEqK8a41mKQ7fDJlJ7qPGumtGYe8qMhVzR4BD/KjN0SWs//5nrz?=
 =?us-ascii?Q?kw5UsIdpenmLaHRpxlrvmgNhIalw4KZwG6t0wLbJr0Ul9XhEHOwIFljoSGq2?=
 =?us-ascii?Q?q5bUWfRpnDuXXePY7vA+bNpbt23e5C322AZq/ovzzpdQCh2czKEtbX2/bkoZ?=
 =?us-ascii?Q?8rR7H3RZSZzMj7xbrXydGzD/4UawtEusmXvVibIJp0iOYv3+PqplIhI0mfmQ?=
 =?us-ascii?Q?6euRPlBE+J9pEBy1Gea6JTgNdXKrWE8/g7r+2Vyn8hcG4G4IYzIFtPoOc8Cc?=
 =?us-ascii?Q?cLhPztEU5KwCV4r4QmbFnB6R2q+xQb6NFOOdYuRdaCNq9Lry1/wUvNxu4UhQ?=
 =?us-ascii?Q?1s41zEu1z3w4KhlZ86hPm9m3a8YUsd6qeDFAa8MObDtRsueBH1OkQZBqQSE3?=
 =?us-ascii?Q?JBTbytNpEOh7AeKo9zzGVv5evbd/knmKtPEoBOptQ6m7d55zUaylV1XmgKsM?=
 =?us-ascii?Q?qfkkuQFMBJNZZYAZxSUUVkzD1EV4J75Z7wUVKkXnLsqwlBI4Fam0DHmSD0Av?=
 =?us-ascii?Q?h8en3iKTDNdBg67AtTlaCGeX7w4ZQuJep8tyFHugEGeQGI1VGlihWSZYWPPn?=
 =?us-ascii?Q?sJibyRv8sc60bKzNo+XPUs6TN2jJ75Rv6JgXApqyOf5Mq7CbvP3l2auZ8uHQ?=
 =?us-ascii?Q?4Ka/D7emLcdCMBaQdazpyHD75n3uK2Kh+r4AM7+SLa8xbOa7MtegULoP7PSR?=
 =?us-ascii?Q?4krwpS7Os1j+mL5XP55nhjz3zcbbxPwV5sma7ip1pY8K4UoEXAfo8B+/Bqda?=
 =?us-ascii?Q?sWVLGuA07Z4+TYGUsm7t6QML4oIde24uLrDjzmpRjmva5bPZdl7yE8j0YeDo?=
 =?us-ascii?Q?DGBpN8uMhFv0DWh8ISKNTDUP0zMP29V8goC2kMmj3ssODmgMiY3siMWrwdYn?=
 =?us-ascii?Q?lf78fZtdtAnRHfsAO4pglmgeZ3s7HEkaF+Jtl5Da3lUWENee/Qo94uNdtaFk?=
 =?us-ascii?Q?Hr8XAOaFINVwP/eXKugWY7zE1yF0HDOGZyDxG9WKmTcBWAZNvM4xjQufPLY6?=
 =?us-ascii?Q?CYexxZPuwWHnBt9j52jI0tQq7Bk7xIUolhD3+zXdiZVIgv2y0bKy+PRYZ4eT?=
 =?us-ascii?Q?XRSr0//vsbUDbsV2ipwnNNlxRN8Rlf8cjfkuWt5AUt9buWWEgnSg1v8Cdgro?=
 =?us-ascii?Q?oF/Ri2XUuYfJEAGD7vEm/WLr5dV8ex4zkmNrwNtrpziYgDVgnMxznhndRnJU?=
 =?us-ascii?Q?KDsypGQAFSaWMmOxyLadQMm25vN3tvlnsSm2DTz0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217eae29-2933-41d5-2e24-08db1e81b781
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:31:08.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddNFVj2hyx2UYj/TnjqnB3m9NsIIXeWPbfYRpf86nEuElU05le/mFxy398Wc0MqD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 05, 2023 at 05:42:56PM -0800, Nicolin Chen wrote:
> On Fri, Feb 24, 2023 at 08:27:57PM -0400, Jason Gunthorpe wrote:
> 
> > +int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	struct iommufd_device *idev;
> > +	struct iommufd_ioas *ioas;
> > +	int rc;
> > +
> > +	if (cmd->flags)
> > +		return -EOPNOTSUPP;
> > +
> > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +	if (IS_ERR(idev))
> > +		return PTR_ERR(idev);
> > +
> > +	ioas = iommufd_get_ioas(ucmd, cmd->pt_id);
> > +	if (IS_ERR(ioas)) {
> > +		rc = PTR_ERR(idev);
> 
> PTR_ERR(ioas)
> 
> > +		goto out_put_idev;
> > +	}
> > +
> > +	mutex_lock(&ioas->mutex);
> > +	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
> > +	mutex_unlock(&ioas->mutex);
> > +	if (IS_ERR(hwpt)) {
> > +		rc = PTR_ERR(idev);
>  
> PTR_ERR(hwpt)

Oops, yep

Thanks,
Jason
