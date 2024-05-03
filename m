Return-Path: <linux-kselftest+bounces-9310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82BC8BA57D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501D22843A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8C01C6BD;
	Fri,  3 May 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSIeVu5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7411BF2B;
	Fri,  3 May 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705347; cv=fail; b=b7uAMBr/ESA6CcYFOeMrrjz1IwLwzJKJiSEWMWPiTMI+cLJpb1Mgs0wZLdCSum/cpQXF7kNS142Qa9vFiDO4jcrHM6pK8ptrvTUXcHgeWhEToL73RdgxdxAd7jG6MuLyoTMxaTSOHnxfEdhSOJ9ySSvXabrtnKug/241SXQeMMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705347; c=relaxed/simple;
	bh=FrW0QCYswwBHG33dYl6LglaBS7QJD8E+wWjt3tX3yfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRxyFjnKcmGycrGQR6KTiHukXw2MYLk4U5T8aKG7qMVU4JceU4ilVHbJRLM0uqoE1+G88NJRirpxtLVw1QWYx8cuR2QTalAlgaZRmSZwS4aNfngL+sM7PBWcSc2a/4sizLV6iXF+qop8XLNkH7/e8LA2nOijXnHD0zwG36E5b60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSIeVu5P; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYix1v1Az8JMp8Hfs2vt5IhlV1xjhl+J8fEdOs6dNVlNdvJTJhbko3bu5kN3T3PolGXmPl7fZDW5newGEb4JA56jCjW4AyPIXWKw3+16lrIqQQ6GsxM3mJQWnAaD0qqIQ7DpnL1DDRvFjn1dMa/UZ/1EUGpqaOQxRuTz7vuQEOGMHu13mnj/INvTw2SNOmQHmGRcC0n+lU9IYJ4K3zXNq/uQsEMzLRAIMJZTa7IbpnIL/8iEcwGhpIIQKPwwzfFV9XHfwGKB7zhIHqkfFg2hLmF2tIElaS/DX+0fvdqKS1Q4DwxThSaxB3+iDcKrdR1xWNetDS5clkjCkytJpoLMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrtAYNTBOn7GExk9ndx+JU/5Z0QkjDJ5YY6nCJy4GCc=;
 b=UgMFBNlN/ntoCvwesNENW6ajgNX+JDqWu0xqQgohdSfeaDT2JUtbfiwl9/2HmrjfxDdGFY9yXIzZ3I6UU2yXXepF6iYJ72eDbif/DKJ5Eeke5X8wU/MoAB9BtCmqJV4rUTOYh4+r4WE23hRMDqYX3imQMLeIK3dbibCDHL8914CcRI6+LuoFu1dIlHGuq3VcHexkcu1eEx95MrW6kp5HsKQJRhtEdpRU9rE4eKLy2rUtqvVjbPM+6M90iRUIkopfJdAEd6v3xREaDSIgVZvZ2rmu5acDfJVRyFQAWzyVSrlcJS6aX5m8/iFTLCfM7v0f5SgG8eUk6pg2djSWXsb6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrtAYNTBOn7GExk9ndx+JU/5Z0QkjDJ5YY6nCJy4GCc=;
 b=TSIeVu5Piwd7Li53F5bd2c2xOHBMhmMge5UodbAXWUJLHcGpeoJKUSufJbQsWi0FkutgvlwCYbjfaBSSiUYGQwulZ0Np9CcBNeEso6q7Eaqva/oL4SUoSwB9hyt+WYttPasm2J7jOZyk1rKbjkylg1DjmTW8HRUNMmMZb6e2d79CobiCx/rBN8p1e2AlyUSqVxVSQkIvLUbMIMJZJe8nikku31AcbNRY+5WYZQskCYf0bKU7HfZqeHxfAOuMWG9688GhVQToLqx+4hDoEaMKK3BkHX0yopZgS99B+0XNBR6T3kAgTZqPCQknOfevsFsQ2wxzVw+FQGlQ4fwqCt5Gpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:02:17 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:02:17 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/7] selftests/x86: fix Makefile dependencies to work with clang
