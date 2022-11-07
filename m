Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085D61F63F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 15:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiKGOiK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 09:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiKGOiJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 09:38:09 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F192C6;
        Mon,  7 Nov 2022 06:38:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T//LAGfIFIZy35iHOiFEAmU5fkKwUT5d8Xrf+Vcsl5kAJV4gzRbsxH7geOQKPmb510x2wYh36C0d1gqX9T+FhCyOLOakpJQlW2WqKCLIIfD6IZKYmPxNjlm+8tVICR5zChQn2wx8f/2dN4c53dnEyX0EvhKJ8NtHW8F8533FxGjk6+GNHWgM85vAoAwsMcvPBPaWWHfAPiY5pvtUMJGLOvCGV/XzBRmW9O5y0oLw/JpCCISy0Idf+DiF6dv876Psk1nEq96XFXUmst5al7WUoL4mUZ+55Hb3uuH711bzipPvSeHwtRvCU3prby7LlgoQpy1RKpGRuhdesy75Q2mm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86tVBISN5fI+IGSsoARQi3YKAxAT0osQx5loXarKwkM=;
 b=WT+hI0vpGDxO/xOsOMvIfAH4gPE7qebHI3XYiH7VlzWwzQ7x6XSkNHMAH86GWa+f8umt3HCbZ+2WDueJwS8R1jsmKwSg7WxWduCKgFjBdmfFBuo4UszaGf6KDzTpNyV51dBAbWH/cvu0WR1lfHuadyyOYx6QORj/Vkrgyz9aBZ6zWCP4CYeP9LhoZw922r7HV1qQvjsdwRgBBveYYDHbB9nLvDlVxbQDjFDnI9GBVCDfoO4tNQ00pTDWIBcfCXHE7F5+Cilo27eF9JuY2172gZZ1bPGx0P/0ZM67OFq/K/5UuuqGjxw++bUM12TuLFGBVmeCfk7zTo394oHnbOrwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86tVBISN5fI+IGSsoARQi3YKAxAT0osQx5loXarKwkM=;
 b=t2Ca3+PXKECdscqsMnz+tHyYN2ubF8omTdkf5aKqR/rDU15kPBATAlw8lHC53RhPKj9xj2A3Tl6XJ8Wph59/SxeXN+FexJE9szTRxg3djBgiI2ate8xUKz2VUltqg2Rb3/bj4+XgWCcnb3XXM7iUnleXK1sA0YyjhaQ1KVi0jbvb+WhD0nFFPHeVZa+mjl/eIR2WTcWCpNmxSht2Cubd30FUlNM5XSLCH5Y/ib3/vPYePBXp9/YJlKd5YIZx0oQJpoqV2p22knAhDJQ0bu5Y745QiJ7+ZsOVUJSwwmPTfT32KLyebr+5zDKZy/SaEggRkbCGo+mVuQt1dd3jwWZQDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 7 Nov
 2022 14:38:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:38:05 +0000
Date:   Mon, 7 Nov 2022 10:38:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
Subject: Re: [PATCH v3 03/15] interval-tree: Add a utility to iterate over
 spans in an interval tree
