Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A9316406
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 11:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBJKig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Feb 2021 05:38:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhBJKgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Feb 2021 05:36:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AAXjQl090811;
        Wed, 10 Feb 2021 10:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=N+DV0bAPr6d1+tN3yYpbiL0HsA6oung0Dft1JUdS1Nw=;
 b=D8dOJDLVQuIJOx10EvBmHpo3FrQ9PxwoY3rGsmzSoRK9Vq+kHMTIK7GUstMs6n1XxHza
 YwTmpoSq5QS/C6HmpBQpYz5Zk09ob1cH8EE1iw3efT3PQeZYYW1olUXCovrvRZUNQIa/
 AmJId+LhEehjL6cumaKg9Nko795Krcdpd1p6Bv9jRvpf+GLskoPbif16aa8Qf8469ZW7
 F8AEG6CrwVeG5JhDj8I7n8wdinSSXze3LeMwdV0w64BiBeC69x1gC1BOfkDmwjvpami9
 yf0hPKKJ2AJs0/CzXMSl5ZMa4vbn09LogDOCl/vGd3he/MpsUV0tmK+1sdHWqFR6mAmQ wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrn2ts0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 10:34:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AATw4r107119;
        Wed, 10 Feb 2021 10:34:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 36j4ppyjds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 10:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aspE5ZrfRBVviqwTnoVrQkEOg8sgFIM5kccD/i680yDTwQTPaWL5aSdd8jPhA8rOTH1/Z9JeVxnMxezKnhjQJw1jUnyaVC+CDWH+5KF2mj7HuRItpyNE0lByErv8Po9uyFJB45FpbqNJWzvZ9f0ngdUffWl5tp5gu1dud3/+XEUR1SB74QUQDZDALnu8RnlAkQPfwKBdiGIs0vuIdn5Mu68Mo0/xJSfvr8whbBFzbbY/QJlgFPggrIC3FsoegYRKsAwen069CSfBK1ESuyRNJmHQQ5i0fHud8AHhhE1zIVwEBd0HGMJ8oMAr0eCMld38oDjLp0IZ3M757U7/ys8cSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+DV0bAPr6d1+tN3yYpbiL0HsA6oung0Dft1JUdS1Nw=;
 b=A4bGC7jVkMOoJYvCuldKyFaGTLOwGNu4O23/YHpd8I7dPss/n1f2Cdz3kBDMSIxvsb88KFvrG10EdovjWYEdEy+Hq67l4Cu2fkQhPpPT2mFiCA+mCZGjGe7tMrRxsNAv2/IbatR/x6YlMTD8VSp3YNKdw0CdwU1FVvgqDD4Md42+kj2AeHe4mQ/hN3JjrtauxLBfJ+4gymg5Co7Kb3ZXpt4WhIQzVBum/eT6px6KKUVTpA50ayQ8hHrwpUKF8SQgDCOQ5O4fmHDKqt9Pr8Kdsrzmw2Wr5XbODqNIuwEbcQz3yhB5YGO+7xnVAu1+QXU9kqxvSaRFmYFJ/gGaCYQ3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+DV0bAPr6d1+tN3yYpbiL0HsA6oung0Dft1JUdS1Nw=;
 b=DteWVq5NgtAOxjxBfCSGtGLfNSOFjWe9ZKZsZ0kY4IXTPqEzM7xQDIlK/V/IykB1M0vSYHPG/tIAAhXV6Bt0M6F0kOz/tIzwUrUUgiH8ETqDztyN9lkqrHaG2ynEqY1NlwEx2FoVoy40NbUBFQI+BirERc6Z0h0Fi1fejGGXUj0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 10:34:55 +0000
Received: from CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714]) by CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 10:34:55 +0000
Date:   Wed, 10 Feb 2021 10:34:41 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Daniel Latypov <dlatypov@google.com>
cc:     brendanhiggins@google.com, davidgow@google.com,
        alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v3 0/2] kunit: fail tests on UBSAN errors
