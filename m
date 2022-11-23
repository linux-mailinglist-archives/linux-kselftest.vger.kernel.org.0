Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3163663E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbiKWQ5E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 11:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiKWQ45 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 11:56:57 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690716DFC7;
        Wed, 23 Nov 2022 08:56:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEDoO4mN+he7uBbUjWqkjfFfyrXUzWVWeKQoD2tghhh5pGtCZoX39yZgomGQh1dz8J2nyA79ZHU6z8PcbuMY0WrJUA0U+idgoSxMaD8XE3s4SXL8v38MO80HxUeDLOBbge0ljVGnYFkMNjvTKQCmtJMqonCL4rd4iTLwwWVgDEGKiOZuGOVCRGtxjwvCECh+tT+MM29a8suhc+pvHrV9ImO1JQZuFWXLMNJvofVOYNwE/MSiuU/KZjklmlESygx1/Z+MaUFonxB8MbJt6bzFW9CTrBlTB2EwUiE6krUxxP1ZYzdWkAoPrAm+JNWxQdN8U75jsBvcm+w4ep/Kw8qTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frzMe64esO9khdvJFcrW0BrF3eypv5jhzpXDyTDioTU=;
 b=bAsnHFLNA0C7LFARlHciMRCZ5Opb/Jwxl+K9e7lBbemB2uJeHS5SPw9hDTO8aOKZxrT149BbO6z8lQu3R7/7oDUZd1emcoBkEcpg4EWQam/lI7eHPb519MIFpmTpSKf970bkWzLKbNUzerDKadjOOAtHhh5cdYuXj0jb76XJh7hTFN4mw89j+Uv7TqEjUKjiO9rvyDZfChkAfcXth9sI1A9kO6gm/Z6pRaaNoCCJ/Onw36Uxvyx4HT50UMnKqJemsGBxZKPMu5WFIF4J6a+uiW/rPdjPywqO2byRwanOtsl29MnePAK4MZgeNINiRROz6Ly30Ny6uZVEinFwuL6fEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frzMe64esO9khdvJFcrW0BrF3eypv5jhzpXDyTDioTU=;
 b=FS/xAJ6tgtoS4WGV6Imhm8UNidk+7MqPdbesmZLbN02Q+LDyo5z3xXlD6SMLuAdZZ4PkG2j9ELTDNGLFQm69yBOYG8W6yOlkKcTC+NVzrWBb0ppPOrBcv+afvBZJ/QUuIJnvTfw1F9nc+JQFV+NZd9mWRwioW6Mn6AWXrW4kZw/PjjIbbWrRBE92O9dux3IBEskDD1lbBjuN95/ZwbOutD5dzPTXxfDRbD1nvWk6XWKFJudoj4QlZ7jdCJX5t2ZKxsHvwUvG/OKf/bJhjIbsfsPC+Z1xmOV8nT3M5nRhz+4oQiVMXj8CXVY9lqYUX32poExo6VOitIHAp2GYuAFeWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 16:56:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 16:56:53 +0000