Message-ID: <Y2kYTLsMbQjIUMXh@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <3-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB527666424E77F8417DF1BF4C8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2VqK3m9i6FlQd9+@nvidia.com>
 <Y2XA702nWRGfP7mo@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2XA702nWRGfP7mo@casper.infradead.org>
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d09937-66aa-44b9-2887-08dac0cdae95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFl6whwbXAqBRXuGCZlTM3gDSwq6ScWo7nxfjmfhk0gSWyZCp9LEacznc+FJMSAk6K42W3k0Ofr0PCrOb5QGxJNeK5QDbrevchgKckn1JvlaCjZvBbuA+Y4I+XWbQDI5ks0GFxJZlMtfo7cK1yQhpZHx0+EGctfr8tmoktw2+jXHNeI+FTAJiY5/m9o5np6CvG+GytxRCMBklyM8Cf9ux3tLrtieU7SGaLWwrkoAbATZTINF1p5wP3Ff8hvwLm9oOvuVapDBS0mBpCVn67UemEWYyBItknBFmWzpKswrT0J9lsNi2wpd0kLA/v+JQauk8Rzxq23ekXG0EN3zAq8IeGaPK3/9iZduQGtMF4eQMk1P+6dhrO9cucEP6NEqjKHbBKHTiI3F8MRCH4gxTwVGgsJFt7dNVBvDsQNLCgWMxeVtHb+VBYjxBd2ktOh+P3/TjQNtantjG+pDqBjfeby2/VLicRB0/RXvu63SqxuQ8sJD8VaSS376Bdyoqp3OOA59uulVgvWbX80I7yQ8pZt2hMgwhMtDBawYRu4cqQXBKDXy6XZOUk+5ckTTrAfuzMVaoGtMhkduJMKy/b4GEptZfNj4h0ZWNf0SKu+T4VK5dbktQ94jlQM/KvbMj+upYlIFy5wD9moag+0ahMW3CYgu56S8yPog97MSG/Md3UoRVYVRVdqscmv3Xaj6VYK1WNDpOmUWoJNpVs6Epet7konigQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(26005)(186003)(2616005)(83380400001)(6512007)(38100700002)(2906002)(5660300002)(7406005)(7416002)(8936002)(6506007)(6486002)(478600001)(4326008)(66556008)(8676002)(66946007)(66476007)(41300700001)(316002)(6916009)(54906003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rtefODzIIjHDt4FdSRuqYc1UL3X0eqEkyi4KljjYzY3BESQZ2lDPecEH91MT?=
 =?us-ascii?Q?4NyrPrUiRqkF61AdVfS6C+HWaJ6AEAQkg0B+0wZLdEbLLSZ0Yn/dUJCzRgtQ?=
 =?us-ascii?Q?+kpcex91rzzI0urGjnjjr6YW5X9xcmIGftAMN0s58xr0/8prU66BkD+pMDQP?=
 =?us-ascii?Q?H0c+Z6UW7D6zgGzSVNLk/KVS5ZUj8D/OPvgZ3xRl035EXEEoHFXN9uokpxHx?=
 =?us-ascii?Q?B60L1VLamGHLerHi/gYn3rKq9GZDLlVYeSmgr3hyBzKEo45HRvdYMYe5J/FF?=
 =?us-ascii?Q?ZmsA4mrDqwh7tPpIc/zS+TUx9ESGdMK/ppQsTzQ14wQjYDHCGoWZalnWI7UR?=
 =?us-ascii?Q?elntX7lAuwmMqe47bQd0O3dt08U2iP5i5VO5UmvL1XezMmJFCuT+hhII8Ese?=
 =?us-ascii?Q?qzkgoaavyT9oO00IOU6+e5NKbHIOUu1cbpt1zrC1TxkV/1Y1lLcmmEyiCj5X?=
 =?us-ascii?Q?VZqwBc64qE+bpnmwbrPD/LVsWBaN+1zan+7MJPkGACeHcNgTpntn4BETMHVv?=
 =?us-ascii?Q?YmLHgOCxaPK92hzN0FZZkzdOB7mtYX7p9b7Pg+z1Xw4pKcHyVk5dZ10rwrmH?=
 =?us-ascii?Q?I6CwVjCMvTzNT7YYmrIE3sQ91GBDLlAiMxlD1OZ4qMWOQJbK6Es7ZxQ5tSP5?=
 =?us-ascii?Q?HhLZVHwavA8o/4UkQWH+eQo6SVjN4zr0aDVurv/pL49H0Gyv3Mcmgrce69iD?=
 =?us-ascii?Q?GvLNRXxI80BAyBoaRxzpLH3d12n2NX1xrQb36TZALtzBBuILQAI10OCgOZhs?=
 =?us-ascii?Q?e5+eUDmScUVu+9e6QbR5t3b6XIQ/CRMKGn2gvNtzbC233O4ztcUusNAAgju3?=
 =?us-ascii?Q?MZho6kjyTWPbCg6MQoE3QsgCtXNatTpzzRRVGztS+oZKSt22ubTyxv50vyLe?=
 =?us-ascii?Q?IbxXNx6RCxPivCmjKtYwzC3rdr0mRqyCRIi28jY+29AM+mrt4VVY1hj/qnj5?=
 =?us-ascii?Q?luvqaYGZhcmatt9/drx/2uhjCsVYUtBT0HuZ26RKEVx6T0ttSCG8QvCHVVtt?=
 =?us-ascii?Q?+DPjXFM1pChv/NO5xqU/TQAiNWnToA5PyWRs1oxXfAWlrAaxP1UT0UltZ2bf?=
 =?us-ascii?Q?K7k7teCsjkZVS6Nn3yBD01bV21l2dGTGynYY1dX6mo60mFE7j8lInT0HrZid?=
 =?us-ascii?Q?z9f9GdV/PUKU1fEjAsFO/f3CZx0t6ti+vEVXXWbjfaRA4ILbUlKziFOSDvtr?=
 =?us-ascii?Q?DqENNwToTsTzln0N8PnIE20RYTwwYBjvuGvxp+NRdajSo6lkmZccIcKSQk3G?=
 =?us-ascii?Q?o3ahveqXWSpggdB0/lFwB8o8G63nDQIeskNDyXFVrLL93CfbW3vTvwKtCpi2?=
 =?us-ascii?Q?m0m3e2mBk2JWY2G7uktL8f8do9mg7J5fMuG7+PDfQzlBugcTLKLvh3dY53IF?=
 =?us-ascii?Q?kzN8HoApQlOZPsTTPQFxBPqcu9mRWUP1/8sl0F3vXR/mzIotWEmj/auX9GHL?=
 =?us-ascii?Q?0Fu2Vqt0XL9JCkYytIX/TtJPl9ojm5yiUuB3sV9owexPqMhXnAZaEVlOr2wQ?=
 =?us-ascii?Q?Z79UEj/bmUOgxmBenqlENZ3RX4qR9A2ODy+MdSP6gpR/3skxd6dZeUal/KkW?=
 =?us-ascii?Q?DldJO/wfdaiqY8eEqMI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d09937-66aa-44b9-2887-08dac0cdae95
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:38:05.8685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MJE4+PCOlIlfii6zr3bv5EdVbc+ghp91YyyuA8c35huDZdlAi9yghm6djksJmsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 05, 2022 at 01:48:31AM +0000, Matthew Wilcox wrote:
> Or you could kernel-doc it ...

That is a good idea:

/**
 * struct interval_tree_span_iter - Find used and unused spans.
 * @start_hole: Start of an interval for a hole when is_hole == 1
 * @last_hole: Inclusive end of an interval for a hole when is_hole == 1
 * @start_used: Start of a used interval when is_hole == 0
 * @last_used: Inclusive end of a used interval when is_hole == 0
 * @is_hole: 0 == used, 1 == is_hole, -1 == done iteration
 *
 * This iterator travels over spans in an interval tree. It does not return
 * nodes but classifies each span as either a hole, where no nodes intersect, or
 * a used, which is fully covered by nodes. Each iteration step toggles between
 * hole and used until the entire range is covered. The returned spans always
 * fully cover the requested range.
 *
 * The iterator is greedy, it always returns the largest hole or used possible,
 * consolidating all consecutive nodes.
 *
 * Use interval_tree_span_iter_done() to detect end of iteration.
 */
struct interval_tree_span_iter {
	/* private: not for use by the caller */
	struct interval_tree_node *nodes[2];
	unsigned long first_index;
	unsigned long last_index;

	/* public: */
	union {
		unsigned long start_hole;
		unsigned long start_used;
	};
	union {
		unsigned long last_hole;
		unsigned long last_used;
	};
	int is_hole;
};

Jason
