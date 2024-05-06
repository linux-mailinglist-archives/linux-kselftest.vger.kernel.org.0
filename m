Return-Path: <linux-kselftest+bounces-9551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2AB8BD4A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036BD2836EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D14156641;
	Mon,  6 May 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qUbUZrH4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A791DFF3;
	Mon,  6 May 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020465; cv=fail; b=uRQId3ng187qjkJ1+Ih5atkzrgmx6fLSMz0kremGRSHDFRNjNTfZgZCKBE9cNy+R//02mlo+SZkYiFgHu2ezPktgoQsskc0t6Bbbxqi26bxyY0wMkyXttJMIMWv2fMZKMIU2ICOHdmH0kCcRefQims8StQKtrDjki6Gx5dywBsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020465; c=relaxed/simple;
	bh=V3a2MI2gS9aUXncT2qhTW/gN10Or3IB1mfYGzirvtuo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kjMpo7xOn/SPxGRs+AQTa/UuHi6VzRzaO92/XWJGjMb1VMlL0q1JSAJy6HjEZXh1E3RZdElPbsyDhok0qfKXHjEs+6P+lKsRd3MgqC+HxpP/2OHzjo/m0ddbYCsKY38HJjVVQbxURVo85tQgvs12PUy7rU1wPo03OM5yBSYAdSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qUbUZrH4; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9zIuVXOKhgNoLvDRFz0zMDjNmyE16vMXgFRzj1YCyms2lZWuiMDS7vgmglRq7HCvw52ggVJlHNAD9704NHWC7Lst09J2hDTu3T+NPA2W1AwM3NUM+fXMjkRXBU5tAap/kbj4AGXRS1aCLHAlt08sQLdoIqEOCYWoz0BQMKWwZ4CRvn5mZKZfr9j8JLvFnir7krt7W698KqFQQIUKC2K0JyIfuXnmEay6L9bviN1iW9E6dTJfRbYRnv6bptGfvmcRbT9Zj/lWVtQtomEkk5/IN178/GaO8LrWkECVZTkJjRjxByX7kfrYUBHcs8qVUDYfR5iJACdbTA7Pl29MveiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPXo9Zm2kSlTrTdCWARl5TIWsaY9d1Pip3eswOsp688=;
 b=FvFSGMOSu37+nJgLloZUHX8e2aoBST8LxQOYKCb6zwiXYbRurQosKLt6SXaAwHoDcUxp/P27OBiE1u/qDcK6YyEHG17f7F9X2T9f6mcHSM6SoPTRVHDgi/2d9TovDoGTv2PZ2r25tbLXjtpHhC2KJQb2jrTgLZ0mLBIBuZrrG78c+1Ad4b2a7AqHm7ovN4msPOLFBf4ThfjZDQdCBJRh+9mSZgRTHIQ/xSs7kF7y2xzo2zOPtUsEdgW0TCgglu7em09wbBaf3K4+I+umza65Cwr0bFJKLijQjtnq3fNEulZT8v0AGDXc8KAMhbTnxTCW0g43Et0AnxMg4MMhVZqvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPXo9Zm2kSlTrTdCWARl5TIWsaY9d1Pip3eswOsp688=;
 b=qUbUZrH4eQ5q9zt9U5k8CzOALFLnM9MuHlWzhclbKII85WB/k1cToqbI7yLVERA3cuOch8QNeR9aH1ky2YdOHXqTF1p+bx3NUvipqCuG4mc03ig/flCg923zjTeql1hStpU+61DJ8ycaCNoOIEY1GMskOA3DizeJjHwkX885tf/3xmdlsujjvXtB4LYQTR9+0aD+0MeJHS7Zu9oP2yM7hBP2VNQMzFaRPeoO6VCuF2j+Bz9+XrihHNZWVsiVUriZYFBVurWcxWXb4xbn+JUuaL4kKjbIRaJFCeMqV8hcyeOx8mehGXZQIDkZ/pksRhNlGAfDErhj7ePh3AyMO0Yefg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:34:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 18:34:18 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Max Lamprecht <max.lamprecht@mail.schwarz>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Boris Sukholitko <boris.sukholitko@broadcom.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] selftests/netfilter: return a value for several "int" functions
