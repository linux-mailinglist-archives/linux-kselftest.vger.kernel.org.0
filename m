Return-Path: <linux-kselftest+bounces-9740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615288C05CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840F41C211B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E142D131725;
	Wed,  8 May 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S4J4JgYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7F225D9;
	Wed,  8 May 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200869; cv=fail; b=f5eFe7+C0TG8JKPlykbS2PcPCgj6yw1C0xzpOMUx+pJlVJmJ7/NhuW+JU+lpJ6r0Hi+InasOThF0Vh/kuvSthy/syWrdsBdH+t66FYyXLAP/FMGEZxQoBUxmceeFrhDmOpH4vnzPZP51njYl7JmndgJgXFDKcJzPG/m3Dm9c8bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200869; c=relaxed/simple;
	bh=6I/7UqVjwA+snHwbZXefxxrCaYbneFpqVQTnDQNLM/A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TiZZi9aFuZc4hAXl4zqHrOUImQAcXL7Hhu3tE+wJU4XvBkgArzDAG+xiDigF4MN6OWLrsW+sB0pt/I/asPJKWR9njgm3f4DND/hHa6y6W8mxiWoRFYjwdnanrNy77CRRHOnOTM+NIuQ2ih29tWxkYNBi64hmSxu13Z/JrNNti3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4J4JgYk; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuiJ+rOTIjaxMHj2oCyYlh1WkR6TbfF2/sOWBjJDvYTjxk8H5onaxmjpce37vEl/9naIF4B/Z0gknTXjDVwV20P8pwcNHNgSQFAq1UCiLKGK19nkoMon194slmi2CxweAFxghX8VVIYu/EcL6iY+T0Jvn9QTUMyD9nAVIUQM3ZWFfXYloYRA7/rd+KOH9BWbDPyJxOpdkBJbRip2/Vt5B7VEDSguDpVIYnDn1Q1N9YP2SMVyCGgX1s0lrLwD35xKX5MSS5qIWDIvtP/a1WD7OAbD5m8EPD7WzN8bw3bBzZSYOpxRe7VqPlXE9anSfUtFEJdKwDkloqzZDN+fj87lxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD/lFxLf2LFO94FzGaqfGfKiDFEvpFbehGYAWrRa9kU=;
 b=Gw54CfEkAPmjS5B20T35KCLr+QgO+2WGd4j03+0mmVvhKz/384mlLEjUIqOYKQXHYk6HFBNly5IzZDf5+hlzqCDlBpFsXfK76PESN9We6CMxQVkJo7Zty4VFaRm/1pQImPNfSgTpSDEs2QGmtb7cwyf1cNW3oLfmTnlenfjDHjRKioqlYBql80EDKiJG87BGSwHfkiAURR0GCWNVXkPi4l3rrbYwFB5/SV7zCaDpXRRgNhQBxeawtbpFBjcvn7tEcOMV2i17dOdQhXUNT3VbYShdjrEPSGpwW/7lyItEaj95tSvi8YtQkfrIRal0oxeesu7w6544bKoC2FP5pUyZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/lFxLf2LFO94FzGaqfGfKiDFEvpFbehGYAWrRa9kU=;
 b=S4J4JgYkFd3PIuFJ/AJZYQ8eAqe65M3/2eEr6WTY2P5rffoJ/FNwjAs6XzngvKkB7QaigwroimJTK0X4y0ODckESqAJDriJn0B/VQGhJMdexUANVfgdEufgCcq6gs0+i8LIkGBw9dIN+eHKFfXuNLwVq7fQEniM8FB8gnBTcQxP6VO3LE1yq2VrddTPLqjlXhRNZ8sx098jhjLO/Ro8ks6N9UCS4YawpxDsZFdwCHx5INEN34W+mcHgV9DAdXOHP4hQ8x1J0sQolU2Xc4L/lSCY/oNZBLnC0LPyX1hmoCPW3Ef2epRQvU8zFt2Qc8yuUxs/RXpRisJBfxS+33ARg0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 20:41:05 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 20:41:05 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4] selftests/resctrl: fix clang build warnings related to abs(), labs() calls
