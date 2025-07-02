Return-Path: <linux-kselftest+bounces-36329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08827AF5B53
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5268252032E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAF3093AF;
	Wed,  2 Jul 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fkijzwUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B23093A1;
	Wed,  2 Jul 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467266; cv=fail; b=Q8N6e071lGsluEvEerRRELXJ9XZLJJeq2QUNpYBRRlwBowlgL7QCfU4kDi2S+mvJXqb7p7h4lOLjnBy4qodYMc78xn5xv0TdRu/M4XOP+sxZkoOGv66q9MO+JbNVrdbvKCiBn+d/sXJFXyX0T8iRi0bDv/JIz0gQrv6QKJskO2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467266; c=relaxed/simple;
	bh=YxC82tL1E4DJB/3vs4w4SFCHjE4ulRqhfUum5bE3dwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ry4kak0bSVwWcRJKwinMKizCriVS6jD24wkSASsdupC3zXa+jonXufvrC2/ZQVeOCHvuraDq0LPoK/K5lpFeWQWXaFoUE28Zy5kvnDs/TP2OqMGyH166Sbat2D5CbZXyehJ2hMrrdN+9ePFD0UVoPIhxyWeUP9w9XEZ9YOOGMIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fkijzwUg; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAIGKF6BG7r87XhDp0BhrRoYtK2vwLKQuRbu2yAoS0MW4VDg7IsfoKkRK8z/ANXrH7ECEFb+6L7lSDLouQDlqvVSspqVwTAOxMwkh8gGJ8i5WLOswJIn5vtXKYH6N6AiV216vSGHsDW8pFhvagD5owZJ3tuf1FWlxRkjREgyawCQWawpu5nu78PsDweUX5eIJrQPFS2ZcXrePc6W274s7WH5bL1ttv3SUm8E0GKI/HrBmdRpWPnGa6m0u9JzXH+REKNkYjke/0zzfLnqLDKeNHqH1fOuuA9282454AmpBXVlh5CQfFOH9nSTDuee5UXNeTvrPJlfqLcy+GX7Wt/RKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt8hIUqyOge39P67f9sAop0Vs88HgwEgpniDi851Mvw=;
 b=knSPFEffgZxIwL/Pp5uOBuSIo0uKfGLGow1KUQRwdLQmRFlCyuhmZoFAcISuXcWoAJKpDOvhxAGXmzWzq325wnjSUEsBD9B3fm3cyBIC4EhVqdia1h6/WJq5JNo5ceKWv+rB2VTs6UVYCyN3EG6SEe1OiVT4jVLe+LR8YfC29FKtCwpF/SpT9vC4pNi+gDm0QPjhFM0Xg1d3QDkwoiW4YIgfZ0/DH7j9KXhOn+D+ywZTXfb+Zrsd35n+iojIYNGqF37hVsDqAXGSZ/3C2L4RlWKWskbNKqQmIFx6eajSVjPokZPWxamAc3DCEcJvzn7HQqJc9D4ZZPXLbzAbLiXfpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt8hIUqyOge39P67f9sAop0Vs88HgwEgpniDi851Mvw=;
 b=fkijzwUgQDPwUYUwp9uObldjTlFMuN5qfQ2SIqEVUDzw5GJiQ8a1Q8Oqgn666m2+OV+dgeGNKujz+r1MK+QryLbRGnmKQ1FiZA5HOUDet02Dml+QvMac27CZEB/kl8M673Zwt2SAgxYK5EamyG5/H4n6WcsF4UA4xK/64J+mifxknqDr6LeNTVlAproK2/LqUMViccucQlG17op6RWty2UdxAZR6xeE5DFnqY1+w6o5oWTmQo0MBnb5nx4j1/BQsqdTytK0cHX4BM6s1PwzmAerwCw+nHHEZccVMx3MAX3J4uYQYk5o0Xq68SDWdKpCShqbBLrWZaZGvqHWB4Ff3Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 14:41:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 14:41:01 +0000
Date: Wed, 2 Jul 2025 10:40:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v19 01/10] PCI: endpoint: Set ID and of_node for function
 driver
