Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E144E3078
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 20:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352419AbiCUTJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiCUTJT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 15:09:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0939D14FFC5;
        Mon, 21 Mar 2022 12:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejneMRsQa70Omx9Ge9C+U4Dw2iX/lykXS3JI4Pk5NbmL89QMQ5JDYnsuXWcY2Ln+ozgEtE31Yn1PhKQNfZX2Wjc1gPstHoo482a4eK7HnfgzvM1go6On/w5E5mBoUZB4nNfsAQeOGw+uNZ90hReQtvoVbTgGTZxuQvvgdiL3T8+s1FDPyXXfKyh+HrmRBC78OCoTsrxxDmKYP724F80IDazODRawEGgoXW3z2Dl+UhYAel2LnjsNSkBpR0+XndZ9e9fGu7Up/KMhJUa1El9psmMHZ4gEqHqrAJkwyhm1Hbvpkiqik5NZ+hpUsJYi+MiqZAW4gJWSh5i29mOMKo09Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqYm47FTMvdUJOGgTLvLdKPG203KLE0rRfgG2+8JwD4=;
 b=eQURDZv4y1O94dDIzp/eg53H3TuIUS2QZRgqfMtOC56G9WdX56VoNr+XyWd4JwSlwbFRnZg95ara+76tdepYTFaDTr8w54s2ZWFBlnh1b2tlEoY3uNM8qIiFdYdHS+PlwgA6FGwkPpj11yFzAdCw9rdLr7jCWeoyJC85yrHcFIHU8hL+teXN6FOzF4jn4f9UBEo8iA/e7pQltEeKwv2SCcOoSKf8BNp6vMyu5CoPP7X+cFbX+i4lmmlAo6GLRdxH8ZrRb9kyoWD5ut6H3PoyBP7TGPCPOhOmwSP/Hdk7g0BzkUqiuW0LqciQlc4Ty6V6M5nZ79XyeFWdUJVC/poS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqYm47FTMvdUJOGgTLvLdKPG203KLE0rRfgG2+8JwD4=;
 b=lB6olLTB7TH6WAeiKVlQG8ZK1lk6O4MX+oeu3dDfyYbRmF71AMOMD/wuddXcuer1IEfCZQZ/0ZNG1m3dQCE9aDUm3PLXFFSwpDWz6XifC7VkQadKtNWnVDoMmX8E+2Nt2K44xKXBm3F1HcRovNaGC+TcsX1L5X29XgSVFwY+FJ0zOgQa8cbc+n458sGFKS5kiq3sHCl9mIkcteEHjF4IHQbgDjYBvJWcJjkn/6VnyEX1MCFc49CfTQpJIymqZ31HyzJKAbAnyTS2ytO010i0JlY7S3ZCJTFFUNDFeao+2A4Ec5VU+ewwHNaSWsubFRtzP8xQer1I6kmYy3NPHAaG8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BYAPR12MB3446.namprd12.prod.outlook.com (2603:10b6:a03:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 19:07:48 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 19:07:48 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm: memcg: make memcg huge page split support any order split.
Date:   Mon, 21 Mar 2022 15:07:46 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <0001CABA-9436-4EFF-9C7F-F67300D09DA1@nvidia.com>
In-Reply-To: <YjjKh2NoWGcq28Oo@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-2-zi.yan@sent.com>
 <YjjKh2NoWGcq28Oo@carbon.dhcp.thefacebook.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_AEE2331C-DCD6-4190-BAE6-F7868D2E6554_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:208:23c::8) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fe7e86-b41e-43cf-ae87-08da0b6e16cd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3446:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3446DFE09D73C76C7FE4F014C2169@BYAPR12MB3446.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: en0iuCg+7Iga7SMGESS70AkSzfsLzOgK2Ih/ctMdS7PywYU7qw+eYw/GfTWzA2tCeP/taJN+iFhYdLpH2sJCSPzV+xkZ1I7/uYaYFuMKXmvtFUECM1VWjPnz4xbcSFFgZV0ZULtBU1UPl2BWj+iPWjy7MYOHU/jZ78RdUH6gOGRGRnjJin3LK5VASDVqT15tZpM1t1i1MIhiqfhaswTj+Q68USM+qi4iDPpNsXbXZnnCoOMWYkUaVPKVGdpxcFMtYF9k1j/hsGDbP+YpNFab2QYUZpfDXHCu00d3SGcuCtjOcWBpgSRAIrdDoI91fg18Ww18Pd6NbBuM1BVVi5agYZR9OtiXHkTSkxQP1Kx8Q+H+fcnF8CTi8+d/5DfOUbb6ZY3/yytXroNoCjUkzXgtnnrWHg3lJID+Qdm4x0aCpN3hbHoTyHr8AwaVZc3wFmNERv49BOoTU/42mqvDw/VMSkV27rVtzTnhFLB9KZs+7/fKF/XUrQNQ2dKcLiyslBBgh7uTeAe6xdAfSEsnPLnYI9kf0RCXKEy0Qt7nqCBlJeOKcnmCNQ6D6uxOXUq7nLX9SuALs6iByQEJAcFqAyRQnQ6GPElwywfL4ftE1iyvj8V6Yv0rcIMgNnK4mP2ed/Q8fOATWOGdccbGHwjshyzLAwTruvrRPftaW6q1o07X6L+racP2hS/+63QVPOml9zyWkuq+NQGYIHOt7Lhm+V5v8V8MKsKpc0vpywF66ALIMwEd+Hf+dAUlYGg//16qHTUK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(54906003)(508600001)(6486002)(38100700002)(6916009)(316002)(2616005)(21480400003)(186003)(36756003)(53546011)(6506007)(83380400001)(6512007)(8936002)(7416002)(5660300002)(235185007)(66476007)(66556008)(8676002)(66946007)(2906002)(4326008)(26005)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xTMCyyLm+rUA6fcAYJY/vMDsHX153LFdFazK7pl08Hie35hLb2ZsBdKd3qW5?=
 =?us-ascii?Q?0TES4WIHas3fi314Mtpo/G0JQfz3CbxLLeOiWVB9UdyO2WXZozFi/h5jA6h/?=
 =?us-ascii?Q?7GiM1zP9pQKQ8z4EWf3rerxnaUsQD7ZK99Iv6ZWF4fjf13ogI44LQhuN+2wv?=
 =?us-ascii?Q?7BYp+kSjdlLsody4sPjg5W3SbQv9AcTy+9BlSx6mCg2nb/SePPRLYfZtAQnu?=
 =?us-ascii?Q?7jqGu+WSCB3S6q9xjTj4/IgAWmfUi7frKiJXQagQuzcF+zuEUIMsYhEQ1SpU?=
 =?us-ascii?Q?E4Keytym3vVYmKYb1mgWOgfXLh3sNZXU2sxaSYvwRVelCQVsHznr3SaR9HOu?=
 =?us-ascii?Q?bRvQznckUUaqv3a9gI1AVvXmxfqsa+DPAKzwQuEclCbI8lbx6DEqfb/QA2Eu?=
 =?us-ascii?Q?FEABXY+4lbiNyoU323lD/VZukRSNLsd6r5LfDVhKllDkionIZ8egXTMqMb9D?=
 =?us-ascii?Q?FxEBG58B9xCxPdkNhPsOtVVVhRRVCVp0tRQZ5+jU9fzMAh/piS+P66v5ZsFm?=
 =?us-ascii?Q?ri7u8fUYe0EyJqz20tTeSTHK8bODBBelHxkXWfmyXff5ELS55ssQym9FEeam?=
 =?us-ascii?Q?YSLqyEs6ZGD9fyaelCzIUPFr3c8OYtYo4INH8vz99QIm/ewetjKl+TPFtx1Q?=
 =?us-ascii?Q?WaZfW8srZo0MY4ApdpdFm7tUzFmu0Hd9xOyYHHoM9uOlL7GLH5dFYl3fbUME?=
 =?us-ascii?Q?TswW8zMdRmbPi54UYFBjGEC9gnAsozHZCbr8w+S+aSBrhtW3dwQnoj51TvJb?=
 =?us-ascii?Q?F9YDLhpA40Dq1AV6oyMMrAVrULEA65la9BAs+iw6vt6bY4zax4aco3g9Ied6?=
 =?us-ascii?Q?W0bgJPXWFHL1qaHshiHQed9OLr/9vfhNEDtpnbFpn2x+DyjSUSEiXtMqydGw?=
 =?us-ascii?Q?OTTlzh4oUR2o//E0g8Nw0JD7UHU/zzhIVCHKksJ1F8FuXMxLC+8WS1/1GBKb?=
 =?us-ascii?Q?++ONxXBKRPniMH+Jb3EkIM9sJJt+2kAkDDFLjTBz03QDEoPz4Zq2/BsAMxql?=
 =?us-ascii?Q?9O6aqMla0RFaVo5Qm2VtMnzyvoshQ/BHzaAm/LEfZ4k7rQWaVriK41wMpq57?=
 =?us-ascii?Q?9pPqQvDWOrmlPmhOhmoHkYVaDvFAbzI6p0bqbC1JdGgE5vCkJKAET9SICZWe?=
 =?us-ascii?Q?wtSHEUar5SwhWVUyOWp+RcXfylGkItf+Kxqg9IVyrMYl8n60ymj/keFLh+dk?=
 =?us-ascii?Q?F7cpD3PIQibgv2K29nHvv3EMdB9iOlXYFd/yc/nekB9gJ73d7cQ/SjDlxrwX?=
 =?us-ascii?Q?TQ3vwTsLHZ6lVdEAlmdDsqXjM3lWrXZK0ubYFTPg+mEXy2Gjkh6XFeDRRtuh?=
 =?us-ascii?Q?q8Y7CuCDLYJH33BErTAmiC801dbJzzXCkaZ0ldtq0lEXznFpMhmMzimcYQAq?=
 =?us-ascii?Q?bUSwHBjHF4Nqm9afzjEskEwV/rSJINM2BJfHtl8Q1DtTb5qn3vHNBhZQq72K?=
 =?us-ascii?Q?tEvilSIRmPuOM8QRL7nqKObE+ycy5tBS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fe7e86-b41e-43cf-ae87-08da0b6e16cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 19:07:48.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lc8wy+owafzZaa6NVJTfjg05OToCToAdfnsOz7O1Xkn5kbcpCLsxTaDQcGwKEVIn
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