Date: Wed,  8 May 2024 13:41:01 -0700
Message-ID: <20240508204101.277146-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: e95c536c-b83c-45f8-067d-08dc6f9f2e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejRhdHZrT0VqQWZwQTVta3BVSCtzSDJKN3ZrZFFiMDRVdlllWmdialppbVNw?=
 =?utf-8?B?RHE5RTFyVy9YQjBLc1M2a1Z4YStQWEwwQURSQzRmT01iUnNXeDcveDBnYlRs?=
 =?utf-8?B?RjlRVm9HMFk1WGwvUDk4akFDNlRqeE9XMmhvb0l5b2dnUlhicjM3WmtXOGtx?=
 =?utf-8?B?SkNsY0VjRk5pVlVUNEtvMWUreDZtUTNKRFAyZE1JWE4xNGl1Z2pNdXpDWjBF?=
 =?utf-8?B?MlFSZk5JdXJKZ3FRV0U0T2ZMakIrMzRCVmh3UzRZOXl0NmZOQW1TWE93WkJ6?=
 =?utf-8?B?TWFrNjlOTW1OYVR4cUU0RjljQ0ZxaHdmM2VJMHBwL1RUdExFLzZQQ09pQU0y?=
 =?utf-8?B?dDV3NVVoLzk4TVNxSURoTzg3OTBQL1g4TFRUQ1FIWjh6cDJpUG9MbEkxQ3kv?=
 =?utf-8?B?dkFLRkZKeUI0ZVNhMHFESVJxOG91QlpsNWZmNGpwd1hJcXlFWnppblBpTUIy?=
 =?utf-8?B?N05lMFl0TjgveUczb0lLNWJVTnA4Y0t0K1JuQUZtMlNycWVVL3k4ZTJhc3p1?=
 =?utf-8?B?K2NzMFBJYUREOWtPbUVIaTZkcUJKbWJ6WmZ6aTc3Y25qdkdxbFhaZW1MMUh6?=
 =?utf-8?B?a09QV3hOQlNtc1ZaeGlRdTRsQVhKajdPU3pVUnhmNFZJUCtvU09sZmh1UVor?=
 =?utf-8?B?ZUdmWTN4dTB4RUFBaG9CREhCMVB2L096UEtxazNjZ1dORjhMUGZOY2NyYWVP?=
 =?utf-8?B?RS8zczR4R0pQN3R0OTRuenpwWENiOGRHeFFzNFhMRFlqQkYxWWtrM2dJK3lV?=
 =?utf-8?B?NFdVakdLK2lQTllBMDFzNFQreEN0MnJEUGxIbjNFeFRvMlFiZ0hBR1lnSm1B?=
 =?utf-8?B?QmVSZTZIdzE0ZVd6SkphVENHTC9hSkFKdjhueU16U09BdWtzejltRnN0QjFk?=
 =?utf-8?B?dHJhTWtONnZNMU01QjA1SmFya2txTU10Skg3TWtZaktoUXVyZTg1SzBJK1dD?=
 =?utf-8?B?N3hBUENaRDFVc1JjcDk4VUFTOUVhVWh4c0tNdHliZ0g5RHhPR2xYZXpUVWVC?=
 =?utf-8?B?cFl0bVRXK2R0MnBWOEtHMnlhNm11UzJJbEVybVhQTytqZVh6ZmF1WTdBSjBj?=
 =?utf-8?B?cUtRV2VCRWllTXUrOTlLeGJ5NDFwS29McHhiRGpKVE9CTm5lK0ZPeERMYTJw?=
 =?utf-8?B?aDFQRWtibGR5Y05adkVwM3RENHZrbHF1Rlp1SXN5bWhwRlVCdXNWemxOb3Nx?=
 =?utf-8?B?d2h5elg5YnJWdmV6OHNiQlRMRUF5cXZQY2x5cDVkSUZzeGFwejgvREpJN1lj?=
 =?utf-8?B?ZGVoWUtobUlZOERwQ0VNTjdmU2N3YzJCU1FFcExrNEpURDcxMUJvc2FPN2R4?=
 =?utf-8?B?ei94WTNIQjZ4dTZiYTlwZjdjNndPZEsvMG1zdGl5L3IwWU9CeWJoU2VSSlZE?=
 =?utf-8?B?cHcrNXFVeFRMaWtWVE00UFo0TmFYNVlBTE1nOTBSVFpLNUtDL2tiV0dtV2gr?=
 =?utf-8?B?cjlCdC9WSk9ZMjNZek1Yb1Y1OS9EeHI4MlA5em04THN3V3RJWlpabVpraVVC?=
 =?utf-8?B?bXkxM2s0Y29YdXpEY1oxSHVuaDUzcUQyM0w2dU1EWmNOMFFYZTVsNnVEampL?=
 =?utf-8?B?MUd6TTNRRXY3VHEvelJzQ3BXaE5zS0FqWmVLWTJpTHAyYjdhOWtKT29RQkNT?=
 =?utf-8?B?K1ZhamtMaHNZeUp4M3hWQnNxRUYyWjAwR1ZVeFlKdlFwMWM5MGszRTlSWWxJ?=
 =?utf-8?B?MFZoeHVYaHNpWkJKbUhubjlLOVY0b0luaVdJbHYvbWF3UHRqUmJXTERRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWpua1hFdDlGd0t1bkF5YnJLRUlOb29KWFVyVVU1NG9rTVNNUkpDTGZjQmQy?=
 =?utf-8?B?VW5NV2hKR3oxMTJOcEZJUS82bkg3dldZYW9pYXI4Y2l1cDl0S04zOTRaaXMz?=
 =?utf-8?B?TWRoT202eVJueEErTy9hVkR0a1NWZlFydE1ndzE4MHhEOHg5WWpmZVNhbVU2?=
 =?utf-8?B?eVBUL25zbVJBVHNIaXdvTkJTS3BSeWw2OWpmeGJmWXNYcGpucHdnUlNrUUQz?=
 =?utf-8?B?VWFmaVJzYitzMzFSaEdUc2JaODZpYm85WjFJSnhNUzZvZit4clQ4ejN1YnZH?=
 =?utf-8?B?bVhnUmVZRktYQkRNVnJYWTJjZ0gvajZOOE1OZUdhOTB4VXZWMGJ4dXZpUnkr?=
 =?utf-8?B?amt2YzNPeU5rdDVhVFpaNjdGRVdSNHFUb0p1U2kxSi92SFhIanhiUjZhdDZk?=
 =?utf-8?B?VWk5c0x6aGFjSXR6T0dONzZrWWdNMkFGV2xQZk51Z0tzeVR6MWNUUDl0VjVs?=
 =?utf-8?B?d2ZwbFdobEJpYmNLWmxXQlIvd21pVFhHU0c3ZVgzS2o0MWlCRTZHRS9SSHNE?=
 =?utf-8?B?RDFWcnd4cWxHaW1DcHhxRXlDb3RRbGlkWVVkQ25pem9GR1lCL0tXSVdYeWlQ?=
 =?utf-8?B?TWZLTENTREU1N0wvOFB1RTBpbnd0dkt1andsNm5SQTFwbUFZSDVXNGd1eGRj?=
 =?utf-8?B?Vzh5TmtVQjB3ZmZjQStXR2ROT2UrV2h2bTR3Wm1oblBlQXpoTzQrSFZrZlF3?=
 =?utf-8?B?SjJ5VVBZSFdVVnptUnpURkNVRmNYajBUdXpiUG9aMXgwVkpaZHMzT0ZqQTZ5?=
 =?utf-8?B?dEN5ZHRPNnN4WEdxUnZqR2QrVmJMMWtCYmFpeHdiZWxJZ2E3azhoSWc0Z2lr?=
 =?utf-8?B?RDMzdVhYK0lRcEk0MWZ2TUM1c056akRZRjZlVm5oQVRvMjdqdjNvcnlVeGFC?=
 =?utf-8?B?WVVSU3JVZGdXcTlRVmtmRHN1d0diYlF1YnBOSTRIMEt2Y3EwV1Bod0o1aUFE?=
 =?utf-8?B?Vlh1RzM4cW5QK3U2T1dCbEtkVkxNbmlRVU9oNW1GaXJwUHpTWnNmWStnNlFh?=
 =?utf-8?B?UGdsRllQUnBtRVlXU0ZqbFc5N2dzTTZFOVJJQmtQZHNyM3RJRHNJbjBxZEtB?=
 =?utf-8?B?UUVaV3lKTTZBN3VoTW9HM3BuaXlVMnpSRGgzK2hUMkFNUUg1NHl1WjFySHpO?=
 =?utf-8?B?a1Yxa2tMd0JiZEhlaXlKUlRCUDVtMWJBV1orM3d5MFAyRFJvNVVyV1dOSUh0?=
 =?utf-8?B?WHVRbDVwRmRkT0lCZ1ZvTVVMLzIrcWpWekpDNzhQSERLN1dHaUMrVy9kMHIz?=
 =?utf-8?B?VmVPbnh0eXVBdTJydXJvK3BZR1FKZFRQU1ZwOGlwZFJ3MzkyMXNGT2JvdFRr?=
 =?utf-8?B?SlpVT2Y5TGljamkyakMxUGV0bUN0aEdoTlRzU3NwSkRYUHlQN29WTmpjNGc3?=
 =?utf-8?B?eVFNLytUSlZiZUYycWpNRmFXRitjcFVuVXBWWlZzamVyT01idE82aGdUamdQ?=
 =?utf-8?B?LzlZaWlFOExUenNhcmp6VUxDRDlIazZ5LzA1KzF0WGpKMzd1YWFKWG0yMHJr?=
 =?utf-8?B?Y1R6NkNvalN0dzlRN0plK2dpZjhFYnpJYkttRG1IcWxKbitjWU9PU2FYcGd5?=
 =?utf-8?B?dmgxM1FnTU5vZUltN0VWTEJZUkV2bXVPRFQ3L2xFZnFSMUNGYjVyMStqV2RO?=
 =?utf-8?B?OWI1UWJIUHJ4bWNLK0ZDY0R2V2FEbnI4VHp5dW94cXBxdmwzc0dqZkhEQWxl?=
 =?utf-8?B?RTBBWnpyR05RbksvNnZDOU9MejZKTFI1NTJocSt4RFhtalZqaUNxS3lBbENo?=
 =?utf-8?B?aW9JazlCUDlDYzh1Ky9RSHVxelJySXQyci9mLzQxZHJqNEVYVmJ2QlNVSjV3?=
 =?utf-8?B?Y2oxR1Vjcys0ZGZoUnIzUjhrSjU4MElCTDZYeTFJZ1NDZGpLZHJFMTR6bzho?=
 =?utf-8?B?WUxFcjJ2a1hmYVN6OWFKTkNUSUEwTGtzU0ZqalprS1FOSXphZm1oWTFGTXgr?=
 =?utf-8?B?SHZUQTB6eVRzd1E1QWtGWHhBb20wUzZvSmxLZGNLdlRRRko1eWphM0VVSVAv?=
 =?utf-8?B?NnRNMGoxUDlydVRVYUZaN1A0N2NDeTBOYWZPL09lb3gvOXpmNmhLZVRyVnY2?=
 =?utf-8?B?YnppQVFIQ2F1R28rOU9KUVlVMmNaVTY3UHBJZkY4MXF6Q2dCU1RyWG9ZRUtv?=
 =?utf-8?Q?JNhh3ecga1YCe0Wzvn+Ad9Jmu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95c536c-b83c-45f8-067d-08dc6f9f2e75
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:41:05.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+0Z4MapgZXm0wd/hZ2DiB06p4wujaLYWWMbUK5N9TmtJhSD0oo1uSx2Rz4oa7f8jeZoidgBxwgHjrBuX9qz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...two types of warnings occur:

    warning: absolute value function 'abs' given an argument of type
    'long' but has parameter of type 'int' which may cause truncation of
    value

    warning: taking the absolute value of unsigned type 'unsigned long'
    has no effect

