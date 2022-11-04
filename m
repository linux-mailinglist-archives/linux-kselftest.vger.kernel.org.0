Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE09618D5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 02:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKDBB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 21:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDBB2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 21:01:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2402BC5;
        Thu,  3 Nov 2022 18:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX06+mrHqy/bofCh99wn2wz9a7ZCN/UeXVf7lMDlpQZQpUGZcxfB7KsOuAt1iC6mFzzwSsXJF18hG9ctCJl6cG055QdjuQH+hoLfLvAK16UDo6WS12Mb9ef5u1LETIYr0RbxDZY9nKFxg+pp4tTJOmmZF2nnf6VVqVaGbpauHCrbSpwhKoMz4sFSq5W1TYObIXfQKpnk6orainV9WMl1nHcDvk38kBa4m31OhcItGY//2JQ3YiPdciA87qZUyJT8KKdCpTjTUz6tY1nnJAU3v5L0M26OqNMBeJplwfrovOH3EE88ExlB4HA3YXYI+1MHfK3CBxF6Rt06k29UMzmXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEP7l7aPJ0HVUr1jSlstmTerFfJ5jA8N/g7XJ3oH60Q=;
 b=VS5mRkFesk4Z+xGVJvZHsvkSxcju2YyxwTiUU6LxcvQ1U/AGZL4dA/hq53OG/6/dcI2q29mR4ngaLJoQ1dl/nWrUJil4is5r/D+b5gsjewid43pzTcWos2lsPR3c+yDn7+VsnsPMtb/A66xc3mXCjiwDsjhhqJ4BbNYYiNR53jKC6iubedml39my2n4mb7HnkrsztmtB7iavDXQKy/BpknDl7TdksKzl6uZbXMBPraCiAtaHY3jhq6DFqLQznuLFFQlrEImoDPwQiIiE4+fUhPVaekmv0Q5B6JUKLWtWY2GPg7l9D41QrNKvh0HALaE1RDxA9OwGBi+IuVH4muEGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEP7l7aPJ0HVUr1jSlstmTerFfJ5jA8N/g7XJ3oH60Q=;
 b=PjMxVCty8Xy70+/va2KuN/0fDBOcvQpOUhX85RznRYbzDfKovJB/phZdeYwxMUl15sDR/HlqSAVu8jix3FUoaW0RVAhFKjXYbqjoDwffi6HUOTiD2DHX7rq1E8QC4PQKm+GRjcLP65g0x8icJuGulDlecvvn3mHawsMu3FVU/LBIWvnYBwsEI97nl4jkc7EnnLJWzhfurJ7lEJk6wRXOq9DoxML1vQeDwoa1QusPSUuec5fdiPD9k0QtXPltPsTStZwCJiYbwsf+c84ZjTTm0aae8psdmR+nYyn2Maq/cvrPAHul0Y+SfeUjfNZW05PQm9O6y1aNIASgJrykk5O5og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 01:01:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 01:01:24 +0000
