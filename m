Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE67AD88D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjIYNFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjIYNFR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 09:05:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817ED9F;
        Mon, 25 Sep 2023 06:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH+2D06xBul5tDqbjxx1Y1FzuyxJAkEvASDUbtIPg7GWIFiBiK6dQ2w1pX5vwId1apmJ+hcXrI/TCR1skcrT6Gn0y6dpLEk2XRLEoxcfi8zMrQhDglmpfx9wAwqPKdttoTa3OFrRLP1R+7xPNfDbIqVyb3gRLw8lqFKXx6Cl0z341P/E7L+MEpxNdq07oqnc00HLF7xSQLMW4guKNMpcVKdRwn6GzU+qRNgc+q4Y0nvuqpizCaxhXYqVd/ZpzyGKY1sSrDtGzPwor3JAnaLPYz7ZeH12z9yPOQ5S2tTEvVHgTXZfqPS42XF40xFkSIs8EfXgqXPiaFkny7H+eLbkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnYIfayjB+lIlu/De5hxdAvf9gaji+1Ra8C3sRvSRUk=;
 b=LcwzD+OVSvilrx83cdQmw4z4+KVyosNS8/JD1LbaSGI7iNjQZYWhH0kUk8jeOsWMRv30pAQYVb0Rq36R4qjIalYJQaLXgkIuIyUeb0rZcLMsUFv25S45vJgwQnZefNWWxybdTYGEFs1XPnJMHjLaqBvA7h547mTJ+Zhw9finLh6HVYhr125LBnFVSzSUMxmTDaJknr4iZS1LVlb1pQ998YNGrUJ4+d/aXjypzuoWMWRN62M7Nm21FTljyDvBHBf7CHmCIA7epgYjyZIaToeCXSiK1JrjWp6KQUnAUbNTp1Z47akv98zVuGQWz8sV5ucY7X1BpbsW4yLb/lzojzSbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnYIfayjB+lIlu/De5hxdAvf9gaji+1Ra8C3sRvSRUk=;
 b=I5QmKwBSx3KR3lVSXBc3U8REq/XCQusx3CZplVP2qYwIHYlcgysWiFV8ZrMrcACJ7/NVAzPEyD9GKcv/NSAHAns3S6Q2jUYV916KSR1CXss/C5L9njHgaRfh61SY1jisT8fS9QaHw1Mxn0Ob9owHBeW/gAvl7QSSfN/Feru5wXZ7gZsXGCaxucb70tjOUqmu+92u8k1wsoKX3ChGVrO6r17e1CQuVLaaGv5XRCZ8t5rJpez6IVHHHwDOgna0Ma8rR9esVDmcha37570qx5V9kKEa+fSdnYY+4QWtPTrtk6Fj/uyb3QTXU0xYO+r5wRPUnBfH0n7Ju59U7rII/XZCIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 13:05:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 13:05:08 +0000
