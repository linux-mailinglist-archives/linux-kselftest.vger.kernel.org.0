Return-Path: <linux-kselftest+bounces-159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AAE7EC861
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62ADB20BB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9A639FF4;
	Wed, 15 Nov 2023 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8psW+JFG";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8psW+JFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76339FE5;
	Wed, 15 Nov 2023 16:20:51 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53447C7;
	Wed, 15 Nov 2023 08:20:50 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=UcDbsVdboOPfteM4lmP8YGJ3vlxayROHMO+imCCQNcsGb58HLW8rXvqaAGO5Wj2NGgwZf4iOJrb3pkhYdyv9+RtHhKSrAei3Lu4Y8TVPKX+wuBTuhfikW1jQfIxYTDXEDKkqMNMtuRXppWWPlkgNWnicjwKPwicI5ofv0O3W+KdsNGUMAQc/Xf3Iup8D0Ft1vBpuMYGBVW6yR/Dh3H88cUDdseUVEAuWLivU6uQ3iRQpEmWrFEn32Eg99t5/04CelOlTE2/NEvKzk2jJwRhkwPXpymk+bUleaSwv/OkfegM1O3YTgYHJd6FvTBE3x5XCm1OyO7Xh/LQs8zO3yaYJtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiYK4jRvubIkiBYVqtiETNUpH6WoYgg2cPQWww38wQM=;
 b=iceBU8ZtsuzlZyMav7rRRHn7n2dD6Xq3CVM0K3OhLGGo9sZNT7YueJwXoOwWxYG0Fjt16ONV1RxmQMdSHGVOPRTte10lgUTrlcP8U8hG2q2qbeS5C6x+QJLneSnmQWiqMOUzol7eKWkTlq2nRiWjSxZpr3pW02JMtOzhDzZ08mrgqruYePAeA8oqXIUhCZDFjSWCRdeMTrB/SGpnYuF2BFnJ9IwbsNUn0l4JlYRhQKpcAXG0GIE/j+9tIAVnYEqhh646r3Cak612Dp3bHm1J7HY+3OgTViYGUGvL4S54PNPQwwnSyYxexwuPaF1pttIbP6mhXs29xrLB4+n9x3QuOA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiYK4jRvubIkiBYVqtiETNUpH6WoYgg2cPQWww38wQM=;
 b=8psW+JFGYPrJW48q1UEv0S5FttC4jNssPWjK+/KRigCckc6l4+1TmwyBN3rMi+KrjwMAITnFwHndS+ZB2Td0DV/WnItiMLWq5WIgkkj+U392fkfFfEW+4t55kkTw3EjrSJIKxymEJweVkvV6F8/WFq0mxlgE6ibxQuimdEtA4qU=