Date:   Thu, 3 Nov 2022 22:01:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
Cc:     Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 15/15] iommufd: Add a selftest
Message-ID: <Y2RkXV+q0Q6bdTde@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR1501CA0028.namprd15.prod.outlook.com
 (2603:10b6:207:17::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 740c9bbb-14f0-4a78-de20-08dabe001809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GT2zdRz4Iqi6dhj1K6EwRfWcrfghKX5UQ/vbo1fG3W76E9qNK2oel17DJMe/qP6ZbW46S8wWMv38cSyfd8GjxoLczWW10oxWvdzjpoCqq8B5yMpW0xwyrULhxBT5Y00BM3Fa8yA06FNPs107xNvZ/su7IWGgI43S8ue1242cJmmKpKhrDqzbhzJzPuZFVSY0dTY+Im9hIjS0XPA9oDrvKdGmrnTIa23lXd6M+RXkqSiXC1bqTgiqEnh1llXoUjl/ekGtizzqntWrinvTkIi0MFhOx53aAR7OsaAl7BcUMNfKEXE7kgE4waLSAoNgfY3LCEBUMBVV+qGK7ZdMZ1ALIFbEEiU/tcd4AwWS6S773O8EtAlmu6S9aVMXvXj4gIaJZDTWrq+/yEiTEDT1yHku8mzZX4bJN1CE0iraIIgYv/0KD3xEQBS/cWvXqJjTFtPlN1eU36HjRpx6Jx/5HS2qXaqrhXJGOq14Qms+xFmC11i0qJ/+h3EaTku0PhedzDDZzn/LpohwAFOS6qKHwEq0+/eflNJlYtVQ9L1sPEsoU5Z3q7WYhgFT2MoQdZ56ftg47GpImQgqqXZC1/zHBp2sJ0FGIRMcO/tigx0JHDrv/oqdYonQ6JIgdcNNh8iDk4nmuvMtUkPBd0fITCTKVJueUxAo/LOwMjB/H7QODno1mldKERxCxtYTeaZ4cx4HAECiOY7ClG8scPCojnfO5hH3H3TPXR4mOAIDOCjcAdoa6u7Cr5e2Z43rBfblq1eYRxJ4JKBva1ipnkk1/D/nNIGbmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(8936002)(2616005)(83380400001)(4326008)(316002)(36756003)(26005)(6666004)(5660300002)(186003)(7416002)(6512007)(66946007)(66556008)(8676002)(66476007)(41300700001)(6506007)(2906002)(7406005)(6486002)(54906003)(921005)(38100700002)(86362001)(110136005)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GaCzzxWX2pFPtKET2t2+m8nZyT4BC5i4k8NGyPr4hIaTMZW8UFUkDRyRZXLl?=
 =?us-ascii?Q?gtgPtvA1gP/pZSBKA6iXPORJu4UFJN9JESr2e7Z9UrbXhYMM+CGRVq4+tLr4?=
 =?us-ascii?Q?kxWuFcHdgLp3QIWktq8+2Bqdc2CkgTjd8FoJgswpOjh7lIKlWKr6kT5UvcoY?=
 =?us-ascii?Q?wuuD3gOdbEhGjxJuawGkVUg8vv9/1swk0RsAPSR9CEuOT/5MA/i19nhaa+gr?=
 =?us-ascii?Q?OMX9Q9AHYmIdM3v/HbsScjJeyyEUOtwEJz893puAbyvW1wjlOxszvHQTBVxZ?=
 =?us-ascii?Q?xZhDyKU+TEwgnO9+aRqVUfGh0ArJi+ANCxtBnAhWbO6M9osz8StPXFv27r1I?=
 =?us-ascii?Q?k69OftGlWZyewbKJHvlx42MKhpH97oH4ZWpfoGh0wb6+1imdvqBx1MTs8Soe?=
 =?us-ascii?Q?VEqQsWod6DqPsy7/XMunXoJeDWDputILzb3xINEOqYmTyVq72xU5uU+UzCQz?=
 =?us-ascii?Q?n1gvyXPuBL5Geckd7s4GT6NcJu0SOlbQ3BWlhx6Hva1BrkukpIsrfJXyvH2s?=
 =?us-ascii?Q?pfxWMUevZESTe9KuI5C4elHCppU1C7BFRGdz390TX6xqnlnlFTJ4C4lH/fjB?=
 =?us-ascii?Q?0fxEJnr42h8IhwmurqQ1FKtMUFXJmilItB7YcwdV95il+dFwDem3RprK8uiK?=
 =?us-ascii?Q?yYiZ3vh8OSmbdyXTLnXqSkDnLC3dpe3eZZI5dqCJS2AudLx7mJAYdWb7y1ih?=
 =?us-ascii?Q?6utfT1pfUxaIwgGC9G9ovJ8rTc28W9ohp2fHzBefM6m9LHvNcwPzhccVg/o4?=
 =?us-ascii?Q?4CaqKQiVHN1NMaKIEXDgbPUCkUa9hokjOMAyd0uOnxq/DF3Idj0VjjFWjdH9?=
 =?us-ascii?Q?dWf/FSQxqmIavx/R6FVNpVhI1RVq5yt/GffVap0X8aimhaEllbI+6HLV/8GX?=
 =?us-ascii?Q?gR5fjC1DyhZcZO/Trr7HzXJ0/JhphNolNZRic43TlneBWjbS3wTB4liRj90O?=
 =?us-ascii?Q?krafBZvw7bKqkja2hmwn0CoI7WKNc8nPhTNlNgDP+Aj5PNsTrV1ZNIezOiv2?=
 =?us-ascii?Q?9wcTnukIz/XqMlSDXkPwrNYiKdFTYaiJCSK0RcFxSuF+o+qibO4I9doMMhRs?=
 =?us-ascii?Q?79u/6TS3mzZkwyuLWx/vOdd9gORsOtG6hunYIUq+YZ8NvcoBMHe3Om0e3oc5?=
 =?us-ascii?Q?WSKxoMBfa3AiBx+NMrEcLOsQsSD3q04lF9Og2x7EZLBsButcFc9n2JeiRjau?=
 =?us-ascii?Q?xu71rcDTyNdYzWC0ep9zqZo2UmRxaCVUaHZ06aRUhzVrpsCeSot3+AskVTfk?=
 =?us-ascii?Q?pOCNuOnsKxxdQq5pFak2Zjz3HY7dJ3aE/ZLyMEzajIq5ilO4A9lAKJ0g1hoY?=
 =?us-ascii?Q?W5UXILyxL9RgD/BbckoZ67SiNVLIW/J0dcvqDzxpNgxXVEsgqk/YJGRZnMcj?=
 =?us-ascii?Q?6kVIdXg2lGvqc/AMKSGSMr1K235Ed/ilQVV/FNbhoVc+KxyyOZpDPDHbC/K+?=
 =?us-ascii?Q?/XRFXIYqelrGzssjFJRDSPaA9Bsn2ZKy1pB1ZMq83q5M4eO6pVESz/Pzr8if?=
 =?us-ascii?Q?+TKqabPdBIFYn0YOMhMdRpgxiGcm07LJAJneYUwRSPTXft/pWNRZLYibvoU9?=
 =?us-ascii?Q?BWlEBgtsnqKqWbxHkQo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740c9bbb-14f0-4a78-de20-08dabe001809
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 01:01:24.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz0Ii0WcSxn0UAxoQsHf8PfmUbdgwRH2ia5SzQE6sGhqRwjxVQxR4uC8U7bO9zAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:24PM -0300, Jason Gunthorpe wrote:

> +static void iommufd_test_access_unmap(void *data, unsigned long iova,
> +				      unsigned long length)
> +{
> +	unsigned long iova_last = iova + length - 1;
> +	struct selftest_access *staccess = data;
> +	struct selftest_access_item *item;
> +	struct selftest_access_item *tmp;
> +
> +	spin_lock(&staccess->lock);
> +	list_for_each_entry_safe(item, tmp, &staccess->items, items_elm) {
> +		if (iova > item->iova_end || iova_last < item->iova)
> +			continue;
> +		list_del(&item->items_elm);
> +		spin_unlock(&staccess->lock);
> +		iommufd_access_unpin_pages(staccess->access, item->iova,
> +					   item->length);
> +		kfree(item);
> +		spin_lock(&staccess->lock);
> +	}
> +	spin_unlock(&staccess->lock);
> +}

> +static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
> +				     unsigned int access_id, unsigned long iova,
> +				     size_t length, void __user *uptr,
> +				     u32 flags)
> +{
> +	struct iommu_test_cmd *cmd = ucmd->cmd;
> +	struct selftest_access_item *item;
> +	struct selftest_access *staccess;
> +	struct page **pages;
> +	size_t npages;
> +	int rc;
> +
> +	if (flags & ~MOCK_FLAGS_ACCESS_WRITE)
> +		return -EOPNOTSUPP;
> +
> +	staccess = iommufd_access_get(access_id);
> +	if (IS_ERR(staccess))
> +		return PTR_ERR(staccess);
> +
> +	npages = (ALIGN(iova + length, PAGE_SIZE) -
> +		  ALIGN_DOWN(iova, PAGE_SIZE)) /
> +		 PAGE_SIZE;
> +	pages = kvcalloc(npages, sizeof(*pages), GFP_KERNEL_ACCOUNT);
> +	if (!pages) {
> +		rc = -ENOMEM;
> +		goto out_put;
> +	}
> +
> +	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
> +				      flags & MOCK_FLAGS_ACCESS_WRITE);
> +	if (rc)
> +		goto out_free_pages;
> +
> +	rc = iommufd_test_check_pages(
> +		uptr - (iova - ALIGN_DOWN(iova, PAGE_SIZE)), pages, npages);
> +	if (rc)
> +		goto out_unaccess;
> +
> +	item = kzalloc(sizeof(*item), GFP_KERNEL_ACCOUNT);
> +	if (!item) {
> +		rc = -ENOMEM;
> +		goto out_unaccess;
> +	}
> +
> +	item->iova = iova;
> +	item->length = length;
> +	spin_lock(&staccess->lock);
> +	item->id = staccess->next_id++;
> +	list_add_tail(&item->items_elm, &staccess->items);
> +	spin_unlock(&staccess->lock);

