Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1A6B518E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 21:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjCJUOn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 15:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCJUOl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 15:14:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352912D41A;
        Fri, 10 Mar 2023 12:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYEergHLpzL8GYIZ7zSnQj8/MMw2t+kwDMRKgJ2fHxjD/vuu7nxG3o3cGUwnaqf730OhanT59lRaemx2TJE8Hz7J+cr8X5SgJt1RdGQGaAMp/D5ERNBtJqeUuvwxXLBgOp6SzXFmlMR5IV6eK4dQGTXr4pfzM+7A0tYlFm/jUG5E/tn5L3fBTmEL9i9WuvUeisrd5Ma5FEPmK4MrOOrPFa9ksVJ1goHt7jGtyGLXiJnnWTirewtogA9V7eFHYPPyvIeGTL4+2F/yCMFX9Fgw9m74LBtjFHRBBm/ro80XJyMQ5ngXy7ddX3tOLYfaMY2LpZFz+NoGQnJO91H2QU/n4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un1BTE4l6FiAD8cn+pXmQYPW47LzK9GxAOMVACcceHc=;
 b=VdSSIP1jsNgiQajuryGWZ0X2fDfdsHCTNx40xS18uaFggafx0QRE4VWEmYBI6fBw8S5nGHiqoRa9AhM85iVf3TCJONee+IU3GBAEc6Si5Jbiv+J/O/sKN9YP4HCIqTD0Eiltx7E4wzCAFH8hGegZR4FfK1qQMzReq4fr2/YUf/DwcVkqSnjAgNz/bxezwHhKshW39M8jvcZxcHmFf/PdBl59xI7bnrLsltKAVaV9XTTFgVojGkmYtdzt+JkqlE5NBCiaNJ7FzT7oGZB3pPXVpKR9nBmhC8Jr6XoKbwM69qCN6BjwojjK2w0Q3rdUpbGbPpxYzNCs+ikFfUmQ25bJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un1BTE4l6FiAD8cn+pXmQYPW47LzK9GxAOMVACcceHc=;
 b=EoiMktYIho0EJHCjEyqSD/B4ZFbeC38cqXGPm16F+2tbeRObn2T2EFwBgf3D0kjafkH2fxV/I7hkg6rIjvdMogug7ctykoEPK0qjFd7sf5V591jDHo4RwaifChebGwg4AY30jaIOVoM2fZroq9Rb9BT2qCluDrDyIHgv6Ejp20qXVqMTss6usHro0X31jhG4aRWEGZ1opHd8Ket90kdKNFYyrrBLb52NgF+W0VMRyY4ZlwoEkcdgYLFL2HyZGuF0T2aFnTar1p69h4nZI1NR7sdRT+hYJB4mWtYyrY370UqOlPDpIiLdh210U/3+NnpvmuxCZ3hPPZFslAbuDZ9mqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 20:14:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 20:14:29 +0000
Date:   Fri, 10 Mar 2023 16:14:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, alex.williamson@redhat.com, shuah@kernel.org,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mjrosato@linux.ibm.com,
        farman@linux.ibm.com
