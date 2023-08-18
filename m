Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B27812CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 20:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbjHRSVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379425AbjHRSVA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 14:21:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555DD1982;
        Fri, 18 Aug 2023 11:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqrz77RSpoLIcL4lpC/4l9TlFdcgKeEz+UxjTcIY7UZHwLPd/TJ6A5ROQJMLZ+ucP0qjDBN/0jiV66HGoRH449XiBK0TPGj0jBN3s1zdqfnZ3QFz1f4sz7GLzlO6yNacA+feB1OSrvd1EyYndAPMJX38VYzjFH9xfJr+Ekbc9rLfBR5HL7oMvys075Hs0sWInwYGxTHmpnS0x5UtCUK+czUUUlDfagCMIIPNwUWucPKxMV5JvI8B5IINpRDx7ihpKbAANFcCx5VOJTOteX6Q7dWcmTQMGvCjAV0D5nqAbKaiiEMAZaeHeAIBe7r1n0X7hEq9wuDL2yH6N9oYBea04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuxTT9iHrZYenLY+VIMaYg5Ykkh0m5Xkpjnsn7XUwDY=;
 b=iHHrML+ideo8dCUixA+DRnLe7GaKVnn2JAyjFgAsL5AxJoTNZa3wt7uG6JgpbSemuMOuIsl6ha54WSftURTzJT9JpANnMTsvYklpReMQO/sS6CLXCJmUXeenasE288Sh9IhKWrfObRjkQAWCyJ/kkWA5ndNLXlyv5jipqheeGmU3ceMYEdYtdjLY1AQ0OrkKHTx5XyEEkIdghQyC/wuUYwRLuEm4O9rHEUTFKWqdTcNetPsRofhaGH+Vh3z5EEsFsKhhED90NEhAEG4pcIpjWdC87+FQOX7FoOT8hv9x+98J00Sc0kaY4twaFgIqklIhh450TJH2c/Um9J+eqPEd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuxTT9iHrZYenLY+VIMaYg5Ykkh0m5Xkpjnsn7XUwDY=;
 b=CE+1WTQtG9rIOy5nfRzN4h5Iuyh0xO7YQMQQ+sGF87I3C4tqwhAD7xxd+frmUw3p0GZNIST+mA8iLzS8LPaPNvcXJYlhLTyO+WM64T+jzuu3g+tnpnVVFLZAXV8nz2luvyypYtvUBvi8tb8Xct77VjVCsd5XNua+ARO+dQ6p9ikNLQeBqMxPZZy44vclu9sgrWdWuzCWdPLWtfJI1WPp017p/WMew3Khq6vw/9y1Bucxcmt6m+Mx9cABYn+YQK6UvX3zYH+cczPg9IUF5Nfo0Yj3J/it0V2b82M5VsxpZbrQF5AVjpmexIXqaHvzZ0c2PoCjvTkM100yqyl4Nj/M2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 18:20:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 18:20:57 +0000
