Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2D61F5B9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiKGOV7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 09:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiKGOVf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 09:21:35 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1371F60D;
        Mon,  7 Nov 2022 06:17:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Deqpk+tA1ppiqO3xdeLHFYrM8HanOc1bfzpT+snBbwIpxGTLWFc1WdaqkgWKBWpzAu2YlgR3wnG8fJbzWXfi8kB2DLcYNjqac3cLB4u300sKor5Qm8i084+6lJHRM9sHXFVlA1SnaNxKNVXE++DkqkDJzKNMvVoGHXI+dvXa78n/mFrD8W4ysJz/gi5DdSP0VsnzpDBR7+4C+m9zx4RwTLev8u8vYn2avDH4KJVdqyfyvZpUzO4aTTgstchfpRJwb1M0rrGP1q+daVLlMq8SFOuDQGXlphSqK5IEmSAsSgMi7SPOyt1eqyzxDgGIBf4NW0jJX/4+mvVB6nYGdu8xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtRVncUK9GRdI6VVugqfMloFk3c01iNjawVr6wsGnHM=;
 b=D7kz2LSj+2uhptcVM6C3nB9KuIqr+USgipjMNC+sHpvwAAEEDQ7h0OVCWyMka0wnpwb4ZLUVxifAK3tgkfSxLvUpCowTuttgMX1s200HkrZzTvEHZIgXfASP3OJA2Q119wbX7Z211OVm9jLSj+EtTDWORW1X4IDmqwr8yWQwqTMjW3L8EENQpJTQCHpzGhhDBonNJqJEl2aOWew9Xxq51E/ZtvCou2OuTmyXRQOfkbzqzHvfF2NAzE7nr5FBSFN8jUhsXZh+0I0aWRZjWRp8D0FpiDyo8yAUkwWedbu96LsWAmk1xaFSUtu4HDRh6xZJT8M3VnAsqx5vYFEC/Fg6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtRVncUK9GRdI6VVugqfMloFk3c01iNjawVr6wsGnHM=;
 b=EE8gSXnNj+9vN0Mg6vy2TbvjKmQErK+pCLONx9P1JOz2fchVZE9tAIZszl6edfBRVB5FNhxu7P2tC1lMg+ThroAlRPY77JZ6BZ3GpzqG41HWiX68bxE1NwugD6tfpCaAiIBMicNSql624qvcrV9mtcCI0wXJAPnhaDyuBryX1PIBTIuv2B0wPLu2LDHqEDaSPbozcKu+ZvySNXJgcxgULuxoQqVPEX7b/GQKuPhbWQ58ZcG21UtqEj55s+zX6D/tI90YOfCMz8fvQcg6VwJTdugHiyh8k3DlCpHdU7/d+5IHwp2R+AXrragIntrXEtanQcdTB/yTw1yfDRDy+yzFNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5042.namprd12.prod.outlook.com (2603:10b6:610:e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:17:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:17:39 +0000
Date:   Mon, 7 Nov 2022 10:17:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y2kTgmcuzbj8UbE3@nvidia.com>
References: <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <32d495bc-2dc7-1cc3-9c63-31f8172bb394@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d495bc-2dc7-1cc3-9c63-31f8172bb394@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db7b159-86e2-4cd3-709f-08dac0cad375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oduClvcpWEdwJ1BZEKufOtziuSbmvQhjFkYPmNhxlebKkJo1tPTRqF6DC/9SfnFEG2vhswuj8URmB6pfiUJ034Oybf8TvGH2FdY4hjIg2l7h7mMOYdTIAcFuuRXa03iXMOJgEMF2n7K5AsM/mKAgYBuGl9M6VSmvB1NTd0SvQ4OWK5tcutxYlObL+dNlyoaQpN2B8MGxRL9AC649Ng+9WR5seo2lbvIoFF0LmL6gct7efkR/hlJpiaWEXNwpU5NX16vyNek+XUeawZMXwrjUq/GR6GzKuIergqT9wahpVPk9BAqFJgKtNRL+5wgV5vr4aLA0zA9lsAvaB/3834NhO5OXvJd1onjKNqiY4habv8QgLhSjaDjXZ8sMqYivg897OUf9bSJBDXNB5tO0z4l9OzVLfBVmR2SuO4MfGxgehzPZzai/qQgxe+MjFr47k65tzrmDFrLDZ+1SNRtQlfoLDFZIwJbyZcT9UrVMkT0D//rx2K6mUrIuphe8o0lIPNvaE45Hzsh9HnCnRZ9LgtLBCEmqCJhtGQnWrhZ5AxG0c3Q6gMIGLVMfdIGrICb/KvPOuRt7BVCP7kFwZVZ0yzeKTsq8ytUW36idc4dFhZ2bCEBhS0LCrZiOnYW+X7cx2gxZV08xYXmZMASgeL9HiI9TtjN3DOrPDPcpValNKNeV17I975VFTfYuesybSEpl1GOzfaNuopaj7NyIS2fkIOLDcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(186003)(66556008)(41300700001)(66476007)(8676002)(66946007)(4326008)(54906003)(6916009)(8936002)(7406005)(478600001)(6486002)(36756003)(2906002)(5660300002)(316002)(7416002)(26005)(6512007)(2616005)(53546011)(86362001)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nV3VFIP+A87jp19FeaNJJuJTWGY/I0Jdy2c9b0iFQyBP6kFvwzGQ0qb0SA6I?=
 =?us-ascii?Q?tc5Pf3yFNAca624Ebf2BAA6W06iLN5pMPvaKJJAunbUgLSxKJWPSO2k6BWNv?=
 =?us-ascii?Q?Sc52nNaIWp8HBmDh8OhCMvmR5RXF/Sl0UlKFtFn4T2w9y76GQtIysYS1gXCh?=
 =?us-ascii?Q?mlwcxak/X1/ITUrMGHtmbjKF0xKkzl2ONfrMSGHsFE/WA6VGkBLM9f1vZxC6?=
 =?us-ascii?Q?qbpgQGZsqeoHguw89Is54/LifMaEyZXmRz27v5Gjsp1NziXyoB1gVs2zKkpP?=
 =?us-ascii?Q?SQ8MiIiH2NT5AYosGCBmZnzsVZCbe4BQxUhUz/qDZJAX1gLY08bsrJUiTdvh?=
 =?us-ascii?Q?AbX0RNT5r4tTd0ur6VP4+84l13QR13g4KSMJfEx0IqGmFoowUROqm7OJkYem?=
 =?us-ascii?Q?TuFuAEfsMVbMKnTXvy4aS43VVmyLVBkmOldWHbNCNQsRaVX8sVay4yMkmxk3?=
 =?us-ascii?Q?0JAmRssUAP8CQUF6JeUi0W3ET6yzbnO4ahBkxaeI49jhe2DXYaP3PcrGSwop?=
 =?us-ascii?Q?D4NXFUZaNasIXJFaRt05yhEAOnJVhsQpE/O9ikwcTxkcLm00rkSlrmeLy0Y1?=
 =?us-ascii?Q?max0Rw3jRFXpfN5GzlTnauRSKIpYtgZcInUIY+kaVyLtoPCyBBSjIr9Cyfpl?=
 =?us-ascii?Q?bZnk1keXl0oPmSFh/3uCFaN8TNWZRWVhF4CnbZOhW/BgXP0FC9TqyonYHRQ+?=
 =?us-ascii?Q?pO9CBkDMjIrjz4qPkLUa6jUf3zCQMFB7DqvZaCpfPJ0YkrFJ+shtodkfAyWf?=
 =?us-ascii?Q?HJSl4VJsKjYyoMFLjAof1IkXfIuqGWYNhuwdTY8hXXkuSqSdlK62GN4FijaL?=
 =?us-ascii?Q?3+kjOyourhmTQYQj7qK99cR4a44nj1MIhxd5FJFg5ofiijBcOeG1az5b8F3p?=
 =?us-ascii?Q?NlW1/p8XSvf2oTCSDrEvjfl+FaEIZhqBBt8UYNcOjnKMjoOL6gTBlzvExAo6?=
 =?us-ascii?Q?iggIiShLJqY3CPy02B77H7bTt6jIzAsgBrxmFefOtbj93N8qTCq43vpaaTT2?=
 =?us-ascii?Q?Fa956/+RLOFPUABkZhZPfbxbFvjfR2YWqDdI7mEj9wSUAhSKmh5NLcz2DGZF?=
 =?us-ascii?Q?iOyIC3DUcndpjYvEPaLxb4u3efyZ+7yRzixd2oPap4k7VsenDU2Pu1BFVdI6?=
 =?us-ascii?Q?zQydpj8mxfuFKo0jo8wRDWzOdUOqhqOjNZ7Vs+znTtEBOY3E5ZCf+SdO7BYl?=
 =?us-ascii?Q?Xo0iVu1rDxVU7Ip4o2MJlFzQKfElrmCXk1A8JweAdnaN7OOlqR3j36xoiycy?=
 =?us-ascii?Q?J+zAgQagJ2qnJ4FGXraTXg3LJh+RCZRhYMzcRUbInVeNS4TxHQTuI7JKsnta?=
 =?us-ascii?Q?lhl3gyn+bQxTxMQScq4WVx0Yo/CQezhPjbgX39Xs74PFbmylgWtlhTSQxn05?=
 =?us-ascii?Q?xx/GyY1arDeiDr6p420vC5aZbeVAEd1+AG+W16e+YW40bKbojjx3mVKATkUr?=
 =?us-ascii?Q?KCkZUSZQFECPZw3PnzsSHy6RVsdMBud5dWLYWEfHqQCJF59C9x08SiETgxSF?=
 =?us-ascii?Q?QLUhJ525I0fYlHTFYeUX6wkHwrnA4mrz2+vvPV+15G5hyuZvDQ1DF5lmGkHV?=
 =?us-ascii?Q?UypGev794x09pkVtWHw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db7b159-86e2-4cd3-709f-08dac0cad375
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:17:39.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21+ctUFyQwVLFfcNF55A63DnWA0lue0/i/hUD3YH5vpNu9BThYHR1NyGkLR0Qoo1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5042
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 29, 2022 at 03:25:00PM +0800, Baolu Lu wrote:
> On 2022/10/26 2:12, Jason Gunthorpe wrote:
> > +/**
> > + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
> > + * @size: sizeof(struct iommu_ioas_iova_ranges)
> > + * @ioas_id: IOAS ID to read ranges from
> > + * @num_iovas: Input/Output total number of ranges in the IOAS
> > + * @__reserved: Must be 0
> > + * @allowed_iovas: Pointer to the output array of struct iommu_iova_range
> > + * @out_iova_alignment: Minimum alignment required for mapping IOVA
> > + *
> > + * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these ranges
> > + * is not allowed. out_num_iovas will be set to the total number of iovas and
> > + * the out_valid_iovas[] will be filled in as space permits.
> 
> "out_num_iovas" and "out_valid_iovas[]" are outdated.
> 
> > +/**
> > + * struct iommu_ioas_allow_iovas - ioctl(IOMMU_IOAS_ALLOW_IOVAS)
> > + * @size: sizeof(struct iommu_ioas_allow_iovas)
> > + * @ioas_id: IOAS ID to allow IOVAs from
> 
> @num_iovas: The number of elements in @allowed_iovas array

Done both, thanks

Jason
