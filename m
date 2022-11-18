Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7430362FEC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 21:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKRUZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 15:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiKRUZm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 15:25:42 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34061757;
        Fri, 18 Nov 2022 12:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtuE69vlTdcg3nNHz8XkuEA87OaIqLkfWBykxbtK98y3O7lsuvfgDvHvUswajT1cbQht10jovPgEQdhTiJOl/sBhb74glgECyWaVP02R2hiuKz2MtdUTJPzJhT5P5aebQq260MZAAak7rJiQdQlXRBexut1wYUEUYuphJUl845GhmNjjgsZXos73wLT97IqpCTbzlDUH75pT1lg+1ccLDcP+cGtj5VyrrXdZk4mYqUpM+P8YDIvHylwKVzmLtvRx8AY6cAbnW/iXyj6uCivJx997dfQ5zb1QHqNHC5nzf9uvj2ScYQMv7iHhv7rQRGiK00W/Z7X9jh3QTKBg00T98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TvE6t0oS+XZ5RvuMvLjy/o0DtdW0rjSujBvdW8kDf4=;
 b=QEYVQbUh1N80c+f2G5GQDTwi7NLnySxQFQQs3aBS71h3TuNaHUveT6VYJ7aP4JNaaPAN3tbHi0xf/FzN2WEDhmd3pxBSh9ZQsMtbCWaH18RGdw9ba0L6atjOh7zTLuhEublsqaW1LPwo4wPAoonm4DxhDeZuQaT3wZPpkvpyqJFxM2xRO87ZpzUDGGu7ZPDyzNkoylj2VZK/jxxWJruiJebYq4vgVjkDMRnn7rLToD1piNUpt5Uv3ppxW4CjAX7T8lOEMUY62SneW/WE1yEeYY6nVpjDwJkb74tqUxqQK06oLF4tqfdmrbfgskL0VRBujJCmItY07FrZ243e9FCs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TvE6t0oS+XZ5RvuMvLjy/o0DtdW0rjSujBvdW8kDf4=;
 b=exRH+7LgGbl9ji/rGsRS19/+tBQ3VtB1t6AsfP/wj0GLaO4ASFZj7fpFpXwkxEi34yeFjbliUkNlZcPYmyEMHU5KCIcDWDGKBgTBNFuR9u0QYY72LKY3OvoUO8VPMcUs58WrQy/AHIAXf5z2/K5fkM7h7RRFoSm0S/Y4QsyvnOQ56gTfcCy8NvOT89EpZgnZk4T1ZXKip/OmKNloJo4bKT9YPQ+Fv+e1HOHIXI9EoNqPqiJBjkjgk1f/6+BS0HdFg9Y5y5bU+7HRrXQdPKPBO0DI0mRLESrobZiOXKazZI3mTxrATan+CrEXZ3MPh17S0LAdKx3n571+vNjRdFR3IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB5512.namprd12.prod.outlook.com (2603:10b6:a03:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 20:25:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 20:25:39 +0000
Date:   Fri, 18 Nov 2022 16:25:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
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
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 07/19] kernel/user: Allow user::locked_vm to be usable
 for iommufd
