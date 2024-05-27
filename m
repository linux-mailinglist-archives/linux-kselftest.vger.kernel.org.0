Return-Path: <linux-kselftest+bounces-10750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84D8D0FA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63644281AE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6166113048C;
	Mon, 27 May 2024 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZOZwI3yF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9C131E3C;
	Mon, 27 May 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845832; cv=fail; b=FVcWLwsMNSWOIci15Nchoqx6WLbN+0LEf1YxdN1+S6wahw3M90wBfBaBSeSPHFzRf2mP5f9TqgZ61pF8VazreX9b7xLvy+jc7jW1+6Mx7f1MwQGaL1dgZZhKZ37xRmkCLZi4Z86krZB6ZGadiZGkaVYcr2ekcGT2p2pjj9D4IAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845832; c=relaxed/simple;
	bh=nu5knViLN9kC7IyZ5zDIgK36QJs81EMtgauMnSRw63g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U8nbHZoMpLDWIVemiiFibjyKSBmAIXAIXhu3YA+BJbJ1w7ggOty+M0dC+t1bLIYXFfMjblCNRv3pYZ2EauoRPeZGVsIgtO/qEOddV9Fh9lPDFFjWXSndFNWivtS8yp06gXxAuqZ62g8RQs1jElgb6vH4+Es+2zla5mywyejRxeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZOZwI3yF; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1k3221eadaWXgFGUlZY/saZdPvoTuKCam04Oq0lAvYWcM+s2KS1ReB9UycaR9yM9yl5bBTapcXuBHAPMUK5h4lr7zgT1OdklKXR/E2iwsv8MK/JIVdzvLDtz6CWyX+oF9x1xm1iIIRFdgi2obvK6ub2fEQcBVeUSI5EyewSYiMCw7FYU6ZuDibmYx897DkR6Y08uevCip2Ff5c7t3UtyKeQKSyAyELH7FN0Yf1VUP+pLFSafwQcmEueDxFpgMXkLDbgixVhA48EftH0mjEbWBXSAZMtKye68OpbnMVf/LMpQf/8zMAUB/7gpLg3xZXdKVtF9bLgQCa/yzcVptVYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKhN8rOF7mi+H17yK5dN3IjNBUqqkQKztErwDOzzptc=;
 b=PpUD5MqeppaTR7SKLjfDIno57CbTQaxxxplfb0fQnQh6r4BoL+FLI+NHa7zKrRW81H5Yyw0qHE4lk9qhZPStjlXb+R1ez8JkOuXypaPzrwcCRnWivkFTdHsCFsPYL/ADwG2WkQJEuWvKhB8nQnujWWhl4fOxubwuVwxgXA1cYSgeGjJUXocOCVUiaCsCFvqSwI8cyF5CxQNKn02n4HuOYWdPlT81cDXwWy0hYSCO92LXYsHga7dEI1JitrLuDuUHqWaALNsnu1Qoq3fYk0jM5l39YyYTSfqesW0sD4ci9T8pw/LSmHP2YLJgp0eFV1sqZyxG0NSialWxYXNC4eBK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKhN8rOF7mi+H17yK5dN3IjNBUqqkQKztErwDOzzptc=;
 b=ZOZwI3yFfQjF3MjSOGL1CvYfyizpZ7U1JrZa7y21vhZC/z9WB2cNmWWZkPHzit7MOhaVtAxfuRS38QPWuJ1m/G/ZA6L6S3KMheiCA+nFphGJ6n6f0ZIocwEc0xs2Fo7U50ZfZqVy3puevk28IQboquJdMZXTrQ4uyMK6sMdqXTsqlmfxMn47I2JsMeskN1xW8nXyeifg3GkTZvfCATr+0OqwMmtq9UJa6H4uFX1PQYT9+Uw/oGjpSjGTVYrT6IJXWfXHzupYlSeWqA83IAI57BAZI2YBvNeeiP05Qqp9EyKN5KXu1KJ8rL+yYm1EdH5LYqZ+05+Hjh/mQ/brQAY4JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 21:37:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:37:04 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	zhujun2 <zhujun2@cmss.chinamobile.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	mptcp@lists.linux.dev,
	dev@openvswitch.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] selftests/net: suppress clang's "variable-sized type not at the end" warning