Date:   Mon, 25 Sep 2023 10:05:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20230925130506.GA13733@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
 <ZQyuIQbyVk9p8C8o@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQyuIQbyVk9p8C8o@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:36e::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: cb77e0c8-4d1f-4a83-6cbf-08dbbdc80af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSG5aL8t+sKTQZAHJo9qWsZmjKxpBmR8aXNqP/qX7sIHzSEZjk8Oxs19a8pOWYaJ15Mear8zqwLeRqzvmZ12WwzsxB1WCpUfF+iSSNeisPvRxmi5i7wjo3iEvRAFGyNLnd1w8v8+eT5HB9PhGR6/g89ptk98rdNQGmaOFWsSFS9aMV1/Q/6uNfbWNkl1NX6b+w6Wn21oKf+cUJcy2gzap0Bw+s8IPJ8DIHEPK81SwbAn32GrnegqcOw8BXjDQgp8uaMhl8QzDcwaCuwsPx5bSRtRhgbCr4BiVcuKRwE2esiKVz5uDpJj6swyz3uOwM6UVyZ0m1yxrRES+6VsIw7IocaByUYM91QIoeiWSfhw6fdiwhnlJMk4WCMSO8wg7STyNXe75d/4RkUlqFnx1gZMPWstZBr3jnZT7yW0bTNGO3kCC1+3P66YtS7Kqsd6nMkjOJjEK6WnbG+6veOlKrCBZvPGuQdIhBxH32Wl+eXhXNCVw+NIH9mMNXQgA2SNKVmAMmFtfcDKzxbBRgiUaNoq+iK/qlYC3a3eaC0YXAr/7EYvvw59HJsOjh4x3CXYYVuq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(66899024)(83380400001)(26005)(1076003)(8936002)(8676002)(6862004)(4326008)(316002)(478600001)(66476007)(41300700001)(66556008)(37006003)(54906003)(6636002)(66946007)(6512007)(5660300002)(2616005)(2906002)(4744005)(7416002)(6486002)(6506007)(86362001)(33656002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fymyqsuoWdYFuh0fNUe1bdW46uRxWHmtbAiIpgMz0KSzMjOgi4NzKoJBXDuW?=
 =?us-ascii?Q?tg0czKpCMGVSMudKbILfxiNHh1K5svK5glVAQup4gXFPFTqw4x12d88CHpXJ?=
 =?us-ascii?Q?PtXkFfMu51Oiv3N75am+bpxjsyWIgFk7JDJ++x8/8jUB0OksIh8fWK3SJ+JU?=
 =?us-ascii?Q?EZwlsXkzZGJAaVeEwp+DggkWWnRAzxcRmDr323eU5nTU3EriFzJ+Meu7lG/B?=
 =?us-ascii?Q?sYmVhB2dj4J3JOg1ZZCxMB3S2SvUdZnt+ZHX2ElGrzPKP5KjvRAgb1eMAFcQ?=
 =?us-ascii?Q?P4ze/okKr7t2gsq6vmrpLOwUb9sro8gjLyxSdX+n8eHO/iNaW22xMk7G4hWA?=
 =?us-ascii?Q?PdAPXS+9ZDjJW/fc5KdA1La++ea3kTJDfiFiDLNo5jXMFx6eIm5haLylG8BN?=
 =?us-ascii?Q?uqphgyvfjMa15wp8Oys6UEWqecwAPovY1sVUP2TLSSMc1l0OvmxHHpGSq6IQ?=
 =?us-ascii?Q?sQCmSjXbmGAdUSuIDit5Blqh3in6iqb0EQbV2gl6L10rnTKhCFKueSPBcW8V?=
 =?us-ascii?Q?2ocSYN+doBn4MTlp0JUlpweyQrVtOUWRDRHHENFbDc+OvrNnna+4WYMbYpQ/?=
 =?us-ascii?Q?xNFoEFWCaZ2DvECaOMl02pnnuOSffXguOfwCdPDca5eFJW9E7q/WUFkv7lef?=
 =?us-ascii?Q?KNLcFeqYJ/1nfGIjfmF1l7kiyiNUqdDlcxZ2hnEW8YsU6c7pbmSWQ0GMrnxv?=
 =?us-ascii?Q?sUwukxkS98oDX24/fjjIVCVwk0zs2IYjxNeAOtRGzmhFFqnuVa5RwveDpjZc?=
 =?us-ascii?Q?iS0pZBqWJnDo7a6cJ4wcJhQ16UWtNdamr3MRG2pECNbL9clD1ullnreRz7UX?=
 =?us-ascii?Q?xwBHw0dF32kwtEI+q3HB+Qx8rcU1s3AJvK4esTspnd7wKI3ime9JRruInJTS?=
 =?us-ascii?Q?TIBQ9oGYKABVk5DfA3vVDeBO8Gic6NY9EkSHoYB0F2uzvyPNOSbrbBj0U+vk?=
 =?us-ascii?Q?Ll+MjZPDt0awHdQH6XlO1ny8qtiV5DJ4XnpzonnRVrx61AlattQfcwWaDVQR?=
 =?us-ascii?Q?S91DHeIup6MRkd5iKU6RADYYh17WF7mulVIoPgtaupbKvijBk0bTZHhy4oIQ?=
 =?us-ascii?Q?k2aXZ3TfC271HgTnxYKswMKwY3ApBMGfACMhvWaNeehz+4ZZRKuSDJfhFkNt?=
 =?us-ascii?Q?ONq2Llk3iPKNrAFJBZ5Bo2niqS6Zi6gNMR9W4Mo/bHit3TBjFaRhJHpgi7Mw?=
 =?us-ascii?Q?eN1ktLJCcaFVmfMSXr151DxRmnFEc+O07758umPmF0W/7FuTyMCzQae0HDUT?=
 =?us-ascii?Q?Q5RM01srkHnpcBpBTK+tw3ngs8eNOFQ63VTn6q8XKYUUO0uKPbvye73KsgAW?=
 =?us-ascii?Q?C3SQjVS1oVquWrimyflLr+kj53Io48TN1lGCqn6AFAAZ3m2ZtdWciBt6T4mt?=
 =?us-ascii?Q?xa5EG5C2clCr2GQ4K3qSnhTH99R0GfTk+1ha9c1U/uuGqp57ahJIadaXqSjZ?=
 =?us-ascii?Q?NsZgY0IVXJ23Er+dZXoTy+KPksct8fOcWdIf2Vkf71cfpjEwrf4EjJO6bZ1u?=
 =?us-ascii?Q?3vLhnZufh5Gt1muHWx0BSUBAkoEmwvQ0t9Exz0cnTSVPPXcRmavTTHf0La8v?=
 =?us-ascii?Q?EF1lZkSYogIudPY1rFFdhZow18GIdzap6Qvz1kb1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb77e0c8-4d1f-4a83-6cbf-08dbbdc80af6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:05:07.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJjaA5r2jAy7QghxiY7lad/XlYC5hT1FB4hhkfdXML8PqUUSOghqJJ3zBP9repIl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 01:58:19PM -0700, Nicolin Chen wrote:

> Perhaps we could put all min_len defines in uAPI header, like:
> include/uapi/linux/gfs2_ondisk.h:442:#define LH_V1_SIZE (offsetofend(struct gfs2_log_header, lh_hash))
> In this way, drivers won't need to deal with that nor have risks
> of breaking ABI by changing a min_len.

I don't think we need constants, just be sure that every call to 
iommu_copy_user_data() has an offsetof() as the last parameter.

Indeed perhaps you should put it in a macro and force this to happen eg:

 #define iommu_copy_user_data(user_data, from, min_size_member) \
  __iommu_copy_user_data(user_data, from, offsetofend(typeof(*from), min_size_member))

 iommu_copy_user_data(user_data, &data, iotlb);

Jason
