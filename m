Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE05563E646
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 01:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLAAP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 19:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiLAAO5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 19:14:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3913BA2832;
        Wed, 30 Nov 2022 16:09:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnZs1g301ZD3oj4igVLmgyl/Vb8FtCh16aGwnghT8bjla/urOe+vrGtWZvLAArswBEbox84/W/YImBEtqa4S/WmArQwHmSGfiOC4nFrn3vwbBveYe+GGP1xzkit9yrMGP1YJ7Hp6D/1Hzx9LNrsFZXZtjIB3zFYgAqo8t+F+/Css1zpek0VJqSt+ulUW1yYSU1J0lS+2QGiNUHsM/lXHweOrgKjdW6jXR2PMw9c4QD+eHvTbQTE9sZygUkIuxsC7yeJLNeAHNvboUWGj0+K6miVjHpy6lfy46UhELY/hB/1PxJ3kG8N0Bx0HLutlMmhyfJGEJSPh1xYHo+AbFapaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuUdeZDc71Ct1K49GFqwN58eUwSj/Sw8lNQZL1tmIfg=;
 b=YkuNZwv6y66p1I+77gG8NskqMF0i6eGMr9piZOpMTmHLRdKHlEJfu/uU4+VuGoG6AiQPBWbg93vAdV63WKYCDeq5j7bEKzrLsfeQkFrFz4+bhumTOM9jLMAS34vAS4/sZmaNzaHAenUdAmCDoL3c2fAS69HFc3o+aBwQYV8lHBrUbsEOs9hBg1nZndZsi7UDAJTnudJ7MYtThcbbQF73V44UhwU1rQsipPmjh7ZKQw5RNWDu6cBJdDGBxVlQkXHOSHpwZo1htCg2K1L+BWZCdsr4gg6A9W2NnS+IshTPjVKW3XkhpP2weWntqkZ1/vkpVthSUXST9Vj1QAkxY+17Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuUdeZDc71Ct1K49GFqwN58eUwSj/Sw8lNQZL1tmIfg=;
 b=RVDBpP2jN1cIfCZpmLtFmwHJtT2QLLBFt+5K2QVvhONR0CcVkHHZ0ER1BV6nZl74aiPxS2Fmm83bPAyjAFEz+KMkbyHcLzZeGtO9o+NB+G56ofClx0xiRFvY+nOX5cZATJl9spAVr2vi9hD/3JFGfZMH1GsOSXoFTxhmF8+C+QnoPn7wj1mfbxPoh9LCZLj064yyyfMQVDXAdCCM5O7tqb5GweItXS/jiyARmqf0SAtTR/2zgFTHMzoirBMyyR0Ha5GTGkgeU0AZz3YsczUZk7o7/FK4eIOFGZ0s8fBr8/kISALRO+hDfDn2dNhwJwJcUg3N/YejO6WTp5xbCS+F7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:08:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:08:57 +0000