--=_MailMate_AEE2331C-DCD6-4190-BAE6-F7868D2E6554_=
Content-Type: text/plain

On 21 Mar 2022, at 14:57, Roman Gushchin wrote:

> On Mon, Mar 21, 2022 at 10:21:24AM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It sets memcg information for the pages after the split. A new parameter
>> new_order is added to tell the new page order, always 0 for now. It
>> prepares for upcoming changes to support split huge page to any lower
>> order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/memcontrol.h |  2 +-
>>  mm/huge_memory.c           |  2 +-
>>  mm/memcontrol.c            | 10 +++++-----
>>  mm/page_alloc.c            |  2 +-
>>  4 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 89b14729d59f..e71189454bf0 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1116,7 +1116,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>>  	rcu_read_unlock();
>>  }
>>
>> -void split_page_memcg(struct page *head, unsigned int nr);
>> +void split_page_memcg(struct page *head, unsigned int nr, unsigned int new_order);
>
> It looks a bit inconsistent, can't we switch to use either nr or order for both
> arguments? The latter is preferable.

Yes. Will change it to new_nr to be consistent.

>
> Other than that, the patch looks good to me.

Thank you for the review.

--
Best Regards,
Yan, Zi

--=_MailMate_AEE2331C-DCD6-4190-BAE6-F7868D2E6554_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI4zQMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkS0QAIDrivISY918TlGX3vEp34y7xV6GOb3dh6uZ
LKmkxEM3+2csr/6ePHCoFppKk8IA6S7n8vftOo8n6uPABn6t28GhMNpUcwchxZO8
qGM6MAaCblMKVUQHkdf1fBPedYR37EWfLtsgzboTY4/et/e1kLnJb0wghkf8N9mS
L7crR4GLFPWU8nmQrWSSnXJ/dJs8md4oW8RQEQHsYbRUr5XrymC6LhNA63nhXczT
J+cs2oyDt2e6Mir5Lm0jsjnUsBM45Q6ujdx6Zip3zlYarqd90xNAyEPlbmjMo0I7
vZXubNcu4nHzE7H1kGNxDwKeqev4eGevG3cdnje9j7SwbLIgIyeexztON4myhSKe
rVMr9vqs2j6qNvTz9wPiLDPsEugGal3SwcHivclYx/5oHpkUAz9yBTMVIud4PbO+
DMPFtha7uBR2mas3z27OupEXE2sjs+SyRWx+YJLFfNd8HkFTjo3KcZbvF0PmEXeg
3q2J7c4i9DKgAgaVcbtRLxp9gx4jPji6OYSrC3OK1HQ8vOLG/DxuO/7JXJarXY4T
+139lqQNJVZ7wyOlp6HpS2X6EaDrywRsCeawYm4Kg4OX2u66lL4L++q5uOMD62Ft
7UVYWPzi73QiIHa2VyBk7RAdkp+EHvRcJkL4vLi1Iw39qVCWL85JtRw+ik/3HjNz
YxnF4Jhz
=N2uP
-----END PGP SIGNATURE-----

--=_MailMate_AEE2331C-DCD6-4190-BAE6-F7868D2E6554_=--
