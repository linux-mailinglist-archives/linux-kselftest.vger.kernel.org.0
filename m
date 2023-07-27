Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21B76560B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjG0Oes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjG0Oes (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 10:34:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9412C;
        Thu, 27 Jul 2023 07:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkxlzeTyOtO/ktmharb6bi1YKdL/A+R4cxH0W13t82V9HarkUn84Ug9+Q4s05D1pEVwyH9z8yC5QsootiCa97fiAjVoMqff2nyGq71Fc5J1ehQygSKHS7KYiUYUk2yPyFLsDxs9ES7RS2SQu9zkwxcThh6gZEGnD+iKmL2g8fomI7s8As/KimgOPIQ/KSeqkciJSbWumMV86rC2CNPu3ZNTzq2mJQ5tO6SQ24MocoIEknQhfPKuKTAtWvtmFm/WBFTS8gd9Dq5mehEZflBM+ye/88RFJex72pQYx0xJMywFJnFXXLv+6O624bEa/zroMOjpf0xxXmrgORJ27Z+0RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYJL7xogsN/NB4uHLkfaac7RXMQgxIdMdP3MA7EdRnE=;
 b=NvM/AsZ6mSW2G3/JZdN1Cgd8R6gAHVoYoJgNC0U8B3gvxUU8UqTBsg/5V8PDb+gLc51BNNrzoQJhuboWwpNDex70f2XH+04diw9OCoQdF73TPxl8zYPK7pHemQhfi4Mtc940KXD24oS/AMKvdM7osB8F5hLRaFFkBHJED2bosVhcSdsiEgFK2ukD5ci5BlvdV8wwGo0wUtnsKLT33513HtEu6ZwH0fNOOE7GI6bkgISC/srsXaCw6U0zpI7GPvHBrOnPSWAYg4F/YE1LR8wwmbo1NuZju5PvZvjyAXIbvsFWUdeNjGCAkgkeHx+ZcQJIwHR9hEjE05cALV2f4iNAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYJL7xogsN/NB4uHLkfaac7RXMQgxIdMdP3MA7EdRnE=;
 b=LUofLvEcRYYcmhQjcCIM3Rmy2o8NwMbJoTBI82inngNf7anhxN7WRGU6XleLfUAY1QZVyfuSeai0iB9MLU/hvJZXZiBmyav2IjJjk7/AH8tZFQhxPswJbOfMOoRMNDLkLAacwNixwOiO3YsfhgoMSrEiUeR965HkMK0G6bbnQvV1zVA0TsXKCh52DNmg+WV0fRyVNMCcKWKkzYxKtwhp85bkXGRCFOxYH1JmOJ3hVlinIYGyXQZkM0qPvpkX8PA5BoSi01ItIBNDM+OR9YqxugCGbRxoLPsiF/qcEnVqQQBjPc50P9XVUJlNR9lwqd6xcBUb5i4X8Z9yepCpZ1JPOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 14:34:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:34:41 +0000
Date:   Thu, 27 Jul 2023 11:34:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, alex.williamson@redhat.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mjrosato@linux.ibm.com,
        farman@linux.ibm.com
Subject: Re: [PATCH v9 2/6] iommufd: Allow passing in iopt_access_list_id to
 iopt_remove_access()
Message-ID: <ZMKAfw02spcSIrcG@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
 <bb3c6845bc64209ae4dca5ee0dc87464fbc4961e.1690440730.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3c6845bc64209ae4dca5ee0dc87464fbc4961e.1690440730.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 165b6b1f-e38e-462a-596f-08db8eae9cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lfpMKESoEFh87rji0KL+Hk7BkQRMS2EOwVnKvXdR3sVS6UCrdT9o47bn7CX4cjCc1iuZiy4VsVYoxFJTWtg8fFWfSEnq+j2jCLkmVq45DJfNhsc0prXaI4FSFBpYaVRUoX7sxr3XUlpOgZOpbynAjSqpFFogbzScKM0n5TWfv6dGHf5l4LKEVHsCtOAXwRZizbOoymHgUGrYDJXIqXfkIIUhK34kt181XDt3dQlA+JdjOV+HiyvriOpx2q/xBaw7KjV3Q2eLF+2uMScQnkktupPdODJUkyf1+7GtNiZD7OUr+OIYHGodKC4YoQZ8OtliFUSg3vOhvfZllQ/z/hAilKOoR1tXMpl4rk+SzZQYQFsaR3/rStoV/Fuqa7SL+hhRuhcEUp04yk1W4o2hKLg6ifqb31Akung8fUJIjE5SllW1jtXdlhCXkHP2miT4ssUxTRhgk3I9tmd+MztcSuz983imLmeaew0hvp2IPkEUORfaCFjajVWSPU5Hmvv56hSG+p7RfYKDn7PatxARPBae+rv1apioHxNP5t2COOAWbe3xFnSH3MZhDpI3PgI48AF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(83380400001)(86362001)(2616005)(8936002)(37006003)(5660300002)(6506007)(478600001)(6512007)(316002)(6486002)(4326008)(6636002)(8676002)(66476007)(66556008)(66946007)(41300700001)(4744005)(186003)(2906002)(7416002)(26005)(6862004)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W/VyonB9TCr78ShHJ5cdfQ12YuUEzcTVaqOobb2l4K7al35Uv7er9aRFZ1Oy?=
 =?us-ascii?Q?YZEe8PgdfG2an8Hmdm8XLvfTqx9FzC4EcudfM2AjZcwzyu3wAnSQEzmSnhf8?=
 =?us-ascii?Q?m96r9Fk6YGmG/eBxoMEh3UgOJKk02+sOfn7JJsHGAnilDlBtJfX3F/sNM5CM?=
 =?us-ascii?Q?ZW/xS5BBmjg6nll8eOBHWPVklbzMo8JE9IOYPg2PG4l6lNfPpwmpMPLPlkMv?=
 =?us-ascii?Q?Ua20AEcz7Yj2F8kk7E9aOnuuH/o9XFTGMkpvDl48xDg+6uvSDWMP28nI6HFr?=
 =?us-ascii?Q?IBptf2AlfvUT9HSB15fRSMVHpvYxTzlzfvgYW8api6Desj0rZpoigikPBanR?=
 =?us-ascii?Q?rNlP5SBs9pK6LXyM/v6a3gllwCHgkaSGmLeFk0ZsTbJ8T7a6HUKEuiHLNEkS?=
 =?us-ascii?Q?VtaxlhPBq6PBH3C0uISTP9qEBq27H3dlp/ExmP6keyUTaR+JR6p3eG6BgYC7?=
 =?us-ascii?Q?WM544aaRCj6e0SZ+ef9tFNaZ+zJYsD1eydxhdHWFOq44gH4OIFc07bdtyg2i?=
 =?us-ascii?Q?A4Gi0yUCsmpaBjpK2TKF2S2kpcUzdgG46RrCQkmx2khv/oVm8D4G2iP/WcIF?=
 =?us-ascii?Q?q7Wz6qwuap3lN0oLsjM7FG7s2CGqVSjnIfz4CJf9M95z1Nre7XcaHggHn+sr?=
 =?us-ascii?Q?mmNFOLTeDphN5csv037LVkW4heqFufBLxmGfxYuS6TGHQxvsW5CXRzUOQai5?=
 =?us-ascii?Q?QTpixxMl5eQVpIyhxmz81tnbsGT0uDprT3c74JBAM48f9mhk9hWPxvcevz6H?=
 =?us-ascii?Q?na+bNr7vH7y2dw41zkrs40wPkk+ptk8ZXb2ceASykRxOZD7ZcJvI6lnn0xpp?=
 =?us-ascii?Q?mJ5w5o8TivSwUCv3oKbzIk5JEBkzrosVIywXyz+v7aXgYR5DD9yjtOlpp/Uq?=
 =?us-ascii?Q?+0crrznguVNzMfDvOdZQDVfpjSuZOwhza30dZHatCWjO/QCJW4oeicYzuKDt?=
 =?us-ascii?Q?sJ72mlz9i0O9rz5HALVrGfx8zDSaZnznTMuCe3e8xjolHQPQuqJxgFXZOIDv?=
 =?us-ascii?Q?e2T0nSEE1dye45oW2yTy2oq5gsOy6PiPWD2ALnLGIXBvHaCOU8gx4Mhgr77t?=
 =?us-ascii?Q?kvkHsNKtILjblwrZrUl+JI0ryLWbfFgPf8Nm4Dt2yZ1lRsL3dd6rbu4fLXnD?=
 =?us-ascii?Q?jYT15a89Ba4Hl+ZEHlvPnNM1kimZRq7bLnXIceCLXno6Znrirm4llLPev1OS?=
 =?us-ascii?Q?zlU7HBD+g8RAcp9aqHGevrCQ6uxd0a7vSMHhIMpvAA6j5r03XnGOq6FT1RrN?=
 =?us-ascii?Q?rFpoqmJJ6A6uHZvIGzp2z3MPhdJk0d54TNkyAk5NwgJBlNZpEWkGtblNno4h?=
 =?us-ascii?Q?YJFoUJ7v/uaUSUXjmHhbTRmhwOxX0DgBk8nJ9XqTKaMgKJNym3P2nOZTEPTD?=
 =?us-ascii?Q?q+ZgfxTnOweOZ9JdOXByErwIK4FC/Nmdfs8EJrUDJInrRNFb2hmIWYzlH2Tv?=
 =?us-ascii?Q?FmStQSfBT+niTuduwbR51mGt0qFzueVBi4C40D7UXtoV2m60AoISy2n6RXd5?=
 =?us-ascii?Q?z1rk3lSKwoPlw1Kz0w8UeOo6TdhvJeEPfL3uHy/NBkUcACzuscZi+ZdZdrde?=
 =?us-ascii?Q?1HazPJYWSConvTLhUIYCYnLCq+M+T/gBgjBCjiVu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165b6b1f-e38e-462a-596f-08db8eae9cff
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:34:41.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0DbhwJ4RBMNrCPmhCStCKiq8cKt7YwBDjR9WW+wy6NWDRJ2Bi5fjpjlpLpeNWVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 12:23:07AM -0700, Nicolin Chen wrote:
> This is a preparatory change for ioas replacement support for access.
> The replacement routine does an iopt_add_access() at a new IOAS first
> and then iopt_remove_access() at the old IOAS upon the success of the
> first call. However, the first call overrides the iopt_access_list_id
> in the access struct, resulting in that id un-erased in the xarray.
> 
> Add an iopt_access_list_id in iopt_remove_access, so the replacement
> routine can save the id before it gets overwritten, and pass the id
> in iopt_remove_access() for a proper cleanup.
> 
> The existing callers should just pass in access->iopt_access_list_id.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c          | 6 ++++--
>  drivers/iommu/iommufd/io_pagetable.c    | 6 +++---
>  drivers/iommu/iommufd/iommufd_private.h | 3 ++-
>  3 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
