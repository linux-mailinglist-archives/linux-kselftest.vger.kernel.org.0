Return-Path: <linux-kselftest+bounces-25222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68761A1D4B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 11:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B768816560B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240E3596D;
	Mon, 27 Jan 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HE3TbI3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335321D540;
	Mon, 27 Jan 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974726; cv=fail; b=YxObtX+LIR2tK9N+8UjnXx5CUtQ6ZBH28r9EVan0edlvmT2pcYUG38+w2NQ0Q4Om/ZZE2YfTnIQ+Qq3yCihvVU05ZgUunh1mNpkmneKE3NLsV6PoYTig64Gokcto/DN726JxObh7tTkHH9y2UP8XOuGK0VRselAyPwUkxBKjgr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974726; c=relaxed/simple;
	bh=rcBQ0EDrxXhXWSfvD7UGflIPrQ6gom/AqcHE0h1hJho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W2shHJtE9rYpw3jIEELFrtqtlBGQHyZyO0GCdevM2Xmo+dlgohfb0SINs5hoDctICAR+/TWQnuzbVSMPt7goUVTFg32Bwp0Ayow8v2IVGG/kVEYtjNVa7LefyfCflzpL+s6Ts2xUYoN2f5Yu06GGb/VXDONl9GIiczkGh7bLKGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HE3TbI3+; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlTwkH88zoNu61NkKrK5Lh4Suyo88m8O3NgB7HWN/3MUnVJvhNBR4o7TPb0eRFKRauT5bc8UXKRjwuoqINA0QIpm/yyvqC7ZqcTYDjTrQ4TZb6A93izvHexDWniKvl5UwkDPA1kP2mFDHRn6LkgvF+7GgoCPNn8DQbq0Xj3CBsARKcJOYT/zM/MR6FyXAUm5AguE782YswO5fwRh6xET9Na8bwMAgQEnKsmV5nebLOpL9ma90JAar+E0z05r9/AIzbzf9ferFIt1Pcoo/0yli4sKpnLxMGRoKh5ddBSqxpXTOgvoeP19lq3nRVcBwFMPZVD4tfWLM6t5mFQWTabJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcBQ0EDrxXhXWSfvD7UGflIPrQ6gom/AqcHE0h1hJho=;
 b=WG+v3Sh9U09IOCJn0Yb/PlT8o5YV6iVixgAwVNM6oRSg+Yx4q5jlGJ7e0rCr0KKE8Oo1agJtINOAFrOzRu84aIhK7kn3BnO98eVlyLlumuFQlnoQmOKquk1esQAolvqKbiOzqp1IZphgBStm2fKPGWJKp4t4nyao0NvH8zX8biT/065PFbp73eEdHVYPsCFy8ZrBqbG7f7emXZYXFH/clZHGR6FjBqJlkulLE3BX9kvTOlZG30B2VnGi5dgI+iSRx0y4v8g9+YNJoaYq2l4NIp8wdM1nXruA+PS7AEqCBzCCjUUSSLzlOdefjSUMMxj+j+jcmvP7cb+EJdzIsg7lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcBQ0EDrxXhXWSfvD7UGflIPrQ6gom/AqcHE0h1hJho=;
 b=HE3TbI3+O3bkaZMxJ2QVkZUF7sIagV+bEaLxNrvly1DWKhDr31gBw71VXU+TMHAyMQpZYB9/EptoqnTlUTKs62uAxfnSAzcTyrSeCiuhmU/OnmUHbeqYiTU70zBJxTP12hHy5buCi96eePmfP4SXBVNJIJtOy+ik8RMupnTSS6HkEokFvEucMaUN+MvJmU53hP7BF6ebl+R1RFyBLH0xUU9OwIA4xmQ+A4RpN4GToRYGBGuqc7RQ0hVR2lPEXhqHglpedGFl2JVurF+65C3NZodG9anR2O7ZI1o087X+AI0eTs1TAZRAF9sqmmj5q7PGTEvKifq6gOVYsan6snr7gQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 10:45:22 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 10:45:21 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "razor@blackwall.org"
	<razor@blackwall.org>, "davem@davemloft.net" <davem@davemloft.net>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "liali@redhat.com" <liali@redhat.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, Boris
 Pismenny <borisp@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net v3] bonding: Correctly support GSO ESP offload
