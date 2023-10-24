Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9293F7D5998
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjJXRSS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjJXRSR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:18:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F112C;
        Tue, 24 Oct 2023 10:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw+odIVsjgnUF/dm4WOdgjW+E4qZMe3QFGySsFc4kiPp7Q0Vi34MHo5TK7G+Wo5XK3GYuGlSYq6vk7bLkAGheY/HHI25UviU1hUYKB6o2IudeGJXOOB13Mju6omUw/5qfT1Yi1WaN5bzqk2bA6rgLxjXxz7aAVIta2xH3NPoCAVPIu/qmAjG15qzJaUjZW5NxKLc3a+CbnqP8zOwT0Ze/s228GGGRoTfmYUC/FCtapnKLVTkT6ArTmXwm1Ksjz4EglYn99UD6/RCpksmqZp4ShHfq2dbJuGp0QC4PT+YKO2Ti7Y9SFxcCmtv82LdH9NRCfDc//QJMpr1bfbhAjz8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSXTtp9NbHdIoUJj8JG1WrSxrJhmyeWn3amHHjQyOtI=;
 b=cmb0Il2ZMjTL6qpggH8oV9uHMSi6YXU4cZmr6GBnlo8nWQCb2xP7cQ57vkp7cdS7dvskA12DYiw6MLF3K6zstU/i9A12aPL7iy/fDk9qGmLyAGTEL6nfWDGcUfMmxMOVewDF4E7SBr2mzCbHFuiPI+HLGQxi3olfhI0qsWtKzhA/fqO3pO0eaQJrKTa2KtZgsFfGFjhGXAiwvZld/r0oskyxvXJqu8NfAaTfRU5BNRJhOmhwX95fZjYrRTweRWVZvqEcx+EtPtj1EVyfakbsosyOfeABeJoOWTMvAEqPWz9rsxDqZvhmcrAtVO4MPqaK/5fdpV7zleZg72hFO5or2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSXTtp9NbHdIoUJj8JG1WrSxrJhmyeWn3amHHjQyOtI=;
 b=YHSd/CykMiL7Ze+4xUasgyQVKHsKkZ1dz1pF6XWs3oa4Dr6XvzRTzXaYk74YmfzXWaxV1GUjfLz0Lyfgkg+b3Rc4NUnIBfgDEzYxLn9l/da3sx/bMwzBzzb/ffYE9tZNvdHVKwS6YURcBXLS3KpQ3mE3+UcvK9mdZdHhqeE7riDui8l7OLMc01d7hJiF6rXlRlXFtc6udt+/9ePU2Xi9/t6QIOMs6deXx5ciarXn9dKXehAiffC1wfh4Ie2e0B7QC/B1oyJsAs1OPUQesmgub0EoMnTfP8x/lnMyWZ4zQly+5RxEqxPQvravLVW/Pay8o8m1Dc8jJrsKpysWUE9iuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Tue, 24 Oct
 2023 17:18:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 17:18:11 +0000
