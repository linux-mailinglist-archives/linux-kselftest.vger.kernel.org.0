Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5804668BE18
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 14:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBFN0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 08:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBFN0S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 08:26:18 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CA083DE;
        Mon,  6 Feb 2023 05:26:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbKBTzugjyZoQSoG9efWBXZEDD6Rgg1VPjcLlwbHlpleFztGf0lodpYyh5sTf97cjuPAm1HAEdPbhCwgzKdJSP34wUHPPLhE13UAtH0E6FHlG1Bj6QwwjdnG9moPodSP+mIVqr8Q8MGp8sTyjPuiC1If1KEiAV5/p7mO99oLNLxL/haHXPCV8JU9CUMqox725yzLc1RppBSg+W6J1V9xK5TyPtTInf4YD9Bz2z6P8MjCAP3lzZRCRUs+x7QTSrPck4MKiky4sp6NOtLqOp40QzBrKtUnwxM0NJsu2/jsRqJqy2cGsL0QSegL8q6JXIAPJQiKTQ1VxOH2xlFH7ovPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDinuEiRM1vk46E63gbQSxKb0o8g/pt3ZJzpUpmruhY=;
 b=T137kyYepJf1ST8rUmhKF5rYTtVAX7e99tY8lPt19wMRRrENFHX53kTDsmpcvXE9STdj+9Y46E5ka7X91dvt9LRt5jm7YemKyyG8F5tPywxIY6iDq+ePtjaWLrwLzNsInhzPP56tvY+j+YWHyVBXfuPYPps6yFNymhGFjBCVChVdR86cM5LBpzzpsGR+FJg8kK+ejY4MZfugMMTyGt6QfOJQnNIy+N6xIfbz66At5t8KrhPRvILch3DmoM7GLG8VKzhtOHMGY6MjKi27W3KdYeej3XLVjKHz+NvWGgj7wcFaogGD2JGMinQfC02gdrRHQvFJ9YkH1miweHdEQZjjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDinuEiRM1vk46E63gbQSxKb0o8g/pt3ZJzpUpmruhY=;
 b=pVHZTlHvcN8K0Uf0olBKyueE4Jy7/Fd7Y8bahFYOzpvkZLzQ6C/cdr8iaEvyYWqpAc7/Kv8JBzN5ceM4kJSk8xsf2LaZZ66ZGTAq7LhFavOkkk2n10Xv7EJRqpaFDUCO68UvLOqVOKB6TiRXAjbgqQyiVJbDZPzBIMtQCPDD3uXWs9HYWCFE2Q11hMYzgcPX9SgNwgMK5dVXP8oYfWWrvcj4/KgxcsW1CCu7wLA9vpwTeT/LCC/LQIhyW4Mm1PhIlPjZUaRIHACAF63T4lUkE9BTQP6KsHPyWPAazf/BewVGbJz/cUvleYT/YiQEhsFuLEXd84hQHK1mMlM1aqsn7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 13:26:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 13:26:15 +0000
