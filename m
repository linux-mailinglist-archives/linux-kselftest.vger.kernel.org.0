Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39EE6C1252
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjCTMuk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 08:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjCTMuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 08:50:10 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E598298F4;
        Mon, 20 Mar 2023 05:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asQqjp5E6E94LcpU9h3niqeQ8ijnNjg5/yVoHkvNIAQ5s0bhvRpwF1JpPESewUDUB/+hw4UUFXjnnXB+rW8MiR/jzrUjHItwJuFY0J+5dJ/XJpGQN8u0fRNX/8zhBfL6Gpg8G9FkUeuh/CLshWsRrFa5FCF7fTgOBUVdr1vDyuYcpg6AD4wU3QiI2PYVw+brfbJzS0T/hkarYRdiRctWaui+ysEzsB8k9MPnB5WGJXzZOuv2pDvKDjFpPepB84Vhh3gWtWIDBVABckFkdQxopGPu0tezglt2o+7ECc8r4yU1rvVVm5WiuGd4m7Pr7B89cg1/+WobViL+51t9E4q/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP8HXYtmC9Siv2xCwSC7R+xq9CEY2aShye0VNV/qt6U=;
 b=f9RwRkMVDxY8tW7kKvcLXwCgtWTSINJMT0IgCytV9ntWXalrZoMiX2gLO84buE6/P1bYKjlKsWuodf3RPr5zP4hxgeyus0H5Czwj/Vplww+xFwo36Ra9T8uRtl3UKSXEZ6xA4O9/us9moG/VkV8SAWmqpPhN5MT0WFlnUcuJPZV3OwSJUcRN4c0GQMKjEih7l11iNvJquTlmpIT1Sxe1OouDIqrVhLQaq0EnJewah8hFGckvbUiI63ucN1V+7G6TAyU5RcJKp2V83/6VfyBhwj5F0H4Y8RZHFMAuRXahABkHzwQcWflTazlQzHSehFe+rJeLji3jh3HsOMGfT0Sz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP8HXYtmC9Siv2xCwSC7R+xq9CEY2aShye0VNV/qt6U=;
 b=cym8dSfJ1VF2f/1rQUZdrlENXVpYOreoAn5XrQ3n84596Ht2BzljwFtZ9kgqdFM5djbqo+S/mtSgk6iU7Tr+zGy5zuLVJV/sbZZcoUno39pTYJpR5l2CmDe7b20XXyLBhOD2I3hh+P0Yfnqiss8WWSDB+r6e7DcPW7DV5cV64PukF4i9AVEKweZEd7o6YDMl1A9r9IdCvBtobkXsVwXiFnNE2aS5Zn+ciRyyNsR6nyiU4Pbf4VLKXQAXtVRxEFJsxI1SfXLrEZ2DKSuVr2z4M526bzWOxb7ta7b61IzX8qaN+YR0RLaylNz2ptnHSdhIY58bdcjLqOfbONNkLLt1xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 12:48:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:48:31 +0000
