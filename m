Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C806928DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 21:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjBJU76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 15:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjBJU7z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 15:59:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177C18B26;
        Fri, 10 Feb 2023 12:59:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdjPCzspLehDY2gocL6JRsMNU+3uu0za+0usfyObjP0HFhaCiZsAame5qD9JyTis2VuHPmGCXjdE1W/o1G46l2FigfR/Rw02jc/RjilNQeYKCAKQ7wIKzoRfk7h7AuXM8qizod6hXYS0OhSBtDtg7/2gEr8qwAy8aQqT3zI77AxI0dS/CcHqFz+hZ5wZwFi5I8+hQ5kIsJivlPjP9PiXSQ4wgb8tXQ13opnpS1t+vm6X/4vnZHPSnXYA9VpPLdRlvctHm3QVREHTDaZRYyNftQ49AD1zir0rmvbWmbhV/KH0nftEhjnOHKBCOEd8DGqkBSpIx0DKOJgZ8AfN4M6Yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MqBPY0NrJXvYbTnvD1h5gtXSv5x5hRb+GnOauo66ZE=;
 b=Uug+2eE+fdse1DfnxReRFamGihG+FcaaFbRbD3/LwL12wZ2+AzzpmDl9ahWSeH6e2Kgu8Ox3qziWKDxy6BFFhWUJvtHWdQZ9fVSsHTMBj3CXefpKqSgwv3bWsQnRcRR5k3TZs4qOnIXFQ/DspeADNWwK/NaoaJ1Gs9t98nXrIjP/ZfSaXuUqgRNj/2AUOfQSCCufe5wcS18OjRPsgFoXwumt2AORmefVJUGktvJZPyVqQAZk/sJli3gUdomolBVF2lRqzUIhz8kddVErbNgL2uEb/rmXTg2hLTG7DVeUk1dc+/UN1LP+am/E5w3PKQcuhSTRjxcte11Yr38TSviHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MqBPY0NrJXvYbTnvD1h5gtXSv5x5hRb+GnOauo66ZE=;
 b=ZrQzro/vQEMWq7hisf3wIVgFGlGlcj4Pg6zluMYcvT+xD624661rNJrOvaXGBNkPQrRKACxOVSN5QVpNfDN3rPMlEGOHKgdlNwsS2Px/505fi7qmxuABjUf9Uo5J/AKVhTJFTIlJKe5+GhT1TwTuHVExAAcwcQ0HUYGJja4JB1gz5STmSJplX3k5GFI/MuGiZaWvS6VylC9FyT9L9zK/bf5S6RJa9qQpqCcYXe/VTCErz6FYQiizN60n75zhSsxa+YyZswfZpfSyT0gAngLUCHWg/kLcfGwtpJKF4p+ulDPF4WW6KfiJqnfYrLLVBvA/JR6F1YJleqFEUdEWucjAHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Fri, 10 Feb
 2023 20:59:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 20:59:52 +0000