Date: Mon,  6 May 2024 11:34:07 -0700
Message-ID: <20240506183407.26032-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd89297-bfd1-4d9e-0a87-08dc6dfb23f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BNec++iVZ0cl7rfNaSo0qY4Mnwdj3dP46NyEgVZyU8GwJfngM6RaC2iKwDx0?=
 =?us-ascii?Q?+V2PuNiai+gmuinImYz+ShOaiW2Y0jsaNZzvV6VLZAI8cz+iv5pcWuOM5Lbx?=
 =?us-ascii?Q?U60cXm+XwYUcMvStkWFmkZ4jvX7sJK9bWGO74Jwtk2+8WJXGM/2qBvW0ujpB?=
 =?us-ascii?Q?jJiDoo4/dYsoNhgVZ0Z0+dCUknNTgQYgEz8R2XIYhT/vK7BnSugOzAar5WNn?=
 =?us-ascii?Q?WFC0w4ElBdvW0+ufxgGTnibCkSNZGUuXFFzT9uXLxcnv5JTz7IVAnUoPcULH?=
 =?us-ascii?Q?CVFt2EKi5z/U1AzUBxozjFU/62jubGyTFnhKCULUpulB7jmJHNKDXnTbnCv5?=
 =?us-ascii?Q?xh2an10xj3hMEVt8uixRDoqiJa7dtH7JRPVQuLR6mnTXfRH1Ju3QysNwNKTb?=
 =?us-ascii?Q?ICfriLUzTLJdT2GpU8lRl7jO6W/Hitfc5Khy7tmts7TLd/y9YFM4pJYpkQBk?=
 =?us-ascii?Q?Ub2K9XoWkPrv9AcjuK2yJuS31HueC4rkkSp8RDas4nnO92+5OIBjNVp7QiCJ?=
 =?us-ascii?Q?ZBi1HzjmCd+OL+bZPeMw7b++sAL+pLmnP9Tw+aKjU+Bd4noN5QxGPdmQiTxT?=
 =?us-ascii?Q?W+BirfPZWdqdVqzr0+cJz3bmQdcQ+KRnRD4VqTgHiZBcwhRVoDbZAHa8JVWD?=
 =?us-ascii?Q?+9jgRH5F5W4ObfZsWqUoADFYoFZVLL4q5uR5Ibow4hHfbEJj8hOFVTbvODa6?=
 =?us-ascii?Q?0h9OrPfUHO6ikr53jF2W3YwMG6GMODyCkD8Tf8eXjWAfpTTLGhHSgI+wcH9y?=
 =?us-ascii?Q?4WYIzTE5q+3jvyEt4BJjWGRKniXWw94IDUrfpN3v8DaTzGhT4Niz4La3ye0B?=
 =?us-ascii?Q?qRhi9e1F/imBR04vz6h/oHAgaKOjUAV5zevIsSBx5h7JxaEZiBId4g6PQa9z?=
 =?us-ascii?Q?WLmYdBt2M87D4/IdnnYmVzb9Rfhozla5psvt5tek2Lc0cTMVX4aHz+w45dBp?=
 =?us-ascii?Q?bpIO7yM2f79Gwsx3JEEBwIuFfUBE8Ys9Z+gfFFLxrbMYFNHSO8v+QsKBLpTi?=
 =?us-ascii?Q?85u3O1UAVswDTF2Gr6ez/+jpGc8L6FHMJFJyrWVR92AcHS3+h0A4wSL17aBg?=
 =?us-ascii?Q?Qff0xlIMzqKjDVt9aYosC0lPImzQnZ7f9YQe0cwAlKyafRbVKxh8kFBLmbHY?=
 =?us-ascii?Q?qVTaWPk7iafRI54m90+kk1grkKS95yIeRTY89b1p8jxW+8hSCKvbkzVdQxp1?=
 =?us-ascii?Q?QndLIsBZ2xMyOmX5UBgPjaNtbjCeCJEPGiJq8zlAqUuM1j29dNNMAU1i0mws?=
 =?us-ascii?Q?VLKgCWO0BGtI91umDFATPjmH9UOOpsmg55ScYKkW7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yfb2eW0HluTMmt3fqlPK6QEi7NZKniBvUdFGECpUgta7dn9QZV0ySInnKvCE?=
 =?us-ascii?Q?nxHdoLc0WOneXPoVmARGW0lXRl+EET4P52vb6+jSa6/RTQiatrezAfFLpoJp?=
 =?us-ascii?Q?1mLIc09xIYySFIPY9ql0q5OMpsoDH0OoRIyH1xj7XUDF+kKlBP4/VESSRSAl?=
 =?us-ascii?Q?7chMqjlEH9C2CpJjy9W4+eJvI6TeCnRigAUXup+60NjPQmGlrcmM18XftamD?=
 =?us-ascii?Q?TktUQCCw3vDT5xpTrD0FO6KR7Aosg033BtTfb6aVYZZX/V5u/LermePYuGxD?=
 =?us-ascii?Q?8B26vkiQ1gxMWwFqXodRnMNILUFGxUcCt1dkGuWFWOSaGN3aoyin/qM3+7EG?=
 =?us-ascii?Q?MhpcHigdHxjgD0bwcXXKxB001r8xS/cN9DfmBbiI4OCrZDBKOt/rMargDECJ?=
 =?us-ascii?Q?jNSKU6Sd9b/1tYHRIibETvupuP3INUnETYwoqB+eMF0a24vA8BNNUFf5fLk5?=
 =?us-ascii?Q?B9vog9mPX5fER24SUISM1uf4sMSCaaoBg6McHmdu+NyfnHMYu7msnhs2zy3l?=
 =?us-ascii?Q?hnb3Y1G7YGiMUEkrVD1hPV6zLlVumE7aQeYuMgNKjmUvSdn+XAswff+H2FTS?=
 =?us-ascii?Q?/rufkP1cQILrGSUqyrbDQIe0hclEWf8OCQXrObSKOojpcMfHzC3RkYF03JXv?=
 =?us-ascii?Q?oLVYdORZ1tM84+L53dxE9r9pfKvdGW6DA6/eOLOkT1fNSOHhEgzZhzgo95H4?=
 =?us-ascii?Q?Y7P9zL7/sr2uWTMmdXiZrSzcEd/4gofKKMlH3eJT5WNmlmGoU2CCna0V9CRX?=
 =?us-ascii?Q?m0+3jSZKBHzAh3j60i3Y30qQf0a8q7/whsUQzMz604/1VT9whbgDmACYl4Pb?=
 =?us-ascii?Q?j09RDRP718jKVwbVyMsBNdHTffxoC2nZ2DyyFWthRcqapdjtk1KaN19Y4Oew?=
 =?us-ascii?Q?+HUYOfupIfE2qDPSYomUSyEqJ6HlMvlMpdJvtRkNMetLBZ0fNr3HtqDRAukR?=
 =?us-ascii?Q?BQRKPEvn2/JEwrKivEjDsvUxtrpbdHlj7hq5RrNlSq+kyK8jGVCB1h3W/uU3?=
 =?us-ascii?Q?tuFn/Ipku/sI/i0kiBH1fVtajcYF1UVO8uo0IeCQv5X2ecWISZ4kcJZGXqMD?=
 =?us-ascii?Q?uSABSYx3oNzvbSY1taFKtTyzpf/FXSTDV2yvcRv3FwGokScmT3N+1lAV2jij?=
 =?us-ascii?Q?S2meg8WS1AAeJQjIbjzoKYNs6FTOFoC0tzGx+scweX7Ec/PORBbAj7pfn5/e?=
 =?us-ascii?Q?MPPDgb+TYhIVgzleKHuupdn2r3enzaMlQnGtNPv9Cde2P/oFU2tdHjQAywr5?=
 =?us-ascii?Q?6zYEtIIBHPfMJcgxe7jEk1dqjD1wyVBpCJ+jugDm5ctSrHFRK96iBLkTQA5M?=
 =?us-ascii?Q?VtBgoWnB0izP5l0BbuU1Lqf1Z3Ywcu0R3S5yOMITxTdGW4GrlchiWd16oOKJ?=
 =?us-ascii?Q?hTtxQpIwFU/UFr8JBEL6wVb78I4gH1TZ8xyuQ/EyV6RNNOdqwFfqfgCnqlQJ?=
 =?us-ascii?Q?iENB4g82LWe+H2H2GsKwaeM7+P9DFBwR5AJO6xd5lS/1hfnBnEPtol3kGs7W?=
 =?us-ascii?Q?mceQH9XXQlOFL60p4DZuK8wenY4/RzJ8JsQa+zbTtka9A8v7PPpaSM4dll+m?=
 =?us-ascii?Q?AssT17pG5paQgGYGoO8rASOiPCO+o0d5DlmZ2sT289UPO2p2U38oK6hbKju/?=
 =?us-ascii?Q?PDizfT29d+olXLYx7AiAYBg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd89297-bfd1-4d9e-0a87-08dc6dfb23f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:34:18.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpXeabONDEAyzt+sbeKrMgdjwd6G7km2sEYVn1n8Y9cacGHY+OEeR60zn4vENeDULhtFvIGYaUaFZhTM1EFO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns, correctly, that several functions declared with an "int"
return type are not always returning values in all cases (or at least,
clang cannot prove that they always return a value).

Fix this by returning an appropriate value for each function. Thanks to
Felix Huettner for recommending MNL_CB_OK (which is non-zero) for the
return value of the count_entries() callback.

Cc: Felix Huettner <felix.huettner@mail.schwarz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/netfilter/conntrack_dump_flush.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
index b11ea8ee6719..e9df4ae14e16 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -43,6 +43,7 @@ static int build_cta_tuple_v4(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+	return 0;
 }
 
 static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
@@ -71,6 +72,7 @@ static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+	return 0;
 }
 
 static int build_cta_proto(struct nlmsghdr *nlh)
@@ -90,6 +92,7 @@ static int build_cta_proto(struct nlmsghdr *nlh)
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+	return 0;
 }
 
 static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
@@ -207,6 +210,7 @@ static int conntrack_data_generate_v6(struct mnl_socket *sock,
 static int count_entries(const struct nlmsghdr *nlh, void *data)
 {
 	reply_counter++;
+	return MNL_CB_OK;
 }
 
 static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
prerequisite-patch-id: 9db2d20be98dc44731d8605a3da64ff118d2546d
-- 
2.45.0