Subject: Re: [PATCH v4 1/5] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Message-ID: <ZAuPo6o9Qk3dlpf0@nvidia.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <2dc87ceb7bf02c7f405bde44e9ee9b21398c5228.1678284812.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc87ceb7bf02c7f405bde44e9ee9b21398c5228.1678284812.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0325.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f301965-4cba-4cf7-cc51-08db21a40d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWTbdykJrxjalWNFJh0WomtBAlwToaE4YBBf+LbfEB8wNSFwzfWvj9R9evt8yDjgBRqn6hQ7rg8jvv8W0RSBud2zysIfZyQhPHHulSbzUzAeLqh9i5Ax6CrgEXLAIcnwsh0NorduaqJzyBkYw7p4IDjPkqV3puP1dBFXyJKn0Lv1z0TwLSW0fXqiR7bvIgP949vHwfD3z8FM/I6pDHAsA0+b+OoUtEx8Zti5Tb0g4FfEE8LD0IiCuPRheXpEPdmMwzMuCse52XzvwWSrRCY8KdMD9n6bLABZ0DoH8ihw3l57ZwekXsrYaszx9jON4llccaGXFlL7jIMQuOAgtNv2PklT3ULD5GhTicXiwSwCyl+q/JN93zNxn18J1AUL9GWXhuiYJc6/699t/buUSg+PcOp95Bhh4MjM4smXe7BLcZEf9iTKpgY+uZyOLiNsUiL9yxoj0rQsit1C/lUjFYJpOvEA814vwHdXcKPWMgsrIRcGc8EWgR3xl0fChK1s2JCbozB5R4eX68J8gW6TVmi9sHEn0jH7+ZajMj/VMgGrzGQH1tO11kWDlfEUhO10EJHhm9QnypRRSSHOscyUD+3d/KOpl5H5VkKQnKiWp9lo/guhH8gfPosayhGGgbsPns18Ia/WAz5AOfSRXoeLHwc3iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199018)(36756003)(83380400001)(478600001)(6636002)(6506007)(37006003)(316002)(38100700002)(2616005)(6486002)(6512007)(26005)(186003)(41300700001)(2906002)(7416002)(5660300002)(4744005)(66476007)(8936002)(66946007)(8676002)(66556008)(6862004)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXJvyRWZVn5UmLMo4uCaV7pID8/Ay9Q1uMT/b9kCHaYrMtrFY3fFDrgVEkE7?=
 =?us-ascii?Q?SXk1zV/qm26p6z2fuxq71qxXOnAQyc0A6Ko8UDe31PFoOQXn5BKBHRRIpjiT?=
 =?us-ascii?Q?xtwBeLvVqH0WKorvxsv/tMS3KAwOMefUAd5PSOIlBYeljQdYTxMlUk114I9d?=
 =?us-ascii?Q?oCg6PE4BU82dZlZmymRF9TXKnn83HWLs6UzQY7qFEt9xW1Y/fAGy8AVBFWwp?=
 =?us-ascii?Q?T2JWtgOQ89XYWxTzIrIUsR48IjomWw0hHeEuf/tyIw8yyBPCePWx3Zn6Ecp5?=
 =?us-ascii?Q?07ZA52VyGocTrXbcxIyj7mlpMv9IbhGZPGz23d5B8wUAl0fXvgvpjs4z1dQN?=
 =?us-ascii?Q?bPkzhwIx0++tKPMkn0THOeuXWhUb+xaQ0A+KynEH7zvD3qLiRN9XWFeuvDH4?=
 =?us-ascii?Q?egMf5MusnTC8/GSc7hdkW6ZMDPA/0zixkQfMGuCafvkwlbY+k698fy/o7jHR?=
 =?us-ascii?Q?TKjO88K9uVIFz21an+uQ/9kujHqLYBh2NO1F8/93j1DZ/LkSKXrx6RgZi4/j?=
 =?us-ascii?Q?5U94gwa7p2NkHmPJ+7GHmECZhbERnAvOFgGoi6a827sIdFQeUBm1bVfNzTu9?=
 =?us-ascii?Q?LV4KxsWexzs+EkWevAN2uQxYBeGWHc+b8ecGtfbc2eLNPFsyN4HrSvYSvdi6?=
 =?us-ascii?Q?Se0KrAni6VFn6Ri9xMVv/JzJDgCmf3BsEmWbpbzcf18Wr9OmuooloYmv/uGf?=
 =?us-ascii?Q?bpy66qVOEBTyZoxJMHegSEkra7YLIlNMmIkmStVkxaYmWGzum7LQ76s83fTb?=
 =?us-ascii?Q?Jd/t+ZPt4dGF8ORY5Uf1nzOg9Bj1XjNAezmZHNVsJacTfdTWk7VwfNhDEhvK?=
 =?us-ascii?Q?T5N7aiAyLWPGgaMf/qGwW4iSrMnEtYH/G3zXfGnJdqaAd1UC/Z++bku32MXC?=
 =?us-ascii?Q?mAmUWHA8b8A8LdVaB/6VUpS7CGnKN5gQcyssibgGymp0vFcNhZ+YoThvZY5+?=
 =?us-ascii?Q?M/WwXpq1GakDvNt2Aj56VQHCmx1AQuE0gE+ByF8NyrTV1OFkjwoPKlcjEBSu?=
 =?us-ascii?Q?B5w6EmxR3wIQkFN3YdfV+Ve42fGsASnakjj2SmggzCx368HT8PazEk5g0Evp?=
 =?us-ascii?Q?FEx2Jyb7+UrbxWSXRerf3xjIalZ93vSA0Au+8DU5mW6pA8lBKZH7+16uUYsB?=
 =?us-ascii?Q?ySi6dF08urZ3+r5/vMS2QPDcI1Bs5/4JH0jAMrbcAMEqdqZjMEgQdHLkCIh7?=
 =?us-ascii?Q?o5VLQ+CDEQgMq+VGrLCA4Np7Nkxls7UI7lclQtukhicSgi+nDD9AN15oHQ0A?=
 =?us-ascii?Q?zjRLQrkQUEzZqFtsexmMxnemN2I0pPMBhkmGuLdVU11fOcEbbTjCQVCWlDko?=
 =?us-ascii?Q?tK/ItE0j+Y1EfI2ouEwSfdcXHvqRrqudSkrqX50VCcHZxRLM36/EnoWrEE0P?=
 =?us-ascii?Q?1Ad+6e98SI03rutBAYDJOKyYnwEQ/7MmidJTKxbypAI6xMibKw8rn1vkD0c1?=
 =?us-ascii?Q?AhoLiKAzwzvaITIj4U19YCNfNY+gKnSTsAqC3CIPNx2xRATcgxiDPXev0ENn?=
 =?us-ascii?Q?dH/scZZ6AZe2ILuU2qwV/h/TmSS+Tu1XTgnzWOfnJxy7jjkNqElym1iNRPkX?=
 =?us-ascii?Q?9zLiz1b4hCbQAFRlKO4CVieisRFvRQBukarKfVwx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f301965-4cba-4cf7-cc51-08db21a40d85
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 20:14:29.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k81Vngavi8aOGGYG//ZVwbuqI6TGGOQmLGfE3HaP3hmJHjAKm7sLUyMOW0F/Yo85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 06:25:58AM -0800, Nicolin Chen wrote:
> A driver that doesn't implement ops->dma_unmap shouldn't be allowed to do
> vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
