Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE5062CBD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiKPVCs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiKPVBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:01:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41C69DFE;
        Wed, 16 Nov 2022 13:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDxxZ5cX3XmULXOuTjiFrhb2iM/7nneyW1kTuzkAxW6rL63viNnr3mGHjtueFGAVFSj85914a9S44Y2ejnhJsejbEGWuC1QGWiITLA+PF70vGL7U691Cxb2153vP2yIJOaPnnRDFl5wVSShw+gX8WcTXLHhCSFHf8EKCjxaGtlviyUfZfnhFhNFCX7QysuMxqS5PQNwAQDl2m+yZFFGlykL4oDlkYSHc/wv9Zv3RpEWOMvGG04YCXhXWWwnmkFmCs9/nV685gHuhy79/gKAV95xrNVD0JFEpVNUG9UT1NNZmqe9vk4Vswz+as1N9XG3kpSxf/MdwQ8RlwrXUZwXRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpSK8NitrBGuN2uMXSNCg8qN3BsVzG7VaERgHA0bYRk=;
 b=oQWyYV0Zbsm51wzf4siQqWC+hwSVykOeA88QikII/9214dj+QiGIZyucQr/KmBSQaLkxcBtfK5PmsTpGn1qlIaG59A9HdJV2tKi0fhFPKD5LlzHaKCq2gkwFdS0t4yg9vPrAh4GdNZ6uYmG9lfCnHhD6v7cKuRC61C+dNSEQwrU14Io+uMBB7WDMXTvbFD44M7IWsJTVcKkCGethnNFMx80eqHCkVHtDlmJlTHxOwpzjv4pF/5NK02+TssDXuVG0TfjxPBYAQtOmMnk7fFZlqnymqhAIavIURNnnWcnha3ahBxZ3iN1RXLbhXZ/xFSDT6F00LD5FXmW9URLxH9OKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpSK8NitrBGuN2uMXSNCg8qN3BsVzG7VaERgHA0bYRk=;
 b=oYUsdPqnnQASfl/2N0JxEdNq0tZ49csZHAnk8jTk+JyGGwtHKJVBFTAmHBrBcXnw0GeWQMsscWvN0wUJO17bGAPRLQ0IASKioPjeFU5gdrEib9Y36SP9qG6QzeUfABqoX1TKvrdh++P2PhGtkRT5L8EVQrIDk8QgJYF28Dkwa+O+EEgJ8jPiKy8NrEz4CZRi4Xq/EYq+PjbhjfVLkMFiX2oPjyV7246UsB6lMHYGhyIDFGvY8KY32Dl+ibhHBURvelHMy2HhTRLukvli5jKE5q4/bEmT5VGAY0k74d3hS86/+NXuaaKb1MaxkKXF8nq4aBnXCuSaDno1juAiVghkTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:00:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:00:57 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
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
Subject: [PATCH v5 07/19] kernel/user: Allow user::locked_vm to be usable for iommufd
Date:   Wed, 16 Nov 2022 17:00:43 -0400
Message-Id: <7-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: c2755163-545f-45a6-aff9-08dac815a81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASOBWAEWMVMu2tDJGmqTZzdJZWGMhqD02KjMGVs57mdm4H/UmWCNYBt1N9gQ4M0UcevsU+vhe4z6n3hXFgUhW9IZooLiGEV6ztahpSpTbYqT+kndfHewLWN5LcevcesmeLPZBVobbZnVQaPdee71SfLq58btDS15fPHseyLxO4sIUmMJKe30yqMRUsVATwUPzuPRvlsTw7P3ick6BXNVq/AknLkiTkJ4ehF94GL+U92xpWjdYAZpl+aoaANnqDMGBMo4JZtCiqd5UgopX2cvfpX5fjLMnjvYLo/dA6mqypvECalmqcZpqvZ96aeZxpmmJ25dvrY4HaAVsZCraQpY9APjctipFT1dr1hNB/1dI+L9VXmF+CCjsCR34e3bt2Hke6l3kHEDw+zx/suA+XiJWraolzH4uMprEYtPdNwkQPRiZhWgcq6dZ/BssuFjiP1i/jFUPHOyHH0PI6rxSAg+zrUz1+oxfWHara4azHCWViu0pYDXzoYBO1tvD7BCo+I91GcZuVteg3XSrruV+ESRtlZVUlhqf5OKeHwI6iI13aBJ1NiErRpO1+uBgGcsvDQLtC4oe/eKCnhlM6SegVNvewiZQBvhxs/qAd226rL+D/6IzPO6pr7Z+6EZrX8ymYE1mzjnZPu/XogFyWpQVtGyVGgXa7EoGid3aWjIX+5fzeGCrm/loCENNCQlOa33Itl/03SKevxGa7IVpqSWqG50LmExa2ByFUbFLY/DrylDIdHDAf6cO/44oZS2F2yrmfBhCySLCA0ZAEe+Lpl0auNmCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(2616005)(86362001)(921005)(110136005)(7406005)(6666004)(478600001)(6486002)(7416002)(8936002)(66476007)(8676002)(4326008)(54906003)(66556008)(66946007)(316002)(41300700001)(83380400001)(2906002)(6506007)(186003)(5660300002)(6512007)(36756003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0eWbHBRiNNePvwq5z6s57HzZQoF2B3NIcPxscyvcx54MsqxTksX/NmZ7SD+t?=
 =?us-ascii?Q?NFHL83WpYNLtZpdKy5C/wiK3rBwIPqrQ2+7nyc1LC7Uy0EvLSOZh2G0eBpZg?=
 =?us-ascii?Q?Wh1Ps6HuNtcj+A4xlUEkltHWlsn+dYewfLBEB0xBri6RHkdROviGqo0DI7Bl?=
 =?us-ascii?Q?oISE+2+mC9uzTcHl0GYAqDPvkj4tNkC4kS38ilQeeU36bPGAI740FueMen/x?=
 =?us-ascii?Q?gDLIHR0cKo+ucsgJ3sBeO5vWIpkorbH9oKnnZEqo5B8YZKx0ep4SCkUE2ULr?=
 =?us-ascii?Q?U8jJF9HePy6EKFggcgxwGr2ghRwI+/9BV44cOCAYGlAm9ot5KqhCvqhm+mX6?=
 =?us-ascii?Q?/Jl0tc/clSYZTb+9FVa6NX+Oq0NT5Mzj/iPXJ2xSWk/J7aqWT5e20rDUTCVY?=
 =?us-ascii?Q?RHchgrH5cFs8uGjcX5pPPTyVwdAfIMaFrAxuo2ZzO5yZjr2/NBti1IyWHAQT?=
 =?us-ascii?Q?7YQE/FoRNRIRn/pU6x9c/lwDd0B5NWets3MYOemBUngyvJ5K97Mccq0ZdWbl?=
 =?us-ascii?Q?YoSwA4xw/fN/kMqhxJwmtuG1paXDGEZXqCRJIEWm3NzNoS8wD1SwdOAKvL4D?=
 =?us-ascii?Q?Q76uz7ZzXP3riNa+/aF6bLGw3TQtn75dnQ0Ps/y0KwX+ScSSYCURu+MyBeJD?=
 =?us-ascii?Q?RB83MH8cv9N4L9iqA6jyQKGV1F5J842uucsraSA3DM3RpChyubSBm6WEDiCg?=
 =?us-ascii?Q?R54NOPDqnprfK+0z+f46ivAyXIpCDR9iu8CoagqDih8zwqs7DMUSxZIior7x?=
 =?us-ascii?Q?bUEvlYBilhUvXXkGKJWt/nOi7eS+9fPEGC5ccug4nAiNt/ZSpOhkMjwB6IpL?=
 =?us-ascii?Q?l8Grt2dPXMMeEf0EktSFHLKtMp9NGTGp7pWFDZOFzbMi/8bVz5qWzf/mdusC?=
 =?us-ascii?Q?KXVOmEPiUFjU00IQihqg8V+0TZ9MLROD8x5m8TcrgHRj/PWPjzz0lCC+ZuZu?=
 =?us-ascii?Q?Aaw0B6lrFtZ6ugp9TeWYKXbMs4TGFwcnyopPWUDwZ7J/uYeCZOGdG1SEpNi2?=
 =?us-ascii?Q?OXKOoSWUIPb8dAmMpLvms8/9Mi9PH7AIOFCxafh77am0bg5z0sXyhvULMxKt?=
 =?us-ascii?Q?K6IGFijACOStXKakTpEjI640B4ATNzOhqYMqzye9yqRgQOgnsvz4/lGzDyCb?=
 =?us-ascii?Q?Qv7hizkIwCKS9S0XtQ7hNJW2red/jVj1MObwsFbWSap4cq7BzVcgM5onfi8k?=
 =?us-ascii?Q?taCYHSzn5S/dD9H2P9Ck9IxaXZDdG4C45IgT+zmsIBxs9anRI/PFJf8gHebL?=
 =?us-ascii?Q?WsIdaLC80476kwY0S9VgWW2aRHk73IwV5HBF/8bqzlosA5duV4BdpLEizaZb?=
 =?us-ascii?Q?qMjgP1fwihilKUxQTl46DAoCqSzX7Fwonp3L/VoF0LYWBXrCO9LBw360HNFi?=
 =?us-ascii?Q?iHmQAMPZAOcT8ZSORNYhZx4JXvHcfgSyZfyXnxHGLwjkF47U23P6ESkbUkyl?=
 =?us-ascii?Q?MEN+5y1n/UNVKsCt7StuN4Hpsow2EW50kL+Q/3KuDA8os8dbNDTnJPp4hw38?=
 =?us-ascii?Q?iSDU43BeVf64JMVRF31etQT36EGXSgnSq09xBcHufeFmi69FHoOEhBwRaWS8?=
 =?us-ascii?Q?r/yOj26nu2il9qgk7PY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2755163-545f-45a6-aff9-08dac815a81a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:56.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNa/Fkp+iAxAoLDgdpNcga7QWkwmOYuDZqDAtsAonppPL4UTz+RxkxlmE5qz+D9+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following the pattern of io_uring, perf, skb, and bpf iommfd will use
user->locked_vm for accounting pinned pages. Ensure the value is included
in the struct and export free_uid() as iommufd is modular.

user->locked_vm is the good accounting to use for ulimit because it is
per-user, and the security sandboxing of locked pages is not supposed to
be per-process. Other places (vfio, vdpa and infiniband) have used
mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but this
is only per-process and inconsistent with the new FOLL_LONGTERM users in
the kernel.

Concurrent work is underway to try to put this in a cgroup, so everything
can be consistent and the kernel can provide a FOLL_LONGTERM limit that
actually provides security.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/sched/user.h | 2 +-
 kernel/user.c              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index f054d0360a7533..4cc52698e214e2 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -25,7 +25,7 @@ struct user_struct {
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
 	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
-	defined(CONFIG_VFIO_PCI_ZDEV_KVM)
+	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
 	atomic_long_t locked_vm;
 #endif
 #ifdef CONFIG_WATCH_QUEUE
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539a7..d667debeafd609 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -185,6 +185,7 @@ void free_uid(struct user_struct *up)
 	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
 		free_user(up, flags);
 }
+EXPORT_SYMBOL_GPL(free_uid);
 
 struct user_struct *alloc_uid(kuid_t uid)
 {
-- 
2.38.1

