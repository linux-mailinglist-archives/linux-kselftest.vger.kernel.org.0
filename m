Return-Path: <linux-kselftest+bounces-11986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B184A9094C8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FE31F21E53
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF761187578;
	Fri, 14 Jun 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tI0Nn/6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227A187550;
	Fri, 14 Jun 2024 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407876; cv=fail; b=XALUiBe5NxVXrXCT4Q9O69l24upbK9UoLYBpAxWAJGD5fKSXO/4NZ0lhfef3s0osz/p9kdaU4tQqsQkkbPheulhHI9gq2SEverZyiOJWOUFOSpwzwMXRI7OMwJdrUp7xgAUftM37wPqSzBRgW+U0NQkYFYPkVVhGu54EW3P06Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407876; c=relaxed/simple;
	bh=9H328mM1n1CnEH3MCuyGth2dhJZN7Tetc5+imnO0piA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sj4tPRHUHhen0NlxzgbI3+YXJVk1IjkkFbEuSOBW6HF29f/tZg+YB1XRRTnIH5RuFWzBXZPRQed5riueJHk6KUKjdOqpU14rpp1UM5kU2OACUfh3JNe0d6xSvyS+4STPY9AHu+OXmuhiVpnlNEwBDfdxlFuKNYY0KuCWlgQLPnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tI0Nn/6u; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxvGIM/9nInrWWP4c4QrG2UaKLrinO80epm2x9OvUUq6ET/XXqtPU0PAj9HtlDZc2znHc5C7j+3zTX+ZgWXrK2TKzyZAfIehKilwiInqGjwtwvmXRkAYgzTQ2yc/pjVP7J68ofLnpSfUdHfD/570ZqTAx9NZRD+B0+kLfphV2JKV97ZuN8VQ5TFUaX09uUEjJzvTzIydGxBYbw8R03ip9/dxiJxregUoHyfR9Ju3jVVPz3RldhRAeg7uSx4Mh6nrAyRGDx9G89sm/eDHasrIzXRmwjFeYkzEilzSxdWnKpfKRgzPqZfO5jeGc3KCdaU5Z8VKXAoc+68zg+PUt6gLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDLkw+ZwYBYOw1rIGdmKoEcxhL5RxeVCNisgSPhiRNA=;
 b=Xh+JOm/iZwI5EhDCWEpY+WCVExibpIOtH7W3osPR9Cj7lAFCXXOzIRALxh8FnjoHsfLF54jv9N10AUk2C9z5X3yXoeSOyDoJPaCc8opnciHRJsW9A3TFxrHbZV4O+MFxMVgTqCTvkcSDlCTcskeOCXcfa7i+3w7vuT7qYI2N+PgRp0xj0CDCSY7+xvYXIMKfhe1U83oJY0ZTpQCFeiLN4ThSOXetkXY0phVHX1oqiofbpigO488NUXYWu8Y21uh4lC3YvFlB85POMhJINczzkY4YvQvk99pxJi2vJ6uEWQXWNES0ryCQd/fJTkPVe/M2RPsYFYY9B+jL6zzxKQpaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDLkw+ZwYBYOw1rIGdmKoEcxhL5RxeVCNisgSPhiRNA=;
 b=tI0Nn/6uTLEAmzPGZKmWngVe4Q6fm+ZYV5t5vcfByNx99RRosd/82e6EHEwLiAHKSkp/aiUU2jYbTcAxuZwq31uuR3sv0L0moGY/wzKxQewWdXQ8kx6OVvHllOEPtq05vSkIfC/QS2/NXi52GrozIiyoALWafUQgX8JLPN2QFyfpNWzvIMkGfDfJ/E3bJ2NP+yCGdZbZDi8NHLL2abgYyOpBdFPxY3ZBnQeOPJ3uo9fCg3/LUL2/WNsq2i2MCOAfcMB5Z0+GR9mRlCQOtGlGZb6YuVqhUnugYSGoZX5B1N0CaRXjlgajB1qZuKp6JnRnqTqfGVmtzplrMrU+/L7moA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 23:31:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 23:31:06 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 0/3] selftests/vDSO: fix clang build errors, and Makefile cleanup
