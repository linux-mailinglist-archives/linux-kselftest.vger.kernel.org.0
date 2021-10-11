Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4F428DAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhJKNUA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 09:20:00 -0400
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:7138
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231392AbhJKNT7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 09:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MHMnmtjRYQkioXOTbCD04eheeLbC5I9Ms51FR5Ky2s=;
 b=fa4w3CjBcRVoLcFhp6C+wPXZT/8M53D1tAeop2031pjxDOUe9d+mX/d4DE9Ts+jwGRfkp2Hh6JUzLKNkIbff5ylxUU1NBVNIysVDnupc1g6/NklRcsa0MoC8syLfyaSos0014FzwNYW4unfiLHLTzk3Gu4aCk/Zcv7uZPay1IOc=
Received: from AM6PR05CA0033.eurprd05.prod.outlook.com (2603:10a6:20b:2e::46)
 by AM8PR08MB5763.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 13:17:56 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::36) by AM6PR05CA0033.outlook.office365.com
 (2603:10a6:20b:2e::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.27 via Frontend
 Transport; Mon, 11 Oct 2021 13:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 13:17:54 +0000
Received: ("Tessian outbound a8bfe25d7364:v103"); Mon, 11 Oct 2021 13:17:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a9b7f4b7a6fef769
X-CR-MTA-TID: 64aa7808
Received: from d338e213f67d.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 88D5CFF3-6019-4A6F-8661-072D3DA12E35.1;
        Mon, 11 Oct 2021 13:17:43 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d338e213f67d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 11 Oct 2021 13:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMShuUp55j1ah6ADeH7QD8BGFYeSFViwQan00TOEIuFSqX/j0V5T5QOBeYxxAzmqkG0hari84xKDIT3UHPnxkimDDhtpZfYQtJa6QV2IdX6y2Xg6zOLb02JlONK5kzUzTeSuHsIP9GF/c4ySHpf81bAVXXbsZq0TU0JjWDksU6KGD/180OVEIlQ6HBj5rFrkRrOS8/M9vTD3UVa/jza3EyDnlGSIsbh3ii1g/5Azf3y3QCY51sVEqBzMGv8Kbk+1v6oLxZ6tJCRWuAXA6/XmHVIqAMx51RyoQNvLCnuaTRD/tEopO5VJc4Nk7m4VB1DYjEP9hNvtnHaZGrbUMQJtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MHMnmtjRYQkioXOTbCD04eheeLbC5I9Ms51FR5Ky2s=;
 b=DP9S+uysdo/hWxqVRhxbaLjCCCJ5d35m/QCusCwro5lCWd9Sp7y/BXx6UY86y3UkOS3V6EbYSYL/TNDZxr9qc74r98+74cIde3DSm/jUylnLNOVGWmV8nlZU4I98S0gIHQYyynb1a/tkT9s8kUY9ceKP0jJvcKS/fOdrRck9RGI4PheXa+CYnixlFlG+yixkSLg1YaMG/ZJBexC2Znu8p6uNoqta52jEHfsjSHiDgHLiHwYu45lZ0ExCjzKmiNYfpimORB18dygjO0p1lJoIhBtdFGTfglZmhTctwxP85QpcIPhzc4zyMm7Br1w8pZOdm1V9KGB2xLXQYEZ9aHWAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MHMnmtjRYQkioXOTbCD04eheeLbC5I9Ms51FR5Ky2s=;
 b=fa4w3CjBcRVoLcFhp6C+wPXZT/8M53D1tAeop2031pjxDOUe9d+mX/d4DE9Ts+jwGRfkp2Hh6JUzLKNkIbff5ylxUU1NBVNIysVDnupc1g6/NklRcsa0MoC8syLfyaSos0014FzwNYW4unfiLHLTzk3Gu4aCk/Zcv7uZPay1IOc=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB9PR08MB7068.eurprd08.prod.outlook.com (2603:10a6:10:2c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 13:17:40 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 13:17:40 +0000
Date:   Mon, 11 Oct 2021 14:17:30 +0100
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
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <20211011131730.GL2700@arm.com>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930181144.10029-13-broonie@kernel.org>
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.52) by SN7PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:f2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 13:17:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0dbb89-d141-41cb-de62-08d98cb98932
X-MS-TrafficTypeDiagnostic: DB9PR08MB7068:|AM8PR08MB5763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR08MB57635F1E4C888F503FC97EAFEDB59@AM8PR08MB5763.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: snxG8giT1W4RIFyNH9VzVy2JFmZLkRtDNSwX2MTQe+vkj/mAsjS1ngc4vzNhYF8Xd4+psoQWPvBqr5eso1nWHASQisw+MzxiTmiSQsvphmo0mA90kQ9hWGmY00w6l3Izo2DiGsKgmRg58eFikYPmY3UpJnwPF4gP1OAiBiaJ7f26izvrFV8mGV/OZNzcVsXNpPjfmhywVKO8tWTXlyxwYHc9CRuAx5cGlErySxd4msvPnyYjoeCT9amhp/IC/8UNwaVYVJ30JjVudQkjdPRZANn21BEFj4qYyIPX20OOSrHvz39GpfAslHmfzSAip7LUufm/Yq6+e2FOyF0P8cX/8qyzM4IbqFRDvs48sPlvPDgd4FmsMCjn1LUIadaslmjSFXt0Ygc/ZXB0mGyWoTc7DzhtOSlCNNpznQHUrhgXmGeoGmx/T0/xwp2lUaE0x4ffxX9ukWpwoZQim0Ad8WowxIsP5IER+tHbY7Xyo8Y5YYYmHHw7GNNtuflU/yZbu4OOYXRo8RdubGvpS3C4pZ7cprtem9KLu5zWG5zD6npb6tvUDK1gAvlDtr7BlYJpiQ+0uwgr+4nF5onHLDVz4jJ/wIQv/OoQ2vx9orTt5QJi2QFM3ytv1LqlrCcewpJXSJJJtwMmE3UreWFthqfzSqeAnRdkiXuVyTzQ6GybrQ8J5v/jY7lCjkvMF4fF7YEtGxgPRRuDSp6svqdePmw0J3KQZA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(36756003)(4326008)(1076003)(26005)(8936002)(54906003)(44832011)(33656002)(38100700002)(55016002)(186003)(38350700002)(5660300002)(6916009)(6666004)(66556008)(316002)(66946007)(8676002)(2616005)(2906002)(83380400001)(52116002)(956004)(8886007)(86362001)(7696005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7068
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3e905a6b-97a6-42d5-a54d-08d98cb9806a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43bN5D2hFsIA5lDp6fNJ5CqBVzhIz4VpalLJ7k8bX9IbWr3J/IR3cdcdA7LfQCfUdGVe8HjklqBGfARJfV7wnziQ05Q51r1cqKyNbmnc/jQxPBHcKsENTnAiArU6yTMb+3mPfpWMJdNKosUoY3TtWiMZnjtfgxXMk9z37ZnsoqO58dISOUvHwg3h/nBdxOwdNtY247k7+AWBnYaOnAsNsesM5ZJUiPE8ogjFvMr/AjnWTsaImTb9KOOTAgyrAmuolGigAXsd/tyCqctDoHL4wt9izkvPdRoaoaKApSUcScJF5xnKA4MtD3M+N5lQl4NH9GYSEGNBX1mrIn7LwoMB+fz7uJnxR4EFc4UybvvHvkBAuDm6U82okkLJ5CGW6fzUIbOyI/UQbV0L/ML/mivjepgUuNUixTM/I18s04YyGpkTvw6hdMDZYy+3gCIq7A0aGSYma8pq07lYxBA6GypC1zZF5qBtXn5cw1zQC9wvGa+HbQtIwbZ++HT3UIHlUnhiDRXpJSedpba7e2qUOiz+Tv/UNGBQ4HwHMGcqpNzO5F4pR3tFhMITCcvl94+fbbOY3kEqaXvmApmHmVRjZjC56gCyeVwec5ubUWhJiWcztxxbR1bMVzBcqQmxTraBZy8pOCMtnUkZFhaaYTlMaktdjOsL48dlTO2fjoxg8+rHFXnTuDBFUCRgD3iyVTy3u1MiAfMn+M6vACF1AIcQU9iwLA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(44832011)(70206006)(6862004)(83380400001)(8676002)(4326008)(2906002)(316002)(70586007)(47076005)(54906003)(81166007)(1076003)(8936002)(356005)(82310400003)(6666004)(36756003)(36860700001)(7696005)(2616005)(26005)(336012)(33656002)(508600001)(5660300002)(956004)(55016002)(8886007)(86362001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 13:17:54.7187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0dbb89-d141-41cb-de62-08d98cb98932
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5763
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 09/30/2021 19:11, Mark Brown wrote:
> --- /dev/null
> +++ b/Documentation/arm64/sme.rst
> @@ -0,0 +1,427 @@
> +===================================================
> +Scalable Matrix Extension support for AArch64 Linux
> +===================================================
> +
> +This document outlines briefly the interface provided to userspace by Linux in
> +order to support use of the ARM Scalable Matrix Extension (SME).
> +
> +This is an outline of the most important features and issues only and not
> +intended to be exhaustive.  It should be read in conjunction with the SVE
> +documentation in sve.rst which provides details on the Streaming SVE mode
> +included in SME.
> +
> +This document does not aim to describe the SME architecture or programmer's
> +model.  To aid understanding, a minimal description of relevant programmer's
> +model features for SME is included in Appendix A.
> +
> +
> +1.  General
> +-----------
> +
> +* PSTATE.SM and PSTATE.ZA, the streaming mode vector length and the ZA
> +  register state are tracked per thread.

can you add a note that there is a new TPIDR2_EL0
per thread and on thread creation it's 0 (and i
guess unchanged on fork).

at least this abi makes most sense to me.
