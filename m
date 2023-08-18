Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD47802D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 02:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbjHRAym (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 20:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbjHRAyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 20:54:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E73583;
        Thu, 17 Aug 2023 17:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSUJPQK2Lfata11kvQIoimWF3yedDJDJfudBmlCAsHY7MWKpr6IzzWxid27g5xF9iIUDpUikzQeD5dXuDJcVkV39ZTcwzowmNEAw8UTuj1GDp/i8QhQiOxa0KBk6SISAz8VkGT9pyFtKgBxpOEmlGgBk1VnDKm9n2/j0pFOL8Od0E29wzys318OXTiI3F/47mM6+4WSQHGmf4h3zPRmzHa9K5ai0drDf7tV7aauwvyWWDnX3mQpVkcMRIMXHD5BXMNhIx4qjfmWR8BHh7BrzhiXTpVFLzVZeaKApAk+a52soW3FEwa9HnkADT2B/Ol7SnzLBnWzxshTMVlHQu9/Vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHzsmlTsAVpzhs1ImNeAGuzxhkYruxKkkD2ZMlSblc4=;
 b=AtJJWtzjFvjm7kJK43MesS8NfotKQ2zQ8P/NBkNi8mJoFOJy1VUNbacbsfAty4VXxVoSjkJS8se+tGGEG3W3kmEXbXIiRPIQprh7JRyFrXCxKi9Qr3QsKvVYYFITKma1+rGuQVmsbpHpSfZarz/1wQoQdIFmRRGCWbvFqHhnszXVIyEySkYeS4LrFpTIznWvpgVALL6gtMgmcrLBvAX6yG39MgtTBUxJmgEI/mDhL/Umku+r5yOUjVfTiy4E5+2a4aDZnmgc1OWEytGwkNyG3PFgCidAkyLX6HxJ1iwYnBISkWm5somztLB/ZZR1xK5WKxbKBoSl0rwQ5beKymA4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHzsmlTsAVpzhs1ImNeAGuzxhkYruxKkkD2ZMlSblc4=;
 b=OJbytGOQV34LJ2BzaqZr7oR6ZsZ343xSEqJ6FGWFMTrZK0lC0qHjDutfCsTt/rHsYkm2QCzNsg1uPU8cnk4YnOxZEOGf7tIZO70bb9w2Ts3FKeGv3S3riLoEmtrihmMCEerTeeQC1Wcja3DjFdLB2DvOJH/X+6qnlGOfapkSL1mRjPw+IYvrR0H4xtUKzeTXOQK19ZzhfWduiVZxE0zS/7Dfud3rh5+Av6dmnRzanT+zZgdGkAUW4Q0g1nha7XOVDLUtI3YM/X/xt/mI8wTYSs9MxrLPqqxc0dprMmB73A7CV1nlC4Fs85rbj4qtRVNi8BxA1uWtW00ZHC8DZV46Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 00:54:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 00:54:21 +0000
Date:   Thu, 17 Aug 2023 21:54:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZN7BPMra5fC7YBcs@nvidia.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-4-yi.l.liu@intel.com>
 <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZN6MKnCOk7ufYnV8@Asurada-Nvidia>
 <DS0PR11MB7529F6CA52479527F7B87B00C31BA@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529F6CA52479527F7B87B00C31BA@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf69673-2c40-43e1-7d61-08db9f85a8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+64Pgcc7/4Ja/Yvdx//85oGVkIG8P+O2DhEpffNpuSNi15iHamPPA/4TcSZKel8OxeS+aEoSUtwBSYXKY7+23YIlgjVf14tMy5oI/l3FE6Auh3ktZqWI6Xzs2+JH+96P3JNmCMrVGDAx+qZXPK/MtK7EVGvXQn6Ytz/qwuMyeUUdgF/xb2/cUdhYV6A2AdIn+M3cjpAMbOWgL/gW7dOFQZkKtagkR1skrEYA/jrZdChEEapiBhy/lYSl0iEyjxYBAZX1Zxkk4WxmXKQbLxU99SQes4LsIJCZ7/rut7q2jXqIAyyz3BUVLvMM29Os+QLLD7KPQni/cc1sDLlqlWCoBC909TfpVJKWgmLdkxdXwu+8OzrAne5cK0v+CbFCGlpTW9nyKmA8TNTSMZLP8IazoEjq/dwtP8pQZifaGY74N1KrMbkpzP4PEEJMaV7fMVb5cgT5znYCaSdNeUTpQAuwAwDp/a7O5MVDd1eP38mOoi7WVj86dypoiB9MmjUy3WDvSDPMHM3OfUxqOnsEPqOCxe39CQLpqME4fbf39WrbRt/jVUq87f8liNwvkYrWDae
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199024)(186009)(1800799009)(54906003)(316002)(66946007)(66556008)(66476007)(6916009)(5660300002)(41300700001)(38100700002)(8936002)(8676002)(4326008)(26005)(2906002)(4744005)(478600001)(86362001)(7416002)(6512007)(36756003)(6506007)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vsRjHuZIHYOGdNvpC80GZMPKt5s4JMwDUAqEzyjVgeMRhWqp89WZAml2v6SI?=
 =?us-ascii?Q?EDFAKvcsz2Sf0AE+QmBL/CdvURInFiq62d6LRuRZ2uXkazSQ5KC9xRcE0dA3?=
 =?us-ascii?Q?nbRWhla+t9DDqzvjPQQKzg6dfM7mtNm35SmNa/hxje0527L9l2RMpBHx5+WC?=
 =?us-ascii?Q?NTEQd7BsxGul9zluEzXLmTbt6tYJ0SgoupGyuCjsWYNhEDwZTJzZZmVLpuVZ?=
 =?us-ascii?Q?33+jX68UJmMouHC2PLmBytuKgTnjFWm86SzX0AJHJwzzHJsJtkOiyynvdoSa?=
 =?us-ascii?Q?0BdODUypFZ0iCXxd5b7rbXfuB7BBj/v7YLyfgtQaOe5Z3bKt2Fh/68bgRe9N?=
 =?us-ascii?Q?f0rsdf9yNlMBV3hAQFKg7wLbuLRDzx68z4O0FUeXU0VVPgPmJtMo9dtwaICI?=
 =?us-ascii?Q?fhUBmibAUWkgKk/Q7Oht3JenyDOtlybSnfTOkdtyGzDOV7cAcsyntiqNIjxj?=
 =?us-ascii?Q?xdU5ipADO6pPCDAeHBhqxplXlgUhWbnWYJUSryMPOUdJ2Xm2QK8bN9wLs4rY?=
 =?us-ascii?Q?kfPTNwf2aGTmzYqrAiv5Xt37fwNe5DGvPqDyMbGxUjfK55kQEogfWkuYrewf?=
 =?us-ascii?Q?qj85jMqIDvcHXxsTA7Tj3ghIJrTj63CsITBYaePyRXhSoTl5u8AQsM7cKk1H?=
 =?us-ascii?Q?Gleaf0pafmL5/pZ8TXgFYK8WbyJ5K4tKk+hWbxoXftIgNllKcpDSUynALF4G?=
 =?us-ascii?Q?hjeS/nHGa7POdq0ePS8qC2znUUCgYVKaJm2RDKrDuICwHQbSmJ6wUXijSkTt?=
 =?us-ascii?Q?bG4ELVYo9SUn6+kZkbkA4uWcP8wxAkYmlcBVmEVyfcVrNBlMhvuC70tX4aK4?=
 =?us-ascii?Q?HRY1kFrVUqnH9ykP9cgzV3Dv6MUOSMP/lXgGsk0Qv2Qrv6HNX2YibGYusl5C?=
 =?us-ascii?Q?EJOoMyv2v2NwVtV/mKJayCW2nP3SCxS5zLt7vk5e+oJCnmxQFtphl/BlPAbh?=
 =?us-ascii?Q?kakY/ZSauh77B+QlM2mvfTyBvoHmDpl7C4R/Pp4s6X4OveO/EshYllftK25V?=
 =?us-ascii?Q?e9JVPGHmTTqPwqx3amrLpngHJdNWcQwkYyCIjha+LcrG1olYYweD+/pcM2EX?=
 =?us-ascii?Q?EKJcyF/fOaq0tRlvnSR4YKkNbxMUXm7lb6jl5dmyOJnqU7itmttNdfVMayD+?=
 =?us-ascii?Q?J4wPXSy3ezF1NAkyL7rqliZuoJtWcc962LbBD6IRQ+eMXcUQ4OA7We6MIpPN?=
 =?us-ascii?Q?Xq9KwkRdRXRB4qe7w5036EvTsmzo4Lt+GSlWS/EeqcvyPvgGufEt5GuAJgDi?=
 =?us-ascii?Q?l4njSIcVp1KTy4y8Rzk8yD7CFo3EQG1LY0f7mY6rLUnxYMR9LYy/eW84x7/1?=
 =?us-ascii?Q?Mx2iPTA1/CZbwhd9JsBPDyny5Owml5rS3LDzoJoBwxLViOFJTGJ3cfkLfs/S?=
 =?us-ascii?Q?MJH8ZDoZ7qrOEyCk0AYEI4XT3+VucGIcZZQ0ZlPwWibU8VVZARjPyl3TX3HI?=
 =?us-ascii?Q?ggzvPqwbE5iqpfaqnvIZUuZqsVXX1p5DnuQBkfhx2d8yPMgYC02qek+GaYem?=
 =?us-ascii?Q?MjmqN6yBQPhvKLWzK4XvadvxSmOPv6PAK3Ap747SFP4g90/ssuLPNHFybJH2?=
 =?us-ascii?Q?OI3hOrGheDM7ty2dHFxEjRr16AX9mq/88x07oYTa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf69673-2c40-43e1-7d61-08db9f85a8cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 00:54:21.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Sha9wAPlBVr0CAJv9SsX1sEhCPzmeQu6tEeooYCXa2G28P/YffH4p260E/OYubf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 12:04:29AM +0000, Liu, Yi L wrote:
> > > > +int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > > > +{
> > > > +     struct iommu_hw_info *cmd = ucmd->cmd;
> > > > +     void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
> > > > +     const struct iommu_ops *ops;
> > > > +     struct iommufd_device *idev;
> > > > +     unsigned int data_len;
> > > > +     unsigned int copy_len;
> > > > +     void *data = NULL;
> > [..]
> > > > +     } else {
> > > > +             cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
> > > > +             data_len = 0;
> > > > +             data = NULL;
> > >
> > > data is already initialized as NULL.
> 
> Probably we can set data_len = 0 and the out_data_type to _NONE is
> the top as well. Any preference?

I think it is clear to remove the variable initialization so this
branch is more explicit

Jason
