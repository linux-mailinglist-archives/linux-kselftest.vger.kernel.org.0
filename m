Return-Path: <linux-kselftest+bounces-22625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F069DEAD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C325B232F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606F14884D;
	Fri, 29 Nov 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WfX/NXzG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WfX/NXzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D845BEC;
	Fri, 29 Nov 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897138; cv=fail; b=h9HHOUFpbpOEhqdHe4jGEyBllqFUOg6o1QnOrlGeRKD65Dco6UdjILCqrwXlo9R4R0hwX0iUaSxsNwMntdwL06+f5DwbN3RjRF8+V17WW8+Bm9KXP0OgCS9EH8YJwToOzCFRyOzZjkwzHXECcsR6WF1Faq4EebureoizI3sMbkw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897138; c=relaxed/simple;
	bh=Gg4uMFPu6XbFkpHGws2oR+5VcdC9c7H/nE6jG1e0HRg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFuHvlpjpHE9gofCsJ1cJchl+BP0+N4Ng7JcjD31oIzX4DggTqZNJ4kH3BB2iXyNj6QrN9+Wk3uTeqgw+ca9MG37DHAgNdMtv1x1mKLhwB3NA5K/mkT+4gaPVxNNvm52mPkmlIRGUHPu7ZEA8uOFOic57raATZggR9E9MoO/3sE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WfX/NXzG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WfX/NXzG; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IOgITCqrG2EMurb/aPP85+LJGDKnZYwXuMcH2Epx6ohK7fDJIsHUWZoLWnCl5XL5a0uRkvsTk47T97C39pz1a7qw6wyTP5ya4ZyA05IUnnblvZSpPx9fG0ELt67NNZL/3k6st8JjEXH6PLNz/Z6ZzJO25hM0O7qmtkqQPFMQO22b39hlYUh8ENBIAjqAmc3dzqVZQov3iVua7UYvS0nB7bOEO9tVY8HI4w5GRg61ILNhie4MV03Ek1bOzz030Vcw5G5Hf1ZwTUU35BBI0BqO8v9hWuxnvSfclVkygXXhtWcESiTCndfGkadL9/mjakwgcRA5+l8NlgbjZoVcYyI7+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+G/HHSOWDZOjKgsIgO30Wg57cs7WBndU7FDY7JL5h0=;
 b=NMHkYdxxhazTWWmfnE+w1xQF1WNPl0hQBAdlEwiTCrai3+UcVDntieHsAycnhDsQ9Zip+4+7UmFTUGSuvbbl+yaAIJsoUpEFHnM2vU9/FGweJpXipc2Zcmdatz2cF++OEFOsRFrgpotIlPJO6fPDze0mMgO8qjVnhGKDaa0pS1Z1kta3yaL7L6UidZRS+cPR3TpLvmnDMdgeVk/b4heSB0JBlLcZeaRlpJJ4nk4lBPI4KEDbGzcF/XnM6bpd648h7qoIGyDmOCCQFckyeFYgN2xsF3ee4Sj1vlhdBRh6hkE7DBj/xw7DUwWhgPsST7Be7BXW0dWbfmTbZWqkruNllA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+G/HHSOWDZOjKgsIgO30Wg57cs7WBndU7FDY7JL5h0=;
 b=WfX/NXzG5bbI6ASQ32UhigPtkfmSb+QzcBQnRtC9eVx9brGhZOBq1gnF0b2Gxxxa/9KDihuzXxJDpJ2NEtQVxksSHiKM4atNtyasIxkbKlYzdIJNhzcXXOk0AdOzv6y+etnTv52gbq7JfapBjPdkx+TagK6JzTZhB51vX/DHWqQ=