Date:   Mon, 6 Feb 2023 09:26:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 0/8] Add IO page table replacement support
Message-ID: <Y+D/9j8Yc444k8QE@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB527680F63EC5443DD7A5E98A8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90ieTgl7I2GZfsX@ziepe.ca>
 <BN9PR11MB5276A84ABA311151949215518CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A84ABA311151949215518CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0423.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: e0feaf00-f039-48d4-c171-08db0845b8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyX47l+gzZ1kln6CO1WawSrU4T6Yk5h16FpLmz5JOfAWLhnrtXYUiBW8WT9Pi3RTrwdKK4KDsqi2Y3+Q6u1NBfmdXU5d6tx/pg0B661GIaeYAO8CZnlYet4csWrYVSJx5Ys0Z8qQ69a3BPgXQ4AEjSMlQQ0SgznD29SC6Dc4Tr4ZGmatySfJ0tFKS3VCX6hecsTxM5P+iAU6C5ZGvVdJbTajN0msWL23hAADXakiZY31NHwSX3f3TsCEqN1990X8As9tWgJQkvxuH3hvp8IXXvc0k5h9prWG290qi6XuPWaxwdlKvU3Lu8gudkYGizepnFTcbyoVvPyMv0X/N15JIBhHauOqJAEgttzBq+78eEm14cBPq8fH3kiHmsdHxVcoQfMeA+YoikRzzpOYTu228qWTzSCKtPJ0Cf0srpOdH+uBoI6jJj9m80Z3Su8tWnWtMQ2fo5zRN3/PxF0zqVMJcwWpll7TaPg4JzaF8S/v92l2GlJqPl5Y6uB39bzjAORiJulCXUktt8SpRreok6A5F18LIOcs3jfJ2ttQv+qSI3mo2amVSSgaf88qC8oE0MKpX3OkgwB/LxsXi25EoD11wPC+JUD/ZbwlVpsq91wqSgUB8FNgXDP1bf4QrL2TcClbzPTBwDH3ZS8tW1L8MUrzkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(36756003)(41300700001)(86362001)(6512007)(38100700002)(26005)(2616005)(186003)(8676002)(6506007)(4744005)(478600001)(54906003)(7416002)(6486002)(66946007)(316002)(8936002)(6916009)(4326008)(5660300002)(66476007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMD8tzMgooQGbUFV1y7Az+aU90HbVozMFA/UKXooj9L3J+yAmwkvzHkyI7ST?=
 =?us-ascii?Q?OQ3O/6Pd0zfgRRQwTRBSAgKICaU7+sSv3loshqD7/bBYal1UE/406J0oS5+w?=
 =?us-ascii?Q?e4gYJw7oLSex301Ct3WUH+azdNGYdz11OJkZz1rPcRyJH7KA2l35TRseGAhU?=
 =?us-ascii?Q?ZmMRGVc/LOOjnvd/V8+IHIjMrq0GW5btsP/6wHFzjJc9+Z7CUXY+nfHT5Wxw?=
 =?us-ascii?Q?KxwOo4IjMQOcDloW3C2nEwSPpdTEuHa0Gy0zbvAflNPoZ+gGowiABzEElJuB?=
 =?us-ascii?Q?5Gkv3SXR3hoPoXEzRzZSsNVY++f2HUVJw2/ji7Wu8Ir8pNKqpLNa/F8YAuMs?=
 =?us-ascii?Q?ykkMqQHRW3zRAcX7N8pvSFPwH6fgzcghwclDAbcEVDl4+Tl3pPnPDTYICSDs?=
 =?us-ascii?Q?EeDRqfJcYfVDEfRoayopzRM50qTlpgGBnbPZc6SVspFDQGTZMRGTSpdt/DUN?=
 =?us-ascii?Q?C975/7v1/rGEqktd7/BDXWH0VOFWa8h7HJSpcjhEn/jL8fz5rpbPg/vgpZQh?=
 =?us-ascii?Q?j0JSFIrUz1trtlgtOGzaOrv7eCeDmiS9TUVMCT1SAZhnrcKheDXKL+pZkdO/?=
 =?us-ascii?Q?C5AihT/VSrf3GNMvDPrlkEk4OsTe4fLqJKbJNNxwRNiFFKMT65Ub4I4xLs6J?=
 =?us-ascii?Q?2cgVhX6jz1Fr2RStw8CwmocqYVJQGbpA6OeaWVp1mWIC+XD8E+3v5yZtwRIT?=
 =?us-ascii?Q?Ui0OXPPwzgB1WHFa5fE3N4ux9mLd6StF91qa+tG1BUf2f8d6fjpDtQADvk60?=
 =?us-ascii?Q?hogLXCIBHn/9zCUZBFq0RpoqZ4o871z5dqbq8ivfETfIQlfllSfbkQa+gUoN?=
 =?us-ascii?Q?+OcgYY3Ez1qBVZ6aF/fC0OVDI+73Wx0AjdyLDoBIrxmwO7reSDenyLNL3wPx?=
 =?us-ascii?Q?YW8J+G4DVZ7qr/Ef0l+IPhfLHG5WPcQF64WlY0vN2dqhWPUE7KClJMiFnO5r?=
 =?us-ascii?Q?MNKvGaJtVT2/aolzTQT9Xvba4CISMSsOCIcftiN45Eeh5gHSFW6SOIRBbGp3?=
 =?us-ascii?Q?exjdskpT0ZX+NXxVuURNoLkt4hsws9BMUrDmcXZq5JE9SRp5jprYqa0uCh1W?=
 =?us-ascii?Q?ZcSx6Qx/qKeVxibzTx0PE0pbntmU10zo4PEig/aemH5afKHVgIWJgQh71bgy?=
 =?us-ascii?Q?JBEHgbFoCqMK1YlbI8vkhrG5ho/i+rnEr3ZXZKzUYEYFzqDiOx4b+ia+q0mX?=
 =?us-ascii?Q?3izA+GRT3PXRsFlJtV+su9Ssbr6lL0OuU2OUwIPMDcXcEKZW6EMIcP2YWAH+?=
 =?us-ascii?Q?jaQmIxJio1WQnOknjJm9eMuTXg6NpItzTcg2T+n3sq5KIBajycFcfWygNQro?=
 =?us-ascii?Q?EzJxzqX0p2J8XsFWVFYQyEuQukIqxEGcog1NqeCiHzCYExYkj7hsJ4DVuBrF?=
 =?us-ascii?Q?3MhUTwV+rdXHERl3GC3+w8Nf6ertT07TKojsxDavJW56WVxqAGaGVSkKDEa7?=
 =?us-ascii?Q?qgLd2pDVDq1BSL5cQMCnfRqNnWA7O9wp8paH/XFEUZD4/+TO0jooHrwZHYxJ?=
 =?us-ascii?Q?XSdpcfCHMla4Km//QCBJ7nd+3+ieS2/iIcP89k8WZswgMKj8pCo4jEvBZS/M?=
 =?us-ascii?Q?IcYZngQs6EDtrmqfc6DdNkcFA6s8KPCRyl6ID6DI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0feaf00-f039-48d4-c171-08db0845b8d6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:26:15.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8nIaN4xiaa0Wg1nR35ENVy2UbM4iI5lts6gcR7ryevFC0RlZbQ77CWQ8VzXk/81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 06:39:29AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, February 3, 2023 11:04 PM
> > 
> > On Fri, Feb 03, 2023 at 08:09:30AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Thursday, February 2, 2023 3:05 PM
> > > >
> > > > QEMU with this feature should have the vIOMMU maintain a cache of the
> > > > guest io page table addresses and assign a unique IOAS to each unique
> > > > guest page table.
> > >
> > > I didn't get why we impose such requirement to userspace.
> > 
> > I read this as implementation guidance for qemu. qemu can do what it
> > wants of course
> > 
> 
> sure but I still didn't get why this is a guidance specific to the
> new replace cmd...

I think the guidance is about the change to VFIO uAPI where it is now
possible to change the domain attached, previously that was not
possible

Jason