I haven't been remarking on the bugs that syzkaller finds in the test
suite itself (sigh), but this one is surprising and complicated enough
to deserve some wider attention.

VFIO has a protocol which has been mapped into iommufd allowing an
external driver to convert IOVA to struct pages *. iommufd natively
represents this as the sequence:

  access = iommufd_access_create(ops)
  iommufd_access_pin_pages(access, iova, length, pages)
  iommufd_access_unpin_pages(access, iova, length)

One of the quirks of the VFIO design is that if userspace does an
unmap then the unmap shall succeed, but like in a HW iommu, the above
pin_pages is revoked and the external driver must stop accessing that
memory. iommufd achieves this by calling a callback:

static const struct iommufd_access_ops selftest_access_ops = {
	.unmap = iommufd_test_access_unmap,
};

Which has the invariant that upon return the unpin_pages must be
completed.

This all sounds simple enough, but when you throw syzkalller at this
and it generates all kinds of races it generates something like this:

            CPU1                         CPU2                 CPU3
    iommufd_access_create()
    iommufd_access_pin_pages()
                                       unmap_all()
                                         iommufd_test_access_unmap()
                                                            unmap_all()
                                                             iommufd_test_access_unmap()

    spin_lock(&staccess->lock);
    list_add_tail(&item->items_elm, &staccess->items);

