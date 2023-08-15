Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2B77D028
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjHOQcc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 12:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbjHOQcI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 12:32:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A41737;
        Tue, 15 Aug 2023 09:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3jo8fQY0o8MMUcnr3TVEgb1VrOes3TdAd+3LQut5CgKDc5s6lUp88zZdwiY4L1Z5KYJ7wP+kSCutFmBr3m1qyn0fq3pCOnkT2xqMJglfzvss2+gog9LG0yP54S5EE5fVk8AYJJ5gbQPg0QjGbbJDGTMYwP4e08W/KAvoKu+rK99YnetWgL7pWp67FVo4D2jwah1emy4GTe490OlTpQKnJAHfTLstnHnEcmzHYbUcd7RP5zxBYoU3FFiMMV+WXWr3d2Q4l5dALDfXawa6Yzg0cjTrXz6uJT+K7mYbids3pjiecNMIXg8YGAW/S0FG6aaBn9M/fi63sL2n7cBsXc95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNOlxc0d/u3UlLE0fN8rFBIMTX06gwusafZXIC5oGIY=;
 b=Zqo2scO0hovr1ON99wwN/3dEjd2vtFQcOrLs93QhXwHfQ/UAiUmo9MTGEWoUduqlsgs4eMuZbNVLWiZixnfY8EOdeM8kfismHuxX2H9I2ydbvuLOmvTMT57M9UcJa8YTfofuoOfaHk+JRQlx89J4g1A3XU8MD1uyihxsgaDOEP2hOf7ipytjo34i6spfmUJGiBxDxFzI7MmREQNRvmSyItIbaGQjDlXo1n/BEAdn9Y088b+aDmAokwLSmOEEDm4jVsodB9nVds7rcFRFQA87HqQ5z6Wuj+xaJC6AJupWH00XDT8ddSgKdeHqyTWSmEHUCFh7vD7BqUEHvScnR0L3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNOlxc0d/u3UlLE0fN8rFBIMTX06gwusafZXIC5oGIY=;
 b=C10uqTnN+JkGxj742TFBgXYAiX70axLgaf9HvHHj/kWrkD5uMznQX8ujyw4LRClojrhzRZXYD+SdEUcY7E5oAoKigam0X1N0KgVztkvCFWLxW1qfBYr6EWI8xVtOh7qQQsHjkhd9AB+pnsgha151aylyOhhN01lLqoO1JB487XvjY0pbyv9HN0YzyfLwt82kIBd5bXz++yHMx35bCM9ENbMjwMBabkPyybAdxqNN6T9/TL8MSH5+p6aSPCHe7RcKJkgK9FcEv5IeHKqUUMCV8UzyDb3TNIZ3pa0w7BIa9ESFq12GDqsuZaEaENDRpJiesTlNrHlAJ56md6uUEQ71rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 16:32:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:32:03 +0000
