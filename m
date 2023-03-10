Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725136B49B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 16:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjCJPPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjCJPOg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 10:14:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31B13B285;
        Fri, 10 Mar 2023 07:05:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VezJF2zcRfmi/vQ5+/FkeIJDqQ+0IefxTZOxQ9bFEyCm0z7l/LqlJsP4lFWiIwzEGROb893f7Q9hcKtuTv+J1TqLbjJUJhrdf4/dVrhRFQxIopuoOKKET64M8GVmQUApICCCfX/7VAsrMKHAbaeT+XYT/5zbZ1iULzwo+4LUGw0PCr9zXSPwf9gEsHH5QHL9baaP9pKBXRuqpdFU0ZqdiktA9LqBub3Y1BjZGV2ETWeJh3nhMqXm8vDydacQv0OjGvqEEvUMvAdITee4Uc+sAMJoYfQYJOPXcEEQ1xJ1tH395ViLJyGF8/rfq8N3thDTkE5O6pp3hRxfgJovwx9ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6jsctypz+vLVbS/gE3VOy9c60a+lBiWZ/27u4Ot/E4=;
 b=l7lUSW82hZmyMbBh2o03JDUqzOIzZarbVwsB6gBVm1GnliPpKOccgbSp5IUSmEuttS42j5PG7IZxlBip2Ga0PfUGPBgeYAsJw5Ooz1J8IRVG8rwYvMykTNPG53RVNEehNFdZND93rS5AWLBmbflHLnTakLfCBSYFh7Q1JWuJZ4lSreGfVAWvqWG1cJsj2c5IHu1D4RfpnZCwzK7V53Cs9X9bZe7KVGheKSB9rrxmv+Ra6SPT88hyAJZ7+IsnD1yR6dQjdjvXC40ADaVI5Vz38QtUGzvW3KBQj5qdKMdPFTZmqGu8igcVg1cB0+Ul3XW3MvwGYdRFuOp653bSK6pgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6jsctypz+vLVbS/gE3VOy9c60a+lBiWZ/27u4Ot/E4=;
 b=G7ifkf3x6dqNb8KD0p5WdvDapL2w9oT51AxwShTBOxgd8ajzgfLgR+hPhWdSKMku1mIVckcT7rSRFYyjpg7osoeKFuMGfjK+rgRVlIS7U7n/MbFAvQ5jddtRm14ky94cOCdHvs2aZ/evSerU+kY+iMNbpFPhVg3Qohwmain8gcqAe2bFl3EFbawtH6QXZFyQs+WXbcOAkeE9/tm0v3k5b1E9B5LdMHO5iI+ZaWnK77kZF8+amEvxA43MATQWIxFYEGJuPrhe1EOe9tdxZQ3vh0VgwqK4gY+FvHZ6dYGJ+fafO7dPXmRKatZCpPsvLKlANt4/KBU4amBqjleF6LkH/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 15:04:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 15:04:24 +0000
