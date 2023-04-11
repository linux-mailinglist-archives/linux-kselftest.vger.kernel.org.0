Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36D6DDDFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDKObi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDKObU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:31:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455752D77;
        Tue, 11 Apr 2023 07:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQfQM3SM3K8HVRuCG+mQWPSxSebh0euifMEJmX6u/z1qv/FpnUDDmnQmk2+/Kt2xEJMT5838rpdS3HE8CQCsUQ4ZiCh6M4QShKxd4VyMxJqRBluyb9ZyhIbr6BUltCIrpD1sVbNzazBTmo8gKab7q3USOWYA5x6QuMRmaN1svJiauKmOZyU7rJcWASoRYL2Xz7BUivCy+2fEMHxYXq5f5PirtZzBCYsj6rjXvTR5jyXg/spQcSst8ISby5lCvw4umw0fTsmRoLesySOqjak+2rTK3UoODU3G2L3Zk8WyigKfK6tMeTf8N/yqJCd2+NFeNxReJJzi5dPN+I6S+GVd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsfQZaqaR/E7SMPgoppmrrryvUbOoU2SYCN5nEWH3XE=;
 b=AVrPhEq9LunWt67TnkLgCaBqQEMlGMzpHN5Zj6YS+mETWdPHohnjVnlAS9G9yQZT9oYMVN+40y3IyTvC0Lw6QPJRFUTeMOPNXdzWO/kwO7NVZKCzUssvQTEkiS2NjUE5zXTkbJfeoUfUF+2Qw+DLcAfYV6sDQ3qui82cl7eOWdnKNQ0al8WnTRW5mFsrfYMhTyFhlSn6B/hlpoI1NGpKb7EuXqj8ddqDtAkLKYCGnNNlkH4ytLdRTCL8haXccWaPZVTqtRzPl+d1MCCmBO5zH7PONJnS63MeZycDhkmvIccVpE6yVs3cv4ulaTyJuZ2sKIsu7ztB4KErxAwjRP2TwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsfQZaqaR/E7SMPgoppmrrryvUbOoU2SYCN5nEWH3XE=;
 b=o2aG54gaAt5ZRKrOwe1D0lOVF4opg4101lt6vpfJWyONryD8CUZd0Cnh/6fM0CHnR+SahLics41cz91Gc3XIvBVUpCgPNEvBAPIacTM9QxAYyIt3ckqP3nOpufcShj/JM5e8By3u0xtL+6XOv9/Do/kTBbuPCai3V92kRquxIXj0kC3ZmQUht7d+E+4V6AvK+aMU3TUABB3Q57Vd5qiyCJmNGBfEEu6Shl49j3oD6VnSf5sLnpXD/ZFycdyex17oSTSDt0ZhXR1jiIZIsmXxZlraa5WDkYwQKn7j8Dr5YzVoumI6n/6brYLL5nb68VTqxPtzb90ONldKgQmNXX+Cqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 14:31:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 14:31:11 +0000