Message-ID: <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
 <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: c45412c8-e8a9-4a4d-32dc-08ddb97676c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUwveVNNbnRFWkg4NUhWUEVFWFU4YXNvWEw3MUNMaWo4STdYbVRjaXEvNHhu?=
 =?utf-8?B?NjlEZXd1K3FzdjNGNjlnWjNkdXIzYkFTa1cxQ0FRbzNYbTZ1QmloaUJNWGdP?=
 =?utf-8?B?VE1FeFIxTXFxK01UQUNsZ3ExWjhLSmE1b0loa0ZXVEJCSnZjbmcwc2FVSU5N?=
 =?utf-8?B?NjdkYTBKMVN4SDFaV1luRzVETHpDNVZ0M1krYXlaV1BOYmNKMnBPTnl1OXZ2?=
 =?utf-8?B?Q1JzL2xIeFpnWjhUNXhMcDVkSHRIamVvOFk3Q1ZkQjJ5Z2U2TmVMdGc0Qlgx?=
 =?utf-8?B?WEVnU0trdEc2YkF5LzVFSllmWFlPak1FbUpWOFV1ZXlmbUg2aUI2dzFSTzRz?=
 =?utf-8?B?ZHZqT1U0SU4zVUhJbWpoSUl4V3M0MmdwQ1FIakVVTmU5MU95eUtvK0FqNkZ3?=
 =?utf-8?B?WU9jL1BjVEZJWkx1ZXlpKzdqS0NBbEJUTXlsZ01HK2hhQzd6Z1lrelJoSnpz?=
 =?utf-8?B?bUltdWxmV2E3TG5wQXM2aGl3d0F2VWJVOWZnVTF3ai9ML1k1VGdpM3Y4OFgy?=
 =?utf-8?B?UFkremVGYnA0aHcyMnl3bW0zbmZQUGx0bmVmcXIvelZ6eVdETFlaa21iVFpZ?=
 =?utf-8?B?TkRKcmRPVXliT0JvY3Y4cFNQYVU0L2dqbG5pVmdvQlJIS0UyME9VZE1JSnk4?=
 =?utf-8?B?YkhpTjdLeTZKR3RNMFdOektqWUg2cWtxSUNRMk5pYTN5WldUK2UxRUNBNDh6?=
 =?utf-8?B?YTdlRHRRZ2NYc0RVSnp6ekEzMEZHdXFYOHlITVBvK2ZJQUhHU3l5WHpxdm83?=
 =?utf-8?B?MlhYZk1vM04xaWlwVnFUUUYrWTZGcW9pbzVxSmlyL2NmZ0g0UzEwTzByN3E4?=
 =?utf-8?B?eHAxWm5aN2RiWjZUNzNyenBmYWJxRWI0cUh0MUpuY3RLWnFOQjVmN0tOQ1Rq?=
 =?utf-8?B?RkRwdHRWUVc1WXhKWFJ2SWNOckd4dkxPSkJRemxLQ29JeHU1czEyQTRLa3l1?=
 =?utf-8?B?RElUQndYNHd5dHpFU2NhMTFhSFU4ekw0d0YvdmVlaDNuZ1JicXFLSzM4cmdV?=
 =?utf-8?B?S0lIZFpTSzFNL0ZlRysxUGt2SWRlOS9ZSjlCTUQvdWN3WGF3TmhUSTZBMnhH?=
 =?utf-8?B?QXFPSkxBcHdDL0VvbkE3TVg2Z1V3OHFpLzZGeHFzSWdPTjQwZ0d3RzA5TElQ?=
 =?utf-8?B?V1BrWGprUGNtUVpTTFdGVE52Q3Fsa0d3YTR2WVJIVGJLTUczZkxzK2F3QmE3?=
 =?utf-8?B?aVV5YWhCSkdacXlwcDV6dFBHRC9vS1NsRGJ4WUdEUmJuK1NBV1BPY2gyaVdM?=
 =?utf-8?B?b2xyeHA5N0dBV1pudTI1QW81cUxGOWhXODA5NGFoMHNKekNYV2krTVhveDZ0?=
 =?utf-8?B?VG5nRlNIQ1NHYk5pNlpkTHdIU2NBem1CVjM1ZjBFR0wxNEFmU2ZjTzRVd25Z?=
 =?utf-8?B?ZFQvblBZclk3bURncDdCRy9ZQm9XeFhwbTNkbXQ4OVl3NWV3WURZZ3cwWlFQ?=
 =?utf-8?B?ZkdkeTcwZVZHM3lDc0FRWUpEUjJTazFoZEJNeGxsNjJZMWNHWmVIbXk1eFJv?=
 =?utf-8?B?bVlGT1IrWWhDa2JyajJmcTVndDFXZ1dLWkcyTHV1WjgvNyttc2NpdWYveDlk?=
 =?utf-8?B?dGlYSkhuVVZCYTFNcHp1UFUyd25hc3paMzcyQUVRWVJiNmZPL1VVazlOTElo?=
 =?utf-8?B?d0dpTnJyY0FnMXoySXVJbWVpZ0FuejB1RXVPSitJdDRNNU9GbDk1bmtUYzRS?=
 =?utf-8?B?dHpKMU9QZjJwSFFQSmNITzVxZVlZOXVrQThCMzVKK3EwTEJ5dWYvR0NkVjZo?=
 =?utf-8?B?WUdCbTB2ZlkwZ3p3cm5JWitLL296THcyN2F2c3lJUmdUSjlQSWVrNSsyNUFH?=
 =?utf-8?B?VXlPVlpFbVRnTkN0R1RXTHU5ZGlKKzVJNkNXbHppMno3VmprK3QwQldleUtV?=
 =?utf-8?B?WklLSzFYQVRaQ3NnN2JZQzBzMFlaRVU4WWVHKzhPNWU5Szh5MlpqUEFvWmp3?=
 =?utf-8?B?SThmdUxmM0lnSVc3bXFrSUxkUFlKdjg5TFJac2x2c0FVMlNTZmFqQ1FmS3Ry?=
 =?utf-8?B?Z3VXRDV4bE93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0g0dFliSE1XeUZDUy9ybFZZYXUyaDl3UnRlSE5EeFNNUnBaSXVPd3hVV2h6?=
 =?utf-8?B?NFBJNXkrTGNIRk5HTU1kMHhKSjhwZm14V0tMWEZXanBqRExmQXNrYjlpQXJr?=
 =?utf-8?B?ZmJMaE5aOW9uNDA4OGtVRXVDWDZQZHRsWm9iVkwva2VCd1dyNVJmZVNXSGFo?=
 =?utf-8?B?MjZZK1pFK21iSGVYUnlPZ0dQcFBKNzNmeTByVElvSW9UVFUrbS9BY08rWmFX?=
 =?utf-8?B?SWttQXN4RXZuZ3lPZUN4cTM2QzdGM0k5OU9JeTJUYVVocUhrSmtLOTY0aUxp?=
 =?utf-8?B?ODJyWm9DT056Q2xXbWN3Z3FqYUJFNmk2Q0w5bkU5RnFSbldCNk5uR0hicFVo?=
 =?utf-8?B?N3pTQXhiRHZJd3hvOHI4NXhRV2NMUjhRa1ZBSXFPRnkwNnFPQy9CaGtmQ1Yx?=
 =?utf-8?B?Z3BEZGpycGFqcXlpLzVZT0EyT21WTXhMTXZkMW1XTTdTbGFOZkplTytvOFpv?=
 =?utf-8?B?alY1NlhqSkNxT0tLYjJuMFhic1BzYjQxb2JkYVYxUi9sajFnWE5kN0loeU53?=
 =?utf-8?B?OU93UmxQNEVQaVlxRkNlV3g4akQvK09sK1dDZnlBOVB0WG1OVHRua2FCWmlm?=
 =?utf-8?B?eWM5djRUWDJVWFp6dUdmL3RaV0Z5L3RPSWdSLzIwTmlZbVQ4YzFtUVhXQkJS?=
 =?utf-8?B?MHIxQXZJQ2pHL0lXUFoxMk44d0NUMXBqVTRKNFRFaFcySHMxRWNydTQvMUJH?=
 =?utf-8?B?dGVkSEpCTjI0NTJ2R29QZ1ZDM3JsTnpLL2N3RFpQdlFtKzhlRmVBY3lwdG1F?=
 =?utf-8?B?NXkzQzFKdkE1b2dzMUo0U1BEd0hZSnV1Qm9yVmx2aTI4c25UTlZiU1M0Rm0v?=
 =?utf-8?B?N2UwUEkvWm9pam0xcDFCanVJcm1HY0tzZkZkVlZtbHVrOS9QTWhtWDVzOFpt?=
 =?utf-8?B?MjBCdWFMK1YrQzkvSTRIRC9mVjJCdlV5N0IzMENPVERubXBiVHhLVjlZVENK?=
 =?utf-8?B?WWMxYllBS3Q2YUw0c0RMRENCUXRyUmhwbEFxcnVKeHJSS2ZJbWk1bzExbG9i?=
 =?utf-8?B?ZjVod0JtQnplSGhXdWdvd0hsbVlHL25aN3JUT3JRRjlSNlluRXdvWnJORVhl?=
 =?utf-8?B?cXRWV0hGRWxyYk5OT3Z4Yk9nQnVoVFpybHdmZDlIdi9nMDJjN3hXMjF1cDVD?=
 =?utf-8?B?UHFkaW41R3pjeHBHQngzL283UnQzQUNmV2taZnVrbjlQLzZTd3JqaUZoQ1Bp?=
 =?utf-8?B?RSt0eHRFVjcvc3FZb1U0TlNLQVB6aC85KzV5SXVtRFVRWWhEbWY4TitzMTBp?=
 =?utf-8?B?c0RVb2cxYTdJaVMzbzVWcjBpTFhvOTEvVzNDd2hsZ3VrTDROdU9kWXVqY2xy?=
 =?utf-8?B?c3hzS0FHa1RheHBYT3ZSSGNFTGRHTENvWHo3QU1EZks2YnlscUJMS2FtMnFD?=
 =?utf-8?B?enpuTlJoU2gxU20wZEkwemVDN1dRbTJTWkdSVGhhVE4xdTJsQ2FXVEpLWm5H?=
 =?utf-8?B?dDgrSm9ONDhOU1M2T0JjNXJQT0hHMnZIM01RYmhwTTMvUHl6ZXNSM3dkekMr?=
 =?utf-8?B?MytydTRFOXB1VmJYK1pISkowdFB3MjgweHlkMVFyWlpKclhUVUFhSVFkZ1l0?=
 =?utf-8?B?NEtEaVVudlJjOVFIOHMvV3hHRThYclJGN1RyZ085UVl1U3UzVUZXYlRoQ3NW?=
 =?utf-8?B?ejhuaEhxVmo4eEw0VjJxMWlvY25QaDRBNnJ5SW5uZHVPTTVYN1ZUZzU0WTMw?=
 =?utf-8?B?M3IvdmN4Vm9UUTZXdWM2Y1lWa2FIcFlrb0dFVGFGdVN3SmpybldwSFJjeFZq?=
 =?utf-8?B?eGRiSUtra0lad2c4dGdyNG52RmliV1AvWENMRHJhbEpXSFlRQzlqZTg5Y3Vr?=
 =?utf-8?B?ZEZFWXN2ckI0cTYvb3NZbzgwRWpzczA5UFpEZHlCUWE4TXVTSnRleUhhdklh?=
 =?utf-8?B?d2VQa0N3Mlk4cXRrb0RQUUZ1WVlRMGJ4RW9lNC9udGE1QzBWZ1VMeTNWMDc5?=
 =?utf-8?B?aWVZUlE1OS8veEF1a29EVXJLTVhsbjE0TDFXb1UzSHFKZll3cHdRTnN5MzZ5?=
 =?utf-8?B?b1ZTRWZJVmdLV3lrVnhsUUxCK0FiWG15K2hMbldWS0NVa2x0Ti9McmRrVzJV?=
 =?utf-8?B?N3RHejBTQkFHS1V2cUxuRGYwbXZ5NVJXcUNKQVBSNEV4WVRVVHpsdjN4YTV4?=
 =?utf-8?Q?2/hthnkhlSuTVCVank55KXfpf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45412c8-e8a9-4a4d-32dc-08ddb97676c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:41:00.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQPvLs3O6X4H7c0LVDOu2fW/uR0JBn+lzxfS+PI9sPTx5Kq3Ptdspps6upm1bVEIXhMp5N383oIqn61K9vNPTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

