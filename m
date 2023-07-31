Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B7769749
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGaNQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGaNQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 09:16:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4EA10FB;
        Mon, 31 Jul 2023 06:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyo4Lmfcb18WV5Zpblfp1DMsh/vkeuZuyRK1+una6dAByVCz2b6lzgfedcnTRO7CEp94kRrEAafHeeqCwBNGTomi4Wws5ugKHED1ZL5KjmmrGmFuH3lVap5EOdcSA7XgLc1v2WxKHifbpdrrsrGiSRtU35xk0VesU9lUt9ykIC6zW/bYJk9UgO5P76edDttrSl7aG40VR4LEn/48wpP29XOJwk2KRMTq6EfgzNcTxkpe1eEyes8A7hk7yQyp/mhFFZR/rjnbNBtcsj7r/8amnMlK2AKrTnc09khT5f41+42EMiMRHir0abcGPzKH+eaTwADsJAR4uPbeIW7AT7N8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLaRy42dmL6H9/dHEnI/F103eBT1bdIggL/OVpadBlY=;
 b=ataja32V0vvxugPQL/eSaPECfO5DdlUa5i03kiOjuklGn8/2W9beOCW0yMULDkrSgNY7Hunhtup1tZlxpCjWyMLmv9H1TOSbqr9fy+THw/0uL7zRn9AHg5YyqADyje9KJvzYl8dSpbGBpiE1OKf3VGV3+Jl8M5C71T/YG3DuvdX/fzsBXnc7ipCAlJiXH7cnRZRWt4clKAB2OqvavDhnhYk35Sah0VHNrWToxCoKl8gqTivGod+00+k28lS6EBEYPkd1PtDS9ZAUCFeBDesG2okdfTyJzO95w2xtd6V+VWJYOYlMSKKbDkno/ETi+Ocg20x8NdXrDUa8E9lJLYL4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLaRy42dmL6H9/dHEnI/F103eBT1bdIggL/OVpadBlY=;
 b=UCHN4lKEth5GMYIFFZHTOrEqOT9iSsek60v6P55FUnU58JnkK7omJ4AnWYmZuKoRyQeTiXfiKqBqtiMHrSkAjL8fEGceepn2sdH+OLVha6SqQltsXFJKgcxZxnlyukpoGT3bf9ubhMbt9xmGpjLUw9f+7fufac8KZEeYO2aMgdHH2VfSMl5AMAki9IoCr9+de5myWObLN0UkOrHMd8U/eUqSB68XUKkHzYD/eKTiwjqxhxD5HRR/NTBfO1GD/G+z3ye/nY2dZbuSVMiNbS27CxSMXBu0kHteY5wZIE5ixItJMTLVs0d7hIy0eQ88ddhpznkJfDGGJSPPqpQowbCd4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 13:16:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:16:20 +0000