Date: Thu,  2 May 2024 20:02:08 -0700
Message-ID: <20240503030214.86681-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503030214.86681-1-jhubbard@nvidia.com>
References: <20240503030214.86681-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:a03:54::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: b875bae5-0091-4647-ddb3-08dc6b1d70e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Y+tFxGBg5pYBdxLpEoSRJt7e/rAlIn6uWz1gD4WX2AKaF6f6Q4Su4guN61L?=
 =?us-ascii?Q?CAJau0CugussffzQxxSNwKA878EuTwdS160fP6iiVqX+en07lCY8jaZDJVKK?=
 =?us-ascii?Q?/UBhBaIwAvhr1fXE/nAYdDo4YXo+M9u+Zf8r9zcN6zKQ/6hr1UQ7vR4aIpot?=
 =?us-ascii?Q?OYmUBk1Ws/j8DWAKIFuymOp9Hkyp4O0VBtK/uLtIekOHAQyROgBQSDWgfHPl?=
 =?us-ascii?Q?g1GmmvWql2BHhmFwe02KXWSQvpCRmcSOWSptoVPZu1q9L6WaFB1P/4FJ2m5i?=
 =?us-ascii?Q?PMLePz1X7SyCcAKZN1R+FvuAq9uclHuhKoSIDaWHNYN8/iBYrWNJ5jQd0up0?=
 =?us-ascii?Q?wE2YH5BDzSwisrxzaK7LOPXytWJ6nu/6gLMTtRoHDrlG0EBhVto318ZToKWe?=
 =?us-ascii?Q?SSqlux7kJnu7IeDtREVX8aOaNnPohxBAmPe94tB7e3L7JaqFP3CJedkdzz2y?=
 =?us-ascii?Q?mMsd8jynWF+SOwlZT+SSMOyw9jZnk774gh0BwpBN7ds/n8q3wnq4MLOY/iPN?=
 =?us-ascii?Q?F1oTIATP6kgFio3l8bPhQiszKiNh+DORB+x7fpIxG71X77263dren/lAWScZ?=
 =?us-ascii?Q?cfmB8WyGCbLV/xE4Lho/EWoW2G4CCxzzTDGzPWjVULLZzU3Bqm9F2+JFb8YX?=
 =?us-ascii?Q?ihEET3aOY7X+S47ezZRXYSboQsmxej2DHZ/Nedc9b4Yzs+XgahWH8imK8ee1?=
 =?us-ascii?Q?/rBf1TeJplQIkoNi/UEvimQyv/D8hiPkBniWBgKD8w1Zt2Ucz7crKnnPxzIR?=
 =?us-ascii?Q?strnaaWi2aPB1FG1+njU4RHajqstV01Z4cFkCCsd00SxteTFOFBays9ZSxzJ?=
 =?us-ascii?Q?9P73N+ZigKOzMXsCZxdSZ+6/09D5+hWqx7N7XsSXXNC8VIqA53lm5nK4xlqb?=
 =?us-ascii?Q?UwU18WV9R3lusGxauAs5HEFk7iSKJCKYvnMoX+Jv1VEZjdLJ7supad9Pmy1X?=
 =?us-ascii?Q?Hg707carQeC7k8IbLLY2rOiOrs+WpciTNW1fbCUwHINU+4vQi5SLS6LCZkGa?=
 =?us-ascii?Q?O77dfBFw1/HK9+mgTPa4wMo3Hb346FV7Zn4qyRJOuNVsy6AZRmDwdaaxxZLS?=
 =?us-ascii?Q?g0e8L0QaVEyXUtC/JREZmi3hdhDVwONldRXb8D3mIAGSBgb7al96WOgQr+0n?=
 =?us-ascii?Q?EPwqyXByagR9zmboNIKAMyt2nedUPOV5aj68Bx6znNoIowIy18BOWSmPsm3e?=
 =?us-ascii?Q?WRv6FTlT4OVQK1HQJIqvENjzvhApMa/C1fehoxpUrJqa/KPNPBCfqMW3glxf?=
 =?us-ascii?Q?9KHs9lzZ1hUF4aupewCYgwOxw2vF7hFgH1Mt00YpCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHGWj3JhyYo98TjwGEI1hDsNq3DizjnZAPNTXuRkAovtk57RDHsUpirIA8QS?=
 =?us-ascii?Q?62BCNiodP0dCrPYqlzc71CG5S9KG69T1sS3wGq+ruef5zNLjbd4G5SJgDh4Y?=
 =?us-ascii?Q?rzVSb22P/l43v/yaxb5/pII/6v98mabOBC6oi9P4eivCozm06vPWNS1IsNYX?=
 =?us-ascii?Q?bvhCsW8UZHWKCpmoUXi9uLuRAFPfSqemidrvTFXdACL4gyTDGwIYstoedL78?=
 =?us-ascii?Q?0tZOgWWjigqeJsUl6ljrpBman8KYX0rND4BZs6Bd/ufY6S7gXJF0UIXxyXxx?=
 =?us-ascii?Q?FckL3qKSpNeA2g9zmcAIFoorqtyVcw8LyV8hMmNTb34OcufSWYgu0pO3CYmD?=
 =?us-ascii?Q?3O9QA1zrqAzHUgF4Wx43hlWwt5mqOI3una75LbJ1ZatrVcUigsvPMCXWsVGc?=
 =?us-ascii?Q?MCZhEfb6zhzR1lliaKWZ/QsqbmvxYlhlquM+oEAwc4vK+a+ocdGIDA84JCLO?=
 =?us-ascii?Q?aKHE2GB8vSe1B65aIm81nWWuSniZ5M1y1ccHq9mOcGlUMwX39XCrjhpTJelQ?=
 =?us-ascii?Q?foc+M6ajTY70GFRaPIdHp9ILLDOP5V7m+ef2yHUIyaqhaKYti4O0Z3TeDDob?=
 =?us-ascii?Q?8B97Tkstm3NiJoVCy3EOy/IsmsUl1604bhAANJNU3AWi0rlVTWpiTHh1xTFb?=
 =?us-ascii?Q?djnzBJsZjIhZxp8L0cti9So4UOyjD05+F69x+87XJYQqU9igoWK+n2hBht21?=
 =?us-ascii?Q?0X8pETPNTuZsADRk6lMeB8avZNOI7djrXovH48PHvT8Ikb3cEpa7I6ntv67r?=
 =?us-ascii?Q?lY7zgVATxSNaAGxlHuuKl0cyApHamCQEkzafe8Hx9o7GRtC94o8mw/DEui7P?=
 =?us-ascii?Q?NASnZXskhG29/p1c1FWoUw0ICG1Rclgue9SHQupOROLqNRG/ZMc2DafRiucA?=
 =?us-ascii?Q?7eGqSc3Dp6Mc5FU2hcGtEizKU98A3D9+hlAoxHaIH42CNYZ4AsR6UJFMhC8Y?=
 =?us-ascii?Q?3lOcW8wb7YGXrc3QGo9fAVe1xi6bkaZjKun44Yu/y1lRyelDUn34UZ6ebH5d?=
 =?us-ascii?Q?hM7SAca7BFHlvJeuInceRPTfPjuVBkOFdAhdACvkI/fMErDFkkS8eDcMb7SF?=
 =?us-ascii?Q?sfuWEiwzFr2OYtsVGCRSwoUA28m2tBZss0D0wSZVd4CoJ/xMB3zfc25pGCtf?=
 =?us-ascii?Q?xJUDnvOmmLSSj1u+76XXQLEshGCoVt9MMr18FADaSWm43nUiZMw+LWBVlgTH?=
 =?us-ascii?Q?p7kV69cP7/lUhbfF9rbK/al8BSRBHjuL8dX2Z2bul9VTYTPKXdYiKmztNb3W?=
 =?us-ascii?Q?spUO/ArdDTVUn+Iz2/qI/v6Hpy/8LPrhEs80JT++v9v/yIp7Us51VEBksfNj?=
 =?us-ascii?Q?uGkGGAfJy9XGByz7Z7XXhDZbmUuPqv/A7+n1DAktuXrkbtr1NSIIjSetdRS+?=
 =?us-ascii?Q?BwpPYc3HXgM8wXtEJpUJvKgfU1x9QQzu1dG6t0pTVfHduoEAncaTu6m9UT02?=
 =?us-ascii?Q?OaxVdLM7zP3+KDuDaVy6Qxn1vJXkZWePJ2qUG/GFrtIFIqbHwCCSs9RAepQJ?=
 =?us-ascii?Q?x8TIGd6MfDtcPsvlbWu01jp7LDJ6tjOEu6gxyJdFBklsRpRju9ireBNMEd2U?=
 =?us-ascii?Q?1T62C2NlgkFZdM27cIPlPqQGPyv6CEqZaV1p/f5w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b875bae5-0091-4647-ddb3-08dc6b1d70e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:17.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lZ3YbCUJlR/KcKySDHMbOWraMGRAfQjbdfJQYdrgt7jvcta4Y/YC5jw39jvN5fRewnQXDAzkwJaqIqwPEir5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the following build failure occurs in selftests/x86:

   clang: error: cannot specify -o when generating multiple output files

