Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52A6D61C6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 15:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjDDNCF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjDDNCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 09:02:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F4173B
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 06:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqreCIhLNs24voB4epP4tjwpa9Iod14hxzdq53zIRTT+yCyIZ2MP3xCTvAOD7hLKdKdVbWcr0ve7q2sivTp+lAXFjc1mSAIaFnjuFhSD8FjBgwgR6ybm10rzG0vF1fO5hICweL2BGlsC/mb16FKqBiss6Ng3HtTWIVLHIc/pFudPXonc8TSf/u976bpj2QX/K/VG0PQcw24ClXXObX+0ff2DogzdVtzFKDb3v9so1w3Q9FImLAoN9iA0UuaMP3AeyC1WWb9CVGpCUQQwVQmOHzv1C2QQTQZ57Y2Tm46cg9saoadKjAJemCSFGyrBO8JevZSdE9firP2cASRgsPcNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLRncIDVUshJCkRKwqFkn7rQNoLETCVF8RKZraxGXoU=;
 b=U15Qz/+NDuDe8CC84lGkVKMvBh+Y0tBzmBL7iKincFf3fw21y+HsEdtVpYSZtwh3tbxJMp6OVqn/QSJdDU009cWNjKFkft8rjwy3H2wkZoRsFGkck+QO1LlHcqrlurMXDEbMyFTYDuGoa8KVDEbuhPp6A5poTje+3TPskMFaYAciv7qEJl4x9iMwL6KekbL47I2oqvXCDDLWD/3/3JpkoGbSdgnkpTo8RBXyIHoAwwPdSiZURjLZNIE9UNcDopknj2Xz+4RzKlBYpRVZuRkWg+SitOZ7yC9G9taitxpH7jN82mQMULKVqlGRuQgDqe7i1Zw0TBWRa49Qik3BoKLBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLRncIDVUshJCkRKwqFkn7rQNoLETCVF8RKZraxGXoU=;
 b=MO9/fKvMFlM8rt4FLmOB7WhYo5+KUPQjUad65IxBfley8ZYmrNDFcffvivD9Vapli8WnQTltFEoIpao+cz24TX1JoqadO+c9PY+bwEQ882tdEJWo43AGR4q/EuHQUAZsNJ1t+12ks5H1/kcHsvD2UuZF1a3tq9Gb1io5iLS0MMcQmyu+oKp6bzQgbgdelRy5A18te1xiXmEP59ZaGG3Y4utDboJDKFYSCK1KfkVZOwBTtWyewsj9z3bCADdqJT/izXH8o7hKj+b6i3/IqG6IHDN1iI1xkbzD5JjF7aVMkcL5C1U5ggGVx05elTl0tHLyExOE+CdqNAcFzKEDjZDjGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 13:01:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 13:01:57 +0000
Date:   Tue, 4 Apr 2023 10:01:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>, heng.su@intel.com, lkp@intel.com
Subject: Re: [PATCH 3/4] iommufd: Do not corrupt the pfn list when doing
 batch carry
