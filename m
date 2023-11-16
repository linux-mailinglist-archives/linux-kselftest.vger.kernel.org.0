Return-Path: <linux-kselftest+bounces-208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846057EDE8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FDC1C2084E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6094EDF;
	Thu, 16 Nov 2023 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RXGCZ9w1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RXGCZ9w1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8927D1;
	Thu, 16 Nov 2023 02:33:06 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=RROQjGukOFIbemG3I7xqX5o8ZU5mQVEfpacmQRmmQyuWkCfLhgUxLqXfQkgsBhxQs93RZHcsSmruUU3/FreISnb9rgc1Df46iJxHLdhMXXkm/TCPyBXWu2Tuv8rT5mLhGYLF4qpF0Y5osb1CYFglG0gImnwQWmxJPLC/wpCEjxkuJmgkBClwK+sTkusagXsWGGidX+r9DtgGr8/4FX9Ad+++Hs8gV7zuOuYL4s40U4x0vE/02xtpWqoG8IkVb2lad9K3679jYYjS73O4Uw5mT0ZWjofRgZGAnUXJ9m0ae8hodlFMjfVi8dmYdqzwbgJ5/id5R+1UfIjnoWyGpHL+lg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbrMNL3S7LD0u5dK3WpPXMOER5TK4GcZ7V6mUOgPf74=;
 b=JRhIzLyHu4aS10bl1R4ALgzsLbEZkyXO+uRUo50QoaJKndVc2FYDBSI7DqP6vvWES2sCLqU96MgEVgtI+8o0L8g99tXxPdX6xqF57+GczYVB7G7cJNYLWs/T0uUF/fwheR3CAPAwfUTqafSX5T3AlZePERIypBb/p+18L5ItwX2Fmh7Hica1GNoxRhw2LhIr07SDxZwdm9TWW5PKKOAzVlKnUMqhcmrq/3uKGzCFBloalqKouyBgJdz9ta2XOo5unVfp09Eh9P9vfvSyKnwcLemoYAJJNe0qKSTPquLdjSBvPV8Zqjoend6atMNhSTKoYg+cSxNV2P46240RRn3UnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbrMNL3S7LD0u5dK3WpPXMOER5TK4GcZ7V6mUOgPf74=;
 b=RXGCZ9w1bgQlP58HxhjiUekC9SYzy0ojZA57T3Y40NqxUlZTm3XwIzsuuAsn0Su4SgYCDlw4nthix76C5x/4QHFc7A5mSo2h4J3bNstX4a4eO5MSh2gev201bvbmbWaK+elXnBsuEfuQtkaGv650O3qY8uKemUMyb5E5ronV7j4=
