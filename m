Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657E77AD86E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjIYM7s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 08:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYM7r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 08:59:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F39F;
        Mon, 25 Sep 2023 05:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSDeKhq81L9wnrsdsSyw3FR4TLBSepeX4aawNTJaon3AR/IbsdzRo+wzmpcMmDlT/++OfKA0EBSzmRF2GZ9mcU5Jh+Hwq8Tf3TzZRJpJ0IkUK1HSr4VaXtFMb+yL5ZOiGhF5qFRYPSCD4+CuBD0PAdMJbkWcHdhW3qmeCY/nl5CmykNw2XiBnyy2uvN314eEEVhRmji6zU5vtDCtKLY/UwZq94Oh+zstsa39+99O1yib0CZCyV3tNyRmaYwYUsieJdCY7EddvgjvdWSWywecNz7VtPMdtilLApGIG4wn0VxSH84inFUTOJDwndw5jmKWL6GLfAx4xZtEtmrkCNJ4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SkBAX4iUwye6GYrPHKY/e9XESQOLrrGpdKgfPIDNjA=;
 b=mNohBxZf12yj/hU1wG4hhTICEYi3pNa0cFTgkyjEemmDSGzBZaO+IT1wGWxGt4/XhYwZgpEBbyEPPy+5zHIHs6zOv5wFCaWcoLp//RJctAhpfqLDgrk78PHhcde+baWbv7Z5wbqA0JRBw8stJbZ8vvADVmtnPeXahIG1UyLpwkfB8bZsc3MlPOzFnAnRmrwPN+ZZodOdupoGkweJ03qRnj0sMODWzEE7UvpbY77SeZAC/qdGVuWddJX22339FrA3Y1WLi3ibv8Qn7Es3MiG2nX8L9Lsvfe2nUJWpoLJbpLdGiLGc80JsOTs7dgmueBFkxE+U+6v7aJzaPaa+OfyofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SkBAX4iUwye6GYrPHKY/e9XESQOLrrGpdKgfPIDNjA=;
 b=BmmBMI34kq1Y5pkiq70eSKqeURQr3t1oQqKlQz7SmU+57fn/rd3khjfhPQSalEW/VEt1z/rnOF5J5HR/eYiROMkEwrVgNwiRB4VFoI/PFRpnVl4qSEHw6UP1SvKl9FNzhpF3XK9J2/3m0GVFJFYm5uS8zh9LU4AAySEaGFlfsjd/VE6xZg5K69huKH2X3WWXLaQD8+D+B9aaRQGbFwNy0SBTTru97WH8MTscU0MX9rKCisozyurWe2Pk1cryiHV1g7WzpLbDMV7ZhH6O8KcZsDSp2dQ6WVorx20NKHbwjizP5cdfDrTE2CCuAkxlIfO+6D9T+aT6e3uBqHzweWDtPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 12:59:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 12:59:38 +0000
Date:   Mon, 25 Sep 2023 09:59:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20230925125937.GY13733@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
 <20230921164447.GQ13733@nvidia.com>
 <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
 <94004987-3cab-9fde-a231-7c63ac88a866@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94004987-3cab-9fde-a231-7c63ac88a866@intel.com>