And of course since the list_add_tail is in the wrong order it means
iommufd_test_access_unmap() doesn't see it and doesn't undo it,
triggering a WARN_ON.

The only way I can see to solve this is to hold a serializing lock
across iommufd_access_pin_pages() so that neither
iommufd_test_access_unmap() can progress until both the pin is
completed and the record of the pin is stored.

Fortunately in the iommufd design we can hold a lock like this across
these calls, and in the op callback, without deadlocking. I can't
recall if vfio can do the same, I suspect not since I had in my mind I
needed to avoid that kind of locking for deadlock reasons..

I doubt any mdev drivers do this properly, so this will be some
oddball bugs. Thankfully it doesn't harm kernel integrity, but it does
leave a mess for a userspace vIOMMU which is tracking a guest command
to unmap an IOVA range and the kernel chucked out a WARN_ON and told
it EDEADLOCK. I guess sleep and retry?

Anyhow, the below seems to have fixed it. And this is the last open
syzkaller bug, the rest were dups of the prior one. Now we wait for it
to find something else.

Jason

@@ -420,7 +420,7 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
-	spinlock_t lock;
+	struct mutex lock;
 	struct list_head items;
 	unsigned int next_id;
 	bool destroying;
@@ -458,19 +458,17 @@ static void iommufd_test_access_unmap(void *data, unsigned long iova,
 	struct selftest_access_item *item;
 	struct selftest_access_item *tmp;
 
-	spin_lock(&staccess->lock);
+	mutex_lock(&staccess->lock);
 	list_for_each_entry_safe(item, tmp, &staccess->items, items_elm) {
 		if (iova > item->iova + item->length - 1 ||
 		    iova_last < item->iova)
 			continue;
 		list_del(&item->items_elm);
-		spin_unlock(&staccess->lock);
 		iommufd_access_unpin_pages(staccess->access, item->iova,
 					   item->length);
 		kfree(item);
-		spin_lock(&staccess->lock);
 	}
-	spin_unlock(&staccess->lock);
+	mutex_unlock(&staccess->lock);
 }
 
 static int iommufd_test_access_item_destroy(struct iommufd_ucmd *ucmd,
@@ -484,19 +482,19 @@ static int iommufd_test_access_item_destroy(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(staccess))
 		return PTR_ERR(staccess);
 
-	spin_lock(&staccess->lock);
+	mutex_lock(&staccess->lock);
 	list_for_each_entry(item, &staccess->items, items_elm) {
 		if (item->id == item_id) {
 			list_del(&item->items_elm);
-			spin_unlock(&staccess->lock);
 			iommufd_access_unpin_pages(staccess->access, item->iova,
 						   item->length);
+			mutex_unlock(&staccess->lock);
 			kfree(item);
 			fput(staccess->file);
 			return 0;
 		}
 	}
-	spin_unlock(&staccess->lock);
+	mutex_unlock(&staccess->lock);
 	fput(staccess->file);
 	return -ENOENT;
 }