Received: from AM0PR06CA0084.eurprd06.prod.outlook.com (2603:10a6:208:fa::25)
 by AM8PR08MB6339.eurprd08.prod.outlook.com (2603:10a6:20b:317::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 10:32:39 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:208:fa:cafe::9b) by AM0PR06CA0084.outlook.office365.com
 (2603:10a6:208:fa::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Thu, 16 Nov 2023 10:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.7 via Frontend Transport; Thu, 16 Nov 2023 10:32:39 +0000
Received: ("Tessian outbound 26ee1d40577c:v228"); Thu, 16 Nov 2023 10:32:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6d7c5cae284988e5
X-CR-MTA-TID: 64aa7808
Received: from 142433fb9a9d.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2579CE8E-7363-45DA-B771-8266EAEACBAB.1;
	Thu, 16 Nov 2023 10:32:26 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 142433fb9a9d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 16 Nov 2023 10:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fg/prPLCVbKbNZow7bu8XkuBfPrRlptjgtQufqWGnP6H46hh0RSpiH+CvnD4QEIsF6H9py1HILAnei82AXl+/TJt1XhDGyfvVWReDFUb7XAE71ZwT/02tNdM+O12rJEYAqtpRD8GDREwm6bv4LkuG6p8GGNHtNQ7AsSj77GFN/c+NjstMHExYGVnliuKwIYJsYDsR1IKyDcT/xuI+1PRts6u8LPz/Hiw7oqlJK0H5JHw/N1lhSnLdH2KUHzsLLbSdqfZlwoyUmSmz6tItXsRJG1EABdNyLWBXxLe1NTC91TjfXAt1Yzn0I47CJvaQZjAIAzmWJJMqvBXNvnUrHjD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbrMNL3S7LD0u5dK3WpPXMOER5TK4GcZ7V6mUOgPf74=;
 b=flDCdtdEVY7SBH4NB4VfoMdCEAk6XsLDlvmHgxm1XDdFGTayL8KKdRXBlXTNd2ZyNT0qT3uoMF/JTQL5TbG6Vn4JVtEpZ7ZJHWMUpVcKmakABZAhPaq+LyYpQFXdBxl5zNtSniTc0l5KoCs+b/Snc94FmRKGbcUn7xNT06A/K0HpabmFKdpSuSjLjXc711UIXCWB9G4zpck+QoNkdQgly3yxBoA8hQTXW8/6Q6vcd2cLyFE8WBNzhgwaphrxNlx79k6qsrQ9ohXXBx6MrbzRdeTRCB7Tn+PIVfk6e6wSUDJg5snuIgMIrcIq/34ckFQcPSj32Up3FQkQgOjCf1e2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbrMNL3S7LD0u5dK3WpPXMOER5TK4GcZ7V6mUOgPf74=;
 b=RXGCZ9w1bgQlP58HxhjiUekC9SYzy0ojZA57T3Y40NqxUlZTm3XwIzsuuAsn0Su4SgYCDlw4nthix76C5x/4QHFc7A5mSo2h4J3bNstX4a4eO5MSh2gev201bvbmbWaK+elXnBsuEfuQtkaGv650O3qY8uKemUMyb5E5ronV7j4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 10:32:22 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 10:32:22 +0000
Date: Thu, 16 Nov 2023 10:32:06 +0000
From: "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
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
Message-ID: <ZVXvptSmmJ6MQ0dY@arm.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|VI1PR08MB10218:EE_|AM4PEPF00025F99:EE_|AM8PR08MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7682a7-25ba-4e27-3383-08dbe68f5b7f
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 NDwxSKiXam/ENoKdpLBraEFsydZwJnXWfzBqsNM91LuDs9Aw5ScJI6C/lAZtEUzLKDKIPoNGQD6WuFZWQxS3CnR3gTmLR/XjJMQanO6Ogc759HhejOjPFT2ea8hjN4vt4+bJ8XmuJxyOmMd0XUiT/UtK9QXHa8ZEppVGEdQvfo2NeUsY+nThaP2J1+Gh2a0dXPysZdt0ZRTM5oZAikgTnugab38nf1uLvbCXVi7xH8+B/zluDwNJDhWrcxyi53cBzW1V8PuQUxC8c8cjSaYS/o8GyZD4ss54Mj7cT9ewORB1jl+et0dP1V2RdUn4U89pGkFzoMMQTr+UFe3WTOJCn5g6oox1Dv0AZWeMACV01Rbx4oIZHcOLHApkcD5pN0FOL/UIgLnFti2FrcSO0s55B3bpM71J8uSwE5Ge1gGxRN6XaaILBnmk+RwpnegpAwmhDB69TeeIbNQUTPg/GB9I47XVqFGNaC9NNhFgo29azMdjOmDFta5+CbzTlup4yrHKFnT6gzjNZdTprSESomE0S/rFRDSlGejdnsWuSwBkCf7cgNCTnv+g0ivbI101lih0
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(366004)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(41300700001)(4001150100001)(316002)(66556008)(54906003)(66476007)(36756003)(8936002)(8676002)(110136005)(66946007)(4326008)(38100700002)(478600001)(5660300002)(86362001)(7416002)(6486002)(83380400001)(26005)(6512007)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b3c7e473-4b26-4ffc-ca98-08dbe68f5136
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sSsaZE2P2xPSuEGKfmGqGuYs5EDeQwWZrb7VYRGAS5XEvcyBfsPsavQ0hSDIj5dZb7M+rpYJQT3Q8dk9b0q9nP5jS0o1iK2EcePRU4S0umeQFb2UQEtQLD2EPNp/HJVvcaehEa3GlEIGBj2R/U82efEJ/1C7X307w9rcbFumHXrdmEICWC4J1lYH7y6E4NSC7DoQIiWOnLOhYq46KiApkzd5hfELeImDhdFywPQk5f7ATE28IqH70DLXBDZ4187q6A033Izvw3TfGEEv3jwDMZAPY6gK569bYDS5iCtGpaYioN4xiWVOc8vA8pmlumAx6A170Wt3rA0ebGi4lgSslEWwBBDA7H7LMrfK0PLE9EYeO8L8KtLlWdFrD/FAgg5B2p4ZXuNBSjIvuyfYIyQsKogVhlq3S7JLtgSCT2htiLCdsjBaYnotypGAkoFria+g50f4Frdrn1WhRlLVHR9zXMxSxzD2trM1F7l7uwDfK+uNGlMomcd8eu9jIVapeKZLtYbSAZ5ngmUWsAm7QbKQL3Ccq5k5u0n6PAK6avuEpWgYqD8X6ET1LEpo5rkZw2cZU5b/q74dwo/dcia6rvxDVNjHmV3W9WYjp/+OVo3FA8ZMvu8vU7xxdsFYs8mcEp9Ww9AosBgD+o5HncHYc2g7/tytt4DM5jQcbtrw7abDCQHj1Nwbz1uEqyGAXWCG6JCfuTQGbYIfylpxl574ZFGtpfF9ufZOIBlPu9DLBcFUDaCqqLJcX9cKaOuxLosm+c09
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(82740400003)(4001150100001)(2906002)(81166007)(356005)(86362001)(36860700001)(47076005)(5660300002)(40480700001)(4326008)(8676002)(8936002)(83380400001)(450100002)(41300700001)(2616005)(336012)(316002)(36756003)(110136005)(70206006)(54906003)(6512007)(70586007)(26005)(107886003)(40460700003)(6506007)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:32:39.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7682a7-25ba-4e27-3383-08dbe68f5b7f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6339

The 11/16/2023 00:52, Edgecombe, Rick P wrote:
> On Wed, 2023-11-15 at 18:43 +0000, Mark Brown wrote:
> >
> > > otherwise 0 size would be fine: the child may not execute
> > > a call instruction at all.
>
> It seems like a special case. Where should the SSP be for the new
> thread?

yes it is likely not an interesting case in practice so < 8
can be an error i think.

> > > > > I think for CLONE_VM we should not require a non-zero size.
> > > > > Speaking of
> > > > > CLONE_VM we should probably be clear on what the expected
> > > > > behavior is
> > > > > for situations when a new shadow stack is not usually
> > > > > allocated.
> > > > > !CLONE_VM || CLONE_VFORK will use the existing shadow stack.
> > > > > Should we
> > > > > require shadow_stack_size be zero in this case, or just ignore
> > > > > it? I'd
> > > > > lean towards requiring it to be zero so userspace doesn't pass
> > > > > garbage
> > > > > in that we have to accommodate later. What we could possibly
> > > > > need to do
> > > > > around that though, I'm not sure. What do you think?
> >
> > > > Yes, requiring it to be zero in that case makes sense I think.
> >
> > > i think the condition is "no specified separate stack for
> > > the child (stack=3D=3D0 || stack=3D=3Dsp)".
> >
> > > CLONE_VFORK does not imply that the existing stack will be
> > > used (a stack for the child can be specified, i think both
> > > glibc and musl do this in posix_spawn).
> >
> > That also works as a check I think, though it requires the arch to
> > check
> > for the stack=3D=3Dsp case - I hadn't been aware of the posix_spawn()
> > usage,
> > the above checks Rick suggested just follow the handling for implicit
> > allocation we have currently.
>
> I didn't realize it was passing its own stack either. I guess the
> reason is to avoid stack overflows. But none of the specific reasons
> listed in the comments seem to applicable to shadow stacks.

while CLONE_VFORK allows the child to use the parent shadow
stack (parent and child cannot execute at the same time and
the child wont return to frames created by the parent), we
want to enable precise size accounting of the shadow stack
so requesting a new shadow stack should work if new stack
is specified.

but stack=3D=3D0 can force shadow_stack_size=3D=3D0.

i guess the tricky case is stack!=3D0 && shadow_stack_size=3D=3D0:
the user may want a new shadow stack with default size logic,
or (with !CLONE_VM || CLONE_VFORK) wants to use the existing
shadow stack from the parent.

>
> What is the case for stack=3Dsp bit of the logic?

iirc it is not documented in the clone man page what stack=3D0
means and of course you don't want sp=3D=3D0 in the vfork child
so some targets sets stack to sp in vfork, others set it 0
and expect the kernel to do the right thing.

this likely does not apply to clone3 where the size has to be
specified so maybe stack=3D=3Dsp does not need special treatment.

> I need to look into this more. My first thought is, passing in a stack
> doesn't absolutely mean they want a new shadow stack allocated either.
> We are changing one heuristic, for another.

yes.

> The other thought is, the new behavior in the !CLONE_VM case doesn't
> seem optimal. fork has ->stack=3D=3D0. Then we would be allocating a stac=
k
> in only the child's MM and changing the SSP there, and for what reason?
> So I don't think we should fully move away from taking hints from the
> CLONE flags.

only stack!=3D0 case is tricky. stack=3D=3D0 means existing shadow stack.

>
> Maybe an alternate could just be to lose the CLONE_VFORK specific stack
> sharing logic. CLONE_VM always gets a new shadow stack. I don't think
> it would disturb userspace functionally, but just involves more
> mapping/unmapping.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