Received: from DU6P191CA0068.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::20)
 by PR3PR08MB5835.eurprd08.prod.outlook.com (2603:10a6:102:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 16:18:48 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::1a) by DU6P191CA0068.outlook.office365.com
 (2603:10a6:10:53e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Fri,
 29 Nov 2024 16:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Fri, 29 Nov 2024 16:18:48 +0000
Received: ("Tessian outbound 75f654e2c9bc:v514"); Fri, 29 Nov 2024 16:18:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b09bc1ed0c3c6ce6
X-TessianGatewayMetadata: eVPoI0TvzgMM9CQs+1J5csvAv3hLCbDtsbPxf9S4HSciQun1FHOjOTycuckwFD6drE8ZekZQxt68LWrnPnSp7/kp1SALoBpVTQjpB1kzBcqMFLuTGopdlp1hzwqHnlzjccadrFcbSBGCMMd/kR1+JA==
X-CR-MTA-TID: 64aa7808
Received: from L5096d9e6bb0e.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 511CAB71-AAA1-44D6-BE99-49FC093BEE6D.1;
	Fri, 29 Nov 2024 16:18:40 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L5096d9e6bb0e.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 29 Nov 2024 16:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVkEx4nr7UZ/6UIiyPXpEevnr48gZrjdf7x4JZ4s4/bUiERGAD04UlhmsRLvhmsJpvup3gMCgdPvypKyM9fmOyB1zPjtHfKI5AlawdthP48GPSu4diwDdNAss7TI8QAv/Z3oAC2fi6sr74FnaKgAzUdAx92jc9Ycn3Quq2eg6B/IflLg3REX/16PpaJcf7+kArsRs+AOWQFn3/yJFQKX7rraDHcv6faSEZ/lCN/NvQAUk30SLEI7BS5+AQDvuIXO8Ije3mc3ktOYC5A16ZMuqm4HoJC7QqoUMEA00VU3/iSpfNDYwh8RJatx1xNvqIP5rK6qFgJyj70pxbBFQEOM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+G/HHSOWDZOjKgsIgO30Wg57cs7WBndU7FDY7JL5h0=;
 b=qOR/QbfTChsKF3IZRP6JSFfILYZNW+FUNTHgfhAqANB5/NgNp/OeHUitvzyAUE67Ge6WiJU9rjrlBQOxibQKtqTHX3+duUTBBrqmgqbmoY9Q5MKo6EjyTwqLxOM/m6LcLHP7pvsa55GwMmuO+P0VgNRjHIr90NgSZDMVRABAQpUchPsQGBM3X1kYUi4izqYIF2NJoeOIgWL8DvSfRpFQMZdqbH0xZgv5PyXkP/WV0hL+SUROgC/Uf20uaPFWNBFUXmi1X5zabwf1rQWmCro07bt7xQTgoHltmwsTmYubXRJqvqbpIPc8nu7mgvnvSkHjWOjaQELWEc+pRY+tamYd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+G/HHSOWDZOjKgsIgO30Wg57cs7WBndU7FDY7JL5h0=;
 b=WfX/NXzG5bbI6ASQ32UhigPtkfmSb+QzcBQnRtC9eVx9brGhZOBq1gnF0b2Gxxxa/9KDihuzXxJDpJ2NEtQVxksSHiKM4atNtyasIxkbKlYzdIJNhzcXXOk0AdOzv6y+etnTv52gbq7JfapBjPdkx+TagK6JzTZhB51vX/DHWqQ=
Received: from DB7PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:10:52::15)
 by GV1PR08MB7804.eurprd08.prod.outlook.com (2603:10a6:150:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Fri, 29 Nov
 2024 16:18:35 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::b2) by DB7PR02CA0002.outlook.office365.com
 (2603:10a6:10:52::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.17 via Frontend Transport; Fri,
 29 Nov 2024 16:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 16:18:35 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 16:18:28 +0000
Received: from arm.com (10.1.35.24) by mail.arm.com (10.251.24.32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Nov 2024 16:18:27 +0000
Date: Fri, 29 Nov 2024 16:18:26 +0000
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Mark Brown <broonie@kernel.org>
CC: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
	<debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu"
	<hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, <jannh@google.com>, Wilco Dijkstra
	<wilco.dijkstra@arm.com>, <linux-kselftest@vger.kernel.org>,
	<linux-api@vger.kernel.org>, Kees Cook <kees@kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH RFT v12 2/8] Documentation: userspace-api: Add shadow
 stack API documentation
Message-ID: <Z0npUmlaTNVkvmkd@arm.com>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
 <20241031-clone3-shadow-stack-v12-2-7183eb8bee17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031-clone3-shadow-stack-v12-2-7183eb8bee17@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB1PEPF000509E4:EE_|GV1PR08MB7804:EE_|DB1PEPF00039233:EE_|PR3PR08MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f40e6c-9e5c-4963-07c8-08dd10918193
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?FiKmlUabv2kgtty66mR9N1JEAyUfpgpTNWpmXlX4lcCHXcziqIgtDb1FN5he?=
 =?us-ascii?Q?rIqT4P5tKIcuV1ddxqx3h/iPrYbMsqgRlx7B2ybxWnW9N+io+TjRwC4y9o6u?=
 =?us-ascii?Q?FosSJ1ZFN8Dyt8lLwrA/htarrNd6oDYUavV2UbTFNl+1IYWpduSl71wCXnTg?=
 =?us-ascii?Q?sjIWM0OJF7druoGeV+W18N4fUrlNXkJ34nZVWO6V30RzWi3Ng3Y32hw+QsF4?=
 =?us-ascii?Q?PbfQTcwDR6PpVWM0RHN6+tVODpi+EvYeIAz347eJootGKZR5qvzepe8tbG7R?=
 =?us-ascii?Q?Qt+59aT8s7TRrxA34ZV00JVlaS4Bie/2FUg7yVHXxfEsflzj2GJeJPywuNbC?=
 =?us-ascii?Q?XLCZ7CCzxW86w6pGttqOG3nMzMOD5V4M6NqMWe7FAYzjXhO1amtVzaj1NBTM?=
 =?us-ascii?Q?1aB8Cqfwfx+euig/e9AAKR87JjnkMuyoryj8Z10zNOeLnQgDEpuizCYMSn3B?=
 =?us-ascii?Q?gBuAPUSA3DFHbUIOiMMin68+iYjBH0XoQOwgtkHIZJjsScWpFceG/qg3TrC2?=
 =?us-ascii?Q?JWYoskGhiVAkXGafZxNrDbLbNvGSuMyBQNNlOWcwG0ruhDffPpU9UgaqF/CZ?=
 =?us-ascii?Q?jXzIlLyE51pdWwhGscMY+82Bl+frj4wYhh5vVYK+RxUiW/Wq8hPMDiS/RUdy?=
 =?us-ascii?Q?DcnittjPecGId7Kw9YblCOFpWqUakGZrNGF+e9E5m9ObPNzkMiqxFH6WtLLS?=
 =?us-ascii?Q?wdNNxWAO0wDnHWl/Rdz37YddFljMgdpsrgM2KUxsZLxgJbf3k7oP57uOmdd5?=
 =?us-ascii?Q?/hIhISVjnuZWkOgo8OA6XJY0p2hPpYx0R20gN6+DpNoQFtQ/aIwFFjOkYGAT?=
 =?us-ascii?Q?zZ1qSEEj/9veWfhvRvxfL5EKARXdbs1soDLAD3HzE6Pya2H0mnLOfG4T7YhG?=
 =?us-ascii?Q?gs1+V4bvthtdJZWNxiru2YcYPcBBC/i/+NKS2JeJoiHHIb+gbtcsbQggoWmv?=
 =?us-ascii?Q?r9Eb4eIyEw6biShqxgfiy+7mpKunKn9fdn5su4paPdnoycSBBkscWXZpX1k9?=
 =?us-ascii?Q?KoSGs9lkbuusxcbtrqcruR/bofK1sqPB9KlRXiuve8FVTrABRAI6OFeUN0ct?=
 =?us-ascii?Q?PIyDhp0eQlMKddNWrOdyveQCdpwXR5VqLOeYd+bdax/9jH82VyW8sOoWroBf?=
 =?us-ascii?Q?emnTtvvLDH0v8uedpIWc3/7viG2UsuB8g7AyS6094PHbOqobFUnPEOfUN2nU?=
 =?us-ascii?Q?8srrkIFPkOwuDjzkLBKzGjqiUAtwk3lMKaXE1cTPeQSGCa6S2EN9CO+1MvwC?=
 =?us-ascii?Q?WxpClXuCJt7kFFERsIp8qicSCIOJJ0uwpc5VESeY2tL+Ug9VLosKCEbPqu2W?=
 =?us-ascii?Q?NaECg/7gPa+im20M+KWzBGuNG0W5otNlRQk4RwT53SyRXgfVZE8uasU0RoKn?=
 =?us-ascii?Q?AIeaEEmsTOU1c2t0yUVo6LuZwMJz5DLAk1R4gTDyvVvahKWckRXElGG3GgHH?=
 =?us-ascii?Q?RLbIS/3ZSni3THAVXa3Q2H8CAtQE7fF4?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7804
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:52::15];domain=DB7PR02CA0002.eurprd02.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	71128d2f-40ee-4755-3e03-08dd109179d0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|82310400026|36860700013|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOBdkFlOczIjvM9OOPPPq+22CyJ9xk2CE0soC6urPftXI/ZVM6V1F1ykEo2f?=
 =?us-ascii?Q?MY40Tt7vgQpzDTIyYpNuHwyTbZ34Xt+a+7QrX7l0kX6hD3oKYsx561srhmmg?=
 =?us-ascii?Q?+3htU0IE5nG7rDXg/DJxApsqExCB08d0RWfEnkaLVEF6MmxphPDSbVWeCUPi?=
 =?us-ascii?Q?WOoM2YRxiLs8DgcgBQ7j8648IN4hvK6VbmR4s65tfPa1Y8R4jM431Py8pVA2?=
 =?us-ascii?Q?8HciAznviGWvoWuNB+ggd8Ue2Qb7BYo9p7NbrpwmP8CuHKQHkQg1CL251QEP?=
 =?us-ascii?Q?j9Ml+UQ+4RwZI/A0xJ71Alp7rzJi1Q6AeBkTLHp8ckWbXwXD2xsV/5WwtrLi?=
 =?us-ascii?Q?ohjquaIkBBnNsy+toELydHacLLPBE0ZsnLCiES4TldlnfBM8K0uw93tSVlSc?=
 =?us-ascii?Q?SDTYvMqKou0rz6pgsuWitFQIKp8GDBRaM5mBLXuP2vHRHglZvd5BTzZ+VWm6?=
 =?us-ascii?Q?KPmv/aLdDw8Fq+T7ltRIuzxo/UcAJ2VJWBd9EgeG3LTic9TcQFaFnGf3fMJi?=
 =?us-ascii?Q?NqE4Sv3dKXZ9WlbqHYogMP0kl/EbDPwmEBD/ybfJE2HpW8ysQzNT0psuw9R3?=
 =?us-ascii?Q?JSuZbzOb024DbNEiLv5WX1cJt/bFirBH40+EP8QSt1PgKyNj1GB/640J4qEU?=
 =?us-ascii?Q?3UgO4sq0DZBsWHz7TlEJOArjcUf0isN9mjqtNGWsOyMlFalCBIk+ayPsFatO?=
 =?us-ascii?Q?6FBBYbOwqkMxGdZtcAG+qDJSZUu+ITwx91jIITunuu1yJBvrXepDyeOHTsQn?=
 =?us-ascii?Q?ItYmFJvwe1Bf5EVjwGMBBd2VwYHHj5BKFDEFKn6o187j3U3PI/So98JPlpwm?=
 =?us-ascii?Q?t/y+dIDLMoc5g7u9AFIECP/LG7CccySPQKehimCeoyrbbGeoYYBSYVe/U5dV?=
 =?us-ascii?Q?IqMeDkgijIHowIf/SWbhF6sEqEPT5NtVhB2hda0qrXa0lKHAvo3G7JUxhDhI?=
 =?us-ascii?Q?l72K9+AFFFVMd0Phnyq+WGghxVsF36tLIQ7crXEOIXTVL3f4Yurf2XyZgvMW?=
 =?us-ascii?Q?SkBF1Z9/keIxuLq9uD+uKf9lP4S9lt0XWH6tfCGQQ/gQSbXwBWVfYWohaHEb?=
 =?us-ascii?Q?SsmeYjnmGi495WnNqRPjBdjblF3kZ/RXvp6BrjEMJaEnQ3rQn2XmlRQJ2z0u?=
 =?us-ascii?Q?yTnm+kqGxuH0JWbsjCfqUiDMDUCaSo8yf6gwJ76muRqabJQ2ZZWtXEA6Hg+h?=
 =?us-ascii?Q?/G5rRKk/9kzcOrOblMVEn05g3oTrvYXa8k5ikV6Ggcr5krc+mTNRFb0K9QiS?=
 =?us-ascii?Q?NoFJevED46k19qJDowUc81tPPz4LslQRmoH2i6kp3cfvsT327QipkREH4tMR?=
 =?us-ascii?Q?olAmtb4QMnKxP4vXxjO3OG9BayZ8UcPVZrIeBwEqXOIfPtp5gN/tmBLT3HOz?=
 =?us-ascii?Q?lzg8Qv86ZeEUYm3L8M7kkcaGJpMRR3ZObKcLiEUUmfhl0ZhFOaPcN8zERXQS?=
 =?us-ascii?Q?Y2NcEYC0DV5uNu8jF/KuorJSRbyXi0QI?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(14060799003)(82310400026)(36860700013)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 16:18:48.5739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f40e6c-9e5c-4963-07c8-08dd10918193
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5835

On Thu, Oct 31, 2024 at 07:25:03PM +0000, Mark Brown wrote:
> There are a number of architectures with shadow stack features which we are
> presenting to userspace with as consistent an API as we can (though there
> are some architecture specifics). Especially given that there are some
> important considerations for userspace code interacting directly with the
> feature let's provide some documentation covering the common aspects.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Tested-by: Kees Cook <kees@kernel.org>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/userspace-api/index.rst        |  1 +
>  Documentation/userspace-api/shadow_stack.rst | 42 ++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>