@@ -510,6 +508,7 @@ static int iommufd_test_staccess_release(struct inode *inode,
 		iommufd_test_access_unmap(staccess, 0, ULONG_MAX);
 		iommufd_access_destroy(staccess->access);
 	}
+	mutex_destroy(&staccess->lock);
 	kfree(staccess);
 	return 0;
 }
@@ -536,7 +535,7 @@ static struct selftest_access *iommufd_test_alloc_access(void)
 	if (!staccess)
 		return ERR_PTR(-ENOMEM);
 	INIT_LIST_HEAD(&staccess->items);
-	spin_lock_init(&staccess->lock);
+	mutex_init(&staccess->lock);
 
 	filep = anon_inode_getfile("[iommufd_test_staccess]",
 				   &iommfd_test_staccess_fops, staccess,
@@ -662,10 +661,20 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 		goto out_put;
 	}
 
+	/*
+	 * Drivers will need to think very carefully about this locking. The
+	 * core code can do multiple unmaps instantaneously after
+	 * iommufd_access_pin_pages() and *all* the unmaps must not return until
+	 * the range is unpinned. This simple implementation puts a global lock
+	 * around the pin, which may not suit drivers that want this to be a
+	 * performance path. drivers that get this wrong will trigger WARN_ON
+	 * races and cause EDEADLOCK failures to userspace.
+	 */
+	mutex_lock(&staccess->lock);
 	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
 				      flags & MOCK_FLAGS_ACCESS_WRITE);
 	if (rc)
-		goto out_free_pages;
+		goto out_unlock;
 
 	/* For syzkaller allow uptr to be NULL to skip this check */
 	if (uptr) {
@@ -684,25 +693,22 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 
 	item->iova = iova;
 	item->length = length;
-	spin_lock(&staccess->lock);
 	item->id = staccess->next_id++;
 	list_add_tail(&item->items_elm, &staccess->items);
-	spin_unlock(&staccess->lock);
 
 	cmd->access_pages.out_access_pages_id = item->id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_free_item;
-	goto out_free_pages;
+	goto out_unlock;
 
 out_free_item:
-	spin_lock(&staccess->lock);
 	list_del(&item->items_elm);
-	spin_unlock(&staccess->lock);
 	kfree(item);
 out_unaccess:
 	iommufd_access_unpin_pages(staccess->access, iova, length);
-out_free_pages:
+out_unlock:
+	mutex_unlock(&staccess->lock);
 	kvfree(pages);
 out_put:
 	fput(staccess->file);
