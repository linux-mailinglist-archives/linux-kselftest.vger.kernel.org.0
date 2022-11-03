Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8126618963
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 21:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiKCULC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 16:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiKCUKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 16:10:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8CC22BC7;
        Thu,  3 Nov 2022 13:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leLh2ETI4Xx8YdcbYpZ0djPGGwtnMi+t1N+y4Eexe20MZILSmRyiKNPaoQb4fWP/q4XmFJFUTwGDCBBRgOYCQkmHmcnNbFvyavBEqECVa5GWl9YVnXD07NNuzlrDIyOiQP7/sXBRdmwVHYsHMeOUIaVH7DJMhgT1SzSQUICyFE9lOql+O58N2zsTzPW8xPx6L0+x5b5ls3itoYrYXaiLHaeFZpzsrit5d8Pi0JvuEX+nbXqOtTFJO7nRG2qiHgSSLwFxjjZiELdwpG8v5MYysC3JiHPwgBp+NW1B9wkWB3r6/7I/lB9tpgIby0rYmMb2NIOJHgalNYIoniiDEQ9Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zm3bIP3L8p2z0OUNnhV6jZNY5NfASqMk1xTsnAFnCI=;
 b=QyhEhPPNzsdb/P6f6kIXXal2mM4ZTxazCXTzzwsmZMhjPY4yyAixb1SLerc89R4OOam9ik/fxxmF1QR+dASbd7+hKKo1NEaPouyFE1ye0BozJRZWFQm4zhpjKLsse+Y8LGNSc8GogAk6PFAvsu9Z/6CygINeWRXvIur70kxX3Zz/KkG3w6qvwoAAK2OGygrC54BV52L8+bfgtVz7SkO6+xWVUw8jD/WweUQdFMqA0+NWg1QQhr2QUhacccq9sdThnEUwszF6KATUyHaZGnOijDIiBxmE3jrP7F0ZT1ugn24dDjWpnFG3S3QaPf71wfIrdZ/nzDh+knhBp34B8ckQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zm3bIP3L8p2z0OUNnhV6jZNY5NfASqMk1xTsnAFnCI=;
 b=unNf544L+elQTlBx6FALIwjFcTms8qVb1E0puFr6673nJ4QTAJ71KmOp7znh2njC5DI0MF4XdFw1+GiWx+cM24mhEQHWPNduKDeerDtZHEmI5E7qakLcYZFJ56kNcfbzhNfDeDvMJrnb+v/wfZuMuLoYpyijqgWyVLl+tVOB7ElBsvkU7A/57lnACEPz1QqsJkl+QUARdOU96vq2K6lNe+zaClWiu9UZ20oAaWdUC+WlKLpvTPOFAzjz16AaBvcNyxHBiv5H9XO4ctXuCEuVsGKncV5TJVPUe+x3AF6qXjpdVcfRyEhXC5xXXqRrfCI6vaAgxQan9CtaK4/s0wTeiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 20:08:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Thu, 3 Nov 2022
 20:08:10 +0000