In-Reply-To: <20210209221443.78812-1-dlatypov@google.com>
Message-ID: <alpine.LRH.2.23.451.2102101034050.25339@localhost>
References: <20210209221443.78812-1-dlatypov@google.com>
Content-Type: text/plain; charset=US-ASCII
X-Originating-IP: [2a02:6900:8208:1848::16ae]
X-ClientProxiedBy: LO4P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::8) To CO1PR10MB4516.namprd10.prod.outlook.com
 (2603:10b6:303:6e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by LO4P123CA0093.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:191::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 10 Feb 2021 10:34:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d132b54b-a703-4d29-7141-08d8cdaf817b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4435D46785FA863D9C6A5C7CEF8D9@CO1PR10MB4435.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xY6HtWsIoc++smRY4udFEPZn1GxYTokAca0w1eOKcuMkW0IREVNn1HmLcDCv+olplK5OjO6JK713nB5SqlDAeB94CbICGOVmF1JH9jna5Uw3WZYv6lW3C5qXyHAmTRgDv9vh92SNM5P6JEAXLKzCW/zqs9Q+7GyIOOuYJiIkNnqKJMGZLwhO+0lJy+sf0klQ40D/CoXWVsklm5KyLBJeur4nCuJ5ST0jF3beFVupc7ow4p0PYS3EIho7hobAnUVIhwzXfKtremynsxBi+6tLn0MZvQy2mLXVf65PqDqs5hs/dXddTBuXPgydHXVY+9BTUARM1xHigdbmffku0dxS3zzpQshgtrXYFH8QyI8OFZRivIy5Zq4CIv8krGxJ3+n/1uw6BKGmQzs2TEqbM9/19Y03k4IuLRYeXyZNVEsFEBXgfNfZE3sUnPaek1UjmMMjE8p6CE3LzwCzWJfy/Kd27PhHOuNpwdK/eaZf7aUPNYDaHSCWlt84KKTTyvm/rvTgTf2KThrvZwOTJd4cL9yXjgYpux2FRRobVcg7AUtmyf+9roKGqBCgtp4pIrXv+2XsJXdQc5F71DHl5O0EDlKlarO+SdNzbBI+CfiNsu3obY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4516.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(86362001)(478600001)(52116002)(66476007)(66556008)(66946007)(33716001)(83380400001)(6506007)(8936002)(16526019)(186003)(8676002)(44832011)(9686003)(6512007)(316002)(4744005)(2906002)(5660300002)(6916009)(9576002)(6666004)(6486002)(4326008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ms9QxImd+jJC8As071udMGE4zFoZ1xIh166YJ/yMZOIVtV2GE1jFjL7qipKd?=
 =?us-ascii?Q?QBMVLtmdz8ssf3ynBitR2IbE5QKOotnGJP7wFLi4qxDt+TkIHzWSix59+NNX?=
 =?us-ascii?Q?2LZUZm7r0McbKb0DSnRLQEGcxlI5UtwifCK38gWN1Lz5UKTfCr4+lso+tV13?=
 =?us-ascii?Q?XEXI2D47fklVRcH6hYw79kx9C/ah9+HaTIWR7a4hzp/J/jbwnmaTaxESpayx?=
 =?us-ascii?Q?XE8R5qaUXa23SuwyuxZL/LL+tQ1UvdP5eQQAwaDogpt6FoVZFp1ml+kW72P/?=
 =?us-ascii?Q?cntq4jOHezkxmyL0n2H5STmDod6DBgmG74KJzniZqp/SG/f4uRmYD52zd/Qq?=
 =?us-ascii?Q?fKxQL+2m6Y/yKQySSMfX/+fYNjEPQpPXIjN+NaCDCjR+SiMkyuUTm34hzIqa?=
 =?us-ascii?Q?Jjpy1D+PilNfKCbr8mrHNroXsHQzDL9xTaCwZuKLjGnjRQiT/asnba2thpY/?=
 =?us-ascii?Q?3lOhJo5igN1vXQTwdvcIObo0Jp7IfaMBUzouSozozFvHvh2DX3xTl4W9XTtL?=
 =?us-ascii?Q?rZqJtFz0JW9x4Y9SI5jtoTaqiFcLjubAKTKzr755YggLBfObUmRhrTYy0kGL?=
 =?us-ascii?Q?AAk8iaeBUWQfq7kIHruYQ/Xe+2AoItaO8k2jrf1rDdogRoSLdrj+A6hy/NAJ?=
 =?us-ascii?Q?DveiO8bnarzwx9RSqa10nNHyU2G9YabuwoTILjJiw6wowYL0UMdv7hLLse10?=
 =?us-ascii?Q?7tQcJkraMhr04MdzRnrZSVateQny6/Dwl8kOvE9X2KtXQ6eELIUqj37uFT5s?=
 =?us-ascii?Q?2aBuDQr1tp+2109bS1b0EFzKEUfjjuf7H5Gtd23jJ4Y2J4TvR5cd8vAltypD?=
 =?us-ascii?Q?pF5b+VtJr7MFKVNhLw6oLf3ZnTOBWWVrqnmvwSvN939adhaeg0/CnWPog7Gp?=
 =?us-ascii?Q?QO7r5t0Boz1fO78SLJYAHkxf6mpDNT9zrqSRzhQ49RYdcZ0ykR//HPL3tEvM?=
 =?us-ascii?Q?k0D4rtOGA6iq2l+iE5LmcpLqfZKrv2BNGa6mn2JqoLcafB7pyp3unH9mVDtx?=
 =?us-ascii?Q?V8qvhd7AfMGuuKx4Q/PtkI4mn5DxVbq/N9LQVsVRTK4UjvN8YM11I+0XxSiu?=
 =?us-ascii?Q?mqIjv7n8O8u0aNQSBc1DAgK5BwUE92XdPCIYyQWEIGXj4nB1f2+zaWmLv3Dx?=
 =?us-ascii?Q?iL1VSr0Gafuu5V+s2UstBiNQEzGu01uiFspSgdvlu8sjOWKcKEm3M/CeI6fb?=
 =?us-ascii?Q?3F6q2RuWV2AnxREiFgyTiscpnHPyQ5ZTDcfQKPojGJDCaP4c40XwwZEbpFyQ?=
 =?us-ascii?Q?99h4MsAm/E0emo1irL6GlWxjv/mYizJvhRdNhOXB9hmOSWHiwjJxxgo1vCir?=
 =?us-ascii?Q?ffeFNpWy9uiPmgdl4eFbbAa5eE/WaG1trq8f4pGPokjM8rSHtxGRDSv/lS63?=
 =?us-ascii?Q?hbyUNJ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d132b54b-a703-4d29-7141-08d8cdaf817b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4516.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 10:34:55.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqPpcy4Wp+wYG1T/73trJLFZBfCa0MNW3uux7D0UFsED4wsR+QWKWLwgIqYnhgY7YJDxkgWCQ1cYrYtd4BPq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100103
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100104
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Tue, 9 Feb 2021, Daniel Latypov wrote:

> v1 by Uriel is here: [1].
> Since it's been a while, I've dropped the Reviewed-By's.
> 
> It depended on commit 83c4e7a0363b ("KUnit: KASAN Integration") which
> hadn't been merged yet, so that caused some kerfuffle with applying them
> previously and the series was reverted.
> 
> This revives the series but makes the kunit_fail_current_test() function
> take a format string and logs the file and line number of the failing
> code, addressing Alan Maguire's comments on the previous version.
> 
> As a result, the patch that makes UBSAN errors was tweaked slightly to
> include an error message.
> 
> v2 -> v3:
>   Fix kunit_fail_current_test() so it works w/ CONFIG_KUNIT=m
>   s/_/__ on the helper func to match others in test.c
> 
> [1] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
>

For the series:

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks!
