Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9B429FB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhJLIZm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 04:25:42 -0400
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:41014
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234501AbhJLIZi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giE24xpN2bO0piiAhrXQTA5jSsVwY/3bkgHMp/BBjzs=;
 b=s8R50yFtCTipvo4KdQZG9cDOhtGDrfH7k3JLC8LVzo4UmxC5bPievq5FwpfagOJ8YLv2vdFXVt2xmbyEQ20/5+XZpkv+teTyTcS1STvoTHYsmSap8bZCQTHfdDva2oHmx4bExn0LgKcEctIMeKUQx7f8Y/YgHaUVMSEpjt6rxds=
Received: from DU2PR04CA0198.eurprd04.prod.outlook.com (2603:10a6:10:28d::23)
 by DBBPR08MB4742.eurprd08.prod.outlook.com (2603:10a6:10:f5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 08:23:33 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::23) by DU2PR04CA0198.outlook.office365.com
 (2603:10a6:10:28d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend
 Transport; Tue, 12 Oct 2021 08:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 08:23:33 +0000
Received: ("Tessian outbound a8bfe25d7364:v103"); Tue, 12 Oct 2021 08:23:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8e2827dcced20e87
X-CR-MTA-TID: 64aa7808
Received: from 6e8afa36b042.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A8CEA2E7-397B-4F09-A938-7D6E44E93BC8.1;
        Tue, 12 Oct 2021 08:23:27 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6e8afa36b042.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Oct 2021 08:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6AFOnrUopePW4NTreWz9u5GTxC6L7E+5rLsiteV/KK1PY0XuK9TXF9+Okf5lQhJQtXUwE8sIYgC6NhGk1Va7gKNbLrRmwfe/niyZQb/EFDVwVEthB+XrW+BqhBA5umwV7fVw2SbkALaR4Z17X2XnDvWG947AKQKS4YRxvr5cMz/teYv1EuUk7/DFL6XBC6wcdcM874TvJcYSJTW8TxHAdw8IpXbTo39bXmezHDl0Mvznlz+qasX5O6TxH2T/x8mf8F6zPtLBpOqG7wwBNp8XeX0jp62ywhTtQ2cDfZScv4JFxp8vz9CF4mbzdwiTVj1vn4VvehkazLVpWh5bFKi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giE24xpN2bO0piiAhrXQTA5jSsVwY/3bkgHMp/BBjzs=;
 b=WRlPNiJFiXOPUwiABCssOJhHEUvY+FeaK6yqNWFJRQPGKqhd9Kc6vJPsRsu3PRZ0v6G5MGUeLgoZzFMyINXneWZqdKrFtmQBSOr+J0Lg+afUFCac2TF3b7E9awsZAvBE+gwErD2V0Hf25+1ml0GeaurZ/xK5qOfo8URi/3nPsBf045133Z7ehYD1r5ujDOHX7M8GycxFcCeRQKw2tpI7HFUgT+YabVfJsanQfWt1Lbrw6vHSzPrVB/iccvm9f21wQcyjj0BYc0IjTlMpYk6EaMif77+5NqVgaFZDxXvujiLd8H+dAs/Anmp1Z6avQ3YsefD/t0AB+dw2v+H+lMmonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giE24xpN2bO0piiAhrXQTA5jSsVwY/3bkgHMp/BBjzs=;
 b=s8R50yFtCTipvo4KdQZG9cDOhtGDrfH7k3JLC8LVzo4UmxC5bPievq5FwpfagOJ8YLv2vdFXVt2xmbyEQ20/5+XZpkv+teTyTcS1STvoTHYsmSap8bZCQTHfdDva2oHmx4bExn0LgKcEctIMeKUQx7f8Y/YgHaUVMSEpjt6rxds=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB9PR08MB7129.eurprd08.prod.outlook.com (2603:10a6:10:2c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 08:23:25 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:23:24 +0000
Date:   Tue, 12 Oct 2021 09:23:21 +0100
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
        linux-kselftest@vger.kernel.org,
        Richard Sandiford <Richard.Sandiford@arm.com>
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <20211012082321.GN2700@arm.com>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <20211011131730.GL2700@arm.com>
 <YWQ67ad5wfRgp9l7@sirena.org.uk>
 <20211011141937.GM2700@arm.com>
 <YWSaHaJOIbEigw4w@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWSaHaJOIbEigw4w@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.52) by LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1aa::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend Transport; Tue, 12 Oct 2021 08:23:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d0893d1-8eb4-4e24-7d27-08d98d5994c2
X-MS-TrafficTypeDiagnostic: DB9PR08MB7129:|DBBPR08MB4742:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB474282D863DB4A07D94AA6C6EDB69@DBBPR08MB4742.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Tfcp1fUW4eUlIxCnwPiL+RaMmVpy1TgAvzwzyua90hykp1A8M6BB2Y9qV4l/aG4Rhw7PRmDiD0YOHWr7sd1pbLjSKTUt2+/lbEtlAfFUfacdf5KOl8vxH46Q3Shk5xEiB/xz+LadbOH45Mc1m3aVKbdnXtfvYtvAVIHYuH2f4WXl6U2NUSPFVVdWG2qwNHnM/WPnIctOmu0MR1KZYnpsHmzK3/JkuGouz5mDzhayUyZgxSBqFX70J6pxAC5mCVZYGBYYPE7gJPB0R5JnU3xrP1CJ6YuQkLNXA85MS6bmq+Ck6MIiK8ncMjVKKXAmVYy2ehuY+5DhfRyB2cDezMijmtmJOWlack9BSHU2z/HNO7ykVH+oXKC1foKohXhoRGmuaB4TlDIoeAc9Wt5WXIz2atqoeUW+BTy1HMDgmGMTw6E90fP3EtJx50YoZUwMG/O8VlyLq0sjLqx8Mo8UwCfV+e4eIp07Z3P7aXcjuRFEnnpzNnt6yTxpbBeh6vXtIvKivCUrTwegSkeWzq5N8cfOrn2RTpqFv5uvXbSE4FcdS//PVuIAos2eb/c0t73/XkOTExTrZaoc5fBkcEcnx843BmMDGLtL80bC0cmjVRfkCIa8RkBD5ESbG6gw3jPpj7eQ8ttRq914iFdEmX0+FGTRV6iUORXS3jUJdn3OUHeEMkx2GR+idjOORQE9Eo0vzHN0pixC9A142rgzJDgXu+Ys8w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8886007)(54906003)(2616005)(38100700002)(38350700002)(66946007)(956004)(44832011)(55016002)(5660300002)(66556008)(66476007)(33656002)(316002)(6916009)(26005)(2906002)(508600001)(8936002)(186003)(52116002)(36756003)(4326008)(1076003)(83380400001)(8676002)(86362001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7129
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8120af5a-c490-462d-b249-08d98d598ede
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8G8aLxbHSyz/R0NargnpQichZctqb5QEwXaUrPCIcMzqEiO4FKYZllNz4Ptv36p/Yw8HSPQBa/CgfeyS0xDDEemlMo1+7+cI9GejkfjtmVFSDvDq+gbjLXkBGyf2TqenWaJQfFjHiR+awjHg+rkllcjL9dgHxEU0pvi7KfFO8lPxQUdSPl0YRZ7Xxy/1eIfK1SPPVKL7xaFUw8EkGlamFbZBOr4zPLMDGEpUElZyMYIDZgUoSZerZj6KS0CkwVan8XdTUIqUfnxxW3AGDdpJoJwAet7zLSfjva3dth0HbciWXSfH+YVIjoBoeqEvooFuYVrfgFIpUSQJBse2eO37beL4UgDJbBf7Qv0M8tJqq5LCeRgB0tVRhUfYVdu35ZJ1Ezvy0UHWOtu/65zaK3R6O/LqdsFTTu24u07qT7whw5CiXqorzEdKUUvxLspupgGuMsa692VK7fgcxUv4RU21TuMXbXe38asqBi16GmSsyrT4c633Q6N7k0ZCDD5EFMpY5egTjT/EfJDyy9G6cOa+fIKEnXVFJJK6Epz/LUikmc1MbAusrs+MqPI1G3+MHF/U+ZMF30GtkPjPZatUBJKCMgpaqUqJNrDoV4omebpIwy6VwPgPOfSCoa3cklNInQQgajO1SfZ6tEZpqfUdhW85Y8vhjpQXnuBjiMIUsmJLOzpkkrljHnu0u+asoKW3NsrlRCOMoW+/Px4DRpCKM1pSfw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(33656002)(956004)(83380400001)(44832011)(1076003)(8886007)(7696005)(6862004)(2616005)(8936002)(5660300002)(316002)(26005)(54906003)(2906002)(82310400003)(81166007)(186003)(36860700001)(55016002)(8676002)(508600001)(356005)(4326008)(336012)(47076005)(70206006)(36756003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 08:23:33.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0893d1-8eb4-4e24-7d27-08d98d5994c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4742
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 10/11/2021 21:10, Mark Brown wrote:
> On Mon, Oct 11, 2021 at 03:19:37PM +0100, Szabolcs Nagy wrote:
> 
> > if fork resets tpidr2 then returning to a stack frame
> > that set tpidr2 could cause clobbered za state.
> > (userspace can fix this up, but if we want this case
> > to work then it's better to fix it on the kernel side)
> 
> OK, that makes sense.  I've changed the code and the kselftest so that
> TPIDR2 is preserved on thread creation.

does thread creation have to work the same way as fork?

(in a pthread_create child we want tpidr2 to be 0,
since it represents thread specific data. in a fork
child we want to preserve tpidr2 to mirror the
state of the parent as much as possible)

for sme pcs to work, the libc has to be updated anyway,
so we can change the clone child to set tpidr2. however
that's not atomic wrt thread creation. i don't think we
aim to support async-signal-safe za usage in the pcs so
this is not a problem, but if the kernel did the work
then the situation would be clearer in userspace.

i'm not sure when to do tpidr2=0 exactly, but something
like CLONE_SETTLS is set or child runs on a new stack
would work for me. if that's too ugly then preserving
tpidr2 in the child is fine.

