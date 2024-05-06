Return-Path: <linux-kselftest+bounces-9550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAFE8BD498
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7424A284A71
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E37156641;
	Mon,  6 May 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="m17UP0zW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E31182CC;
	Mon,  6 May 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020247; cv=fail; b=S9ALc785/3ZBJwb5S2ojXJ4ZaRgmnBAAIzkXwMbkiLbJJZLsb0TxJs39Ahu3oxT63hmSWt53Xi/LyyV2+A4UihDGPdgM/6UskW8fNylHK0pC/mMXK/LYOfUMuGc8/jVOAE4FUNA6BTzoK6xcf/MnIZEJjE04qO4d0LChm8FBKgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020247; c=relaxed/simple;
	bh=pDjpyAmLc0tYNXUAcuj+QKo3N4dZ3uW0gIlKtClJeRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fN15oOdw2PTuJttXDKxy06WpAA+E33SHEB2o3BfzuQCQEU+rwEYVLPDV4d7m4Sju5z4xtiD/YJAkNlapArcIcQBGvkCGpiUQFevQhNu0bRmnmG8xlvxbgcBN7GmrfBwU+19Od8RNqxYIwzdJIf8zSansVharHvjpC9r/Q3Yz4x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=m17UP0zW; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446HFLLR006231;
	Mon, 6 May 2024 18:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=5EOZV95uEGv4yXFEEMtFfIfQxHEwVB7mWsMi9ULm/Do=;
 b=m17UP0zWJRiA6Yd7NJh/cI6DVSMFEb1AgmZGuZiurDn8Jd7S7e0MXd0eK+tAGvQJ9bfA
 ac5uy4OFvqqi9q83rbvCklVbgovVqLqgSIUcGaZA0q4y/IkPYzte5eL5IJ/terPcWznQ
 WtEFi6PpkVDYalxyJ4CmdybxjVTtkZWKzO8QZ++4zDWf7Bv8whTEd2EcwGF+h9QyksKB
 BpSRrb4sha/0VkgDxEfKYCzLAvAwbROtDSN+aZ/mhB4OsM9lKv3KGG3nT6YxpviDeiti
 MPablUfUrdDiEgkF25Yp8KqeijGrePjHRL/A3uwtyYcXKUqmbI+eHatYjtvplxynsgCx Aw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xwb7ht0u4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 18:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luno1VOgGAnkTYZ4zoXCFxnwhsZMjOlDYonLaHQv9cPgN3VlKL6oFK9gN6LaUwWh0R/mPmctuTHuyox18pmP/+SI/+axDBPZBgaEM0+LVrVwPJKcMomNeA1/JU5srSUIuluafylGFYr9c0xOxQPFboxP+qOKz84LaMXHzlX35dmtCYQe/cab8CI2llpZGYtOeUEwHgcmD2henucVOpZ0J0v+28g9Tmhmp7N8bQdoa0dLbMPBjpYAOV+5PzPsMIcVYJrCoiSqTWgtRd9PLkIFXDkw/2gAxIOxhGZkwjuCABaSj6srZOpk3huHKZn5/jjZWITWSFVJedmNorQF0n+qgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EOZV95uEGv4yXFEEMtFfIfQxHEwVB7mWsMi9ULm/Do=;
 b=IyVEIkLG2K8GCtHXyqtEjVB60QLtIpmGzA5+wIbtOnKjt4uA9OTEUqrOxJpkJx5Vke7fIAIlh/E0Sg7GpMHdQJihnaxCM7rmiYqB9BEUmGefBQrijI5dGntAke3YlG2L6kZZap9hCKA471JAHLTorRTCqpsKdCwISJVq1GDw7/e5/+0lRU9jTCsE0Ja90yzz86cxhmtBszjLNdImX6AJLrdv/S/vM63tg4aA83QEPWNNpOw9cciJMJSl5bgHiTi02B+jMDnuA7tiCDjZisP512609HZotENcVi1zoi/83mj0bFSndT3E8sTEYQoi+gwKP56e7MJTuoSat2l/qP67+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by CH3PR13MB6996.namprd13.prod.outlook.com (2603:10b6:610:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:30:02 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 18:30:02 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Wen Yang <wen.yang@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: SShuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@google.com>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt
	<rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] selftests: introduce additional eventfd test coverage