Date:   Wed, 30 Nov 2022 20:08:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 05/19] iommufd: Document overview of iommufd
Message-ID: <Y4fwmIYO6OCYxhSb@nvidia.com>
References: <5-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <f1077114-0f0c-0ec0-0dd7-8b6cbc26ebb1@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1077114-0f0c-0ec0-0dd7-8b6cbc26ebb1@linux.intel.com>
X-ClientProxiedBy: BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: d4394302-9f91-4cfc-76ec-08dad3303da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHscRFb+llt9tclxi8bx3WRLLa6XNtBUiNW90gFwFinM7ma5F5DfMFMYnv2mfwivf16yEil3qKe95rkUonD/S/BLL0t256d7WAUbhO26LRBtJB2FmrwEerEuzOMnH3b4SPYLYmc1j6H4F5olmDy0JQ7M3wQZ5lIPix1oDQ1RmWYKqfaejG1gxa6HRYtToc0KVURrs3/gZHZoXCVhVLPO/ZdkViPVOR5MYJ4UKB/Vv3OkONnhRYfTwwbG5/yGNDuJt277RZj0JpSe7QNZ2BBoxHr48adl6wbTv64O3RE111fifczod63sLreaz02afMSc3wEL0CFVxiljL3JnphTMDL5jxMmaNyRrHzohKzSEIRVyKQ7QYfggScHJ5SH3d5o83kQ37sxBrXNu+0d0ZKGEP/x890GJ6H2FCY3nomfdwG30JB1o0kS8dDi8DOYDpUDd1J+lCOU6EdOEasMxXH7h+se7e9usME4cZgtK+26NXd4CCWJXo4Qpjg0oC2fje7ieUg8l6cnXuETbKJ+Qzv5psx6YoUhGyeVLT/vL2BMUBi4tcYli++WWbMvmTDNp88HtZWgICYxQ1vWuu+8uSF1zvX0l3ULC2Co8hJe9qDZbqbMWgtzdLeCxsDEN9L0BwJjRRKAekl5qcXaX0KFjSWRSFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(6486002)(6506007)(4326008)(2616005)(66556008)(8676002)(36756003)(186003)(5660300002)(66946007)(66476007)(8936002)(6512007)(26005)(316002)(6916009)(7406005)(7416002)(54906003)(41300700001)(478600001)(2906002)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2iufAj1xANuFhJSUQNlbWSs+6TXzJoE+I35xXoYas+zRxLtru/GMzOzPz1MF?=
 =?us-ascii?Q?iu23CK/Yi7YH/o7hIpGVZI7OrnNIjpKkki9HeROX+9b1IO53D6wopvGac+XV?=
 =?us-ascii?Q?htYKkubmzbC62ZZ57b1fbEl02cZfkp51IJf9tDR39PsgIxcl4QAtsuxNqUU3?=
 =?us-ascii?Q?+SiQdYUvOPpXJH/WzUXA+LEYsUZrxic0JChwwXv6eo1HHyathogGskg8jzXo?=
 =?us-ascii?Q?VifJ/jT+Me4MhNWa03AbEzk9K0g2lvYueFTI4kIR3BHT2o3/lhkuJ9iSDo2q?=
 =?us-ascii?Q?AHukIpxLUhTO35xOKU0N/5WuBpJ5egoy5YsK1dx/FRct6Oa+uY6bYUEOFy5d?=
 =?us-ascii?Q?WaMJVdT4CiRlte7ucst1ZpdunM3aA/dmE76q3iuY3Qvg9p7DC8ig7Z9queRS?=
 =?us-ascii?Q?+Wc9xqOrRPKyPsoESUJzLqRbDFNiIVk2wQ8zYwi5BBLzaO8/5nacGLne5OWG?=
 =?us-ascii?Q?CMbasUS4W6TJWbgsJc03zx8jhIb//NtE1/i6LITUN++8j4L+FtKutPHjHxxM?=
 =?us-ascii?Q?M5KQ2QxEvcc9Gu7Jlh1x9vztpnHlYMMdCVihp+DJhO1ZviRRl0cl/nB55Wt2?=
 =?us-ascii?Q?5LZfHLkOC9B1NO3STZEsMhWLbdVPRqajt/SIO2WcczXQezt0DVroFuEvGjIF?=
 =?us-ascii?Q?CV+lZU6U1HXXDmmYNI5KewmtTTKgmKvPyu20XuJKLKA/Alu/faZP7YlSAwT8?=
 =?us-ascii?Q?D5XJ9TNyVeKVw/QJMdhgz10ArQxyJmsTe3Q0eUPyCqP4YHFce+5k6Mtgqc62?=
 =?us-ascii?Q?VoUI0POrvNeDdvzOus+ytGLKRMcrbGhfgcjOAUvBtincJu42m5UbSSLdje4o?=
 =?us-ascii?Q?vvN7x1GxIvpZuEliJoJxNKd4XahV6+t78PoGzwCFpyPdgyqOmp6gd0mQwF72?=
 =?us-ascii?Q?Qboz4WcVFG5dJ5UOJ/yTgAGKtPVjhGLacmpHzcDGexmAHr6ogpeDZK9hDmUv?=
 =?us-ascii?Q?t7utUvaYqMABw2ZSPsRnBWR6lnbGC8P9CorSudtfqU8SMIFHYXdyxCty2fkT?=
 =?us-ascii?Q?V4EL9QvFIKaEhI2w+SEhsqbasIxGh8/i6OaUbCCWxZ2Omw6jCVGg3Ghd9Asw?=
 =?us-ascii?Q?LrbHpE08pQyvUnMOyvUOj2ctQj2Fnejkid4bC21xwapV4rPPSPQIq2an3sNc?=
 =?us-ascii?Q?7Mt9qqATarU+zNzwerV0LDxKb21/rFmRaVbrV3zlFEMD9bk62N+Nn/jqiNjz?=
 =?us-ascii?Q?HtsvqYugJJ/iUhF66svdQbRu78FISwhkx/hH/mmNm+tST/uPn+OZHfv5nPCE?=
 =?us-ascii?Q?ZTiApr6KnSQWmjkh6FTaAq8UNSQYsdoYyjUpN72sqrpmHjAu9uXb18gQPMGF?=
 =?us-ascii?Q?thzWCYqJu8EQ72XRU2Piomhq2ilL/jHwDwzpMU+C21CAUxZb9RjcMctM7rIj?=
 =?us-ascii?Q?KZWx4J5dNRhLWC+0zWlEtTHOfDzq7edGwoeTAu+B19Kq7p19XowfsHMEqeM/?=
 =?us-ascii?Q?4HerPXzNKqKpedouUCpQJOrTvojm1gt8FJekmUmqoXmprD84iJ/+0aOhmTNi?=
 =?us-ascii?Q?OPPt7WVg1ncBCTxh1PMGKA2bq7AtwutixSwKv9RMDGUhBXSXR9PmVoIyaoiK?=
 =?us-ascii?Q?NWRBoVZvLe6IvMHBklU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4394302-9f91-4cfc-76ec-08dad3303da8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:08:57.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s6WbSXxlHOxyu+18CfmsSUv22tPDXK6r4++nkpvaiSd2BmHXu2lIA0Gt/I97E8B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 30, 2022 at 11:06:51PM +0800, Binbin Wu wrote:

> > +iommufd_ioas serves as the metadata datastructure to manage how IOVA ranges are
> > +mapped to memory pages, composed of:
> > +
> > +- struct io_pagetable holding the IOVA map
> > +- struct iopt_areas
> 
> The struct name should be iopt_area, adding "s" is a typo or intented for
> plural?

Yes, plural, I'll add a quote:

- struct iopt_area's representing populated portions of IOVA

> > representing populated portions of IOVA
> > +- struct iopt_pages representing the storage of PFNs
> > +- struct iommu_domain representing the IO page table in the IOMMU
> > +- struct iopt_pages_access representing in-kernel users of PFNs
> > +- struct xarray pinned_pfns holding a list of pages pinned by in-kernel users
> > +
> > +Each iopt_pages represents a logical linear array of full PFNs. The PFNs are
> > +ultimately derived from userspave
> 
> typo, userspave -> userspace
> 
> 
> >   VAs via an mm_struct. Once they have been
> > +pinned the PFNs are stored in IOPTEs of an iommu_domain or inside the pinned_pages
> 
> pinned_pages -> pinned_pfns?

Yep

Got all the other stuff too!

Thanks,
Jason
