Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43738621268
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 14:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiKHN2G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 08:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiKHN2D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 08:28:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BE1554FD;
        Tue,  8 Nov 2022 05:28:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeqxVtiH8KNVMr2VLTjzxV0NTuzuNaHVt1+ZZe3tUdrp6f8Q+gndq8CFmF5qact471JLNHr6I4y2HoFBb7Dp0vaXyNkbmQJZIfenhR2AhU3p7W/VIHSPjNZ64LlotUB9VqYvjRXVlEnGGCaaJv4uTA6DQ7ECYSrBzqKtrndZ/UgzkRwc1xhf3tXqku2cOentqDym0p6FvFCnA3K670FELd622PPijM02wtthnhun27N1KmyBWVnLCWRoxWQMKDQhSqrlqHGnZmatfHVr9sxWTdDDgZtoqtn9FGbrHyv1i/qm088r6y+hvlSeyobChRfA+VSCYJ0yBmtbrTNcezEJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anWd9qsmXPVJDhNrHatEy47iIrUfy+/8r5t/+YGNz44=;
 b=Ie9g9OAt8Vis5Vrnj4Nn0Oh+aCnBzJzdr+XXXcuNkhZWzeWxdSBJxuqB85Q8TUGc7PcHPbGOvr55GFfjJujjlZu6oBaeGmCxiD0QK132F79gaiuZxyZblLESjleZYMfIfYAYWTzg7K9BikhXUUu+oBXvTr4gPxlUwOLP4SfXSiyzOj5Opnz4H2eyz2wjjoLQA3TZnPxpg+zHWNSLUKrw7Re5vl0uYjLAhNV3xyNIQLEeKzRa4CMW12oW8L9DzDVn7NPx3I/sGu3XhLnrvt85YfVXxuHnUPP6GKDOnAUGbIkP2Mx38O3YkHSyqOdsyrOmqWM+m9mlurIsZRP6p1aqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anWd9qsmXPVJDhNrHatEy47iIrUfy+/8r5t/+YGNz44=;
 b=h1aKhNsbEHAmU9sn6rgFE+b/ARIimB6h8CdMFuSR/GyUVqWOXcRllAcdYNhWwriwXj3mKZqBuZPlFpItsiUCSAN9EkSoVR8FTLJlAimu872QrKucM9QfqbKwvwdyZTPbS7f+Y6Wdy5zDv+Piawnc0x6kqBEbbTtdF/+e1cxg3qxmgo3ANlSOm2V7lOj2gze8rd3V4SWv8IKUf/jmnWQtf4nUnchZNCcePWF+zlF4pVZRkK0OfHuv9oEJ0gmNuouEkou5eQmkw+iVFUhZAGN8L5EiGIcNsr0bjvQ/Mzy+VIcwyizs4nXNh2Rgg17oElHQ+no4sq3xOzGUTjAiYSh5Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 13:27:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 13:27:59 +0000