Date: Fri, 14 Jun 2024 16:31:02 -0700
Message-ID: <20240614233105.265009-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:40::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 290111e3-19d0-4b56-691d-08dc8cca104d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vsnR9ebm68w4YngHAiOU0rcYxKbB8cEIQ0l7VTZgCIRpoiXQNGgVAZDPsEqL?=
 =?us-ascii?Q?QkjOtc7bVyifePPNbWRcMgdq/JqmAuFdNVpLWMX8jw7L0IjN4nomPqfZJi1y?=
 =?us-ascii?Q?YLVkDjOPArUtYd44XF9wf6OmM7Wly1JlhAQAArcsLBNs9l0hxkLkZamp87qV?=
 =?us-ascii?Q?snz5h/5JQA/GTB5Nq1+i9E5pXjSxKNkPQjiMpu+yHvVS+MNelml1Qh7p6uGu?=
 =?us-ascii?Q?HrN7YbrueVcsyEx64fvkA+h1A/wjXYzrEX+/DJ27yRoODqdchOHshNMBk4W6?=
 =?us-ascii?Q?IQsFm0pVpUX4ShJaLuKP8lbJBr9/aC8nGsyoy1HSwG9igMuMvSPXEcrQJuUR?=
 =?us-ascii?Q?RqxnrSAYLWNGzMPdD3Lx7YPSmuDOtCl9mLHy7qKtQkqyEa8q7I7ZRLkMrA+h?=
 =?us-ascii?Q?DG/PFHEK0ttKFVkn8iRcWoOdgCMZNE6bL7wL1DmeFP75PI5KKzVhFD7JyHGj?=
 =?us-ascii?Q?nzH+xhrZGNC4faE+3QUBS4jz9edhiRdFtwr+7+PqPfo3oaeK429hWU0SOyWq?=
 =?us-ascii?Q?ZZGR9t3IcWahXpjvXbzuLC8Y84LvU61rMvdCyKuY1w1DHE3NHIV2+E0pUGH5?=
 =?us-ascii?Q?Ia1VBo+ZPKMQxT0Vb949HbgwmITnSFTEaGhDbv8z2B6mbVMUuBN2Bhh/6uKr?=
 =?us-ascii?Q?EyPnKT8SmjwKfQjBSck3spK4lKeKofPidiW7YfO97281RfqDysb68qjPkdVu?=
 =?us-ascii?Q?NuIyLBGzBHavBj8NO6YZq4/mXu0NIDnmBfhqy/6fY5xwISkwtrqmSx1uoj+s?=
 =?us-ascii?Q?ivXQ5euQ7dL+FmuAdto1HFXPL8qas5yg6y+M77kGdcOSLwHjCRqGqyQwwyyk?=
 =?us-ascii?Q?LZJmzzoJCMgzf4sg+uuCwEG3EN9PR2J7gEb5cqaEnmXRcT/sIDtRw90rHXxj?=
 =?us-ascii?Q?ywJ2FZebzPFalQoDjtymxTRlf7ODV2jCuGNqsVZrS0dVJ01lXwIEmI+YYZ7P?=
 =?us-ascii?Q?A9qEV1bcmfdJ8wvl4w74iU03sX9gqADb7ERX3njYlPg7I/obDSv7YBYeFjaj?=
 =?us-ascii?Q?Fmbd+udbtACk23arSauG3L/J583eawZRULLanw5h74J1rRufSqvAFDUgTkK2?=
 =?us-ascii?Q?miVflZHTqn4yoFTPGHKtY3JlgHVCl3tHBZ2SnLm/JpvACpvCPeZ4w+J3qmBw?=
 =?us-ascii?Q?vs5R1cDFPW75/56HffK7NIkjfzPzNfb3Vr9zIlHbfn6EXeAOuU/YhltK8vqY?=
 =?us-ascii?Q?9APmvhu48pfzPjc16OrvjhAic5fyiNrUCyCGjEz+X1T+9+iftMrhzY85Ztc9?=
 =?us-ascii?Q?+vzTfI/abuZs2DVgUnvCMvu9Ijujt5wYNk5C55jZioAfSeH4Az2KnWCMzDgh?=
 =?us-ascii?Q?mMhrttNj5KbhwF/vV0Ljrws6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQR46wrqhWGyoqd+NAw9d4emVjLSQUwuskNj/TegLcfhu9k+ELBrmSpfGzm3?=
 =?us-ascii?Q?9/K76dvIDBabqZnbUEZpUqIYmOkQ7IEiUS0r/PkBpYkW4isvAe5Aacn0bsjY?=
 =?us-ascii?Q?nj6S/S1rfS+8lGLTxuUDgVKF9F8t/IhY5DkE5Cu1RvZFEOiovypi33f/0dba?=
 =?us-ascii?Q?UyFcK8u6gFsXEoDQXVihLA719UQdpoRQvVdQP8+puNJWyhf4KXTVxr1wvbZB?=
 =?us-ascii?Q?7SMclLN/nr34vuUL40RRxd0XXyoeuuJuBrcGzoLOP/3kTAR3uQA7f8QE88He?=
 =?us-ascii?Q?slFxeqdUUcakOTVXR9ZG9+3RkSCMDbEeXZm1Ugp43cijfYMojvwODSIy6R8O?=
 =?us-ascii?Q?TW1azNF4mfux0vwCjtptzIXDG16k9gvr7+Uq3dGq1+Co3+l1je4FGnM8t5Pu?=
 =?us-ascii?Q?/0q3JDpZZc8li9PoWKcUhjzPaenDcchteLaFJtQijzu95WZ5QeyaNtNithef?=
 =?us-ascii?Q?mX9Ev1eLCWWlDGBJBtZ88wFSjpZioHbEUSmJeLSkglmeYiuKqHTKbIbvwElc?=
 =?us-ascii?Q?EthGxkxV51CVjl6czTD1s8b2UPnwKbCQ0j3zrAMCRQXLQ0oqCotUCzrWa+jq?=
 =?us-ascii?Q?rvbGs4GK/qvZt5IzzQ4rJR3IWZPC6ACfp7S6cizfOBtjJeOUItMF76aupmPY?=
 =?us-ascii?Q?cyyRVtKaXpDeIaShI1Wg6RmEQuDbJQItwRcsCS4zflX5mTHaK8+1tsrvEbkF?=
 =?us-ascii?Q?HRZyCTnKsodnUtEjJsw/9DoxivSslkuAgSO7/B2vYOIqQg3bkZ2Q7FEoZGMG?=
 =?us-ascii?Q?nKXT9qn5NFWKzrs7co9d+A8gdv18RZbo2B1oIYOhUQ5XlCkFpnuPxjCQ6jzc?=
 =?us-ascii?Q?r/yYCwHRVxs3KNkFA2JWitTaehq6UI0gDcba+Y/ff6uZJXhyxsmQa2cfJsxs?=
 =?us-ascii?Q?TlMiuC6/iP3+BjoClt1J89RtFbHQljSj2Ynf0OS6BbLax0jnJVjaPPp3mEWU?=
 =?us-ascii?Q?gI8PoVzfwtKopF4msQtmjb3sIoNCGjZBTnTfHVTavipgnQkI+kufvEOHo6GK?=
 =?us-ascii?Q?NseMjrmBIAiokNpy7cjBCx3CPvUHRa3758p0muvpJS7Jcas6SlBFGmmG4cc8?=
 =?us-ascii?Q?my0/3Lr2dtnu0lAYGZco55OWa+MKiEUv59qyGjvM3vlDjnE3prhLhGgTWvFd?=
 =?us-ascii?Q?AYp8SN6QYnS71QdqxK4v33fPFXWfQEFzxMfMvgucR2EdN97BfRy/albIAjwy?=
 =?us-ascii?Q?a9cyqVa3O8vEfR4QCe7l9/H9MajG0bo7urZ96H1CrByTkQRnvin8Bt8v2VFm?=
 =?us-ascii?Q?zNZeDRRqdi1lWZflpPalQJKgaiiSwXBgYuOjwHLnfzJKMf/dTCgB5N8FPp0f?=
 =?us-ascii?Q?b/B95kenfFyWWK7wNLl9QE52sLvKxs4mAX+W8Ccb4f4FGDcCz7zGnrqltDjv?=
 =?us-ascii?Q?2a2rqlfDke1feRd7P4vlGiYosflyVG7G8lfwGu1M8EnCdbM/woMeuCEGFZAR?=
 =?us-ascii?Q?1Ve1dATqaBhr26rpcsB2Uvs6K8il5871BgVefQ6vydNveaWf1vGOVvNlWATl?=
 =?us-ascii?Q?FrzEKoEFHUPlVSrTTPbcRvl7bY5bsZJ22cGkyqs/BtA/xjVREhDSZPUTC4/g?=
 =?us-ascii?Q?KhwYHANXQPtlt43tV1lzwVrOujLmlVPp3pJYo7eb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290111e3-19d0-4b56-691d-08dc8cca104d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 23:31:06.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /44UEvLFCUHccJysiQE1DUmXDMuAoacp3QbH2ZVAFSCbbrti/SWmeP1eecGU2R1Dc9OtFTGOdFSSIsvO2HAyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