Thread-Topic: [PATCH net v3] bonding: Correctly support GSO ESP offload
Thread-Index: AQHbcKgqHR0megussk+A74Cd/aIoErMqb8wA
Date: Mon, 27 Jan 2025 10:45:21 +0000
Message-ID: <47227635d220ffd8941b65d778e23a578707aa96.camel@nvidia.com>
References: <20250127104147.759658-1-cratiu@nvidia.com>
In-Reply-To: <20250127104147.759658-1-cratiu@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN2PR12MB4304:EE_
x-ms-office365-filtering-correlation-id: 6cfd666d-6a06-46fd-9768-08dd3ebfb2ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?An09JGWf7BVj7pWbepMOyGj0WSAckrag4TSm6lOs29oiFO8xSE863v9xEQ?=
 =?iso-8859-1?Q?liowJ5NMpaCLCP+dWlNpP9ibI9IRjJZT1G9AlzuXdgWD3SsWukE/pwIWjg?=
 =?iso-8859-1?Q?JbVTAEAl/CaA3+E6AVtFpX9u+FXUTcpFVB/g1FHEuKGKnIVpZ/BEQZjTAM?=
 =?iso-8859-1?Q?h/OJ/HJSXVqm9KpvS/8Fo3fV/VpfwOiaO0bP1cpoNPy66TK/1C5/+Ec30o?=
 =?iso-8859-1?Q?zsuNnnkWGLvUjNqg0ssYcKZetPRwIPD6c3/ppiPW2cQWecfR8Tx7ax8TzI?=
 =?iso-8859-1?Q?1A9W1/9HMf2e9r4gCOTaRWcDRCfY7hyssPHwRVb96DAi5rZfleMFgAG/FI?=
 =?iso-8859-1?Q?6c8tX5HY2ynfRtWmQTMxDQ6qJEVqHeScqrO8lW1ZhjUGCmAVy2IzHC7WWC?=
 =?iso-8859-1?Q?O6yFcDiWrOVenGerg6YLcyjxbB+/3M1xOXEnpCUEuznsl8TmlQ+GxCmB2T?=
 =?iso-8859-1?Q?iDJnu5re/6DnYOY0RkBaolJ6+18qlLVDHsAIkkZJRUNbNAvjI2qwqLOFn8?=
 =?iso-8859-1?Q?vyanEWXCIGKcYY+dZ0ffpXGfzFzMbuiiC8+0M1u+Bada+6nJtxZlK8ohEH?=
 =?iso-8859-1?Q?G5jS3N+rBJrYvcuWJsK4lFvlYktP2j2vpbPtZxwIwA0XOVAImomBF9ynWb?=
 =?iso-8859-1?Q?q3QowgCB9aZcnxPfXX6C1WMrzxpZyPqoCmiu4ZJwFNY1hBONz1PQ2jo9c4?=
 =?iso-8859-1?Q?VkM07HvfLfd2jzNaj6UfkPklBBw1p2Aw4OUyNwp9XH7QgBgf2iRahFLebX?=
 =?iso-8859-1?Q?gcQYm0TLAc9H3hA8TIT4Lt/whK+OxJ8so+dT/8iJvUJLtMpt+ek7Ev/wZD?=
 =?iso-8859-1?Q?nvGIPR64QPy7plkguIIsYQjp/gQ/UAvg8bewmVMfkOHCqeSES9lpeMDo4W?=
 =?iso-8859-1?Q?2fhGkuzub52WqptaUzoyXuJj0z0cCJ3N2HgrshpJSiHCVwf6gSobQWXxks?=
 =?iso-8859-1?Q?lhiJTF4zeVdUZUUtI2NxDoJHsmouIzNHTu0lokqIyCUCXaERiXoDVwigIC?=
 =?iso-8859-1?Q?wHmXeMHPU+toHEYw+0ICNiDjIDebaHxBQI926eeHhMQ4y2OMcYD4rN8hgp?=
 =?iso-8859-1?Q?CTZJOVzd5G6K+ZClenk6FlzH9YMEdQ0sPjjzMkcry12GTGg+osRUTj9yoB?=
 =?iso-8859-1?Q?apcCAvdczQ2YxDBnSPF/LNTB1WcfRyFTmBv6vrSHiq0ZJgbkxnkBbrxKQk?=
 =?iso-8859-1?Q?rpxZsWLwjLzz1MWJb9nkSj00VgoFnh7OtBNJdEVt22ayPqDYKxoH7SVlwI?=
 =?iso-8859-1?Q?BBMtQ5YrnCbUdDYPesx/RP4nFsUZJ5l4YP826AUIXlKe+sol95hs3Yh5k5?=
 =?iso-8859-1?Q?7+IvelvgxynD6xbAfUGJbh17h7U85sot7tD0Va9LT1UJDVk0722JHzWzIn?=
 =?iso-8859-1?Q?76I0K0mcgUcCgavXIESr/XZXUlyDl+y3yp8CU1q6zkXriX5dOFCDCCTeVD?=
 =?iso-8859-1?Q?0cc472xqSbqDMFaSqu3AGt4nFVwPYXQCR7OOW4FP0C7R+N5aD/vDgVpJKC?=
 =?iso-8859-1?Q?2ZRVUAmsmc6wz5Idqc8geu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?98UYNqIF57U1OD1SpIMacQLJ4FcDB65GuTxDgIkaTkjX8ehsRZBW8OoVqB?=
 =?iso-8859-1?Q?0zZ9VVTXmAbItdDZ3LHY9rf0OkAZg8YHrjOQQ7FMMANm5DJRkGTBaAAk7S?=
 =?iso-8859-1?Q?FRNC6PTl7S+o5wKngQUfZ2E1qWeq9/2OxlUkHmDnhEYtNh+0+lUD+ac3qm?=
 =?iso-8859-1?Q?vbm6WSlsB49r0OK9RyyAqvyBjN03XYpgU9L03SgchjxsDyueFMZZ/wsJUc?=
 =?iso-8859-1?Q?RWIQk/E2d9iCvYfEtveqNN7lqbmAQu5iA3NNHY7OkEolvlyz61sDeExof4?=
 =?iso-8859-1?Q?qbPxowvs2CCtS49ap0UUXKabQDY9ceB/7suG9w2CubET1I/CX45jEy7H0D?=
 =?iso-8859-1?Q?wos1rV3U6hWivzTnfqLj98JFd+nwP5DOLEWlzNrikuNzFDxrRz1N+YZuAH?=
 =?iso-8859-1?Q?/2iUKkorgqteTEyrUZQyI9XHAEi+Mbdnro2ZG0C2RBL6m4kcDmQS84knyp?=
 =?iso-8859-1?Q?j7IdE41T9XtGPy7urPrE0Wr9Eap7xR2j1r9QgiHUA3dSFY3RtF/uGAKyCT?=
 =?iso-8859-1?Q?aGRW/ynR/olECU/6zLkpDw3nkz6nSzu1Pq8ir53MRszoyaMfhDuQsBUs9N?=
 =?iso-8859-1?Q?nELTd2XEzHWCtv1Ng1nzgpaM3pUm5AQRfqXqXb55pEPJkkjD0Mjzx6GHNb?=
 =?iso-8859-1?Q?eMN3y1vf6+KKLn8oP9Hryox10AgzHjTijhY2EqNZwyeb4aYxG4pLfCSM5m?=
 =?iso-8859-1?Q?tdUoMkTom0C86qkQOKV1bQFnIVatzG6kD9CM0enj1BBuxBYLf0I8AO0xAT?=
 =?iso-8859-1?Q?IWHJ19T9O+GgO4CRVYrwu6bipwiafsdCJ0d7nGLnu8Zy4SB9rMD/qFrA49?=
 =?iso-8859-1?Q?l0OIAktTtmRlPliW/+jvThHW8o0muRTo1R7WaHwQRfEQd7bDgDC8IG2A4u?=
 =?iso-8859-1?Q?DYLFCsZj0V9KXKVL89xEM4iUkJ0TOYLF1coM/ah35oRfmTDQkU/mfBus7f?=
 =?iso-8859-1?Q?QJ/wxSIFN4Xhk2cQoi54+4bl9i/LgNTgC70+66UaHQOouoKs/9hcEi6L6y?=
 =?iso-8859-1?Q?hUKw/aqGE7o0l1DDwg44hg6NfUPLv4Mns8d/0PVmrsrslnsjvmQl6WAhdH?=
 =?iso-8859-1?Q?GQcBplkDecU4wdIhfrbeH1YXXeafAVPUcCZV/JSetviem6YWiKTKVKdE8G?=
 =?iso-8859-1?Q?EkITqSHudTQS3SIJ7LB6aYoKH2WHtZuswNguxuAv6QkXdcszUxg4Z9O7Hj?=
 =?iso-8859-1?Q?I5/EHsPcqtDmjr/dh0i90LytFzhzPeGiva/ZJQYVWEvGGJijMtcQDwBQ2/?=
 =?iso-8859-1?Q?GGg9oNveIRLAVGEAmuNlhLvN/bapQyQJfsqeRQb42t2WZ64fs2H+BoxN49?=
 =?iso-8859-1?Q?E/6WTil3msg/fEScak7maIJDhgHECnkDImShMfjQ3tH+Rc/iKeFrTKAxUG?=
 =?iso-8859-1?Q?A1mLJahfa7sElrulAjmiVYFQfdWiQzc6vc02EGNklX+ypx43Z/NOAE2Igv?=
 =?iso-8859-1?Q?o6ITXBRxXxSWBiPt90cFV6rofZi6Q32XaDE7SQQJ1DaaV1B1GaAqDr4EQk?=
 =?iso-8859-1?Q?PzA2okPXHWJeNnOnmMs2FLA7Kow2+k1aOo8a22g6aGiCtSVjx9o+/XNXGH?=
 =?iso-8859-1?Q?lNP1+bkBGQIln6Me/58Gd6Citx5kaxdVLivD2t2sOoFGwH7xBw9B61vntE?=
 =?iso-8859-1?Q?zyW26OVSTeukmze+w3fpnGXntjovaApK5F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfd666d-6a06-46fd-9768-08dd3ebfb2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 10:45:21.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXWXrllMUPTZ/hzywSn9c2kx0B675ODjw7S4VTGxsZd3gMbpqdygrcXzBa1ENOdLHxs3M+ZVfwnTUtBcUuJVMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

Same as v2, but I added Hangbin to 'Signed-off-by'.


