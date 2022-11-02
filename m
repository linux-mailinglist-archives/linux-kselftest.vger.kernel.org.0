Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C72616389
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 14:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKBNN6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiKBNN5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 09:13:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004E2AC5E;
        Wed,  2 Nov 2022 06:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeTJefXWWNGShOe2YDJJvjthgxTeyxJKDTKD1BT6W14oNedaht1EE57EXl9qbKekIn9PFN6ioWDUQj9SQR0DmBEGGgiNDV6Q3x78eZSY0UOoXQm8xZE4IeNLAsAvZzVzzANhhTo15W4SfrtfpeJ+544mBlCCUt9EzCZCZFc4y8CQJ2Q2R+V3V1cVl2jztBub3bC1c4QvoxCUEnX2vBO1TzLAZfL0CSBJe8ruyxI/YLGlEzbf5CGAo2xGiHruwIOT6pVubLUl+O6nAbr3OubFGsv4TtFcdAcHB2ZI0UZRlfjNwqURPaUVmoqWlOx6J+cMWSaWDcZHK5kqK6L97bBfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ao4QkxhjiaeX0IiHCJuLTVXTmerIcc/QutgDW+21og=;
 b=mK+TMIP6t2lCp7vozBFcOk0oQC42K0hHxoJ25LocNc+ulTQsLAAzJmuH3W8zrgqH0+5MDk1VLKfxj4OKeeEYI0V5TSaRU3RYXBCvKx/Utq+8jdlgKr8Flkv3NgRq1cfP6P99pr+KmY+ow1xI5cB0l/7HuKVNiuO6vGLB4ZCEfWMl12L6iOY8Ylkkf5YmrKfXpC6lIMYMkaSuJm9/rJY1uBMfXykq6o8A7RFrsgO/3F91XIbZymSw9Fvh+GKfv1/iXWLZc/x3FhJKiyuRd+joPB2rEciN9WCtcqcL3V9dArLeqNb6HKb35SuzfSxncBYaVKt14y7n3orovPn0YnCzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ao4QkxhjiaeX0IiHCJuLTVXTmerIcc/QutgDW+21og=;
 b=OQDCL9BdIpRrK6bk8gMbAyHD2yFdXYIUoK3jq4QNzzm6UomFMkJ6zWKpsrAEwPxZNVriVFr+0pOxpEu1llzNOVwHQ9DCpgEF67ehQpgzmLInO1scEl1dEXkoXGe5qQoOXYe4PcGYfUrkR8R0AhlXR02WbFeUIqpUKdGEAzLqV/BeYlEXkx6zILmRcMPG/JJk0KO2A+Q2DjcCcPevUV+0otjEeg7iLnuUkNu30v57KKp2EDgWbAMhfx25RQ9HF5NFeO5WIxF2qDL+nj1sh4BgVIFCbkkd8TSsX6mZIOsPKPYvVHod9tCCYaEh7FqI7s4M+xC8hgQDQ6Ho1MRE8R2fLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.38; Wed, 2 Nov
 2022 13:13:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 13:13:53 +0000