On Wed, Jul 02, 2025 at 04:30:48PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> > Set device ID as 'vfunc_no << 3 | func_no' and use
> > 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> > device.
> >
> > Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> > settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> > functions use the EPC's device node, but they should use the EPF one.
> > For multiple function drivers, IOMMU/MSI should be different for each
> > function driver.
> >
>
> We don't define OF node for any function, so device_set_of_node_from_dev() also
> ends up reusing the EPC node. So how can you make use of it in multi EPF setup?

In mfd devices, children devices reuse parent's of_node
drivers/gpio/gpio-adp5585.c
drivers/input/keyboard/adp5589-keys.c
drivers/pwm/pwm-adp5585.c

multi EPF should be similar to create multi children devices of mfd.

> I don't understand.

>
> > If multiple function devices share the same EPC device, there will be
> > no isolation between them. Setting the ID and 'of_node' prepares for
> > proper support.

Only share the same of_node.

Actually pci host bridge have similar situation, all pci ep devices reuse
bridge's of node. framework use rid to distringuish it. EPF can use device::id
to do similar things.

Actually iommu face the similar problem. So far, there are not EP device enable
iommu yet, because it needs special mapping.

Prevously, I consider create dymatic of_node for each EPF and copy iommu/msi
information to each children. But when I see adp5585 case, I think direct
use parent's of_node should be simple and good enough.

