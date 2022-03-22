Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19C54E4153
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 15:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiCVObr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiCVObq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 10:31:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C486A033;
        Tue, 22 Mar 2022 07:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJa+7hYoh9++SOMuwFjX/na+7e/pYKVO6QMiuEm/hfcu3tyFv4LAfg0/U2Ir0E4yRxSxX4IEIHA7R+nzi0SZHqZzBpA4q9fgPw/28H9+UL4tGX4TgvFzCyU6bwvcIMBJvlMs5SWuWdoYfcy+nqyd6ok/SzPeNcP1a/aHKSw99qL9BP4sZWadu0qvFBX7Msxlhz4jnNvh9LTlGnINIunGE34Euo0FtVut9+vFPmSoUs+azwRKaALAmD8nP+Eo3tJzXdD6vS3zN/dPSL0sZeFSaTiSjt0wLpQlMogIp/TnIFAcVyj05yDIgMdoFiEEjp6Os3KowXWN0ln2TH+8r8HODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwxShZGCwWXCNPsPx+oqb4+cktxK1cKHRiDUIG3iwd0=;
 b=XoeC3vt9PAKfvABzLlq90MnFagUOvon1Op7vkI+PXSNcH5R+JKAOmk7xFH8C7B2lkuRz4vLtqqvzeVcP7HSvTJJcwvUzsiY+656jEdfitDuhRRSvCLwITxDf2SRa4374CLGN4CD3Nth+1lK47NqdfcR8Z7iaK+3j4T07b2IUxy/DD87mltsomSrF8zrxsi9/c2x2SMDc+MeZLr2cFJxx8zcpZ1ihDNkhpVON4PWT1o684cLlHT12CEd6s4ONCMVWt7rY9zGJRbfhFTDmROllxWKHExTAYw82U5uZ7r94SwKV4ACHU9t9VyfLfYnOkDqJ3A2WaCC4Puv8DjVcembw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwxShZGCwWXCNPsPx+oqb4+cktxK1cKHRiDUIG3iwd0=;
 b=TSpTOhpHwR3klIXmcbmE4VbXvD4voo+h5tw7SMyVioBMtkmVsLTLF197L3G23lfqUybVbOOYWzwh5HkDpL26HQev8g/Uu4WHwmFns8kZxo8Dbl8NvU+Ule+qvFORW/CNcC78nl342M50B8s/CC/DrMOdqLsKPGKnh2cPwa+qjdazznplxgf5+qs4+fFURYKRxfCOt9i2qOxM76h90WTlT39nLZ9QIlZWq6uAdvTSGQU4bAIGGnTTiIew0kh+lnKDBUec3Iyhd4bai5I4Sv5Z5hoFwUriQ+qddY61kEPCa5qldCWMcHUA/8L7u7Nd2L0wg9+cJkV8U3bZQKwkfvTRZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 14:30:16 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 14:30:16 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [RFC PATCH 3/5] mm: thp: split huge page to any lower order pages.
Date:   Tue, 22 Mar 2022 10:30:14 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <D03D6945-8BFE-4137-BDB6-BD884656B65B@nvidia.com>
In-Reply-To: <165ec1a8-2b35-f6fb-82d3-b94613dd437a@huawei.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-4-zi.yan@sent.com>
 <165ec1a8-2b35-f6fb-82d3-b94613dd437a@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_11772522-6D16-4F1C-A239-DD3624EE149B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:208:a8::30) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b91dedc9-ee45-41ba-0511-08da0c107bb6