X-ClientProxiedBy: BL1PR13CA0377.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f10770-1165-4622-0682-08dbbdc746be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4ZbunVSD7ugAmNedjmBDb7E3XocxVCQWZ3Jx+MKQ1bsroPF5qsZvYqW6I5fkUsh5m2bFYX1RQ+zbLuiUNJPd0Lu34a8MR27BdxJUcLZFgdwguox2nHENFdJne+uKYS6/NXk25cLsDwxw1zW8RTIJUWznIGHA2Sc/unfWZileunZTZ2/A7Pu9WAJWTeVuwUCY5BUPVPkEEf10hN906sC0WVhiLdI/zFMS8C1JWPmp3oiYRs/XwHvT0mP5DuU+uD5ZVRiqKaD0rrLZLO1RBbYm98PW/p59inqZ953pVzsrVrxKQflAwevY1LVz6pYmBu7wBGGFaqu6sq6hHWISm5ORkc6BF8tD29mUwfIQctD3UvMrt3juomcN26zVj586IzPvRzSBRT37szi3UqdoHn5aK74CrDPm0Ydjdkg8vujXVDo/H3ukuHbxsyCbaxJrdBlvrhng/3VgqpOqC5AtUc2KdEMB9P/5Y2/cSWwxODhQE1ePj7rxTzDdnOPMqnMWSKYKIKkN/cZzvaArmF6KDMkUHvjHcsKiubVqi1UjPvE2SZUdL4lHlJbkR+mkmHkxBt5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(26005)(478600001)(2616005)(1076003)(36756003)(86362001)(33656002)(5660300002)(6486002)(38100700002)(6506007)(6512007)(4326008)(2906002)(8936002)(8676002)(41300700001)(54906003)(316002)(6916009)(66946007)(66476007)(66556008)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGrFdYZVlR3c5s+uwP7Apawu3tAc4HBs8RBtgR6YgP6wD0Kv/UiGNTBgJppM?=
 =?us-ascii?Q?kRIasbRGNr+c1okLkRJ4Z+2OmzrbqmIL2A7V2DI4cCwUSBZwgteMHmQA97oZ?=
 =?us-ascii?Q?mW3/zzkXbKVm8mpI0HvJ6M1KFS17R4P4HO0CgOWrcnvO0UJXOQj+wiP4dwab?=
 =?us-ascii?Q?LvuN37yrRRzWmnyePxsM6Hvgu3fcIPDBNKubDU6V6clRdO3SQNxvZlJnb28G?=
 =?us-ascii?Q?ZsYfx1yZuRr4/etzbTwoxOIthyJxABa4ijeL7C1x23HI7fhqnm2ruBj9j5XZ?=
 =?us-ascii?Q?DSV0ZzeFCARdw0aMbO3qt1tESUsl4CR4lX69cL8tPG6CFrta/Y6y6HCt1akm?=
 =?us-ascii?Q?ZRWvBBh4fk3U+rUT+yqIIrEi8zPri7kNOHEFrkBkhaRjFk2WeIazXLaJc+/S?=
 =?us-ascii?Q?yhZwUxSNnUEgRrq8B3SYfV2+OXQ+cq/Yf5uNNJt7vfgVzFtHq4OL3ShvGc5J?=
 =?us-ascii?Q?3ohchbuoyEnPWdMK8VEwz9dP1Q5IbjArSj0EfwlJTFVRUA3Dv2GWCWSMqXg+?=
 =?us-ascii?Q?h6VcpM7JV4jXDqGvU7UnP7vdUuZ8qa2b3pYePRJ+WRL2jFveaInGfGRNB+gb?=
 =?us-ascii?Q?oBPootyDPZ9qaiggjl7MNXHGcKqKY3qa/YKl7ENollR5gaySjERTRIjIaeDk?=
 =?us-ascii?Q?QHlE7dA87KSR2Sin4ND6VsoMJrkIKp0oXgEbk7td5uoS5vPaAamMwMjSxOnu?=
 =?us-ascii?Q?c2QFthIZjJw749lkoySD9jS2ITDJUFEn732Al+jiYrQCgfKJPQsi+jXFsM7l?=
 =?us-ascii?Q?bK8Hly3vNtdmgCN0rr8xpvOQRNMNgH451XZ4i5DaBu17XEOmTGV9BI1LHprn?=
 =?us-ascii?Q?Kl3k1M8KOXn6ep/NXrcbS/U3jxc9hpGQhzE5T3PW3oHvJj6YrS1vl2FDOupd?=
 =?us-ascii?Q?ZSiX63cPy3X6fp5EbTUoSgYZgBMuC0yP06zfu97eDanA0kDJ1JsFjM493x5Q?=
 =?us-ascii?Q?jFo2DNUOnpa06x7vRKzpSv5dphVFuhGXhcFZuJZ1gjV0oPBz+LZsadiS4ADL?=
 =?us-ascii?Q?XvJKle5mBXarirzZIbGYNQR9/bISEUuveYJaXU5EOTOUttxcLbeHGSMS4wiP?=
 =?us-ascii?Q?XOSlhOsxJx64IBi/fsWdiFLx+8LRYaVjobE+zNzFK5BGWR94nDCZG8QqIsH9?=
 =?us-ascii?Q?aQHGHQW5JvBAI+uky5BcVJoKO1D7LVCXZpaHU0erFbYxycRhpXXNfcipBXJ0?=
 =?us-ascii?Q?sW5gbexgJ5lHXHjvQK9Rd7V0XwyDCegknEo6HWPQUPURIs7rZ7X7gJFEqXcL?=
 =?us-ascii?Q?JT9jds/3TvclTy4w1MY9bpAugVi3fzstSkeI8uVIg+7un9vVjJyBw4gcSOo4?=
 =?us-ascii?Q?HgMmmXFLEURZlu35jvcdlkv99tMojVvL6QA215Ne3jTjf5apCNMeu46bUH5I?=
 =?us-ascii?Q?eD0X8RE3PcyGaEykqBe0gqEqD1hmF0gFuojFQS0IwXUP3dyOaFViRxjZBLto?=
 =?us-ascii?Q?F4sba1XNJ5UvNK11vREK7/8mgrog29MiLJnJ4gwcW4KSFKN91sg4ClQMtiCh?=
 =?us-ascii?Q?YIJeIKPVMOW2sETVeVVeV7FNCV53gNgOktcP8oMfb0WnDcg21YzbNM+Ms3yF?=
 =?us-ascii?Q?5Mq2GNPmBf9Su1LRFVM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f10770-1165-4622-0682-08dbbdc746be
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 12:59:38.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EJpE/ZaCLmrZo8En1VTicUvR3a12io0kjYGvE7HDq14vJwhgDjui+UTHCNINWne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 02:17:37PM +0800, Yi Liu wrote:

> yes. It is just what the existing domain_alloc_user op does. Here we add
> a hwpt_type as the type can be given by user, so we need to define a
> specific type for it.
> 
> Perhaps we can also name it as IOMMU_HWPT_TYPE_UNMANAGED to be
> aligned with

unmanged is also a weird nonsense name these days. We are slowly
replacing it with paging.

> the domain type naming. IOMMU_HWPT_TYPE_GENERIC is also a good choice.
> Please feel free let me know your preference.

This seems OK to me so far

Jason