Date:   Tue, 15 Aug 2023 13:32:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNuogZV2eEeVwNX4@nvidia.com>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811071501.4126-4-yi.l.liu@intel.com>
X-ClientProxiedBy: YT3PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2909f5-5df9-4c53-4270-08db9dad27fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eea77YZDOxr3fTlHFv6bn6bm+1et4tRE73/2tm5sGuO+yIfrl5nFLeSYocVA4HEtSohKm4gAPx6M8DfP4wZT05IHdCd3cz+Le/G5xLcJI1NOYPAXuykGtqQrOQMdQFbA6cosJwougpVXtHT97DErXN4HT5iPHjxAMzU8QAaqFOlhfkODdBeAjZYZSnSWY/CZrHrFo2pSIg4yAZvITSPn1jcfzpgFsNsd0reAz0XhTOd+VHB9V4TXkPQhLu0+TOEGL0+D4W4KShwYFgn0xLwNadneEfc/WSuFT4I2oKyqiJ1+OCnCFnfUs9iz3w4fIKAqyz9f8CacxQZTpV/1/BIHRGZCh7sVfPCqddHsFHi8BqbIpivToVlCvh1Og7md3npwxHAgivkSIkRlOIQWs4HZ8wnYz3Nr54/bQOu0sAe0BOvN5J8EIxgj/paYxOv+Qoky45jJie7BZPC2uT1RgxM6YUzzm3QmqNAQOvVA6dl8R4cbzNTjLSm5Y29YRC97ZuM1Lc9asnigQOws2mdJLAXj4uXPpGoFJgZOJzqFDXLkKuUs4wU+lYbScpPQJ4Dq8YT9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(2616005)(6512007)(5660300002)(66946007)(316002)(83380400001)(6916009)(66476007)(66556008)(4744005)(7416002)(2906002)(36756003)(8936002)(6486002)(86362001)(4326008)(478600001)(41300700001)(38100700002)(8676002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZPOBzh8enQmZFpWPTZ5y2KYpcg5fmhBiheggdIRxayE3VhEdKcvAO/FsgZR?=
 =?us-ascii?Q?N6QHA5uwWkEGeqRzH0uma/JDRzl6TQlxP7jo0XpAZtxbBxIHaDS3HETmWILE?=
 =?us-ascii?Q?bfrIb0oRlrUJtSOmudH+9jnjT+kHHjII4M/D+/MAFu9fnR5HGAtkF22Q/pHU?=
 =?us-ascii?Q?p4TSvUET8FhsNBquWP2UeIGptWJShCbsmNPGklVCmwtplDzzY9d3Mgbc745x?=
 =?us-ascii?Q?mjvYJbiuowsD7NIkVmQ86mvddEKD4IIhEisuDPLtYPkXapTDBBXk5OonEpWw?=
 =?us-ascii?Q?JyQFrX+gkdimTM+Sljex8gj+eYse3bxnhOaHVzw8jQoAD7NTXJyv9zLqBBRv?=
 =?us-ascii?Q?oHyAdw87FR+h3Hv2sfUZ9mdfAhHJck9uO2k3Kl78vDLyfLV77cXKOQIx9t5J?=
 =?us-ascii?Q?GCWF2qWEieHuqcBVFMgulf3M+2d0LN2G8K6HBCkOiNiGEHl2aBX62eGZKxw/?=
 =?us-ascii?Q?9rbVNULGjTDHNqfdrk5+hdVQmwqHp3R9Has7Jgqi3tYofXzgYjMIgFw8kV/l?=
 =?us-ascii?Q?wVDopoLwfckjDXoELvTIG6vs+oP0o87JMnb7z79XVobR9DLTMZJedfvEhyMo?=
 =?us-ascii?Q?OWFX6zlUsLpqYdnAgzVUJnbCegtKhIyPc4BibarBp2n24krMHc/LdQuViUSl?=
 =?us-ascii?Q?SeMwJVqpBs/f0a4qKdiodkEc8tEgj+eUlDOHNpDB9wHi1TVljQ18xjvcgxIY?=
 =?us-ascii?Q?4HotoaAJwXc+XOzQlp/+Fg+pePdcwrImbBorK+atW4Rhw2MD9wBsjGQ2ctvc?=
 =?us-ascii?Q?sFun5n2aE/hBTZ2U46bKFzRQX/MCYbjxt1zM7LNbLK8nLeQcpkMDAxUFLFM8?=
 =?us-ascii?Q?xmD3o0O0RVgz8jaz1l0LBXTXS4CkhAnhx+tQ6C0yIy/NhUkAWScyHFlYjZgE?=
 =?us-ascii?Q?gSYJT6aG5x8huxlpbyXfh+CY6auulm7NGx/NrjtGifTU2sKN1HqcLDn6O+GM?=
 =?us-ascii?Q?CmtPZSlYaeWnk2LZFRPsg3c13VlbcBq0MT/1/co7TDhjjS+Fwvmf62FwpDEf?=
 =?us-ascii?Q?D5neXLpazVInSlMOcMv+07l2SUgmBliMvxDxrRHbZxp15io2Cuq0ucuOxdgk?=
 =?us-ascii?Q?PRBtS0QFrbIRdZ1dCd+s+zqE7u76PXOTRVmKqZgKrbMeVkWuVO2xa81B4YlI?=
 =?us-ascii?Q?IXQaH5vpDoKJS2iAHLms5cNaTqbEpdXXFGhOaqDVfCVQsN344jy8dukbSsVK?=
 =?us-ascii?Q?fPhSBE8HYpZiOef9eCRE/MpkMaLM9cSeMy1MuD3lUodDWqWx1z7mtFahxxtv?=
 =?us-ascii?Q?WKRTHuxOjiS8qI2Fr0ImP8kRB6thMNaikdnk+VQrcJQ64iWVoS7FWdAsWv6i?=
 =?us-ascii?Q?ykVezk0t9m/p0zlcvGDaAZLxboOp821/gPrrG1s4zpGdcpDZPTd7LY/6fXt6?=
 =?us-ascii?Q?piwvkYaHnkgVyme3ODWfQFqTCH9zj+RcdTzMCjJrZpbY5ZzOD4bUNjlI3Iv/?=
 =?us-ascii?Q?Z37jZ4Vi/nw/YKyIFc2nztj1dVTlorBQf1R9D/Msq+n48AyeU8cmFofYZM5F?=
 =?us-ascii?Q?M2Fktzqksfzen0l9rG6Ykn2+CRhqev53T0ijLpdUnr+Y4IMaVB/9F3oxiegx?=
 =?us-ascii?Q?lGp9fSNOhO990WCh0ISQA6wLnzEaY4GQBUVGJXOL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2909f5-5df9-4c53-4270-08db9dad27fd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:32:03.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS6oC3AYT8h0z+n28u/CTKO57GMgDxCOWwmPIb0c11xAyrTgCgivykMi+Jc5PpJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 12:15:00AM -0700, Yi Liu wrote:

> +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_info *cmd = ucmd->cmd;
> +	unsigned int length = cmd->data_len;
> +	struct iommufd_device *idev;
> +	void __user *user_ptr;
> +	u32 hw_info_type;
> +	int rc = 0;
> +
> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> +		return -EOPNOTSUPP;

Is there a reason to block 0 data_len? I think this should work. The
code looks OK?

Jason
