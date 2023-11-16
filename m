Return-Path: <linux-kselftest+bounces-214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FC7EE11D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25A0B20A5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B09930641;
	Thu, 16 Nov 2023 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VeHHi/Mo";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VeHHi/Mo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2053.outbound.protection.outlook.com [40.107.103.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E16CE;
	Thu, 16 Nov 2023 05:12:51 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=dLFCYZJoMW7cY56g4fY5QZ/dadqWvGcow56mqqQtzO9zC7mrIxXeQdjcjinN5XIWLlvsXcqcbFzzUh3r9JSFbhspGFl3/QndXXQ+L4wCATVY9+RBvZZWGebJU0EtrRe1vIoJ1c+5xtcQgST1bD9opco56/7HSNqOAeT+hPt06ch/PEfJ1fDy2Lw6GMF2qY7dY1zqCnaR74x3rqfEgxS9Ot/iDQwdeMgeYvVlK9+BTR+ukrp7o5btaQYQy5q60Jec46hvZ/Doz+0DojntMR7HAjBvK+OMsa506G3tXZ9wO8gn4GrnCFTaz+JU7+NCZdjIVQR1TMTQes7tChQYRPm17g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df9OM3ejA1mwKqDpBEbkVVub9rONWcJATp6SDhd1iWI=;
 b=EbCL4oRh6cGYcixNJFapPjTwJqSqGhiF3MZst9itUK15KjIvBcMTTSjsFNOB7mtQrnkZNMjlmu2msgm2WiwweeNbWx/hPqJHQYWP0zEP8c+5octVjGDmXwhJ+3GfmaS0cAQo3fEIN/rzKtTuIf6SU4DGcf+R8iCLnI0kqA5BZg+BLC5tpf2g7hPf5dcXX+eeEnESU2GVJlLP+dHoIqueA33O5HwWwYwFe9c8/OuBoJ1Lq0oc4zVBgMO9I6yGPUFY+wk6NA/cYnSzXne5u0V6lr81ZPyPJEvwf8FyCtY7Hj9TzuQRyrbleHPYoA57TH/U2cmKSemCu7Fbfo1JsfYE3Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df9OM3ejA1mwKqDpBEbkVVub9rONWcJATp6SDhd1iWI=;
 b=VeHHi/Moh15HVWclo1H1Tnj2n2RRIbs6X5GmhT7eut0mF7MOscn7Djtg4hEB4q3NFnmSuLqS2cb7IqWUuhTC0SNH6y9ucSm+V2mPiseC5H3+RBT3NJdTmlZ6+KL4Zn1HY1Pbbt2LT3k41ciypHsPvRAT6cnDX1amubBrmxwbrLA=