This happens because, although gcc doesn't complain if you invoke it
like this:

    gcc file1.c header2.h

...clang won't accept that form--it rejects the .h file(s). Also, the
above approach is inaccurate anyway, because file.c includes header2.h
in this case, and the inclusion of header2.h on the invocation is an
artifact of the Makefile's desire to maintain dependencies.

In Makefiles of this type, a better way to do it is to use Makefile
dependencies to trigger the appropriate incremental rebuilds, and
separately use file lists (see EXTRA_FILES in this commit) to track what
to pass to the compile.

This commit splits those concepts up, by setting up both EXTRA_FILES and
the Makefile dependencies with a single call to the new Makefile
function extra-files.

That fixes the build failure, while still providing the correct
dependencies in all cases.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0b872c0a42d2..c1269466e0f8 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -73,10 +73,10 @@ all_64: $(BINARIES_64)
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
-	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
+	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $< $(EXTRA_FILES) -lrt -ldl -lm
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $< $(EXTRA_FILES) -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
@@ -100,10 +100,19 @@ warn_32bit_failure:
 	exit 0;
 endif
 
-# Some tests have additional dependencies.
-$(OUTPUT)/sysret_ss_attrs_64: thunks.S
-$(OUTPUT)/ptrace_syscall_32: raw_syscall_helper_32.S
-$(OUTPUT)/test_syscall_vdso_32: thunks_32.S
+# Add an additional file to the source file list for a given target, and also
+# add a Makefile dependency on that same file. However, do these separately, so
+# that the compiler invocation ("$(CC) file1.c file2.S") is not combined with
+# the dependencies ("header3.h"), because clang, unlike gcc, will not accept
+# header files as an input to the compiler invocation.
+define extra-files
+$(OUTPUT)/$(1): EXTRA_FILES := $(2)
+$(OUTPUT)/$(1): $(2)
+endef
+
+$(eval $(call extra-files,sysret_ss_attrs_64,thunks.S))
+$(eval $(call extra-files,ptrace_syscall_32,raw_syscall_helper_32.S))
+$(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
-- 
2.45.0


