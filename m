Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610368D65E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 13:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjBGMWp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 07:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBGMWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 07:22:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21D830CD;
        Tue,  7 Feb 2023 04:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYvTwNlH15dYof4gyAahCPGnn2lUF69+kFRoFE2F2Wwd8XnvkVL+1m3IL9dmlziN0gLfgTVaUo8sVW29lk8LQDXGY8l12HKRh1fnDT0muYFR4nZOHYdSWw4KzyJstF5Ebz44kby9KbKX4FVMWC7HSHE5TyRVjWg+cfQjma8VxuvrpC1jZD8Jt7FFjLbBkawPjnW4BKo8mbCfVuzDjKEZUC6YhgvR0cC2z12bgDTgQmi8q7qFNRFlTHX8nbhBiIO+ENwg7aCE5heK70/MBn9edHIE/gYZfI0mlJ4fJy+S5Y7TYW/DVzZYEQduQLWMQtXeGj0QiURG30Jmtp8efz1Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEsruZZWKMKaJ8rjY+A4a6YX3JNOsDN5bjQMr5y/0BM=;
 b=czWqUWQBdDpK0Ofvdtbq/ral0l/yDeYTKjy+83nXFGBfmOgib1CxpVXEiYpP+htCS7RjQOadZQZ1Ghoju8q3oN2Qf5X1VLxNEAj6IZ5oQ4LrXxSqYMTxIN4Jb+mFb6jvVTAm3yo/Z4ArxD9HQg9Sg9IbSQaesWdiV0jDGiUYkROcUcaJMBp+i5X9LvQlBp2ZplkNocDauQBjPhG/d5VBORFwXLPaslnpM31MnqtCKIfjFjSHfDsZxipxAZL85jP90PcTSEAxR12rcxv3929kx+vcNHYTxKZlmGYzbagLGnO3gJZKOb1BeAQssSHbGFDLlqD8fLVXeGQ2tzGvmX1AqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEsruZZWKMKaJ8rjY+A4a6YX3JNOsDN5bjQMr5y/0BM=;
 b=n5sj/iRfhnW+zgyL+rRtrwQERwMgBj1SwfezdhDDQMQMdfCLTu2MD8mPjDpSLxEgAJvXpR+nHPeJkuYnvpHWJPgTjnhO7Y5cEeVPWtvlblMbL3pNOEiVf3AqiW0n3fH0NPm3RqaIDfP2FRkdnhnLt9Kqqbz25kb+pzRlUgRMvKzBz6r8+IZV6o7lv/DiDZNtUirWbA1QekaoDLYoN0uMfhIQ8aBSaMy0HTE+WV9jvxWm26DrfP2Uirv0DerFd4JDfAVa79wsfVS8fPqIEMCjk3TOlap5HgR4lllqcpZn1YdlryZ7NQm+AT+OlDGn3/IX5by6xXAZ3z/WxF9svQ4aVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 12:22:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Tue, 7 Feb 2023
 12:22:39 +0000