Received: from AS9PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:20b:498::19)
 by DU0PR08MB7543.eurprd08.prod.outlook.com (2603:10a6:10:314::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 13:12:44 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:498:cafe::81) by AS9PR05CA0108.outlook.office365.com
 (2603:10a6:20b:498::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:12:44 +0000
Received: ("Tessian outbound 26ee1d40577c:v228"); Thu, 16 Nov 2023 13:12:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ce7020c9a395cef6
X-CR-MTA-TID: 64aa7808
Received: from 7ebc8bfe34e1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 75E62B0D-F097-4B03-BA3E-4D963B33F8FB.1;
	Thu, 16 Nov 2023 13:12:33 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7ebc8bfe34e1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 16 Nov 2023 13:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO7eq1yj/thwwhlsLY0n0FYJxHJ/3PSPRx6jtYTMCKs6gMd/IHuZqsb0lE6LP4UkWuIDW3Jftx61yi59CDZj/2ZbMsr9n/6jbvxsu1v9Hk/zJkyfCbKNuBB7MVJPLcMbSzjkDOk/GEd3ZOxPzAWUH1OIRnCXxoSSrQpznaX0MZwLVjCTKJBG5qJvoNLt+tbj7FTPsup5rtf/pgFbv0bppVvWGkZcVp8nZYk0wXtYKah3MaVGQitveyhKGjnNewFe1dLP9/VZ+3oabFTuA7ayuNJc0gm4qcBc1rGD9ef5uMsTKT8PE+Sg8K4U/LJPUJ/vLYOkbBP1YEJ2jLjGeewI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df9OM3ejA1mwKqDpBEbkVVub9rONWcJATp6SDhd1iWI=;
 b=bOsXepUI81uo7ih3lL7B6HakBuux7WvQTjvLcsC2ZbUAQLhYe7Py7IoMhwYethEWxfowIqR8IBaXQfKgeBExSIOc9a4VQgStAoN0+4WMtMJWdAtylFKrRF/TmaZV4tSl1qsHpv0/e/x5fkllP4vssZZNPm75Pg29XItqzaoqQS/B05syTzUqi2D8+hyI7Qc+SeJOJ7ME+ZlKc0IGcPj3P40FVfj2yNaW6zLtjpd8RiufnoV5HJRiQBVQL0FvbEwm7xo3sjmF29UNLvme+YLNyQOtlNgQ3T6+dPun/Cr17Vz/Km31DJTG2u5Ruo6y49VjtZ/TJ6yEuoT1wQXziPG1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df9OM3ejA1mwKqDpBEbkVVub9rONWcJATp6SDhd1iWI=;
 b=VeHHi/Moh15HVWclo1H1Tnj2n2RRIbs6X5GmhT7eut0mF7MOscn7Djtg4hEB4q3NFnmSuLqS2cb7IqWUuhTC0SNH6y9ucSm+V2mPiseC5H3+RBT3NJdTmlZ6+KL4Zn1HY1Pbbt2LT3k41ciypHsPvRAT6cnDX1amubBrmxwbrLA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by PR3PR08MB5580.eurprd08.prod.outlook.com (2603:10a6:102:8c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:12:31 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 13:12:30 +0000
Date: Thu, 16 Nov 2023 13:12:16 +0000
From: "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jannh@google.com" <jannh@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZVYVMFnMnxhhwyiL@arm.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
X-ClientProxiedBy: LO2P265CA0120.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::36) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|PR3PR08MB5580:EE_|AMS1EPF00000043:EE_|DU0PR08MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f3abb3-5f4c-43ae-66ef-08dbe6a5b8ba
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 2uUUGBjMe2VQO51XbDtRxlgXLFqX++MoYQxdvc/RAztOlQfg4exuCf3y4hNF3bgfvlTh3MGTnDvWKNFVp9P2R8WcEy+wis+BYh+EPxrMqiqxVsqWFfXWsDSMyZQ6DxeXyaNt5Um3kxlQxc9PMnZJWskpRWeIs7Z5+/qQUGx5hnS5OvzBHJtX8FjB+XIFmuHyL8b/wYkDF/odgUvqpvU/big4gE9CpgQNxJFatla1i1wNgeoUH7KzeZ+tYnrvyUharcahFsySnOqGxNeGZrNwx8yGEVAVJZ/bvoM9v6dLHnqdiyDX0DWk0+nJ2okcHPnjb77Wbw2gsmOb3HXoR6pER56WMcAhWllefDObcvqP/Hh5ySeGLWrr7BY/jUxHjxdgcHLnisiYsHqPCTYS0W5xfL2T/NR8R9A3cgBIrv9zoB30Sg5EEAbB5iJqRyQ34ThCbhNHJA5POT0PKI6y+UmvcelcUhDmJUvtsZ9h593dT3JfIe0173tNvawbgqMKT3YkopXjeqNaDKffu86koQ0jtP9HPv4kKEeX7GyXGkaVbJc/86UOHYTZ4O7iqnDpW49M
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(4001150100001)(5660300002)(83380400001)(7416002)(2906002)(41300700001)(38100700002)(54906003)(6916009)(316002)(66946007)(66556008)(66476007)(6666004)(6512007)(6506007)(86362001)(6486002)(36756003)(478600001)(2616005)(26005)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5580
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5e1173fd-8086-4f62-f3f6-08dbe6a5b033
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WS8iciBD36CrFi+hS7hpj9HPLFISBXL1wEuY4JkTFTSFHZf5Jvlm9G/UazcJzDyZTsd+C9Jo4aRc/mejD2LllJexmVk27+5asYdaJo0vk/k7AP7/4GNShXoRhn2mvDdwJqBK6ZNCqEbiGna8ghOULWfbboWaX/7HLmyicJgCF+nG387mdNBTNgC1831EW279/KpplUGCGE7e1XdQm5qcM8cWXPjno4Ae/wAybdDKRodUKz9wja3aaz9lR2DDDuk6F+Tj0xqUybJQfN7ymKjX3pIuH6+sbr+HZeZ+zzZz+0Z0GRnaqnl0jK7Xk9tHsgxUTerxpDkBz/N9kEVSkDuTiVtsCL/+2qv011T1mNuufYdJuq4WWkOB7y1XPUxjcxRsmbs6PqC0s9H3tsQKVfenH5How0msRsw4TvLZV5UwaG3yTv+ugdeeQ6zuoe0VjbF2y5OOWuTPVRxGnClujSO+lE1CxEDLQaf+rqJcRPDBOVvegPBjx8vBFe9F1wTzd8+nKegNCYYhBwgFbZVxY9xZL+gYH7YSqzzDYZfwT84/v2nem5zJMfwIylsL1dwl6hU9VzDLLCXRWEue/NbO775Y7+BDy9wVgL++pnGI0sPCw9jZCfLWRKepzSNUH+HgH1pbjBrHLGzVY5LwUMknf8OKwgMDPITeOQGwbpf+z/P75gx1Yit3N/2KzWvQtc5ucRrpV4LIawOXAXXpmd66HAhkpQTa7wNkKWDC9qKt5zu/ISn9N+4z79ZL3PLiZ4FqzRIe
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(54906003)(316002)(336012)(2906002)(83380400001)(478600001)(5660300002)(8936002)(2616005)(4326008)(450100002)(6862004)(6512007)(8676002)(107886003)(26005)(4001150100001)(6666004)(6506007)(41300700001)(40480700001)(81166007)(47076005)(356005)(36860700001)(6486002)(82740400003)(86362001)(40460700003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:12:44.5179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f3abb3-5f4c-43ae-66ef-08dbe6a5b8ba
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7543

The 11/16/2023 12:33, Mark Brown wrote:
> On Thu, Nov 16, 2023 at 10:32:06AM +0000, Szabolcs.Nagy@arm.com wrote:
> > The 11/16/2023 00:52, Edgecombe, Rick P wrote:
> > > On Wed, 2023-11-15 at 18:43 +0000, Mark Brown wrote:
>
> > while CLONE_VFORK allows the child to use the parent shadow
> > stack (parent and child cannot execute at the same time and
> > the child wont return to frames created by the parent), we
> > want to enable precise size accounting of the shadow stack
> > so requesting a new shadow stack should work if new stack
> > is specified.
>
> > but stack=3D=3D0 can force shadow_stack_size=3D=3D0.
>
> > i guess the tricky case is stack!=3D0 && shadow_stack_size=3D=3D0:
> > the user may want a new shadow stack with default size logic,
> > or (with !CLONE_VM || CLONE_VFORK) wants to use the existing
> > shadow stack from the parent.
>
> If shadow_stack_size is 0 then we're into clone() behaviour and doing
> the default/implicit handling which is to do exactly what the above
> describes.

sounds good.

> > > What is the case for stack=3Dsp bit of the logic?
>
> > iirc it is not documented in the clone man page what stack=3D0
> > means and of course you don't want sp=3D=3D0 in the vfork child
> > so some targets sets stack to sp in vfork, others set it 0
> > and expect the kernel to do the right thing.
>
> The manual page explicitly says that not specifying a stack means to use
> the same stack area as the parent.

not for clone. clone3 yes.

> > this likely does not apply to clone3 where the size has to be
> > specified so maybe stack=3D=3Dsp does not need special treatment.
>
> You'd have to be jumping through hoops to manage to get the same stack
> pointer while explicitly specifying a stack with clone3() on
> architectures where the stack grows down.  I'm not sure there's a
> reasonable use case.

ok makes sense.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

