Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0B4E4131
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 15:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiCVO1y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbiCVOZe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 10:25:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC628BF33;
        Tue, 22 Mar 2022 07:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2wtcopW1pBTJTmS30WxCqU9Z9iMic4Ja6qv5RZy+LefSyuR693Mh+23ccxqOhF95QIPbYhhTKYxNnkWE7rR8JdeiFRhxNZtjhccekjQEHaR+JFzFYCwkqRi6cPmQYzABj9btIF5wCnyI8Z9zc5bIoZ6nOkZw3t2Ek58JoD2CSR546BcZzuZ+fhaYSG2TNU+j3XI5hRRd2C8zL5tmOL7OCO+BjFSJ/Im4ObzAwioCIGFWSrhMdRq+8vnXPVIsfqQJr5SIwLBM6mhuat2HY3DMCDtLD4zMBoA1dhGcZjyONdNMM4q6Kc1bUBsXrB3RuprinD/mMV5XrtQajPEx9uLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htsRGu1YIXs/kpj29TnjkfGuNHyVYSCDUoY7iqwDUEI=;
 b=LR7qR7ENu7RlxMAh39sWfWHUl1z6ZVncwSC+V/WHqNpJEZGmnvQyyhI7pPzNw3xWOntrBeZ8DS3/rkLIrW7SSy3Gy/i6wRnMLncHKviBmxI7pn8AQwNijpxz6AGHTQzCDlNvhBI8yicBON2brxDHr0mXWGWSgjyCBEMCWCDFYvivXa/8sONtDAxVkoA5Y1tbYd5eYJK+OOUT+iRoK3pTXEMEXo5yP8wNt0BSbpyNGMApQveYGpUyf3lGH//2Lxda/US+qt1/ofuZkTxvs/SXrb+lWxO5U2UwHhF498VRma//I8UImXXlz6dbvDb+4zpAlMSOmQkYiuzsGNRJ/maLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htsRGu1YIXs/kpj29TnjkfGuNHyVYSCDUoY7iqwDUEI=;
 b=ltyiFhb0pQ1k9OdpyjU6sXpAiJHRLKQqeyKDjOH21zwgnOMdnbVd6RfA7u7CzVWtLCy3D77JwljTkEYpKUP13yHJ5ijUaaIBQi32JfjE2Ak0/j5K8MAEKfgBiw9yE6mTyw1f2TUVoahV+aL4XgL5UKAZc9Um2dHO3c9Ys9FphwiwKvfK2u024AkJAPjninrz0Jo0VgVErk1QO2XFAZc9UgCt4OVQwW5erHy8H9jM/V+in2T7ofgh9Rq817aiWOOnJhgX5SCEqd+hvxU+R82gdcpJgIkmdcTtL2vMpSzUk8B7pA8nw1a3EhLXjO1d4UViUctonC/dQ5Y+c7tMZP40ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 14:21:30 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 14:21:30 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] mm: thp: split huge page to any lower order pages.