Date:   Fri, 10 Mar 2023 11:04:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 12/17] iommufd: Add iommufd_device_replace()
Message-ID: <ZAtG9UCn1V90u99K@nvidia.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <12-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276166EE02EE60085F103598CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276166EE02EE60085F103598CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0b907a-fb3f-4cdc-2ade-08db2178bc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vAYxRriaRAR7RBu5SsdQ2R5rZZ+vDlq6vplSNRInZQPDGYxpsKyCK+8cSXeRpoMKwXY37YCkFlTXLlGj021iItMP1D4/tjjgKjrFwRAlNvtOUs3JI0t6oh+m7ETFLqUjZUd8kKN16uJh4sRhF8Z49rhg5m+5J1VmKSf/be/dz7fkT2E0CEWgATUsbbFsywvM9jVRn9fkdtSkv3kL8yzMplTaIam1RBjqgPYmA+fP4DNOd29NgJYdB/XPONGcf0LUifVZPMQDSF/07ZfJsKuEWZvhQMg4q2gvXnC+cC24qudNOjN2ty5qgU+EgYTXbAMkOwZQWw0BBuwF5Qies/BFa15RE1cFGfizztlPVNRwjYPHZYxiAp8iFK/8kL4JLXnfOcSH+2D3wPXEmMf14cR3I1hBjIlL4N1mH81U6zZisGnFOg4pYLN48w1E1iREwMcC7j9dKmRdyHDUyCSJZqpYpRHwkFEwc9MWHlWNQOjXVjkl70HAUYtdmcBUegi2joKiTbxCWrRJkNf0PbFSoh3ggvI2BXh9ZN177+XnrDFAcDoqdBiVHEAWDAtLO6nKhxiNGgSUAqFC0uopZVUo9vWwgUcp0T0hKu0Yr4/F5oUCxmK3obMo1E2EGzJRNvNm8yOjWSBFMFq7Su0imnDFmGs2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199018)(36756003)(478600001)(316002)(54906003)(6486002)(5660300002)(2906002)(4326008)(8676002)(66946007)(66476007)(6916009)(66556008)(8936002)(41300700001)(6506007)(26005)(86362001)(38100700002)(6512007)(186003)(2616005)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9DD84oTriOQ4JU8a7IlpWWvE6hRCt1haTnZgg3tjH3aXu21LTEHiXK4Nu2FD?=
 =?us-ascii?Q?TNjS0FSQ8d5XA+1VGzFbWefwaLImHXnEKo1xgfOjVbi/csdVPJmAGFvyMme1?=
 =?us-ascii?Q?MwldVTkb9cUOIJ0XVcxap1NBy9VT0YFiq8xsVfnz3sTXF3OkxjOsUYjGz/OU?=
 =?us-ascii?Q?NAkE2ZWJwfJDdjsYz/wwjS5kukNV9GhyKGqBUk+3hiNuYqvZB2Qlh1bOJxmo?=
 =?us-ascii?Q?SlgFdKFeSVQizYtezj7S7fsp3zGCxvUITfEl9mqF8u0j2eKDrQaZlHcO/D7d?=
 =?us-ascii?Q?bAUI2suhmXUFVcqlqO/F6BiC0oD+UXHmrsL9XCKZ8TKCqPeJl7+JVnIlYzxD?=
 =?us-ascii?Q?AaHong4grHC6P92cEErjI7WBG15zEmmQ6PyGa4aCuRgnjOd+Dn5TQ5da669z?=
 =?us-ascii?Q?VU6HT5prWatxTNuR0Gk4epYqEhM2QenEt0BRnMJbyk6qw5Tw7cFNp/uGXSvG?=
 =?us-ascii?Q?+jMrEsS4IhrXtNbBWzKYJeuta24fnAOKJCsEAEhEawI3XM+s4umYZ6eEAn09?=
 =?us-ascii?Q?Xq6pcNlgfNi8kdK41HujfcSENg4dTNFWZtlZbFp/qmoYCgOdHk44uSRQT8E6?=
 =?us-ascii?Q?ZxnlaaIeGs07pkaE2sByVVfMd020CUKF3T/mXPPUSToL8K8EGc2QDIFk31vg?=
 =?us-ascii?Q?fr4oicps8GSF/6JgSgsS862BT1Aw0YE0HcTHSk9ToaIoITdHp1SxILgTrNKx?=
 =?us-ascii?Q?QhliSaU5IPfacnBKafdbNaAj6qLC1zLqjuub5k+SY/inj7ZYlUWlSYjJr+yg?=
 =?us-ascii?Q?wm3vqvWGISD/7rwwg319i9iIQGbIxNKN88b5ScaXGjidX9G1HWCuzlg7qHz6?=
 =?us-ascii?Q?6uBXIJD1VJ3om/AzHPPl65hT3Z4lY0iJv0zfaO5p/3AYytDKXiPopZ3saKvG?=
 =?us-ascii?Q?cBEwxnTr2J0ckIcsRdxlpEyH7LDm+HlHrM1+IBZWv2T7Br5u6RRcsLHXcdLl?=
 =?us-ascii?Q?BwLGh0ryj+V0k/sLi8RpoCyVcyflVEizcZiMvXJyMjlGQd/EvU3EJju3FOE5?=
 =?us-ascii?Q?DzPOWemJn/RhpXEdA109zRCIU7Ugk5yA42/+1/aK3WhCtL7tFx4wKwjqdH4c?=
 =?us-ascii?Q?uh/l8SxF2xN+MK0LPURwnfD+8FJwwraj7vbBb/0MT5REKfhML43yh9sgAJg0?=
 =?us-ascii?Q?+LuRsoI8y+VticGy0FMRooPrXXhObtFqJJkoBU0Pf7kHO2Q3sjVOlmOo5CFe?=
 =?us-ascii?Q?u+fzgT75uN/GLYt3s6d0I87yuRJxSrZqrT06Qak8q6zq8vSpZ/UlA8pyWFsZ?=
 =?us-ascii?Q?XvRSjdZ4WwAMEN2TjrPSHeNqZFbvn9E18OY8+PHyZ3Sj+Oj6+SGpBDLsqDB1?=
 =?us-ascii?Q?x2Jd3ssv8yXL2NaN0jSwxTVNIuvUjlhaWwK6zAVqiFao7+lukQMqXKjKbbvW?=
 =?us-ascii?Q?GmtRP8bgEDmOsU+t4dmCdMfSLLU19i1kQezTtcjD96XbAyrtwbwleLjBN/qk?=
 =?us-ascii?Q?iq0mzm2GOJaJRVHd9JxzGA/in1N7Xtt7o77alQzMs2Hhg/9qJ08UUfBqgSeu?=
 =?us-ascii?Q?vSRfylijgi6QzxBTLv1va9rjlQRalTUYEXJxTeV9hBtuoZKl0rZFLz06pczD?=
 =?us-ascii?Q?dIMpp/zmbBMf+Q6M/S/Eh3aBeL91kgv1NiWhXauY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0b907a-fb3f-4cdc-2ade-08db2178bc40
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:04:24.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: au8na3/Nbm1umbefEY1wNNrgXOOf8Ky8OcGtabaJ0rwiXQT/hYnmNMElfMvW5gRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 11:48:58AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 8, 2023 8:36 AM
> > 
> > @@ -359,6 +360,76 @@ iommufd_device_do_attach(struct iommufd_device
> > *idev,
> >  	return NULL;
> >  }
> > 
> > +static struct iommufd_hw_pagetable *
> > +iommufd_device_do_replace(struct iommufd_device *idev,
> > +			  struct iommufd_hw_pagetable *hwpt)
> > +{
> > +	struct iommufd_group *igroup = idev->igroup;
> > +	struct iommufd_hw_pagetable *old_hwpt;
> > +	unsigned int num_devices = 0;
> > +	struct iommufd_device *cur;
> > +	int rc;
> > +
> > +	mutex_lock(&idev->igroup->lock);
> > +
> > +	if (hwpt == igroup->hwpt) {
> > +		mutex_unlock(&idev->igroup->lock);
> > +		return NULL;
> > +	}
> > +
> > +	/* Try to upgrade the domain we have */
> > +	list_for_each_entry(cur, &igroup->device_list, group_item) {
> > +		num_devices++;
> > +		if (cur->enforce_cache_coherency) {
> > +			rc = iommufd_hw_pagetable_enforce_cc(hwpt);
> > +			if (rc)
> > +				goto err_unlock;
> > +		}
> > +	}
> > +
> > +	old_hwpt = igroup->hwpt;
> > +	if (hwpt->ioas != old_hwpt->ioas) {
> 
> Do we allow this function to be used as attach/detach?

No. NULL is never a valid input..

> if yes old_hwpt could be NULL here.

Er that test got lost in the last version it is neeed

> and looks the policy for physical attach is different from the one that
> Nicoline applies for access. iommufd_access_set_ioas() can behave
> like normal attach/detach.

Access should change.

Thanks,
Jason
