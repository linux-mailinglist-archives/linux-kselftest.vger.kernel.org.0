Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465B4E31BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351870AbiCUU21 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 16:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiCUU20 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 16:28:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406F165BB8;
        Mon, 21 Mar 2022 13:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZbO0KdhBiORkhiif0BsALcp9sgyuD+KeZa9N38C1tR1Ot7cZcDsR9dC/UcNM5hq3DayL2RTi5W9AIqrZfLkXtDlxenGJQtggQxdKiGS2vFd4VfvzwMmWXk+8jaaSRFi3j5KHqnNEI5Sr/kCGKHa04pktENxuU252WRJPne4GuuCUZfKsCal7Flg+UoGXvHAcx2j3C3tGMQlD0/1wn55yfT6bEQ83IoscRAmpaflVxCvJkuugL5s8n5rYvZno7bDgpdVj0/x7Ptf+5Uq9E60SOTzSXvN1bCecrCPvzNPxMUMQBQhtaYntNb6lKWWJjRSeMci5Ke0PcHL/dvc1IuWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFbAVOgB5L3qOPG9VdCAPxzY821z39LgMQbDCE9M8Vo=;
 b=OUg0iO/X+cTz1etgFk3FkL284IZp2MmSPIrokeTItQXghEWV08gI9zYUMqUuwsvrH4afx/2NXonAzhn/TlgpE1y2xzSJ8S522QJy+f3nt48Idj6d3zsSZ87s79i/79AoCIBkCkqIwzEgPGWa0DLeLsjZzQJBmZCcuq5pUXYRAvG8s749twKmvqnev4MlZGAefOAyGCMAWCmbKcuE+sbUZB3KKdxG0FbnlTQp//7DiZvEGpU8ZeWlagZvTD0qnwu8CG6DjILuhJ11+dvQiD4D6WNtWpCpgoIDR/iHWpoCPQf5Gk5d/AaIu5ThmELIpJPEdW9zU+uDD0jvYSrIfgZgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFbAVOgB5L3qOPG9VdCAPxzY821z39LgMQbDCE9M8Vo=;
 b=O6BRFysnBo22kJOzG33391zJ3P1+7YUzmBUm9pGfnxJ3h+B9z6RFZnCumP+C/LhgfIiHcrVtbV/g6MDeT1+QxLar/5P7r2yeIM/zi03WlTqlaTt+SZ1gLHfeOPVlIVGiCu+APv31PUyN3bmoX2vyXjWOdQkvw7rGcBRGQuS6t05ziwk5mP8ROLChnXjwAv0ivBx7seP6w3DZjEvvJpj6BbZvQrWFZbu+P2XNlzSAGuXGrziMLP+B4fC3YG2TpR7I6pkNKkFwE7Ez3tUug0wprFUlFOvCp7MGsKosZ9MRXVKTt92qXBpJfvr7MlNV1JycStcHoOv0YXMb9rmUarfuNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MWHPR12MB1504.namprd12.prod.outlook.com (2603:10b6:301:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 20:26:57 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 20:26:57 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm: memcg: make memcg huge page split support any order split.
Date:   Mon, 21 Mar 2022 16:26:55 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <2FBD6D12-EDBE-4061-8738-E5E333F2367C@nvidia.com>
In-Reply-To: <YjjX/bZrUmQfFjHC@casper.infradead.org>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-2-zi.yan@sent.com>
 <YjjKh2NoWGcq28Oo@carbon.dhcp.thefacebook.com>
 <0001CABA-9436-4EFF-9C7F-F67300D09DA1@nvidia.com>
 <YjjX/bZrUmQfFjHC@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_2F541385-50E7-4360-9312-72AE9C63E581_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5b324fe-a083-41ef-4a46-08da0b79256d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1504:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1504BEB793E325E97F490560C2169@MWHPR12MB1504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdGMmIWHqJ6ypqNeOOMf8yIJYGLTe5M0tHoPXicXWhe/cBYDAHjc5IpTTmnkvWT6Iym9kT8oaWEt8O2jB2vDnHEsdF4OTVDaxqNDTh/LTkIKpYnXcu+Cff4JWzlPnOCQv3kQNKSF8L/4jaaw/JV7+wiT0zxRqncVfacAA7JzDmgcwuVu3gRhY/YenYt1OBUH6spkXm+ZFQHmw6PBJ0MH+xjpZhswD5SXXGsFjbPEtbCGr7o0S2WBzu7WdFdjyI9nZbwBulLkW9j1HupOT330ArswawzlcMzu+Wy0gSDZUK4/sczDlzLyITIyBta0UOa3lcBX3jWz1ipZrQVZDiLcHRH/0GtM4vxthuqSYrFZZwdryyGG+QkNQ5MuIsvteUcPcGmUFXpInookKqy10A3ZnhHzGgVgWKpdxCjAZj2RN9tsH1NvD71MrTcB4salIzQsEwBwQ1vXvqgxxs22njzOFvF2MP0ozokIxnIWIsVMMAi/VLSMC70C0NYRDOSijpt+TI/k80n+v6Em2Lc74/TTB0mOjsqV1rtCv0F2VAoi7G6Ui86nZAwi4fmaRHhjDoasyC6RidIFOlEkLIhsmTIvlwPn9wc/y/Qeg61FAKmbISxznkqtSnTQIBPU4z08xhxsHBi6DGuOcmvfMBchF5x6si2+Wvie81hCHWqaaT1ZQUD7h4IKnKomjU/VqqWbwZQczHM+eRzja/xGitqSGNZgqv18i4yXmcOqiVw/blKUgkLs/36Y5fz16cBEVjmKBw2d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(53546011)(6512007)(8936002)(21480400003)(7416002)(86362001)(235185007)(2616005)(33656002)(316002)(36756003)(26005)(186003)(66556008)(6916009)(4326008)(2906002)(54906003)(66946007)(66476007)(8676002)(38100700002)(5660300002)(6506007)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+fCjQHpwU1zqSFJVuuguqPGXfn+HT2uT1FiR5ndIECRSFrWBCBRZX6cv1iK3?=
 =?us-ascii?Q?FxXspqlIY6swy1K0cDYuHfh84DLp0KnT8jKePKMdwNAorOMBsYM/DOFtwy/r?=
 =?us-ascii?Q?YzzhcMEMwSbvf8nLhjtfe6PiyaTFLysyY4/LUKFLeJpCZBF//L6hCD7oIcqu?=
 =?us-ascii?Q?g3GdXwTG6Wt6IuwZwVJUDZ6fo2Why360GQ1jIt0wtlxScw9fQ/UNBoE1ALCc?=
 =?us-ascii?Q?QA4KRSnTHy1w/wtyf4LmMxAeXNtRi87quPguXRVHYoSJtGuYsHtynbIL7OUt?=
 =?us-ascii?Q?FkUatbYvuhLCW3dumqFWYwV2VmJxajhbllQRYE3Y7KqcVJswFpKNMcZR2HGv?=
 =?us-ascii?Q?Q5TYaT9PEXrdKkyOMxHxLdBeSnHGqWqc6BTZ84dk+gi86pw+4FRl0Ohf+wu6?=
 =?us-ascii?Q?k0gM1sTfU1KahdfgZrL26SP2Jc5vZmxfTA9WALwCkPJKrLyhgG2IU68sIwZV?=
 =?us-ascii?Q?mrEM0VVMxdjWd+Glo1bs9TLgjZ8K+f71/xbx/L8HF9GUD6k87dtfRaO/dFCK?=
 =?us-ascii?Q?mRWIazgKCvC4hEx9NJbX5eRKep9tJA2UV76ptZlod2Q9m6N3LCWwb25j6HaG?=
 =?us-ascii?Q?UgGeL2NsPIMxahDZMfdj91DRwYzLR82IxEOngDrZupOxHKOz3YkgEOr/FBav?=
 =?us-ascii?Q?o8Z4jcvqGZqwoaA8PuE88YR+CLQlE7U5Ml9S8JAnyBL3KEMHCwMoW1SVPjhd?=
 =?us-ascii?Q?d+YYJEjuk0BMuHTAgeOwuP8S+747FVIs2LZmu1EKUUJiTmTOfLbipXa4QqtA?=
 =?us-ascii?Q?HwVwuLT8WbxEL1cN/XuLTeAGSfLcoX5wSXK5DVx9VDoqymKhZEjUJM2tJP1q?=
 =?us-ascii?Q?AZk+CEQRq63F7zJIAZUY9elc+1vvmd1kHXR2cSZcQBa0wvUf64811qRubCun?=
 =?us-ascii?Q?JLyTdi7H1qfoIaRK78dEocGUCnLJVy5si+dg5FdmO7pxJuX+uHFmT1uLnU+s?=
 =?us-ascii?Q?sR5rKNFV2MAjyLwpwHFawhxy9P0Tr+Q18iuBH5sNVbA+bvQ9nM3BxB9wMUKd?=
 =?us-ascii?Q?U/vFtJucZD05BGHBzxfXwwHRYZX7dlULIWK8in8x2NAOIhEloZbfHMOueofZ?=
 =?us-ascii?Q?/7bkE2ovng0Odgjl2tAqjWTGeygItvvr9amrNwpHRa8bNDrfEBqbJ6nG7b+B?=
 =?us-ascii?Q?RMQY2Kdd+IwfiuM9KNuxTTI4L3oUoSxY1wn5dMTMkjrSvL8lUpPr3qYVy1vD?=
 =?us-ascii?Q?NWRnhUp+6gULQjyf7QbnvqUPN0o6ODtAk22zq+zcjxmdEwZ6N/QcyhHLF1rn?=
 =?us-ascii?Q?YvjVs7jU6a4C3j5K9iBT/FAxoxOtiTH8OmPXcXfxreOsbnd1xpOqFffPF9xY?=
 =?us-ascii?Q?bpMTF9RR29DAqQjxHsv4FF1vHOxaYNA8ORMskUqPGs8RIT7d3OewduAfCgz+?=
 =?us-ascii?Q?p/2w6bXmE3x+IF7hTyJ22cpPoJqPVrqIPZj93HKJ1iwEmseDPZ5vE/DULYhY?=
 =?us-ascii?Q?xHU5ER0PKP4Fsh4F6+PCOin2zTAPjI4F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b324fe-a083-41ef-4a46-08da0b79256d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 20:26:57.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH8FX1ft2ApTKrL5nOforLoqtvKeWFR0L238w1AQIy4Ptkyf2DWVsB+8fzol5RDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1504
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_2F541385-50E7-4360-9312-72AE9C63E581_=
Content-Type: text/plain

On 21 Mar 2022, at 15:54, Matthew Wilcox wrote:

> On Mon, Mar 21, 2022 at 03:07:46PM -0400, Zi Yan wrote:
>> Yes. Will change it to new_nr to be consistent.
>
> uh, you're going to call ilog2?

fortunately, no. Inside split_page_memcg(), I probably
need to add VM_BUG_ON(nr % new_nr != 0) to make sure
new_nr is a divisor of nr, since there are a couple
of nr / new_nr operations. Otherwise, new_nr works.

>
> I think this would look less inconsistent if 'nr' were an unsigned long
> (how long until we need 16GB pages?  Think PPC already supports those)


--
Best Regards,
Yan, Zi

--=_MailMate_2F541385-50E7-4360-9312-72AE9C63E581_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI435APHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUJIAP/0CzSz8P2XRJkZdEbGhs9vL53wFcpYK/PFGx
uT4zo+m6uD/rpMvXfGAvp9rebHsSbru2PFo4BIuPuaiuuuqFv7ESdHHDv9x5Y7jc
dV44hJjFEh+sTMJPORbdwk28U974xQYab4Ay1dAn5eemWg7GpQm3GOsa9aa6TT0J
Bg/OLxsswJoKkVAPLEzRo9r9JpVh09Jgmic0kAHTLTsbckKxvKu+H0CUzXxcZm5T
46j2jpInUExeLDwrROzxSQ9OFrE3RliH5ojmKHWjxikWVRyEmA8YEu2+PAz8fy8s
3/FlI9lFFbe+j9iSeSe46l/A/guyK6HTORXDmy9pf2DXByYbOgIS5f5jT1K7QVNl
PzJrn/VZ9PPcVHHFKL1rinRo4TuAiyr1q0qeUiOGdAyvcmIyX75V01PIxSqNbKuL
qEYGaNsr84ekpbACtY0VpRGVlIbQfZnFb/e8FEko9dFYL8oMLyaoWDHj7eFWN4RU
xk+zU9szLijVJaJw9jOpawZ0pPlNv68NzMIpcNSRXDZnajxBfslmnrDA5JwM+QqU
mS1mUepZUb2Br3Sk2t7wH/K2cvmnHLQDThcHpPv+cDR+kKEV7L9XxOh8LNDZBFmD
wP/ri2AdsnDN9SVatmf7hcZU2y13FGKiS73584xn6sgl4QXeK0m6en3RfVjnj4IZ
9bAK/5nO
=1XBK
-----END PGP SIGNATURE-----

--=_MailMate_2F541385-50E7-4360-9312-72AE9C63E581_=--