Date:   Thu, 3 Nov 2022 17:08:08 -0300
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
Subject: Re: [PATCH v3 8/15] iommufd: Algorithms for PFN storage
Message-ID: <Y2QfqAWxqT5cCfmN@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: b3852987-e928-40b6-6e26-08dabdd7210c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QhhWZcAE7T73USA680PHEcRNrgHVxtYlDU8bcddGS8bGxNnLOlMwiaMS39Q9xrcbJyX5GBdUHqv1kXDMscYKH+ux9+R852th+Pi20BohuGRXEaLhPODEKOS8oSx1KCfBIxxT5RYoHUwA1tkYXHmXAlhVNCVZ6rq5afT9GIFzXIaaFjit7bjslVZn1tSzOX9oedpsQ3iw6zxKZkC/tUKNeQg4OxZ9TuJAfJadDD4Q+2t8cfu0Pf+1TRE3fYqVmcb5ukGFG2jhW0q4RzgaL9MIVlJ0EvJccI4shHqBKhi8BgOxYTyz+GKsfggaH8hhkkyO7oCPy+p2zfSAhLVrYIlKyC3DQQPq+aIvA/3+eqa7YiPFK7qij3MIyFcYT+VJyL+UrKO64FuEYl8oz+em/yMsgvluU0Tah4eptrh3an8HPSJaa4EEqsqmP87g+XpsnRgdtBUAL3PdgpS825S3TD9xLhQFiyjSe6GqP2lJ6wKfVXJX26Qwykkc+yIlo9oDclFZK42qf7+Z7m5JVpMy33pcS24alMuHHYePbLOg+a5ykuUt0zz2aDUA4tzvzS50DGu51xmQY48ojuDWT/UV70/KetApMRVeKgOpOZfxGqLrmyT83JmQo/HL7O/+0IcM24Kna5xAu1ZFAfYqlb7jW303m7Coyihm8Ua6mPjEPu1CfFx3+0uBXMEX3ys7AaKuYnE4nQJlk528tVcXxFqf0HNeaPlpJoJPWj0gKeteCNrHazcJysFwaqAu4VX1k1+GkxyIspF9WujnuuEOpwOQU5IFjSSC6h9WxZg/CM3Q/i9znlOD2xVI8Iz769og2dErtKrQZm21tYWUQMYn86ervjrsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(921005)(26005)(41300700001)(36756003)(86362001)(8676002)(66476007)(66946007)(6512007)(66556008)(4326008)(186003)(8936002)(7406005)(5660300002)(2616005)(7416002)(966005)(478600001)(6506007)(6486002)(54906003)(110136005)(316002)(38100700002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjmVIT0evtLp+SHTLmW+txnxnw+dTMOtZty2u1Mx9Zx7+LPt/svF/bfSLp0z?=
 =?us-ascii?Q?/qsWq2bJXXO07mi451Vk7XMR94kHEgFfShX+10Zy8eeDwnCYpVBmNftRxC3k?=
 =?us-ascii?Q?C0v3L0Yq/uk4WhLYqk3IgiGzHnQ6ZXPg6wPYVh+bJetc+ik4Jg9NrrGv+kpb?=
 =?us-ascii?Q?9PFtgKHFbYaZOFAL0lGiOh/px9/sFVET6nF7v9n1DMng2piE4+pO5nfpqrjj?=
 =?us-ascii?Q?vtB90FhsEdVBqCMHUh2OnJFaUN0PMA6S3TKyr0Qs1xJ6ZN+NVQ46uHC6Qjtf?=
 =?us-ascii?Q?7kOrRxPJ+i4g0Vu9cWWhunz3hZeXxFFNQXkcLnZ+VsjUjudhGjEsrdT2gRkN?=
 =?us-ascii?Q?OXh4tXr19WkZuJTxlezq5BLiu9kKhBQRTXf0HZ8406xwPxPy/wuGq6riiV3O?=
 =?us-ascii?Q?aIfu9sIbjSI8AUCf2Et3UIVPmEDKD0IQZCXJPZvo0KxHpwxVOYggVvKciKLs?=
 =?us-ascii?Q?pChpiwvjGSfBKf6ewVVHbjgX42WeGXUMMVQlf3TGlrWiLDCXQepdALQ655I/?=
 =?us-ascii?Q?d0uIHYLihJ8dbdRiTgqYhpMbTwUThMiFU3MfvV1o/lbcfHWy74aztvGJ5BCE?=
 =?us-ascii?Q?33eXKjRzAGcevJurYkaZR4IIYaC3kVRktZkUN64r9f506u3Mz9ZPA25ZdZq7?=
 =?us-ascii?Q?GvZ3TjilixYkesLt89sdgUou1s/VoOvxHpyX/qncWFvG2zAYhpx9QO1uQLYt?=
 =?us-ascii?Q?Nc9V8glPKjkdvM08y9ML//0YcKR2vmbLu85kTkf2F+qNL4i3cFJPaKxO/wCP?=
 =?us-ascii?Q?ddX2e9cyulPhureo6U1mn7kaJQxExcjDnfb7CettyuyPns6oHoIENNBwJ6lA?=
 =?us-ascii?Q?t5Z2VCP58Kgs3upMxqVdKbrcO/RsdQhKmOX3wol7u2nfpWzezxzqgnAYYfNK?=
 =?us-ascii?Q?XC4AoIz25CP1zmqtF9Q90pz2e3vqUPRXXylWKyC0Gx9FQ26sKU5ujEvmTFs1?=
 =?us-ascii?Q?KP4m3kd+S6UGtULzp23C+hfwHcYQYXRbyK401bK1NbpetDcvWXJjuFXpi6KI?=
 =?us-ascii?Q?1dZWJK3a8TolCY6f8dHi8daFmdPXRRm/+RSrXXR0hbTAGt8Q7DWc8ekluY9B?=
 =?us-ascii?Q?y/yYgzz1ixFI0jM+EJJg1NLtxp0h5wfg2okrlCN9FNYuRRKDKz3zypBX0CdH?=
 =?us-ascii?Q?r6yqKro3s3CI2PYPLr/gQMMxf9qSycqKlWdMbLaoJjuztt0S5F+hhxXm4PRo?=
 =?us-ascii?Q?/KgtxNUg2RQgKC4jGrUPxhojISosoT3EggoT0AsY4HVUIvtzx9AjkfSjhWtb?=
 =?us-ascii?Q?8HEkh7s9pFbPF7n8Tar8mN/dNJy2vFymvKn3bDzI0kxGY1rtlGmwFmv3yGD9?=
 =?us-ascii?Q?fQD8Cem6PKNaY9sQ4niUFlgGXIGJkk5gmUb13Ob/mWFCKh/4QrldCeH64a31?=
 =?us-ascii?Q?CJANxRHyzUfvjc7LvACSqwW/snUqogzBgItBhXHrRid9YhbwvydgVAEopqYB?=
 =?us-ascii?Q?abJxteaxmTkJ1ediJ5GbMpg7KpJ1PI5uhv5C5wMLDaQQ+Hgmc6JG14liDZay?=
 =?us-ascii?Q?dLgp06c6OiWxxR6kervh+t1r+6jxBTHtXGIYZdUXVd0b8sfaGex5kM3z+xPB?=
 =?us-ascii?Q?EZjUc9M6s+86OjDYHjI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3852987-e928-40b6-6e26-08dabdd7210c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 20:08:09.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePm9doUxLMBAo9VXMlSGz2lulRKwIew6kMy3i4TuAlEHH23N33F17+aVy+LSDLLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:17PM -0300, Jason Gunthorpe wrote:
> +
> +/**
> + * iopt_area_fill_domains() - Install PFNs into the area's domains
> + * @area: The area to act on
> + * @pages: The pages associated with the area (area->pages is NULL)
> + *
> + * Called during area creation. The area is freshly created and not inserted in
> + * the domains_itree yet. PFNs are read and loaded into every domain held in the
> + * area's io_pagetable and the area is installed in the domains_itree.
> + *
> + * On failure all domains are left unchanged.
> + */
> +int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
> +{
> +	struct pfn_reader pfns;
> +	struct iommu_domain *domain;
> +	unsigned long unmap_index;
> +	unsigned long index;
> +	int rc;
> +
> +	lockdep_assert_held(&area->iopt->domains_rwsem);
> +
> +	if (xa_empty(&area->iopt->domains))
> +		return 0;
> +
> +	mutex_lock(&pages->mutex);
> +	rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
> +			      iopt_area_last_index(area));
> +	if (rc)
> +		goto out_unlock;
> +
> +	while (!pfn_reader_done(&pfns)) {
> +		xa_for_each(&area->iopt->domains, index, domain) {
> +			rc = batch_to_domain(&pfns.batch, domain, area,
> +					     pfns.batch_start_index);
> +			if (rc)
> +				goto out_unmap;
> +		}
> +
> +		rc = pfn_reader_next(&pfns);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +	rc = pfn_reader_update_pinned(&pfns);
> +	if (rc)
> +		goto out_unmap;
> +
> +	area->storage_domain = xa_load(&area->iopt->domains, 0);
> +	interval_tree_insert(&area->pages_node, &pages->domains_itree);
> +	goto out_destroy;
> +
> +out_unmap:
> +	xa_for_each(&area->iopt->domains, unmap_index, domain) {
> +		unsigned long end_index = pfns.batch_start_index;
> +
> +		if (unmap_index <= index)
> +			end_index = pfns.batch_end_index;

syzkaller found that there is a typo here, it should be <

However, I wasn't able to make a quick reproduction for something that
should have a been a very reliable failure path using nth fault
injection. This led to a great big adventure where I discovered that
fault injection and xarray do not play nicely together:

https://lore.kernel.org/r/Y2QR0EDvq7p9i1xw@nvidia.com

Which ended up spending a whole bunch of time to add a nth failure
study to the test suite and understand what is going on and how to
make it work better. It now covers this scenario deterministically.

The exhaustive nth failure study also shows this error handling has
another, more serious, problem. We keep track of how many pages have
been pinned inside the pages, and we also keep track of the last
charge to the rlimit/etc. At the end of operations these are
reconciled. There are lots of assertions checking that this is being
tracked properly so that we don't loose track of a pinned page in the
very complicated logic.

The new test suite discovered this missing:

 		/* Any pages not transferred to the batch are just unpinned */
 		unpin_user_pages(pfns->user.upages + (pfns->batch_end_index -
 						      pfns->user.upages_start),
 				 npages);
+		iopt_pages_sub_npinned(pages, npages);

We need to charge back the as-yet-unprocessed pages we are unpinning
when destroying the batch.

And then we get into trouble that things are not happening in the
order the assertions would like as this:

> +			iopt_area_unfill_partial_domain(area, pages, domain,
> +							end_index);

Demands that the pinned page charge during unfilling be only
decreasing, never increasing. However we can still be holding pinned
pages in the batch at this instant that don't get cleaned up until:

> +		}
> +	}
> +out_destroy:
> +	pfn_reader_destroy(&pfns);

Here

Thus the assertions get unhappy.

Introducing a pfn_reader_release_pins() which is called before
unfilling gets everything in the right order and the testing of these
two functions now passes, though I still have to insert a few more
error injection points to get full coverage.

Syzkaller has found another 4 things I still have to look at and is
now sitting at 65%(72%) coverage. So steadily progressing..

Jason

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 245e7b96902107..ce707d6f5ee959 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -994,7 +994,15 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 	return 0;
 }
 