Date:   Tue, 22 Mar 2022 10:21:28 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <7CCF90D5-A132-4CDC-B6E3-DDB151F6E98B@nvidia.com>
In-Reply-To: <Yjj5mADYABiZSxGB@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-4-zi.yan@sent.com>
 <Yjj5mADYABiZSxGB@carbon.dhcp.thefacebook.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2D8DEE1C-1018-4BDD-BC22-3843829C0362_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::20) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb4cdc8-d5ed-4402-1303-08da0c0f4272
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16844931443985A2F8B1CC7EC2179@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oadHqjV2Rm19FL2cc/ihGCpMgAn7DCToemS3y3N6LiQdLavkLk4SBM2JdA9/fOhaLff8iRlkdZpgmQ0NOBifRtlDPsTl3Xp1BTjSFurUpbeEZot5KyH9ueLuQZi4cQPWjOoDk9sVfX2izW0zqXuuf7uB6h+qZMj/5HOCFzOkKWnQvyHrJw7MXaPk4TzItKjzjQ7fm8Caw1sIHvIoFMP8Pi0G2HlFB47z4PGLUNtXLdXE63VaTH2CY0T8xSSc9GS4TpaBEV9qcva7aT2eExLqLVX10n6QgsdWj0wWTqsRuoc3NVRKVMCrGNWeVZm9HWMeWjeqtJr/P/VGsZozTy8o7j4tQDNu/VlFcANKEOyfefna8gpC/EsE+OI5ycGAc8yLdOzgOQXIxCUoS8qfU2ktAsvV+xnSlUl6Ot0j9zL82fzoz7MRhoVGz5qoKgwdkZpIST5jvCRQTVXgjU8bs9E1P2BeEn1JN3pwtEsk1QYvU0IhcGlngkd2qFETUGEnafhNwYl/Q37RNo1j8AdoTdSqhrca2WIMBAwKmBfQnpWpB4y5mmBSVy4RQ7AsRhHY+X76gBb+Mi+131/PK0X7nN/UmkU4epkIM5xg0OwSuZC4UWpNo5NX+I9h0K9x9zbQAY5J3lqkVGBdxfss+/cZlE2sz1lQVuOyqsp8tHeW33yGkpzr51m/GKG1igQc3XeycZv4j1HC9vuY9Ig0gWCI5CDPSsWYLdO4SfPY0bdp0jgXSAwPEo/TGrSBzs5tp5EhJtHS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(30864003)(8936002)(5660300002)(6512007)(508600001)(7416002)(66946007)(66476007)(66556008)(4326008)(6486002)(316002)(86362001)(2616005)(26005)(33656002)(38100700002)(21480400003)(83380400001)(36756003)(186003)(8676002)(6916009)(54906003)(2906002)(235185007)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zondbmyJhl1Zhn1IqhIfxudngrH8dBWUBqSPaA0hQk1dmq8yf08DR+dXTnC?=
 =?us-ascii?Q?Ui+Y48ByuqNy4Xhz4VYG/lJ431Vd33x6kL1Q6SD+fbysb1u4Caqk10HTLp/M?=
 =?us-ascii?Q?GJcGBbRInDtA3Yfvmi384ycx/QMhEkp2EhsPei4B3j4JjfyC3saQ339ShZqi?=
 =?us-ascii?Q?084EGCxd/gpUFRBDiHkECDODWbYNvRiWu7owxC6O3iLnq5Y0b/1S//hLBs5y?=
 =?us-ascii?Q?Z6qqinl1y7Au5QpbL3GbygPkwyWYl2xZoN65oObqh5tc/Fkd7V2W+/UwBbws?=
 =?us-ascii?Q?rgy0Lk4fjBl1X/8c9up/sryQ3/FmcE/X/jFLQxRT1AcjWRrBrOvDGWTrWhXh?=
 =?us-ascii?Q?3YkU8KXBhzBckZdwGN+HetQgTHaXd1GST0cdgJ1Jx3kEBqMJ6c4cEBh0Ep0w?=
 =?us-ascii?Q?FVmhiKtOL8cK3Qs6tIwIBdzyxSHac8jGFTTftrfnnq6bTwU/O7zFOuYhAcb7?=
 =?us-ascii?Q?wPopA04bqGnOdLHrGaSzvOFc8q8DRD8Pai2QLT0Rx2NHn+/qepl635Hbk0D4?=
 =?us-ascii?Q?zEwW3u0s0ELlsQsW6lM/mmXi6ozXctLW/00v0hCRpXz83gKmjkfzz1N73zeC?=
 =?us-ascii?Q?stAif1gZpJX3WZbC7VwG/aN4gsSTaWs2L4lGqD0EAe1jnsokjQJkEAXbBCAc?=
 =?us-ascii?Q?tra8dxNuuEr2vR3LCLRyOWoktlRugvE+0ABU7xBls8isE2yGE1HhOQP1yxNa?=
 =?us-ascii?Q?BoxBg1Hc91OJQNZH8diXb6o8xab8CIx3ILInPukJTkEryz9KYXwzXpZlSWCS?=
 =?us-ascii?Q?WgeJUbzyFkQ9H1czNiQEAz/0EDbSVX1aM+ZxSXudVtlmSf82K0PgcDu6PHEB?=
 =?us-ascii?Q?W9vnz9NQhvmQi6EMmnRk3TqhQzEtxhzhmUnA/utGgjMFh3nw+xNZXoaJurHp?=
 =?us-ascii?Q?EuBIxK58g8HHYZO4XR6fCux410JAZsnuY3T58xHTXr1lW2XHSWNRe53h+736?=
 =?us-ascii?Q?DQka7+bV07IbAoIhRzC3hIZKsBWcRa+uQQzRdU11up62GsS+hpfRoOzCe9wN?=
 =?us-ascii?Q?C7OCue8rqiGeuG0eu9dhPptbuJ9fKGr0KSuZP2dI0PvG75UMszlQBPStE26d?=
 =?us-ascii?Q?eUfAl/hapukHGGb+i1dYSC+/h2XRKLHsS/A7uSr5oA8GeLph6opBExV1PMz+?=
 =?us-ascii?Q?RV8FTlhrnBkTHvlxuiOzm0vux56GiLlm7AmdfWk8HKwUSnJpBBFTdB2LriO9?=
 =?us-ascii?Q?nmE5hZrF1X4vHUrJG0XscN1w0JiF+mQdLvPfnrfdl0Im4Li/59F/MjXaFMB6?=
 =?us-ascii?Q?JiFojovIa/OHerkypUrPvnWQu08Vz3Byl3mIy0WM1n5rvq9BApm9RC6Gb/B6?=
 =?us-ascii?Q?qc5MSEJ3DL7+a9gczbg6uDNkl7oUZ3xvDaHuQeF0HkOwYC7fX410SRA7lRWT?=
 =?us-ascii?Q?IF5b4yD6S5QCEWGkZHZ7O2zMgaAAmDz6TBkpVdhlDCKzFBAI3wJ4S3qw5j5N?=
 =?us-ascii?Q?/b/ijESukCrSxFzSGHkngInTd9OuDjcX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb4cdc8-d5ed-4402-1303-08da0c0f4272
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 14:21:30.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3W9F48uQkAlXyfas1F1TezLdUtkof0pgwLi/GDBt3wpgVIz9OhGumezk6Rsxz2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_2D8DEE1C-1018-4BDD-BC22-3843829C0362_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Mar 2022, at 18:18, Roman Gushchin wrote:

