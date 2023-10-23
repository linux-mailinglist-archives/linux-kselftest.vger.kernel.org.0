Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D87D3F6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjJWSnC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWSnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 14:43:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22A102;
        Mon, 23 Oct 2023 11:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGTQuSvvyUcXmWQbIABwi2+rOQCli9Wl7mch20KsN2qXuCUHaVNG16J/88Tmhbgd5r3PfhZFg3o+WauNw2+A5AA7pKVUKt550HA9hUOFJEdrwhMOrrA1YF17iRMakX9JRWuj2JjNjQ8HY0nj6/XMk1yD41A9yFPTuw2hiPKGy/LKkMUCHQrn7egUGQOjDjs9jbldRoDEWt8fKHWqNt4DSdLxtPvHhVc5UWyqfTbDRgJXoia3fzng52Eeuahly5l8z52iwcsfjnzmvwdQ6CF8Dl7nIex17XyYB7irEp/y1bXCXTnw/aYOQMzi4r67HYGRbFi/ldDNKur3j0LH0lHRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLnuRFQFCJySvXf7B0okLa7Fsc2gRkjkvEcoMl9eBzs=;
 b=ThuhBAyzHEeXpJtrVdeQPR1jikLlyKFxLHltCPqXDeBPVtc/xBzsJYWZaFlIxs60Zdp6DVYe+4XuFQoU/XX6yVeHRNO+wNs0A33iPo4ZiuR+CmUgjSV4Wj0ZOH1wIonrd7fIbL7cytZ8u7hVcuzW5CqkhPdXq7X/G6YNYdAyes/pHwQc96+68ZyjnBH6mOJLQAfOeDNa64VuJEU4LWyAAp8KMTcNIht1ihub3k3iuOq9Xf0EZWGc/uFgy2B2v9933AKDmes7QfCjp6Hm3ZbTCddSrcfNkcZ16PoezLs7rJLkCpWTksAvWk4Dl+82OXwCRu0ZcJazXUys+k98j38ZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLnuRFQFCJySvXf7B0okLa7Fsc2gRkjkvEcoMl9eBzs=;
 b=lbhULYrWYW1tkKLE2yQ3KYmuM4R3EREPd0Ay85LEiGFYnSwXaR9hVC1t7pRLksrj8qA5/zifS+Myzl1aLTK9DHPAWNrNE7/rphXDvm/O8LQK5dwIJVDdLp/uNT8WROG8cqfEqfJ1ah+/gYgVjkIhuFvIrLZ+rdvpPD8AL473KgG71p6cib2IN58YCtAU8ZKlU/af/18w8a2sW+jIUhvzUjg/t6bTHKaGYWsIm5Jk3iUZ+AZnAHIrmLwIWli+6hKfbwqNDGku/LCBnbTeAYOxrxVUQA4vmL806TYJMmxInYy11gZV2ter44wToIOT5zr3AfDyzCVPX1g3TTzFYZ2m1g==