In future, I suggest add children dt binding for it. For example: EPF provide
a mailbox interface. how other dts node to refer to this mailbox's phandle?


> >
>
> I don't know who you can provide *isolation* by reusing the EPC OF node. It is
> same as using the EPC node directly.

why it is same?

Frank
>
> - Mani
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v14 to v16
> > - none
> >
> > change from v13 to v14
> > new patch
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 4 ++++
> >  include/linux/pci-epf.h             | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 577a9e490115c..95fb3d7c1d45e 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -120,12 +120,16 @@ int pci_epf_bind(struct pci_epf *epf)
> >  		epf_vf->sec_epc_func_no = epf->sec_epc_func_no;
> >  		epf_vf->epc = epf->epc;
> >  		epf_vf->sec_epc = epf->sec_epc;
> > +		epf_vf->dev.id = PCI_EPF_DEVID(epf->func_no, vfunc_no);
> > +		device_set_of_node_from_dev(&epf_vf->dev, epc->dev.parent);
> >  		ret = epf_vf->driver->ops->bind(epf_vf);
> >  		if (ret)
> >  			goto ret;
> >  		epf_vf->is_bound = true;
> >  	}
> >
> > +	epf->dev.id = PCI_EPF_DEVID(epf->func_no, 0);
> > +	device_set_of_node_from_dev(&epf->dev, epc->dev.parent);
> >  	ret = epf->driver->ops->bind(epf);
> >  	if (ret)
> >  		goto ret;
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 749cee0bcf2cc..c0864935c6864 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -216,6 +216,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
> >  	return dev_get_drvdata(&epf->dev);
> >  }
> >
> > +#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
> > +
> >  struct pci_epf *pci_epf_create(const char *name);
> >  void pci_epf_destroy(struct pci_epf *epf);
> >  int __pci_epf_register_driver(struct pci_epf_driver *driver,
> >
> > --
> > 2.34.1
> >
> >
>
> --
> மணிவண்ணன் சதாசிவம்