Date:   Tue, 7 Feb 2023 08:22:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
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
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+JCjazMAMzNrc+e@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
 <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+D/vWwRLD27slQz@nvidia.com>
 <BN9PR11MB52769E24B07CA7296D8BEAF28CDB9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769E24B07CA7296D8BEAF28CDB9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: cc66bfe6-433b-4b52-9703-08db090600e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZcT6TOGdEtEl8/scyolJuotnd9b3Q8szA2BECBgI2OQdOsHP7O/DVvmPBkr5a2PgAra3gI9ELwlvnuyFl2v4fnx8X04Vs9H0sW1AJ4vOIOUrhZfl/cHUduXNGATCmntCmwiGy2gB686OUoW3VD84ffeyrsS1/TixtK98vBla/HXxrz4f1kzGIeh4Qh37BdECzAP2mUO4gr0H3HxSRAKgewjXuS+5QqrFxlciOMF00/wtag80FnAcSFVaWeMFBVE1mXm09pONZasWb5Q2bt7Ftolt6Pb0Gj6y7Hph0GY+0dHWRFVpp4c59QWx4D0W1QZk0BlJu+W8dsRSm21z8kzqbZn5NFwLbWFedGaCEptK7yPAqQST4V0OWOzlRQdFM8GKGtqD4NM0iP4+LM4Sb1pK8HLYH4lJc4hMn50zi4UJnHo3PX8C0ejdXfXGY+BVvIri4D1wQOK5su0P6iiukJ+KcDXAPYbAmYkq5vmVndfEBhr6wQjkdcPp1ATT0eBaRsp6T9BB+hUxwqMYETRa46qeYiM8bbNhsJmKAiDmrPaX7ouTqQang44RMptWBLOLpxB89NtTel0nj5xqzUjFV5wq6YZd85x7fhR9D6wuYOVpqHa9B7e7gZOVdJYIYnie1CbmYCwpQ9IF8sgodFvIFboVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(36756003)(86362001)(66946007)(54906003)(316002)(66556008)(8676002)(38100700002)(4326008)(6916009)(478600001)(6486002)(66476007)(5660300002)(2906002)(8936002)(41300700001)(7416002)(6506007)(26005)(186003)(6512007)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nr+4LNlbbjZy76CWMN3J19DR2qzjIHLVpSZEvqC4xYs819M6hZlNd2uer2xT?=
 =?us-ascii?Q?r9NCqF64U0Bx/5gjSyCERL3Jn7GVcCiazsvk2H2mk/aVGE79s2lmOoX9iLER?=
 =?us-ascii?Q?E9vdZL7q1aHQSpVweyiq/8kgunovKWYbhMoh/NFiy6sDsqpqf7+E/naZNxYZ?=
 =?us-ascii?Q?XNkqjmPPSJ0nmwFaoNv3atQC6U4GeC31qFU0UpQTLszxYZceTbfE8fsEaMqK?=
 =?us-ascii?Q?susxSQtzJczqGZoOX5gUy1dCmxVDH9GczvtZW6OKCnCjlM4IuGpXforDWFb5?=
 =?us-ascii?Q?moJ/wWbz7HaMnltVZOSiRmG+aV69fvmcKog7hpTjR3+UvxbgpARh6SA1C8vP?=
 =?us-ascii?Q?MGuljrlVFtZzqXZ6Upfu3HXkzc3iwsfi8EfqzryrMlupEf24LEJzj1sJVfL/?=
 =?us-ascii?Q?rokFKSAs9WajbesmO2V7P/lq3sKt/B9hIGkmZIe5mtMtC9jKBi20aoylRln8?=
 =?us-ascii?Q?PDBkq7F726/6np25tq1ptymCx5gwI2sEfCICqVowlAswMn+XT8pHvfQn+Lzz?=
 =?us-ascii?Q?lBDdvLRRv4IgF+o/mI41eOg3+3CJz2glRwU9hMZ34tB0BNQpxe75xHgA8toU?=
 =?us-ascii?Q?cmW68kLq5Go0x+F2YqWeUS6QrjBVBXXITOim7yWmAvWgs5l9eKiJoOUmcvQu?=
 =?us-ascii?Q?b2LTzZo0Yx1HpCWFDcgqFNFwXBaPiVPgGT5iOpjzB/hXrhrJwrMMgs3dKA4c?=
 =?us-ascii?Q?JETRtq355fSLcTYnFP2YaMU/lAKbCDbUpFcT8KdY9zQBVIu3O/Y1lJCQ6VOR?=
 =?us-ascii?Q?byNSYo6tZXziyq3q5haypb//QQi4pw+sq+T6pnphW+H8EbeeEczEJbjHRt80?=
 =?us-ascii?Q?tHFVbuTitwJgApENkEvn3ltYy09hyjtMvcY1et2oNB1uqGMCBjm01Xzphnvp?=
 =?us-ascii?Q?0dmAkMlBkMJP0U5JEvtoDqUTgsNt8saoqQBvBmluIcHSagOqT2YxUD2EpMfy?=
 =?us-ascii?Q?aXrYRP/xE0RllvuT9FEA4KgniKqyWConA57iWzMndfhkrBgJj7ufx1oVLYSn?=
 =?us-ascii?Q?TxaSJD8JQpynLvisqDpEyvrCeLIoO5KMV2zAxsEBhCfCS8wJcMr37oElzjKt?=
 =?us-ascii?Q?CTDvEqD9N/BCk2Jv81TcyG96vXBdHvpsnGG2Fi12ZhM/mEBmT6BTxJZIBpI8?=
 =?us-ascii?Q?WTn3i6KAMC9kmanXE+B9113gq1do0f54LlKcaV0m9oa07KHdn3p0kjLisEge?=
 =?us-ascii?Q?0vHhoE/DUp8stGxUrEQ70enltbtVq+dws+kHQLFw/cnW7J+SLkU8cJMboVpP?=
 =?us-ascii?Q?+6vwW3G0ae0Y92J9V1Jut6FAiH/2nt/nGw9kATh9Ttsnj7gP7Z4CExW26Wgk?=
 =?us-ascii?Q?03t/DzHoAw5LXjSAVqpHls8fBSvVnZBBHRsyvWGaq68KA+EVbzIqvkFs5WrJ?=
 =?us-ascii?Q?+3FcOzenSGSbURDAD/BObrGvq1Fmfc2TVO01MMcwXcPuVu4xGHONxi3O3Ifk?=
 =?us-ascii?Q?5SgNsLi6eo0w0eEnr20NQjGbk76x82b1etxpA5VK7zOEB1+Q+4bKuXV2B54z?=
 =?us-ascii?Q?snhCCllSF7Eqq5vIEXBdfWqxAK/vKC+xbklObKLZf+y2hfmXittmfWmi88yn?=
 =?us-ascii?Q?IEZjvZJmFmxlGL1LwtHhQX/Tmor+b92OmoAkrEGQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc66bfe6-433b-4b52-9703-08db090600e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 12:22:39.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9+cSweKtL80yy/LB3BQKF1TlXiy44Ujr0WVWYi988v8bOItRCR/pfO95na8gqZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 07, 2023 at 12:32:50AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, February 6, 2023 9:25 PM
