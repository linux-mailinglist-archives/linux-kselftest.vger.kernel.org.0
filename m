Return-Path: <linux-kselftest+bounces-220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39E7EE1FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C031280EE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09F30D1F;
	Thu, 16 Nov 2023 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wm3PyvFP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wm3PyvFP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2E8F;
	Thu, 16 Nov 2023 05:55:42 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=gu/PR9HDu4XGOuZ1P/tcas97OFpSbOxG95BXliUUqAAwNzVMgLMwb5OpCj74Vwyhkc4B+BW9ECzj10uxYabaWKBGok6eX7kbIcr1bZtAW1YFVd9fabx9UmZ9nsiyKZ60/gyJnTNd0b3oqyVXkWphK26HuochrOV7u0TFXiE8n3dgc3KdH0e7hPMAo1akj4Or4xPJrEGp7AR9i3G3f+fWrxuAeHFtMXTgw4+Z7UOYVwMV43gniISvVpFFmdQjOGlFz3wPkXGJeW9rj/A52wReyFjGCjUS34smeAIC9ekZSRRGY07z7g7E1sy3QKjmHQbljQpeICi18q+/+Wf8E96CUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8q11BZlrsjszekpJhSuaFOS8KTA8eOGEKhrCLtHbHo=;
 b=WPQV6pK1h4+uhJakSsMkCmY/h7Pn9aBONB2W3ML9oQAEDW4rVcCoacvpATwIVJzuHmDMy4pWbV0a67ntkQ79o7vZGYOsXuwVQHwjXOSdW9Mya7+DDQ4HGyw5xN2H2lAIci6MNoANkLJeyGrb9owu4EUMKFqMHVO1ibptH7PS21vHKHG2mIEvj6TspWUE+VuwOHJuf2RbEPmjXSnIZo73UBzQdj6gx8nd0aArrRs/uRIpykCLYuLW6I+Op/D4x78F0aXByd4+qJDE8stIGadcX4YSg4Yh5VvwyyijvmZ888gjLjmI71bEAPLNBxQ26IWl4mgEAcjlxxxsB/MQ5W6bZw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8q11BZlrsjszekpJhSuaFOS8KTA8eOGEKhrCLtHbHo=;
 b=wm3PyvFPgPgsPo9sJSnSgC0jPOPHKwejNFHnZMi0nFnRjulY9L91By3hyGzKYuwIFq4abuVWuQSd+F1vQchm0YXBlNlnTkv1Ri7WPS9f0MABUZtfa+7mL59ROe3JVAU9W9BnDX+3aD0rNN/4rjZqewfnRPtRvigW84cFrUM3ZbQ=
