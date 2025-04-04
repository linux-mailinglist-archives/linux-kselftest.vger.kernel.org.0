Return-Path: <linux-kselftest+bounces-30137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08E3A7C396
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FC53BD55C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FB221F17;
	Fri,  4 Apr 2025 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ppg5M3Cd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C5221F11;
	Fri,  4 Apr 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793355; cv=fail; b=DNrhkQIpp9EJyiHjq5BLvPsAo/2R2IrDEXDsSG62b5o3cQG6aXjRfqdnZHnalORwyUzuHDntThz3GB6BtEYbbndiBmFsdDmppfehIoYinvZxEc+TdfKkCPgPupDLlvVfkSI0/HgxgY/pMsbNGZuaSLDAIPlKG859JITukfuaBDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793355; c=relaxed/simple;
	bh=Mp2cXn9FsMWsG/hvucQeIBBPPQdjWFLzH+Ukbq7aPzU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dqhweBMbTFHp6R7rlTPSduU45ff0++SPt0bFCLSXkJXIdLe1gMYlgGdCiNZMMUGc94zKQaOKxf9WT1SjHl+aDXsz+pehKdGO1BDodlg0HY+hpwLtFfeYd9atKibTifTGF79aMnTDdB+O8uFkoe/pLHrbxY8mUxV8N8RomH3iP7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ppg5M3Cd; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxSPQf8CfxrVtLSuhwEM2KN8edjioIRFg05ByUrO7C5En1AFs0AbYEuH2TRXPpplXETcAjHcQDVbGLYaexNcafB9pjsnlEgEqqMlnCks1aUw0zyC4dDyyBw4UBJKSGg8Y3WzhEY3tMV8COkvCvMIwnL5y3o4ghJXsKK1OHNTkW9zmPFIgEFFtpi6KAmqwQsIsRpzYqmPDgAlsxwyTvjLhYeVaWEcDAdN8Qn7UK3BWdm1EkbTZpDX2A4U8qneNwI2V/Gjvq1FFYDDWRLw9YF8URe3T+UcKEX+glhQLyWtEuaCrFxgVyJ8okUZA/dudvgK88faUt/iPNzmLKRvQhhUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+qwraQmG61cZxMtmXO5VrRkCys/e7X2Bx0RuL0d/hk=;
 b=E55h7UqfP8yZFBWyYZVvVi6yU6uhb8EsOMK7BwZ7ZEyVLepU5+HNpjqcpf+fyg+ltetgP18AFwxxlwwMjarxdps1bNEmLf047QumZoLvxpJLm47LVt2KZ6T6a4lD/y1g9Pq7WsQfYqEljwmxXQPu2m8vCs45Bvgo7zjIFFWZd5qEla4z46TD1d8pt6Axxwe5mxjJ4YeFDFX+Mqqa+KqGNFQqbsTdIrvF33GKh+ZfWuY6xu60pQxjE55L1ZWL1yl3q4Cx0bcNVnQE+B64f4GmJLRQ5ZiZfLCxaofOo3GLWtJwgOelYiEWKmesGCIV6mqUfoFUGHcDIixglmFqP77hBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+qwraQmG61cZxMtmXO5VrRkCys/e7X2Bx0RuL0d/hk=;
 b=Ppg5M3CdH5Ayjoo2uUHGE5wrrvJBrk9jOLEVT5ZM85AyKoKM7YHg5yqmWxkJkL9u3e2WPD4t0eMC/ySBI0DOa4Xx6OewEE8FS1AEr3y1ZTnxNR+CD+AJs+WtThKaXp4VU/ZBVVzwCvfyDecqz0y10utZAX/XdSoCWEVmnEOed8zK/yVNey6N+ejQWgylqH8D1AWTcEMQ1UbiN/sT8tcfwxYaBgWH+gEAiiZ/gxPR/1UFz6sG71h6Y6Co//2x2LzGWl3xCXUw8UFHHX9bkcgdPz1j84YHDFkRFDX7e4TO55+5Pomcsf/xZrRhyrmEGFWWceg0OX0Or3uu3fvy+7b5Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:02:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:10 -0400
