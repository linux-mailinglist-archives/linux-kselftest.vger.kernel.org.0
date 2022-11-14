Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B056286F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiKNRYj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 12:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNRYh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 12:24:37 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF99B3F;
        Mon, 14 Nov 2022 09:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnU1zE4lYuLoOUx8b3gOVBmokoa8iP5Im/tCdNBjtY2T9hzEX1ktPFJKBIiDPFG6Bywr0XiGLNYO3froLSFhOBuDK92DD2jMexUws4OIFO8tzSD/iCoAtg0VNjQzm+xGYEBFF7UWUcmTEV8DeVxaMUF+Sx7YJG3NbZ5+XmWcLcCg0sCWV8H1QS/61blnHN1j7P5RKrZxezo5V7NXTyeyxq+X/isb7RJyorp1QT+mGO3T5rRBZQoYDAQ5yCQn5t8j2/LC7nme8z8VabEF/vs5rFhI/VrocQU/E7644sMeRPdJgPjvGg1Fq2StxLTIorqDfnCC5pKg4M/hnKDWai3ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwIOB9zB3MavKCsJ6S5ofGsfkj1j8MBubPux7SHcxmQ=;
 b=XExogWWYo8Lhm31X9rC4PT4Tw8HdDWKg5pVQ4Gg9Cc3UsPx10NetluT4DivNSdlQFJLiYB3XRleRyKuUzP1IK4fzpw+MiO8cLpgjSE9v2p5t1rA9qgSWc5aCa7ZqGeiZ23Cyz6GpNBqUkwvl8NsNWcLZ/eQNLPI7cRhSBstnll/9PEqQak/bjp3FbWsHZxWLz5nm6+6zcQz3uxcyzqJsCTa/frv22/dlMpePnaDul8lVvKMn0NwLDzY0pzTykMF2hXFUK/oZOfZFJZ0g9gWy0dHZpA6QaXW0XV9ICnAaQab3zty73xPXUqFj9MMstBXpQIHWgd7WQfeOreMOkdeprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwIOB9zB3MavKCsJ6S5ofGsfkj1j8MBubPux7SHcxmQ=;
 b=R8zxCHkIafe4T/T9Wa9679rVJMEH8YnWZUozCrcp9PXRmkdjqPDkj8V0d6kZqoiGaxL4mWKF+cy84cStTGaiyMMiyGygS5/KMxkf8RP5iKvOYN3B6wWDiKBHdOg333+EdsP8uOkUvnObn5jA31KIXL4bKeki4xYmcU9XoIU+Ke359FENKGFnrKBLUv1echvbfm3CXvSofdTtAXKBwdYl+vKagal5GTaixvP/NiajpR9Mp1ZpzY8AkauuboE3g8eKBaxEXQokUmkkqG3Rmrn+tE0bp4WJfTQO5XpfUxry5asdeYqY/at7NT7RLWcr59rjcOZmsTqhpa4VEmdD2GGhEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:24:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 17:24:34 +0000