Date:   Tue, 8 Nov 2022 09:27:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
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
        Lu Baolu <baolu.lu@linux.intel.com>,
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
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 15/17] iommufd: Add a selftest
Message-ID: <Y2pZXStDpLla+P1u@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2ntsDi4RSLtUVKm@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ntsDi4RSLtUVKm@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:23a::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d6114e-18bd-4b18-5f67-08dac18d0d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcxSzgBPZMo2ihgPMUpvbqHH2YIZf17SMMGARXx+lKOeM4/esf1aOO248FliWfOm/10Ixr2tp6wSInO/PfTKx24VTUcdM2GXhiKaag1NNbJ0fhlGc5XdNgvtpjEDPDrQV4t3tyX+YVXsCirIrZ5AWH4hKdSCTOe23T30oKjb3J8vKksNQdYnFQK21K8jCl8bzWxPfUOvxkh33BBrbSsJ/CVcKL/aHtda+F5bDcY18tv4LGwWGkLGT0XfG31KsriGrrH2XSQ3aCtxhmfdr+tNwXG7WNXDcJGqPpw7pkq0YgPM+Fi1hnMUTqGiqCoBG4c5X/FQERj7XnhdCeACa8MfoiLYigxOmrntOHI2kYn1/7/OE2JYbjgFx2TKxmiF/dneGoFRuq5RrJ+quroH6NfLOLT7AHLojAwgeK70hcgop00xlOPzeQy1gyl0qIGZoQ7CkSwLn6rGlBGj90A22oJ4EGojvptOACwA+pY6/QDycIzJ42SlPah7uxrkwsIC7iNiZLRk9pNehW/rjgBsyNfdYz66VR0RFk3laH2AoAFNJ8uCkSU8+/vFCgH10l/TVjMJ1vbTgVjvAQZRI7qHxQSiFXFWyID/XVQHzjYmMyzhOMLGZ7/02dUnpjKZ19nNieqlNLD4I0dxvv8T3BsrvEubeJm5pvW0uGZxAbDGC5Dj53Yicuy7h5ZPTybgZovDpfIE4Yo/WveN1FKEm47PrIe7/iGu3T/tLljKWlOJJ6Ei1ShxKoiPhwjU9C8Ptj4A7Sr5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(6506007)(6512007)(26005)(83380400001)(5660300002)(38100700002)(2616005)(186003)(7416002)(7406005)(2906002)(37006003)(6486002)(54906003)(6636002)(6862004)(8676002)(478600001)(4326008)(41300700001)(8936002)(66476007)(66556008)(316002)(66946007)(36756003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfh8MgF4bou5+BGsqzIEt3qlH+4ZlK3touwtpgZtFTYnAYOaNh771byJDHqh?=
 =?us-ascii?Q?TFMVeueH8b5IsOVqh6y6AptfHriNBTALB1QdHRrV7OCwFuyFKhmzDaVZRNFN?=
 =?us-ascii?Q?oQCrqF8BqS/mqSmAUkmF6WML0v0Q0+MzfaNUjIJLL5ByuW4AAFfBAZe1Wo3s?=
 =?us-ascii?Q?b7N2rC88u9nXHLu/1/PfL+M5BPbF8GF/AMEoARmHu+SEzVcmpnjhEzyCnBAz?=
 =?us-ascii?Q?4NWTxUE53U1AA5jGbKDCdYxBuwhBtq2bVTajLfI78cMVOSCcHWIeQTqHqBbu?=
 =?us-ascii?Q?X1p247pVD37Yaz6vrbfTjHpVfGy1fk98FvKrZIEGi6izDgbfN2tsSH2EsZ4I?=
 =?us-ascii?Q?arlMxge7TsWdjclVl2t/W1Y0XPva4bfm8b1Bt/fAy9IuDszzLBXwknUWyF3h?=
 =?us-ascii?Q?RkDtbZehGYNiWzQ93nqKGVan5qd0TeQe71UhsUtZ9uHNadNZ8ErdirwEARVS?=
 =?us-ascii?Q?QUsUv3VLEsnqdwHeDuKcmc7cBKRdfh9EOGTQegQH7gRw+41Z/Vkefvy8d++K?=
 =?us-ascii?Q?Vt6WjX2z8dtuFiL5OLtVlqyXNuDm9i4TmJRmaphHidMyEj92VrMqFdLUgE2m?=
 =?us-ascii?Q?hsIpZJUNr67mdeVguId31HF6GOc39Tx+g00KUlT/kbDVYQF/KWSlLJCrG5Fx?=
 =?us-ascii?Q?/fxi5pwLKQatC7Bxy10Mp3w03aTsBotUrCTLKsid907Z/8D9ovXX7gG+QGcY?=
 =?us-ascii?Q?bcxY0E/qziccMRfT6Dmg6ZgRymcB/INLFx+yz7MYwtleqZkI/lm8d4/akrJQ?=
 =?us-ascii?Q?g7gFH4otFuwdaq8jlnRJSWEqpfsyMwwBpGndvIDU761do+eVnm7PGL1DmX9o?=
 =?us-ascii?Q?hgc1bKsYjOSmko1CJzx9abUqZZoEaR3tr0GAaSSunaosT+QjS+ctTL6Um31K?=
 =?us-ascii?Q?oWNj3+QREuSETwrfWjuBjnnlRhsGx/95Bt5ZMMVKi1ZLx2FhN1woZ0HG1dlL?=
 =?us-ascii?Q?NfGhEDKyAVfD1UxxY75oXKL0GiVWOiBi09TIfLyF/gtTNrtsKveDPUrC+t7D?=
 =?us-ascii?Q?tmtVvfTTOt0qbErTmG/VrIsf4hPa4Ll/u6R65vKXTOt/m87F4WLiZ5CcGrlc?=
 =?us-ascii?Q?WZYtuA4kMkFNuGdVafSvbI3AgzPiU0v2HZ0dgRN4/00QD6Sa/aDMte5/PLZ7?=
 =?us-ascii?Q?DUqQCO0RM1T4Vr2SjXYDyigxqg7cZakyCMs/RcNppT7snwzzOnR4hgc9ESDt?=
 =?us-ascii?Q?rR/oGSn4+QEY8BoMxr71c702FqXGtKq6kE8xt0rsScag/lXh4Uv5eXyecuNl?=
 =?us-ascii?Q?ttkaKw8hZUfcb/2qsHLnLMP9J1y2Ku8GFd0+uJSycwv2vkjT4fIU7L4b+yE5?=
 =?us-ascii?Q?hsIlbHvvmlT72srhmHsZ8CgFAuOj1apCZ188pZZzCKXqrSrO6wgtMqPH2PBH?=
 =?us-ascii?Q?qzvgKaxJKEd+uwob+WUZgamsAFjhjwCM+Qjgbfli6PdkYfzBe8EM08iaQ7DG?=
 =?us-ascii?Q?k7tRPwf/EiXtuLuASPL5pZrJaOY22qLGNRDZj8yli5N0zbo6DlfmiLCailel?=
 =?us-ascii?Q?8N4QjB2IrvmL8zpdnJ94ET+Qg3Y2I+WCjJVATadykvoGGJ4B/JXo+YcOKk8W?=
 =?us-ascii?Q?BICtTzFzyNXkwuwYZIc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d6114e-18bd-4b18-5f67-08dac18d0d79
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:27:58.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SigL4fzAAIqRiSSjnto1zoiY8Gkp+FbHAxe2/jDW+H+y4mhtdWo6FoMfS/X2Z1h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 09:48:32PM -0800, Nicolin Chen wrote:
> On Mon, Nov 07, 2022 at 08:49:08PM -0400, Jason Gunthorpe wrote:
> 
> > diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> 
> > +TEST_F(iommufd, cmd_length)
> > +{
> > +#define TEST_LENGTH(_struct, _ioctl)                                     \
> > +	{                                                                \
> > +		struct {                                                 \
> > +			struct _struct cmd;                              \
> > +			uint8_t extra;                                   \
> > +		} cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
> > +			  .extra = UINT8_MAX };                          \
> > +		int old_errno;                                           \
> > +		int rc;                                                  \
> > +									 \
> > +		EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, _ioctl, &cmd)); \
> 
> I guess it should be EINVAL corresponding to updated kernel code?
> 
> > +TEST_F(iommufd, cmd_ex_fail)
> > +{
> > +	struct {
> > +		struct iommu_destroy cmd;
> > +		__u64 future;
> > +	} cmd = { .cmd = { .size = sizeof(cmd), .id = 0 } };
> > +
> > +	/* object id is invalid and command is longer */
> > +	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
> > +	/* future area is non-zero */
> > +	cmd.future = 1;
> > +	EXPECT_ERRNO(E2BIG, ioctl(self->fd, IOMMU_DESTROY, &cmd));
> > +	/* Original command "works" */
> > +	cmd.cmd.size = sizeof(cmd.cmd);
> > +	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
> > +	/* Short command fails */
> > +	cmd.cmd.size = sizeof(cmd.cmd) - 1;
> > +	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_DESTROY, &cmd));
> 
> Ditto