Date:   Tue, 11 Apr 2023 11:31:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZDVvLbSN2TR1Er1c@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0407.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2cadf6-a6e8-4efd-20d7-08db3a9965c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBHSlazu2X2W/tkiWMcU5lOWr7VjwNF8OyQxcq1s8f8I74k3MD5Ew8XsbVOCSTotzwmCgLQUiEtwQ6Wmu5T+Z/RDaNM14a6aPfoxDasWlWAFfNBs1nJpWAe1jbtlBVsWTiYoTUnP94skJfdDybEXpCvADX4hKo6w/GRTrwhwOnh0dt8AO/WK3Kqd2WMEEqVwefzCF3HE7umFP18URxmkA1DyatQtPddfiWmUXGIRjzah9z0S30iBYkIk9uC5Pya8USzK4lA6P9gfpCeP1JV+uKVUh2nHLUh6Ra80Xl0fKL9qCMBsqdZM+wka6HpgOT1mOYg0oObpzehOZddM+aTJp3HthKyHwdIKPhLqD8NQaxVGZAwJsxV+MbZj+/GOd9MB/6ixp8IGSMG8DbmOVP1F8jWIObM2UJ2QH7CKXZkEPHvK7vea5b53TtAzk4FlvmAyqiH8f9QAQ2bZ54UYITWNm2TuEV/keyGddikxjzaOFGiZp+grzGUPztrY+yFey98X5Q7G/6gBM0QJHlmWBErVpgJgvnx5pO5X/fdBEmUGBRyI/WB7W1Sr9mgEPvL1QfYuDuKnBrEXB+u2QWRsUoQLtqyDtqcl05fRD9peBxH6CUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(478600001)(86362001)(83380400001)(36756003)(2616005)(38100700002)(6486002)(4744005)(2906002)(966005)(6512007)(316002)(26005)(54906003)(6506007)(186003)(66476007)(41300700001)(8676002)(6916009)(66556008)(8936002)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oCgyN1tlYX2S4aG042FaV6fa1n8O3IOoxxkdjSikAZ/b4nN2fuOEcjKEfd1f?=
 =?us-ascii?Q?9q8acF6tKqiLJCNJ4c3zT0CVuXEw23c1WHF7FwpNtV0R1JF4CNsH2m3BVmNp?=
 =?us-ascii?Q?F5qrAMjYHnAhO4J2oktf9HYI1HkIpdfH5yEudgwfVCG4Hijr9KiupmQAVebh?=
 =?us-ascii?Q?w8VwnXUzaJfEa3b+p6PKW+xtG1laaaPOUC/ZdFb6eEYEBIiZxZdRycm2MNm6?=
 =?us-ascii?Q?5l0CUAKhckMBKdoqohAos6YLZ0pB5vy8y65RknJeg83bycWNJjLkivMWb3cw?=
 =?us-ascii?Q?8xXmjeeLW99KSsUSsunFLLwSHMC0z7mYmSWCtPdLeYP+AUbx/87/DDX1LmIL?=
 =?us-ascii?Q?KLxmT4d6o+YGlhBajZmPyIomK8MNA0FyBhQxDz3CX4+3N0cgcTFg2GxTteBJ?=
 =?us-ascii?Q?Ow5Rq2iQ9sB6QhdGUmN4tH/whD+RKaXNoqjWXF/X5L7Hu6PekW+FNCNd+sBp?=
 =?us-ascii?Q?V4bhEZ5INBP/eQZCMXE9ZDTLxDx/uKZXJi0Oruz+DNpmjw4J/tKqoU6/m039?=
 =?us-ascii?Q?fp/SAEG7zV6pVcRS3knJPHgXDyk6UXZM3c0oK4jhBYHoOllC922UlUpgeQwZ?=
 =?us-ascii?Q?fQe8aq0pDXLMROnyvtQ/klgbXjlkPZXbMKIMwRGaTc8bYAEBtVsNI35I+nWe?=
 =?us-ascii?Q?dU5DQ0KSLreGHeeNq+dtDEgo0Zeat/REx4wQ0t0H5YlURHheMa+6D5U8/isH?=
 =?us-ascii?Q?Z7g5a+VrIzmGM2TeVnqgUhaVwQEOIRVN15s+ooIGyquGDKhhC0cGCPJvUkPD?=
 =?us-ascii?Q?OTYJjj9sbCTJdGLzlcvsMKMXKl88b97BL1ON6/jg99q1VWlKhdnjCIltdw/9?=
 =?us-ascii?Q?Y7IH2N83kKtkHlV1bvcFMM31rq+GF41j0kEuFlI0ev2GQ1dGr9RR5Ca0O5ZH?=
 =?us-ascii?Q?kGehUckO+9hrOid9dkjANBDM4myXQfEWcyX9E34zIeZgSYep7pUYvQ1t2ULS?=
 =?us-ascii?Q?5NV1kO89B6ccnwFpUygWkOtggQzH5mi48s8/TuUUFI4XpZxE21EHU6Rn9TWz?=
 =?us-ascii?Q?vunHysJAKRtiiv7lMtrDv4Kd9I9TQ//s3qJFsoel+JhCjlxA2Rrbf2EHH8EX?=
 =?us-ascii?Q?U02Z2BQ+pw2TZCJr/zcu2nGSW3VLrBVI49jkBbZ8uc61Xc0T3YtHfG0uquw1?=
 =?us-ascii?Q?/ijbXoN3/9VbD4xH1NLGDRoXfpeSdp0vxU8BQMyCDFMRzuxH0dalx6LwShlo?=
 =?us-ascii?Q?bvTUx63ZizqhoKWmXC7EtO8XWMpjEnoucdqAd38z4bwjEPoaW6+lHLx7EOwz?=
 =?us-ascii?Q?ev76gT5Shzoyu54JCTA/XatSYc/bC3oCJgSmHMTcy44e0Z3yReqG/zkXvklZ?=
 =?us-ascii?Q?jkafwr9/RsXNKve/YvTLjBUe593+Mpv+VT6HvS+FAHm00eM28jxRTxW+W5Ea?=
 =?us-ascii?Q?xdfBJH27kwMYEoquQzuExOv13O1fLApMwNKvtXyj7o80D3fDWm95HDS2a3l9?=
 =?us-ascii?Q?lncM/D4L5GKp93/gMLT06D0gSgARMu9JEtrah38twHo/A5CnZuK+owPSDuhj?=
 =?us-ascii?Q?PCdlrlUQyOY7+MLJL4lkUGw4uzH53n8v8ik2tzNtkC9Tiv9RQsI+ushrWcNl?=
 =?us-ascii?Q?173GBMfsi8WbgRNWDSd/AJ1E8tWsWdXqVkgG4uK8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2cadf6-a6e8-4efd-20d7-08db3a9965c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 14:31:11.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO4SRLj3JI2Ef1Md7WHdfkBUPBiCVkPMnBJ46wTqzFE2+0rSZ8dCHwxOT8XdEelQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 07:21:42AM +0000, Tian, Kevin wrote:

> If no oversight then we can directly put the lock in
> iommufd_hw_pagetable_attach/detach() which can also simplify a bit on 
> its callers in device.c.

So, I did this, and syzkaller explains why this can't be done:

https://lore.kernel.org/r/0000000000006e66d605f83e09bc@google.com

We can't allow the hwpt to be discovered by a parallel
iommufd_hw_pagetable_attach() until it is done being setup, otherwise
if we fail to set it up we can't destroy the hwpt.
 
	if (immediate_attach) {
		rc = iommufd_hw_pagetable_attach(hwpt, idev);
		if (rc)
			goto out_abort;
	}

	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
	if (rc)
		goto out_detach;
	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
	return hwpt;

out_detach:
	if (immediate_attach)
		iommufd_hw_pagetable_detach(idev);
out_abort:
	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);

As some other idev could be pointing at it too now.

So the lock has to come back out..

Jason