-static void pfn_reader_destroy(struct pfn_reader *pfns)
+/*
+ * There are many assertions regarding the state of pages->npinned vs
+ * pages->last_pinned, for instance something like unmapping a domain must only
+ * decrement the npinned, and pfn_reader_destroy() must be called only after all
+ * the pins are updated. This is fine for success flows, but error flows
+ * sometimes need to release the pins held inside the pfn_reader before going on
+ * to complete unmapping and releasing pins held in domains.
+ */
+static void pfn_reader_release_pins(struct pfn_reader *pfns)
 {
 	struct iopt_pages *pages = pfns->pages;
 
@@ -1005,12 +1013,20 @@ static void pfn_reader_destroy(struct pfn_reader *pfns)
 		unpin_user_pages(pfns->user.upages + (pfns->batch_end_index -
 						      pfns->user.upages_start),
 				 npages);
+		iopt_pages_sub_npinned(pages, npages);
+		pfns->user.upages_end = pfns->batch_end_index;
 	}
-
-	pfn_reader_user_destroy(&pfns->user, pfns->pages);
-
 	if (pfns->batch_start_index != pfns->batch_end_index)
 		pfn_reader_unpin(pfns);
+	pfns->batch_start_index = pfns->batch_end_index;
+}
+
+static void pfn_reader_destroy(struct pfn_reader *pfns)
+{
+	struct iopt_pages *pages = pfns->pages;
+
+	pfn_reader_release_pins(pfns);
+	pfn_reader_user_destroy(&pfns->user, pfns->pages);
 	batch_destroy(&pfns->batch, NULL);
 	WARN_ON(pages->last_npinned != pages->npinned);
 }