Oops, yes, I fixed these

> 
> > +TEST_HARNESS_MAIN
> > diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> 
> > +static void fail_nth_first(struct __test_metadata *_metadata,
> > +			   struct fail_nth_state *nth_state)
> > +{
> > +	char buf[300];
> > +
> > +	snprintf(buf, sizeof(buf), "/proc/self/task/%u/fail-nth", gettid());
> 
> Not sure what's missing, I have a build error at gettid. Copying
> a solution from tools/perf/jvmti/jvmti_agent.c file, can fix with:

I think your glibc is probably old

> ------------------------------
> diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> index 99eaa9f32e0b..7704b3a754d3 100644
> --- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
> +++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> @@ -19,6 +19,7 @@
>  
>  #define __EXPORTED_HEADERS__
>  #include <linux/vfio.h>
> +#include <syscall.h> /* for gettid() */
>  
>  #include "iommufd_utils.h"
>  
> @@ -84,6 +85,13 @@ struct fail_nth_state {
>         unsigned int iteration;
>  };
>  
> +#ifndef HAVE_GETTID
> +static inline pid_t gettid(void)
> +{
> +       return (pid_t)syscall(__NR_gettid);
> +}
> +#endif

Ah, there is a lot of complicated makefile stuff to make this work,
and it only works for perf/bpf not selftests

It looks like there is no reason for this to need gettid, we don't use
threads. So this can just be getpid and that is portable.

Thanks,
Jason