Thread-Topic: [PATCH] selftests: introduce additional eventfd test coverage
Thread-Index: AQHanvs9FAxJ40hn5k6c626r1bhaQLGKiF0Q
Date: Mon, 6 May 2024 18:30:02 +0000
Message-ID: 
 <SA3PR13MB6372229283A34550FD52F913FD1C2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240505144648.18347-1-wen.yang@linux.dev>
In-Reply-To: <20240505144648.18347-1-wen.yang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|CH3PR13MB6996:EE_
x-ms-office365-filtering-correlation-id: 13cc71cc-20d0-4cbb-5c8d-08dc6dfa8b1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?19tb3MksaZaosvgJ0nSFHxMT0TL8BGXPrt6LS4DZ5UpkrC6ovAOAkEO5bNCq?=
 =?us-ascii?Q?4XRW+IpjqWyOlA1aIv2fJ4+Y7Dix3QcuPtAcavxcwC5fiM1n2VJQaP7Ie5ir?=
 =?us-ascii?Q?s9do1k3N6+z48pZyLiCHPiKEgS2n+csCFo5ZnAwp5OWeEMz9j4GBIDnCjNZn?=
 =?us-ascii?Q?RyKcvEghZ4R8fGiXjpSvENvkKYMpqQAhv8WEZr3I7O6K7OaCoic29dVJPeOz?=
 =?us-ascii?Q?8jaZnMRUBzmEE3ILKPrW2SUlZI+5SorINBeLKAK35s11pd8uM4E30x8ku7nO?=
 =?us-ascii?Q?CAgaASNmTwafYv2wLKrxgcE148WmpBOxPKUj7ZN3Ng/Bn5RQRLFSbZgJkZbn?=
 =?us-ascii?Q?JjI9zBx9+fBvsH/+YcUvFWWoTEa8IhzcB9HIXH+rv2QURlhHDuydIN7X2+EG?=
 =?us-ascii?Q?LbrBUgPpM42FZfgIIqrRhvLaBmvFAtZQj9wTfTEpEVFSt8FfW9sua4obl41o?=
 =?us-ascii?Q?Z7Y7GbrlClKYXlC8t34LXqwLucaMQEml+BXgxr7vKbaMDN2vsOQZzhKqy4BT?=
 =?us-ascii?Q?X7rsDV3XqfPfPilsxG6rPYYbQ9PB9ALPenZP1VpiZSsZEGNd7fw+0cCxebHI?=
 =?us-ascii?Q?04/CzSRVPz6ltdIvaYY6bJP6ATwpwl1uztCwfnb8K1PuzztpoX49Lcp6GUWe?=
 =?us-ascii?Q?4C/H/xxSIKWxKir9wDbS4A2wyIU4nuYjUqWo1JQEN+P1S8rTJDUOeSMzEw8s?=
 =?us-ascii?Q?K0QmWqTrLr1mnSjDDQNrF8QgJK6jm4msiCaT6jvE4YCveS414J45PlTFrhWF?=
 =?us-ascii?Q?7aDTKngdZMg1Hy0d/B1heqpflJV5XUIPwgVVngi08EykPTW/qlLZdY5UinJC?=
 =?us-ascii?Q?zgiuwd+LLvxAXZlktK3yGyDp4v17bEsDYdcEvLX52PmNFqkhVDFYVhlvJXIT?=
 =?us-ascii?Q?7Sj8AT8EOTCQJWe1tIksARBtZgGWyWgW7HHEuIzI4G8o5yHCkBw8S1NZESp2?=
 =?us-ascii?Q?LQtgWZLSh7/ziPMgUCG+4ZYvFM1Di8m+2DwcYy+T1k+DLucoMvVMqjioIc2Z?=
 =?us-ascii?Q?nSzR1K+Wx1vBa9WrlJHFvqEq4oHYy9qTCacGNMzfeKZV7dRITKNW/CKfRTst?=
 =?us-ascii?Q?nOPGZAeejp1Uf+Hhzx/x2tHlvhM9HnzkWIDJYM4K8otipDZbtQfF2vRrSluu?=
 =?us-ascii?Q?JNZ/q5n+EF5uvPS1eHKzsDxidguiKSux/1a6Pb1x4kLdVLJ7nDAtW3bJZWQS?=
 =?us-ascii?Q?mbhin23V+Qhb8whJgUemXRMf45VbPqtnTLCg3pca8RnCLJV8YzztprXN3NsZ?=
 =?us-ascii?Q?a1lV3irFb0w9SnDJm/cmHxLR2Zt2ohNHndAqAfGpqO3ZQK+vx8stoLh/ahm3?=
 =?us-ascii?Q?kQc6ac9IVtRObxF5KRqKxOmXnAKBI0R+WEK2r/o6U75NHw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?igNFPOHZcDaFnrsf6Eqqu7gk59fb7JAqpXqrUhefdAOknD1c+vV09RkC9jdu?=
 =?us-ascii?Q?W+sT6ryjUv+Tgdwasrqf3LvmsXb8VpBHWKgF7rbSkIISoZ2hxFLn72sgomd0?=
 =?us-ascii?Q?bIszHX541ka0OV/3e7C1g+rZ906d4flcqVpFfn8PhcIItZcWKdKpQJBYn8EL?=
 =?us-ascii?Q?GIFfwUC8bC4HvFkTTXXH973JV895bfNjl/+tKnDl0SGkDCn7qwY+2f4vb9+s?=
 =?us-ascii?Q?xpWbi9vltpF75m7o2L7wN74QsFYUO9wB4rSGSdX61ItNXhYJjlnrPuDRYkyL?=
 =?us-ascii?Q?B+cKPANhRb/M7pXwH4xkQuC4YwY+60ieoTEAlR358JL4ZNxHwQFFMbcS5943?=
 =?us-ascii?Q?bbX0IUgYAFVmnfVzWt0mVAnKchz9PxnDN0I+hDtruV6YehKNv090pWdAXr8u?=
 =?us-ascii?Q?FjBIvT9jvdiiEZL31sjpc3l6pxYWhSy1IvsE6dEvAw0XXV5RCVeS296mf0vn?=
 =?us-ascii?Q?mVxkH0vQfROFsPLElW+I6CRQbhmpp9UNKXjalxAdTNbX+janDsuONaKef/Op?=
 =?us-ascii?Q?szCnb9brAPTgaTsO9oqrLgGfMRiurhXbTaJCvIGw4qaVZ6cNo/wcGb7zl56k?=
 =?us-ascii?Q?Ky6YwVwZ3Tlkkp6XyUwaqRw3XQX8EHXFSg9M8jWT1K38YBdYtIndf5TPgZ85?=
 =?us-ascii?Q?PdomJ+tXr9P7d0AHPVi6D9mauayWoliQu0XPRBKNfRrSI7fBtBTwXVa65PVW?=
 =?us-ascii?Q?0Zj8YuE4mgv9sPAO7G99SDOAEN8izqLEpctYgrm5b86rl6Pn0fppccsB0rQL?=
 =?us-ascii?Q?MYDChfCprAOZNIn840ygNl5/efn5DWByQTZgLdEh7Rb7pzXZw7s730Uo0/5O?=
 =?us-ascii?Q?LkzSsnCT1w1F21L5tdTqPdOOTZCKgVklXSHd7L5znTQEhMeHFTRWUMd9Xp5Y?=
 =?us-ascii?Q?mhuT7mRngzRDbhlE+YaOgClphtJEyZGLX/duX1paGLR5bTUU8+Wb0Agycpc6?=
 =?us-ascii?Q?26S9MNI+qmHinIYD14R08WVMzh4eO6fFKN6kAfQqhIAYsxAlclSH3dpPLqDc?=
 =?us-ascii?Q?9Ye+A+tMOE0dDvK2quUDPoeEuwpGM7URMzZ7hqnpqUVKwyS6Tp7KJ2dDTxvf?=
 =?us-ascii?Q?nBOHkl8pY+sMbBcp/zhRAqMbhwpjatns0dHiN0clst0mxMw0AMGTZIWivNNW?=
 =?us-ascii?Q?q9eBL/IH9pSDbe9IZyHyNlwrlZo6/m5axCe8iKQxH/T1EwG3FW5xXVQKUPTX?=
 =?us-ascii?Q?HkA/elnpc9XuwUtlhNr/CdWjRRclHzGS5Nh5mDl/WPYKifS5SWDfxqgdlxRu?=
 =?us-ascii?Q?NHvY/m1q7pcc4UibYpVv4rnFpI2WJ0q79sMXe7y5T6mC4qz0LIcpwlXeMnzw?=
 =?us-ascii?Q?aVN4G5JqbV08LGuW9IZVjJIW/xHu9rgoMMR4euIszABvLt/TuSm52B7tJqyR?=
 =?us-ascii?Q?hGHvxRxWMe7HwYxElBGi7hzPFsA7neix6xIeaqcpHrilAhBd8LSgd6UWy34W?=
 =?us-ascii?Q?Fqr27CWf3yMdGtPm1TDvF6J5I5fsIm0KQdmRbTpxGmJrgPjr+qC+9UKlsb7W?=
 =?us-ascii?Q?bUhL+3Si5ZsaG3EWp8oGG9uErteBCmH4589K8MORx6fUmKQnfccqbfQweF5h?=
 =?us-ascii?Q?H8rHYY2X3AYhmBs6geY=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7RJvKpM/LaCr3e10VsRAdt/FlpJx7EC+zAD2ZoUKjXqwtflhWIS3eMnVGenb7kWKWiXfF3fpF2+YRrbt9QhCtSB5IvsR+PPNqBqTkLwOFdGFkaSMTPLYrpfiQ4VwAfV6vy1pD5aRAzx7ofsYNMi1R3gNWJwYYRrrSeBopVvjUJDq8tbFvICYjanoInhifW5znhIxQd3RvCIVMgSQqkRSII73a0hQsfhwmqSxJtjVuogwyqrYo1ImPZjKgoRlc1FYCUDWeh8r2OxoiDEiegnSeMS5LrgdozYwpvzrzet5wa5HXBTk8GNyAMbImtiLEGlqYp0Gr8mg/VtJPp+1vmYYUP6qYs72OYr0cT+JADTJVLka6rzw/Dtn9MGSAlTl6PEIei1EZRRLzh19wVEy20yNFWIfo4GINyNy9hhgsVjlJG2pyYYyN61/0B/tyjp0pGKIOmkAXQexEgL7Xa594L5NDtgtzpI5ub/9HkNcpC/fS0CwpsQALgCI/LnC6EhuF+yd8U+EmmwfxGVEOsxAf9eQGW9mAwlzrCkLfXTIbqmQRiP7a+JddoSNUr2SDLwAfH6tCHD94FrZaVLup4RYGm0qCFdGsy+K3lC+hXLrfwOsth20Fss6Uzlff0nqUxExXd+p
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cc71cc-20d0-4cbb-5c8d-08dc6dfa8b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 18:30:02.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtsWZYJf8dxqMMPWQ0MUBlW/g1iQiY/f6V2NFlyMshYF0g33itq5/NmSl3N6PBFSYeaKDCU01I+e3uWZGNGTIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6996
X-Proofpoint-ORIG-GUID: -IE7KEZsgApLh0oMp0Og9J3wziULzeU8
X-Proofpoint-GUID: -IE7KEZsgApLh0oMp0Og9J3wziULzeU8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: -IE7KEZsgApLh0oMp0Og9J3wziULzeU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_13,2024-05-06_02,2023-05-22_02



