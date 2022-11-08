Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B679620583
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 02:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiKHBBF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 20:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKHBBD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 20:01:03 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833A1EEFF;
        Mon,  7 Nov 2022 17:01:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACNMvap5rsF+g/0bX0XEqatshk784O43aOQ9HgmUbAsfz0c2bwTH48iW3+0e9Q+mUD77ZSXQlTaNC7Z0ieetnXJ5BpVsflZMlux1xJyJQ9ObuGJqpa27mW3uk0iook6+9aXjFhGaPpLKyGucN4PBv4Nj2EKVsepjI+vr4QBmV/oFKV4ssQNsrBhYtqqPXrOVtvEGjril2vZs/fSl9XjeqateOTRTs6v5uVUN5BytjnkXvFwCE6tFiWNmZJ21WBHGTI1SvksbJF3qFAkBIG2PXqRiHD1qiX77hdxfKHst+QgkT9gyGWa4yGJSmJyi0phNYLxYd28ZHQUwB5gshIMyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2tILwaw0DgJrA7/RqrFSTMhwWLi5WmlhZwNa3dMvfE=;
 b=SYwdJQIrb24KpFBNEIqsC5U5mHS8nYzdojSDpgLHRpU2K79Nb6Hp7PYQLXHFTNwmhi35gXouKYKgpIIEBorcaaTHnZFuwM5p7ubCNYB3YYUqufeqBbTHNKQCU8T3BmIK4DgppwG5T2VXnTKD/OI3B2EKwxhZMFB/7cLzSnaO/irBOSmLl/59EiB+nEfdZBJrj+FuK6uOXDcg2jloMqSf0dyM7+yQ5gQLg+dwkU4X0cNRNJNvJGHnUSoddt7WdYjUZKSLoCL2vWd+ZBPJyDR2zY6KT3XAnjEp3WtPb7eSDIXTfCBDVsgoVMiEg7DGFv4QwPxuDkYizq8P4R6hLvrzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2tILwaw0DgJrA7/RqrFSTMhwWLi5WmlhZwNa3dMvfE=;
 b=phawVIzaQeILrZ/4jtzfpJEi2V6p7LY7JxjCHD19T2ZzJKzb8tJ09GuUi5S5+Axk2sVAi3FD2Vla2aa7723eW8/XYfATS/loVmxsGS5oAY2PbDiUbRQxtyK2gEqBlVvOP092VZmb9jgQGwDsRYZNMiEtdTqLLUJA2t5DF0y8z8em+tCn93JW5EfxPL27II7ipryTjvBCvhVgzYekOjyYYRKz/kUN+deKynm42n1Ln+igAcUZv/s2oI950Y6LqwB4pqWAFXXTQC/SewnhubdDCk6hhJ3TFPzm4K80qcYuXnCZKT9MFsL8IS1z6dWaNdIyxbosUzeSG7j1WLhkmYCV8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 01:01:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 01:01:01 +0000
