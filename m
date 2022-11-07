Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D161F5D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 15:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiKGO0o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 09:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKGO0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 09:26:32 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5AB27170;
        Mon,  7 Nov 2022 06:20:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEEl5SAvEJAWb7KYil0gaXxmw9AEVQBDOq7rN8rZip1pzk7dpyEKM1chs8PnHf3h0c9/0jD966g7WkN8zKG0y71nKVBV3X7GwZaguvxTfQAvJ69wY2s5hMSMT3OGr5nYTxcKkwcRnyda95XIV/spvM8Dlm084ChpO10m3xj+5ce3rUjTshrBxyYc9BZlCLP3M3TkK9jGIKp5h+T8XIacdZ0hKZcTEtqqY6kd4W7T5Jj7RIVWkVA2e4OQfJwWbX1P6BgbED3/W9vzRXl3jjt1vDitaALsMcvjOi4DwVDz9aeUWg6NHY3Yq0kPw/lYKNDQ0LOJGlPtv76sEhPx4REC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEwYfp1vDgdh2XuSdxVDSC3xXM7OiiMZPxb6HvWVmx4=;
 b=n2GXMEGcqPAaOAaD2ocB5ta1DcV4HbvpBkCtilw74WWFZ76Wp14ROKp1JKWa9dM+eQIHyStiNdw5c55dUU3DlTlo0z3CmlM3S+j862bpj+ldnUV0lSXd+1Ci7D8AF3vkrNZ+pW8W3R4CH6fkIGTJj5sAGr9wQzcnG8XxuOBh9ybCseV/OedCl3LgMPKgiB7cqdhTtNu8aBlMBryHwGt0J9/BP8IL3GKKHBIFJnxeAQL07TXdHyUCFeo25g+r++cIGxs5BWCQYHzkm2O7S3Nu+LODRCEOOS3NEeiKmQg7c126MYDDs8O2DWBpqK1zjETt92nZIE0HpmE9xiJ8Gz0gwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEwYfp1vDgdh2XuSdxVDSC3xXM7OiiMZPxb6HvWVmx4=;
 b=eian48d3ZHw9qlNu2ss9lSp/ZwII8cKt57OXdA06EzwpbQ9GBNakR13NDudc39qmiHJ0SaaJDK7R5lDbbHixiY2p0TtguL6Nw+cjXphhisEJqoC4pdlAB6hDo+mkAVbfFsF8pBIroLKVXdfmOmVimnsUo5R2zhoTtq856dCJ2SE1Q6Ac2YuF0uVHRTtT2h7l+tWygK5gxU35FYyfccp0rpapjm/dl8cRpk2TaNACNkpHB8CQOpd4ekLLc/p5JcpTG9uhPPgzfN664fvIswgZrLpdLTCqvxwlkETYJ3ZFB8sC94bX7xhZYtPYWGb8dl9iZ6HUNY2jr/8UAmmaarePlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:19:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:19:43 +0000