Date:   Mon, 20 Mar 2023 09:48:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZBhWHWP9BqCzVIAZ@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-8-yi.l.liu@intel.com>
 <ZAtt4F9zSZxptyZh@nvidia.com>
 <DS0PR11MB7529853F52AE5E338A84AFE0C3BE9@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529853F52AE5E338A84AFE0C3BE9@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 44da26be-0042-47fa-4924-08db294168e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4hvAtJGb1L/5dVcuaUQ4cDc+pUZhCVdC9wg/yHZO+hRvTzzIvLPhT77dEfvnUN5jXfjZetrT2QkGqGooB8fTLMdd7A0DnxQoag/em//qNQ2WzwcpttirEVRlObzuuLqPOMVXydPMDYeJXHt/xukOTZjk/61vgkhmtF8ceEjI0Ow4J1Tp5qw/y8g9Ha2xnQRfH2P7sygM7aak2GldOeftciqf7Zh7tTs9IO8aUDJpMaveN5f2a93pZrXwyRZqVo150UIiPf4z/6OloxArZ+J/durChG+nEIP8n0DgR6Vaz5OAw/5PXmM0wI6qC4g/kpX62EDi/JGOuHEwXm/FRF96tbFbZlxAGlkJ7DTdabEwCKCLh90H46Ls/BxpZ7shUZql13TbxvsafOApXHEeMJQW4MgbhdVA3MaTze0Fdx2EsN8rc208ct8OXfuYRM1R2/NNgsDgvQZzOCVKoarNX8UoQurd3lvn5XsGZISH5YciiUiIBeU+2987H7KeGZJ1sgmDE5xe27lASf4IwnqVoeQ8fU9ckDPp+TyzCVbJTXdCcjqX8ys0ClfP3+uM7aS3C6dk4XlNLWvbZMSvtY3EJ/iq2tF7s6uG682S8HP32wRFPDYe6fHz8xsudG5GXvcTsz9bNTrFBsX/TFNB2yyQwXJ+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199018)(2616005)(186003)(6486002)(4326008)(478600001)(83380400001)(54906003)(316002)(66946007)(66476007)(6916009)(66556008)(6506007)(26005)(6512007)(8676002)(41300700001)(7416002)(8936002)(5660300002)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQ6tNLXMi1Y0VnqVYHsfHdQKQgJWfmrQngg7Tg8iVzUt1y/AvGtTP3WtIhdl?=
 =?us-ascii?Q?lvK48fhACDrt7IPh7KMVNazYackMjQdHcp8aVITzIv3QxNYHuvJiifjY6HTj?=
 =?us-ascii?Q?yB9gP8100CX4k64hPj/l/uvwPcb3VxPksUKNWdJrSqm5czXPeuUPKqV21q+M?=
 =?us-ascii?Q?lUbi00ARdwI2Yb3uW1yG/tNoAu7ivzPv8XB3yBI5TEdI2X9i/an+UOSDun+i?=
 =?us-ascii?Q?lH0P1ulwzYsOz0Dn0f8dWvtbe7GjO8QgW3Hn5dXM6tcv+a22HKhb00IE3PNA?=
 =?us-ascii?Q?3nUSX7yYdW3GB6pXYtrOL5+FlMMsFwXTG4PguxG2WDPqOiWmc2mDPPXctK0Y?=
 =?us-ascii?Q?okEIPHUw2uCivaWtiQCO8P6Sti+anGphFQpyNuk5fb3xmRwXYrLlWmSJPP4T?=
 =?us-ascii?Q?rtNM5Y0OhsHliAJMU1QFtgPzeC80iuRmCr/Fjy/IKdQObxnT72IWKC6Rfx/k?=
 =?us-ascii?Q?H66278y6yNTaICrXsCA04Wqeq6hyCfDbIMm0JzFIvrw9VQM0yOFUZrA1jn1I?=
 =?us-ascii?Q?s7oPi8Ng+2pNxhArSraW3kXBU06q0DDaOoBSugi0t6xS2gKMSvbzyWfZsBpf?=
 =?us-ascii?Q?0WizYDbqHtr7j2FZHO8QUMvL97BgRu467HvprqjcHonqjN3E3D939vTa23L9?=
 =?us-ascii?Q?xyWDBtWOpwsiqE3fToi0mE46ryQGJ9AZX+/LIQ69vam0yFo9y1u2upqwTWva?=
 =?us-ascii?Q?baUNWA+2AsE7WhXMHXfk/Fbs9hBIYQaLs+r60X8IV4E3Pw0pGBSNooSEeQzW?=
 =?us-ascii?Q?rSVINSTemr0GjG+WUxQzifGZeWFfLdk2rNKdyaW8f8rQvzPJEN7QT+bOAhLL?=
 =?us-ascii?Q?QtUwkeV54HsGdqOWJI+wU6oe3n7+8hKOM9SMi7FDGi5gABMVZeiRQ36Avhlg?=
 =?us-ascii?Q?w/S7n8Jn1YJhZi9YZdAx/UazdHIQa2xcyeqK5yqxj7mKhw+hHncn1r9xZODt?=
 =?us-ascii?Q?pA/HarQNDfaecG36Jee7TpYE6Shucu5sl2ebGSJ9waX6709ZbG0SBiFWR1Ue?=
 =?us-ascii?Q?h80YKHG4z1iDAmgcms/eKMpc/0OvMaByDKbjsr5iXw/EznND6utXjz0Gs3oY?=
 =?us-ascii?Q?/D9cHsvCTje/qB+Q4jcRbCzFR1h6qul2IEmJvtzPOnxXgQIlV3ShNI75kEj6?=
 =?us-ascii?Q?3GqqzQ5NewJ+k5SYnH1iO5QIoZT5WR7ZQCKORF6fyTqH5WfZajjLsi4RXSuA?=
 =?us-ascii?Q?vQYZvG+8G6dXiuvtXdA8K39zIaom6KHHJNp0rlCCmsEcR/cj+0yDsAFitCdT?=
 =?us-ascii?Q?mH7XbIpSE5U51rNNqVn444Qv7neXfwUn97WCI8KFEa7gj2Hro9KaoX/boFJr?=
 =?us-ascii?Q?uVUrfnGzbnBr18KPDPsjh85M/x6FK23MzK5r1Iafi+Urfwi26sbKFTHcR6dC?=
 =?us-ascii?Q?QpB3awzcG5pYGcLIlaczauhaxBGCMoNA2mQe6F7ZoEfjGuBPxL/kksCTIdlL?=
 =?us-ascii?Q?jIgf0IdD1KyW78RzmofV9lUDghQ5j3AXRgCb7mv/j0//ezp4EE3WSR1eyf9k?=
 =?us-ascii?Q?i9VUr0gOlLF56RujycSJwobhidsGkwDoL85AE7v6aTXzV50cQQrEBxzenXPw?=
 =?us-ascii?Q?OUXqQ/gcJ0m+Y+MGyfJ4uKf1Ma5DWIJInadcKLAu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44da26be-0042-47fa-4924-08db294168e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 12:48:31.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uue6/KMtcpaF/uDD7GC0+F7Cl6jDxr8gO67rTuXis0/yQKIhilbKOvE6N6IwGp4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 14, 2023 at 04:18:21AM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, March 11, 2023 1:50 AM
> > 
> > On Thu, Mar 09, 2023 at 12:09:05AM -0800, Yi Liu wrote:
> > > +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
> > > +	struct iommufd_hw_pagetable *hwpt;
> > > +	u64 user_ptr;
> > > +	u32 user_data_len, klen;
> > > +	int rc = 0;
> > > +
> > > +	/*
> > > +	 * For a user-managed HWPT, type should not be
> > IOMMU_HWPT_TYPE_DEFAULT.
> > > +	 * data_len should not exceed the size of
> > iommufd_invalidate_buffer.
> > > +	 */
> > > +	if (cmd->data_type == IOMMU_HWPT_TYPE_DEFAULT || !cmd-
> > >data_len ||
> > > +	    cmd->data_type >=
> > ARRAY_SIZE(iommufd_hwpt_invalidate_info_size))
> > > +		return -EOPNOTSUPP;
> > 
> > This needs to do the standard check for zeros in unknown trailing data
> > bit. Check that alloc does it too
> 
> Maybe it has been covered by the copy_struct_from_user(). Is it?

Yes

Jason