> On Mon, Mar 21, 2022 at 10:21:26AM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To split a THP to any lower order pages, we need to reform THPs on
>> subpages at given order and add page refcount based on the new page
>> order. Also we need to reinitialize page_deferred_list after removing
>> the page from the split_queue, otherwise a subsequent split will see
>> list corruption when checking the page_deferred_list again.
>>
>> It has many uses, like minimizing the number of pages after
>> truncating a pagecache THP. For anonymous THPs, we can only split them=

>> to order-0 like before until we add support for any size anonymous THP=
s.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Overall the patch looks good to me, please, feel free to add
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> to the next version.
>
> Couple of small nits below:
>
>> ---
>>  include/linux/huge_mm.h |   8 +++
>>  mm/huge_memory.c        | 111 ++++++++++++++++++++++++++++++---------=
-
>>  2 files changed, 91 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 2999190adc22..c7153cd7e9e4 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -186,6 +186,8 @@ void free_transhuge_page(struct page *page);
>>
>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>>  int split_huge_page_to_list(struct page *page, struct list_head *list=
);
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +		unsigned int new_order);
>
> Do we really need both? Maybe add the new_order argument to the existin=
g function?
> It seems like there are not so many call sites.

Sure. I can do that.

>
>>  static inline int split_huge_page(struct page *page)
>>  {
>>  	return split_huge_page_to_list(page, NULL);
>> @@ -355,6 +357,12 @@ split_huge_page_to_list(struct page *page, struct=
 list_head *list)
>>  {
>>  	return 0;
>>  }
>> +static inline int
>> +split_huge_page_to_list_to_order(struct page *page, struct list_head =
*list,
>> +		unsigned int new_order)
>> +{
>> +	return 0;
>> +}
>>  static inline int split_huge_page(struct page *page)
>>  {
>>  	return 0;
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index fcfa46af6c4c..3617aa3ad0b1 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2236,11 +2236,13 @@ void vma_adjust_trans_huge(struct vm_area_stru=
ct *vma,
>>  static void unmap_page(struct page *page)
>>  {
>>  	struct folio *folio =3D page_folio(page);
>> -	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
>> -		TTU_SYNC;
>> +	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SYNC;
>>
>>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>>
>> +	if (folio_order(folio) >=3D HPAGE_PMD_ORDER)
>> +		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
>> +
>>  	/*
>>  	 * Anon pages need migration entries to preserve them, but file
>>  	 * pages can simply be left unmapped, then faulted back on demand.
>> @@ -2254,9 +2256,9 @@ static void unmap_page(struct page *page)
>>  	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>>  }
>>
>> -static void remap_page(struct folio *folio, unsigned long nr)
>> +static void remap_page(struct folio *folio, unsigned short nr)
>>  {
>> -	int i =3D 0;
>> +	unsigned int i;
>>
>>  	/* If unmap_page() uses try_to_migrate() on file, remove this check =
*/
>>  	if (!folio_test_anon(folio))
>> @@ -2274,7 +2276,6 @@ static void lru_add_page_tail(struct page *head,=
 struct page *tail,
>>  		struct lruvec *lruvec, struct list_head *list)
>>  {
>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>  	lockdep_assert_held(&lruvec->lru_lock);
>>
>> @@ -2295,9 +2296,10 @@ static void lru_add_page_tail(struct page *head=
, struct page *tail,
>>  }
>>
>>  static void __split_huge_page_tail(struct page *head, int tail,
>> -		struct lruvec *lruvec, struct list_head *list)
>> +		struct lruvec *lruvec, struct list_head *list, unsigned int new_ord=
er)
>>  {
>>  	struct page *page_tail =3D head + tail;
>> +	unsigned long compound_head_flag =3D new_order ? (1L << PG_head) : 0=
;
>>
>>  	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_tail=
);
>>
>> @@ -2321,6 +2323,7 @@ static void __split_huge_page_tail(struct page *=
head, int tail,
>>  #ifdef CONFIG_64BIT
>>  			 (1L << PG_arch_2) |
>>  #endif
>> +			 compound_head_flag |
>>  			 (1L << PG_dirty)));
>>
>>  	/* ->mapping in first tail page is compound_mapcount */
>> @@ -2329,7 +2332,10 @@ static void __split_huge_page_tail(struct page =
*head, int tail,
>>  	page_tail->mapping =3D head->mapping;
>>  	page_tail->index =3D head->index + tail;
>>
>> -	/* Page flags must be visible before we make the page non-compound. =
*/
>> +	/*
>> +	 * Page flags must be visible before we make the page non-compound o=
r
>> +	 * a compound page in new_order.
>> +	 */
>>  	smp_wmb();
>>
>>  	/*
>> @@ -2339,10 +2345,15 @@ static void __split_huge_page_tail(struct page=
 *head, int tail,
>>  	 * which needs correct compound_head().
>>  	 */
>>  	clear_compound_head(page_tail);
>> +	if (new_order) {
>> +		prep_compound_page(page_tail, new_order);
>> +		prep_transhuge_page(page_tail);
>> +	}
>>
>>  	/* Finally unfreeze refcount. Additional reference from page cache. =
*/
>> -	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
>> -					  PageSwapCache(head)));
>> +	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
>> +					   PageSwapCache(head)) ?
>> +						thp_nr_pages(page_tail) : 0));
>>
>>  	if (page_is_young(head))
>>  		set_page_young(page_tail);
>> @@ -2360,7 +2371,7 @@ static void __split_huge_page_tail(struct page *=
head, int tail,
>>  }
>>
>>  static void __split_huge_page(struct page *page, struct list_head *li=
st,
>> -		pgoff_t end)
>> +		pgoff_t end, unsigned int new_order)
>>  {
>>  	struct folio *folio =3D page_folio(page);
>>  	struct page *head =3D &folio->page;
>> @@ -2369,10 +2380,11 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  	unsigned long offset =3D 0;
>>  	unsigned int order =3D thp_order(head);
>>  	unsigned int nr =3D thp_nr_pages(head);
>> +	unsigned int new_nr =3D 1 << new_order;
>>  	int i;
>>
>>  	/* complete memcg works before add pages to LRU */
>> -	split_page_memcg(head, nr, 0);
>> +	split_page_memcg(head, nr, new_order);
>>
>>  	if (PageAnon(head) && PageSwapCache(head)) {
>>  		swp_entry_t entry =3D { .val =3D page_private(head) };
>> @@ -2387,42 +2399,50 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>
>>  	ClearPageHasHWPoisoned(head);
>>
>> -	for (i =3D nr - 1; i >=3D 1; i--) {
>> -		__split_huge_page_tail(head, i, lruvec, list);
>> +	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
>> +		__split_huge_page_tail(head, i, lruvec, list, new_order);
>>  		/* Some pages can be beyond EOF: drop them from page cache */
>>  		if (head[i].index >=3D end) {
>>  			ClearPageDirty(head + i);
>>  			__delete_from_page_cache(head + i, NULL);
>>  			if (shmem_mapping(head->mapping))
>> -				shmem_uncharge(head->mapping->host, 1);
>> +				shmem_uncharge(head->mapping->host, new_nr);
>>  			put_page(head + i);
>>  		} else if (!PageAnon(page)) {
>>  			__xa_store(&head->mapping->i_pages, head[i].index,
>>  					head + i, 0);
>>  		} else if (swap_cache) {
>> +			/*
>> +			 * split anonymous THPs (including swapped out ones) to
>> +			 * non-zero order not supported
>> +			 */
>> +			VM_BUG_ON(new_order);
>>  			__xa_store(&swap_cache->i_pages, offset + i,
>>  					head + i, 0);
>>  		}
>>  	}
>>
>> -	ClearPageCompound(head);
>> +	if (!new_order)
>> +		ClearPageCompound(head);
>> +	else
>> +		set_compound_order(head, new_order);
>>  	unlock_page_lruvec(lruvec);
>>  	/* Caller disabled irqs, so they are still disabled here */
>>
>> -	split_page_owner(head, order, 0);
>> +	split_page_owner(head, order, new_order);
>>
>>  	/* See comment in __split_huge_page_tail() */
>>  	if (PageAnon(head)) {
>>  		/* Additional pin to swap cache */
>>  		if (PageSwapCache(head)) {
>> -			page_ref_add(head, 2);
>> +			page_ref_add(head, 1 + new_nr);
>>  			xa_unlock(&swap_cache->i_pages);
>>  		} else {
>>  			page_ref_inc(head);
>>  		}
>>  	} else {
>>  		/* Additional pin to page cache */
>> -		page_ref_add(head, 2);
>> +		page_ref_add(head, 1 + new_nr);
>>  		xa_unlock(&head->mapping->i_pages);
>>  	}
>>  	local_irq_enable();
>> @@ -2435,7 +2455,14 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
>>  		split_swap_cluster(entry);
>>  	}
>>
>> -	for (i =3D 0; i < nr; i++) {
>> +	/*
>> +	 * set page to its compound_head when split to THPs, so that GUP pin=
 and
>> +	 * PG_locked are transferred to the right after-split page
>> +	 */
>> +	if (new_order)
>> +		page =3D compound_head(page);
>> +
>> +	for (i =3D 0; i < nr; i +=3D new_nr) {
>>  		struct page *subpage =3D head + i;
>>  		if (subpage =3D=3D page)
>>  			continue;
>> @@ -2472,36 +2499,60 @@ bool can_split_folio(struct folio *folio, int =
*pextra_pins)
>>   * This function splits huge page into normal pages. @page can point =
to any
>>   * subpage of huge page to split. Split doesn't change the position o=
f @page.
>>   *
>> + * See split_huge_page_to_list_to_order() for more details.
>> + *
>> + * Returns 0 if the hugepage is split successfully.
>> + * Returns -EBUSY if the page is pinned or if anon_vma disappeared fr=
om under
>> + * us.
>> + */
>> +int split_huge_page_to_list(struct page *page, struct list_head *list=
)
>> +{
>> +	return split_huge_page_to_list_to_order(page, list, 0);
>> +}
>> +
>> +/*
>> + * This function splits huge page into pages in @new_order. @page can=
 point to
>> + * any subpage of huge page to split. Split doesn't change the positi=
on of
>> + * @page.
>> + *
>>   * Only caller must hold pin on the @page, otherwise split fails with=
 -EBUSY.
>>   * The huge page must be locked.
>>   *
>>   * If @list is null, tail pages will be added to LRU list, otherwise,=
 to @list.
>>   *
>> - * Both head page and tail pages will inherit mapping, flags, and so =
on from
>> - * the hugepage.
>> + * Pages in new_order will inherit mapping, flags, and so on from the=
 hugepage.
>>   *
>> - * GUP pin and PG_locked transferred to @page. Rest subpages can be f=
reed if
>> - * they are not mapped.
>> + * GUP pin and PG_locked transferred to @page or the compound page @p=
age belongs
>> + * to. Rest subpages can be freed if they are not mapped.
>>   *
>>   * Returns 0 if the hugepage is split successfully.
>>   * Returns -EBUSY if the page is pinned or if anon_vma disappeared fr=
om under
>>   * us.
>>   */
>> -int split_huge_page_to_list(struct page *page, struct list_head *list=
)
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +				     unsigned int new_order)
>>  {
>>  	struct folio *folio =3D page_folio(page);
>>  	struct page *head =3D &folio->page;
>>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);
>> -	XA_STATE(xas, &head->mapping->i_pages, head->index);
>> +	/* reset xarray order to new order after split */
>> +	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order)=
;
>>  	struct anon_vma *anon_vma =3D NULL;
>>  	struct address_space *mapping =3D NULL;
>>  	int extra_pins, ret;
>>  	pgoff_t end;
>>
>> +	VM_BUG_ON(thp_order(head) <=3D new_order);
>>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>>  	VM_BUG_ON_PAGE(!PageLocked(head), head);
>>  	VM_BUG_ON_PAGE(!PageCompound(head), head);
>>
>> +	/* Cannot split THP to order-1 (no order-1 THPs) */
>> +	VM_BUG_ON(new_order =3D=3D 1);
>> +
>> +	/* Split anonymous THP to non-zero order not support */
>> +	VM_BUG_ON(PageAnon(head) && new_order);
>> +
>>  	if (PageWriteback(head))
>>  		return -EBUSY;
>>
>> @@ -2582,7 +2633,7 @@ int split_huge_page_to_list(struct page *page, s=
truct list_head *list)
>>  	if (page_ref_freeze(head, 1 + extra_pins)) {
>>  		if (!list_empty(page_deferred_list(head))) {
>>  			ds_queue->split_queue_len--;
>> -			list_del(page_deferred_list(head));
>> +			list_del_init(page_deferred_list(head));
>
> Can you, please, add the comment from the changelog here as well?

Make sense. Will do.

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_2D8DEE1C-1018-4BDD-BC22-3843829C0362_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI522kPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUdkUQAIguEYnhRRq2ZwhHFid8XfNO2Mk2C929xnKV
tx0NNNZB6qToJmi1JAo9OVdTG6iv/tharGjUUkhm7ylC94Sxj0g6kWnWJVryjOjf
j7GaYp48x3dhBRxXS9VldfJg6V/Z1tul00FjIQ0tqiX3RTBtfPiSGEhCLR6JakVi
wl5kO2xXxKgQ436caNJbUxnGo+GEfVmueMYMs31pNeHur7DV+Paijngw7lWeoCJh
gM/kdi9QwjHGUBC4guFxTJlxGvadORxF7nk3Ubwgu87uOpUYdUWLZ7ohCbv1etfX
a4Hw68M49QuCQl24FRdaaVF3PMmZa8RbFrZrEPZ/qhHkyGxQ6sjcvXJRt0GAnsiz
2oozHGZ/n4VGjrJWijJxd41D9cmm68EoqHk32YTeUCsK6/4Rf9/+56gvgqFeY+Q5
YIZlEpYSkIJ//qdjExzbOwaLTJ2kuIswyA4d7SZEQhrXNWaH4zoCOf9B01lRBsYV
7o0U5ee8cxnHEH4S9GYKEafseDkqpfYFJ012sYdLORhonR7ThNa+qb/JQmaurGxG
OjpBoLnSFkJidc1qGY7OQUi9pswDmsz5TO2d0VE2MVfFW+lG2CRgC8otz7cHbLwY
ccm3f/KtgRmTw0XXZO29slrwti/Wwo8aeMapGQtZnL0RBlnHVo3mgFghl667Ku5y
NGHDyV6m
=FWVC
-----END PGP SIGNATURE-----

--=_MailMate_2D8DEE1C-1018-4BDD-BC22-3843829C0362_=--