Received: from DUZP191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::11)
 by GV2PR08MB8439.eurprd08.prod.outlook.com (2603:10a6:150:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:55:35 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::5) by DUZP191CA0007.outlook.office365.com
 (2603:10a6:10:4f9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:55:35 +0000
Received: ("Tessian outbound 385ad2f98d71:v228"); Thu, 16 Nov 2023 13:55:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 889b594ecc5da411
X-CR-MTA-TID: 64aa7808
Received: from 358486624679.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id FD2CFE32-C980-446B-8E8E-6B00E0525F3F.1;
	Thu, 16 Nov 2023 13:55:26 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 358486624679.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 16 Nov 2023 13:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDFddSrF/IYyifrj/ucs+AG+lIheC7bDYVv9qol2Z45s7w5dfjBMKcrkj0Hcuqz9CRsvK7ug6fU/kM5YXWqU6tv6PKvudDSorgyb7r76g2Sx15iBQf2RuSKo0C5M4FCAouO6flu3qNfGnVdRNkXLG5RsbZyZjQpXQqqXYGc4LC9IDaiMcL3ZhjxNqDHHL1dvfozAvsDnRCBxrtuyFfcRysfpogn4bx8r/+mi1rq82uQOwLUrooiFA6qi88C33vNHCt5yb4GMXJQvsoup/gMOY8ICnacR+xcbWzDOjpJ5R9Xh0J2FwRTf09AWR0rsEXiI/qTf+hhHkZpgOUUS73Uxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8q11BZlrsjszekpJhSuaFOS8KTA8eOGEKhrCLtHbHo=;
 b=OqoUlrsRjFJuhBqsv9c5eiRA0kUQ8jf8xjKiQqbnQimi0vk8PY9QUK85IjNz2wrk8e+FPZlt5xKyiriWQxoqyCMleQBHWR2XEl4t/ZwE3lLpEvWbhcfF0AB2d0EY4N5wqsIOg4+GEqlaabgDcVvLkuSuCY391wddqUjYHkStH2SMa3Xg7TgzTxqN3/37hDSgrJh/X8zet2TDwkWfV+W38B67uZkRTJutpg7EkWsuwwXhh3atXOzQ9/yDyloLm8PQ71B/ASNLTVmo9fPA/1ZFoMdhrr4xFD9ocHEO9Kitz+5Op1je9ISq6EtD7agoqnJe+jux1Gdg3wM2KL2GV+vvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8q11BZlrsjszekpJhSuaFOS8KTA8eOGEKhrCLtHbHo=;
 b=wm3PyvFPgPgsPo9sJSnSgC0jPOPHKwejNFHnZMi0nFnRjulY9L91By3hyGzKYuwIFq4abuVWuQSd+F1vQchm0YXBlNlnTkv1Ri7WPS9f0MABUZtfa+7mL59ROe3JVAU9W9BnDX+3aD0rNN/4rjZqewfnRPtRvigW84cFrUM3ZbQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU0PR08MB9535.eurprd08.prod.outlook.com (2603:10a6:10:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.33; Thu, 16 Nov
 2023 13:55:21 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 13:55:21 +0000
Date: Thu, 16 Nov 2023 13:55:07 +0000
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
Message-ID: <ZVYfO/yqRtuRYaJA@arm.com>
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
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|DU0PR08MB9535:EE_|DB5PEPF00014B99:EE_|GV2PR08MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1bd66d-0a28-4651-d4b1-08dbe6abb4fb
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Pq9WGIESRnNcf0ButHEAaxPkehDUxSeVNhI1nTOPaMe8jQ8kuuAmrN3FJ+0c42Vl6cXrgqKzlMkPf0iaFN2HdFx/7dOriRQ/QLU2TdMpveXXZIq+AUX8gCaHj0E3suDIoKozARCEnB7mahYz1G916i79tH8mRDFHSh2uUROj43ItFsNn8pWLD2gjt+GRL+I6ODuNH8NvRjES6ALhxD6bXJqZVMNs1BSZeK9wBt2e6Dcwg0xhM70i/y8mNq45DQ1GHLx3a+kLf4SPqxAhfDkNZtvVJ3crFIDETgfzQ0LCKVLdgX6aOHXaq5d245fKEpBStHPmgDnjUXXgzPraiKxQ7XAFztwCsSx/cCgeAZPCwa3YGKHwW0HHK9Ce464OldFr0MChDLQPfqB86+UBF9mcsodAxUIY5D0r1QJ6qMMc09A1JHoX/ikqlZ8w0hKl7a9B9GNacF0GtkUcSrEDN5MASewG2xs4at1PrIfTGg501jpcEQ6pHwfdFYph5CIYuRu09sswoHXT2lJYB611i2UafB4+5kiLtTmEZtonoMj0BHoCdO89D6jyHjeqnx1W6c+m
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(26005)(8676002)(4326008)(8936002)(83380400001)(38100700002)(36756003)(2616005)(6506007)(86362001)(478600001)(2906002)(6486002)(6512007)(316002)(7416002)(6916009)(66946007)(66476007)(4744005)(54906003)(66556008)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9535
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	92dd55cc-75e1-4b88-1e55-08dbe6abac9c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N7GXYErQsHpvfEM3IcvQid63zQfiAyorumQJNcfTc+f3gQkYxE8MU2jKhuXkTsj3L55sgs+uaPj1aTFqdct6n6vA1mbJL2nHfXi6q8RZRud88As83jG+ZR0FCvcLW3qdYaiEMXwMWXbx1Z7gRsy4pJY65vhVxuaGgx3WG7mBLT1UCL9l5cksoHAJTGNSH57KpD3CPJgpuAsI6KK/CtQSv+Ro7XzkLxUGAyJ76uaNMN+2h97GkQqpbDU6AuNATJkj5b/QCa7DLTnuFsBh2HMDqLdCdbhHNr6Z0oT/RKVpXx1mzi71Yx463Yi7TL94ckhGFqy7VlkLuU0phzQEzsdXmjnftTVJAyw8XLDHkyiLsNBH79R1OPpfsIP1fLC1OnQ/SOagZK7s0Hy9DyuzVfD7KsuZIftpHlMXdVsudVxPQiDTEGL8QGAldalkFFldkZ4PiLrt3QKT5zEw+s/GfjOK63XL19sgeROTFwXhTHq32ZTjJOgrYddLAWcvXdpek3v79hGjq6A26TLJeXYKYomL25cKLC3RnvHiJh+NgerclSTiE3dqw5d7vIQcScwY+GN/TJsPZU1wNh/zXvu5r1eTJq99322kEZdjWZmqe7F1V5Z53Ci4uq2DypBQyI9TCgzzP9Oz6CkpHI4B0ZG2dhiRdveA+xMOBqwpryPhbz80hnc502TjUo9m/AdD2/zRXOvxDnN0Y3pJUUYuHOUVbAA2nFcNWkw8IR1oO8OVANKVc719SKLOUbEJTt62vhRBujNb
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(82740400003)(336012)(83380400001)(6512007)(26005)(6506007)(6666004)(2616005)(107886003)(316002)(54906003)(4326008)(70206006)(6862004)(8676002)(70586007)(450100002)(36756003)(8936002)(36860700001)(40480700001)(4744005)(2906002)(41300700001)(86362001)(5660300002)(81166007)(6486002)(356005)(47076005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:55:35.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1bd66d-0a28-4651-d4b1-08dbe6abb4fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8439

The 11/16/2023 12:33, Mark Brown wrote:
> On Thu, Nov 16, 2023 at 10:32:06AM +0000, Szabolcs.Nagy@arm.com wrote:
> > i guess the tricky case is stack!=3D0 && shadow_stack_size=3D=3D0:
> > the user may want a new shadow stack with default size logic,
> > or (with !CLONE_VM || CLONE_VFORK) wants to use the existing
> > shadow stack from the parent.
>
> If shadow_stack_size is 0 then we're into clone() behaviour and doing
> the default/implicit handling which is to do exactly what the above
> describes.

to be clear does clone with flags=3D=3DCLONE_VM|CLONE_VFORK always
use the parent shadow stack independently of the stack argument?
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