Date:   Mon, 14 Nov 2022 13:24:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 07/17] iommufd: PFN handling for iopt_pages
Message-ID: <Y3J50bvzPallqYD/@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <7-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276F9A4AC8861005DDBB3A08C009@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F9A4AC8861005DDBB3A08C009@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4417e9-0029-4cab-a89b-08dac665190c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TzekCX640LuparpjKHqQdUeSVCgRlxHF2AV1OXh9c3EUiXaZTOGwjqIIFp5+ucrrgLFbP12rh6yzcn3GLgn+5VdHpo1LNRS7Ho/v71bhO/oTgRsq3teQCO/Bxv7O15+nU4jXoJu7O06AYE38rMLJ4PgCvk/vS7Tjz9eUlADCNX2myQA4iDoRb2qzHPeZh3zgDTKrvyvAcyivyi82OzdlrDevDXXlkUQ37ppk6sCaa6JhJW8YxItdEv6RIlrgfqBOIvh5IkQjVggwamm2bp4zVnnGdY9+nXNNCLFmPljeGt+2TU1yFMewLPbRB3qyzdE0dX4GyGUXz8yzbUYrccdXERslXWgcDSFeQnyurYFEmGLD1ZYvGgOTAj6wkzSPq5JOrDWPkvSiYvcJPJiR955xQL28lXB5o1ZlBplkPyoPgu3OFJBV6HnTTQAzqPvChDywul6Ck6rCAwfVcvSCLuuYjeOfkUdz234/J04W3lFZuaSmXBLgLaGEoLg5hGZ4kEzOeYXSRHFkto9AGnJgRCBxx6lPn/I3vwTPDVhp6biqZm4mrbdhmHNcGYpJpTgXHyPAyXyb4G4HV1WRTnIn4dlClc4Ov5D0MKaGRD/nqS151531rF5Tw+On/A8drlU+LD8VZlYpxI9DHOkKIXIALlwtPRm1YkelZ5fb1Yx1onAuBwfgIR3L0/ZwOCFJQOH7+M7edRo2RowPEo34FuskgjDdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(6486002)(8936002)(4744005)(41300700001)(38100700002)(83380400001)(7406005)(7416002)(478600001)(5660300002)(6506007)(66946007)(66476007)(36756003)(66556008)(186003)(86362001)(6512007)(26005)(316002)(2616005)(6916009)(54906003)(2906002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtZ9hyF3cUStlJxerCqXAnkfwst+5XDJWJVYW0YVjarr6VY73Yy7PkjA3BFi?=
 =?us-ascii?Q?/FUV8oOu0b4fQLw0i0Rz2URxvKbPP6KWYwQgs19mcalNypGqHFYNwnE48aNg?=
 =?us-ascii?Q?VI2OKygnITNAHhnwfBY1b0eYGoaezTB84ltja95d6MS9pPT1ABjjl84FzjFj?=
 =?us-ascii?Q?/MoHDxrwrLBn2JFn6uixXPgXwesdJnUxMpe5Vp+G16zgF/AfvfQNwTggTqdz?=
 =?us-ascii?Q?bCkfq+woN/w5/HnmZ3uHKcgECk34zmvC+ZKK4R7tdnvDZ1NS2aBuoVqDrypI?=
 =?us-ascii?Q?9aQxe+f7qOndMI/bZaIPklx2zcqEIZ/qKhiv9ehwviFxZKw+vtTDdBUGA0ve?=
 =?us-ascii?Q?b9ZGCMkBlPDlhHwhFKs8sUpDxhCTGfJMz/nIihidTt/H86mclGnenCtLhZ27?=
 =?us-ascii?Q?l72nardboudLZnXUgIkuUvHHkeh4lL70idgL3XRCfdEkIgyYcEVKNPe/ODED?=
 =?us-ascii?Q?Twb0allteHRUQDuGVaNB2Lo1j/L8YFjNNnrfHVGCf90v0goCzbweP0i+4vmW?=
 =?us-ascii?Q?OkyG2D/4mcmTboRbLgTqByNHMblPd6FsUxRyK5mwiJ+kUckrHWSTb2yKUg4X?=
 =?us-ascii?Q?dgxcIv5ven8QSwlqM9TNo3E6dSeIrcHS7It7ZXduwOmcZ5uM3r28msf7k+5d?=
 =?us-ascii?Q?ZlD/s1I+Dnv61EGqIa9WDwrepXRwU0C8U5jd/ZsvtK0AuNh7/8W9B/pQRool?=
 =?us-ascii?Q?WpZtmmND/9ld0vIPCxIRqNzEY5yZYvEjwuz4L4glprIO2TGY8zXmWewbGsxz?=
 =?us-ascii?Q?fmhQgDx4XRn+f4C0ZzbPP9acnnVpaLry5R1eSZCb08BUWkRxnHl1sE9Z/0q0?=
 =?us-ascii?Q?EMFiZW+6k3lgCrOcIFIMQxWvTBWl97YO+DPebgcH2xFRJ5Os0mI691bc+ySG?=
 =?us-ascii?Q?Jg8Uauw9r0M0v0aoqD+o1WW/d+N6luQYOJc2jxfMIfF6BNse1IOA+NRChkwh?=
 =?us-ascii?Q?nEwm2W+ZTaZit6IDMnpa+/yQcbnnlf6XvxEYdW9LBdfg1KOWJsXShDKzbDsf?=
 =?us-ascii?Q?hILX2wGF9ejesokf/0QsqNVElSiwm4K1owJFLOjDGw2NNHtTmPrdeZ8fKRAp?=
 =?us-ascii?Q?5hZ7woUAgXcgOdVcoa/kug6dEQWL4jB6S3HcqC2SCLwP8bD4lJybXARkLXN5?=
 =?us-ascii?Q?+a+fe3QKM62Apce7d81LKjJMayfn3xD3VgtRTjXR5LiMV3x1G9czKCnUD9u1?=
 =?us-ascii?Q?3YPi8H/8stL2bhxvcNJpoE+27x/uS+3vkiPsZWrbLTZvdaXB6AxEvXUsCMsQ?=
 =?us-ascii?Q?MVeqkZ2PegE1SoyHYkSdxi07VT/rAarN/68U/MSMLDtdyaEEYnApTLcGQeE/?=
 =?us-ascii?Q?0kric4zyHOqCvkS5Gpi4o1iABnCjd37JCxRQxpc5s5QjQ8YYYQwenpYutjsJ?=
 =?us-ascii?Q?BR5yNFzDFQK6IWeLFpXHXq3TnJ+zvVmUHg5mgtQ7HqT0JaV43sgASd5pWhCy?=
 =?us-ascii?Q?rzCm8t83dYCsynWNi5UYuPagHTK5i6RcvFFMzdE98zGqXjYPIxIlrFPLV761?=
 =?us-ascii?Q?2BDL/ad41V9lGZp7ZKZV9s3QQGQ4Lb8k1iQQjG8KWQmBkNlVrooNKoC9s9mU?=
 =?us-ascii?Q?8kyuLDvS8bYNaVkrEj0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4417e9-0029-4cab-a89b-08dac665190c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:24:34.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrPjOpYhpz0irUXMICTjHzZg7He2DtPZwQ79MAdore+hNQxjxEX1eH5G27T0DMI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 11, 2022 at 11:09:08AM +0000, Tian, Kevin wrote:
> <...2nd part>
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 8, 2022 8:49 AM
> > +
> > +/* pfn_reader_user is just the pin_user_pages() path */
> > +struct pfn_reader_user {
> > +	struct page **upages;
> > +	size_t upages_len;
> > +	unsigned long upages_start;
> > +	unsigned long upages_end;
> > +	unsigned int gup_flags;
> > +	int locked;
> 
> document what locked==-1/0/1 means

+       /*
+        * 1 means mmget() and mmap_read_lock(), 0 means only mmget(), -1 is
+        * neither
+        */


> > +/* Process a single span in the access_itree */
> 
> in all storages.

+/* Process a single span to load it from the proper storage */

Thanks,
Jason