X-MS-TrafficTypeDiagnostic: CH0PR12MB5250:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5250E7D8306DD71250102593C2179@CH0PR12MB5250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVwjTIcY7cTx97anXQQVbh6YLX6ylwwrID4jqgZBMOewgb+8JmtuVZNj/sfGsL+EuFS+TbrOnliuJao2gyqfyGbQc1qt3fiPNujyiC4SteSLI6DboQ0waaq/F3YGESMKGXW/tIpXyJTvO8xaElOBO9vsP0+IKZ/GPAPikXhOe3KbamwI9xrTMnKC57vsfUPnRH43NDxZ9xetqo3qUM0BGbRhq2P0nTMNRXx4ehbv6XGceSMmIJOHPl31W2UxaJmjYo6HMKi1UkJxkfnhduZ5828Ybr4Nw8Bl8jIlcX+/k+3D359p5D8Letevgmlt1jTaqUaMgPCWqin93b3PwhzIuAApFfcLGFCfqBKlQ5J2wOKaieNzzKFIa3P8KYGZidfKBswqzyLesBHH94NHjbSqRQnbbP6NEGHGsyTYP5xcTGoxd0LsU5JWtK5yepTSbh+szltMRrV5VGsCBGyx6Sz1zSrMxUVWml3pLWUbG5E1sOFW/etmS+DlSFyh9uTgevEgXLa/n/89RLYpS8+sQiDvIJpx/C5F0ZNFU6pNYGhygON8bSJeV9/8B5HSlfld3N2YrP0yMCv3IybT+BIGqGXSB/kjRhfyE1y+Q5qyUGrA7/LE6v+vzJAJqh8OkD4zEjXXr1fO+HAqcT1Cz3TrldcmmYLHcxfk9eJn1GG45BcvwQwY6XmEuHeV+PE7T6YPYlxz1Yw8NwD7NzTdRjNM2klo/hquF6gTtSD5Z8me4J1tISHXEoxSt7LUZVFsgWHyshf9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(30864003)(83380400001)(235185007)(2906002)(21480400003)(86362001)(6486002)(508600001)(8936002)(7416002)(5660300002)(316002)(2616005)(26005)(186003)(4326008)(36756003)(66476007)(66556008)(54906003)(66946007)(6916009)(53546011)(6506007)(6512007)(33656002)(33964004)(8676002)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS9BVWEzWi9aZ3prdmtRUG5pUmNhVmU2MTlpZ3BUYzdZOU10MlpoQzg5VHlV?=
 =?utf-8?B?S2REd0hlcklhbjIvejdMYit1UHRXLzJlNFV0Q3hOVmhBNTg2VnJQTXlhUFIw?=
 =?utf-8?B?NG92UU1NMnVLM0YvTU5ZNlFyZkpJWndmbHM2MWtqYlA5THVqM3ZPOUEvTzNX?=
 =?utf-8?B?M3EvaERXQUV4M1VqdW4zU1VpRHJWd3QxQXFBZk9ZMmJES0s5dDFjcE9QcDVF?=
 =?utf-8?B?WHdyNS9iME91bFVrSDhnMXNNWkVReUlWcVB5MmVvQVIyNmNjM2FKSnNWQUV4?=
 =?utf-8?B?d2trRktCYUR5Q09yUzQ2Z0c4WlBzY3JJV0R2UmhEU2IydkM5YUU5WWs1R0sr?=
 =?utf-8?B?dmdrVThDVVJnZkd4OTJQMGovemdCNVpIYzJQRytrUHRRWHlHcW9YRE9wY2Uy?=
 =?utf-8?B?ZGRtUnUyVEl0QUxqWGJwWDZrUUdqYXBZUjYrTVZvMnJPK3EvampwbFNEdjUw?=
 =?utf-8?B?cWxnOUFUdFFFT0ZDU0R5YkNZK2xGWG9wSVh3YVJpcC8xQ1JEaFhCRVpwZTlS?=
 =?utf-8?B?dFhHRFI4U3ViSS83RU1tVmdqWEk3TkNEUERoR1FENVBkWVFyYlpiQlZtTGo2?=
 =?utf-8?B?Rk5QZ0JscXFreEU2VXlxdmkzR0JiVDFNNk8yMXhtUFVaeTB3ZjZ4M0x5U3k1?=
 =?utf-8?B?WVV6TTcycldBbDZ2MGp3dGV4aGdVblZEdDAzQU0xSjI5U0ppUGVSYVRUNVpq?=
 =?utf-8?B?MWw1U01aU21tNHBoUmlaRUcvbkFNVEFsWHkzSEFPY0c4a2t1MEtMSStaZWtk?=
 =?utf-8?B?OGFTMmlBRlVBRGVaR0d0c0RuTk9BMVhRU1M4RVg4dnV4M0hCUnJEN1U5UU56?=
 =?utf-8?B?RmI0ckVnSXZ2dlBVTGVTbzc4NDFlM2dwaVJZUzVuaG1yZGtMbFVHUnY3UTJa?=
 =?utf-8?B?ZG00YUkyUUFNa01qQnlCejcxcHZQSWI2ZzA0TDZWdFJDYm9Jb0VpOFNYMXNX?=
 =?utf-8?B?dXRBVHpmMkN1SGRVYVlmM0d1ZklGb0tvcXU4cUlxVC83NFFHbTNvbjI1SVhL?=
 =?utf-8?B?cVk0Yi9wTkxBUGFUVlc1L2l6Uk50TjRWUEx5QTVaVFVoK2psQ1NteFU0QTVm?=
 =?utf-8?B?elZOREU1dDJObGRFQnBWSklBV09OWEM4d3JVdlZqdmEvOW54WHdCd1lyREpU?=
 =?utf-8?B?N2c2enVXUEZQQ20vQi8wTndkUE1BdGExRk5wUEZVczRBS2dtUitUOVVpd3l5?=
 =?utf-8?B?a0RHRFA1VSs0Umt5SHFzV3RkVFZDSHdSQkVrdTA3cGIvSHEvT3hPTmtxb2ts?=
 =?utf-8?B?bFYrdFdQdnJBSHF2M0ZuWWdCRGVBVnJ3eGJSZFlQS2NsMk1TWDVRbmdyV0pV?=
 =?utf-8?B?VVpHSVJTaTZEZ29tYTd0VHNjanNLWDhMWm01WlQreHk5RmdEOHBDR0NpSG5k?=
 =?utf-8?B?NjJ1cS9uT2ZYQVdWTTY3ZndMNllmK3hlaDJOZUxBSzVRSXBRTVFEQ2NXZEdj?=
 =?utf-8?B?ZXlrcHNqQjk1c3pkNHduZkdwTzdlYTc5V2JFZlkyWWR4bGR2Q0VZenVPclBJ?=
 =?utf-8?B?eWJmcVFNUER4UmJBWFo3ZWZnY3lCOHRuTGIzMDJkVnNSVlVNMHZpVElFMlRI?=
 =?utf-8?B?SHlkaXFOLzJ4WlVDQjVBOHBocHc1ZkY3MExzZWVmcHE5MXZQVEhMbFE5S3hC?=
 =?utf-8?B?REtiKzEzcjhrK2hNMVJGdVVHVEVXbjBpQ09DM1FES29UdUc3dnBOVFpoSlY0?=
 =?utf-8?B?SkpTYXFReG5zOHlxUXFZUDJDeDRKWjliTUdMUy93a0ROcjBmclg5aDZ6cTY1?=
 =?utf-8?B?eDNvMVNtSUNVZzRCckd0SW1FOVZsVVZITXB2TjRHTlQ3NE44RFVIbXdWVVpG?=
 =?utf-8?B?N2tYTWxoT0cyZkRSMTRVQm9pMThYVDRPanhCNWhMdzg2ZVJNR2hVZXdvRjFk?=
 =?utf-8?B?a01WbndPZzhQVEtVOHBGYmJvczYwUmpTVVNMR1RHMjhzTHVkUlpBTXkxT29E?=
 =?utf-8?Q?Hix3FEvJj99wKgVciUKg3oG4opNtrp/p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91dedc9-ee45-41ba-0511-08da0c107bb6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 14:30:16.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnuY1mN1/UfEiPxhyyiCDv3xgsHaP334JRibm5XVf+I2STWF1PjvWqe7BiCdOP5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_11772522-6D16-4F1C-A239-DD3624EE149B_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Mar 2022, at 23:21, Miaohe Lin wrote:

