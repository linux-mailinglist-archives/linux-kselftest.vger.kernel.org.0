Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941804E307B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 20:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352433AbiCUTJv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 15:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiCUTJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 15:09:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8551FCCC;
        Mon, 21 Mar 2022 12:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXHNzHXCXrsP+6J9l8CkzeK2zuL+cJnMA8b1gXBDIKrQz5kOaNHI6jtA2DxLOXrwOf2RrZTqHtpFSGFneh8g68dHgh1ODb6wOGi0wHoaXtRX5dn58MjlsxvvmHYm1FvLqxIld8LRdG2kJrqyUT5LJfvut8hjHHPGe1kTGxRV8zp3yqAwJkYEFjmGJYR6oMYSSkOqAyLT6Lpr+CiTNsj3hFIEyLOjKIH/x1qe4KyDLf89gCH0KnOuodulcpDIfnHvEdQNirRtL/UmnLzqICXm5FmbeU/HOQovr7nNLVPqqzAX1HY6FaE6mVuqonDm6WrkaL3DoY0EXIwqXLnfCbrJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjES0IBRyTMPyFfNR/HhBSxjxOXhQb6WWZFOTXrYuSs=;
 b=YqC8i2WCTSqgEFWiMUCUzLo1ToP4R2wlrkOdjzOBpSr/KQ3XEY3tESKfwvyLL7uptEc3/SSBP+/+JzYWfXrMXh51Lnep+uSWOuuEd5KQDcmaYKdnbrvwCZNqh7DVJYIDGmUsyz10D3Adv2Fq5hIMsXHn+IS4YAi+AOzcTRCl0apoZQumkVH9zhxux1Oj0O4+bEPTCX/tAw/VBl2bnaDJfb1t86DLIrTzn7iqCCBvaxGK4Kp4n0rUGlHH1gNavWFzLiNnM2UurYvtNcPypukID57gqkcwG5rZyPGfcIrjqlzWU+JU0dv4XRiN+CwRUb8TPgJAlDJrtl8DA9QEMfduAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjES0IBRyTMPyFfNR/HhBSxjxOXhQb6WWZFOTXrYuSs=;
 b=PUleaI2X3FxPYCmHzo1lCD8GyC515gD0c6ClL+NkEgO3jHr+ZPNmSTitcI2qj24DcyNHVFBle/mx8DCRKsbGsofpaAmIO8HnaQjwn0gFjdeqZe42kudjIsEGa9nl2Fpv+T5qIIfpTSX8HrCRdP7yTH8BfCTWiQiDVF+kIQvZilQbQtzuG98zhqBFKiqHMxWNz4PUy7LoBp1CnliJjkVTevn6OMmhaGsWRvzMXzw9ELrmWpCg+DhQSBzGc1p1+zqtIJXgdsaq1epfE6Z/I3gd8kb9hLOLzAdEleBq0qk216yaN0uAqteIx3p/5Z6yCVLixZmXxuzywREaW3rc06BClQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BYAPR12MB3446.namprd12.prod.outlook.com (2603:10b6:a03:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 19:08:16 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 19:08:16 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] mm: page_owner: add support for splitting to any order in split page_owner.
Date:   Mon, 21 Mar 2022 15:08:15 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <364AEDD0-1BA2-4F36-877A-C5CD4BEC74B3@nvidia.com>
In-Reply-To: <YjjLzvT2if2JDbGE@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-3-zi.yan@sent.com>
 <YjjLzvT2if2JDbGE@carbon.dhcp.thefacebook.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_694D7C14-1DB8-4269-B827-50B94088E4B7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:208:23c::8) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d292118d-1e9f-4bc8-af61-08da0b6e2795