> -----Original Message-----
> From: Wen Yang <wen.yang@linux.dev>
> Add several new test cases which assert corner cases on the eventfd
> mechanism, for example, the supplied buffer is less than 8 bytes,
> attempting to write a value that is too large, etc.
>=20
> 	./eventfd_test
> 	# Starting 9 tests from 1 test cases.
> 	#  RUN           global.eventfd01 ...
> 	#            OK  global.eventfd01
> 	ok 1 global.eventfd01

These are horrible test case names.  Can you please use strings which indic=
ate
what is being tested, that are useful to a human?
 -- Tim

> 	#  RUN           global.eventfd02 ...
> 	#            OK  global.eventfd02
> 	ok 2 global.eventfd02
> 	#  RUN           global.eventfd03 ...
> 	#            OK  global.eventfd03
> 	ok 3 global.eventfd03
> 	#  RUN           global.eventfd04 ...
> 	#            OK  global.eventfd04
> 	ok 4 global.eventfd04
> 	#  RUN           global.eventfd05 ...
> 	#            OK  global.eventfd05
> 	ok 5 global.eventfd05
> 	#  RUN           global.eventfd06 ...
> 	#            OK  global.eventfd06
> 	ok 6 global.eventfd06
> 	#  RUN           global.eventfd07 ...
> 	#            OK  global.eventfd07
> 	ok 7 global.eventfd07
> 	#  RUN           global.eventfd08 ...
> 	#            OK  global.eventfd08
> 	ok 8 global.eventfd08
> 	#  RUN           global.eventfd09 ...
> 	#            OK  global.eventfd09
> 	ok 9 global.eventfd09
> 	# PASSED: 9 / 9 tests passed.
> 	# Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Cc: SShuah Khan <shuah@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Andrei Vagin <avagin@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../filesystems/eventfd/eventfd_test.c        | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>=20
> diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b=
/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> index f142a137526c..eeab8df5b1b5 100644
> --- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> +++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> @@ -183,4 +183,120 @@ TEST(eventfd05)
>  	close(fd);
>  }
>=20
> +/*
> + * A write(2) fails with the error EINVAL if the size of the supplied bu=
ffer
> + * is less than 8 bytes, or if an attempt is made to write the value
> + * 0xffffffffffffffff.
> + */
> +TEST(eventfd06)
> +{
> +	uint64_t value =3D 1;
> +	ssize_t size;
> +	int fd;
> +
> +	fd =3D sys_eventfd2(0, 0);
> +	ASSERT_GE(fd, 0);
> +
> +	size =3D write(fd, &value, sizeof(int));
> +	EXPECT_EQ(size, -1);
> +	EXPECT_EQ(errno, EINVAL);
> +
> +	value =3D (uint64_t)-1;
> +	size =3D write(fd, &value, sizeof(value));
> +	EXPECT_EQ(size, -1);
> +	EXPECT_EQ(errno, EINVAL);
> +
> +	close(fd);
> +}
> +
> +/*
> + * A read(2) fails with the error EINVAL if the size of the supplied buf=
fer is
> + * less than 8 bytes.
> + */
> +TEST(eventfd07)
> +{
> +	int value =3D 0;
> +	ssize_t size;
> +	int fd;
> +
> +	fd =3D sys_eventfd2(0, 0);
> +	ASSERT_GE(fd, 0);
> +
> +	size =3D write(fd, &value, sizeof(value));
> +	EXPECT_EQ(size, -1);
> +	EXPECT_EQ(errno, EINVAL);
> +
> +	close(fd);
> +}
> +
> +/*
> + * If EFD_SEMAPHORE was not specified and the eventfd counter has a nonz=
ero
> + * value, then a read(2) returns 8 bytes containing that value, and the
> + * counter's value is reset to zero.
> + * If the eventfd counter is zero at the time of the call to read(2), th=
en the
> + * call fails with the error EAGAIN if the file descriptor has been made=
 nonblocking.
> + */
> +TEST(eventfd08)
> +{
> +	uint64_t value;
> +	ssize_t size;
> +	int fd;
> +	int i;
> +
> +	fd =3D sys_eventfd2(0, EFD_NONBLOCK);
> +	ASSERT_GE(fd, 0);
> +
> +	value =3D 1;
> +	for (i =3D 0; i < 10000000; i++) {
> +		size =3D write(fd, &value, sizeof(value));
> +		EXPECT_EQ(size, sizeof(value));
> +	}
> +
> +	size =3D read(fd, &value, sizeof(value));
> +	EXPECT_EQ(size, sizeof(uint64_t));
> +	EXPECT_EQ(value, 10000000);
> +
> +	size =3D read(fd, &value, sizeof(value));
> +	EXPECT_EQ(size, -1);
> +	EXPECT_EQ(errno, EAGAIN);
> +
> +	close(fd);
> +}
> +
> +/*
> + * If EFD_SEMAPHORE was specified and the eventfd counter has a nonzero =
value,
> + * then a read(2) returns 8 bytes containing the value 1, and the counte=
r's
> + * value is decremented by 1.
> + * If the eventfd counter is zero at the time of the call to read(2), th=
en the
> + * call fails with the error EAGAIN if the file descriptor has been made=
 nonblocking.
> + */
> +TEST(eventfd09)
> +{
> +	uint64_t value;
> +	ssize_t size;
> +	int fd;
> +	int i;
> +
> +	fd =3D sys_eventfd2(0, EFD_SEMAPHORE|EFD_NONBLOCK);
> +	ASSERT_GE(fd, 0);
> +
> +	value =3D 1;
> +	for (i =3D 0; i < 10000000; i++) {
> +		size =3D write(fd, &value, sizeof(value));
> +		EXPECT_EQ(size, sizeof(value));
> +	}
> +
> +	for (i =3D 0; i < 10000000; i++) {
> +		size =3D read(fd, &value, sizeof(value));
> +		EXPECT_EQ(size, sizeof(value));
> +		EXPECT_EQ(value, 1);
> +	}
> +
> +	size =3D read(fd, &value, sizeof(value));
> +	EXPECT_EQ(size, -1);
> +	EXPECT_EQ(errno, EAGAIN);
> +
> +	close(fd);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.25.1
>=20


