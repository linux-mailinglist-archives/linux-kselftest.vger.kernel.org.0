Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09526A4583
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 16:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjB0PCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 10:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjB0PCh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 10:02:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D61EBED;
        Mon, 27 Feb 2023 07:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQeTYf9iL6MzD8jGBZKY4LRRLl/BkrbUP9fGKxN9Y54RtJOx+1U+w9H9wNKYjsrKbn+uRyfAhGyzMvnlVhAGw02Y4VCFZo3vyHoEpijCan+oU8RL3/tN2t3gSWhao4T0VtE2QNpp9BmLST629h5UGa3DUpWeKDKFiPBukDjnDuBY8PZRR+ua4vZPFJv8qoKAuOtOKMAZvM6m6HnSNF/nhOH54TWO61Yqh41Dt5IXRa9qjczbFwo9YivMUu6GhI1cXOW2HjvnvUq0HrRQwF3JSNnGqzpVnt2lofzEGd3i5YkPwB1J7QieKxhN37hqJaLu0xavQ4KvYiy08gOY0tx1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr72OOHKT6UrlUQ9tz/heDjryEmN2wwxGocpsgtHSXY=;
 b=DMiOCRrfhA0KNsvLwSJ3RWaG6Y9/fIbWAEUfxsD2r9Aid9De6hGS/GP1HmLOhIjwonQ0uFl1s4tO0Ig1t7v/LT6e95DHsGrMom7VouM4W/9m0/mcB3FTQx9Beu1vZyXlOZ46Nc2Gz1uyVYpQvmNviRvlJKQS5Mjx0gk2mQkxaeYD4aK+Pjzpjyn3LcirFOSXxNG4jbWF5EJ1MYl5MD9ynKyaOdgEJqUnsR0t0yweVJhC3bUHlMldF0WFBC9BBu19Asjz4yH5hChoF0LyKXTeaHX2XghM4V1blfCBNBqgfYelNoSJgnTMQs9MAbzRR+qR1ojh6V7JdFFucAFuBv0S9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr72OOHKT6UrlUQ9tz/heDjryEmN2wwxGocpsgtHSXY=;
 b=fDzynzXcnyFeDcPr5TXUxOU3qDUCQ12mb0RvogVklGUxMhJMrAH/l96F9W2aCJK7GFoiT+UrrYVfecq87TR0gcT9ZfmQEtFw5/D7IBoUO5dwssIkXZ/aVA9F0OXaG1HQy204AY2wWnJ1JMx+M9UPJU5VNmZmVBK3sfbutgTymslWt/5Kp6G42hRmu69RdDm5VkIykOdVvf6oo622dJISZii7YB4e335VIwOpm3Sq7QI4VIS0+jgeFCMfD75LsbqoRM8ZPZwiQZ+5T7zgyAUUt4N6g5TIVlY5qOYumgoHILLLvutQJxJsX01SUgm5HtJTX5DAkaDPsQshO7IxRoU3iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Mon, 27 Feb
 2023 15:02:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 15:02:33 +0000
Date:   Mon, 27 Feb 2023 11:02:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add a selftest for
 IOMMU_HWPT_ALLOC