Date:   Fri, 18 Aug 2023 15:20:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZN+2h5rpTUI5aG3M@nvidia.com>
References: <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com>
 <ZNVQcmYp27ap7h30@Asurada-Nvidia>
 <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia>
 <ZNsYxta9Pi7USDoR@Asurada-Nvidia>
 <ZN+i1pEoN/NsWPKS@nvidia.com>
 <ZN+w3fahQpM2W9Yx@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN+w3fahQpM2W9Yx@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:36e::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 391475ea-ffed-41db-2966-08dba017dddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TheGJsBxQNYoPFDJzvXypHEorpo0P4ZNWhQdaAgs4HcxFXgKD37RD80hrsDzvFLB69+OADn4+icWEsnRIGcLV6CM12TlJJf33gpYa7MtcW21y6kjPu3vH+rD+bC9H4r2pQBs20WgEAMSwnbqkMy6DF6Lhit5XyEpoMQALGBz0XkgihrgjXeHUidglH2CsrBl84q9czL/qHtZ2f4UG3ldJX3qzqOtTyj5SX9H5T5xl5zFpc8WDWEl+tsa+7UtpZdA9NKEmTVySTOWCn9EHJEaH2VpF8l7EhFyU5Pr+bEuFeGz6oRURxYsI71CtWw4npL/xmcC5NdGuucWMsqpxgYFQxi57wziZwCxeY9Z27TnjVgDNBL63GnVXL22UjdL1llcrTnFrcbZB/a7vNpokc8wbBTa5xd2hKqW57SdB5/R8HwFhpBKnig/VH4quXxxG81EN125UkimRBA30UqHCcFLoIn1zM5JKyFTLI5Fy9U6EWgvywiDa6sGTk9Ksr7nqxGcpFoM/8bYrb16tgP5Ved8BKe8sdzWaSlOYvn7jX3wVSIFt0A8GZsGwPOzMA4ED2DQd8uP/0BOaZRCymBywP1rCD3wELCQBmx/qjX7OsJ3EBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(66946007)(6636002)(66476007)(316002)(37006003)(66556008)(54906003)(478600001)(41300700001)(38100700002)(6512007)(6486002)(26005)(6506007)(2616005)(4326008)(8676002)(5660300002)(8936002)(6862004)(4744005)(7416002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybfnfArvabBUEXDBiOMGHGztdWJmVSPQYGU4GYtvfiqk4/M8uSrpLEvkuzyZ?=
 =?us-ascii?Q?yB5sxDmRwSX+/jzQVpW9xw+Z0b4ICnpnRnFy+Nz0JlhCiJock+g6W+uFdMA7?=
 =?us-ascii?Q?+3dCGJyPGewDJaQMpXb+F0A4tqPNodnphJezD7xZmzGSX/4jw2VRy5Oi1mUT?=
 =?us-ascii?Q?aZSxI1rbq7Vc4nTqGw4NVKlm5CNrNqZ5tJtqm1n/hHjaud/bAqpuq9jo1Of9?=
 =?us-ascii?Q?OWyMEpLch9AB9Ib5ZYx/j39cTiky3t5J+jGFuvRQJg+JOSM+AaBTHCSF06OR?=
 =?us-ascii?Q?SHNHE5wuYHjm9HRBm//uDpOFQhS4biGtob3tuH/MMxDgEdTO3cDT8C8AwwnC?=
 =?us-ascii?Q?4OyvQpvuZeLJOb1101gTc4MykVslfFESxUCqIQ54G5YMwTVo08CRm8jNrxzf?=
 =?us-ascii?Q?sR3qT63Uk2/AikVOkv75sv8ptUESzQDo8IzOKuB7QYGBqCLxjChln7ws1jrp?=
 =?us-ascii?Q?1SKuul2Mz0WVdFFJq0YpxYwr6HybKYoo7fLi5TpilFxJ+in/OwQy3fXtly8H?=
 =?us-ascii?Q?3yQmN/yHRE9MnZQQ0exEwOkjxGXB4Tl6h7zgzC8WS6ZvZk8zNwDXzHmcE6r5?=
 =?us-ascii?Q?+I3njymZcjO3agjydN4RlQy/4QR2wW5banuw8Cb0hl3LWnD2ogPiWLKNDDwr?=
 =?us-ascii?Q?X8owhQ+EnNUxeU+O4dZp6AUaroJcCyGu0yfxizV2TfCK2epMcPTuLFTKTM/y?=
 =?us-ascii?Q?ym3eIdFxaZJensw2KZq935h370llfF06aY7DFOdERsac0mV4A5j6uMSpRQcA?=
 =?us-ascii?Q?B8+vsH6FzndIMiiqgyq+hisUJJG+5gz/V3J6DjCCzhxKmAoRAjFTNLtbgKPj?=
 =?us-ascii?Q?A/tBAV+ilZst+f3FwnSEnAW69/bW3Shi6dFzx+EeqxY2juyuLMmaZTWmvkbI?=
 =?us-ascii?Q?Fu9hsLc9LsH1VVpRAg37UpRGPpen28E4nTYwnoOzh7WoRsz7yAZ9IKzXqDHz?=
 =?us-ascii?Q?YeWo8SpwUrUm+2RwDtV0W4uvjZZkhjH51diKwpmYaNfttpac638BSgOMLiug?=
 =?us-ascii?Q?lif6Ky6wDpKFa+NMfpURreGnwov42U7ep5NO3RYz9J9ixcqx+QqtVi5DKYlf?=
 =?us-ascii?Q?5BFBwdrkr7SsH0uVgCxxYOuE40HCsV/RsJYacG7VlgwT/KyFCmvHMl8W/D/n?=
 =?us-ascii?Q?SowUdveX/ctr24SkT58Gapg0qpqM3Tdq9HUHEpUELFtHc7ZMFxpVO8FovEqD?=
 =?us-ascii?Q?/B1jiESnCi4+hCQmah4lF67hiwQmZ74zDAacZFavx4KGtT/No2BaeucdNd8n?=
 =?us-ascii?Q?d2OnO8VhedRy6aLgwijq1aBjpjmYI3q/kshgXwgGipNI351vhUBElkBVOItd?=
 =?us-ascii?Q?hnDBE2giU0s6yuKlvnk5is6p23WJxLcTyPOknH9RuFxwl92pGny+ApOtqbq8?=
 =?us-ascii?Q?TfHnuGv0NJsH8vfgDAO0f0ZpcHj04dx5iuNeeXjVLuDnA/6BO1m12aNDuRoV?=
 =?us-ascii?Q?KRw6kUOIdOHVi3O19hy02vrprnrSlmeax3UcVmnQsv49P4ENpZhM4+Oey1v5?=
 =?us-ascii?Q?FlIoM3m1/0DT/9dOPpPQbICkb+PDTtomozW3F8Wix1CMsDuOihvkO79v+wqq?=
 =?us-ascii?Q?00vYWbKIujXvCk379/tcNG6xJoxXyxw2KGuT777H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391475ea-ffed-41db-2966-08dba017dddd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:20:57.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ohzlt/lQnmfMc5BF8iTv5z1MkJilpi2wJKzZwwsuNUyLUNgT59XJ6kGbdK+xt6mX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 10:56:45AM -0700, Nicolin Chen wrote:

> > The highest array index sounds generic, the error code maybe is too
> 
> We could do in its and report the error code in its raw form:
> 	__u32 out_array_index;
> 	/* number of bits used to report error code in the returned array_index */
> 	__u32 out_array_index_error_code_bits;
> Or just:
> 	__u32 out_array_index;
> 	__u32 out_error_code;
> 
> Do we have to define a list of generic error code?

out_driver_error_code may be OK

Jason
