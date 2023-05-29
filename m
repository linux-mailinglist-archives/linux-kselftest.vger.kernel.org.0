Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD73715025
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjE2UAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjE2UAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 16:00:23 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1AFCF;
        Mon, 29 May 2023 13:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEpPU9Ehjd741nlk8nvsY+1YO8cq1yFJuDFFurhg459x8d2+J5LlZ+K6eZQsskPyx0ww0yyCTr6Ikvea3kneCkMJGe6o0/5KUnAtQvSmCfGjHPYgG4B5EJAwN0wLSyxv7tZZiW2B+mPcXBpH2iJVd4uLzq7echfwiyH9KqCcuUSs9KBcEzhcb4PMsyHF8RD6dyH95U3r1Ccp6+8FpL18J9LInDiiQtZAO8vW/jYnfTGyY2Gji/pgQjabGfcB76Epkzce1iUchFVy8lndoUVQZ1DhkcUSiy1BV4A4YcQhEaT4AFxyNyqzr9I5GPw7YVO86TFB6CmzW9w975qsZZOzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47R5ND/1B4bsPU8QJBPq0qqNvy9K78GZw5Ysf+HFCko=;
 b=U0HaH+apTEiRv59yFBmm2y6P+v5fAHhPFEGmIQq4CQSKe0H+Il5IezlSrkjERZCamAAisDf4m2d8BPJw6sUxoTvudtpg0x8/ume28p0T3HQLEPTYrFgebp5W752NxdbxpkNOvI+M7lrEmGeAWcf7HnhrZhbD20nUwvCLJdAXVXWK5/4xSoc9oSICLN6UxLAq0wrGYZ2RobgJTev40JC8d4T1l5UidEILi4gdgPjj+AmlCn/QJ/hqLvcJl5s8f79HAr3GvjolQn+SAk8h5ZmqWGtlYnWH9fL+J6wMP4MEKETu/aeb9osMox9Ht0nsrDbCozzNiV2Z3yoIbVJt+AfBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47R5ND/1B4bsPU8QJBPq0qqNvy9K78GZw5Ysf+HFCko=;
 b=twE8TLLYOhSM5dWtCoEEF0oUWR55D0WCcmPswrM7w3r7qwCSYIJwJ8KraQh8250n8/mYta4wD5wezeQw3B4EX20LQnBQug8YEpBHYUwVjzxSfpquzNLuCByNVDBIL9n6UNRKaXv3xhfpC8I14yXlKvkG3Sp2DB27ThQ6rUvfh3MhqqQECEt7J9kvn5OylwstkL7zu4/RM9B/VoTHKUjEZXU2yN0IrtaTNqYAjnCbAl1ahVax/axSW8bCCL+3g03N5tq5fRa/Sy2gWpjqEHivNB/XmJnjGVQAknRilo/DCvXbcdyW8ONA1p7jtJ9mGeT2U8juQ6HhSEX2pChq8IvKxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:00:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 20:00:16 +0000