Hi,

Jason A. Donenfeld, I've added you because I ended up looking through
your latest "implement getrandom() in vDSO" series [1], which also
touches this Makefile, so just a heads up about upcoming (minor) merge
conflicts.

Changes since v2:

1. Added two patches, both of which apply solely to the Makefile.
These provide a smaller, cleaner, and more accurate Makefile.

2. Added Reviewed-by and Tested-by tags for the original patch, which
fixes all of the clang errors and warnings for this selftest.

3. Removed an obsolete blurb from the commit description of the original
patch, now that Valentin Obst LLVM build fix has been merged.


[1] https://lore.kernel.org/20240614190646.2081057-1-Jason@zx2c4.com


John Hubbard (3):
  selftests/vDSO: fix clang build errors and warnings
  selftests/mm: remove partially duplicated "all:" target in Makefile
  selftests/vDSO: remove duplicate compiler invocations from Makefile

 tools/testing/selftests/vDSO/Makefile         | 29 ++++++++-----------
 tools/testing/selftests/vDSO/parse_vdso.c     | 16 ++++++----
 .../selftests/vDSO/vdso_standalone_test_x86.c | 18 ++++++++++--
 3 files changed, 39 insertions(+), 24 deletions(-)


base-commit: 2ccbdf43d5e758f8493a95252073cf9078a5fea5
-- 
2.45.2