X-MS-TrafficTypeDiagnostic: BYAPR12MB3446:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3446890E7AB0C7D5F7BE6B76C2169@BYAPR12MB3446.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dr7wwYf3TJGUICCSI14kLyiwZTLA62viY1Ra8rPZ4iUqQxbE851Pt0T5bSPJSFgZwx66eXoJv0FkYcxL6hr6OZ8DR0bceZGwLOoquLTvCorwR1ALF0uY/0cB1HQWoYYsgF//xVBxpKfWDxQi63A7vE/2b1/Aa12tdt+ANwkovIccni52UHECmpzHpuK/cjYuZRmDdFsYNQPzHidLi0isx+FXjs+Y/FNH1r3VJM047lQ2zkC7XUCQHpKxKSJF+BEigvlMAH9vPzxmRdz7SrBNfsKF9kkm7rsBAPb5gajoZ+nmonV9qpS9pyyMVA0JLL+1xNgooAMCHRcD49ihYnWG3Gs9cGpE1cao6r1eazSLqvF9MlGQOJ/VWajiW8zObthRbh+b/pAP692JNma58tON7OuYwJa+8Y/Y2rKKbEsYZ7biM4SkEc8vDvftnACUix2/kUFAkPF9Xy0zajEUBE3BuSEWfnMvcxqBx5gupS7RIF11x2otO0VXg3renf9vV+tD0Cw6wfwqanKDi1NRO2W8h5nX64AXdW6l0wR1GMPNTFo9J/h1ZXJkGM5pkgDjhZHYVbjW0uPZ+oLrPa6YggxXW3gU2uC49S88J7jHGtbqKJ2kP8Ma/MLnoB9qm3mTtQBr6LKgqcbZUFVcC2Tw58oJfLlASzDI4OKyTdbtOmCEZKWRLxwgF3+IZ/2PSakqgIMyi+sTDUT5wUjZ/3KekC/IKR6tRbLEzCSB/QsHXjRFwhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(54906003)(508600001)(6486002)(38100700002)(6916009)(316002)(2616005)(21480400003)(186003)(36756003)(53546011)(6506007)(83380400001)(6512007)(8936002)(7416002)(5660300002)(235185007)(66476007)(66556008)(8676002)(66946007)(2906002)(4326008)(26005)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TjLwBga7i1BGmdAkRhZqHwdGR+UiywW+KrQMaP9Ziskx7eHD1Nqc/e0embxH?=
 =?us-ascii?Q?8o8vbc3lhr5ioeN92YdgBSaSQ8QMipgpMg/eO9Nr7dRLsMBoRMsmgzJuIHJq?=
 =?us-ascii?Q?MaL8zsOb11rUQqNGpflPjC5uwvhZRukzzoM4mT73bMlzANERDvn65LZYBx5Q?=
 =?us-ascii?Q?XAFSFLCIBs4Lma8aSu8e7WZgeZ4XQZW9E7NPiQGZB4Q2w8R+bc2uiYNmt1KO?=
 =?us-ascii?Q?f2sxKAnNYvPOjBNt3/CSeumADP4nfC0vGkk5bfLQWrQigl5T9uDm3iJ9E7Gx?=
 =?us-ascii?Q?tvR0zaVJeWKrvsF5df8cp3VFKxSG5eDFPKl7A8azP+ax77GAI+p8m1mzbEat?=
 =?us-ascii?Q?ZuqioQ1jp4MdQEGLN6O0OyLmD5Iu5xY15K6Ka415j4jkLx2kjgN0N+vS5oiQ?=
 =?us-ascii?Q?/Az17mNrq9fChhLTw/06o4sBP8GGLBaLaJUuqE6WgsuZjBJZHOItNlP5TMT9?=
 =?us-ascii?Q?C8sKviUh8TjyDexci9LeXPk0iPqj7VUgKPhAvlfJhMQO9gxK5srpA6GC2wbQ?=
 =?us-ascii?Q?GduMcgbWdsMyoif3vdK3alnWBGiebbsWSQqzInRN26YbPl/Lf1KqQ5Fp6ICp?=
 =?us-ascii?Q?rHt5aWbe/KUuCZIekxQbUY3O8u/uCR1z3ELFnx4Y9Ypn3PxYG47ZWM1Dt6Us?=
 =?us-ascii?Q?VRXjHYHTWzkMIMTvEFO08u+vtm5V68ED9w0CAIpGjqzAGbVVcUpob5z7ARBR?=
 =?us-ascii?Q?BSgRUBSgX0/GH6EFKX8VAaCnSjXSHOvkxjJywPn0JGbv/6oKQ0hU+VShVWu5?=
 =?us-ascii?Q?mq8gNrSREzxTX30K5jV6zn0BJherJk1nTFDWR4QoF4TTEpaRbbUsGSlVosSx?=
 =?us-ascii?Q?KI2T0m1vzXf5h3jPJA+vgShBlBRvWGQ/kSZzPUL+PyGcTYugI/K1wgw9JxH/?=
 =?us-ascii?Q?QJUgHqDXlroQ0y59CE4ETK3XvQN2iplRteFNwI9Oxjvbtii9ONQDTAFh23sw?=
 =?us-ascii?Q?FuuuAAGDfddKZAI/UkcgbJaJ8BodPaRND+LgsV7awvH9G4I5GvRHKQC0rvw6?=
 =?us-ascii?Q?6OxG/+Ibn4ZfavKyIgEI4Z8WA9/ZXxN72JNH2HtaMgQUJyR2P4hnOxlGDK9G?=
 =?us-ascii?Q?ybcg8OTzQ6poyjvDntmxk1dWUI3EaCRg8H80xyfKOjG0XOmyFD0gYBJ4j5S+?=
 =?us-ascii?Q?rJsLv0xT1VlD+bP+pY/kEfMxeIUReY9PccBUBe7yqBW/sOnCBCJGzHSaISWt?=
 =?us-ascii?Q?5EZRuuaRObhAwTVZUqXK8kOXGsXxIAm3cu4GU+EG2/D7/7gZnAIFyMmNFneN?=
 =?us-ascii?Q?MKfaED/a9WJPkL6B1eRb7gXC4OtX89ejVSDlvHbQO7Gioq7d1yTEirKvW8/w?=
 =?us-ascii?Q?fJUgg9n8VFSt+PpUYxnhE+JilKzCalM7CzYw1sYYJQIigU31OSvBq9bcflfv?=
 =?us-ascii?Q?BpQJMqzYceUf6K0Nw919OYkkegMZHnpNYKwlkT1CSbIR3K/MqgmP8R4jQy45?=
 =?us-ascii?Q?RHaai4n0e/2cgViJO0bef+j33J3PyE5+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d292118d-1e9f-4bc8-af61-08da0b6e2795
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 19:08:16.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5piUdyS8H7Snj0/Fwzo/xEKb0CerGjbKQaxkwFRDIX7VM/7BeQKbZh8V+wGYZcVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3446
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_694D7C14-1DB8-4269-B827-50B94088E4B7_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Mar 2022, at 15:02, Roman Gushchin wrote:

