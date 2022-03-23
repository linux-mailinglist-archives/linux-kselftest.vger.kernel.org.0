Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE744E5B14
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 23:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbiCWWMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 18:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbiCWWMF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 18:12:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCAE8F9B8;
        Wed, 23 Mar 2022 15:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGM73XxQGZbFR3z/Nbox3hF+OsNgzdEdX7JjxQT3NV1UlVJx0uPXWetCaXoXf6lfEgazdmsL5cz/yfr3+E1nHEQJ/MjD8CfVYfcZ3rbx5q3lRASSdrsO6NxB3AEy5nHN+oewZgVP0X4EJP5xae1nGs0K2O594GQR3+jwSdMtu/ceB8tiSOYjDJv0gBVADW84zfFSpBAJ/jiqcugRQijSsqFS9Y6MPHoVkM/ZbWmRB1UEvTUySyDlLdGU1UVpQlqPKttkzD/NYRRzwNjrYOIlk3/p+gWiQDO4MnIDXQhJpdpWaB5uwDuOvbhnnB+2D0mM06witW/Z/raGDpqp07lAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJwHhkjndhwwO4R9mAn4FNMo4+wYfhcZh9Yp1hLZu+I=;
 b=J7JFP0P7qTWcl3Bj+bTiyjhExV4coKayCMTcmr4rFVYoz2FJSNxK4s5BBTqAFtuP63oaUiA37LrwaG18MRayg9B74dMw7SBLXZ5W+4ePTkm3aIVmexdjpzV96zVqVkYS07X4OjADgPhBAC6yM4gxS320moDoxjHxcHR2aXh/qFArz4ukDXY+ZOfLIfWOuOTgSQr3KdPqpU2eKGvItNwEDRgAToUDdW9d+QxVDStSrY6Sndv+ZKPI+zefitbFVG2eFSB8IQOTWrqQSSGY74mDTakOJ/2aA6YELENbzjbYaSpUaGRakCHccemNH7sjJKCaBgwm+n7Ku1MvjlPXQPBQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJwHhkjndhwwO4R9mAn4FNMo4+wYfhcZh9Yp1hLZu+I=;
 b=n6aHPUnYEyqqZABD4dPksQWrFKCOViKJPUIo6Yc2bYXychFMOUoMwOgrFhUJijHAxF9Kyqwjrm0h7TakMi73MBiAC4anAr4pee61j7/bVmMMj02DBhhKUf2eBAZEQxKL3ixlbfVhcbZKwC69fb8/NK/RevVmUxlEWZ9ljQRt2Ii4le2ilP46hVcy+FwEX5YlMYHS3nqO0M7damHerObto38yCjUfdAfFCUaO72m+csdpHXHm+ORN/qtJKkqYhcl8rOQC8HdlY+v7JDQgesYRgGzL89wAaKLzUK/HKUEpk7Qj91/4EuDnCx509FpscuTO0Vh1WeJk7JTJ3k5qmN1oAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 22:10:32 +0000