Subject: [PATCH v16 09/15] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-9-d4919d68c0d0@nxp.com>
References: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
In-Reply-To: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=4364;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Mp2cXn9FsMWsG/hvucQeIBBPPQdjWFLzH+Ukbq7aPzU=;
 b=bOfNKLiaFScP1ydO3C8L08eFpL3/qIyOYorrRe69HQ1oEl9JP5YB1hNNE1tLsfvSTBpd5C22t
 /AGgd/TnEeOChvZVMOWSI6PMTGqtQEa9cmgju7CSKC1x5Eq3gO5qXem
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: de2ea5ce-6636-4485-a204-08dd73ab3fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm5pM05FaUpZUEtlV2dKN1FuaFA5NkpadFhTenRkR0xWdlZsN2xtU0NpT1RI?=
 =?utf-8?B?Q2ZhdXBkc0V6b01LUlFMcHlOd1VkbUFldWczTWQyV2JDZ0ZIZzQ0Qkswcm1j?=
 =?utf-8?B?b1VxcVNBUHZtZTkwSTEwZk1Ga2syVHZleHdSdWMwb0hSVjBjdzlJa2pyMTBO?=
 =?utf-8?B?RGw1ckNSVWZ0OGhSNUFPbEZtWWh5ZXlCK0dxR2lUOVVHMUQ5TkhucXUvKzJB?=
 =?utf-8?B?R0pDQVg5S3BDdGJOdXZxbmFvTjdxZzYrTy9yWko0SVhTOWFXRm8ySFZYclBL?=
 =?utf-8?B?L1RPQzJGL3R0U2llSlhmOFE3Sit5QXArZW45a1hCYjRlcDZEZUtOeDhXYlIx?=
 =?utf-8?B?V0ZrREc4Sm4vTSswbGdmUStTTEo0Rnd0YjB1VW9MYzVES0krdW1BR2lPakJv?=
 =?utf-8?B?ZEl4LzB5RDlpWUcwM2xycElqMWo3ZkV5YU84bnhNZkdjUWhyY2pZeU9ISExr?=
 =?utf-8?B?VHJRUDk4L3pzZzBCdWRueitHR05mb2tpS1VxNEFWQStsb3I2TTNMNW11UmF4?=
 =?utf-8?B?MGJiQlQvQ011T2Q5MldJaEN3aHFJalZ6VkozWXBLMjJwRlR5RWsvdGV3azlY?=
 =?utf-8?B?ZFBQcVB0dk4wczlteEtYZ2QzeStvUzNveW1DemhvaHhhVThBc2h1cFBmUmF1?=
 =?utf-8?B?ZmNNUnBYWHlWWHNVeGtMYnVWYjJMcWo2RXEyRHQycWpwMXYrWUo1QVZadTYz?=
 =?utf-8?B?bkd4R3ZNK3hjNlJLQ3hodWtuaTl5WXo5T3RYWWFST05Ed1lLYTNWWFZuQzhq?=
 =?utf-8?B?eFBSNk9UK3RWSHdhSXZvL0FZdjNxOGR6ZmQ0Rld3ZWxPb0p4dEE4WVE4WnNm?=
 =?utf-8?B?Mm5rMTQ4UnJaRW01SUF0KzNyN2tPcnFubkJBM2FONVpHRE9QUnN5N1VsMTBk?=
 =?utf-8?B?U0JkNXVsQndEWlJQbWJnL1NEL2pMeU1yOWRNUTRWUFVhSlpBdGNPSkFEbGtt?=
 =?utf-8?B?cm9SdU9zaGtjY1VDS0RxdEVocFJLWnVyZSszTnp3RHNMQTdkelNjUzhFaWRt?=
 =?utf-8?B?YWNzUlEzTHdNSFFCOUEvYldFWG03Wmp1a0pzOWNTSE5YL1NvUjgxbkhHcHhk?=
 =?utf-8?B?ZnNrVHpibmErNExLUlEzTmtnV05QZU5zN3hYRGtTZUl0MEVaQmJhb01uV2ho?=
 =?utf-8?B?V0pxN3RGOU9ocTVIK1llRHBqQm1DRmN5cUllSjc5R2U5bmVwUTZ5MkxnQjlI?=
 =?utf-8?B?MWN4N2I1akZyc240NEJQK2gvZWZzcThORFNFK0tFWnBDcVpNTWRmbjl0cGdO?=
 =?utf-8?B?N1pOaGQ4Y0JKQTVFOFByQnhPdHUxU2pCNWlRNnF6anJqUlVmWG5DaU1CbFJp?=
 =?utf-8?B?bjd0Nkw0V0ZWTUdQZTQyaHp5dWxJVWJKNHhmeVQyRTYzUUpweElrQnJKTytU?=
 =?utf-8?B?SzlNMGtaTGl4UkwwTFRiM1lWekdOTEdYdXpkTkt2VzBHV0gyNWVQZ0w0MmtZ?=
 =?utf-8?B?dUVQMk5kbjBkbDFDUC9MOUtOWlZ5TXgxeUszT01tTk91c1FTdUhFaWxvS292?=
 =?utf-8?B?anB5SHVzMHFKZk5KY2pyNUp5Z082SUVkdEdDeUJQOXp2cU83c1V6SVlrVDBo?=
 =?utf-8?B?S0x5Z0JhczZwdWNQV2RaMVFmN3pSTEl5bEZSVG8yT01uT1JwL2Q4TVUrYlFR?=
 =?utf-8?B?OVRRd2puZUYxeURlb3BPeFdGVGhYZGQrcHNKZm1kVW1PWTdua2hFL1hmTko2?=
 =?utf-8?B?dDE1UkVQMXJKTGZCeGlzM285dVRhK0dGeGpYTGFlazRtZEtJWmwxbUxmL0RC?=
 =?utf-8?B?elZyd0ZmNTlTN2tiNkN2N2lVQ0lTZUFFOWl2SlNrY0R5Mmc3R3BRSEhNY1I3?=
 =?utf-8?B?NGVndGcrSjlKYndZclVCVGFubUx6VHhIVG5id3VUaXRJTUJtTG8xY0JVTWE0?=
 =?utf-8?B?ZVd3L1QvN3d3N0trZEhnZlFMZ3l4Y2dhODREQ2dwVi9NNC8yNythbjJkRXFh?=
 =?utf-8?B?UVdaa3hEd0kvMkpVeTY1K1BuZUlQWjlOR2pOVFduTjA5T0dBb25BRDFNSnla?=
 =?utf-8?B?QXRlckJPRUxBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVQdlBkSVVkdGJGVUxzREV5N1Ird0VVbTdLZ1hHRW0rUlc5K0EwNHdydGdw?=
 =?utf-8?B?MHZ3VzNMajQxWDFHcm0vS3dQTW1lU3YzbmNtckkyTDRFVG9oUUdnK3BNVU1W?=
 =?utf-8?B?eWh2NXZycHdOTG03b21KUk5VWFhuNkdwd09RaTNRc0dEMmQrdXlZd3k3SHB1?=
 =?utf-8?B?S204OWpBdUJlRmV2M0lxRUZOb1p2TFR0Y1llVkE3eXFHTXhyR0RaWDNVRWx5?=
 =?utf-8?B?VUhtZzFwWExveUJTYWlCLzNUVUJnODd3SkJ5Z3pCSlhvY2ZPMUtTMWkydHpW?=
 =?utf-8?B?T2YxSnZna2l3Q0xZRGxPcTM5WlhVNlFPTGdudVR4L3VCaWNldTREd3ZUZ0tm?=
 =?utf-8?B?Vk1kMW9Sd003MFJSNWV5TVZjWExaU3NSU3FkbldxNWpKa09RbFp0czM3ZTlQ?=
 =?utf-8?B?YjNkbHk4eUxNWUJhTk5rNWVxRVlaaHVwMzFCRGNCLzlJSWM1WlJpVEZoVXB0?=
 =?utf-8?B?VXhKdkkzYkQzblhYUmluYUJ6dWtaelp5d1o5VUUyNkZHNDg3ZVpIWmZmWnZv?=
 =?utf-8?B?dDhCK1owc0gxTXE1VDdjVXpNclZVVjNtVVJYci9GUEFNT0NwblVaUW5TRUt2?=
 =?utf-8?B?aS9qaWF4cEs2ZTY3OXB3UEF0NDdwa0EvYkpHM0FlN2RNcTUvZjhPSXNhWmcx?=
 =?utf-8?B?c0x5WG1FcEttNlhmY2g4NDBFVU1FZXR6aS92RktFY2ZzdENrOHFoY3lraStm?=
 =?utf-8?B?eFg0VUlRSEljNUtzK0EyYkFPSWVtc0h3aExwcmd2MzFWUlI4YXJ3NnBQZ2ho?=
 =?utf-8?B?ZlNiUllRVUx1ZE4wS3hWQW5ValJJb1JrNW9yMWg1aFpEdzl6SGdLS2ZDQlJu?=
 =?utf-8?B?YlFFN1ZUdnZXRk4rMGFFRkF5QUFmSVUxN2VFUFQ1ZlZOQXlMbXBRRVdxRCt2?=
 =?utf-8?B?cm5YRUpaWUM2MklJWEQ0bnZyaVgvdUtHdGJvd29LRTdnR0FnZkZpelhEN08w?=
 =?utf-8?B?V3BSMGJtUXRTbW51UmFNUTdXcXNFM1Y2WTFWWEpjOGdleTh1NmYwVzVTOWtm?=
 =?utf-8?B?aUtyY2VIZ3EvWWxMeEhHZEdUdmQzcFVIQUNYcUppd3RacFVoNmI2bUVIR29h?=
 =?utf-8?B?M2Y4TVBvaXRnZ1NMbEdvbDFubmxRVTlodEZMbkpCdm5pWitNTUptVG53NHRY?=
 =?utf-8?B?YjNtaVJFR2E2OUpRa3M4M2lhK2hPSGRrUWI3OFpXQVQ2L0FPbVBldVZFSHp6?=
 =?utf-8?B?VUo0eURHRkd4UDNaRHRlNDZGZDI2cGRzL0NlZHVKMElCZTU1RUtJaUFsZGEy?=
 =?utf-8?B?dlN0MjNBMWJ6VFlEL0NYWEtBSzJ1MWVmM1lTVW9SanlSUmd5TUFUM3pWNnRs?=
 =?utf-8?B?WklwdnRmYno3T292WmR3c215WDhlQTBCNlcxR1RlQjY4MGIzRFdRa0xneC8v?=
 =?utf-8?B?dXh5dzBjamwvL3E1YnY4ejdGcDhrUXh2cHlNQ3JDT0hFK2l4bUltWm81aHBp?=
 =?utf-8?B?dDZiNi94K3VmT2ZLRmdiU0lZdUk0ckZrZEM2aE9pbzJiNmhKcW5rb25NTG03?=
 =?utf-8?B?NEk5aFpsMUZYZUhVNFpNTm1jOGZYV2hsL1VuTTNKeTBJTzQ3OURYU0oxaVFp?=
 =?utf-8?B?ZFlKTmZQMG1iWSsrWmptZDdXWlZIVlM1dmNCZmo5Yk5KbkZTNlVIRlNaZkpU?=
 =?utf-8?B?VE5XU3pzYTFJUmJTTEVsYWFoQm9ZM2x0ZnRJTlV3WWZxUXFMd29sb0hnR1RB?=
 =?utf-8?B?aFJVdjMxTU8xejNVeDBUT2V1aGdRQnEvakJxWC91TWJUMzJlNEhUUXVnOXg4?=
 =?utf-8?B?UkJ5cVRJbVJmRkxHUkFxUk01SjVycXJuUGNqN1hFaS9rMXJrSS9qOWUwTGE1?=
 =?utf-8?B?ZXJVL0ZmMXd5WVd0KzVHR01Nb2RqNG1WRDJIaUtrd0FCUEUrRjhLWlpVaXNt?=
 =?utf-8?B?QVlGK0ZMT3VYTUplcFRGQmIwUlRZN3RaTnl1dnJxc1BLK2hPZk1GR2ZDWFI4?=
 =?utf-8?B?SklLL3F5aEpiUkh4SjRaMDNOa2tyUEpwdEF0cDJWc2ErOXpkRy81NjhvNk9T?=
 =?utf-8?B?MHBnY1pxUzlUVmdoVXVCN1RTSHVnOENnM3N5WXV0RUJWdFF3VkVKRFN5S084?=
 =?utf-8?B?Q0RqdmhrWlVmQkZjNXRpekVSMU1wa2VXTnNuY1pXam5jbk9JSEV1aG0rMjcy?=
 =?utf-8?Q?4WG0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2ea5ce-6636-4485-a204-08dd73ab3fd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:30.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCKPi9AuIhNKtPoobHd1dLOx96GZDyNyH6v9vQGj8qkWdYzP7NGKBWD41nBkzqrcbNltWBqCETbsWMLH1EXTSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v15 to v16
- none

Change from v14 to v15
- change out address type to dma_addr_t to fix below build issue

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082311.G1hWGggF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_enable_doorbell':
>> drivers/pci/endpoint/functions/pci-epf-test.c:726:42: error: passing argument 4 of 'pci_epf_align_inbound_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     726 |                                          &epf_test->db_bar.phys_addr, &offset);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          dma_addr_t * {aka unsigned int *}
   In file included from include/linux/pci-epc.h:12,

Change form v9 to v14
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d04224b8e1631..529dbaaf76750 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -473,6 +473,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index dcc6e2a2c6b3c..299ce1f1e2d80 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -241,6 +241,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