> On 2022/3/21 22:21, Zi Yan wrote:
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
>
> Many thanks for your series. It looks really good. One question:
> IIUC, It seems there has assumption that LRU compound_pages should
> be PageTransHuge. So PageTransHuge just checks PageHead:
>
> static inline int PageTransHuge(struct page *page)
> {
> 	VM_BUG_ON_PAGE(PageTail(page), page);
> 	return PageHead(page);
> }
>
> So LRU pages with any order( > 0) will might be wrongly treated as THP =
which
> has order =3D HPAGE_PMD_ORDER. We should ensure thp_nr_pages is used in=
stead of
> hard coded HPAGE_PMD_ORDER.
>
> Looks at the below code snippet:
> mm/mempolicy.c:
> static struct page *new_page(struct page *page, unsigned long start)
> {
> ...
> 	} else if (PageTransHuge(page)) {
> 		struct page *thp;
>
> 		thp =3D alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
> 					 HPAGE_PMD_ORDER);
> 					 ^^^^^^^^^^^^^^^^
> 		if (!thp)
> 			return NULL;
> 		prep_transhuge_page(thp);
> 		return thp;
> 	}
> ...
> }
>
> HPAGE_PMD_ORDER is used instead of thp_nr_pages. So the lower order pag=
es might be
> used as if its order is HPAGE_PMD_ORDER. All of such usage might need t=
o be fixed.
> Or am I miss something ?
>
> Thanks again for your work. :)

