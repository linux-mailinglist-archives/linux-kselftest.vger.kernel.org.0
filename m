Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4154B628399
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiKNPOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 10:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbiKNPOI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 10:14:08 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5400EE3D;
        Mon, 14 Nov 2022 07:14:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz0vHMsn+QuwLQovMmfndFQRv8+O8JZFQImWYtMssvhuOoxnSe4zBKOMrMEUGPN9g2B3OdXDNJCMFCC0x4D3wlI9R93TU+qdfZvw9rqoheIU+U4ipHAUhgkelnwAMwH25b7VYqbwjYIzu0GV5sVCbeQHRaR1gI3jKG6fmq9t1BkrkJUDJA7n3qhMXxAElV8ovGsOSshdcL++uhDVYqQL25Th9klUjEJovpNdgHuECWgKMq3GiVEoFDRHvnSFKqjzSLiBlG14Q8jaoyRTn1J5aZ4fJ8OrlixgVBqTgb2egzqPw1lIDepCWulHg0tBbrd1jk2u7nS+rrjGgjVA3i/dRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+yhSh4A11RVPcltH0h9e0n4a+SksQfuOHQTwWR1598=;
 b=ilMnoU6QweKxLx9Sm4/GJLfh2neHNQe+hQ3RqtjMkG/0uACkHAngIDjiOjG/WYNdz8mff8WpNmLHsrE/yS+y5Nj/sewyifYT0/iu8q/Zb2p1+9NlUKBw2Lp6/5z+IEanV0q08gBlzU+kRijVpH0bU5/Brmy9JFgTKj3ANO4UlTFwzcPZDFMs1ZxrMmQes6LQ8tFmTP7e975TK/vZdI8M8HLKln15eIEtUzwDVSEeb34miu4ErBX0uw5hkG+ufu4Ig+NQIorl7pDqf/U7JizN/9CQYOvGpGjnMpVImXusxeAXCpUufzza+Q+SVFR8rX5yNifIyS5sKm6IaVkT+AYwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+yhSh4A11RVPcltH0h9e0n4a+SksQfuOHQTwWR1598=;
 b=t29i/30rz4apnPVy2xK74c2NCsxzJPnE+QG3hdoW2nTmabptC8EebaROyk7pTqsW4AoI8cQyyacBBBVYSNHaje7DljaEDeIgC1mUwop5y7F5nb5aMEAAvUHBuL68Ln1rFQ/nSCJK1AUZ7wXbJGIAuI8N6F526ipPKvVgqzMRFgXoC3lLxeXnlKT5k3iz+ChK23WdfJljyMvDE1u67H3MXthIRGxnh5Pz1P8xN9mNjNxzD8/SY9XIx3u0xJmT8fA8d7WtPcLf+z7Hi4M3s5niq2L8lNkpc55UWRK+TqLNuN7C3/odaCAEr2SG67DIuea+VnmbQRUkkY1tCGZybgQLTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:14:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:14:04 +0000