> On Mon, Mar 21, 2022 at 10:21:25AM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It adds a new_order parameter to set new page order in page owner and
>> uses old_order instead of nr to make the parameters look consistent.
>> It prepares for upcoming changes to support split huge page to any
>> lower order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/page_owner.h | 12 +++++++-----
>>  mm/huge_memory.c           |  3 ++-
>>  mm/page_alloc.c            |  2 +-
>>  mm/page_owner.c            | 13 +++++++------
>>  4 files changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
>> index 119a0c9d2a8b..16050cc89274 100644
>> --- a/include/linux/page_owner.h
>> +++ b/include/linux/page_owner.h
>> @@ -11,7 +11,8 @@ extern struct page_ext_operations page_owner_ops;
>>  extern void __reset_page_owner(struct page *page, unsigned short orde=
r);
>>  extern void __set_page_owner(struct page *page,
>>  			unsigned short order, gfp_t gfp_mask);
>> -extern void __split_page_owner(struct page *page, unsigned int nr);
>> +extern void __split_page_owner(struct page *page, unsigned short old_=
order,
>> +			unsigned short new_order);
>
> Unsigned short here,
>
>>  extern void __folio_copy_owner(struct folio *newfolio, struct folio *=
old);
>>  extern void __set_page_owner_migrate_reason(struct page *page, int re=
ason);
>>  extern void __dump_page_owner(const struct page *page);
>> @@ -31,10 +32,11 @@ static inline void set_page_owner(struct page *pag=
e,
>>  		__set_page_owner(page, order, gfp_mask);
>>  }
>>
>> -static inline void split_page_owner(struct page *page, unsigned int n=
r)
>> +static inline void split_page_owner(struct page *page, unsigned int o=
ld_order,
>> +			unsigned int new_order)
>
> but unsigned int here.
>
>>  {
>>  	if (static_branch_unlikely(&page_owner_inited))
>> -		__split_page_owner(page, nr);
>> +		__split_page_owner(page, old_order, new_order);
>>  }
>>  static inline void folio_copy_owner(struct folio *newfolio, struct fo=
lio *old)
>>  {
>> @@ -56,11 +58,11 @@ static inline void reset_page_owner(struct page *p=
age, unsigned short order)
>>  {
>>  }
>>  static inline void set_page_owner(struct page *page,
>> -			unsigned int order, gfp_t gfp_mask)
>> +			unsigned short order, gfp_t gfp_mask)
>>  {
>>  }
>>  static inline void split_page_owner(struct page *page,
>> -			unsigned short order)
>> +			unsigned short old_order, unsigned short new_order)
>>  {
>>  }
>>  static inline void folio_copy_owner(struct folio *newfolio, struct fo=
lio *folio)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 640040c386f0..fcfa46af6c4c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2367,6 +2367,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>  	struct lruvec *lruvec;
>>  	struct address_space *swap_cache =3D NULL;
>>  	unsigned long offset =3D 0;
>> +	unsigned int order =3D thp_order(head);
>>  	unsigned int nr =3D thp_nr_pages(head);
>>  	int i;
>>
>> @@ -2408,7 +2409,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>  	unlock_page_lruvec(lruvec);
>>  	/* Caller disabled irqs, so they are still disabled here */
>>
>> -	split_page_owner(head, nr);
>> +	split_page_owner(head, order, 0);
>>
>>  	/* See comment in __split_huge_page_tail() */
>>  	if (PageAnon(head)) {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d982919b9e51..9cac40c26c58 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3514,7 +3514,7 @@ void split_page(struct page *page, unsigned int =
order)
>>
>>  	for (i =3D 1; i < (1 << order); i++)
>>  		set_page_refcounted(page + i);
>> -	split_page_owner(page, 1 << order);
>> +	split_page_owner(page, order, 0);
>>  	split_page_memcg(page, 1 << order, 0);
>>  }
>>  EXPORT_SYMBOL_GPL(split_page);
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 0a9588506571..52013c846d19 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -202,19 +202,20 @@ void __set_page_owner_migrate_reason(struct page=
 *page, int reason)
