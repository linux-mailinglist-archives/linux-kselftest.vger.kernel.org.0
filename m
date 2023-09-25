Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BF7AD877
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjIYNAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjIYNAk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 09:00:40 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28FF10B;
        Mon, 25 Sep 2023 06:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm9i2ZZ6X9BLL7+kerx/QHXwhUu/YX9a4SxbWGk20KAjvbQMhQ0xdUlx77w3tIEz9We4UIXHso/ijnpB2aZPTzDXP5hac6rBPS3A5F74Py52kz0oiyXjN6z5WhZfRQ7Z2MM+QnW6D95BkwWXUTv6fmOEi2ck6v1TbCMvWrwEX5BVrqhtEdaNcYgQj2sV53oq0elg/FeIIhsRR7hw1PaL3lPtZkuqHcQbZnU1BjphXFAJjBDp9RNPo5BAzOfUDIk+vXfa1ef8uLzx5ofuPke2VtRl2AtdGv0XG+/LmA8jXRZurU+efeDPxSlZafl97YTNrZgof7xnquVHf8HWimL/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj21gdlEM3mfx1yhlMJc+27UE45nkcnPIiLAfSlM6A0=;
 b=CnSfLUCl+SzqrVFwmBmroDubythXAnxs04U5JAsCRhj1VM+76HglJhSGZkxxC5iK/wZiwmQ79fH7zrEWUv6ZoGE2timGKB14AvXBGhIizTspzj451zacAQ/T00YpVN2tX5gQlmpkSskCKWYAcWM1KtdUHI5IfilWPcGhcqboynpgbSSRIAzgPHw7MBpR7AWF9nGxnxGxfMETEh/8Qt3OCjJGj1QGAISOGa2sbRHm2SZ+fYpsvkbajvkBibJqfumi9Be9c7P3aCUukA/1ZDAj5jXyhn5FEB/IYwy7FiAJ35lnR2ehmNyZN25SRn3rbUI50+VTpefdBI4DXCbD5r0/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj21gdlEM3mfx1yhlMJc+27UE45nkcnPIiLAfSlM6A0=;
 b=X8KriZkxYW61uTdBB8bshgxYJwwMK/ZrYljhHVQf+U8guhrcDE5yOuTrUJkdslJFWN7YXxWC5f+rNd64tJr8Tqlyjy1+YT6zcHvKT/50liJyvdomy7WxSxVb4S2qYMieMCS2DCNNpFsXLr6nW8JkepbTgMa2f0q4YwFp9CiMPzRID3PB3zpIbn4PXUJqH9TS7mBJqK+FPYnFE0uMI23Avc27n7Fzbd6pZKmp6TgSshbAKynlmQVBxuHrnSp2fj0chTvBkjaqAf95IamIVZyZVHXf+fNPOd4X2Q44rtUzPEc6xzmGmXqOCVK8+Dlh3do1MY65ayVuQc+WR0oYgcW9yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 13:00:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 13:00:30 +0000