Date:   Mon, 14 Nov 2022 11:14:03 -0400
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
Subject: Re: [PATCH v4 4/17] iommufd: Document overview of iommufd
Message-ID: <Y3JbO8kWgecr2csN@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2qNaNfpBG3dcBV6@nvidia.com>
 <BL1PR11MB5271D83054967E20CFB937A68C009@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271D83054967E20CFB937A68C009@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR20CA0042.namprd20.prod.outlook.com
 (2603:10b6:208:235::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae44126-0315-463c-c88e-08dac652de36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez+yRsJq4/GbPm29SM8WMwy9Lbg99RG41K0Ci6TDR70dllRu0DwRN0E3aRQn9VweTwUiFtEhSc4/q0tjaqFNbrTzcjGJyh8zFuzDWCMZhE8qAuvX+7Zg5xSKUhKlnkF9N4eImPI7A5aYJBbZeKfEPV6Fzhq5Jjkg3CPTYy/m+RqnmDVR2kJLaHDtjBY3WZEMkf5Wm15IJkGzN01KNtHQ7Bfv1eH41QnmztJ8g173+02TTsekjB+hCc52eug1zLTUf3CLWqtXWVNjGMfuncEX/jXQDqBkX75J0gtCh/JSs86HbDwx/3YgXfZ0XS+MIsYc3GlSunYthh19d62/ck2RA+gyApHa4HDgdJY8L7Z/BmxjLfPt018AjF4okk6pz2SeuVmBf9JPGoTecZ5iEqi0puvJMwoGpXomdLBe0m8PR/c7z612L+4co+rSnoDdlJf+aPygWx5igiYeUvwRObuJ9g8MvqOjLs/3LjPBCBWjoL4P+OieM9TxRyeTKFteoqMe8hL2p9mDLI9n7huyzxsHe5vi24e0+c8JLYLfx6aJFxgNKobWMHB764h0lTStfDjE/J4CBAyH5uXcmq3ahFOQ5yvp2xApquhGbZB6fTHhyStpbC9wmhv05YHBHrzKnufx0dED4F5yeuZPIAiETI2T5nCjiqGwe69Q4EaPZNKCZODKYjLECcnxI0p0a20Xs92EY5C2mXJVNJe5QXP4st40RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(8936002)(2616005)(4744005)(478600001)(6486002)(54906003)(38100700002)(36756003)(7406005)(41300700001)(86362001)(7416002)(186003)(5660300002)(6512007)(26005)(66556008)(4326008)(66946007)(8676002)(66476007)(83380400001)(6506007)(6916009)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzJvQZ0vpTB4LyerizDgCfJBPnKwk9w7y4EvLxy1BOgDnG3/oAPaDXRN9/qo?=
 =?us-ascii?Q?Y8aWXRomza0uIAQV4wwU9Mb9+VZDYTYAb6SjxejD3p+BNs/V9PCKlfTD4WSs?=
 =?us-ascii?Q?vU9QL2F812EIQnedpf526Rnx359oxnLhACBX9ubISCUqwpms2fEI2/GVjGrQ?=
 =?us-ascii?Q?HIrzrAzoqeZ9F15zIo210K7zEkv4l4VjpobFSvspEqBY4AWqtOOf7NBMsQGq?=
 =?us-ascii?Q?OX3quo86kS8ydibgRLno5mrUqHpw1DOr46ZQ13Kqz+j/8NGg2a+2jDVHN9qa?=
 =?us-ascii?Q?G7Oaxa2Ubdk3MPF00gAFZ7MJiDlhpr58kOsNbAAzJd+zyYhj52m0s8Gx6EA8?=
 =?us-ascii?Q?UtzFcVPBNKVGDFZZ/9QZbFoBDMCY6GokQkuDRW2XnV8lorTClrpNT1ZMKyPz?=
 =?us-ascii?Q?TWK9SQA6hM5TGS0ZwYs9LtMrwEP94y6d8Gv0QA1gk/Q669NhmkK79eSJB2Ei?=
 =?us-ascii?Q?OiLgJjU9Wi8Js9r/sK20nzbqL0L5Nb+uHgnz1iHaEps1vz5cN5JdeNWZxqT1?=
 =?us-ascii?Q?jU0S6C8PwEmmJQZiMOC7XGOn/SG45DBhukg94034P3Wadyu+jkEBWzBaF1+t?=
 =?us-ascii?Q?c1iwDCq78RWMtRHJNTErdPPLltEYhWVN9S6fU2kw0j4PJLljPRI5OHGkzFvx?=
 =?us-ascii?Q?3NLTR3rG0TSi7FQpMQvxjqoMYmbS5mvj0dS1Sbf3XYGoruRa4XH8UguUA2g0?=
 =?us-ascii?Q?8Y/2w60ce9+GS4MXl891GJDPXzfGMC/nICt4y8Srfd6QgNhUy21hcUUpBrg1?=
 =?us-ascii?Q?j2JOjRh4TEFZsXkLM50+lPqbMF4h7dv5ccbQZvnBKQPBQ63cpAzQKRIksN44?=
 =?us-ascii?Q?qpq7x2CSTSLW41Y79w/ZzfP9DG/VHmV1PNmGgJcb29GedOTEUSSgtqzz8uZk?=
 =?us-ascii?Q?GuVVTRd+xWqgLKsjHyU5d7jSdP4veesWcoDpVSLPM96dZimtP34MKBctLE4i?=
 =?us-ascii?Q?rMCb6yxRzBRA3D3PqFSGDEQMmMpoF+orCQd5nm2A+15LZKam6P6p+e9UFjGI?=
 =?us-ascii?Q?DdWcSrtWWG24s8yz32ABMzvA6WhbrJiLz6z3IALiDkMS31r39rlwau/Ip1UO?=
 =?us-ascii?Q?sGQnq4e2oEBU0FQ8aBj8E7j5pw0i2+a6MfN+H141bxYF187hCqLYzoKJsYbH?=
 =?us-ascii?Q?+RC/MwJf4DB78JgNYB0M3y2sO8xUSTok3rGPNU5QndyLbT2w5KVFsAdAzH/x?=
 =?us-ascii?Q?TfjMjrZoXHVp52jsv4+t9gH5MhGHUq0+n9jQwjzvl9oLg45BYeqk7n8M1XL7?=
 =?us-ascii?Q?YARwKs2AoH9YlHw73/fOGroiqJudjtXzJiulQV/rJeICtBd9MZM+fH3KnIQj?=
 =?us-ascii?Q?kK5msqAKWAydzhz5TyVvKlugKS79oUGBJd8UVswkAI/n8g3YTEpNu3l0mRAb?=
 =?us-ascii?Q?eUAoVQwcHduxSlX/R3mnG1lpvTTc9ZKd1eRH0Sr0EdysWYbRgV2sPi8iv7Ea?=
 =?us-ascii?Q?xXxNRgtZfAU8qFZA2BauYT3q0vNOeKrA1I47HKc7t0zAKjKR4xoIzWKvH58C?=
 =?us-ascii?Q?a/XhNOCS7IzVWQ0zo57ItPtdFbl7s5fb99yHG+OCbS3al5ifEVuii7yrTS7A?=
 =?us-ascii?Q?gNVGAdw/0fRjV/5iF+w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae44126-0315-463c-c88e-08dac652de36
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:14:04.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IckimW+HCyU3xS+YWsT2YRmchM34sEkwy+sGFjFYcLb+Nn5E4bch3xVTNhPzBFO/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 11, 2022 at 05:59:02AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, November 9, 2022 1:10 AM
> > 
> > +/**
> > + * iommufd_device_unbind - Undo iommufd_device_bind()
> > + * @idev: Device returned by iommufd_device_bind()
> > + *
> > + * Release the device from iommufd control. The DMA ownership will
> > return back
> > + * to unowned with blocked DMA. This invalidates the iommufd_device
> 
> unowned but not blocked DMA. iommu_device_release_dma_owner()
> will decide what will be the state then, e.g. attached back to the default
> domain in most cases.

Woops

 * Release the device from iommufd control. The DMA ownership will return back
 * to unowned with DMA controlled by the DMA API. This invalidates the
 * iommufd_device pointer, other APIs that consume it must not be called
 * concurrently.

Thanks,
Jason