Message-ID: <Y/zGCLb5aGmxWPHu@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <14-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <Y/uzM8PD/XY0WI7f@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/uzM8PD/XY0WI7f@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR1501CA0032.namprd15.prod.outlook.com
 (2603:10b6:207:17::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: ac99f7a2-8293-4772-eac3-08db18d3a7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GP2xv1K2Vrm3TfjsROQWEZgrBt4I6JJBjokMz1a3+JX5UpbVYme/qStgILoelLTJaAyiBcBbf8rnVT2ttj2Lf/H+/Rij8qCtmgcup7byaJ7Caklv+TCCGVXlqJLHe61AV6ZFDroZbNiKXkYFVM+ib01aUpHoahmgm6CW+l+hbhrK4gbsRDY20nFjXd9GYgPm0nV1hDAeZI7hQ0payrZrelbTV7agw5MgPx1OY1NAuUgfvBxQj658LNcBfmxojrE3Rfx6JDLp7RX0XBvSelcNIWGpBb0SiuSvCLfAfToob4oYTN75eq7OPCan0LDTZltsrgrsduhvSmeVMUdzpykgl+GdnkCtNo3Ox1kf3dN7stG5xK48Blx4jO5njGdcD4AGnNJXqUuM3ZQTac8A/aC2ZgqH2fyx0521Rj2VDHF1LznKWf2Gf7D3Olx7xhnow/ao4AcZut4qpzvr+EnlmNUIm9aT3myS7j4RhxzPy6AGaNhrNOCTJBfqwYvEmsqzWVNfauU6AkwCl9Nv5acUsRDrackfZA8eucRm8SR9yB00FegLyWbdcm+LMNJH3HhsZNs83P1uBgvTYX1KXsDg7IpHKbaaYTbpXIBCNIjAiXRUaOe8cQI09ar9K5FY/ZdlpQDsiJ25lL6xRMEjOqIFsltwBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199018)(6862004)(8936002)(5660300002)(4744005)(66556008)(66476007)(66946007)(8676002)(4326008)(2906002)(54906003)(6636002)(316002)(478600001)(37006003)(41300700001)(6486002)(186003)(6512007)(26005)(6506007)(2616005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKU1KAZgGdVXw0DHs2duATyhWiTSRktqdOsYmrb42e5yg/FyLF4CU1Y/Fa4O?=
 =?us-ascii?Q?2jl4NCBH9Ch5ylPKVwcGTN4MNlDIlGp8hCu1SNGhd5A2nYBXUDdTcFlWH9Fi?=
 =?us-ascii?Q?jBMlJjM7wFzy7jMbRNXY/iP6c+HE9L+IB0YHt2V5b+caCyJIT5myTWudU6R4?=
 =?us-ascii?Q?AdxqNoSPFClxG4GheiSlKHYdALoYH7CvyrDRKR4+IuENC57Dr64yvmKogdEw?=
 =?us-ascii?Q?lxdbnEh53M5mPDz5BZLW8F1mPHdwpNocJzesOrmUiaoNfQ5oRywC8Y49s1Mb?=
 =?us-ascii?Q?sHX91oO295W63ZWuZoXNmT0mEycafLAbIfuQzE9zoc1uQ6AuuV62De7tOR5v?=
 =?us-ascii?Q?0x6D4Es5YQtMvxKgP9JvL7Yznpjd+W8EMQ1kfGGvxsFR9quQa7G7J0mhnUck?=
 =?us-ascii?Q?9cu20OujlXzDe+YgkU2J35jXNnmZmdHlrJAE3U8RCY7YompZf2GAyS2jjXLi?=
 =?us-ascii?Q?sQKprtbePZO3nZBL91ScH0BhdgdMsITEvjU3K5ofXZbHbnDHFo5LKo2SmHJU?=
 =?us-ascii?Q?k8qZQ7mOEF+tkNnIMV/Qteh4j5p0EPZ/a1yCoY3wv2JgQITJ38Wpb4KcN1OV?=
 =?us-ascii?Q?eCBq+tKhh3TElDP7h+uTxLfuq1JJnZqkzp3SufkmR0CXZ1Dmf6BMHaWCX2HO?=
 =?us-ascii?Q?CXL8v1VljaVG5JuPL93y2pAhxsOZAe2sSJwPN6ziblen/khk1+R2LDmVlomS?=
 =?us-ascii?Q?DqLPssXm89cWsjiNHVUYW2aqBQbwD575aQ/NL01No6fzAyDl9WcSvhRbDORI?=
 =?us-ascii?Q?YIMPyDMOw6hicJhSScVI1AOtxqwV9nPXwwIhpOFyXTnvf8YSj+W277cm5PXh?=
 =?us-ascii?Q?ndvTST/PTMfAWDHDq1cLMnhh69iawmjNY4VF9Kk6dNWJ6VLtfnk5kEPJnJU+?=
 =?us-ascii?Q?/WCdp6h0z7mH0xPvTDy3Kq5XdtnU8xXy2Yp6tlqv4eLfGkSUzF8dFX5jOGtc?=
 =?us-ascii?Q?bvAypDeL5T80riNz++zR7QfIzN2QXRFof1aMpjT9I+ue/P2xP8qdoErl6TsN?=
 =?us-ascii?Q?/Nuiygvi96h3K89XifPn9p7J1BHYf6Q0wXc4O/lTBMfFETfq71C7tAog4adN?=
 =?us-ascii?Q?cLMydA0lhm7vL63clSD0aSum6wksbHs+MSgBDsTPH2xGK/sl9E+vL3Cn4Z+g?=
 =?us-ascii?Q?k40zi6BAE6+E62Vrygz6RZu+B9+DEOUd22uUM15a8jn2s8u5QrbUjRjN7mkz?=
 =?us-ascii?Q?BkprldVyMIDdnmkEeek24HylroM/zMQkvPyTlO3zY2CphkUn/ubAAl50tpya?=
 =?us-ascii?Q?FonhoYIJtalqOGg6m2egTjTeh45XQodpVjbJW3pI6Ah3ikLoF9AWlkOeNors?=
 =?us-ascii?Q?hcl7Ra1YcExyF4w/Xuc5kN8gLradgQhHYSVFrexd5FnCPasIRQFZfr4CIGLo?=
 =?us-ascii?Q?p3HZd7ZtIQH2OkiCGHBlPsfNPn/vVbXHbnPmr3V2rs6fFDj3j35XUzjDSH4Z?=
 =?us-ascii?Q?6v0GtdTS3RCfVuuzLaxY6k08V49UUKtl6Y//G/WyCcXHvtJ7YLPNYFQ4Dzbc?=
 =?us-ascii?Q?nQrVIZe7AxYzxqakJvkaqzpoMMh6AB29VGSDvaIApJ87qLTYUXWQoIsk/a4Q?=
 =?us-ascii?Q?Sx9AAr3nJ55dHZm5aMCDv+6/vkhV6kwRaARPefi/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac99f7a2-8293-4772-eac3-08db18d3a7a1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:02:33.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6b04TjJCbFILpgsNv08vE+MsMXNztSQwl9HH6JbFDjwoemv5oBlD7piNQRX4ANc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 26, 2023 at 11:29:55AM -0800, Nicolin Chen wrote:
> On Fri, Feb 24, 2023 at 08:27:59PM -0400, Jason Gunthorpe wrote:
>   
> > +static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
> > +					 __u32 *hwpt_id)
> > +{
> > +	struct iommu_hwpt_alloc cmd = {
> > +		.size = sizeof(cmd),
> > +		.dev_id = device_id,
> > +		.pt_id = pt_id,
> > +	};
> > +	int ret;
> 
> Can we do "s/device_id/idev_id" to differentiate it from the
> "device_id" being used for a selftest device object?

I renamed the selftest device object to 'stdev_id' instead

Jason
