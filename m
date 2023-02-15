Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5034697C44
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 13:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjBOMvX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 07:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjBOMvW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 07:51:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600534C10;
        Wed, 15 Feb 2023 04:51:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4sgnRdurJ8rHs2GnXsi2/oj/BA903lK5MN4RbYbydoS6YW3auYDJXOAbtKyqWdCpr6yJpccBIKPHq0tRDAWk64kw0BMs32G8nc540Z6NwGv3Jm71LE+GHBLV9ihVOt2q7DkC6pLSlM9/1uw0dvn+E591A5f4sZfiRUZWPAG98JxIvVH5uD29lV8vJoyGucwE+JwxZEEuXRq2LpHpcTssZDnPvZS7Hhm7kx9VwR4d8iPR9ilWI3jAzHwVCth6JwgUFP4ISrktELyV9zP9uWVHJDlwCOEkUHbBOU+Gkqk90Ed8fXF+YsGbcM2EYDjw6npcQenXNszGy2mwIveMaei+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHhqCBFWFoX2ColOLgeJejx7jJ4HxU2EuPg/sakFCtQ=;
 b=dbhV64Nqe2WQS1iK5CiMNucVT2Qn7Wjid7q+uN6EePbBhSaQC5cBSKQEmCk32xC0tZI/nZ3dC/BR6PrL+gsbVluISrrVbgTyniduNpHvGW3gdsIkXNtqDsp7YDmEoH4rxBGiWnVda9OzpZijX8D2b+5bX1Zz5ipYLQBLEAQHg9bbO6lZvIU/YQyf+nr9p/7bTSQyWsGczLVU7EjrKQubH9CCDJOZYFkAjsCF5lP/a/8B7MAsKhoIbv8+Mar/pJwTJ5xCMYnmNJV+7mBhrLSEzprxRJnLzBCwq60WA/Jo0dQenX3B5d0RHYzdMn/DGVSe8kk0Q9vyz+zFp1Tm6z2LAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHhqCBFWFoX2ColOLgeJejx7jJ4HxU2EuPg/sakFCtQ=;
 b=oU6usHEnHNfQFRMlmQpzMwXeKBpps713KHLRX0gQLCpfdNiIR/oxSdU1sHaB/6KO0Ft001wlHBwXhaGBhWTciWt/sD90sW/DLT1rEljn5xQdEnYD5P108Ml+ZCYjW3Lch9vyYyZHyl/iU8sBwplc8AMTN26X+Ja8WtSHRKgYAgH15KJurIdRsp1mW7flLjKnbSRpyAgjGDgos6rpUnIF4jdO2HwWoGH/6leYa9YVlx+fPsDi8g6gIEwrKenQ/AAG9S4NejHYibFKwPAay/WplSEDfuIMD6pxmsEUJ1JJlp9oKsdacAT14SyJDXRrQxD2Qp95DpUP3C+xtVVBituhKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Wed, 15 Feb
 2023 12:51:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 12:51:19 +0000