Date:   Wed, 23 Nov 2022 12:56:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
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
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 01/19] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Message-ID: <Y35Q1M4riY2O9rxP@nvidia.com>
References: <1-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <da5dffaf-3e75-9681-8e0d-4b7402b05b1f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5dffaf-3e75-9681-8e0d-4b7402b05b1f@intel.com>
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef82cc4-a2e1-4f96-e0be-08dacd73b8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiMohi3Fom8Z671Xrm4TWsAie9V62W8lpXyVG9wV5nmprYG/FGIr6k1hVoR2mv9efgwROCwnmKGb/qTRM/9nWoo2TzBApmYgjqy4KOXtxXRJeKy/x2ef2lbUrGqTEPMQhq+Tt9O84ik3fiDUEcIeAp+zfahThQkrY0dUQh5Te1au1JYmw+wIMpJoRCSXLFbHNhmLllg7QhFQLqvKH8dxdL4QTlHQHQTqo6uAFKAEQjAJKbEdfaL2dSks3jdcZaBlm4XBytH7Bh+kH2bYW/qRZuzQ8lFjC73lM24PkP9q8G3UBCO5hZpkQ+6WGC5BtevklultZPWRgBs3QmKhuaCtx2W2inlt5vWijH79lm7Gnp+QX7p1Z9C02YkQ6Zq+gfLNbjeuHwac8oMUDxp1p78DFExopk/hDmNYumB9KGWi+oYVQ8zro66LkuBAPDhyxj/JsOL98QIjXC2U7hYjGsCxcOXq1QntIKPzVFEQI0pQv6F0bg3RfgD7sD5upIZb9s7zXwS440YK2LdZvR1LwGwviqCRiw1Y+6en+/tXAF8Uovxk1zILzuMK6ta48Z+l6iYXeco7zXpiHxEqbk1sif2nFxqUEPHCIB6PzKbnNn/RCQIxg66iHiDvnKL4EF5Ehf+dkmLoCxqWrZHkPlJRXZKcuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(4326008)(66476007)(8676002)(66946007)(41300700001)(5660300002)(8936002)(478600001)(6486002)(6916009)(316002)(38100700002)(66556008)(86362001)(26005)(6506007)(53546011)(6512007)(186003)(54906003)(7406005)(4744005)(36756003)(2906002)(7416002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+gv+6Tnl01Emhu/Pl4j+r/z2uL++/7mbHgGvxOiPte18MGRqxxNZMrIJ4YL3?=
 =?us-ascii?Q?aW8XnfT6apNnS8EZwLRU1FaEIzkfZkPyduw/4lxne4k2zUeBsUvCNx/xajQa?=
 =?us-ascii?Q?VB2PWA4fgDOReNMKvrNDER8m/zK6A3zBLQvCQ8ZI3uoGCucfl+2rQVCzoYLE?=
 =?us-ascii?Q?U3t79pKM5+u0cgf2H5SxZwKMJG9u/zgdlR8u9My9Xgo5n5GgGR9J1kBKZXgV?=
 =?us-ascii?Q?qZzkrXoQLTh+5epGEso7TqNq6YEpU9yztVDC2A7GsvV7ZjoDBLJq91hK+AsB?=
 =?us-ascii?Q?r/6kYy8dHzgrPFjUmThOaVu3zWTz/WGXpGNJPv3JAYiksI+pDNp8L+ynvsCK?=
 =?us-ascii?Q?Q8scvwHZpCt8MMfRR2DwrCyZLPEUQLiYs4QjNWcgw9Xgvp22PCgTUXm0i1AD?=
 =?us-ascii?Q?j1Rjdfbg4xsDEmJ4fOQgHG6v1SlGA6tWL33E3B5Z/IG/4px7Y6V0edFR/SYU?=
 =?us-ascii?Q?szEQ0sYNmIo0hYztcm8KAkMMlZLxFUWTjc+HeTnLreVXaDDCtBiaYR+aQOnS?=
 =?us-ascii?Q?qiZ2jfe0JT6GYWDtdGl3dS5rggcEfPCejJpf7fhXYa2HhcLeAvkVR8ASnT7Q?=
 =?us-ascii?Q?3sTvUwI19Yn5xkuUmV9gE7gK1/m/46LEd1UCmSlmkrOsfAfniUxNactZ5LPn?=
 =?us-ascii?Q?QlBRCTbpljtxU4fxynbhDdFd6lkCND2MJtxbtneSjqXoUwLyUX3dr5cbF9Vt?=
 =?us-ascii?Q?yfIjbvkT8MZENM0JDWNbNiVfCMa3Y4veDcziATp4Piz8eMHv8Pw6jr+m8MFb?=
 =?us-ascii?Q?9TSUmPOAT9VQoTSZrhoh7A2Dsn15nh+UmsJt74WtwxJjszcy6kp/ktjyqDKh?=
 =?us-ascii?Q?MzHCynlgLkX2rp/BMce6Fg1JfRF9wbmFX6eoqfSCkjfoRV+xtawiQycQX3Ku?=
 =?us-ascii?Q?AyFO4qVMfT0YkV8C0vi253RlqgOMZoS9SsG8sKdu4a+ysZuQcuCTPfQVUzJa?=
 =?us-ascii?Q?BVUGsLzoSCG1AUMUowX4/kHDt3+Wt4R5Tu81vagcO9Jd47LsvN7w1Wlpb3JE?=
 =?us-ascii?Q?mh1O66v3n9BEW3FWKNyO9Vls2Vd76qVakd+iO3QFpEJv7dwPGmDVoBR7Vvut?=
 =?us-ascii?Q?g9AJd59Si3lBoyuqM5o7JcNsd195FahE6YjLSfazNDxLK9bmC+cD+agNrpng?=
 =?us-ascii?Q?c60VflAPXoiP455pcLcwilLgX9fPRWySLJCdOIXUEQo7S7CBzDIjSOxMyeCi?=
 =?us-ascii?Q?Z6ZGpohoH5HukKBZcPzJOUbdoQMZIsH+S57qhugUmmUVDDm2mS1CK+cdUMNP?=
 =?us-ascii?Q?ctQ9ufqWXHaaFX8fuu6p4dO1VKCVs/vs8ZZjE7dgy2eHDOaA6OHaJ/7g5kCC?=
 =?us-ascii?Q?l3gY4fmSfcwWZvxetbMFXG9o344dZyPGp+V8OP4Ec0SQR/NHZfqg2OmxJmxf?=
 =?us-ascii?Q?AqhdEiXJDoplWCyxfmLc/fFfKvNLJjZAythzYr1BUjZK+6OqQAFL/NsOUkyJ?=
 =?us-ascii?Q?9iOrWd4EhHLPNBIO+FLIMnjGhNwK4s19fcIfXW6JRvWJzH93wBVXzGVnZP96?=
 =?us-ascii?Q?SnIBz4bR0NBEg5lr5XPZVMBYlImRyX/4PwzePAZUu4+mw3DMWvQz9hoQpOpy?=
 =?us-ascii?Q?Cpand4N3vqM5r3YBEsQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef82cc4-a2e1-4f96-e0be-08dacd73b8e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:56:53.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyeZobsaH6xwdIgRRL21EuKKZMlBXk6rJF5vWGfMbLRgx8q9+7684PgLfrLsm0kC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 23, 2022 at 04:30:23PM +0800, Yi Liu wrote:
> On 2022/11/17 05:00, Jason Gunthorpe wrote:
> > This queries if a domain linked to a device should expect to support
> > enforce_cache_coherency() so iommufd can negotiate the rules for when a
> > domain should be shared or not.
> > 
> > For iommufd a device that declares IOMMU_CAP_ENFORCE_CACHE_COHERENCY will
> > not be attached to a domain that does not support it.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > Tested-by: Yi Liu <yi.l.liu@intel.com>
> > Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> > Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> looks like Yu He's test-by was missed. :-) She has given it in below link.

Oops, I fixed it thanks

Jason
