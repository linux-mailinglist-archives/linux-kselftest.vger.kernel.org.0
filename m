Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7011374DB63
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGJQqX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGJQqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 12:46:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41984127;
        Mon, 10 Jul 2023 09:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6FRpM+aFdA1BVbwGQxTDwtxDnSM6szDKuOUw8JL0iEpokCPNn0JWwsgNz1GFr7IJqVAT0LTj16fTNc1ML9At4SyuI3CnCPgYQSFz6wlBpdJTdH04te3fnqvLtXlB7ZdEkVkTWaTTqE7mwYq6LZlOxz2VVgv7w1qINm4tWrDGS3FOmKl7Bc2eftOuh6hdSo5HRSVd0GVfxGpryqAvoKSu+I3ir3qikQ8Gcp1Z81FkuQRAmZzETa9V9dEz23PNkYnCVa0oM405PPzDWZH64+AZeXcvsolDele/JBtCoNVykM+bPoU3iTBcxO8Muny/wIjWjk9+itkuUy3G8FV6Z5QyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3nP7W7Iuu7wgtbreMpmj7h264YV9YGhv06MpLJKi1I=;
 b=hSPT3k4z4jfYwzJ/y/JjhcDmZOL2Tjm+ozp4i8sMm6dXKsZeiUWtuXyt4A3vCTNE2KmNMA3839iU6MCosXK1BE6uIRmNjPCcBO8QH/EQwK55Sw8xLrwpFBZNlzRN7644+jLQCap1x8YeQqwZf3wGqWEXRjPOCG871eYh4zrUX4Gt9Bdks2Ds4a/820MFsB/89LgpO9Kh9Xg6AFqCJvVPzR3mW4RW4YGvCxQp4po8JI14Mas+4MiI/2nHWeXy0cnU+yYjAsEzsNf5o/3ch+Wr6zq3+AG/ipnVZB9w8kR+5CpAEw9DSBwjU8FnUOpL4ujKIAKNm6qkZa6FZ8i6HtVELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3nP7W7Iuu7wgtbreMpmj7h264YV9YGhv06MpLJKi1I=;
 b=PhLgLnmhoL6pWWrOM58Y+PX28QQiz9Go0bI61BD3hPsDdbMe2s/FiorbP8fHKxQzUoFyZ+RT0yJWEndKc6aeM1MhK7bm+O20G2573ea8zEtJ0e3oKyofM416nIeK8I6EOiXn0d7F3o+1RRKzGhvUzYPpn3jrY4OHhbVNpqtmKqtxaKR/822+T7rwaDp3pJBVhcF7ehwyIRLW6K5EwlCFAZAtCYyGLuBE2YGR7Z3oQp9vI+oT6mHbFIkPzNpxfz0wBJxxqrguLXJN+rtDVJFyZr+QNRES729xmEHNzV7RiYbtfYk0vVYBZr+E5y7fQJLhijZsKKKUt+t+tsPa4QsnmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 16:46:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:46:17 +0000