Date:   Mon, 25 Sep 2023 10:00:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20230925130029.GZ13733@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
 <15831871-cace-f954-6af1-328039ffda16@intel.com>
 <473d4050-2f2a-f9a2-6c40-3efd5b582b4e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <473d4050-2f2a-f9a2-6c40-3efd5b582b4e@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e50798-7102-4144-e3db-08dbbdc76562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EbV1Anvgd8IdokZIVfZxzgAMFXHf4wjkBKeH5PIKZaNx1vrbLnjCCtwMRhbEfu5fky5qjIfn0ZSGzbN508PqNMyfKjKNvrTVt+uQwXtgeRNhAChfC8y/qVxOAaju7tdaL6mdfth/lZDL/qFgWI6QGa5RmvUEDHgkWs4hq+dgTgyvB3+UA+3v8rydlx9a84FJlBg+Rg7uY8n0xPkUxLH2wNieZFKrHcuJQHJJpUX+igUmX6NkguRSmx9RURzhX4f3q149l8z7r1GuveXSBWJCoIHPW2k498drAUrYcmC/U6Wztq4POCiQtT1xxJN9ZQXm7LuFhZ0LDU4Ecl3iRHs2Mi2JW9xPNZ9+vEnOBVZXQQ+8P3RCOwngYZ2BBip36eAQSltQwD6W9Pi1WcVm7/mQO/MP6ZIyE9KfXmMH+PwHc6AMa53DtfQ5KO4ebQTJZopYhqMHE5F+G8LLqcq3fwjFRjxDJtCLcNRSDvKVAKu0tIzKF0NZRn5Fjk0wqvdNDn2VXgD744q61Dn4eEHbJnGZkgVBxRXg7DI+HCyYx4JsKZrnm5PPpl1Yrc/SKRqKooY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(26005)(478600001)(2616005)(1076003)(36756003)(86362001)(33656002)(5660300002)(6486002)(53546011)(38100700002)(6506007)(6512007)(4326008)(2906002)(8936002)(8676002)(41300700001)(316002)(6916009)(66946007)(66476007)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekVDWHFZQ0IwL2tKVDZkQ1llZ2dOQ1dRbFJpeXhNVW5ta0VUU2JRVWY1Qkcv?=
 =?utf-8?B?SFVsWkhwZkJtNWhtWjZyUVBWZjZvVXVjZS9QT1hqcTNJRmRqd21MaFg2Z2Fi?=
 =?utf-8?B?VWcrTEZIaTNGWnpoWGNPalVURHhtUzFVZDhkSVJ4eHQyWVhvcTdLaUxVYkI1?=
 =?utf-8?B?Mld3MHlvVnR1OUJtTjY1MGtIRWlOWDIyOFhzOEJyVFo0M1NIa2NoV1JGTlJa?=
 =?utf-8?B?WjdmUjFkdTg2NlNiK1dibTkveStxNm5aYmFnTm1Gb0RCeFdMT0tEKzBsRzJi?=
 =?utf-8?B?NE00VVRKbW5uaWptRzRBSk5XVkxRbzRNVnFZcDQvMy8yelE2aG5kRWUrNUxw?=
 =?utf-8?B?UEFxWHYvcFRaaGJ2WVR3NUFzVytnUEYyeWx2RzhFZ3MxWWZZUzVOTTZ2MnNm?=
 =?utf-8?B?NWZZdG8yNlhJQ0JST1NLYm1hT1BITzRnSzN2ZGZSc3ZRTmRBeUpPeXprdVpx?=
 =?utf-8?B?VFNsTWx2OVREVll0ZDlZamZtZzE2VlVaMkU1d091NWt0alZrUWJFcDhrMzZH?=
 =?utf-8?B?LzQyU3F0WU5GaktCZ0lpR1JmeDE0SzVoL2tEeFBCMkVEQzM4VTN4ZCs0ZnNS?=
 =?utf-8?B?ZlcvUXF3NFBmeVFzdUxzdUZseHZUOVVDOXh0dmVjVjV0bi96SWhuRG4rYlpE?=
 =?utf-8?B?UHBnamdieGFEL3pXV2xENzJDNWlkMVNQQjRyOExOenhWbnJ2VmdUd2VXMjMr?=
 =?utf-8?B?Y1R5aGhZb0U1L0JmZ1FGQktSQ3Q1Sm5vbEZhYThjWXg1Rm5FY3JHQkc1cVFL?=
 =?utf-8?B?b2pqOEV2a0FRcGVRcVpOa2hIM2dXaGxuaVpEaHRwZ2RqSGt0bWFnN1dIYXQ3?=
 =?utf-8?B?WGNEYmxWYnZXb0JzaVpSeUxUSGFPRm03QkJzekd2Wm5KRytubmUyS3p5Tjl5?=
 =?utf-8?B?cUJEN1h3WVR3V0JGTjZHdGVzUEFtQlF3NmFsT04xcDZiamxHNGVrcGdZQ2ZR?=
 =?utf-8?B?Nnc2TWg0OCtUbVNJc1g3dVhBN0h0NWhRK0lONlprR0trdlg2TFBwWjZyNjBs?=
 =?utf-8?B?VGZjREUrN09DSk5ybmROWUc5OS9OaFNqS0Y0SlliWFFDc0tGcUZ6L1pTQVFp?=
 =?utf-8?B?QVhNUVVRUU44UVJRMGlRWFhnWmVpMzgxVlFXL0doMTFTdjVlaUFZNGRiMzM5?=
 =?utf-8?B?MUQ2cmFieStVUm04MkVVSnh6Umo0QTk5c1N1RzFkVzZ6d2Uwd0dkUTFRV0ZJ?=
 =?utf-8?B?U0xON1k5T2xpbmh0QzZUSWVoYk5SdXQxT0pQMkNRVVE3MVNHK3ZmTE5EVEU4?=
 =?utf-8?B?SWNVK2dEQjZEZ2h2QW41cDZtMVN2V0MrZ2VNK1IvSWRubXlKVjJHRUljZm5w?=
 =?utf-8?B?aTFTbTFxeWJjRGl6cWxjc1JxK1prTE0rUkRuT28zbWFDL0tpeVJ0eFluRjFV?=
 =?utf-8?B?Q3NlY2g3KzRKeVF2V1FLVldsMmJ2OVp6QlN2ODlJbENKQVBSSHBKNjFSM1hu?=
 =?utf-8?B?NE1nT0R6MkZRWlIvbTlNKzVRcDQwVWErS3NQTW5EL210NnNhK3NnMm0waEJw?=
 =?utf-8?B?T21sUmtnMFd4T09HQWZVekIvalREMHBweUhjaTh2LytrSVVxcWRPWkp0S29D?=
 =?utf-8?B?ekd6RDRpV082bTM1MzRvSnRIUkMraTNkWURMRVVFVU5vWnVJUXFxbHdNVlRN?=
 =?utf-8?B?YU1ickhUY2syYm1xcGh6TEV5NnhITGx5M1cyVHJoY1RIVzZqRFpwWmg1SjBL?=
 =?utf-8?B?R0I4cTVLVGl5K0ZCZUY2SE00TFJrMHNWY1J2VEVncnV0QU5RWjFVcU9HSmJ0?=
 =?utf-8?B?OEFzNWg0K0FTUS9saVFDcGY5WUdwZDNOcHRtZU1tbXRkNUNVNy8yQmgyMm5q?=
 =?utf-8?B?S0FFMHpZa05wN2YzU1BjdE5TRTBjTTZtbXlFV0R5bnU1em9mVXovbElXQTNL?=
 =?utf-8?B?UWIvRm9qdjRUQnR3aHNpL0gzc1M0UTZZUXl4OHZCc3kvTEpQbjd1QWxQMEZY?=
 =?utf-8?B?OWZWZ0xHUDNaMnBjYXN2U2VJTkZubHh2L1lxWksvNUFaSExKYThyL0ZwWTNX?=
 =?utf-8?B?TUsrNlN6K0E3dmhXRXhBellFODQ2Y3NDMnlvUEVGeEEwcnJBM3R6ZUg3RER5?=
 =?utf-8?B?QUxSaG1FdmhIRmQrM2E4aDRsU3MwTlhCdHpqNy9kSHNDL3p0YUFDZ3JlTTJX?=
 =?utf-8?Q?TrEQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e50798-7102-4144-e3db-08dbbdc76562
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:00:30.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hoybaDahh9iMIv39XIrJEUF0CFOuK2JGKPk+fWQWLhpd/V3zzB2p78PqjBbvJo1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 04:01:55PM +0800, Baolu Lu wrote:
> On 2023/9/25 14:22, Yi Liu wrote:
> > On 2023/9/21 20:10, Baolu Lu wrote:
> > > On 2023/9/21 15:51, Yi Liu wrote:
> > > > +/**
> > > > + * iommu_copy_user_data - Copy iommu driver specific user space data
> > > > + * @dst_data: Pointer to an iommu driver specific user data
> > > > that is defined in
> > > > + *            include/uapi/linux/iommufd.h
> > > > + * @src_data: Pointer to a struct iommu_user_data for user
> > > > space data info
> > > > + * @data_len: Length of current user data structure, i.e.
> > > > sizeof(struct _dst)
> > > > + * @min_len: Initial length of user data structure for backward
> > > > compatibility.
> > > > + *           This should be offsetofend using the last member
> > > > in the user data
> > > > + *           struct that was initially added to
> > > > include/uapi/linux/iommufd.h
> > > > + */
> > > > +static inline int iommu_copy_user_data(void *dst_data,
> > > > +                       const struct iommu_user_data *src_data,
> > > > +                       size_t data_len, size_t min_len)
> > > > +{
> > > > +    if (WARN_ON(!dst_data || !src_data))
> > > > +        return -EINVAL;
> > > > +    if (src_data->len < min_len || data_len < src_data->len)
> > > > +        return -EINVAL;
> > > > +    return copy_struct_from_user(dst_data, data_len,
> > > > +                     src_data->uptr, src_data->len);
> > > > +}
> > > 
> > > I am not sure that I understand the purpose of "min_len" correctly. It
> > > seems like it would always be equal to data_len?
> > 
> > no, it will not be equal to data_len once there is extension in the
> > uAPI structure.
> > 
> > > Or, it means the minimal data length that the iommu driver requires?
> > 
> > it is the minimal data length the uAPI requires. min_len is finalized
> > per the upstream of the first version of the uAPI.
> 
> So, it looks like a constant. Perhaps we should document it in the
> uapi/iommuf.h and avoid using it as a parameter of a helper
> function?

It is per-driver, per-struct, so this is the right way to do it

Jason
