Return-Path: <linux-kselftest+bounces-5814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF9C86FAA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 08:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D85B20A3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715B13AED;
	Mon,  4 Mar 2024 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="MO0qmrPk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB047134A3;
	Mon,  4 Mar 2024 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536957; cv=fail; b=PkGAcOvTIj818RdEHZLpL3XSTrixVA6OwouG7LAuSoynSPZ7Q8C6IJV9qVSZrUKyM/AfjTwTcnX+UkG+ZZKnS5VzXbtIBH1dXSjpjTGx0IYVZm7vT8gFTxnjdJZ4Pbll/oQbVtBIyQ16ZDPhMlgvyAshA7wPDePJxVOTptHE6cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536957; c=relaxed/simple;
	bh=shH8ZWCgeHNzihz1VC0GbToJnf+nqHNbbLP4T2mvDdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WmWZyLz7fpsFsJ80ZuCx7eXer1MwlRUgT4O2tpZbB+7LGFSo8MpwP6Db6BWSA43/VrqXXWvPDYM9R4rze3h0KHXLBVEp+bVFRGh1SbdkyD48hVJkONe1kBtFTUQEz/Xa6E8usFnNI23wSm7xeoUli8vZWCRJKjFWm49K7nKVF7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=MO0qmrPk; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXZpG6LhjPY7MYGLTl3iZyfBpq8IU8rZMQ0YAC6SMyVmE3eBtT8BOU+pA5nfK4Xqpw5qIM+wof30gPsdTjITjQ/VCZpT/t0COfZUHYHzZwd2YdgAYu69tSfPNEWP7CSp3ZtpF/trnF1tIQq+zvmNAJwwKHUaBhKDREoBXa76gMyLFPZi3DNP8zyU53Utj3vUVqEuGQtBVgzs6sBRg2IwrtrAArGAusA6ilX5BINjr0fsVNCDFdsLPdefTSki3AfutABdy1PG11Z510NboRsaPejcGioPsQ+sL3T2LMw8bmYr7fl91JPcx54jesRFlub6Mj2A7xb7Y7UaC7zYVCL3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDr7kQ7N4C5Fv9m+3hLfFosAE4soBb/1s0hyoD1rzvs=;
 b=V2HaDl5Z99iO5VVQCVZCh6lDXnv1IJtzYVztcWovpa9anCSA7xv4FqhE3BdKz+o5RawCA/eWUvS0QEP8XDH7QMgyQFlEdlcCksj29FF5qKDZOfKq8/rtN2F/AccbdZJjLw9KQ83d12MVBUDjwU0RjmdAjjNQyoaTu02+cTlLaz4X3IvNOnZm2qjxSKVxW5ukn0rL74fXiml2P/qbajWsxDC/tp0AF5/5HsTQD8i5Ua1JBr6XQx3QOrRuw29Q0+VuwgkzGWs5o0LtpGX6IrD25Rbwyz+NnXFdzk2WG8rn5jml/KudnsxdCcrcefqXHWS2194gKh1cHZtxfrWL34VFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=valentinobst.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDr7kQ7N4C5Fv9m+3hLfFosAE4soBb/1s0hyoD1rzvs=;
 b=MO0qmrPkLNVeCxiE/Airkhiv4prVYVqM1NcmgTrMG5d/WA1jua7R1L3GCIfboJwUKvP/ELnRbvhORV8trLlKSFbOcjAjXOK+7Ckl+Wka3zH1ODx9d7aQ/pKkIfV2yIes1zRvuoKY329jIcypwVcjPsmwuzJc5IKkdelM8fgVRZUrSbPJJ5FWZJbg/ZLSSClu9GaQUqpkH2nRxAWHKSh1DaSX1u6gViS4056GBF2P1LaxJQ+HEXOS9z5UZZVYiYUHw4HN6RrwZmYYvyRpYP0owAacC48g66gyAHHRFvxPAAA0DT0U/FQumyAETsBZXROsW1yarhnIK/PRdy7eWH1AzQ==
