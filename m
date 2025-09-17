Return-Path: <linux-kselftest+bounces-41761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E8B81B56
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3518951E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0A26F44D;
	Wed, 17 Sep 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KrRp52rY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7072263F4A
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139322; cv=fail; b=pm4Tn2HBflvLVZDwmDDnTjRJ/xgWkfpxsvf3V+WSjjYKEg+QPcnjjhfDdaFzJ7Ut6Pe8SAlWja+KEFvBjjCucXFtLJgcR7gwyUCTeiES9sQF6yqTnMdOK6EIunkmMvoJCJXsT72ai0Hy43VhL7t6mJqjToTxpZmc3LcErayvY2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139322; c=relaxed/simple;
	bh=AKzVBtLaJTLwGoZXJ+yqQL0q8YHsgT6hbr/+AyPRauo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CPzqXbv3L7WK0NFz37pPGv9sFaWDoNgcKfxkOq7oeXmokS6MOVdQErocJotsqtbykYol2Y56LPZXqE0VRtmftBdNSchEA7do5z2EV4YaNL+MZBTFJcaJ8DLPlfcKGEXzSpyyBBuXL7dDgeA89WF9qwlnnmFWnfxG2bCjvwNTaEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KrRp52rY; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZAy5cl2/Xo2UMjR7kZi4MedEzbdg/DTgLkshGKBcaIFJ0Ar1+s1qBfkaTR6EoYXj0oW8MJhqFtlexu/fy06/BX/ZSiRjczdVmG3cg1vTckFKQlEPbgH4yup5gJrdOP6IimmF29YnZB3ZG3EtauPWINAOwYk8LzIHP0MSnBqaVEr7nM5QJY7Sgm28BzwbaTVstUuZNjN7zuI6exnvCYxB2p54i1NlC4o8oifVPgedlvE/vUZOnrrhqPaY0gCH7VTIzkwrhUYPuiqW63H5P0r+hFlJVWjJ2H+wfL+6WmxkDFHtkYJUZ2UwdUN+iJDu/B7cRax6UJpixNW/qnhbtcx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84QWn1jULDRL/egCfFNyRouNmT+foxyPJew6wXuwHyU=;
 b=Cbx3JxeTEVczMRZjYJRiCvdRdGMGnuf334wGVTRi9NudZHKNvCrsWqtVpbsSr/DiO8WLMu9qJXbx2LVDJwSPtMbira+dkXnvjXBwCbjFE8u+m8GXvEI3qQyuxfUEOx/mWj80q2MvD/CWT8eNBkahkLElqgPCUV+EyZo3Xob4dpF1gkkyG6llBe497FVfwphjy91lKXT0+701SsDp/q+PgDRaUg3JxsmjEtqM88Jwkfh5LhudQoFbg2jSJEaarVqYfywJXqu57ZXGYhbZ2QSEiVipaL/iq9kr7nVXk5f+KbTEqPrL2NdoT8H+C36Aqe8U4wrUPHEe1n8yeOGIrdc0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84QWn1jULDRL/egCfFNyRouNmT+foxyPJew6wXuwHyU=;
 b=KrRp52rY+cVWHqwO1SulHAprTkYWyboU4Z43588e+LzO9ZmXaLPjyrYAdO0kYT8ps1iwUhjaf+HzXoEyN1NwgnI0nVtbZZW1EUWYZsfCpEHAou5szi/hyaMjNVJWetSKgVe6MVk8kfAwxVxeiOdbPqmPlG0uapZ6SmeRJB0BUkhVmpBXUyc1vhMIMo+DLL8+RSd8ZOLInqcc9N+sr1HOSlE5mSkTc62C/kSW5ErrhBLkWrsv6Me7BZVgkmcvIj5nJVc8z4O9wuAru1Y2dRIDpH2EX9Dg4d1UD8lEbPYgTNWDUVR1zF8u7bxqQGuZvfS3yz3UDVDgSo4BD/ZA4XFm1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 20:01:53 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 20:01:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Subject: [PATCH 0/3] Fix a race with fput during eventq abort