Date:   Fri, 10 Feb 2023 16:59:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <Y+awR7UO6R2FzHiV@nvidia.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-4-yi.l.liu@intel.com>
 <BN9PR11MB5276F92ABD5998FDD74D510A8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F92ABD5998FDD74D510A8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:208:120::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb2fda2-2cdb-4941-3286-08db0ba9c163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZitHJsM8uhyvb+SePwSSRsR/5ws5o6IroqML6QarHBrw/Jhlg4sO2tSMgvCgNsobRF0bSlEOV+cns3bHLVE7Wd681BS4csCMU4rPwAbhP/Yd2l8ZFE9lPBIDoAvIIreRXtOqEKFt+ld90Bo12xz5M4ZGMSAPnPipS8ZR3mN0wnEGP2ZoGSUN1ebzvjmFT8ng5sJ7ydQliVEKXirYYT+6AwWq/yLFCNbzmetf2nIJYKIBC6fGb26esRJ4wecpteYI9BMMJmvNC9VdX2ytTN9sUDj+B5g/sRbtWNwCgWfSfrcuN5Ntj+io0ozBf6g+Mu6St5gqBir/XIujGzdw3IBShe08Pd/d6jN/pRkhUJmu8ISygoW7yPC0+PudphnxAGlXHsYOUkhKFpBxv/uiUQHrm/z28cmtbrERTCdOxOSqQqFETG7ko7Z8BRQRI+30PFKtsi9BpFxHNf+YVjIUK8zKJX8LZvAFCMQ7UffkR13oKqxSZoNEJZZCJuDlCbGoi+JtVYlhWhuEvtyo3TNsijz83IzWf8t0QT7SS3fWhd8Hsr7yXkUSC+kPEadea3e1O1D2XF09zH82go1+jicd1EOY1u37ZRLTSBjZI1/UGlXzVQqXNU9cQ2VkkrlGGjXkxQuFjoHEu8mITTs7VXh4dtteQLVXoC96tnni21xkgVXfwnyAeddN1DYS6HcNCOYmL74X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199018)(66476007)(6512007)(36756003)(5660300002)(7416002)(2906002)(6486002)(186003)(41300700001)(6506007)(8936002)(66556008)(26005)(316002)(478600001)(86362001)(6916009)(2616005)(66946007)(54906003)(38100700002)(4326008)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j0+7iJGzrMrmzcOj68UmDjYvwSCvXfDZH2FJ4yvQuWh52bg8EGkOzGLDRo8a?=
 =?us-ascii?Q?MK+OPJptT8w77a0XqN85ZXGxqzzMOVSUHR9pWNL/D9wdWWQdBGQjDAYrbNEA?=
 =?us-ascii?Q?stBVKxhGld8/MS3kK9ukv4ZZLeLTCtpU4Tn/3jl69LOP8E5Bb6nvAOHui5Tm?=
 =?us-ascii?Q?O9T+gOF8mPUCp+aU9PZdanDy41Yiai+xWTJ8WkCfvQWnciGRHRxmw3TZ0PMt?=
 =?us-ascii?Q?2SuJbsRCMkgLjYF0O5SgxC0P28wsQSPCbsnf5c6aPI6HUY4xyeFIowXCX1HV?=
 =?us-ascii?Q?Wrs7OgFfqeAt5ly5fVdmicaVK6Z3oHfwLDsaUwZRik4b5S7DpSDAIvSdFHWq?=
 =?us-ascii?Q?BhfZqvzebH+YBHzJuUldsRmw5WWpXekTlZ16NkR6APW6JWkFP/xUl8rr1Wfh?=
 =?us-ascii?Q?7XcltBNiZRE0uFR9sDmq6G7/rrkHpZQrvqy7QLyvXSdW08BAs2WpCfFd3vHv?=
 =?us-ascii?Q?VPMDW9u1tFeWctsn5pgMWYaQvabbq0N7R8mQEQO9xSPB3QsFvOlrCZH31eYl?=
 =?us-ascii?Q?mV5kkp+R/AKCCJXqeMYxzY3x+LDGYfxbAr5FEYQ1La25oNmB8RlQeLayM+Nk?=
 =?us-ascii?Q?oUbPQG2mDbmr+zN99zUGcCxLsrFsmPijm6tXM3v4U4yW1Z+VPJW2UxdncnF3?=
 =?us-ascii?Q?r7IChmFICCl7OeMEa4UrxqXHgSYJ8dYD9HdgDYQR7nHUhHhOPiSl/DqYvYjk?=
 =?us-ascii?Q?Jjm88zMaFVx+b949n+URsqPDGLMZkKW2mr2YTu+K4kWZsZdBMxtuoVryPJw2?=
 =?us-ascii?Q?r0Qz/lVsMS2L3LIt75t8v8t5s7TtL80qAKqB/THA1Wof8fcu7kMgaMWZh5Ud?=
 =?us-ascii?Q?nWcCwXtsgvlmvOYZcDv9c70qVduSlnABLCdwAChqcThTGQqLDi6rpxdtlsPY?=
 =?us-ascii?Q?/VzrX67jyJJm2G+hIYV7wdBvA8sbtoDds65CMjrU7IwpdC2AZglVhFv6dmD2?=
 =?us-ascii?Q?r5OIxFLgDWMaux4XoGxwIWr4H9dk4gjG1PLjJTrm0h4wWGnSgIlyVNL/4nm5?=
 =?us-ascii?Q?HX5rTVKMGQaFFMmOcgQOA1Ynyg99TdbfWTX8ZVy1pMIPmclXqJrPCj2AexZ1?=
 =?us-ascii?Q?Zb2+rC2P+5tLqXawGOnrJTHWZJmKoG9vzoiwvVEaq5hSNABtp3Uodk29xHDT?=
 =?us-ascii?Q?g03G2NKUGJX2yQRzfuThv7qQmTmB0vb7h/SzbIwjNBZzKzuvDsIQVn+jcqvG?=
 =?us-ascii?Q?/UT7rE/KErkiIbDyA4TmMdm1E89Go/zuYOf1tuzVyrA2UEIeJH+/Uyrnw/Nn?=
 =?us-ascii?Q?WCM3wfKJafH7bqkJ4Mp2dOsONxCbV9LRuQYsbKzzE2eZmi+zH4j0ZSMsSBbq?=
 =?us-ascii?Q?VpWh8GyqRRyVIVadPVpyJowWuQ03A4qHY30xfGq3NFamh7yJaD8fZDG+8i/S?=
 =?us-ascii?Q?6tlLf0t+j1QPlAHgmJY2r4yfIODWCxfSvnvRSw0BhYELfmaJxi2TItp+0O6n?=
 =?us-ascii?Q?Edj2npJPNP2Ks7PvR3NcdgQpE3p0lGLP1q306yKi9nMd66XzsFPPdanFxl2Q?=
 =?us-ascii?Q?WKZUOeHlJ9fiD4pAWxN6fh2eQw2NfBFvbSb/nMaHYE8Dbs6A9K4woWS+1uDJ?=
 =?us-ascii?Q?K05crg43W1Je6yiQZRt+y/2FS3zUhtwwdKcK/yAT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb2fda2-2cdb-4941-3286-08db0ba9c163
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 20:59:52.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i6oXhuvVt+ptNmJLlvwd+yjdh2NVeIKJG3bv6bLLEaNzWDBMRGggACNO1oxKlfu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 07:55:42AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, February 9, 2023 12:17 PM
> > 
> > +int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_device_info *cmd = ucmd->cmd;
> > +	struct iommufd_object *dev_obj;
> > +	struct device *dev;
> > +	const struct iommu_ops *ops;
> > +	void *data;
> > +	unsigned int length, data_len;
> > +	int rc;
> > +
> > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > +		return -EOPNOTSUPP;
> 
> do we want !cmd->data_len being a way to check how many bytes are
> required in a following call to get the vendor info?

There is no reason, if the userspace doesn't have a struct large
enough then it also doesn't know what the extra bytes should even be
used for. No reason to read the.

> > +struct iommu_device_info {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 dev_id;
> > +	__u32 data_len;
> > +	__aligned_u64 data_ptr;
> 
> moving forward iommu hw cap is not the only information reported
> via this interface, e.g. it can be also used to report pasid mode.
> 
> from this angle it's better to rename above two fields to be iommu
> specific, e.g.:
> 
> 	__u32 iommu_data_len;
> 	__aligned_u64 iommu_data_ptr;

maybe call it hw info

Jason