>>  	page_owner->last_migrate_reason =3D reason;
>>  }
>>
>> -void __split_page_owner(struct page *page, unsigned int nr)
>> +void __split_page_owner(struct page *page, unsigned short old_order,
>> +			unsigned short new_order)
>
> And short again here. Please, make it consistent.
>
> Other than that, looks good to me. Please, feel free to add
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> after fixing the type inconsistency.

Sure. Will fix all the inconsistent types. Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_694D7C14-1DB8-4269-B827-50B94088E4B7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI4zR8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUavcQAIpYY/4dCqr9UPuuZM1GxgrT4nzJimIL7i47
JWd15FbH3NzuvkZ1keBE9mSjZ/UqZ6X6K35E83VQ4qUXyyNpMLbaSLC5pDDjXhFe
THst3po0LwB8ecW8B1ddvEUpikMwqSKXBfe1DaRZt4b1RTHKjbqM7KPqD8+DOlS4
up2PgceQqTnIDtRbJnT8rI6L2SfSMh91+Dct5PrrPD+p5BPvTBc0O25eR05rkuXr
UqD6ynBNQBGMrKnFX+Zr4nhnZqWfCIe1RSbTn6rsBKZk2tOJ53gwehXt3N+L/+Ra
lupYAuo+roPk/wM6fwR700mSAgmYuywau0CXVKsA3/b4a+KSnpX0KJqnM37KiFo+
z1HRvpI7Wr9d+tRJ7lExL9X32pUz8iZDXqgKm8BzOe69OP57JBUVs7GX60P96FGI
Gq6VO/1YQyLrwIbx3iCdSUmnoIhc0NfZpvIZiCwl8negNL/sHXgpBNUqAIvyeZbv
1MTDnGhsrj62byaqPfYevTjyPYLnIAmcBKHhfUB3k7JoAu6L4styYvsP5AFCFR0w
7BKK0ZkaplusMT/E+/ikXoifWEp3s1lrFlcXl59Z948V/qBHBJ+JXdpNJtVCLzoD
twwPax1VAtaneFAYaMscdin2q8M3jw+t9yG8uae/+uDMpnQm+2JumUnnwv0RZBsK
xRIcPiCl
=uG1B
-----END PGP SIGNATURE-----

--=_MailMate_694D7C14-1DB8-4269-B827-50B94088E4B7_=--
