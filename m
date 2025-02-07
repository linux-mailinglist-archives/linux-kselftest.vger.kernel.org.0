Return-Path: <linux-kselftest+bounces-26046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB51A2CCF6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961573AD0E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93E1A5B9E;
	Fri,  7 Feb 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YMg68Ws2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531891991A1;
	Fri,  7 Feb 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957329; cv=fail; b=pxMuivDaNQxd3JIlYNNlmtgnmewNcBguXs0LUyFjfeZQgbHS28r3vM9c++yJHywQGuoXKqDX5o0gR8a7yN2ZJR6NR7+Kk+5ijYlIngJFB9TJ+Absgfbtbhdg90IB/you8Bs4hpJVG0ZnUQMX/ZM3PYf/Dhxv0/XkynDNoz51G0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957329; c=relaxed/simple;
	bh=x7Baft40FQs3qktRIJPQ7a3I6QN5UrAWWQfC/8zsIfw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=I4q9ebst+eYe63As884UM/8B4aI9eLd8b32qlPwTC1dypqDn3WIwfBgRAigpnvUNRqx/0rOq2JFH8gBPF+tQD7FHLOg7Czl2p/XUKsbH1k0uASP0yOTzf1Hu82kHI+x98aUehqsMO6XB2RMDFkmMtK5Nohw7JClk6FHH7rr7e+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YMg68Ws2; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4WNuMYx5lCq8KyempBZ1nj+cSQntYv1pv0PT34axWuyODJlxywFDLaTm91cCavL6YkWhIzbqoMYffbBRLjKY9VT91byI6PuvcS+D3U9qtMN1gaVG8dorIx+xOIzBX/Qzl0/IVmwL+R5DURpL0NjoLTF5A2yvu1G6fYKCEHDYyEJBVbygqnp3d3q2suROfLvhltToQGcYM9BCUgNEKyNlxP6z6AEJht/t8uMNyuAlrvaJQDhv9e+9nuqHXYGugW6ySDdGcLowUUNIWnjzPflcrWT1kO7Bnw7tXate8GLz+HqXon9CkqbgNDBnTX7IdE87umZcEtaVPz20otoNl/JOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnxF+5Z/X/dt0aFC5AgL5PNoSsTkohrJxD2cbd3d2ng=;
 b=FvfUqnmBGYevu8EbudXphjZiNVVbewZ3QWFG2VH+OISxQjsn/uLWhAzBkYJoYwB6bOhr4Iix2dv7mRHuvBoxcLe6EDfQ23d+UB6NQyron92dH8qBoMjU01jXRpDufE/8ei04rk7f9kLmp3yCQBzsNbn/SKFt99OMtp9r1Qsc0ExP5e/pfRzqt2/WDrczZ04ZIsuJkkyN7LdvVEoH2H3zeuot0zkL0t9md00h0aRydxzuskdwp6icgCZAEVrZXVEzKF0lkM3JDRDNrLMile3/HzJ54CDOu5+Zjq+7Mi122QAbztv9UVbzjHZe17D2ual544DHYRWS22sBw4ELkdBQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnxF+5Z/X/dt0aFC5AgL5PNoSsTkohrJxD2cbd3d2ng=;
 b=YMg68Ws2/QJGHvRZb3Gzdg2Qknz4e2n7mGAALRgCEhZ+mKukhKEql+gtUtFjxi6mG7Q/0WHo6xzCyPD+Tem6Vhwqg9RylfC+SXKMsDisznqzYc2OYdHyRY5qEiJ7EoDa01IlJz7xf2lYAGa8BFk23MKKQki0I4NhMkqGMJuMiIqQ8OAqmKq1VlBsOkdn1dsSUrnMquTpJ57aPDYAmQLfGmMLZdMHMdtE+W+QZC16wdGLnkZx6kvBBUfFSKNylEL9YBltprZEkZuhjdG/UEJyPdJjaVN4NVXLDVNLgwJKqYgZGgM90ij+sWT13l7lOHbZjWBgE/8/SRJFAYESW+IS+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:42:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:42:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:57 -0500
Subject: [PATCH v14 15/15] arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint
 function overlay file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-15-9671b136f2b8@nxp.com>