Date:   Wed, 2 Nov 2022 10:13:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 07/15] iommufd: PFN handling for iopt_pages
Message-ID: <Y2JtD5Uq/ddcYf1g@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <7-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y2F1yBnFpv8jhosS@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2F1yBnFpv8jhosS@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:208:32f::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5596ddb8-b486-4a08-a55e-08dabcd416cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUc1rkBdbL8KKFqzaHPp5MrchcNJ9OMBkOz9Y5APcXKMKOwbi0HJXFY+kqH85VAyf87AgdqXo9kJqvIc7VzMYG0megC05kkm8a1hFO+yCng/KAyR2Pst4Dl1DPhDy8UWOiA9Po18miUz/5dh9/cvxENLOrryLRdtMlc/1wota/wF6OU4xp+hMKw7a4fqpzcRdqoNEnz+JkpgKbYT8zzGeqK19XrkO+lwkpMOGwqG9qgdURra1KgAg2CmaKwigZoRmKXA9L7WdFl4hKfeXbM3R4VDQ/ovmeO+L+FPyW5fnGkXWqkiYwoD728ZKLCUEsp5A9d7tSu+sGeEup6VHMfJM2bVDKycIMNPT3ksR7Bqny+jJAAT60xeUCh144WM8QXnOC2gKLeQMgWV3kmv1a5EiFS4OjsJwKFfVIZ3/JznxUkGskwCZlhoigVZS74KdTiJafvabtb4Y65zf5VzYvhaGNYzHwRW6QmdB8gJZUVPOxKxY+n6x7zzCCHwKHEfdKM4GhYH1BKPKQeEPnT5DBilll/7kpFGrI3zNwA97tyjX3bmND0Oinwi0XCa/RAtviI7to+7jk6PD9N3T+C3nns+zxYvMop7AgdiLHI7fcI335vqPfxhu721xgdq2JiX0ZgFqHyGQx35ixpSfN820DyMvgRmAhZlbE2opM6JhVkCXLJbsGD7ZztykIyf9dAcPvZzUXip/nYBqhHxDgMTxg8WBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(6512007)(66946007)(37006003)(6506007)(38100700002)(6636002)(316002)(54906003)(66476007)(8676002)(6862004)(8936002)(4326008)(7406005)(26005)(66556008)(41300700001)(7416002)(5660300002)(186003)(36756003)(2906002)(2616005)(83380400001)(86362001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AP+/vkWp4aSXGrk6ZrLNG0W5uT50kFcCjYsVVwhodRBeavqqnNrR8mxT4qO8?=
 =?us-ascii?Q?cAyo9efDQM96mRAIgj13Lb1m8EMA0QM/IT0h4Amij5gEs1xO1fA9mg24PO4l?=
 =?us-ascii?Q?GvPAooabr6W/7sOTupPAuK3R2c1NapQ0YD9qgfLaOeuoy1YmG/avn2KnsprS?=
 =?us-ascii?Q?OKWLhsiHTCLGp3KvfVRMuPPDaENxhgPa8y+inaWGVyEavHIv1e01ihDy/Jwv?=
 =?us-ascii?Q?ksPEahFqybvEBPY3wwlj7m6olEV69/UkxxBcznET+NicEvmd9/1YJkf3MODd?=
 =?us-ascii?Q?clNq3VRekEHKRbW7DCYY9guO6YrxAFIgGv15F9J5JURs9TdpH3yp+pqMZJvL?=
 =?us-ascii?Q?BbVbFdbR3Xu+DjShaliaCpNFXc2vIDwMgD2/NlGKxrrdRdKxKOmC4BPBN2vf?=
 =?us-ascii?Q?LjD/mIHO+S592iQ0GzfxBWY3F/IIwQuJF44EnrumZALY/ENcNEocLwASp7kG?=
 =?us-ascii?Q?N2TPmjUG9NcbIvL/LTySEJiUnfVqdSOiDw8eqauU9arhVzO88+CphCrn9L5v?=
 =?us-ascii?Q?D+o6GlacAAagBTqItiTcFM4Jm/FxCGw/xD9ksx84N+sZa+Ior1eqZuJsqVmN?=
 =?us-ascii?Q?/wS4C7Drx6l3cgkZD33fm5VIjRIe9MHe66obsNZcYe33fwcN1xYBuDqQr8dm?=
 =?us-ascii?Q?fZoI+/7z2uK7PhKxVTHwvKu+nRFla2qBU02Wr6dm7pBOSWu2eBCxghJMO73R?=
 =?us-ascii?Q?K/iLueUaOTXjsmCEWhwinDXNtp9UvNuf+/jgTn89uv+lLQXknVUfk1zsV8oc?=
 =?us-ascii?Q?zTUsR+LOCMn4E4LpYYbxwGHZN6ApZsmuR27+YYS7F+5lnaEZJOaoS5Y7bx7f?=
 =?us-ascii?Q?yH112F6eniuc4TiGpDTPQzNVRq5PoT7oCsStocUee1u251QjaAoqN3J8+m9C?=
 =?us-ascii?Q?0K88zSMyDwv3vvVj/wfnEEUGgPCqc8ncl8o95MyfRfBwbRtZf+SccD6NQkzw?=
 =?us-ascii?Q?QrStYGIr1ongHcK4dEJyxdVRW7khRwgnQIjIDBML90f3M63fyXb+eLmmltK4?=
 =?us-ascii?Q?IB+GJ3tuMK663Mv+hZ4dqPdtEcfe5C1Jx8TeL1kIzrBg+3bu2N+wOZrFhx41?=
 =?us-ascii?Q?WHrLheoaCTYmuN948AzCcb4+4SSHijFCgNHmE6aec+0m0RHuIy7CUxXzrjmo?=
 =?us-ascii?Q?FLxbuGQSdvsOUMwIOhJHSX1Bly4RqhW3m2OwQpkQ7ALczBOAY1JjfStRi2+k?=
 =?us-ascii?Q?y1hxj5tbpoM+il9DxYa7e1GNA4BKMfuJZaCTcsGDVqKug+C374V5YvwSuuV/?=
 =?us-ascii?Q?YhcIoJ7DYuWQ1IBRoBWF9CgWxVesO5PKHDj04tlRNqzokLtDQtSQSweiYjxJ?=
 =?us-ascii?Q?YozK5C26j4Ldcnd20o+2A2aGZvW+hGMGiUcqFeHsNsLbdfiKvDMuV3qm2mtO?=
 =?us-ascii?Q?jwgn5DUi6VFnsdH4OrhF9kKWQPuGpq8iBEx9y1cIZd2HejWLKx+NpOkOUrud?=
 =?us-ascii?Q?Qt4HwABvl1WYPxbOGh3dsMlq84q8N+PUzua03bfQuMTLcxIxcXzNpfAOdkdc?=
 =?us-ascii?Q?zWLPKkqLoR2SOJeBbBQf4jOywjIyJBazuOrVVJF/G1Sbpa5KXe4hwM9blfjr?=
 =?us-ascii?Q?7KYqb1mU987CdwTZz3g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5596ddb8-b486-4a08-a55e-08dabcd416cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 13:13:52.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDwKmm5rGDfHjluvfEM2J9hTH7PtB6BvdwOeMFaiKCnmigeJRJJ+wVZ9S2PKM2Il
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 01, 2022 at 12:38:48PM -0700, Nicolin Chen wrote:

> > +static int pfn_reader_user_pin(struct pfn_reader_user *user,
> > +			       struct iopt_pages *pages,
> > +			       unsigned long start_index,
> > +			       unsigned long last_index)
> > +{
> > +	bool remote_mm = pages->source_mm != current->mm;
> > +	unsigned long npages;
> > +	uintptr_t uptr;
> > +	long rc;
> > +
> > +	if (!user->upages) {
> > +		/* All undone in pfn_reader_destroy() */
> > +		user->upages_len =
> > +			(last_index - start_index + 1) * sizeof(*user->upages);
> > +		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
> > +		if (!user->upages)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	if (user->locked == -1) {
> > +		/*
> > +		 * The majority of usages will run the map task within the mm
> > +		 * providing the pages, so we can optimize into
> > +		 * get_user_pages_fast()
> > +		 */
> > +		user->locked = 0;
> > +		if (remote_mm) {
> > +			if (!mmget_not_zero(pages->source_mm)) {
> > +				kfree(user->upages);
> > +				user->upages = NULL;
> 
> Coverity reports BAD_FREE at user->upages here.
> 
> In iopt_pages_fill_xarray and iopt_pages_fill_from_mm, user->upages
> is assigned by shifting the out_pages input of iopt_pages_add_access
> that could be originated from vfio_pin_pages, I am not sure if the
> remote_mm and mmget_not_zero value checks can prevent this though.

Yep, missed that when I reworked this. It should be like this:

                 * providing the pages, so we can optimize into
                 * get_user_pages_fast()
                 */
-               user->locked = 0;
                if (remote_mm) {
-                       if (!mmget_not_zero(pages->source_mm)) {
-                               kfree(user->upages);
-                               user->upages = NULL;
+                       if (!mmget_not_zero(pages->source_mm))
                                return -EFAULT;
-                       }
                }
+               user->locked = 0;
        }
 

ie locked is tracking the mmget and is completely independent of
upages.

Jason