THP will still only have HPAGE_PMD_ORDER and will not be split into any o=
rder
other than 0. This series only allows to split huge page cache folio (add=
ed by Matthew)
into any lower order. I have an explicit VM_BUG_ON() to ensure new_order
is only 0 when non page cache page is the input. Since there is still non=
-trivial
amount of work to add any order THP support in the kernel. IIRC, Yu Zhao =
(cc=E2=80=99d) was
planning to work on that.

Thanks for checking the patches.

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
>>  		}
>>  		spin_unlock(&ds_queue->split_queue_lock);
>>  		if (mapping) {
>> @@ -2592,14 +2643,18 @@ int split_huge_page_to_list(struct page *page,=
 struct list_head *list)
>>  			if (PageSwapBacked(head)) {
>>  				__mod_lruvec_page_state(head, NR_SHMEM_THPS,
>>  							-nr);
>> -			} else {
>> +			} else if (!new_order) {
>> +				/*
>> +				 * Decrease THP stats only if split to normal
>> +				 * pages
>> +				 */
>>  				__mod_lruvec_page_state(head, NR_FILE_THPS,
>>  							-nr);
>>  				filemap_nr_thps_dec(mapping);
>>  			}
>>  		}
>>
>> -		__split_huge_page(page, list, end);
>> +		__split_huge_page(page, list, end, new_order);
>>  		ret =3D 0;
>>  	} else {
>>  		spin_unlock(&ds_queue->split_queue_lock);
>>


--
Best Regards,
Yan, Zi

--=_MailMate_11772522-6D16-4F1C-A239-DD3624EE149B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI53XYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUni0P/2SYiHXPaGXxEsd8oqhjQk4tzl2euewBSFQn
9x3un8OgdfMY3NL2LZgadRH5/pApIK12DTZyQiohkUXcMFKxvcP70qpLv3LV9XIA
wXW665drodL4E28eqMMGBL6+iSz+WIjxYCuR8kdx/Sh6f4/NcV3vzMu3jTawENt7
RFQy+2tV/kfu8fRboW6YjsP55RoPBy1MoepRg5gXuHokRgxy4jIrbzm3kJkgv9MT
li3Ky4Gshw57XYeadN0+yoRGqi1QhJ9wScenBEUdg8BZhhtuIywwvSNETHEYdhn5
8/ni27aE4/5x6pWu/W36H81UAbQWtv5mGhUUF7CjntC190iykapRtO0xjh/t+PuU
MEf9X0KG+6Eu/ftcxgTlZeodS7/uTPMtpEZVgRH4JX38r8+5ZMEPgNxkcR1Ga5zM
E7Xy3+iFph4AXIIoRnZeFe5JZzGNu2H1PUJ1U9cTeWjVAtLTFRl+j4D+p7BOMpxm
W3Wu/UH8ExQY2yfGnc5OYYdeue/X58qio2qKoSOwAzx/vOvQseqfxxAbRXLTfiKq
njUgoxLWalfrtE/RXorakDY51xxX+7vQ9laMYRoQdHeqJLBp/YKSDstWKgKDzkOa
ckApR99BQt9VdCjGWWm1wK8Usilv+aWx6J+IAIG6vFuCEyvcbV38qvXnGDGuYFRc
4a9JJh4L
=YF9H
-----END PGP SIGNATURE-----

--=_MailMate_11772522-6D16-4F1C-A239-DD3624EE149B_=--