> > 
> > On Mon, Feb 06, 2023 at 06:57:35AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Friday, February 3, 2023 11:03 PM
> > > >
> > > > On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:
> > > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > Sent: Thursday, February 2, 2023 3:05 PM
> > > > > >
> > > > > > All drivers are already required to support changing between active
> > > > > > UNMANAGED domains when using their attach_dev ops.
> > > > >
> > > > > All drivers which don't have *broken* UNMANAGED domain?
> > > >
> > > > No, all drivers.. It has always been used by VFIO.
> > >
> > > existing iommu_attach_group() doesn't support changing between
> > > two UNMANAGED domains. only from default->unmanaged or
> > > blocking->unmanaged.
> > 
> > Yes, but before we added the blocking domains VFIO was changing
> > between unmanaged domains. Blocking domains are so new that no driver
> > could have suddenly started to depend on this.
> 
> In legacy VFIO unmanaged domain was 1:1 associated with vfio
> container. I didn't say how a group can switch between two
> containers w/o going through transition to/from the default
> domain, i.e. detach from 1st container and then attach to the 2nd.

Yes, in the past we went through the default domain which is basically
another unmanaged domain type. So unmanaged -> unmanaged is OK.

> > Inside the driver, it can keep track of the domain pointer if
> > attach_dev succeeds
> 
> Are you referring to no error unwinding in __iommu_group_for_each_dev()
> so if it is failed some devices may have attach_dev succeeds then simply
> recovering group->domain in __iommu_attach_group() is insufficient?

Yes

Jason