Date: Mon, 27 May 2024 14:36:41 -0700
Message-ID: <20240527213641.299458-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 7708a56d-01d8-4ca9-2190-08dc7e95267f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?40aFKmVxUM7U+ShmJ46dBn6PyzlCKMANgB71hzf+oMFIyY9f7J13071cKOeg?=
 =?us-ascii?Q?Veeq9/bAGkQmbYlAjx2aStxWdmnYU+eZvdY/vQVpkc0QVMteXbFmvCbKhHaJ?=
 =?us-ascii?Q?xf94CkOa7noja82APvvLWr/DI7T4szZVILHQQSLFN+bcRO4TQMy+st+w6ClC?=
 =?us-ascii?Q?2FqtsttrFjd4Gc6HUl/NaULc2SkLH7C88UmPhMChzlkC2pJijs6JpqerSX9g?=
 =?us-ascii?Q?EdK6IcpLQNAOn6TSozeVig9L9pE90rkQPNW5TKLWj16ro5ojjl7+eGQ6ngmv?=
 =?us-ascii?Q?x0R5WnRXIFoPsKOMmFs+gAbV9tpvIBWBRDC4VbcCY9sEu09Wob7VtNUjhpNh?=
 =?us-ascii?Q?szji+FWL8l9T9jDiewJ+fYvPaAar7tXH3wrmUJr9q5YmA3XOveQv18WFGBfi?=
 =?us-ascii?Q?5Gf/5AZQ7VRRXS3puRJfpEds5WA3qN+rP0iao6mjvhEDqYGtpsiOSZAKAQko?=
 =?us-ascii?Q?D23dR1wSWewqnrbxEbOo77Ic4Pl53Pxq9z7RUTRj9lWxY5SXTnL3FnwcL6FZ?=
 =?us-ascii?Q?hxgOtgnIc+riW1iRkJEAPsNPxWZJCcIPhNAFn/YuAFl12PW6mEZQLwuooy66?=
 =?us-ascii?Q?9LqJej0KOEMC8pUdFnoQV90TGn8puKUvrxQFvvdVvNhd08q3Gb6DEVSPhTI7?=
 =?us-ascii?Q?XdEOwGcNzWoeTB0BAkKzMOpKPmFv6bOK1WIg056UocT+x4YezL+kYmDWREfs?=
 =?us-ascii?Q?V01GEC0Gv21PwL3WKAI9YCTiLEISOgOyexulG/ius6oJpnOSlrpU1zsXzP9S?=
 =?us-ascii?Q?G2pC8OiRKwR1PcUv706T7ZhS/IfiyyfAKyf1Dbb92qIfyhQBH4nr/WSK+/RG?=
 =?us-ascii?Q?i5JzBuzaaTwZU+jiCTINFGugSztyRo6/gZueuBC4Y9W4PtdSNmTQnA06YMMa?=
 =?us-ascii?Q?QNPJotog4y7oE3dpHmudYliHSXxFlSkYAVSiI4M+4uy/CBMNpeFdTRIIalwY?=
 =?us-ascii?Q?NE0kqsERYf+tSHocl+Re5uIo35ZN76QZrDueJOJmP8PpG3hvA3pgMPbnHBrv?=
 =?us-ascii?Q?wG75M3u5VLjl4Da16lBqhhURF5sv9Bk/wIVCt9fXFzN1x6dhqITg+1c5UbVX?=
 =?us-ascii?Q?LO9Swh736KJ2h9BJfmACjQj4e3ZanZeFRXVYAsFFvvlF/FajdKuGILNsJ6k3?=
 =?us-ascii?Q?e9iRItjq4Gz3prrxKFKrUvpkQDCVn2CV2YaglPcdwCSGyvvYZQsec1sgwd3D?=
 =?us-ascii?Q?z7Ph1njKyvBlC3D/CfsuAMUePvxMzUJh+JErHu6EexOu0itO+IM0bXCW8nkO?=
 =?us-ascii?Q?hiwshHQvhoVezCuIMHjFvLReJLYZ30QgKm2BqktRZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+4uxXia0x8YuRCfQVKp8Gy/RqB8fyuCc9ga3akr/x0oW5dlxrlDSf+P6Loq?=
 =?us-ascii?Q?eRv9y43FCp71YWAoJM4WIcJ3IMOGBSGJcKZbQ7waFASzCNjo44qByVY6jKPk?=
 =?us-ascii?Q?w+w5BoPve369L438hcfYzgmuPhxv1cUsSdiKF9yetkPIYcq3PeW+fO/5S2LN?=
 =?us-ascii?Q?3bp3l9yKzp6SL9yBMLF/Ot4X3uQ92/sCBlyTAVjumJhcq626K0aahDIrrba6?=
 =?us-ascii?Q?C8/1/0FceX1AHEedOZfjexyB2w1TU10NArMrryZ9e5rGPyYVkexRBcA6EKE9?=
 =?us-ascii?Q?bi3Vp+rLTZL60eqSyEDlPTI5t6K8g29ifArJmSK0WNgb7mW3OmzTHF6hTOWZ?=
 =?us-ascii?Q?OUw36fdcMG8ddH6sEaWLgnjfEhpFj0QMv7QwV07zvkd84cgEUYlP1wkukVHI?=
 =?us-ascii?Q?HtnvlBhjS/EnbQPt2+7IbpNHksWfR9NX39jOJxLlfMpiDZiPoMdK1MA4A1Va?=
 =?us-ascii?Q?4+2msPsLukRWFhPWrgcR19HZgEH/jMJfM1mpvgQrbVS00aIlS6EfnVWi3MGC?=
 =?us-ascii?Q?8yeki5RTJtLLYt6+xffh/ibYCStwlXeokLS42E7tKslA6c6OlumZcQUU3KcB?=
 =?us-ascii?Q?LnuqpxAjdKSXF/UpjA6nQpTcPO9unFWuWP8OoHiKEro29r2e+N/r34tqmwzg?=
 =?us-ascii?Q?tA/lw563/yuCWZy+H4ILS63CcCWtqZkElvf7/yUhdFgDBF3zisONZTJNMvVG?=
 =?us-ascii?Q?NXGr/EBwAA9wMt8sej3DVJcyM3uetJzBu96cWnOP3FWfT+SyUmmC+nmB0KU2?=
 =?us-ascii?Q?PehtLybt/C4w/XcjJlumBE2r9BEzrMsA2mva5WHUZOGWL2+WnQ4UxCmzwgiu?=
 =?us-ascii?Q?FF/tver1O1M9gdUg86M4L1R6fxZUOYK4gAg2oDnHMHDbXSCvfRQGEnfUj4s0?=
 =?us-ascii?Q?FtQFc0zaaH1QhHaaFMIcvRNed8wusokt+onApbXbMSWyWd7isE4ivLqzd/+v?=
 =?us-ascii?Q?JSWJmgxk7JjE9Ws7nJQFgbxUomx2I/NUwz4OI5XWlieHa2O7Pc4K7PeMTOqC?=
 =?us-ascii?Q?fZZEFffrWEUjAUlPaPEUcqUSE/Dl6MhkM/rbKRgccZKEhvS1afqOAAKf+xq0?=
 =?us-ascii?Q?NpJdGTJaBAmbhbu08OldaDN8PyIUZz/T6FQ06XwDWJagcT2H1P7XPz0D0lgP?=
 =?us-ascii?Q?aAi/TYagaI8nKXGzqKjOBOA6nAgSsxRijgg1d96227EXQiDOCBP3DNv1Xevt?=
 =?us-ascii?Q?FpbERtJcS2gTA6ft+q2kL/auuOqd7ktwEAaPbVVyiUJcP4Cmc7uHAmZ2hlK0?=
 =?us-ascii?Q?GEUDeoqlNKZwpUyc9P0Zhehq1DfqSmP++tvcqaFZ8CkKOMH0CX9vvtO/lm8I?=
 =?us-ascii?Q?nJyiNZL3c7VFYnifIQ4a1TZAcCqRogJh+asCkGCJC0Uu+X2sw2PG9VaziAnO?=
 =?us-ascii?Q?xnIhvIQm0lz+tL1NbEmpB5ENjabHS06mPLzq6CfZNKz/D6g07mNSzsAGZhvl?=
 =?us-ascii?Q?yZcT/tsAczi9GX/+8aL2VsexWUMflG9QgLiud6JkMNVaV3smFq47JaVS70hh?=
 =?us-ascii?Q?LF+xwWMcrjIrI50oKSeFLKCgoPRIdrLU0utODc3LV3b5F7f2dgAQrOybLXa0?=
 =?us-ascii?Q?2HYcr0lcs68+h0GUx0eB0hx5uICMWApKg5Ty4hjuS2n50kG+/Azjq8kXjY2o?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7708a56d-01d8-4ca9-2190-08dc7e95267f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:37:04.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZQOZW0dllvXYgh8x/ZZ5T+82NzgCI9PvMSXG1ui8uubs3xH0IoM28hGCCdk3ycymDpaorBstUnvBEKDykEqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns that "a variable sized type not at the end of a struct or
class is a GNU extension".

These cases are not easily changed, because they involve structs that
are part of the API. Fortunately, however, the tests seem to be doing
just fine (specifically, neither affected test runs any differently with
gcc vs. clang builds, on my test system) regardless of the warning. So,
all the warning is doing is preventing a clean build of selftests/net.

Fix this by suppressing this particular clang warning for the
selftests/net suite.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since the first version:

1) Rebased onto Linux 6.10-rc1

thanks,
John Hubbard


 tools/testing/selftests/net/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index bd01e4a0be2c..9a3b766c8781 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -6,6 +6,10 @@ CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../
 
+ifneq ($(LLVM),)
+    CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
+endif
+
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
 TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh

base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
-- 
2.45.1