Date:   Mon, 29 May 2023 17:00:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
Subject: Re: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Message-ID: <ZHUETinmrYy8zp/h@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-2-yi.l.liu@intel.com>
 <MW5PR11MB5881B1B7C7B14F776F0FD3F489469@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5881B1B7C7B14F776F0FD3F489469@MW5PR11MB5881.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:32b::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fcfdcb-e834-44e3-f068-08db607f5238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBCF9tWGXPnLQH5+LEoEUhmJP4cVAeNFf3jyrvuFbtLPH7tpqv146ZqZukWETpCPE0zqqns+DksRSpBrZ2tsS8JonnRca9eWYE6lOt+p+nwn1Bxgq6UV0hc92uktehi5GGYApoE2kx3iOa2uvSEvj+DVWSCb9vsEyPCmc+j+Apz1W0DydA6btsPJWBBUQQOAaUWvfWh1p7/ZMRhIeh1eigRvEj8IbmQxBLAvfDXLQGqSJp2y+H0VhMdZLIwjktBkPCcnwQ44yxYhuQZCsMUZhEMAhNmFqv3VjQ8hitptK5k2KyvdtWNj1XCr+JkuGEOb5OFBkK3i9RICfz7gmFRKA6Z707DJeYtoXS6dcc5kHq4d96dnKpcV7utsBXAGDAGkYrHoH4aFIS4eYO3zGu7XaK22ZKICB937yxuj2zswBQ7gbDImNtB6OVvl5wm/jbPQRA7R+r1ALZcZOmnZBb4qdQN7E+RWzp6feby2RHbpvX2FM+s4IeLKdKxEoi17gMdm9ezVkw9o58L1Br+XpZV63A/njq2znt4kyr2IogVG8GYeQRURDw/fgy+Ln5cCazpV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(86362001)(5660300002)(316002)(66476007)(66556008)(66946007)(7416002)(6916009)(4326008)(36756003)(8676002)(8936002)(6486002)(38100700002)(41300700001)(54906003)(2906002)(2616005)(4744005)(6506007)(6512007)(186003)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BsbRBJMNsRBK3sFaGmW8kURxanekFRvYF2GTgHS5t5c4znlDZniBgaldRS8?=
 =?us-ascii?Q?io8nRHNWrNkysiSpk8jJ7At7JGyGjKF8XQBAG7/z1l6sPLbEDdWByyymUN5x?=
 =?us-ascii?Q?8QF5j7VzmmhLuXN8jAOfxImRnmVPyyZz1Yz6IRjIzn6Py/doKU0lBab52aiL?=
 =?us-ascii?Q?lEcua7XdJm+5HVqxDHkrB/vE5IDH97EQKPZ66OCpsPN6+r6yNoBSM3ZzSjjg?=
 =?us-ascii?Q?avBgEUV60aU1aS9sMje5fs736OMY3THTa4W71dep/qvZo3qeAipd8GdHWvPN?=
 =?us-ascii?Q?Q5jSbXyIQgahNazHyFwEnIz2F0OORw2vX8Hsq6gGsBBKkiuvIyTnTCAdT8e8?=
 =?us-ascii?Q?x3AH0O0vPYQLQ4lDCP6dIPm5vY7hVCV8ULlpnlPDnxRNa/BExCLbX5BB2x6M?=
 =?us-ascii?Q?9SY+mxLphETDGo5DCGUPMTBarD8RaN2oDyYaOM+BvHk+UUOfMoGs/z0QJwOz?=
 =?us-ascii?Q?0hVb5GrWLiyYdplZ6ZI+YGJXVmpTxy7nNwr9fE6eieR8CSt0wZL68C9NrVWc?=
 =?us-ascii?Q?d10EhwchalHb3RtTeVnXLXgbnYwPaNMl3Kh8Bd3I4qMTDNdKtoo1w2I7WvcH?=
 =?us-ascii?Q?2FWEaKiTWmtEubdA6HccPpBI5uLIRiZgEHpkDCWKN11nu0h9zIk7eMyZZJYK?=
 =?us-ascii?Q?OOmjIsvAsgA2Sk/QIcN3sRKXBA4g40PHsVxgQc9GRvYy0Q+TsEbqbmFXBOyO?=
 =?us-ascii?Q?6V/vSCaQ+VjheUlpplvCuvwsn9FQm6XFq2YfvruJUol77XytDMtJ7dfm8ZV8?=
 =?us-ascii?Q?KjxINrdJcVtwWUSgNWy0Jch/rilTcxi90+1E40Xoj500qW7EqtI9N3/nZTrO?=
 =?us-ascii?Q?halDjvQzDuhWjIdCRxg2keBbIx6eQWXxqAgk5/pANKB5vw83i8SqwMRkvwPh?=
 =?us-ascii?Q?BAqpOMKlsrgvxbYzlZjxe+/5/d9Mf6bUIDjxyF6TSMFcuQZrcrdtKZJjPFyc?=
 =?us-ascii?Q?hZaLzTH3Cd+G3O7UiPca1yLw5Pcz/7IAeWKSGpkWJxWRlgW+ERpOMQBI5VEI?=
 =?us-ascii?Q?J7mdqL4IJPKGSz4Xko8lrVx+m77oiusSt0FOS+4bS4Hdxkn+rRVoJ+gHVEBA?=
 =?us-ascii?Q?cYJHQapeflIh0PitsUNkDxgVDh0Ht82rRoetqoojEzohk3ORZ9qbaHBnaUGE?=
 =?us-ascii?Q?RuWoqr+VqqjwPMOTUTPPbQFGv1EQCESRKpOYf3pIfrV7ApSlGNGUf4+a7SJK?=
 =?us-ascii?Q?YE0a7P5Rw3sAmLJ7NQY7qIXRI/QX40NCb8XgB8Fi+Y/z1MTs4TL0L2tjloBV?=
 =?us-ascii?Q?KGF2FQ7Vy/zLCJ1gY0q9AmsI5f4R334dr3MY3DWve9G2fJFpzTVyTBUY0O0X?=
 =?us-ascii?Q?ths1Q0K9jS+DP21Bbjc0l0QE5Dli0z6LprzmTSeNOZ33uUJraabwS5BMQicz?=
 =?us-ascii?Q?Qk3rOLuQbNgcNL4pqHkolFFjkXM1PKWyp9bI1+VjszwYidpO8bj58wMr+YGN?=
 =?us-ascii?Q?rTN+KPKEBLJkgceCrLwbsJPeqwsbaJk4p9LSRD6iTkhbNa8uwvc4TLEDE6HM?=
 =?us-ascii?Q?xEkbX1CYhKjUcAskvrBotzBqm6NQQHd/2T3pEq8OR69pPk5VXtiX4fDjY8HJ?=
 =?us-ascii?Q?GDVcdy7s6Z2m1RmLUKmC5ZyPqABXhUTC06NZoX0m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fcfdcb-e834-44e3-f068-08db607f5238
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:00:16.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XjG92I2hoI44NddEVBLRdhEikNsU3G+xJHgPspCQINiVdgzHA9mq+vgcvqpjFQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 25, 2023 at 02:28:18AM +0000, Zhang, Tina wrote:

> > +struct iommu_hwpt_intel_vtd {
> > +	__u64 flags;
> > +	__u64 pgtbl_addr;
> > +	__u32 pat;
> > +	__u32 emt;

> Do we need the emt field as part of the stage-1 page table info?
> IIUC, according to vt-d spec, the emt field is in stage-2 page table
> entries. Since in nested mode we only expose stage-1 page table to
> guest vt-d driver, I'm curious how does guest vt-d driver populate
> this EMT?

Indeed. The EMT is controlling how the iommu HW parses memory that is
controlled by the kernel - this simply should not be something that
userspace controls.

The S2 itself has to decide if it is populating the EMT bits in the
IOPTE and if so it could enable EMT. Does userspace need to be
involved here?

The seemingly more tricky thing is that it feels like EMT and PAT
would like to be per-iova and we don't have a means for that right
now. (and even if we did, how would qemu decide what to do ?)

So probably drop it.

Jason
