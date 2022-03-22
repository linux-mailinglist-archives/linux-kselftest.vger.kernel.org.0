Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261DA4E412E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 15:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiCVO1p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiCVOYv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 10:24:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BAB98F59;
        Tue, 22 Mar 2022 07:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqszyVg4L2jxi3/9Akd8QMlk3wp2afWA+1nFAKerUnVptSdqRlwhmgXKLrtlyT5+JzQVY5gp4D1rvYw9vQ2c6B2WlfiJlrwsaTPPRdVGYhEU3GI5YN7bNHsfgD3gvi/qedkOXCyuIUZ5Kx3PRDqC8CGb2tn5b7ZYewbTqGu3CEnpTQvBMAbVAHPJ+6luE1N3EtSSKjGBe1SrJuIEn0Dk9SfNuCBoi1I2+lnpNCGSiUJ175vU9DE2UQ+xf51B4raCiRcuyVhTWGgSdUBweTENpun/b4CVER/pRu988qoq7og3VJcsDZsl23EEvE5Ju0rsynxp/rhI4TwWiWZq3UxF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru8E4LFHVf+kw8xPFqzeSG8fntHfmGzeug5xEkvbnmc=;
 b=oapFzjROHSFoImDEtcFu1XPxzc2Ua2K9PDw3RltjgvB3Qo8MzLLJZd38r4tfuKxH1Ti+aRIr/VVRu7WLm0NfEJwr6NB74DzEA7LOvwcN+OJoj336g8ZLyvlr1I5u6o7kbpOcHm+mJulZrIgP5fSOlnLfueopgb9ajoiYAAShQBKXoPPDC4cji/EgZo3nDKdVubGlMXJd8CwepXVG3iSt/qE3dVwj0uYkq18eUMWXIMNNfbCPL98NWWhjIRfrbfVbtQNUs1+/CQ5+epGWw1ExEPNKn6R0n76P+oCnNFql0a847LZRm66HVGYS3zuy+V5BX4zscZZD+QsvYqsPWfjKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru8E4LFHVf+kw8xPFqzeSG8fntHfmGzeug5xEkvbnmc=;
 b=Jfji/lc/DbeXQAoCT1tQIB8dOfql/kwL32EMvQ7V3Mnatd1XCGzS4Ga9W8C8oeCCZbyWiM7mg59ysQTmQhwSCTLnQVNLL8FP+fH0yvmWSV0DxJ1UiAtpAPOZEuERtWdBx0swPj1+YmZsQ2yAfD0kxA2wgewc/lRbcvkGDuc1NAd5Lu8ywkxkvJftlA0VBeBAsY26xVsRNKcGsaXt5FvyaVB89XcZqqfqxeqiXQ9tzCqak136i3B453JwzGhvKVJlWgPQkN8cguMJX4OYFpiX5MuoafnOMC6j1PWw1I+S24tWt5M3H9kqXiPhoBuAmkvhkIKItEvcChY+pbsyVKHaCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 14:19:38 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 14:19:38 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] mm: truncate: split huge page cache page to a non-zero order if possible.