Fix these by:

a) using labs() in place of abs(), when long integers are involved, and

b) Change to use signed integer data types, in places where subtraction
   is used (and could end up with negative values).

c) Remove a duplicate abs() call in cmt_test.c.

Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
 tools/testing/selftests/resctrl/mba_test.c | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..05a241519ae8 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 	int ret;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	avg_diff = (long)abs(cache_span - avg_llc_val);
+	avg_diff = (long)(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
-	      abs(avg_diff) > max_diff;
+	      labs(avg_diff) > max_diff;
 
 	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..8fd16b117092 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -60,8 +60,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	/* Memory bandwidth from 100% down to 10% */
 	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
 	     allocation++) {
-		unsigned long avg_bw_imc, avg_bw_resc;
 		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+		long avg_bw_imc, avg_bw_resc;
 		int avg_diff_per;
 		float avg_diff;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..252c94ff2a3d 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -17,8 +17,8 @@
 static int
 show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 {
-	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+	long avg_bw_imc = 0, avg_bw_resc = 0;
 	int runs, ret, avg_diff_per;
 	float avg_diff = 0;
 

base-commit: 45db3ab70092637967967bfd8e6144017638563c
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
prerequisite-patch-id: 8d96c4b8c3ed6d9ea2588ef7f594ae0f9f83c279
-- 
2.45.0