Received: from BL1PR13CA0367.namprd13.prod.outlook.com (2603:10b6:208:2c0::12)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 18:42:57 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::ab) by BL1PR13CA0367.outlook.office365.com
 (2603:10b6:208:2c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14 via Frontend
 Transport; Mon, 23 Oct 2023 18:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 18:42:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 11:42:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 11:42:38 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 11:42:37 -0700
Date:   Mon, 23 Oct 2023 11:42:36 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <ZTa+nDbHnXCmClm5@Asurada-Nvidia>
References: <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231020135501.GG3952@nvidia.com>
 <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
 <20231021163804.GL3952@nvidia.com>
 <ZTWabb6AbOTFNgaw@Asurada-Nvidia>
 <BL1PR11MB527173DCAFA9DD1D9270A8D78CD8A@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR11MB527173DCAFA9DD1D9270A8D78CD8A@BL1PR11MB5271.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c0ffd0-f117-4214-8ed5-08dbd3f7dfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rfcAI/d/4ijN2x1wOnWArl2Ng17K3CexfrhoF7+HtSe1CzFdZTq86B47nnaTf8xOfSo3Jj9rZorE5FI+96+9FDCgkc5AUYlJXSsaYy5UBch1iyMV9OOSV8JuE3NFQjvzI5yeaLkZGRv/KnDEdHVuK5wqndPfQggIB2grVUn266QiCv19qsH8ZsVKNms82qeFh/KZwrJRxagK4tiy8e37qMQsKN2McSmn2rVVp43+nqyIgG/qzcqHwDJ2hYT6kLJyN632yDWqomp2yL1yd60il9gABld+Q6/AArHZ4SORqgmw+7QNam5d4ZSSOw54GwyYnl8IBSHSVM0woaDSjLjXIPaONT3VPxlecndImMf4L9PmUPN+pzNKNzbvUKZ0dLjgGXVouCVKG2sboVZzg0DQnmsMeIY1NluNCBEkbCR5Rnb95aNaNCJdflbreP8oUheVaHdYffDlJExd57ZaEF29Ea1XxaiPhoIJsVIxvp3xJuut3Q3AKFa/VwTwp/LfKtI7G3g9LFsbWR1fvAceLXtEX/cOhjzoJPb+QIzi7F9y8Iu0E/0KFFhN3MREsMxZM9iNV/7kVbIPpBmoGTbU9oZJR2d5xJLD6Aw0pTbm9N5N7iRhQHbG+Vd5rnPSwaQrQN/kqOV2YlKrYNsJU4PVOkJLPesGpFJF1K5I99Yx6+QL6EVkSf/sj9+v4mCC6ahrMSZ924qs0qmadm2I4Hc1vVenlnfCVRLheGxnso2FUhZtUn6akNU62ppSDdZ9J5CGQeS8DSbuhhp5F6LWlc5JNM/OCj4/56AQWHYqccJ5WLiO8w=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(26005)(33716001)(55016003)(36860700001)(2906002)(41300700001)(40460700003)(7416002)(5660300002)(86362001)(8936002)(8676002)(4326008)(6916009)(7636003)(478600001)(82740400003)(70206006)(70586007)(316002)(356005)(54906003)(83380400001)(40480700001)(966005)(47076005)(9686003)(426003)(336012)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:42:56.4757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c0ffd0-f117-4214-8ed5-08dbd3f7dfb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 23, 2023 at 02:53:20AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, October 23, 2023 8:18 AM
> >
> > On Sat, Oct 21, 2023 at 01:38:04PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 20, 2023 at 11:59:13AM -0700, Nicolin Chen wrote:
> > > > On Fri, Oct 20, 2023 at 10:55:01AM -0300, Jason Gunthorpe wrote:
> > > > > On Fri, Oct 20, 2023 at 02:43:58AM +0000, Tian, Kevin wrote:
> > > > >
> > > > > > But the user shouldn't assume such explicit consistency since it's not
> > > > > > defined in our uAPI. All we defined is that the attaching may
> > > > > > fail due to incompatibility for whatever reason then the user can
> > > > > > always try creating a new hwpt for the to-be-attached device. From
> > > > > > this regard I don't see providing consistency of result is
> > > > > > necessary. 😊
> > > > >
> > > > > Anyhow, OK, lets add a comment summarizing your points and remove
> > the
> > > > > cc upgrade at attach time (sorry Nicolin/Yi!)
> > > >
> > > > Ack. I will send a small removal series. I assume it should CC
> > > > stable tree also?
> > >
> > > No, it seems more like tidying that fixing a functional issue, do I
> > > misunderstand?
> >
> > Hmm. Maybe the misunderstanding is mine -- Kevin was asking if
> > it was already a bug and you answered yes:
> > https://lore.kernel.org/linux-iommu/20231016115736.GP3952@nvidia.com/
> >
> 
> currently intel-iommu driver already rejects 1) enforcing CC on
> a domain which is already attached to non-CC device and
> 2) attaching a non-CC device to a domain which has enforce_cc.
> 
> so there is no explorable bug to fix in stable tree.

I see. Thanks!