Date:   Wed, 15 Feb 2023 08:51:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+zVRrt7mGkqtBBo@nvidia.com>
References: <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
 <Y+pN/vtO8I/oiMOJ@nvidia.com>
 <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
 <BN9PR11MB5276CBCF780BD7C61154BF8B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+w8TJ2jfDATftbr@Asurada-Nvidia>
 <BN9PR11MB5276FA23E61977389D0C1A198CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+yGfXYlumqOU5xj@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+yGfXYlumqOU5xj@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR22CA0026.namprd22.prod.outlook.com
 (2603:10b6:208:238::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: bd37a8b6-ddac-4cd7-dc4c-08db0f535551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dRltI/QfRVfyt9HmfZf6t/rjzi00bJEjSttG6yqfCKIbNfTw0FNmxJSDfjS2Q/xWmbC6scHB+yTb5KmzVTfGivhkZ7qFhiLmxxWyGXeU+B0MVyQvBKgsfvd18ApiM0HNqxvV6NbJTVWS8YEAXf6C0qUiE71TnTWO4fLlsE+MAfS/N4xc1s+/ZT87U9VzAmzz11HahBdGqY92qlGhDGqYqS/BoYXgzb3H25kgxRAPCn9goJ10ZUW8hW8Y+h/QxTmj2FidQ4tJYYH57mq6Xd63RWi+HYNzoqM+KeSRjY6yGwdvrgjfuQz6VzR4Bbf2WiUvdp/oomyvDuuy28LIFcnNeX+FYG0yV+2mMzpllVqEc64yf5NPcGMR7i4rZiOx+7DYiXsSPbogvMzqAum6L7NebEddKlxfCZ1okTBoUwxnO3U74oLxB6xy9/55oFd9iyjfCtKLFMY4+AloojX2vrPLj2EKn3wmegcWr4lKjBaAzrb3nRDOt/ZsQIL5CED19cH9Lwg7E1OS7chzo7T+g/HZ6cADONaAvtbRtfjVKzAmFT34BpZSK/m942XXubXvRY/yBeU8slqTu4b3397LTj8EHhPEfWV2tNXz3cSjLrTuhkvtQsPel1RYoWghVCarC8yQlYxwyySWBjLe7OXmlBmvyGOV/M7TgHaXK67AIw/WPY//qOFVChh1aQqRD5FwHJK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(6486002)(86362001)(478600001)(66946007)(83380400001)(6512007)(2616005)(66556008)(6506007)(26005)(4326008)(186003)(6636002)(7416002)(4744005)(37006003)(316002)(54906003)(2906002)(36756003)(66476007)(41300700001)(8676002)(5660300002)(38100700002)(6862004)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WREYtMbsyFq5JB/WMANd3OqAs+Mb1yKcowxuCBe0a0uaBS19bMuxllDT4FyE?=
 =?us-ascii?Q?TsKhKf0jhc/N7ZocWdkCFANpKurdOYb9ZtBmXC4Weqg/smnuf6V54HtkN84w?=
 =?us-ascii?Q?MDGduRwDwSJK96/LPR2HvgGDAIpnztl1dGhmZkZQvp0WeKYlp0PIOVPJo5dq?=
 =?us-ascii?Q?SnDywM/GCdoDsZ1mC4eJyz+h3NZvVQOl0k8f5u+pxA3M156D59jp/1uiE7tQ?=
 =?us-ascii?Q?sPu8DfprdXWh6TQVDNqKXNn5ec3iawfdbswJqbLWXQ8Domuc8xvTEnJRD1/m?=
 =?us-ascii?Q?GoY6qJ7Mb71scuY0gYTHG8oHVzJbihhTMVMteHaT8e2wRi3KXjZdMJahUot0?=
 =?us-ascii?Q?foEvF6oYkAFDS8XXi6CmGR5pTEyDjp0mSRWvvHfk8ZQpKtm2nQKXI7z7y0JD?=
 =?us-ascii?Q?LrV4ol5jo1+npdTN1aQl2l3yRI+A0oP8FiljcLHVoZSieBh0SPzqHwF73AQI?=
 =?us-ascii?Q?l+rPRGT36aogTn9NxqZZM+mEIMhM4nZE38HN5bQdaUEusYfqenA5TrYyMjb0?=
 =?us-ascii?Q?CG5/Cre8QxSio4No8qXpoDf6DFgcp28YuIeX3mp/dm3XztanSlRPZ5xnvE/5?=
 =?us-ascii?Q?Vv2Y2JP3N1eMkSh1Yp7mL3LcJWvJCKbn6QCeka2Y8f2W9aPzCFzTrmytC9Pi?=
 =?us-ascii?Q?vSTfATjat0AE//wymfjHgtVEF/WRwoliB9l95jy2fZxgLscaXFqYiBVqH3yt?=
 =?us-ascii?Q?eQsGJXAHHcBgtfHmy9SYW44mcm/YogSASKliZCUqOBtcqZ+kwdBnOSy95nVT?=
 =?us-ascii?Q?GECSpSQNKiJgsOZWJ1SjvQFyvAio0QzOxFRU9BJfMqSRGT0eUStVCmTjxmrW?=
 =?us-ascii?Q?zwVWXUkUfKNfYCtEqEzCrDnj+bATpx84UdqQUI7TYSIi8bFrxSgPRFouzeyK?=
 =?us-ascii?Q?NuQdHONYfPOgsJDRbkVq0ni71eQHZ/DvA51KLaQdGl3uqHXcaOriarBu4lO0?=
 =?us-ascii?Q?QqNzc4wMel2GdsxdkLCV2VF1BmabkmXBnxJSRTRNqzOmYt0x4jvjVPgP1Zk2?=
 =?us-ascii?Q?pASf1uHd4b34uSslPj5bO3hOukRDn+QYA6x7eamUb2AX1NRM39DUu1UTimvW?=
 =?us-ascii?Q?sclB/5yE8ttUoddkiy/jjEG1zosBxAayukBJ55VdKD+kuXARhLILOfN4BLZ0?=
 =?us-ascii?Q?GAGY3mHd4TSykwtx/JI4iFolllsq2NuV+IQrEZzDc+UIrC3qra6rYjPvjlCJ?=
 =?us-ascii?Q?99xi9GRAxiCFK7ZfK03CUKCKNy/sMYIQYUWKb2NTeHzQYlAPB06Sr3TpbGlv?=
 =?us-ascii?Q?t6D0qYXhEiJLWThyQ4FJu87TVwntRtPmaumQfFznqY30kSFpp6gGj33r0M35?=
 =?us-ascii?Q?7Z/avL6rKonaTxcu3r8Ur9RcBhhLtOVG3U1r+rSh+oEl8KZoS5wYouzD3a9a?=
 =?us-ascii?Q?BiLC1QSVZehEu971tP7YFXJY5hCe8SNu5C14uKgcUpdOYkNqQGAfUkU0RGQr?=
 =?us-ascii?Q?aYFq+kb13FYNTbpKz4eGsMkDFhbvpvSZqik4p1DFiWqrV52Cq2XZykn/evPe?=
 =?us-ascii?Q?KU1UQODQm0tnTrjbZyEkpHa/q94vzdHROIHGFiVW0IhefvxDY8NZoHLi+rbg?=
 =?us-ascii?Q?Mah4cm4gDqpZRxvm5hg1OW4UpfqHIbIdIesAes10?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd37a8b6-ddac-4cd7-dc4c-08db0f535551
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 12:51:19.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bPZYDPtFbP6fCW7x38u9P20qc6Ofruc/qmGXTRq23F5RXL++VLquvXbV3+3u2Wm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 14, 2023 at 11:15:09PM -0800, Nicolin Chen wrote:

> But things will be out of control, if user space continues mapping
> something onto domain1's iopt for idev2, even after it is attached
> covertly to domain2's iopt by the replace routine. I wonder how
> kernel should handle this and keep the consistency between IOMMUFD
> objects and iommu_group.

I've been looking at this, the reason the locking is such a PITA is
because we are still trying to use the device list short cut.

We need to have a iommu group object instead then everything will work
smoothly.

Jason
