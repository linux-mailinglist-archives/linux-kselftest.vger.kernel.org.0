Return-Path: <linux-kselftest+bounces-10813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1998D2AD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A92281BD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1915B0F6;
	Wed, 29 May 2024 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OO0ugLe3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134D15B0E4;
	Wed, 29 May 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949787; cv=fail; b=McuGDz48gffdrsZ02r7fEZ3NMTR7JsT00XQZz/00H0I/Ftslgh7fthJPDQLMvv8BEEAoiqQEtJLJTsUuLJH0SfA2xXEjekXZ3iHxoXUtr1CJEF0/55otXCT+2MMs0ftj80GEJbm9IYmXstGVtqkYsyQ/jLzcLoLBgBAT/vgCmVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949787; c=relaxed/simple;
	bh=KbRIf7nTBfEhGIqZc9kk1/tpFXmiXOeVhvTUKoFJHnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDrNL9sxNnzLmwtcNxZ6zUwGutxeeIJ4y/7Y7AFqRdHiKNfvDYkYTNTseYJ/dl63Zz8c5LBzjmt2iJMhn9xSgyg8u/l+SYNmzSRvxORtkdGY1w9Ao6RfP0L15FpJg2Nbkk3vMj//wRrvawhKamKryHY2EAJACYsejltpnlGBn1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OO0ugLe3; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTbVdXmGC2PZMcUHhSKjyzLhKa6k1SCNKmBuc0aESddsLkd0zAgfO3IXjLHfRn1k/VsVHWdM7l5LOTvxeI9lNYgJUMAKb0dVjgx4ilNkggu7hPeLOUIbE/HqBqNHZ1gF+0Xvit2tOPVCj1vcxcgzDyb56tZOsv7dR26BEUU9n6b58oaeH8sk7fxSWva2tFsGaWb/OLoZLqEEjz/XZL7fizweppgS1pYRELNgvY0+2wDZlPuyoui5hUFYEsUIUn5ku3xcvXonByD/o5sLRQcKdEo36G2yaQqMKt2CNk0A3LOMHII/AETsp1/04nHW07W5BcXPSF6NeQDf/tLwWLf3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETt+unHWN9G/LEmJW4Vn9axVEtEp5FYMTV96IkPVheQ=;
 b=nBhsXvey20c8CBm32zA9BqRf6VWVlmSRgQK+21hSgokoV+ORmxCZhIEXzMSDX9t8bsxqHd8yBZxvLet9JIkpWxjJ90W7PcoK6oyQRdxc4lhjKyzZIkNWKfiFkfjbz2YQOIhq+DH/tLhtJS7oymcuDgt50ZcI1VE9Clr/iWYx7ve2Om0meD5FoRhtuDH+83vage+2paMravwcE5C2HEIwGMMEoWEkxJJ1LWQsYDQCxBr2ggBWHR/2a8D1HZtL1AlHz0z4sGTuCYbArBh1AJWhO3Gg34fi6p0+yogSXUU98TBmyH+IUNeMFSxKgr1fUZ4nf9fSJ+hLR0g6yAB6kawRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETt+unHWN9G/LEmJW4Vn9axVEtEp5FYMTV96IkPVheQ=;
 b=OO0ugLe3yGTlehBnfueipcQjqIwyNbPgnTvlVWHBeCAwzocj/5Ca7cOHW33AxQcJFAGAAtz+13px8Q3WPG/ToXbaTqVzwNjIILHTHd0IuFZnH1UU2gLaRpqNsXpbg3J3GMfOADt2SBCc/OO/t+eSjgcDhYRMT0EV2qqv9rhnJAt5agZ/yJtXY3pjMLGbvRnAiSZ2P8KbiVLgfMsn6gqnc7ySo9ji7z2gSRrZzbBki9QypAoy/OXonahNRejfryY607on9CmNKvUd8DoxhU1NHrvgcIOYmpd6ONG7iLlKOxSnurfs1U/mQ4eeNLXtRkB/sVjuio2nsxmcaaKqx/3w/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 02:29:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:29:41 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Edward Liaw <edliaw@google.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/3] selftests/futex: don't redefine .PHONY targets (all, clean)