Received: from AS9PR05CA0109.eurprd05.prod.outlook.com (2603:10a6:20b:498::13)
 by DU5PR08MB10701.eurprd08.prod.outlook.com (2603:10a6:10:517::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 16:20:45 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:498:cafe::37) by AS9PR05CA0109.outlook.office365.com
 (2603:10a6:20b:498::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 16:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 16:20:45 +0000
Received: ("Tessian outbound 26ee1d40577c:v228"); Wed, 15 Nov 2023 16:20:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9f2b2bcce476622a
X-CR-MTA-TID: 64aa7808
Received: from 4673a9bbefcb.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 05467DEE-9ADC-4667-AB50-8AB2C15B4B1B.1;
	Wed, 15 Nov 2023 16:20:34 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4673a9bbefcb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 15 Nov 2023 16:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRmw6YHjZfhfci9q/vTOqUBf0/bBswaGncAKEFyompnCgY1tmRv8kLYbnXwre7l8bzw5NA7Spn3VrA/1vz78eQWSDHzedi0IipTTNlxV5OrGtGYtRoLqnUla8eM4c31Ev5oE27bDv4jbWmAlwW0xg9p2ae/1Mc2y7g+IpYb2lAaHZVPz8Cej3XlPGCh6S9qilpICG8WY8G/KbVyUHjf8K3Pv9GyV475XykQGJlxeWX9tlmA5IJyOiyTekJISfpZ9WTgMZnEhvCkrLZjJVBu3A0xd5ecaPkdjH0TaTkNLCObGXcUwnJlrRfsc7F1+h9HSuvzsplQ+C4YCAYO7ae10Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiYK4jRvubIkiBYVqtiETNUpH6WoYgg2cPQWww38wQM=;
 b=ZVI++wzn1ija3QzwGgej13w5oeuNCp3wpaBQKpIMKxHXiwDCF5vWlO7xrv1RLC5I57lXRfAUTpfjICh/JZC2800QrOZ7kS5Lcg9TkyGR6XZSMw6Af+hbjzdgSGXPJKJV7CwhYQnpVizJjsZjpqWwBlRtY63akIzOaN+pjKlavBkY8PGcO7anFMPmqJ7TDmLPr/S+aifbbJB7KZaJ7PBU7ynPRk3mhWMmRZCoWFVT5TiVA4mm/mkzKR4xewiQONCRQoWZZbjbDaJ9/OYRCbd4QJRblsWzAefYPS7FnvakuEmHOB8lWM7/a90rDTmlhRjhpf5zghccG2WA7HbEN865uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiYK4jRvubIkiBYVqtiETNUpH6WoYgg2cPQWww38wQM=;
 b=8psW+JFGYPrJW48q1UEv0S5FttC4jNssPWjK+/KRigCckc6l4+1TmwyBN3rMi+KrjwMAITnFwHndS+ZB2Td0DV/WnItiMLWq5WIgkkj+U392fkfFfEW+4t55kkTw3EjrSJIKxymEJweVkvV6F8/WFq0mxlgE6ibxQuimdEtA4qU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB6648.eurprd08.prod.outlook.com (2603:10a6:20b:39f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 16:20:28 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381%6]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 16:20:28 +0000
Date: Wed, 15 Nov 2023 16:20:12 +0000
From: "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
To: Mark Brown <broonie@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZVTvvJTOV777UGsP@arm.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0140.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::19) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|AS8PR08MB6648:EE_|AMS0EPF000001AA:EE_|DU5PR08MB10701:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9950ef-0510-42e0-09df-08dbe5f6d22a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 8xZq+tzXL3sB6zfisxHBeNTQ3rK+30gEw3Ygk3CNPXMBDoGE2tuKfZBmZfxiy8JUDr3Z48NBh7BKXjtrg2D6ceFokN5M6QkfJl6Laeiro7TD2/lpNEDblYzrpKnLBmasbcIckOyyq57KPNeHVJBw5Mu4iaXrUu0/7HuDlXDdU/dg7lck6rke2UMvNgfIRpphPL6KRNLmz2+16v+KwR7YIuz80kJWZJz8iTFAj1wQw7L3qMuELIfx/wffzVRHKuM1TDYTnAFHc19fWu3z3j8+21W5l+mPo7+FQkrgDS3BRHJxnILa2ZemJLXvwDzdZMZ7BS+Oi83NOLnNr5C76ihtVBW0LCpWCDUXfgnsVszCbKEc6P+0l1m2Ina2r69rl+qA0IQ576D3wpWkzYn2D7HXPksplhnnQI1PKHz0OzaYCRD3ibtTzU1u9NwQAqVOym4N//+YviiiseYOEMn2bcrE726klapDM1Ye56oaW0uo8Ej0Sxsr6gnAL/UcunXQQ3rFKdDSABhpOHEh3R6BjSVqC6Vc6wiX7cqWVbSxx7otwploCJIw1lAVVXFPWfZhIVUn
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(86362001)(6666004)(2616005)(6506007)(26005)(6512007)(4001150100001)(110136005)(66946007)(316002)(54906003)(66556008)(66476007)(478600001)(6486002)(2906002)(8676002)(4326008)(36756003)(5660300002)(41300700001)(38100700002)(8936002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6648
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a0015104-8fc7-4f7b-949a-08dbe5f6c7c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApopCXhw5JHIPTZxOel+N/cnpHgxvo4xq4e64TNks+XH8x8eqL0wByLPYnoimnHaybgddUZKoSd8WpBbZlqKvjlLloFvoXdWPObzkJm00fU/0cQtBV479ngiqTGyG1yjYBwVzp+FxIouDVvSIDoCJ5p2c4owx4hXTObEBAgB2JYJEkdRv1CqZ6dgLlwQWBj9CJzSdKNOfG/vApt7ivcPiZdIeXRFa6EKWHjf/l9Gk0G7G7ehb/MmFcR0wJsawKO53bw+shFhSYTfCwjNZhkVd88e1ZeNy0HDDuVJDB1ZbqPc52EVLUdfJWEsEa5lXeazWzABRAFTTjEAq2CEIFBuikbibBkdIg709dzOKwx7lxGX+dIgG1sm4G9POEOaLFM4N7GD1AhOQG69he1FivEpo2r0g3tWhN1U75/Iw2x2zKUXJ3x/1XGkCh/GUlKlyyzMn8DAe5RE3NJbr2G0pF9q2pKX31Bjc4NvctmzxW9C0bW+0ji6YB21PRg6hcVV7/NWEyrzaEpT2iSxAjKK6EEYHAYftaCQdelZIfDamMTmve4s3Yib00hTBj5y/qKdrG3a71+r3MRby8VEnTjXCDcrrRgQ76Qynvu3Ub5OCN+nDAQgKf0A68F6VouMFZY2wHfdZlVbOSDZUP7w8wP1BEJU22ELbTvp2fnTnyvEBJb5kfQrynOrxnusaXJtTO6YdZXngwxCyXndvc077pJHCPkE1cbM5DbH5viVvBaoMgxPpnipWsQiwpynjcOqiy2O5PBP
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(356005)(82740400003)(40460700003)(81166007)(41300700001)(6512007)(6666004)(47076005)(6506007)(107886003)(83380400001)(26005)(36860700001)(336012)(2616005)(8676002)(8936002)(4326008)(2906002)(36756003)(86362001)(450100002)(5660300002)(316002)(110136005)(54906003)(70586007)(70206006)(40480700001)(6486002)(4001150100001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:20:45.2493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9950ef-0510-42e0-09df-08dbe5f6d22a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10701

The 11/15/2023 12:36, Mark Brown wrote:
> On Wed, Nov 15, 2023 at 12:45:45AM +0000, Edgecombe, Rick P wrote:
> > On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:
>
> > > +               if (size < 8)
> > > +                       return (unsigned long)ERR_PTR(-EINVAL);
>
> > What is the intention here? The check in map_shadow_stack is to leave
> > space for the token, but here there is no token.
>
> It was to ensure that there is sufficient space for at least one entry
> on the stack.

end marker token (0) needs it i guess.

otherwise 0 size would be fine: the child may not execute
a call instruction at all.

> > I think for CLONE_VM we should not require a non-zero size. Speaking of
> > CLONE_VM we should probably be clear on what the expected behavior is
> > for situations when a new shadow stack is not usually allocated.
> > !CLONE_VM || CLONE_VFORK will use the existing shadow stack. Should we
> > require shadow_stack_size be zero in this case, or just ignore it? I'd
> > lean towards requiring it to be zero so userspace doesn't pass garbage
> > in that we have to accommodate later. What we could possibly need to do
> > around that though, I'm not sure. What do you think?
>
> Yes, requiring it to be zero in that case makes sense I think.

i think the condition is "no specified separate stack for
the child (stack=3D=3D0 || stack=3D=3Dsp)".

CLONE_VFORK does not imply that the existing stack will be
used (a stack for the child can be specified, i think both
glibc and musl do this in posix_spawn).

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