References: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
In-Reply-To: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=1955;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x7Baft40FQs3qktRIJPQ7a3I6QN5UrAWWQfC/8zsIfw=;
 b=Mm+uUzWhGzxprTqSZz/ohxCg4WB0Af7DumOpLqz0BUIK8jc23ApA3Yxonx2+kkX5hLZPUHR28
 7pKtuwWRMDpCV2/rLTKNnk1/UmU+UMcXzh0b/tVB+DtANjASVVCFSkI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa907e6-b916-4428-04bb-08dd47af7fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1pwSE5xaWV4UC9JdFVwUWRwYkJFVGVrSEZERFhOWkhjZ2tETlJKYkZoc1Nr?=
 =?utf-8?B?ZzRXcEVHQ3FWdi9FZ0Y1dHp4STV5U1U2eHo0SHJWYnBoYlRKT1hnT3JrOHdD?=
 =?utf-8?B?QWZFSzMxVWgrT2FvY1NncHMzNUZSTkxhN3pMM01QWEMwUDcvUG9vRmhJdHps?=
 =?utf-8?B?UmhJRDVPS2JNYTdoeW5MK1VkTC96b0JGRmJ4VWR5LzJmOVA5RVJzanQ5WFNl?=
 =?utf-8?B?YnZWYU9CK2g5SUc2Q3o3Mkx6RW5nZnUvYjBsTkVtZXljc1daMFUzeHV6ZWVE?=
 =?utf-8?B?UmVLK3lTWk9iWjRlOXI5TmUyRTBzTWlOdytrWStoK2VtVWF5UUozcTFaYWVV?=
 =?utf-8?B?emJ3WVZOQUlGd29YQTZ2RDFicisrb2NBSGl2amlHbHBFcldyTlBFdnczN1ZK?=
 =?utf-8?B?Y0pNekJpMFRuM3RRbG1nRmpJbm5QdlUwSmFFWXRtdzE4QzBRM2lhcEhzMUJ6?=
 =?utf-8?B?bzQ3WjdnVGxORXNJMFJES3FQb3NOcFFBemRkVFBVajk4V1podStia21CS243?=
 =?utf-8?B?REs5RWxQU1NNUXRXQ01yRzhPc2hjR09sWndiS3JaYUQ1U1hQVG5iMkw5dU0r?=
 =?utf-8?B?alVpVUpLbFRvczN5c1Vic2dGZDVWcjhzOTdDOXR2U3RHV1U3WlNCOENKSVlt?=
 =?utf-8?B?L25oWUxMWlNUdUpjOG9YbUs0Q0VoMmU2NzVhNk80RmYvaEJRYzA1U3g2OEJV?=
 =?utf-8?B?WXVrenRBcHdBZ2g0MkdlZHBLcWErZ05DcEx2V1JTN3NQQVUzMm9ZM1owYmNn?=
 =?utf-8?B?dWoveDJodnJhNWJhdlIza2xWTEhTakxJc2lzM25pVTdvVmgwemFkY0w3M1Rp?=
 =?utf-8?B?eXF0UXFMTzZ2ZWJ4cmFNVGtWN2dxYXZld21pUkg3ZVJpTndESUdpUmVPT3dR?=
 =?utf-8?B?S0tHaHhzaDdvUTVzNTY0L2JEL3RLK3hidU13THo0Z3M2cmhZZVhXWlFCSDA5?=
 =?utf-8?B?TXZuVXROTitVQ3Z3SGRWYlpjUUpTQlJXZXh2TEw1RGNSV2xsVUkxek1iTkZR?=
 =?utf-8?B?dG52Nk56NFo2eWlsblJoSmJsTE5nWTl4cUcwZlczbk92Wm5BWm4xSHdHb0xN?=
 =?utf-8?B?U0FGUmpyVTNGZFdwRnJrRGcwRVo0eFZiUVNZVUprdkp0RThxU1VqMVhXa1ZN?=
 =?utf-8?B?ZjhmUStmYWlqK1FERDdnalI0L1EvZXFmeGJYWWNwNDBQUXVuRWxRbmZ6Nnpj?=
 =?utf-8?B?UndFZXBDK01kZjRHbnV6eXZsMmM3NXV5V2dBdVNPaFNITTErTjYyVlZ0cG56?=
 =?utf-8?B?ZVFUV1pXWEE0bVpoQzY4WEVLS3JlNlcyQ3U0UW0rdHlGbTZYbUY1TURVdFV1?=
 =?utf-8?B?MDI1RTZ6TFdEUUl6YURNRU0ydEdsYS8zVDNueWRZdzAzSk5sd1FQSUkwTnB4?=
 =?utf-8?B?anhzUVNkV2xYRmRsSHJlaXI3OGUyeXBSS0pIMTFYdFM0cjFMQ1FybG1GUUYv?=
 =?utf-8?B?UXhYUlJZWkpGaEZaZ2duUTNEWkVCSjBPemh1bFZkenBxOFlGV1I3MUlCS1V2?=
 =?utf-8?B?UGVKbjM4UDd0SmV3RGVrUURodnB1R3IxSWg2Q3I5VTVZd1RXc3VlekFZczBx?=
 =?utf-8?B?WTdDdFZwMUw5ZHQ5UHpCT1B6K012MEk3Q1BjUWE4c1ZHamxKK1h5aDEwZXpQ?=
 =?utf-8?B?eHF6TStSbXQrSHEvQ1MyWW9aTUtlampyMi96am1ObGZIdFEwR3F4VEQrQURX?=
 =?utf-8?B?SG8rVzBTSis2QzhzWjAzK1ZqeHhvWS9YM0lwd3FYUVZVTUFnREMyWWpvNDJs?=
 =?utf-8?B?Vm4wOWNBV0JVN2MyUDNxNFN1YTNZelpJanBvSmVMTjlzRGthRlgvNWtPU2NZ?=
 =?utf-8?B?M0oxV1UxRXhTYnY5OEN2b1ZLQmEzM2dhR0orZkFOdHU2N0RrZWxjQUNRaitZ?=
 =?utf-8?B?SGpvaUlPRUNOV2VVdHFEY294M0dBaWxPeXN1MEx0QUE1ZUpTV21oWVJZd3BI?=
 =?utf-8?B?WGJJcHFNNW50bEJDNXNwZkx4aUNUbHlvY3RydmpwWE52YXhwU3hyL0FJMC9S?=
 =?utf-8?B?TEV2MXJTNmFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFhOdlVxN1NRZmtsWlFpcXZIeUVDNFF6TVV6V3BMNjFtcFpkcWZ5NmpOZXkv?=
 =?utf-8?B?a3RDTW5PQVN3dTI5Mm5XaW84dC9Lbk1wL0hENUQ4UDNUWUN0WHFVT3NVTm5Y?=
 =?utf-8?B?cTFtcDNmdEFKL2dGcTFMTitKV2YycEhxM05CSXZYQjZCc1ZtUktPdXh4S2ZM?=
 =?utf-8?B?RXNNZFpSRmdzMFd5VEdobDRLNGlBQzZvL1lZaW5WaElMT2VRdlVEdmRFWDMr?=
 =?utf-8?B?YnJpOFl5VVZxM2c1QzU3bnVBM0o3YTlVRzlrY3M3NUoyazZHV3p2ZXZ4OU9N?=
 =?utf-8?B?ejFBMDhNRThuZFF1VUs2djhteWMyYnRUL1R3WTl2Y3o1R2ZtSElyVU96dTht?=
 =?utf-8?B?RmZtL2JSUXUyVERqN1RvRnlKSmorU2tQN1lGYlpRRnJoTnh3K1NjOXJhWFBa?=
 =?utf-8?B?Z0dqSStoUERTMVgySENLTWZEY01CTDZXSG55aDhBNEswZi83UE41WDBzOXB6?=
 =?utf-8?B?cGp1SzNpaG1TSHovRDZFbXNMalVvNnk3Smx1d0VUV3ZMZjVVdS93WTlzUVh5?=
 =?utf-8?B?aUlzVEtWeTRoUGdlbzBRQkZmOWt3andPbEpEUFBsQnNGdW9NdWdmVWNpS0Vv?=
 =?utf-8?B?MkVvNDd1Q0dyYVYrZktIS05HZ1NMaW1EWXJTMVUrVmw0TlRLTHdYMXQ2NjA3?=
 =?utf-8?B?NVpjc1NmWkE0aVAwRHFBTlpWRzM3d2JtVmtWQmpKdGdRWmJKdEo4a2IyeHNi?=
 =?utf-8?B?YmxiOGd1cEdDTFI2WjV5bHFGMEFrRENCeVlTVTN4UkR1MDlBZk1xNG8zODdW?=
 =?utf-8?B?bG13NkRITG1aY3dOZmNnakZrdElqeWhHZUM4bjBCZk5mNGw2akhPOS9XWm1D?=
 =?utf-8?B?dGlrQWxUMk5pM1I4Zm5QZEg0SUNQRWt3a0tVRkdkUmhIZUxsVDRENEZyaUx0?=
 =?utf-8?B?Wnk1RVhhdXZlcm5oanRjbGpDMDVOdmg0d2FoaThOb2NDTW9IZ3JiVkgxdUtD?=
 =?utf-8?B?czdYQTZvT2tzM2tMRHRaYkIvSUx1blZ5U2RuejVxYVBWbGF4TmxhaXE3dlRz?=
 =?utf-8?B?eXVBbi9wSm5jc05Ld3prbk8rQ1F5N0N6QlIwZU1jbFNrNlRMRVZ3UHhUaUlO?=
 =?utf-8?B?VW1KbGNNRkE3N0kyTWVtZmh1Z20wSExQbVRML3FkbTBPZzJxVjU2eXZwdEs3?=
 =?utf-8?B?OHVRK3dGZEt3K01JdUdmMWVDMHNlRWhpa05VM1ZCeFdEY0w1Wk1BcDZRcUhh?=
 =?utf-8?B?VHZyZkdUbXhZUHVFL3lHdWNzV2hEQktvb0NLRUNJN0gvNlEwYVdxeWh6V1JQ?=
 =?utf-8?B?dzRQZ29lRWlya3JUNU9ZRWZ2Y3BnRWdMMkZvQ05NSjBOS3YxcjQ0NmY4MXg2?=
 =?utf-8?B?b1c2Y2QzRUpmQ210a3h6VlZIQ2FSRFVya1o1bFBPcE9OQjFCRGJ1OFlmQlZ5?=
 =?utf-8?B?MjlISDcyL3h0ZHl1dW9DVWJMVzBRNktTYmk4RVlodEdsaVJyMllRbUZVWStE?=
 =?utf-8?B?djAzUVN6VHRBQlU3MDdCTEV5OGcySktoWEgxRnNVdFNxOWFRRjB6clNpTUxx?=
 =?utf-8?B?WERHeEttMlg3TWl5Q1VRZnlCcmVmcGtaRjJGbG5jZytwT05FVWNSdGZXbmlI?=
 =?utf-8?B?RmFSbXBNQUNLaFFXTkRTNUlMU05URjVjMFNRcGd1R0lyT1dWcGt3WEFnNkxh?=
 =?utf-8?B?Zm8yRExVbHg0SThjSURXaGdqYU5xQVB2WDcyOW5jdERuZ0NaeFkxRjI3azZa?=
 =?utf-8?B?emtuRmRXdUVxNmxWYlZtUE5VaS9oZGcrdHJNRVBUOGNSaTdmbm0yakZnOHZq?=
 =?utf-8?B?WGUvbm4vd0FndFRyZmdUVE1Bckl6RmtkZzJFWFJJVWhpRllwamVMYUNDRTIw?=
 =?utf-8?B?NVZxcGNxVm0xZlpXRjhSSC9TQXQwYUFJekxKa2c4c01rZjYwMzR2ZGUzZzV4?=
 =?utf-8?B?RS9tTzRKbC9sZ2VITWNia212RmhjMVRDVEtkbVpSSjRGSGhCd0V1WS9ZcGcw?=
 =?utf-8?B?YWM4L2VmSCt3SXpMbWNUb0dyM0FuT1JmOFRMUXJZWEtCamVJMGJ1eEhrSStP?=
 =?utf-8?B?YTVLakNjelpNa05HSlFMNWozRW53VFkxelJSbGVIbVZUOVB1eC8vd2NoeTFW?=
 =?utf-8?B?aGVuMDg5WW9ieW5UWWxXcWpDK2dLNFIxZGFBZ2IxU0d4bXNpaDVSWUNYOFd1?=
 =?utf-8?Q?RKoZJMBxz6Q4Vh2cumxUPZNXC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa907e6-b916-4428-04bb-08dd47af7fbe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:42:04.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW8lvnuKq1WXOrvoiiZOGqeuKMS7n2fzQ4VER97oaGC2195C5m8EFcnwVkWL1Ppf+gXXcRPjJuPCgI5WwKLfKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Add an overlay file to configure PCIe1 to function as an endpoint. Enable
PCIe1 to work as endpoint mode on the imx95-19x19-evk platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/Makefile              |  3 +++
 .../dts/freescale/imx95-19x19-evk-pcie1-ep.dtso     | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 839432153cc7a..d892303fa7eab 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -287,6 +287,9 @@ imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
 
+imx95-19x19-evk-pcie1-ep-dtbs += imx95-19x19-evk.dtb imx95-19x19-evk-pcie1-ep.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-pcie1-ep.dtb
+
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk-pcie1-ep.dtso b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-pcie1-ep.dtso
new file mode 100644
index 0000000000000..696588e768e61
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-pcie1-ep.dtso
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&pcie1 {
+	status = "disabled";
+};
+
+&pcie1_ep {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_slot_pwr>;
+	status = "okay";
+};

-- 
2.34.1