Date:   Mon, 10 Jul 2023 13:46:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v7 14/19] iommufd: Add iommufd_device_replace()
Message-ID: <ZKw12ADWodRAFB3j@nvidia.com>
References: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <14-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <DS0PR11MB75290ABBADE3CC8C12B1AEDCC32DA@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB75290ABBADE3CC8C12B1AEDCC32DA@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0097.namprd02.prod.outlook.com
 (2603:10b6:208:51::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e41b479-9f6f-453c-5236-08db81652e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TN2mQCG3hDm8kBH5XUJPmEL9knQaw2ImEydBPKH8tpGbiT7eM5SUONwCBp3xw9018du7yYk1ADFHGXQdrR2lhMuHMu08I1P3O4qDLZTOpaSELdFhldmdymkKsytKuG57g2DcnysiuNGiYMKj12FHIfEPtyvszAAX8+10moIqK73jcoSZKc4gIIuxYbYPB2G3EVfY87djwV3to8BzXxJP2tziueQVWKNe6sHbfhyv9QR4wVd8UDRTQbyCHvSOjejwb1wD8VFhUKF7IKA3tdmt30mxBMNPxLX9Irc8UhBjxctOtIepQOXFze22AVB+G6+hjBCRM1EVbzyEI+X5B0yzSjV1+l28BO7n09FCiFLg5QK/kjcsIBNgq5KJnmagD4DNguYc0zpMpAidv2ujTqQjDKtQmDXl5Yp5UI2rmoKUTZS0wtqjbFeV2goD4Jw6lYJ3bpX2MLuTD2h+qJ/7SYx9LVnyeLaOiqhbEO6gP13Rn619HJkVqR8geOXXlD2ycG79z0UmK714+38R5jHpOJ8u4aVZnTqW3N6evazxSxTcP/iX+2rHtcLsuWj0kePLjmYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(478600001)(4326008)(6916009)(66476007)(6486002)(36756003)(66556008)(54906003)(316002)(41300700001)(66946007)(86362001)(83380400001)(26005)(2616005)(186003)(6512007)(38100700002)(2906002)(4744005)(8936002)(8676002)(5660300002)(6506007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlpB98OXr690UP5z01r4a7VQnyHkGAmVRiNUh55lNr2YD5Tz2+6yh6n8SdKs?=
 =?us-ascii?Q?eIPOnz/dxa8dVXgqjw/IarOpNhuC4npl/xfHTaasSvkvfzByx72kZWm4tT8+?=
 =?us-ascii?Q?24qmxjpHYPwyP+cRMEB8yRLCMgKBiwpwkBx6iD3mTm5Wt9ZAQAHxn0/hWiay?=
 =?us-ascii?Q?Ij/oEQgdZBxIzYWAWz6vTiaLgE6xtEOUJDszZ1SKc9bIY0nqOeWLesLCyqol?=
 =?us-ascii?Q?fK65iOQtGJ7OFDoo0Gr1lt8ihI4eoG7WKgKltfX6E/ge5quGIpMRSMo2taYb?=
 =?us-ascii?Q?Nq3LO2YRG7yfcxzfmnNw8V1qpBH+OnjlVJ+I+yQicXTm1t6mA0qR6dXTx8rM?=
 =?us-ascii?Q?c9O2dum90FnVSLJ7X4SSzBp9GBF4UXnktWoUYHywnofaxwjZ6oCYzpfYu8L0?=
 =?us-ascii?Q?q5R2LXFhG2dzFroMqaiMRBmOb6rA1JOSyf9tRFIIfpHACGcrM9tYI5AdY//u?=
 =?us-ascii?Q?QaajngwpKi3BNoTyS1QOV7jC5iyWzRZbxogo9rbo0TzKc3yLXyha1zwjEHH3?=
 =?us-ascii?Q?K7a+1xxRyxcZEXt4VpWX+iN1hOVT4T5uuvzz5s3ovzNfNrIRgbM6obdAk1JK?=
 =?us-ascii?Q?Tw3v0b5wnKA3g9ED8Mri5STu1ttGKE6+AoL1O+XdEtSThtOYwUqzMiijwSMS?=
 =?us-ascii?Q?gOXRX9dsK2y9EbslzeP/0uPT0kXJY48SbeS742S8mYGAVnRai9s0R+7JCCGn?=
 =?us-ascii?Q?s68NapQ/DZga77yedqWZHO2evHn8J5N6S2sAgeSOdVSJln67Ryh7BT18fH+S?=
 =?us-ascii?Q?SuPy8mZszMrIfxcHMnjBipY9KlO6kBDn4UGlLZWaT5W7fVar9t3vVs4pXwkO?=
 =?us-ascii?Q?Q7bzlNkb3N08U+IfYUSLo/UuHAYWWVJpJmJ9NKvifkYlWZq+DIaRaSG2rcBt?=
 =?us-ascii?Q?VZJEtSGkWU8KMBI9CVUwcHm+yeKdIzskkmIw6OdjDcyiR85ejxfFdZ81ADrJ?=
 =?us-ascii?Q?2rP0DexCHS88epZAklGsCzO/0c1toH5Vbw+fnJgYYasaVcukIY7gL1W30jOu?=
 =?us-ascii?Q?g3jW95gp8pZJX1NhAIixwJaPlFd56klU2h4lRzrDZCCRUU/g7gwtpZobqPt0?=
 =?us-ascii?Q?NSGj59H2W91ryxt/a4yi9cgD4cfTIgET0aoqMPP29Z/IZDD1ZpNKGls682dn?=
 =?us-ascii?Q?wu+tW+zljUo0mFT/RzLQoo8VkQYXOrRJwjGoPEEFJJtlO9soz+KfogLzsiUp?=
 =?us-ascii?Q?5X9S6f9mrVdWCZldNsIYl9HOTYlZnWRZXDva5un3IugPaeRRQj2/IwqUXcmj?=
 =?us-ascii?Q?27TJ4ihSGasehH1zYbAptaCBfDUhiclcUqG4TKL3casb83TcSr4yEYkrcpKZ?=
 =?us-ascii?Q?rUcNmNN2jXg3A5H45d6gAFILJVgvrHuZ/FN0/nZFLK9yrhYwuNNk8y9cD3/0?=
 =?us-ascii?Q?90ogFlDm1e9cg7+0/WcpoXO18Q/c6EoAtHkQJLWa7QNBRQsX6BOdL4IiIw9d?=
 =?us-ascii?Q?WDfX5BRPrr1VKrqDkFOX7l5n2NuFnvrGdC+VQtjReKvpgkG8M2y3TOhZLb4x?=
 =?us-ascii?Q?Im6L4xJ7gECbbKsNHBZoiiOmtc9Eq0YLxlChRPKKeipYK3f2OalZK+DZe5I+?=
 =?us-ascii?Q?n/IJ7KGrS1WwLq5P8tS7ZVlpp1dytUYRmHq9y5T8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e41b479-9f6f-453c-5236-08db81652e8e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:46:17.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e19t7kJ4hyMd8mynZBkvDi+w/Sy75DYkk4/JTOzHkWBy/K1zg7K2iLQteVL0w0Bg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 07, 2023 at 08:00:37AM +0000, Liu, Yi L wrote:
> One blank line here would fix a warning as below in "make htmldocs".
> 
> Documentation/userspace-api/iommufd:184: ./drivers/iommu/iommufd/device.c:665: WARNING: Definition list ends without a blank line; unexpected unindent.

Yes, I did it a while ago, it will be in v8

Thanks,
Jason