Date:   Mon, 7 Nov 2022 21:01:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: Re: [PATCH v4 15/17] iommufd: Add a selftest
Message-ID: <Y2mqTE8iCEds8otT@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: e45f7b9a-df2a-4e7a-c9ed-08dac124b3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80Ro+Qjf3yDlMw5N4FkEroO2S7ENqcz7ljLnHXFq1D6RtywATPg9q2qi/vFeLGHOdcGbEnCgRt0lr2uN0TBIRsr65asu4+W1xHHKshn4UQm/EIGIpm4ZwbeOZGttAO23eNxPU92/QaTsPk1EM1vQ16vKSY+z2HU+X6qHMS4LZ8i6zsgbNpBVF16kmRD2BftJM8USipKEVANMPwPhD7vkXLPIj0E76oN6yGXnpECdLcOFddwi0u94zPuJWH//0fyXeJfj3wvB5oMrDV0J2r6jD7h3AwZZ1tcAaUbVgOxPUjCrW2bQPV3CLqMA1v8VYe8FjtemdhvfUahEGuoAOJOCIat+LDXtHWIe8404+35S2z8bVhdWaBG3+nDDqcAWcDJ2RXa+ZRT9N3D/2292ayr+CWFYoqB2P/uEXYkEYsI7tyksFC+oG2Dmdo6R+JaNRnvePalb2Iw4rS6Gx7og7YWii7gY22vCc7Ki0duF9yweD28yYmQjOOOvEqUQQwRG4Rnwa8+kz5r9S3x/AQw1EWYoRRjotxs/zU1iZn6yBSVdPJWuRnLZa9U2YcFCTdGW+FgQtNfBcl/u6NmA7EBlKSfUKCM325uSO4YPID84BFWVUIuWkJLBl5JRKk7czarB9DS7/zXBn7CVxIAFPZWqtZ1wt6wB3IG0tlaRi4yIUUmC20/FC1jaqmmq16kV4c6hNFsRBh3Fgn9EsD3h31UCwMbZr08wJu4CTk3MVeEy9U2evhPxHm8hX9ceGNOVRCLkA8lPCTMM7XgX6BPPqO2KmzX4iAv57YTnrBTAyZJJkmFzqIj7Dj3vZnBPQocHdTB6ldi2sGWjBnuKvN9fQeuLSpFV0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(83380400001)(36756003)(921005)(26005)(86362001)(8676002)(41300700001)(6512007)(4326008)(66476007)(66556008)(66946007)(7406005)(966005)(186003)(478600001)(6486002)(6506007)(8936002)(5660300002)(7416002)(316002)(38100700002)(54906003)(110136005)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjjV3C7F/GtnKq15bzUD59b7AvC7tOTBPEElbggKyqzTPFLz1OWHj90f+eKj?=
 =?us-ascii?Q?VSUo5cWqq9eCw0D7Xfw4Vx0005/+NHAqvq3YBwVJwKXh0OJFubRvG2w1gWil?=
 =?us-ascii?Q?ZmAKeH1j/LEbyGe1kB4hCIroRBRmLiT20GdwYoaHdOlYshXuh44Re7EW5to7?=
 =?us-ascii?Q?h4Pf8bZkKaZBf/d/0MJtV9k0Z87H+nP6STakbJA3kDKvuieRUxsyoXEq5W/F?=
 =?us-ascii?Q?GrZKDW/iG/0JbW5atfJkbr9GVPF0STS8Ls1zJwFQ8VaKm4QVQlGT7CKufeGU?=
 =?us-ascii?Q?XyxjEe4tJtL5D4ndWijW5kUY1XS5xJ6D5z1wS00JAbAggv80Aw7np1CYol1N?=
 =?us-ascii?Q?rV+OtS6QVje0nwMxUIdJ5l+zqVCwajs8n7phC+Q366+7vkm+xTR65q9QdkKB?=
 =?us-ascii?Q?hFEfT3unIfp4l1N7lLCHna5KFAKegWEI5VLRPEBo9zZlJYNUrLkxEzoBK9Ad?=
 =?us-ascii?Q?CYcfBmd0nPgIMWr+esOrTzgA34azj4h9BxPZSPMXdp0ZIR88foAFElBIkE/U?=
 =?us-ascii?Q?JdIdGUXSe7B061AELJcVmzCf9h1DX+MaqrbLASO8J1co5wh8Gl+mkosR+wl8?=
 =?us-ascii?Q?O58zn+poW3JAPFYMlcBIXbspus82hwhq2kTnnWh405/rzacAD7b4q59PI9QE?=
 =?us-ascii?Q?FJl5DR91PuzJo/+dWKUd5jlQDIG8/zeP5c0gqkbYSheCAk9VwnQ7LDKbPCq8?=
 =?us-ascii?Q?LqThNDU+QbjcjyJbtInXeUoOnf4Zerjwtq/ZNdoyAavUwNgvsvpBRxbkkNjU?=
 =?us-ascii?Q?5saWRWVC4Y0UWHT6qmJ5qI1LFBDgzA3ow5YLjef6u6hx+KLzO53KMYT3HkZi?=
 =?us-ascii?Q?ia6KDKqillsv2uT6PDsvzuNIzLQvp1EzrOBddjIEAa/ZQxwRVhKOipeBbe9F?=
 =?us-ascii?Q?q8hP4pg+0NHBudWLYOSdbFGeLBwVDPop0JMwNRg8IKlQTaBSGB5r33KR5cCk?=
 =?us-ascii?Q?C0TT49uWUwK7qyj+xxVH58458VgpAFtFvBhZIXtTLNCo0wt3Me9jtL1eDubY?=
 =?us-ascii?Q?gI6AqTbQ51vNb0xX/Hi4KvWks4gBEnT+qUyCmHifGv2ElNM72vO5HwVRMSBq?=
 =?us-ascii?Q?jmY9LZxrBo4SwY4+HO6eXqj9fAqmDkvL6StODeNm9i+0qLYIAG357a7fIMPm?=
 =?us-ascii?Q?m1zJobeAay+x1LYTfkv5kL0nmgVV9boGB764SruKxvNohk76x58L737Fj9+9?=
 =?us-ascii?Q?b0UosJQCqBSXgnH9fycDumLTBWoYsddxrRBRLxnStZNxL8w7BbboCWOjIC57?=
 =?us-ascii?Q?NiHp3ty8P7HJoc2OaAFRLB7Mtl7tBbHYCS2DalozeiW2BCU8LKs/8/+FPLxw?=
 =?us-ascii?Q?rYtL+CVgqLchW8CUk/xT8zEoqfhxCKDouRYMzYT6c7tNoVQhfnOniDyP0RqC?=
 =?us-ascii?Q?XhuVkkQpTOJGun55ecrEXcqxcsuSBP+0/tLxgs7/YLjzvK96MI7orXQdDHHt?=
 =?us-ascii?Q?30R0PIy2E1uzgdA89VC/+3nrd/gdprHxDQ4q9I6iBDunadCpZC+/B3ajBnz7?=
 =?us-ascii?Q?QGrB2dMv2y7x5z90ee305zZrjIxHMUO/WT4NXuW4brZPCVFGnDdhHqqocPD1?=
 =?us-ascii?Q?k0Sp+K+ejGm/EEarZ4s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45f7b9a-df2a-4e7a-c9ed-08dac124b3fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 01:01:01.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zP4WGbrZvAw953VI8GBxuvPe3WcsppvrORrqUgPDxuGwf372V/mvrCpIpWaXWsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 08:49:08PM -0400, Jason Gunthorpe wrote:
> Cover the essential functionality of the iommufd with a directed
> test. This aims to achieve reasonable functional coverage using the
> in-kernel self test framework.
> 
> It provides a mock kernel module for the iommu_domain that allows it to
> run without any HW and the mocking provides a way to directly validate
> that the PFNs loaded into the iommu_domain are correct.
> 
> The mock also simulates the rare case of PAGE_SIZE > iommu page size as
> the mock will operate at a 2K iommu page size. This allows exercising all
> of the calculations to support this mismatch.
> 
> This allows achieving high coverage of the corner cases in the iopt_pages.
> 
> However, it is an unusually invasive config option to enable all of
> this. The config option should not be enabled in a production kernel.

This patch crossed 100k so it was bounced from the vger lists.

If anyone didn't get it and would like to see it lore has it:

https://lore.kernel.org/linux-iommu/15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com/

For the eventual v5 I will split the nth test into its own patch

Jason