Date:   Mon, 31 Jul 2023 10:16:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZMe0IQksFgV6yKTB@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com>
 <ZMQBLTm+U+5bgC/Z@nvidia.com>
 <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: b51dce3a-208d-4340-6e84-08db91c8547a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L67iAYgF/P4eNxg09ABN2gghjCQnbj3b13qxct5pXMDySG/3oN92Cls32Zq9kTHPNSpwo2qaKMKrLF0vUkheewnxeAgXCA8PnHRGyM7GW5/hgfeP2Ki0e1yIcUCdIHJfNHVFjVPc+QyvnzINoU0hJ51rdpMt9Wguzwi690tOjgdv/X2pdjmTU1Sa2PNzkTM10TgEErRpgmXrfDjgog7Dzq3SXTymnWnzebnybKHQi4SSgyzJTpYj9TK8P4GO5dTnW2p8caa2EJLaoNSW5UgR6tQ5TXYJUDvA6ugn6lpgFpFjfEZT/B+uhiMarA9yhx3vhzFNIhGAmESZFKbYFTC7jP7La4q9cimaHF9eeREjWmyPa356pmwFuPqOZfi3mko/KTXkyeUqmBs0WCdfU2jhlF6GEHNSi+b+FmPRpDXjkH69rSI/EAtShT+Xdw0hpXKEBBYkQ3o0s9JN+pRJNrWZf71P84ssJqAZ0wOR9QjcAfZTmWESex3tWsU0RsEZRJ93EnWfZ+//Y8NTixJT5MgnO2Wl0uH0zprn8AJjLdTJqbQodNGLrFRI+sswda04LTBX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(7416002)(41300700001)(54906003)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(38100700002)(2906002)(6666004)(66899021)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DEx/ZOCBe7bGrnBlUq8NE67si9c3f+aa2EOF/+SjxlQ5H2BJ50a4WHWlNTp7?=
 =?us-ascii?Q?LGLWeDtrZWthCa7NcpHMO94zRCZ4EAC4fFb/kvULs6rYqrmQdQJQP6Hzg5XH?=
 =?us-ascii?Q?nh6RuiT2vjRGtWwi7dSgRC8CyQ7a/GqssQ9AVZ241uOXbgMqbjGizW76mAjz?=
 =?us-ascii?Q?6KxIh/dvBhzkyeROT1obeXD5M0E6p7lkBdkH7PHrdQDlWL0dkEw9KqyS6Oqo?=
 =?us-ascii?Q?Y5ffHSSLhYKwu+YWw78nME6X+Td9QVM8IUlZwdyIlpbBjiiBBe76ckiq75G3?=
 =?us-ascii?Q?097CqX4MbEnYsjX7mV18qyCAsAUfD2mkvk6MNKdroSd0757aupIAP5hXXGSJ?=
 =?us-ascii?Q?WgrQmupMGdveGSxu4KyvPDY/EjRY2v/RPgLyjUop9oI20v22cBwyjMzrwZJd?=
 =?us-ascii?Q?VkdB1qPjdwW6F1/5GJ5mKzl+RTG8/M5N12vtPgvoTVU8A3lIuIixiDNHc5b7?=
 =?us-ascii?Q?6B9P/0sK+RuKmSI/+MxhW5Ax5c/X97jz1j5JhKg5fGo/JPMG8R7/2o4EB6x5?=
 =?us-ascii?Q?FWsLwslfgGrQRv47m4OQ1NtB/dnwqVYYYZmIWj8wufsqHp4sfh1Q7E5peLWE?=
 =?us-ascii?Q?D5mWsA81KEV5YaDpU3nNsc6uEU5n14h4jbV9h3CI5hXv37KHyhQU1/K9Bwta?=
 =?us-ascii?Q?23orQwtD+3Xs+Bu5DzB5SMfuluYT3BBlttS5AkIboKNni+GcD+ig8Oxgf+iV?=
 =?us-ascii?Q?OYH5mKr3RwtUNMC9cL6nFJ8prwrxjgVmrsQt8abfcHz+nxMyiqzgOnj0KPsU?=
 =?us-ascii?Q?4t73FktZe7UG6hZnE657k955WxZHbMb3A8GN5vsfXZrVQiaAD3BRQHl2MWvD?=
 =?us-ascii?Q?V8gzTjpazVz+eN5SZTd6GTZXrfDbVo3RWB/WJOP1oQ1VhevTxyBKupL3hplE?=
 =?us-ascii?Q?Bi6l7nT7TYm7hmcWnNjtYuLLPpheW7NO80Lt2aeEfPtCYrpEHyeztGHG4S9d?=
 =?us-ascii?Q?bE+DBBgwnXWlWZT7K8ZxmESZBBk23uKipndVyDjgkNcFr6mfA2anVKSYAzvR?=
 =?us-ascii?Q?w8OufCx7WcgqVTgTqwsMJdMsTSF6/PITvqchZ8hwBP+CpEz112oWCcbLRzco?=
 =?us-ascii?Q?siFStmWAd0eAdKxbEXoJuhbcSQ19tSZ+4cuo/9QQWvJdcTOXypUsBkaveqgi?=
 =?us-ascii?Q?thsvC6YOUJn28LQ6ki8Ou/0vmH94EPrvy5xsVxvYz2XSAZ25DxIChsT8mlc8?=
 =?us-ascii?Q?00UwF241tOuGDz4WswX7wu4RmXYI+iRfWK6e8XVwi/JAxXYQJx55l1mtB7/t?=
 =?us-ascii?Q?UfgAos4O3+5gwz0ThC+zaCUCfh2TUIkE7y69/RPCEV5qCDwzLpiBTzWHQkg3?=
 =?us-ascii?Q?DKgXk37my2Iswl+BjeyA9QPXfwJqTiZkg4sWZewYYZXhs+ebItlmikMgf3ME?=
 =?us-ascii?Q?L3PNQcQ61oktC0Ftbrjm9HeabSeaHENDmtLkpKpKwTAOfaHmKh8hPPQiAEZr?=
 =?us-ascii?Q?v3hq9G/PbZD4nkdjuszt31BezSO43G9Go21qpZjOM3TJfPrLM8wSR1rQS1Ki?=
 =?us-ascii?Q?1dNeE4srbYd2YZDLZTVsMcpCapq72YD8oNCXoa6Yrh5EpZArmLUu+9Cbsoai?=
 =?us-ascii?Q?Kzs2dqHSGPME8mlkf6wlEQJO1OvKbHlCEDExs0Lo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51dce3a-208d-4340-6e84-08db91c8547a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:16:20.2044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bOGqVigkotVC/XEzA9nRkA1MWzOTri9exO+p6js8v4qY5WmNjkv8v07PV5GXUAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 06:31:20AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, July 29, 2023 1:56 AM