Message-ID: <Y3fqQbc9VUMVxpFK@nvidia.com>
References: <7-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <7e8ad9b6-f4d0-0aeb-8bc4-717a9719dab8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8ad9b6-f4d0-0aeb-8bc4-717a9719dab8@redhat.com>
X-ClientProxiedBy: BL0PR0102CA0014.prod.exchangelabs.com
 (2603:10b6:207:18::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8f8605-4114-4ab2-f680-08dac9a30ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUS899nDOvXNGQobvmPiWBjEALnM2jooAiM1j9xCarXP2KGZL3c+x6ovTTTyOoFheWS+JmZZCtbqGV8wpHyYwZm1jNSjWnrOt+U7KpZ0TLmSJKhNCna936u8V5P9L20WFMovUqrZ7siif/1Oc3HGlJA0AiqrcxjjLSucnuOzMvbTFPEQLhwOZEHzRlztLKxEVwHn1wXopPu+96P93jXO6Wb0F2B+PT39DTPkvOior2Eb1a0gCBAtnUntfXfXOjqDiEdYJBgCpuxP/kfLfBLzPS7Am49t8VQ1R+aNbm2HNoj0QL56F3kMHvSu89sP9+ieBweiSX0ED24cdHojhqFkVlMyEb3cEl4jFK8vXGyi55tSJ3SB5CW0+mQvDu/L/dzBZcpFnN8rh6rFoy4ViDK5rEt9ZIuw/ZscIQgnvSbB4gQ99eHxpTx7HQ/jxbZ0yYJ6blqJ00gCYDptOCgr7lwmEjtmHzPWfBTFb+xNS+LHRib2czIjqV51UaN3AQbeCG8QGerTB1MMMvv+hZh1SOGPaPxfGWfKxSYVUP9C1/9w/EhVtD0oATMMqrHXdLWnRXZtwexJhYSrPXlMPUYlMww88EK/48wCH0Sj+5wnauQmEfYnxJKoacorY3AdqLeOWMY7VydBFfDHOpVjHC0ZAwDmDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(26005)(54906003)(83380400001)(53546011)(86362001)(6512007)(316002)(8936002)(6916009)(2616005)(186003)(7416002)(7406005)(36756003)(5660300002)(8676002)(38100700002)(66946007)(66556008)(66476007)(4744005)(4326008)(2906002)(41300700001)(6486002)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u/hM6ckSK60bgH7/6dDvESaE0O9igHYS4suy2WaPoFdVXD+OrpleYS8hDJTE?=
 =?us-ascii?Q?ph69sU8Vh37MYOLNTHfyhgPJD6Oe+Ss831wxCn6YwST5hj9ue730jUHQzT2/?=
 =?us-ascii?Q?CGXvhM3I/zpiYMbCksOfPvCHN+x6JVRdOwuIW+ee81yF2HYJ3HbJh5k8k6/R?=
 =?us-ascii?Q?VI6p8bL9DZxHKBPpzCuAMjeplNvfu6PgyE2OmS3nNBI2OP+kISt8aTvRBS/N?=
 =?us-ascii?Q?ZgCV0xcdBlSbLvqNqgCwhYEENaj1KbgTbmUQFWVvBY6WcLOmRdrH6WbTVX4B?=
 =?us-ascii?Q?eJBNVgM3EgFOL9+e6RW/t0dCXHrG0tszpnAgFgjP45FgEL5L9hp8PcC/o3cN?=
 =?us-ascii?Q?PE5+HJdfK9kmXnb3eaiowCGJpHRq0/IXC5NiiXO9v4p4Wf+86mX35MLWtlaZ?=
 =?us-ascii?Q?KI6D4HCQTCGEhvrsbqqa5PylOKCJ+4JIi+K5h/imtdK211XmQjVEC/0DkE4j?=
 =?us-ascii?Q?XjdMRoyZFqeCPkjb0ddX1Fm3aiKMdRfDdAVvHLxL1SLw8oJ2uZlkyaaCY7qj?=
 =?us-ascii?Q?CwqoOFMhp73+Z2zute2GVILz5yDaCC23DJMRnmN+zrOgCwARX1k9X9vvEDaN?=
 =?us-ascii?Q?BC7CbVZL2lFL11eTTI7lGTGUJ61KlvTbWxWp+niDg8mp/vrPbdAR8KO8KNWd?=
 =?us-ascii?Q?z6xLsSpzd7m3QDKQojHiwOSO1ajhszX8x6aOUEzb1Epc0hq83hBSW8ZQGQDT?=
 =?us-ascii?Q?vCQPVM7qAKvQfliotV+c1N7qh9a3Q6dE7so9Oz9bOeYanSDQK8O0Ur1/s7Et?=
 =?us-ascii?Q?ofjCF/9RaeiMuP6dr+sfrtCpTuD2UuU1yuXP8UBsTupurU7/v61OfixebPKD?=
 =?us-ascii?Q?e8zhVA/E6wS25iUdDM5tW0qEEGXGcA97657E+2IIrXC+pAST7jS0irFkwL1R?=
 =?us-ascii?Q?20/hKrSQV//4LRAQeCqDcz84bmVZr7A4tduusds8KqbEE5kMsV5iSMrjRuD0?=
 =?us-ascii?Q?O47Sn98u/4J+sGZSvcgxtNoOfpaqltRSP/YVL4bU/kRf6TqF7se7hh/CzYd2?=
 =?us-ascii?Q?YZVd8q/KV0N6gCk+0ZwN5DORnemUDqr3sSe38/E5L0YDyf8MbsJaqCwl/plE?=
 =?us-ascii?Q?4n3vAgxJN4AHS1jrHJbIli/Kv2aL+M4oj9qlfJtvdXCaLMtqkMSQFc4uGNOK?=
 =?us-ascii?Q?rz40bq5klO7t7JelnH5Cv8tM1Z/L1N0gRUXS148Cnv22Hk1SrkJP1qwl31J4?=
 =?us-ascii?Q?IFGPjN65rZf8pdbo8CE9Xw8iH0bqRkfmcblTkL1KiskPrSVQT0f7t7J586k5?=
 =?us-ascii?Q?L6QAqMPvW8dQBz9Khf3sY6Iq+494imXTqSgeuQPBMtVpp1RT3NuP6/gObsJV?=
 =?us-ascii?Q?qS7rJS3nAAU7r2gB69+A7eS7oqOP2iSPP7bsp4ywWJigXk7BF6DILZ3jujg2?=
 =?us-ascii?Q?u5+Ch3UCbgDT3LP5QLiZhbTW0OOINxJtUnVkfCGmu3Bn5o80RDLEzFLzs2FP?=
 =?us-ascii?Q?sRMPCIiy/8POIQu5x6e9uivV6McgO7KB9H3MbfdqBtbeHV7cPG7vTLUStpfg?=
 =?us-ascii?Q?oc6Fz3vRxZcsz8GK92QsMb3lyhmkF+uA8gh8z+AKvBu06e0uafxBBya8Siu2?=
 =?us-ascii?Q?+oCz/7zmgeWkt+8gZNE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8f8605-4114-4ab2-f680-08dac9a30ead
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 20:25:39.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TcQQr6X/hwLixanXoiW/7Dt4DokMlx2FOwYsNUOSWJiiJkA2az4EaK+Qx3BMbbi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5512
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 18, 2022 at 05:28:19PM +0100, Eric Auger wrote:
> 
> 
> On 11/16/22 22:00, Jason Gunthorpe wrote:
> > Following the pattern of io_uring, perf, skb, and bpf iommfd will use
> > user->locked_vm for accounting pinned pages. Ensure the value is included
> > in the struct and export free_uid() as iommufd is modular.
> nit: s/bpf/bpf,
> in case you have to respinned

Ok

Jason