Received: from DM6PR12MB3819.namprd12.prod.outlook.com
 ([fe80::a89f:aaf4:f337:96bc]) by DM6PR12MB3819.namprd12.prod.outlook.com
 ([fe80::a89f:aaf4:f337:96bc%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 22:10:32 +0000
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
Date:   Wed, 23 Mar 2022 18:10:30 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <87E48455-3FDD-47FC-A953-CBAB52FD3889@nvidia.com>
In-Reply-To: <ed175cd4-1411-459e-e892-7d889e1253c0@huawei.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-4-zi.yan@sent.com>
 <165ec1a8-2b35-f6fb-82d3-b94613dd437a@huawei.com>
 <D03D6945-8BFE-4137-BDB6-BD884656B65B@nvidia.com>
 <ed175cd4-1411-459e-e892-7d889e1253c0@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DC4B50B5-6DCA-4CAA-8B60-62A7AC8DC6E9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:208:15e::17) To DM6PR12MB3819.namprd12.prod.outlook.com
 (2603:10b6:5:1c6::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f91b47a-4108-4db1-8691-08da0d19f2bb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756C6CE327609D0C43F8C4FC2189@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zb5RUGkRgudljC4HYrNsCtkw0V52YZ6GpHhe5AYp/zhVSRBESdmcZOJxkPhCVpKVqXbF9G9+o55EvUN+/17iytvgofBzuvC2smawxAPAHWFmr4MaK5kcPVymA5D+EzNvsAdVu1eD11BrV1E+HfAvgzDRmCJ+foOLxHO80YPBo7J0TV1Em3wfdsfKHCPlGTzytnLikBO0nktL4QjWYH251yDY6ujJfM+WmPsS3dLHHeq1hUjp0jzc83cb3HGkEMEzZTYHYkIqpPw+qTO+NSPuaUyfjKLvJEqBlIzNXVDfhVSh+GvGdvzj1Q7n1Z8YNjlLlYE27VxCUgt5i2Qy4suEoqB/Coz+pDldUIdPOrnLodF6+elz+QzilDjTHnV2N9SReanASXVN0boE7jQSKF0MOrKLBcSEmnw57K5MpGt0l7SdoHSclMtWyTRo3DKQI0DrFHOv/x8Xc+72XujjQGyMd/LFA6jq/NDfDscx2PYvSIMC1Fk069H2HwllqebugMEL7pLgqS4jrhAKNSCbm9Fcasr2bPtWAFtI6FdEZx9TeDIj10wJUj9kJSOUDirf2fjMaN9fNhWNBGkSk51w7C0NMXGFAD5t4H9PX3fEJWMqN2TXIeIy7k05JlFu5oNoaT7lVulRZe0C34fPx+/CHFBXs5nZQTOO/zGh7xOwQqlAyDVkQT1P0LstAobf4eqF32MAiFBCCz+1sYLOt7yM6XkpkpDDq4tBUV0jhSPlE9QHopuuc7YP3fX7DQAlkUg2pDY9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3819.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(26005)(186003)(36756003)(38100700002)(83380400001)(6506007)(6486002)(53546011)(33964004)(86362001)(235185007)(6512007)(66946007)(2906002)(8676002)(66476007)(66556008)(7416002)(4326008)(21480400003)(8936002)(5660300002)(316002)(54906003)(6916009)(33656002)(2616005)(14583001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enc4ajlVWEREd01lZzZrUnpHNWs4MFk1SDhhVFZqVDVlVGNRMmhibzRoZ0hj?=
 =?utf-8?B?OE0yQ09wSDVJZWF0S0VVMCt0QUt2MUl0UmJLcDNBOTh0dlZxQkcyNkxiN1hq?=
 =?utf-8?B?dVdZRCtCSFRDamNCSEdnOUhSK29pajYxdy9FSXhTS0JwZXVIUlJ6aWduNUxB?=
 =?utf-8?B?cUZLZUZBZTNVNWlmSUd4RUJDek1XeWpTbnU0N0dTaHg2aCttejAwQjduNGUx?=
 =?utf-8?B?ZXE4NDBSZDRqeU1XYk1Iblh6OXBURkY2VlhKd1dZTU01bEZIOGFjOEVISFBP?=
 =?utf-8?B?K1lrNC9UMmg1Nms3Y2R4V3h5ZlJHcHNqeEEwTmdrd3lCeENyYUtwbzgyak5T?=
 =?utf-8?B?L0o5SmN1elpkMXJ6dklESmFxVnlTLzBRTDVKaERwZEtveXZHQW5MZHZIaXZz?=
 =?utf-8?B?MjJ1M1JLcFl3QmNsdFJXTFZnRjQxb0d0b2lTVUVWVWlzUFovYStyM1lZWGhQ?=
 =?utf-8?B?dUJJeCswQnhlSTUxMlZTQ1FtdjY0QUFncy8zWk1Cc2Nkd2dJSmNRNEI2NGt3?=
 =?utf-8?B?YzNlb05wdC9rRVEyN1QyMUt6a3B3OTJLQnprdmpMWENFNW5pcm5HcWVFOURP?=
 =?utf-8?B?RVdSNjU0T3dhbTRmZGJ6dldnY0FwTXROYVMrbnFGWStTa0Vxa2gvKzRtVVRl?=
 =?utf-8?B?VzlzR2hRRVJieVA4MVFjL21UMmNoc0srWm9Wbm5iOVI1RGVPSHdzalBocmxv?=
 =?utf-8?B?RTkxeUp0R2FQRXF4enhreFBqMTNzVmFCalhWMzN6WitWTkZCMTZ1TmdCRzM1?=
 =?utf-8?B?OFFERFhJdVpzS3J1U1lYY2prZGl6KzExUmtWbnRxRUFTekorcFR1dkdBTTM3?=
 =?utf-8?B?Y3hRK0FreVFEaUlLTHJmT0Nla3U3M05hZUw3NEh3Wm5XUnhmVDRjK0gxNzZo?=
 =?utf-8?B?TXlrd0YrSThTN2xQaUppZnN4TkU5TEVuWUEwSHZJam84aWJ1TGRDZk16L0No?=
 =?utf-8?B?c0NSN1Y1WVVkVFJUSFkrVUhaVjd1M2VZcWtWTXE3V1JqNWtLNTVZS1EvRmND?=
 =?utf-8?B?Znk2WmVIZGo1U2FOOERqc0hRT0pGRzdpT0RvWFZhcDRTZ0xEK2JlSHpMeVNE?=
 =?utf-8?B?ektOQjkzRjdaenBEYUxZaExyRUkwMWd3ZDkzWWxsZ3BuS3Z6eU5zcThpUDNt?=
 =?utf-8?B?dTZkYWNHZEJPSWtweElWNE1mV3UwTktCSGh6TkNvMFduM3pOdnE3eDJ1VmQz?=
 =?utf-8?B?T1J4a0RjSWNhYk9BVUUvMTVxUjF2bmNDdURHMGhrc3ErcWtIS3hCOWg1Wmhz?=
 =?utf-8?B?YUcveFdrcDV3bVdpZjF6N2kxTUpFcFRZaWJsWitLaEhuU2d2Sk80cGpPbEJV?=
 =?utf-8?B?bGpkVjg1S3JqWm50SkZ3bDd3ZzVwWlhKTWpOMngrUFdicUxFbmtxNXVIOTZR?=
 =?utf-8?B?VU9yenZxbTVpN05tZFd2NTRZR3U2NDdsblY4N3VkdVpCQ2srZExmQkppN3p1?=
 =?utf-8?B?OVNhakI3ZlhEbElkUHJuSzZmNXlNMGV6TlVkVVFhYitQWlRELy9VWVNjWVVD?=
 =?utf-8?B?dW9zeE1KQjZ6UE5VWWcxUStkOHRwWEovVHRzcytZTFNPcUxhMjlHSDFreDNP?=
 =?utf-8?B?M0JvSXpVcHY5ZzRVSWsrMEFXNGRleWllSEQvdXFscU9IeWUyK3hIRUMwd21h?=
 =?utf-8?B?UFJIVzE0YW1nUzZXa2daaTRYdksrZERxeEZxMndIaC81cVE1SHl1QWpsRHc4?=
 =?utf-8?B?ZGsrZVROT3dHNkZNanVTWVM2Sk1sWEVoS2tGNHFuUXJQeC9lUXFSNlVtbDZy?=
 =?utf-8?B?OXV6cy9YbndNeXFMR2cyTTJYa2E1dkJtbmRqeXpBelRRYnFucVUvYWdHbjFP?=
 =?utf-8?B?K2Z1cWkwOElGRnZ6WG8vVW40RUI4V293OFl0S05abmVOZ3k2OGE1OXZORkV0?=
 =?utf-8?B?akNpV2dDRmVBWTdDbTRpQ21reEFQbGhkemRiMjhrdWhvTmdBeGphNkVBT2hh?=
 =?utf-8?Q?bLvcTf4uxJqVZQxhcBEc3fqcZ4/bNnWE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f91b47a-4108-4db1-8691-08da0d19f2bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3819.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 22:10:32.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP4lP/eByYHbi4LPtiCoDiD7a0snJ/22vHaQeYrgLeAhmWlMQ+UpjNBO8LqpPQpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_DC4B50B5-6DCA-4CAA-8B60-62A7AC8DC6E9_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22 Mar 2022, at 22:31, Miaohe Lin wrote:

> On 2022/3/22 22:30, Zi Yan wrote:
>> On 21 Mar 2022, at 23:21, Miaohe Lin wrote:
>>
>>> On 2022/3/21 22:21, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> To split a THP to any lower order pages, we need to reform THPs on
>>>> subpages at given order and add page refcount based on the new page
>>>> order. Also we need to reinitialize page_deferred_list after removin=
g
>>>> the page from the split_queue, otherwise a subsequent split will see=

>>>> list corruption when checking the page_deferred_list again.
>>>>
>>>> It has many uses, like minimizing the number of pages after
>>>> truncating a pagecache THP. For anonymous THPs, we can only split th=
em
>>>> to order-0 like before until we add support for any size anonymous T=
HPs.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  include/linux/huge_mm.h |   8 +++
>>>>  mm/huge_memory.c        | 111 ++++++++++++++++++++++++++++++-------=
---
>>>>  2 files changed, 91 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 2999190adc22..c7153cd7e9e4 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -186,6 +186,8 @@ void free_transhuge_page(struct page *page);
>>>>
>>>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>>>>  int split_huge_page_to_list(struct page *page, struct list_head *li=
st);
>>>> +int split_huge_page_to_list_to_order(struct page *page, struct list=
_head *list,
>>>> +		unsigned int new_order);
>>>>  static inline int split_huge_page(struct page *page)
>>>>  {
>>>>  	return split_huge_page_to_list(page, NULL);
>>>> @@ -355,6 +357,12 @@ split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
>>>>  {
>>>>  	return 0;
>>>>  }
>>>> +static inline int
>>>> +split_huge_page_to_list_to_order(struct page *page, struct list_hea=
d *list,
>>>> +		unsigned int new_order)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>>  static inline int split_huge_page(struct page *page)
>>>>  {
>>>>  	return 0;
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index fcfa46af6c4c..3617aa3ad0b1 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2236,11 +2236,13 @@ void vma_adjust_trans_huge(struct vm_area_st=
ruct *vma,
>>>>  static void unmap_page(struct page *page)
>>>>  {
>>>>  	struct folio *folio =3D page_folio(page);
>>>> -	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD =
|
>>>> -		TTU_SYNC;
>>>> +	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SYNC;
>>>>
>>>>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>>>>
>>>> +	if (folio_order(folio) >=3D HPAGE_PMD_ORDER)
>>>> +		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
>>>> +
>>>>  	/*
>>>>  	 * Anon pages need migration entries to preserve them, but file
>>>>  	 * pages can simply be left unmapped, then faulted back on demand.=

>>>> @@ -2254,9 +2256,9 @@ static void unmap_page(struct page *page)
>>>>  	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>>>>  }
>>>>
>>>> -static void remap_page(struct folio *folio, unsigned long nr)
>>>> +static void remap_page(struct folio *folio, unsigned short nr)
>>>>  {
>>>> -	int i =3D 0;
>>>> +	unsigned int i;
>>>>
>>>>  	/* If unmap_page() uses try_to_migrate() on file, remove this chec=
k */
>>>>  	if (!folio_test_anon(folio))
>>>> @@ -2274,7 +2276,6 @@ static void lru_add_page_tail(struct page *hea=
d, struct page *tail,
>>>>  		struct lruvec *lruvec, struct list_head *list)
>>>>  {
>>>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>>>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>>>  	lockdep_assert_held(&lruvec->lru_lock);
>>>>
>>>> @@ -2295,9 +2296,10 @@ static void lru_add_page_tail(struct page *he=
ad, struct page *tail,
>>>>  }
>>>>
>>>>  static void __split_huge_page_tail(struct page *head, int tail,
>>>> -		struct lruvec *lruvec, struct list_head *list)
>>>> +		struct lruvec *lruvec, struct list_head *list, unsigned int new_o=
rder)
>>>>  {
>>>>  	struct page *page_tail =3D head + tail;
>>>> +	unsigned long compound_head_flag =3D new_order ? (1L << PG_head) :=
 0;
>>>>
>>>>  	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_ta=
il);
>>>>
>>>> @@ -2321,6 +2323,7 @@ static void __split_huge_page_tail(struct page=
 *head, int tail,
>>>>  #ifdef CONFIG_64BIT
>>>>  			 (1L << PG_arch_2) |
>>>>  #endif
>>>> +			 compound_head_flag |
>>>>  			 (1L << PG_dirty)));
>>>>
>>>>  	/* ->mapping in first tail page is compound_mapcount */
>>>> @@ -2329,7 +2332,10 @@ static void __split_huge_page_tail(struct pag=
e *head, int tail,
>>>>  	page_tail->mapping =3D head->mapping;
>>>>  	page_tail->index =3D head->index + tail;
>>>>
>>>> -	/* Page flags must be visible before we make the page non-compound=
=2E */
>>>> +	/*
>>>> +	 * Page flags must be visible before we make the page non-compound=
 or
>>>> +	 * a compound page in new_order.
>>>> +	 */
>>>>  	smp_wmb();
>>>>
>>>>  	/*
>>>> @@ -2339,10 +2345,15 @@ static void __split_huge_page_tail(struct pa=
ge *head, int tail,
>>>>  	 * which needs correct compound_head().
>>>>  	 */
>>>>  	clear_compound_head(page_tail);
>>>> +	if (new_order) {
>>>> +		prep_compound_page(page_tail, new_order);
>>>> +		prep_transhuge_page(page_tail);
>>>> +	}
>>>
>>> Many thanks for your series. It looks really good. One question:
>>> IIUC, It seems there has assumption that LRU compound_pages should
>>> be PageTransHuge. So PageTransHuge just checks PageHead:
>>>
>>> static inline int PageTransHuge(struct page *page)
>>> {
>>> 	VM_BUG_ON_PAGE(PageTail(page), page);
>>> 	return PageHead(page);
>>> }
>>>
>>> So LRU pages with any order( > 0) will might be wrongly treated as TH=
P which
>>> has order =3D HPAGE_PMD_ORDER. We should ensure thp_nr_pages is used =
instead of
>>> hard coded HPAGE_PMD_ORDER.
>>>
>>> Looks at the below code snippet:
>>> mm/mempolicy.c:
>>> static struct page *new_page(struct page *page, unsigned long start)
>>> {
>>> ...
>>> 	} else if (PageTransHuge(page)) {
>>> 		struct page *thp;
>>>
>>> 		thp =3D alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
>>> 					 HPAGE_PMD_ORDER);
>>> 					 ^^^^^^^^^^^^^^^^
>>> 		if (!thp)
>>> 			return NULL;
>>> 		prep_transhuge_page(thp);
>>> 		return thp;
>>> 	}
>>> ...
>>> }
>>>
>>> HPAGE_PMD_ORDER is used instead of thp_nr_pages. So the lower order p=
ages might be
>>> used as if its order is HPAGE_PMD_ORDER. All of such usage might need=
 to be fixed.
>>> Or am I miss something ?
>>>
>>> Thanks again for your work. :)
>>
>> THP will still only have HPAGE_PMD_ORDER and will not be split into an=
y order
>> other than 0. This series only allows to split huge page cache folio (=
added by Matthew)
>> into any lower order. I have an explicit VM_BUG_ON() to ensure new_ord=
er
>> is only 0 when non page cache page is the input. Since there is still =
non-trivial
>> amount of work to add any order THP support in the kernel. IIRC, Yu Zh=
ao (cc=E2=80=99d) was
>> planning to work on that.
>>
>
> Many thanks for clarifying. I'm sorry but I haven't followed Matthew's =
patches. I am
> wondering could huge page cache folio be treated as THP ? If so, how to=
 ensure the
> correctness of huge page cache ?

You are right. All these HPAGE_PMD_ORDRE locations should be replaced by =
thp_nr_pages().
I will look into it.

Thanks a lot.

--
Best Regards,
Yan, Zi

--=_MailMate_DC4B50B5-6DCA-4CAA-8B60-62A7AC8DC6E9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI7mtYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUI5gP/Rvk/hHI+7xsU6xD2usmKWf/LlfFO5xSlLhe
57lN7MXq+sT4chNs2cTVdpb/ew9Oj/sUVQ8nj2mNlYMardQcRHNQOPVwOmqYbnKs
wyzSqbv9t5OtPoGmRhS3YSmq9b4PcBcF2NCB99dWQz8m7ksBaUO8hnKXGOql7Q3T
QqemZNWe14k4qKIdolNuQT/XwQEGL5Bo2eb/KNgkvIii+tB907gj7melrxWOvqdo
iovfDegRS0+Cd93+Q27OUP/tAzJftINtOnfbN5+ltZekRrWyEhLH+uBc9b4k8Ac/
f2xPd4sfoiqXOfSTp8ejzfFznxOQCjo9+w8Dc/OwsgB8a7ZrlRRmCA7q4FChQHdX
0tgXjoPwxQbpNQrqcMIhKPZvIp4dKpTllk9Oq9VyLpE/RRsOUJ1YvZGAz/MC+LR0
1Y6lSeb/Fed91WDkpBvoSf7UVXg7FnxRzHsbcepsroouPLcXYoz0LC2AvY9DvrVl
n5TPO0JZLCjK13SUoDgxMVQEt1HkRZCdz+b/32YCLcJhkki9bZGm9sem69ehLfvk
dte+ix1LJOdqrucntX1IE45V/W4ZRRQqNxo6jfLSJ+xK92B78EX9W6+wMvKMZQLy
PizwyZDGYa7bH5T/br62X6uojT1z/tmu5Ldez8S9TnTrrkrmIoN0M5+gtw9aE5MK
JoLtHZM2
=gBi+
-----END PGP SIGNATURE-----

--=_MailMate_DC4B50B5-6DCA-4CAA-8B60-62A7AC8DC6E9_=--