> > 
> > On Mon, Jul 24, 2023 at 04:03:57AM -0700, Yi Liu wrote:
> > 
> > > +	switch (pt_obj->type) {
> > > +	case IOMMUFD_OBJ_IOAS:
> > > +		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> > > +		break;
> > > +	case IOMMUFD_OBJ_HW_PAGETABLE:
> > > +		/* pt_id points HWPT only when hwpt_type
> > is !IOMMU_HWPT_TYPE_DEFAULT */
> > > +		if (cmd->hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) {
> > > +			rc = -EINVAL;
> > > +			goto out_put_pt;
> > > +		}
> > > +
> > > +		parent = container_of(pt_obj, struct iommufd_hw_pagetable,
> > obj);
> > > +		/*
> > > +		 * Cannot allocate user-managed hwpt linking to
> > auto_created
> > > +		 * hwpt. If the parent hwpt is already a user-managed hwpt,
> > > +		 * don't allocate another user-managed hwpt linking to it.
> > > +		 */
> > > +		if (parent->auto_domain || parent->parent) {
> > > +			rc = -EINVAL;
> > > +			goto out_put_pt;
> > > +		}
> > > +		ioas = parent->ioas;
> > 
> > Why do we set ioas here? I would think it should be NULL.
> > 
> > I think it is looking like a mistake to try and re-use
> > iommufd_hw_pagetable_alloc() directly for the nested case. It should
> > not have a IOAS argument, it should not do enforce_cc, or iopt_*
> > functions
> 
> enforce_cc is still required since it's about memory accesses post
> page table walking (no matter the walked table is single stage or
> nested).

enforce_cc only has meaning if the kernel owns the IOPTEs, and if we
are creating a nest it does not. The guest has to set any necessary
IOPTE bits.

enforce_cc will be done on the parent of the nest as normal.

> Ideally expanding uAPI structure size should come with new flag bits.

Flags or some kind of 'zero is the same behavior as a smaller struct'
scheme.

This patch is doing the zero option:

 	__u32 __reserved;
+	__u32 hwpt_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
 };

hwpt_type == 0 means default type
data_len == 0 means no data
data_uptr is ignored (zero is safe)

So there is no need to change it

Jason