Date:   Tue, 22 Mar 2022 10:19:35 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <B5F3E897-7BBF-422E-AF62-9E4AF50F655C@nvidia.com>
In-Reply-To: <Yjj9FaoChB3u0Gbh@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-5-zi.yan@sent.com>
 <Yjj9FaoChB3u0Gbh@carbon.dhcp.thefacebook.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_35D1A03D-315B-42D0-8538-3E47809BB42E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 802ecee5-96e9-4bd6-fcc4-08da0c0eff3e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24152E13B3356D77DD83880EC2179@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgUZwmb2OfKLeSbWR2Xgiq23Yc/Uy3fY1yF08l3ZoXawVRlv9kkcJsmqe4aePwpRZf1HR98IKcgGXb0DbrfzwX+KSDjn0+x1GbKBOx9U61qyySc29FvZADAs0rQv1vIt6Ob6btpyZPC6LHFxUr0Yqt1qyodoMhe7ihbN9YchlZj20svnuRkqFzzYQSHs8W71+/uXt4pZ0ZH+oJc/Awj/R58T+sGAx2rCogRuZcHx/38n1KnAKrwZT07fbsOtFw/uf3BQb4MH4aZ2CbFm7/gdP+fj3/1oH7k7DdJDNIm7fMKnClz+a2fSZAtDAuCoXpUlNWgkTda9pEAIbjM+zvtbOSlc8J858JKqfP/WVTanQ5cVBOS8laUzlN6CvD+WD20469B0M9JKtMevcc5LgEEG6jixyZcxYYsJyBwY91VWPVfLwv7T+1m88tF5gXB6nzPAVuA75KnB2qlBnIXXT++nkX0MIObr8Dzrgb0ewLrfpvWez1qOUo/GQM8/araSvQTaqXKdOS5hJFoQUxF9kEezi/KACIKVDZxdefBEl3GA3W7Hai+F+KiqL3jXIpE7kci1wVjWEMwzfdCWr2ePy5hZ4QGfRaGc6ltq3hf8aVC4QbyccSqB8JzpnYbjXMMT4p9eu477eEF4bhGJ78M9Z9U0KxS27z8xewFOeNhaSXFaO315RA4jgK1wBFK59jAwTV7vAVoKG/OmfCT8++90/1ZNCQuqzylOR49F4EV/pvBjwiDg6zPS9Bl6H8eLPSOTwXu0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(86362001)(38100700002)(33656002)(6486002)(54906003)(6916009)(5660300002)(235185007)(7416002)(8676002)(66946007)(66556008)(66476007)(2906002)(21480400003)(83380400001)(2616005)(4326008)(6666004)(508600001)(6506007)(6512007)(186003)(26005)(53546011)(36756003)(8936002)(14583001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0gzXN1veKgmX1ChY6eEodiUWPChH4BLNh7mNYfIfQYa/l+uajqU59Oy8nlD?=
 =?us-ascii?Q?C9qtK9J5IM/hEjQZyH9KIOUlUOGRDbxfUE9F6WFfmG85z8KeDmV1j09olD/w?=
 =?us-ascii?Q?WDxD8sdsEJLLQTpel2sq1TYoIFPyU/yhlgxdxazXmxV+JZ/rpzSUspRMT9Oz?=
 =?us-ascii?Q?bGB76TLtN92RGqR0lBvFYqmwYFHMruRgXIn4bea4OuG9CfX5WcsJeLKDTsoO?=
 =?us-ascii?Q?McW6+p8M0wTzHaWnMvYFR0RHkleJM/RtniPIxct+w1X0D/FdF9TZhwzUG8QI?=
 =?us-ascii?Q?S6H3RcjDzZAo9mVh48MIuVTexd3nj+OwOo0uWYA0xVx4n+IOQGPC1KToGLZB?=
 =?us-ascii?Q?/WPaEkXpp8QHw0cOM7xvyuO4ih7g2rPdEV9FYg/AB3KGI42DEdKyC+urJvEN?=
 =?us-ascii?Q?uTZlQlXP9zheAVeKBZC2BzlGEo0epcTD08s8j1EHgrnN22cD15b+nFusNSvG?=
 =?us-ascii?Q?o1VjLp7EsBwF7ASteGImDu99x88kPOvLUn2a/KjcWxkDmM2m5txMaS0wcLFi?=
 =?us-ascii?Q?GVxZIuomR8dlAsoGVtLbWbB1R1UNSmttQL5yiblbvparSezW33fT6A2CwfPS?=
 =?us-ascii?Q?FUiQEmJjsyd+OQb4ukJwVqwnMPrDB4jS7XxIeyNCaCr6c+erfCGxmDYDDSGO?=
 =?us-ascii?Q?GlnNBrRpC2PJ0sGgSegyNvmV7ha/0k5tJuIuAd0SLWtkA07jDhBc6HtVSmnS?=
 =?us-ascii?Q?ECyWFq2t/b7hrOwK9LrcllqvhI/+cMvHbYeIaIoYF7LipSbiJvBYsx4Nli0K?=
 =?us-ascii?Q?4/cPeLlnnXKzJOJ8AALDMsfhq+kA8SVSKay1rG1X8jLTsC7+6fVJX9+j//ED?=
 =?us-ascii?Q?Y+92FHanznh7Fjs6NTubhXlSQTBd7pqANy4Czgn4oLQLVzPrsuXRuClD/s6W?=
 =?us-ascii?Q?ao6PCe6r3MyEKiWJM0ajdgYpFQRWgYgZSrGgS9QNavuH/8FsBJiX78I9Dkvv?=
 =?us-ascii?Q?6lVQhxfFX7WJsUSQsnv7ZzNLl7vvfGfCOzJKJ0/Rzb1Hpwf22cBu9Xj2uqfv?=
 =?us-ascii?Q?ITuhtNrPY8CsmGbNoYM2NKuCW729Z2bPisE9jw72q2PeUdXBQPpXQfeAhIv5?=
 =?us-ascii?Q?dBh/r10Mnd0bFWhwf+TzG5swp+ksf9XBcgrYFEhgz4jsnQNg2iHnxdFx7RUC?=
 =?us-ascii?Q?dn2a6lkIO5XXpgobvXyN1ePRJ1wARRnbAGw7quRjqTP9nai1K+HHG1h4QJ1S?=
 =?us-ascii?Q?TinUz35oikbpnwZHxkuUQ0tghkQpMancOFBm1a2jP0rxwspoOn45VnQh4ZV/?=
 =?us-ascii?Q?f6m9Cb0sH4NmAQIYNYhtxDCJwl6v7SIygnuUvhNxfUmo4kWvBW949U9pHj1M?=
 =?us-ascii?Q?8O3O0OuDQpJl+3cVyMkvZ/xamM0ZimggGj5PXeqW9a16JvjcP54k9VF0M3/y?=
 =?us-ascii?Q?fJ3fd13pnwUx8xEGn4PS5Uxl1odA8qaK6ryDflYSYBRkwNax2ZMEoHeSGDW1?=
 =?us-ascii?Q?Ot8pmmo/uutzuYYJaON4iCDly9epJgkl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802ecee5-96e9-4bd6-fcc4-08da0c0eff3e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 14:19:37.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgWwr4ycQ0OIWqgJr+Zsy+qk4MwlG+ZNV8iNit3j1H5rddeKc4MSjOURu3ITh7bz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_35D1A03D-315B-42D0-8538-3E47809BB42E_=
Content-Type: text/plain

On 21 Mar 2022, at 18:32, Roman Gushchin wrote:

> On Mon, Mar 21, 2022 at 10:21:27AM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To minimize the number of pages after a huge page truncation, we do not
>> need to split it all the way down to order-0. The huge page has at most
>> three parts, the part before offset, the part to be truncated, the part
>> remaining at the end. Find the greatest common power of two multiplier of
>> the non-zero values of them as the new order, so we can split the huge
>> page to this order and keep the remaining pages as large and as few as
>> possible.
>
> Would you mind please to describe the algorithm in more details?

Sure.

During truncation, there can be three parts in a huge page:
1. the _offset_ from the beginning of the huge page,
2. the _length_ of the to-be-truncated part,
3. the _remaining_ part after the to-be-truncated part.

the size of the split huge page need to be the greatest common divisor
of the non-zero ones of three after being rounded down to power of two.

OK, I actually find there is a gcd function. I think the algorithm can
simplified to

new_order = ilog2(gcd(gcd(offset, length), remaining)) - PAGE_SHIFT;

I will update the code, the commit message, and the comment in the next
version.

Thank you for the comment.

--
Best Regards,
Yan, Zi

--=_MailMate_35D1A03D-315B-42D0-8538-3E47809BB42E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI52vcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUomsP/2bJIPAzwm05+PkUnEXdMV1zzJ5A5NEhlmuP
NRdFKhKvSjipK2qU4Q0h6kmtESTbxZmnVbaU6g8KvBWrtuDliOJyf7ika1uUV+Va
2t1yziumrX9mlUFGfzca36O70pj2EkDCBuYPntV/VAJG35trMApLMeXktr+y2wGp
0T3mZcs8OR0vKLVm6rmYT020f4l7xtShIGi9wpAZIhYHkFblKZpbRxstgk3V1HRY
XgpVLA2z+GKX/X0x+9ochEIHLUa2XxkJfmRHFNeywyD3Kunw7YIXrSLWz6NkOJkK
wR1ok7xFoCcF8GsLnMs1peN5Rikb55+GLWBW70ZzreynebKFihRklhLnMEaNGN4p
lRj8pbnyPkAsuSiXLVSzsUFO1ZRz3PCKdCE67synoziIV7KEmbylbNxNFJ/wWYsi
UjqOIXfcxRyWuCCx6OSXbxrCANvZIAv5su9N6VX6jA8d9vl8ZPKYgA1UxOHPO1Kw
aAOm2Qa6KiqWJ7BL2WJnbkHrJbyCI8opnRE8D+YWn1N5x28tPWhnt2ljzO0T1XFi
mVwW38mNuGZKRoavVcYKmYiUJ6eA/+/vwttKWC/g9KvbPlaACSq65H6oVzc6L85+
UnjQ9bRODLcVKW/fnZneqznRhuu+CKgOTtHUFJXuekveAomvy/0IhPJpAXv698eW
J+gLaRwj
=etv0
-----END PGP SIGNATURE-----

--=_MailMate_35D1A03D-315B-42D0-8538-3E47809BB42E_=--