Date: Wed, 17 Sep 2025 17:01:46 -0300
Message-ID: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::11) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: fe13c95b-a1d6-4b3f-575c-08ddf6250ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78lvsqqkvvntnobqLl0HPD7fqPX6YJlDJfTGEdwK2Q1Sgg7MpeQ75Lsb8amI?=
 =?us-ascii?Q?Ejjh6S4cdqj/OJRzrGS8wNPUtJryP9dOdVIxLbhu4g4rKhjNE17uF+Q+eYF7?=
 =?us-ascii?Q?a1+1QpRSwiQXPDJI+6eJFmXNGGHVSqacc6dODP821bMuR67myFlojSNPjBn6?=
 =?us-ascii?Q?/DXO6HpqxmVlQK6AH3CatDSB2ru6zF6an1g2IjT+ETsIUnfFMoc0J4msZEGs?=
 =?us-ascii?Q?GPlm1zHNxD2Nj3SZRqYvJ58csV5Mi40YUOldj/J+5OG6E4dCS06jR+ACP4dr?=
 =?us-ascii?Q?vG75kTqT9N6OrYJKBwahgRyutxuex77hmFwX2ogna6AvEuoL+77/1ztWxIuN?=
 =?us-ascii?Q?ynkPoC2Nj72kefsFA5HtruHgPasxNcGu/gek03HC24jOTz64Kur8aZr51L/O?=
 =?us-ascii?Q?8vpnnZpZ12av9VMt4w501MQSRuIKC2C5iBNFaYYTyD43gi6SP1oyenaSQDMa?=
 =?us-ascii?Q?t91rQdcDc6YdK8bk/CQmiJVkT8ocgeddwAqt/z/48Pux8HcGTjHAlS2LCicZ?=
 =?us-ascii?Q?I/PQPhQ65K+7mXaIALzcseFdWp1KzxtePnDyD06G7mVCZPmjvllTDtSxctrB?=
 =?us-ascii?Q?aNO+nkFw/JtWlgdKkX5A3cC/8/3BAYYGWLP/U9LxZiY9rCdmii/3yY1Uxb+g?=
 =?us-ascii?Q?0rQnHtZI8Yvm3+YDzQU3YSyKKw6+IZq+KlYJKPWEu7HrCwu0Sfyq42nNbMqP?=
 =?us-ascii?Q?sYTfMXQ5xFtxnkIF+toUFXJSE4RRXmo2S3bgEiuzJrjB0T1BY28I+XL3PMeg?=
 =?us-ascii?Q?OOq3GL4DzztNCtAVVdj2/FJ55//NpUNZPi9QrpDEgGWL+wt+sLJJCTTXCU+e?=
 =?us-ascii?Q?6EzkECdfyX1810cfCB/qt5YLGLWsGkmhXtavX4DydlQCqR9WfYGqzOsSbO6f?=
 =?us-ascii?Q?1BPmKTFYjaV35W97ZH6Wds6z61SW+7VHw6dk0HZgbL6rg7DqaTZ7/uLF0XYI?=
 =?us-ascii?Q?p+NRWWKgmecOtEG02dQFP4aHI+LpAirkoCRQhfx6LD7QneweuxXmHO2xONXK?=
 =?us-ascii?Q?EWFcNmteuIR4/uFwo4DIqFrz1Rnn3A/KJBYtTaf0kj2TvehtBTD840ptpuv1?=
 =?us-ascii?Q?4wFPMr/kjNTtRD2L2trN8hMjx4CZ1XC6rOg9L4JJMfOlM2tosEB40xzkUktj?=
 =?us-ascii?Q?btIJ0m9BDpAvp+x1/vJcCfOMtC6qgsFq1IAy/rft29/nEb7i0AqmZwGtoBvd?=
 =?us-ascii?Q?rEA35hmMorZ7132lzThMTRGKvzAyjLX1ODGMxR3qGaDDd9C8HpFUuWEfK6hx?=
 =?us-ascii?Q?i1owolmAAwOlTDOekbNl6POJgfGczUiXOT+EHAoEzTaBmpacSBGnVMeuwDgq?=
 =?us-ascii?Q?EUTdYAF33nVtBXJDkyu9VmFRWQ+VVjtZCc0L61VB/UpmCoTeN7jHfh2/aGY1?=
 =?us-ascii?Q?rDHcmu2gckORROZe/3ECtPQIC3pv7XUMSZHAlfQYFM1RLZhoDUY+iaeQkHTP?=
 =?us-ascii?Q?47KXbsLmxxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAir1pEWPMGTwgtV63iW6lYkHeJ8fG1vEW+B1toTLQYt0A9s4H0N4BRhMz8l?=
 =?us-ascii?Q?YnLYHtz9HaH9Ssy57U7IWMzvp6D2sj5E4cKFMfM29qFWTqPs9yY+rKFcyWF3?=
 =?us-ascii?Q?Ez0s8kq1q6XOIrib3GV0iWSg5clsI/89YThtToOnRhg+mhs+i66y0yCLWfXh?=
 =?us-ascii?Q?OZc+DM1ZF6U7fuDVDfGM+7nXCjokfBxTzPgiDDOCq0hG8bjgLCOu2IcVsEA1?=
 =?us-ascii?Q?4EUjGyViJuoB3GIc58LxzN1WMgfWzXynE16heRCAz9gKeVkF/dDw94qbz4Mm?=
 =?us-ascii?Q?K5arCsPcmBg6V5M006XhEsB/ky87YflvoRszcIkzFSx6jUuU20oMD5r0wstO?=
 =?us-ascii?Q?EjYBiFIRkPaCd9Z06smXRFaF7cFvm+qGN7EjrvSa/eVZlzi7iIV30wGOYVUU?=
 =?us-ascii?Q?uT5CBYVdkAYsUTrN17OuQYMnGNSms5TqUYX5oOEAQLh3VwJGssi+h8i4CA6C?=
 =?us-ascii?Q?vrPhQyV7W2QxJn8xTOy4FKIX6zVuX0IU5PAtBHPX30SrMp99lSP4SinJWXl5?=
 =?us-ascii?Q?bPM7d7+9a+AKrUpJYxH/yEufqeeM2hCo4eOUj1rS9i5JzMp8M0VPN5j1kdGO?=
 =?us-ascii?Q?+TDHNAt85fFV6MwyXKBu3RRcsJ/1EwpIjd2DgKYTd2dhHM+IohpWQqJoce9b?=
 =?us-ascii?Q?SBCKMaltAXiopx+X34hn/425TfXjCWY3tC0QZ3ymXuNDcx7cU6DihVrpQ1Qf?=
 =?us-ascii?Q?OuqtRXzCOTBFHbvMBqKHhdwTpnbRlqdGnsseCAusT9OOCyiEvusS3dBDqz1n?=
 =?us-ascii?Q?Qe4V+nO+fCpKVwxhUCKVuPmsyIiDy9RM00rPS2x6a1EQWbi8r1fWVuLIwXUR?=
 =?us-ascii?Q?t/GYSUMwRBNYbS5CKY1CKbqwucRBY5i6eJ/mWNsJEEk5cHutl8pX8bCg3Wz/?=
 =?us-ascii?Q?K2Oayf+uCz3l3fk6OhpMe1OyLwUANwFJwimCs4hu6xKsR9DzHtApFCQpvXZ2?=
 =?us-ascii?Q?MenNUotm35HTBKOw7lh9icDuhtHDF3EoVdFevFlSnXbcgfbaqvEhLt78hF8Z?=
 =?us-ascii?Q?vnIFjwsyaFzb6ZK+mUdaczI+jmn/cjr+EMkDHElaHo6yVS8Ng3/M9TJNOa2B?=
 =?us-ascii?Q?k8Usc+s6evQdT1+YbuuvHlqt6C1WMwFlVNZRHbHKpVdXQermOSBGUe+KKAh/?=
 =?us-ascii?Q?DAwrQyE5TzuZBG2PLe2HxvdrcvxRwNOVJHuAqEBpPGcrALg+7q+I5bK38Dc3?=
 =?us-ascii?Q?WYKvJVFMKbDpsLYW9S/HUmNJJxEOI2D3p4hM1S6LsfWhQkUJMJqkUi/Yve53?=
 =?us-ascii?Q?t0Mh09wq9L0GHlqWzy/G0QPpfoW9g/ZpFP2eDAtE7qK4U39Aw09f252DBLIt?=
 =?us-ascii?Q?vsh0qIt0YNFhrwkxt84Mq9t+kjtlgn0PBpqmM6xcyxE46wha4ZpsVV1vu2Id?=
 =?us-ascii?Q?1bPkQoGDowyanQhOLBGCtgFrFkpAKN3xvEzeJBYcEQya48YjopBwJLLTQQdW?=
 =?us-ascii?Q?4afolwvd/58R4e+LGXzjuQAO2s5ZbdOFSfqzaR5imEEfWkx8fCzLkbIj55nc?=
 =?us-ascii?Q?+viUImqVso086KT49lr9PCChG2mhy1W1p7H08mxvu0ua0QkvuNb43Fg1XFGT?=
 =?us-ascii?Q?97KdqQc0Sh/mB/+935M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe13c95b-a1d6-4b3f-575c-08ddf6250ad2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 20:01:51.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlb6eyT3M/6vJg2Xo31JqXK02mj8OiQfSKx/2w43L5kJeih+3NGTxhhLi860vI30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

Syzkaller found this, fput runs the release from a work queue so the
refcount remains elevated during abort. This is tricky so move more
handling of files into the core code.

Add a WARN_ON to catch things like this more reliably without relying on
kasn.

Update the fail_nth test to succeed on 6.17 kernels.

Jason Gunthorpe (3):
  iommufd: Fix race during abort for file descriptors
  iommufd: WARN if an object is aborted with an elevated refcount
  iommufd/selftest: Update the fail_nth limit

 drivers/iommu/iommufd/device.c                |  3 +-
 drivers/iommu/iommufd/eventq.c                |  9 +----
 drivers/iommu/iommufd/iommufd_private.h       |  3 +-
 drivers/iommu/iommufd/main.c                  | 39 +++++++++++++++++--
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 5 files changed, 42 insertions(+), 14 deletions(-)


base-commit: 1046d40b0e78d2cd63f6183629699b629b21f877
-- 
2.43.0