Received: from AS9P194CA0004.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::32)
 by DU2PR10MB7765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 07:22:30 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::da) by AS9P194CA0004.outlook.office365.com
 (2603:10a6:20b:46d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 07:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 07:22:30 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 4 Mar
 2024 08:22:29 +0100
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Mar
 2024 08:22:29 +0100
Message-ID: <3f61c6f4-f058-46bc-a7b1-ce4a397a06dd@de.bosch.com>
Date: Mon, 4 Mar 2024 08:22:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] kselftest: Add basic test for probing the rust sample
 modules
To: Valentin Obst <kernel@valentinobst.de>, <laura.nao@collabora.com>
CC: <a.hindborg@samsung.com>, <alex.gaynor@gmail.com>, <aliceryhl@google.com>,
	<benno.lossin@proton.me>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <kernel@collabora.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <ojeda@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <sergio.collado@gmail.com>,
	<shuah@kernel.org>, <usama.anjum@collabora.com>, <wedsonaf@gmail.com>
References: <20240229155235.263157-1-laura.nao@collabora.com>
 <20240303144857.22733-1-kernel@valentinobst.de>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240303144857.22733-1-kernel@valentinobst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|DU2PR10MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: ee09fc0e-b23b-44d7-d7a5-08dc3c1bda82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0EgRfbgPmmAvdjTshyM2E49HYf40rEx1L4ynM+d+EgpO5Fdf4P+yippUQ4vxHXUyKQy/Hlo2/1JV0C7auSz/53UaZOezVJPF+MxdMqHNAds9fmJGfhRPukOFs+bYbZCvxXmWr0xBsRVXFKrhIPXmiNL18cHRori1HOAAg+0u5w7rV7vG8oKtdnFQB61g2/fOQeo9JWU/khj8O0oX568WYFJUTcWKO0B5WWSCo/eHb5p8vlOrXWotiGE44tjrIXyMMY2Pdzqc6Rrdq8MMv8kqBdDf4CQlREY66OC28BP53H99aa2MCIVELlZww7NAGTd3pqhs9PoAaS0KW5GBiUXkdgWYsIsC1mE2yYNB/jSEisoiDsNNrqh+jnVVH9tQXlTzRj4AadsalIq9aUOv4bsBL4Xg/mNEF1jaZ4GePfdStQM/Up8oeoX3sA5y5C0FoCMmuDKBXLroanvK1WCtXEbDrjjGfimxjBv/RMG62AJN3K3x8si77ZKkNcxX0NtzHvOeZTI7QhEGeafKgKCHNlWJ7NohbyaV+i9rR96x57BoVQkJD/BK3Wi3ZV8wzI8oRXwDKtV4TpvL11Y7KibJS9fkkiGGT6L8sAbrZHlc5tVXO2a9IZEqrTIYCzgd7dsPhVBDeekDV7TO2fYTqR64lvtdjYuq2jql/7kUpt4xCfCpS6PHffHEbPw0bgHCIL8h4xHj1L375Hda/AOnF4oJZFXNQA==
X-Forefront-Antispam-Report:
	CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 07:22:30.6621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee09fc0e-b23b-44d7-d7a5-08dc3c1bda82
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7765

On 03.03.2024 15:48, Valentin Obst wrote:
> Perhaps we can also add a section about these tests to the new
> `Documentation/rust/testing.rst` [1]. We could mention that they exist,
> how to run them, and link to the kselftest documentation for further
> information.
> 
> Not necessary to resend, perhaps we can do that in a separate patch when
> this patch and the one by Dirk are merged.

Yes, that sounds good :)

Laura: If you like to write some basic intro as proposed by Valentin 
please do it against

https://github.com/Rust-for-Linux/linux/blob/rust-next/Documentation/rust/testing.rst

in a separate patch.

Best regards

Dirk