Date:   Tue, 24 Oct 2023 14:18:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <20231024171810.GO3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150609.46884-8-yi.l.liu@intel.com>
X-ClientProxiedBy: DS7PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 08458c40-5ba6-49eb-24f2-08dbd4b53318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xp2hKx96JjQPqQewmiwGS9KGwo46qGDFxuds/Qvw7Sf+46RaLhiTS2t192/3UJyMDz5vq0Ju5Yc4iuA5O9hGfCe656vTogBLiz9DqiL1MWrSZrGYTUpKXI0Ep0L66euCUi1AcMh6T14BOu0Bj712DHAXQXZlaIF/QjAv5i6l9pqtZRU1LUwkCWk7C3TaWckolRNTivF/i4BvXYpGtzbtUn7V2MWtElahrHZ5vCidXIHzIxgnZyToBjpIumevAArFAG+7B8xRZuy5iRNtz1urfLStgRftCHiQ+0U3p5/WUSWK7q9m4WT7+SRKW96RcfvUuE/JI54nSFq/EL0qvuQ9D1lbmEuNR6Yngz0cTqu0v87MUD0o9JPC7e6IdwbdpIr7VvjchKTuYs1FImhFdEE0tiIiCzt2CAdnC1SiVa2AKLpXBUVNPGERbvwha/m+QKXVuxKc/7qmfvKjBPATdoXoi35xAc9ioTF84UEDVvTHM1HaFIRZND2hOMtrtBOmKXw9bq3a1sjE2wabogdrarQD6/YpCJ01d9qHtHq9PjzXacRRhGccWVeaUKLjToab7I9p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(6512007)(26005)(36756003)(6486002)(1076003)(6506007)(478600001)(316002)(66946007)(83380400001)(66476007)(6916009)(66556008)(38100700002)(4326008)(41300700001)(8936002)(8676002)(5660300002)(2906002)(7416002)(86362001)(4744005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xoOttR7wxinKzpC+SEER2eZpN/Nhbxd7mPdgqmcipz6hM6UXo4WAXx0CA7b5?=
 =?us-ascii?Q?I6o2O9s0hEDYCVwhBcfHfQ8sPoTNt2huEilJetDceALVFpXvYf/sHiNGisLI?=
 =?us-ascii?Q?BxglMpTMdWwk1ite/2T7n6ckVUi2SQ85PnNu6cMsY8Y0GUAf1q6i+PSJsaTE?=
 =?us-ascii?Q?dbust6Aa9vMwpO9jCpCdxMW2MATHNxoiiF9G4kN1pALR25ucXE6JTWoyi4ci?=
 =?us-ascii?Q?42YK0AJtUwwqjRsL89yN3T4cGrPMvor26BmBj8QjhLZTGWnGuQICoEJEefbr?=
 =?us-ascii?Q?ikzWYQhad1nRA5ljQcKePhIC6udSuGKdgxenDlRRQmm9fkLQRLblIqFLcOwb?=
 =?us-ascii?Q?BgUFoTZOYHARXrhGiNPjaOCHzaIwORAd00xRwwFJs+HLIk/PxoIrmUGHm8Ts?=
 =?us-ascii?Q?se7gvSdvAm/ujpSB0n8hQMkzdfyjtWTUa91S+VWNGCv7cDYSKoo8ko7xDF94?=
 =?us-ascii?Q?ciPoiYlDLtSeiWjWL9LScNW6GudBvIXH9sQ4jdwoHAqSOUmyP0mLGPJFLoGb?=
 =?us-ascii?Q?nIrvJxYUXP+RJjM4TeZCoEoJFls4pl1wWS/48D8pGjEnjgugWYDQHjg/o6Q8?=
 =?us-ascii?Q?jFz4F10F0YQHctDVC1klc7ygs9Ye5GYsPNFvdpAyrIedpigfv3sX3Y91cLAd?=
 =?us-ascii?Q?YrU5qrnXqbO4PRcvY2UPUyU346FZZ2+IUOSUtMNOAietgCuDNNAHQJwhuhUd?=
 =?us-ascii?Q?EpU9DYXtvlHIP+NLw4iQJCWY787RATqtfns+HvHFUbLwhabTeLGkMzZA6fT1?=
 =?us-ascii?Q?OEi9w+Ep+RbdXdoT0TmKDAH+ql8cQvwHp6b2TOsxH6ZehN+16wKdznZFLv+x?=
 =?us-ascii?Q?4pPhzllcCgowzTyGvSkbp/k6ySrygPed0rRynBAzqBd55rqRkWa1GLT74Q4W?=
 =?us-ascii?Q?J9s9obXtX9ZgP7bqmkgHGTX4aelb2VXBUi+7DcVJWFj/LoY2Q7eOhUh33v8v?=
 =?us-ascii?Q?8b3lqllTo1Sp2S0ITjIaJZyO8BBdShFkDTLc780cgPZhFJ/dEwBz/o7SClT0?=
 =?us-ascii?Q?zJ+DvOOMQjNACero87mM5aXXHbL7B8nifhVv6pEnFTK0uy3upIoSx2CEO3aU?=
 =?us-ascii?Q?3VJC4tM4mJFU+rPqK1FVMwuUa1UMwc1YdHg5SuBr+4kehnG1IgJxX0y87PH8?=
 =?us-ascii?Q?Q1bOCQaXjwHNcbe82LD1ukzaCWUm87CzdIu2PugExT83BIvetW1rpSIWBfF6?=
 =?us-ascii?Q?ufLDvh9zJVUg/ITg9AjPj4x9FPqLCVLyXV5eXx+7IrgAXD20XbEyAN7SeHre?=
 =?us-ascii?Q?gcwbhcKoPvKVra3ZKCcb4lakCnZ8r3/GbDfXjPpvVc7+APfNKaGxeuIZ2LpI?=
 =?us-ascii?Q?6s6OIt2QiDH5/CzED+LLUu5GoH3AzTcy466xC+w5a0dP5c3wTxNufWxOUYmp?=
 =?us-ascii?Q?LFCg0bveqfZfR+IKbReDy6p9HjH0uMJ0rZm6RxzqCJHHaqvSV0R1iXIVTSVx?=
 =?us-ascii?Q?ciaBIT6G10ul85EAQg/UPsc48zuVVIzHpzgb/cyyMaIZWN41Dj3Ftgf7LHDD?=
 =?us-ascii?Q?wrew620h0MDhuRnhgjnHeEveofeFBuS7SiSLTHdjfEUcUioODNAXqxElVDHY?=
 =?us-ascii?Q?RFuBjsH8YxL55FwRqRsscTjkZFFFHOorbChz4g7r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08458c40-5ba6-49eb-24f2-08dbd4b53318
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:18:11.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiTsGwnv7W5k9WSKap4J8yPalnImP7NBveVIH1hPwHH3XhXRs4tgiIBZFJE3na2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
> @@ -195,6 +279,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
>  		struct iommufd_hwpt_paging *hwpt_paging;
>  
> +		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
> +			rc = -EINVAL;
> +			goto out_put_pt;
> +		}
>  		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
>  		mutex_lock(&ioas->mutex);
>  		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,

?? What is this?

Ah something went wrong earlier in "iommu: Pass in parent domain with
user_data to domain_alloc_user op"

Once we added the user_data we should flow it through to the op
always.

Jason