Date:   Mon, 7 Nov 2022 10:19:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 00/15] IOMMUFD Generic interface
Message-ID: <Y2kT/Qb35wI/Pnh5@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <20221104152713.3ae1c409.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104152713.3ae1c409.alex.williamson@redhat.com>
X-ClientProxiedBy: BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e8c584-2c3e-46e7-0cf2-08dac0cb1d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4bQjJ3kUNXgAwMnPVZu+cNiWnGQAeER01GqcRQmtCyXu9Nynfcg2hYKcmKtMb19cYDYskQUpwH3QufkbJYBxLG+qkaiw7kyzeHSkXnAvZqLSchC/hKJSt9h0nUpmFDtHs4ySqRGgtdDViDCSiuYdHs7H3mk1nfQ1AfhiHmY47md6TuyMYFCMg2drG9aEqzJGf5es6c77InwaKjmRn4pVjVpAFNbAuv7aD4cM/CLNvSBG/RuFBDbO1UeMykfHxtuIr85XY5KZzq69jFJOE+gJJlSPel2glHtruW1EQ7ZvKwJCuKyBLON3qq6pxttk8Arld3z7FiwXDlShu1G5HV3VnLGsXD2PKxBc6hdnq1hCmsx1eRLMwOs3GhRUufpweI4loKZqu226cXph/PTdhz5BDNSm5XysnyAPtpDhbmdLT0Qj4dX0Q3PkXF9VgUkyBofV/6OI0MgWlvwmVCZgoY6knUeL6uMSuTjwNtpWZ9Kt7K8mjHHIHoPxzDrHK2MC6/C72Ixq9PY6pZMFIhi29IXsNehp494/B8AC4VUnyePUjNK2vUn0QSyLlSWDD3l1iQtX/9JlAL7BWW9yQam+gIdcacGgmGLpzVfSLhoaGLqQMBNNW9MhctS1Rfe8qJ+Nx5DGRc+0oxXED0VD4FkF+C8voSiFRMtPZVd1zE+o+TQMsyOID8O9oLJECeOdl2FZPkkk08OIPjFg67rsUrqutBV0rJT7Xi7MYLQKKyZtVRgTEg4G7fy1+3AZKJxBof6FYw5DjZO2/uKhfipZL9az2Aq/nxJd9g3wIngRG1wyK2TCf4eJfT/BExAeXDl7sGPYNpqaNmFAOT8ESNEhpX5HkPJfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(36756003)(38100700002)(2906002)(478600001)(6486002)(966005)(6506007)(316002)(4326008)(6916009)(8676002)(54906003)(66556008)(66476007)(66946007)(8936002)(7416002)(7406005)(41300700001)(5660300002)(86362001)(2616005)(186003)(26005)(6512007)(83380400001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgL48e5KlGCQRlZoJDAT/NExkc9sxa7CKnlf6rFJOmYkcUR0Eo3xY0t7eRgK?=
 =?us-ascii?Q?17xOejta+Suo68/Y5XfZOGtgyFsIpQ5k0z1JHOgmuPsBhvhXjPB5e+QEKXjB?=
 =?us-ascii?Q?18QNmhAKFDMjq16TAHsm6hHOKPgdr+wyRe2c/0hu2bntzW621JnUwIDJCmxK?=
 =?us-ascii?Q?W7TnJJ07wR/QSmuVDfndIouCwggQdVPiOqlp5jsj7sHKil42Z3DyRTbbjjoh?=
 =?us-ascii?Q?/1wX0FUVbz4OBInZlOYhNa0iQhyIZZJ6GeLGOHzNlINofJ9oTNjmKXP9ALyW?=
 =?us-ascii?Q?cnwTpLeinPnzl8hm1/RGhTGk5EEnreILrsw+3MYsLjsILLok6R43OJcEtbof?=
 =?us-ascii?Q?tuw1Yb6K06+Yuxi2TWaQ+h8Mw6P0EbyegJCUui548P8WbnyKiTgvGmgmAeSX?=
 =?us-ascii?Q?sTqycjlNOlEjy22tb/d66yCvN4tJvWaJbKZ9D3+PgoPfNCktWgDcSdOwp5Al?=
 =?us-ascii?Q?tPL6xx1tOEHzWOq0HGi3nhAsjRTvONuYifrvillO//NmtiZhCB5lXiU8WF0+?=
 =?us-ascii?Q?4wQ+ch1blVrHOfTzCyZv4BLVK3mw+pBBTsdavifnopnHpY76/RSpUAbalvpX?=
 =?us-ascii?Q?+JNtWq1Aq2WTpCoYUNNEFCXR/qFQBmnuDCbDC8THUJdreWSGVYB5sa1aAos1?=
 =?us-ascii?Q?Id6f7b+XUpn7guGb63tQ20UKc0zADfWU4vhgLDrDt/BTJeEIAnfsE62WBKrI?=
 =?us-ascii?Q?tnuIAMZaDwAa2fcvBPftQkQX3CDUXHXhMiIv1w+VZI2PNWzOKIIFLCY4jY9H?=
 =?us-ascii?Q?1Q8owAe9TorF2wUPi8jsO2k0d4Kto848tF/A5Few/E7pZ/Nh1/1YkD5P0xIp?=
 =?us-ascii?Q?7eHvDxr6o98CqUI678DPXOcyT1cpj3Fyf2PaRfkl5NejH+dJpSNudvy7j2cs?=
 =?us-ascii?Q?5IWNGRZqnffbniRoxIDcBcwIUQFq1siAprHpcLQOUQ3l+vxxHgL+D2PrRLWA?=
 =?us-ascii?Q?abqDNZbf5rxdG22+DWUmesQEy8i9yV5ryk/SpIB5lgilIKkB+KctInjBgb6Y?=
 =?us-ascii?Q?/WVrDM65GFIm61DUZHacHNzhAPO527mEDbaiOVkkLXdQoAt2jcSRhTDx7i0c?=
 =?us-ascii?Q?2T2Tq7f+BYdjxz+oZPbAiriIchhUmjmGpXaqzNmnnr2LqkvnhDvXvaEEqX2g?=
 =?us-ascii?Q?XHUpMOpqsJbCQCXCjdh7wTs6YiVSGEUdDXr1KHTePdQCF1W6Y/ZmyQ+wDPmI?=
 =?us-ascii?Q?OSZbVkwygPFbNz4kS5zYrrDPVy6ffxJRvBPpLYqLN0BSlARwBXaUdTZDgVIo?=
 =?us-ascii?Q?meB9bSk5kuuqFZsUUI/JEdpna1QOd8QxvsQzTjqv7BJAsZV2wTyhtf+7vejV?=
 =?us-ascii?Q?yoCNz8oAaOAzkeuRf2JKZgUyl58NKsMGR330R765rJNGovN4lt31fHXweyRn?=
 =?us-ascii?Q?HPLawTvXTXKqAYQJ25qWcCY4FnvjNpoFN1JqKgJq1bfEDZVJAXY2s8sJUM9v?=
 =?us-ascii?Q?CoDbkKcSvXC7MeYaZdc/tJCvDzuLvHMdygKX7512W2HLjq1bpTxuGM5oQtS2?=
 =?us-ascii?Q?BxyABMbIb1Eb2E0Ca0d7BGq/N7JgZ6TJvcOArJS2l/xBkphenMpwplI/KQyy?=
 =?us-ascii?Q?m7pVrMVr23D7psoKmH0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e8c584-2c3e-46e7-0cf2-08dac0cb1d2f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:19:42.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdF8Qz+tx81L3y9Pj/TbMPowqeDNZovAR3FSXxCLnghlqYzT99rR5Z1EXD8FpZtb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 04, 2022 at 03:27:13PM -0600, Alex Williamson wrote:
> On Tue, 25 Oct 2022 15:12:09 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > [
> > At this point everything is done and I will start putting this work into a
> > git tree and into linux-next with the intention of sending it during the
> > next merge window.
> > 
> > I intend to focus the next several weeks on more intensive QA to look at
> > error flows and other things. Hopefully including syzkaller if I'm lucky
> > ]
> 
> In case this one hasn't been reported yet (with IOMMUFD_VFIO_CONTAINER):
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.1.0-rc3+ #133 Tainted: G            E     
> ------------------------------------------------------
> qemu-system-x86/1731 is trying to acquire lock:
> ffff90d3f5fe3e08 (&iopt->iova_rwsem){++++}-{3:3}, at: iopt_map_pages.part.0+0x85/0xe0 [iommufd]
> 
> but task is already holding lock:
> ffff90d3f5fe3d18 (&iopt->domains_rwsem){.+.+}-{3:3}, at: iopt_map_pages.part.0+0x18/0xe0 [iommufd]
> 
> which lock already depends on the new lock.

I think this is:

https://lore.kernel.org/all/Y1qR6Zxdmuk+ME5z@nvidia.com/

Thanks,
Jason