Date: Tue, 28 May 2024 19:29:36 -0700
Message-ID: <20240529022938.129624-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529022938.129624-1-jhubbard@nvidia.com>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cb3909-4ed8-41b7-370f-08dc7f8731c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NH7UHkKM2uSXnyfcMBSDC5tCcnt/LpDrKnChOMR8vqk8ONwbt5sXNDNgcP2r?=
 =?us-ascii?Q?vzJjQOdyKH3lQj1rH1xiirRVHhaCOc6DX+qK/oI6UYP0aDIzG4z2RL08ihwG?=
 =?us-ascii?Q?8Mxutu4GkMv6X/dZ07SV825J4twzmSQkbZoF3M14Y0JEu8FS5GtDWaoZC3Rd?=
 =?us-ascii?Q?IVtADiADzTmpZtkF+JkPR0+pnXcGry8FzAWcz/t3GO4KA5ZHKQnVr8efDfo1?=
 =?us-ascii?Q?hzLT0u3iAnRYYOeXPxTm4NjJ0OFYCbphY0CD1OAr7B6bp32fbgIOj8lwgSkk?=
 =?us-ascii?Q?8MX2+XJC+ojK2QaDUo+Puu4xEao+IJGx+WGdqHOxQPjqmtwaUw/L2vsHUXvP?=
 =?us-ascii?Q?vg5daMZHOehzqed/Sq+jV3E8XMoWM0NkuHi1jdjElTgyKvNetfxUa+2hu5tR?=
 =?us-ascii?Q?ItMPas1dmPBF/1cOzDbUerAATsKA3WPIXLFb8vndkgXw5T8V4f1taxZ8sm/0?=
 =?us-ascii?Q?cW6XSvTgOtkSLAGjtYogq9Efs/kvqB1THk3cMTjN0ghGPDQuXpSRS++Ty3Qg?=
 =?us-ascii?Q?FvcaDDtyCVIvKJEYuSsTl71NykLGIQhokBQrZPnx1U6mpJckerZ2kfEBmMEZ?=
 =?us-ascii?Q?Kgu43S0ucNOh6PtdwMdJNOr8oqvdy1IynypjaEYsdYHoffkt2XuY5lPDXykt?=
 =?us-ascii?Q?Xfh+lALt5sxoZlnh/6F4a7F8pyG5yl9B2x5nQQoO3YoH6i8SlSfWznFMZx45?=
 =?us-ascii?Q?l5Bd8Gznxun/mSI7n+RjyP+bWYHS6EghiWQbm5Rs6B4ahDwCNVOqIgC+lamD?=
 =?us-ascii?Q?j7wHjhxb749Tx/dqO5iFNXYWic7eVdiYCQ2CiPXPRP5VTQxIFhhL2KqnjNqC?=
 =?us-ascii?Q?MFDF8G6+H07SEeTAFXpF7Dvke+AT8S5lKRK8g62hTBf06OuIg0EZBFOIQaxU?=
 =?us-ascii?Q?CKs4bWwTfAhLSuQNsbTOoOyb2lRKCAAD+TyaEJ4zC5Q81C3pepElZzv7vkjT?=
 =?us-ascii?Q?Umw64XXX1VEvmLqrChoy60E+W/4UTNsig8haMtr3BlWCMD/fSRF1d9LdurUa?=
 =?us-ascii?Q?agrQnLJV9k+uzYq36Z5j8r+l3hAQ9oIurmixnMU4tV3JRPPLRdbzVBEOISLU?=
 =?us-ascii?Q?rsfo1zzCf/ZGmP+p1FiGRIairqMxnbTT5RkVbAGHiblOZLDhT9QVOBFUS67f?=
 =?us-ascii?Q?ah8uDqz9IJXHOF3NNFYkRJeydKf/ven9BunZMcIN0Mk5LWkf0tFIUuPG2Mod?=
 =?us-ascii?Q?jc0odXpF8JWZtgdYw860DGJCqyMfgkf/EPrxOgedhW5ZlUAfIA4Nw/noOTy6?=
 =?us-ascii?Q?0HhIptlx58TwVhYR+Qi+4u5Hp+Xrx1wZ5Ao6c/rV7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOX2IxArCmXjSKHn5aCntJOyRNbSuJrkJor49mUX5vR5AZ4wDd+qkhG/bDP2?=
 =?us-ascii?Q?xIcDxeeq8semY6ZQzdKkod/VNRUuz7wctM4racJo+FmAr9J5AkS2k8knkhVQ?=
 =?us-ascii?Q?1htnf5fAziMPvki6n8A4Dgd4faTrUzzJqxMTPgOYuRRXdFOYm1YOKHHibOad?=
 =?us-ascii?Q?3ZopbVA0A2cnlwrMeMTORytsrIBwGHsGcMdGaH9UKwWXeWoH08Vv84cyYIaE?=
 =?us-ascii?Q?zO4ObcHKI1DO9CITJ/uLPfU9Dgz3cMQtNnYg0ll6sKEqUmbP/NpnDLHekFWl?=
 =?us-ascii?Q?lvmcSHRSczoBi4RHdJcwxR0CdNGR7jCwa/L2P3if8jTxXh0dSF9RJoKEuNTj?=
 =?us-ascii?Q?R3hS6JmvxD3iRG5g23tJe7mmG49AqIafu39aEXDlCf1VtZiLMlMhBsUv95LF?=
 =?us-ascii?Q?rs0aQinPdACvhB/V2gutFN6tvJLS0Qc2UarWQffRae4kdZiZNCDXKC/gewNI?=
 =?us-ascii?Q?XyB2uTJTyheLR6KKah5L97BxxB6jXfaalJK+uHoT46aoKFTmd+9J03JBNa7u?=
 =?us-ascii?Q?Ry5dEBD6pZKMNLfafBWFTso9p2XAl48qnq3JbZvO9i+KM6W9kTh7SgDye0Qx?=
 =?us-ascii?Q?a4UlTHvEE7FAWWic60o0S69In6sMvc8WzlkkG8HsdDQX8Kypo2N9zVfSLK3o?=
 =?us-ascii?Q?W3t95jUGTJBF5O853S9XsTpQeIwBIeKEq7MZOS/mgUZ2/Xnvu6FNYKq3WG7w?=
 =?us-ascii?Q?i+u9xOGbv8DRXC/QuBiVmJqvPFVmMY+8wh8pvLqLo3GgZyz/gDXur/AqQeZf?=
 =?us-ascii?Q?cXppQxhL2rvvCE/QeYhFEaf2F+m1lcU3l01RV/UXMbp74NuvC3t+Z8dyy7bR?=
 =?us-ascii?Q?sCKIy+guuE9Us+RJxTcKmyEYWtGzvQiEGMnsYiJd5OEx6L0xtUieIUCzRq4N?=
 =?us-ascii?Q?aYZM8/KMTvzYcXgv1mEzplVjH5d8af3bWhPOY+I0Muj4dIIa3/ndSBXeI4OB?=
 =?us-ascii?Q?KKKro56VqgRiQwGKamHeDc+n0Xx3NaSotHiI774Gj5W73kuQ4XfLcEZ5DE/x?=
 =?us-ascii?Q?PzO/OfpkDFt524sDaubE7crf0xfU6Theb7ov/VidhjOD5cgVcOSm9sT7QGdW?=
 =?us-ascii?Q?LqgfFyOn0Yk0k3SEZcT/tacWdswdULPVmeoVfoTdT9SegYV3chI3ayLnHMxv?=
 =?us-ascii?Q?KiG5uK3miDF+S3/9tyO88qZ4m2fPdUJkkQ4NUPkN6ofsdIZyZ/lPMD2WobUW?=
 =?us-ascii?Q?SrLseR4k3hfz2lm1uRRNEaRJPIU7EO6UiqWK0A0TxoAGCcilj/BQpLdnSxo8?=
 =?us-ascii?Q?S4NHtOZ5b0E+RWJvcrD73zgPzfiiEEk8wwG8cIcnJaeG8Bgr59mZNM0KkxgI?=
 =?us-ascii?Q?zEM8XX9GIr/e3mTvIKWD2JwrbYNbQXPj3trITKbrlojTaoZSNZIiPHhYLDVt?=
 =?us-ascii?Q?0hcOT+riWlF6XMh5ReAr4lUTwRN1yUZfavJZWf126dJJ2EQ+xlW5V+YA/9QJ?=
 =?us-ascii?Q?jkXGUb0Kt69BS0cUhLabaGX2Vl97Zi0kXWww3KSgCoOERSigf3AwxjFLpk7W?=
 =?us-ascii?Q?xo9pHBVyMfOFBSCy9qAjZvs6X5oCDLB9AP2mSgiU0HDAKfE04Qy6DTN4PNPu?=
 =?us-ascii?Q?UFbBdUT3cK1dn7b5RbwtGZl1yfl8LBrwCR+mQlNW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cb3909-4ed8-41b7-370f-08dc7f8731c5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:29:41.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdNbUhcql8Koa2aiBuzfHfHZv9rugdiHOoGzfiBDVMzRMTyku1+YFCmTVcyQBniHo+SfZHbK+IvTOmL3ADpkRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

The .PHONY targets "all" and "clean"  are both defined in the file that
is included in the very next line: ../lib.mk.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index 11e157d7533b..78ab2cd111f6 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -3,8 +3,6 @@ SUBDIRS := functional
 
 TEST_PROGS := run.sh
 
-.PHONY: all clean
-
 include ../lib.mk
 
 all:
-- 
2.45.1


