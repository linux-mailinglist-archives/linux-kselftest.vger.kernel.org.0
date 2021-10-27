Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CFC43C85B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 13:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhJ0LRA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 07:17:00 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:54150
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239601AbhJ0LRA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 07:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyj19jzPWK54Z+J2gKC3mDcyEwR5fzd3TEo1xD9jfek=;
 b=+LMnvp0j20nTG421aVkDnrNgJY6A5IZT0+9qQ6A8MlQJyamVKTOWSPbRChU+407bo4Izs3cYkWy8iOHc/12Rb5a1DZK/3UOtFl/ABARdY+fkjztchRXavCp5R5Kpatmhfh/nLZLFAd72m10OBtGzC/ZcYg+Tn4yJ068jcLttmJI=
Received: from DB6P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::29) by
 VI1PR0802MB2414.eurprd08.prod.outlook.com (2603:10a6:800:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 11:14:25 +0000
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::e3) by DB6P191CA0019.outlook.office365.com
 (2603:10a6:6:28::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Wed, 27 Oct 2021 11:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT064.mail.protection.outlook.com (10.152.21.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 11:14:25 +0000
Received: ("Tessian outbound e27daf245730:v103"); Wed, 27 Oct 2021 11:14:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8639733033b0226c
X-CR-MTA-TID: 64aa7808
Received: from eaf5b6b5cd19.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0CDC2721-8D4C-41A6-BCD4-8EF717EE8326.1;
        Wed, 27 Oct 2021 11:14:14 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eaf5b6b5cd19.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Oct 2021 11:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgreX1EZ8A9gSiuOitCE+1O2zLnolZfxPQsqp4QwAL+45PH27xTrmrFuXJO6mIXcNr5x/4PKZr2El2K+UWZtquwpo3aWFnKdi6RN8se55cRGwsOO6GyKvkvlOc+ugYQcW46Y8ygGU4SnsSXh2wLKoUpKQjmfa8XpmZWEAupjxEF4jSbH/oaZLAUzv2fRuJC0oBfn9PB+Bdx4S1yKK7k+E44GWoz9WEwF4VEgt9v2z3OtcpfcNF3Yv2siO6EbpVS9RwrVsD+S2SAv91GgVn/vB3GgDr6mqQ7pCLnlG6dFVNtlr9pavfK8qxt2U7/14cvSi9L80T8ueep74SHgRFYcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyj19jzPWK54Z+J2gKC3mDcyEwR5fzd3TEo1xD9jfek=;
 b=WN2dEcEGh7isZiBMpAHXrQ3Ll80NGrMmOYlC4Gp8qo51rgmK1EC9oi6D9vcANhG37YCw2tlZGSSr80YInoKc8Uquo18cbGpqnf6gMI322Ou7FWDQUoLxTD8yLz4drL5gllprBJrVoHGQIIfWIaLkV7LewtSHetI6HS7h3NeN1d70MkLscZ9WroIk3QoXQMGdeTZ7XXP4hlOg8RiWDV1Ea4Seyfhr1jFJpm3Lr0qVj/rF25eKMdIfLoSMr6zq5KAJrpM7W3VhK6xfPIFfNVLoyGIlRyxw0Wm9KHc8D+MKpEoQgAiyel0NEKyp8Ubxw2kG0pxj9xolnZ13yvqn6bjpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyj19jzPWK54Z+J2gKC3mDcyEwR5fzd3TEo1xD9jfek=;
 b=+LMnvp0j20nTG421aVkDnrNgJY6A5IZT0+9qQ6A8MlQJyamVKTOWSPbRChU+407bo4Izs3cYkWy8iOHc/12Rb5a1DZK/3UOtFl/ABARdY+fkjztchRXavCp5R5Kpatmhfh/nLZLFAd72m10OBtGzC/ZcYg+Tn4yJ068jcLttmJI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU2PR08MB7344.eurprd08.prod.outlook.com (2603:10a6:10:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 27 Oct
 2021 11:14:11 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846%5]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 11:14:11 +0000
Date:   Wed, 27 Oct 2021 12:14:01 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 06/33] arm64/sme: Provide ABI documentation for SME
Message-ID: <20211027111401.GQ1982710@arm.com>
References: <20211021180722.3699248-1-broonie@kernel.org>
 <20211021180722.3699248-7-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021180722.3699248-7-broonie@kernel.org>
X-ClientProxiedBy: SN7PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:806:122::10) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.55) by SN7PR04CA0095.namprd04.prod.outlook.com (2603:10b6:806:122::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Wed, 27 Oct 2021 11:14:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab98190-fc84-4148-9839-08d9993aef9a
X-MS-TrafficTypeDiagnostic: DU2PR08MB7344:|VI1PR0802MB2414:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2414307173ECFB31846D13A0ED859@VI1PR0802MB2414.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UbEOqUKV7RJNihurwo/O1Oi/+VMBPtJBZH1SunW5LLJqST5UYuKjNHoqBr8d9qEl4VwIaglvmFjqfscBjQWU5yF38dSABhXWnA5DfOE1kp+GIpVWJ141Lc5xkely4JedBATv1DaY/qmDUrQo3n3MULwtMLHtemCX+Ul0mAJBxsaOkpduXwfvN/Y0Z3Rf540V9VReezVLwsT46k/uY7zjVtBjhTAF0xMUph8HhIWfTRo0gml5T71QLuNJLPxOB3h6nU4QPORRRpfQ/AtBOzNBNkBivz2tHQQ8b7Rq3U900RwnmedSEfbfTl+48FHPk+EEufyAbE6O5JAhGaUBrzD5EakQs4Z9f6cY7weKrt17PTheuvAWO8wpchFG7H3hKKrDU/YTBllm51G46BQ8oLF4M4IO+RhhI3QIDAZHKqu/hgcPgcBtIVuvDU+ALzIKycrsMw0hFPG2Ejt8TuPrSghP3C36fQGXQTq9b7UaAlIv2SGC/DatxN0KJyoQPQuKWyAQ12h5dXVTsZ4+vZghjwUD0Cj2WsqS7y8gcEmWgmDHDEdzNFkbGQsVgeGyo4rcTD2fXZp3xstWes9Nx8+Uc7KXip/Fsy+Mu45813zrj+hf1ZvOfC+t+es/BKmSUQimEf4Pjiy34w4Tq98CsVezGcwt/btEDGZeXE8pxrOG5QgukuUH71UoTmAdnBMgvgOA5il4uBxXKG9dEerTg9nc2ZHo9g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2906002)(1076003)(55016002)(956004)(33656002)(36756003)(508600001)(6666004)(54906003)(316002)(2616005)(38350700002)(38100700002)(66476007)(558084003)(26005)(66946007)(186003)(8676002)(4326008)(5660300002)(6916009)(86362001)(52116002)(66556008)(44832011)(8886007)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7344
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 34957f3e-fac5-4a40-5d92-08d9993ae704
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XD6uifbAHAWqxXbWAtkGoGDxD3oEF7Ct5YUXbWu9Y4eNrOGsClN5x4Z2By3W2qb5Q2gdc0+5scbwmTBZec1m+7q1wpywohzoXgbwabxrmNgbFpnJnf+Y3hrYZQOnDxFZlQQRgKceOUXME4Y5boAiVYxflC+4TpPvPRWSwqEEHZjetn8Wc6svWJT0sY17Vkx9rbXIXN0xLuFI6MepPZWAjrXJdJ/QabQbgmSU1MPOzQ0lRMgrOj1m2te5Bu7GQd9tZ6HSH7Ll9ox/sJO63HWSnPCzhpVaSeCVk35zLhD2vaEgsqPaw26aJG6Yd5XVHag73mv/PcfEwXfkKx+hjKkd6AFGCGLSWfS4MzcDUUziGx5cpO+RxESWbrBzfzADsLhlFwQfcZGGUOXezUx6nHqtcmvmLsRNWArwtYw24KEMAWHdIilP5IOp4BI7z5ccGwF8ahSB5gK6zYOngA6vUsjE0gJC2ZlvRwd01azn6EOgy4+LZTJVUYSj9mXk9bNP8wSuaylF8GBnnfTfBcaT33URG3tPMb/4auoCXxYUQf43KlzPw/xQznJh2MSytICirGS0GkuN3eAyF6Vvpbhgr2dI3Uqz5rHPT2FHAPZSmDkDvwPlOJBX5/tRnyUZgjFrphVGrb1iKpOd9DmWeCrasxTk7ezoxxRGR6+FDIAhYV79apuyG++1Xi2aLqv9PUUV9/cyfgN5BJHfDo2widk4MRghw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(956004)(8676002)(186003)(2616005)(8886007)(336012)(55016002)(70586007)(6666004)(44832011)(26005)(508600001)(33656002)(5660300002)(47076005)(36756003)(81166007)(36860700001)(70206006)(1076003)(558084003)(2906002)(4326008)(6862004)(54906003)(86362001)(356005)(7696005)(316002)(8936002)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 11:14:25.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab98190-fc84-4148-9839-08d9993aef9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2414
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 10/21/2021 19:06, Mark Brown wrote:
> +
> +* On thread creation TPIDR2_EL0 is set to 0.

i think this should mention the CLONE_SETTLS logic.
(thread creation leaves tp2 alone if !CLONE_SETTLS)