@@ -1223,6 +1239,7 @@ void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
  */
 int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
 {
+	unsigned long done_end_index;
 	struct pfn_reader pfns;
 	int rc;
 
@@ -1234,10 +1251,12 @@ int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
 		return rc;
 
 	while (!pfn_reader_done(&pfns)) {
+		done_end_index = pfns.batch_start_index;
 		rc = batch_to_domain(&pfns.batch, domain, area,
 				     pfns.batch_start_index);
 		if (rc)
 			goto out_unmap;
+		done_end_index = pfns.batch_end_index;
 
 		rc = pfn_reader_next(&pfns);
 		if (rc)
@@ -1250,8 +1269,9 @@ int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
 	goto out_destroy;
 
 out_unmap:
+	pfn_reader_release_pins(&pfns);
 	iopt_area_unfill_partial_domain(area, area->pages, domain,
-					pfns.batch_start_index);
+					done_end_index);
 out_destroy:
 	pfn_reader_destroy(&pfns);
 	return rc;
@@ -1270,9 +1290,11 @@ int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
  */
 int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 {
-	struct pfn_reader pfns;
+	unsigned long done_first_end_index;
+	unsigned long done_all_end_index;
 	struct iommu_domain *domain;
 	unsigned long unmap_index;
+	struct pfn_reader pfns;
 	unsigned long index;
 	int rc;
 
@@ -1288,12 +1310,15 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		goto out_unlock;
 
 	while (!pfn_reader_done(&pfns)) {
+		done_first_end_index = pfns.batch_end_index;
+		done_all_end_index = pfns.batch_start_index;
 		xa_for_each(&area->iopt->domains, index, domain) {
 			rc = batch_to_domain(&pfns.batch, domain, area,
 					     pfns.batch_start_index);
 			if (rc)
 				goto out_unmap;
 		}
+		done_all_end_index = done_first_end_index;
 
 		rc = pfn_reader_next(&pfns);
 		if (rc)
@@ -1308,11 +1333,14 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 	goto out_destroy;
 
 out_unmap:
+	pfn_reader_release_pins(&pfns);
 	xa_for_each(&area->iopt->domains, unmap_index, domain) {
-		unsigned long end_index = pfns.batch_start_index;
+		unsigned long end_index;
 
-		if (unmap_index <= index)
-			end_index = pfns.batch_end_index;
+		if (unmap_index < index)
+			end_index = done_first_end_index;
+		else
+			end_index = done_all_end_index;
 
 		/*
 		 * The area is not yet part of the domains_itree so we have to