Message-ID: <ZCwfwwA4s/6Eorfm@nvidia.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <ZCfPTfmYA7SvNd+a@xpf.sh.intel.com>
 <ZCp6IOS0UtUE8z9o@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCp6IOS0UtUE8z9o@xpf.sh.intel.com>
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4936995d-7417-47c2-03d7-08db350cc5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWRUz81RqE5bds4cwbVtveHzgwuH9PhkSvbu35cgdmiwUjpoOPVp+GsvfR/inup4+vu0hepG1Yvpup5jEnADmYhG02y8QSoJvOzomXM80/2Gd7Aev9+1vhRWRJJpepu7NQv8c3PjArjXYAaB7E/urN4Tg/BdCxLXSpbJI4hFI6ZFq1N+d0Z3NRSwJXGJjpWT/C3sSWhKXW9WqDUer71LMOjd8qvovtIFs7AXP6IUT9RYrj69+iAsEF43Rv/YJOtEw5zhsdXJ38jx7P5M4E6faOB4tjrZeYMOlmhAONNAes5AXV4Ef/NR0prUINqgDozYV9kxo6gII4tWjf7KJMPK6N7G+StBDKAaAGY4oKfJgKdcmi10czLXehtycu3HUnI6rLJ05RXWHnqqkVc8g24AEhGlGptcI7jahQppWMlMwzfRPOXOfZduXgIEyT+uDAjM1zHIGfcRjCMcrbdyZRrfEFZX/hmHEB+Z4njMSijag8XPDRQ3+xg1LxOwfg8qCb10EZKfGVfQ0QurxUhoJxIczlatj4RCCFJRPY8gmJsy3vljadAZR98lrh3OyiWGVEy2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(6916009)(8676002)(4326008)(66946007)(66556008)(316002)(86362001)(66476007)(2906002)(41300700001)(54906003)(478600001)(36756003)(38100700002)(6486002)(8936002)(2616005)(5660300002)(6512007)(186003)(558084003)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jJNwk2zamytT1ZAPMhTmHaz+snJ2/SUb57gLebV3+b1AE4pMbubNABBEDYm/?=
 =?us-ascii?Q?L+kv1UUww8kJSF5oSgwoZXA/eGNOGgBOh0DlpqEH1sIMow/bY9TAk0xCvVWT?=
 =?us-ascii?Q?1hNYjkXI7TKZ/YbCY3tZ4qSmkg7V2QajttCdNcGWzJRDgZIpyrYpoGsxnw6F?=
 =?us-ascii?Q?jjleU8K/xTlPnWxzBWV6ARw9IK0VH5TlDTcoBZLNPjBOG/6NDRgyesc/2Msc?=
 =?us-ascii?Q?a+tW9q5b7nq0oJEsFKU9zir0lp34Vl+h5JgaCgnvr8jflkpiVRobAhZRn4i5?=
 =?us-ascii?Q?ngPNrwPQkexzAudhD4RNpApX1O60mFsLs7+PfOd6HNHzE5ueIkgyfphGJHUX?=
 =?us-ascii?Q?kjIACCaP6EgmdvL2uU3AcpqnDmXNKg6pvgXtCEtXNUL15zcrnG1lU58cDkcE?=
 =?us-ascii?Q?XYN6z8nZ1qpedzFwcfnyqRcr+3ayQJeUtMJk04XfMz0humZS6zbWNmTmc13F?=
 =?us-ascii?Q?7Kff3Xv/XElkiT3uUcv1D529cBl1hvl8rU/AocQ2ICLtgiVxx4SM8rEaLe8H?=
 =?us-ascii?Q?ajGZpeUn6B5/yicIOe1MKched0wJ1ac0hQXZwEPEaKlf/x5/U3QOCli/6/sH?=
 =?us-ascii?Q?PppJM61++yQ/pLoHw8xo8iUt5d9s3BSO3MFOKC+fd+l8+a4iULc+1abQUp85?=
 =?us-ascii?Q?1gFig542pyBjA0k/oztlgZHD9MbtyOytS2228v05559cQHxlQwgtvMsxbe90?=
 =?us-ascii?Q?ZAKuGsGp63yHrcraEF+etsaEiZ+Y+YbP8dFwACELKtkxBqlBRERkPlQnvRpo?=
 =?us-ascii?Q?5FK4pZZZ37PO4MdnoyOA6oxB5rars16vZ5JG47UdANWIzn6aXbyChvvpksOR?=
 =?us-ascii?Q?l0o1jmgOk7SXBeC/UdZz7z5scVyayVksPLg7YtuDPERjTPUytVF/hOl2rE9H?=
 =?us-ascii?Q?t+9p/4n9dOz+uldJVa1F1tkWNyhSq/EdgaYe0NZOBVdrn8Wz7e0Mdx2HNTuM?=
 =?us-ascii?Q?sDTkH6tphjfjK8TegmaGXACb1Qt81oo+dulRsd4LkF+dcYVZWaEGr4WJkYbS?=
 =?us-ascii?Q?H1a0vrP3MJuBRJMkrU0JcCBuodimEMpOyq4UNVLPLon/s8V00zvJmv6syaAX?=
 =?us-ascii?Q?XlN7LKVb4NCjtG5Q4MEGvUK+TZlbzeq+5cGE10Rt9BR8yh50cHkoQd2e7n4p?=
 =?us-ascii?Q?LgVAdGTNvprIASWpFTp0bwvs1GMMeIXj1/3X8HotjVOQvMJJfPm6Aj5Ryan1?=
 =?us-ascii?Q?v1GjvMA7NW8BWG5nkl8lxXbXKtYhm6ctTt83GaZerGad3d1bHvs4GxiPVEsB?=
 =?us-ascii?Q?CsYIZ0DS6ZG+3VuHZV74ImhZ8NQuzRYVA7iW1PFIuHekXpsduVFiR+JO5VJX?=
 =?us-ascii?Q?QgUtdgbjvrY8KdOjCHVtz8O2JRFp4fSVGfB14xrfxbwNi5E7n/P29wf2ZHL2?=
 =?us-ascii?Q?uI+dlpqOZUDoLoO2BIb1A73EYNYU4RFcTouh4GiVIrwuUMGWcNWuWzZM/BBC?=
 =?us-ascii?Q?NmCc9hVgGYtMOSdAwKle35F+/7DTo6dKztcxZCoJhXsHXOPiTP2aXqXyPlOA?=
 =?us-ascii?Q?XnWWGTgc1YRRWx9vTlAnNx8T08iv+ZcJoD5TubU7x7YW+Hm2tjycLa1OWK2x?=
 =?us-ascii?Q?Mh9ePAXKZo2eFkpJvCxP5qhRHiNnREfPgigvL571?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4936995d-7417-47c2-03d7-08db350cc5a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:01:57.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmuAj1Y15ITLV06C9A+TS5L5rVVHP/RY89xv7gZOgUtV9njztMBTXeUeqwXoDnpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 03, 2023 at 03:02:56PM +0800, Pengfei Xu wrote:
> Hi Jason,
> 
>   Could you add "Tested-by" tag from me?

Yes, I did, in future you can respond to the cover letter with that
tag and the tools will pick it up

Jason
