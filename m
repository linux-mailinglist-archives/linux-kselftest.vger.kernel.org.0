Return-Path: <linux-kselftest+bounces-11049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD88D69DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9850028A32B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781917E446;
	Fri, 31 May 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qyTq/Gqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B11C6BD;
	Fri, 31 May 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184327; cv=fail; b=V7SGjutARCCXITa7IYAlilmb2FXp6A1sphhrBWTgkS1EPwWLn6rnciNGBktFakjOBDNCyaTqp+85be3uHtKB+RqD14HT+Ho/R9gLVljAyAw9WHoZKzHwkKNBjWA46mon9nLLBJXNcFuuxxx2NogVT3bzynrVYK+26HEKKKWPDO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184327; c=relaxed/simple;
	bh=NXo5OHWH1dlLO1+Cs6gbTvprRat8q1X+/kFGnMDxMP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KuoPLbHOdipX+/23nq00zfjgO+Me++dM7i8ct29E6qz16MLPUxU5oIX2MV0itBxMxWftdaj6Xha8NZ8gmXEbcBWow5gpx73CkLiVML05IUcA4mnXicXM1NVQZ3lRIETChlmyR7TIu4dnfhMjyMJvP6l01I5nkXJG5+8OCeIbxPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qyTq/Gqu; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ/uZQeQFYsnah7M6yGusGMj2aykUwxPLhADtCnOls3UXhGBWJbmT2m9XKkKBnr3DJvLeDHTH/aC0gqGfLC4gYqlfq4218ClmNowsTSgb/XGNSudHUw2VRU8dq8QTZN3yWC5+hja0SbexC51M8cNyaS2OPGKlOGcJdV+S7NgxB2ToInlUgBp3mnniTTh88FTt6y7yznCvqAGt0FM3bQVI7gMMf8AjIpR0dG/KVHRBSaj7cFML6tykt9YKJQFdjDqKpHmpxc7BGQjiZY2hvw0Y5Rt7geoxVozT/7xRZlSQ12PLK/C2XP6kHvmxalr8Z0Hp3uaxWQ9bL47mAyU6DKZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JpfVRS3ifomvkz9hJqZbKn/0k62rFK4N6x3Tzj4cz0=;
 b=eR9ghq3MPnSChwk7tkJEFR9+Toa/DePQVJyNlPP1scnDPcjNs8cy+mudSRp3DumCv/XZP7wQnrPUwXad8itQoO4mJhXznk3FcbXHO5/O0/jOuuITrNf/5JJZk/5ZKpwS6x9LYgapdpNf2iGFtwVBbN9mua1F6oan0rO883yCiKFa8GLUlzT4icMDBJhwt7Z6oirWN0r6Svd+qKZTkrVl3vQdt4fNrkIWMSXKvhE6pxPMtkvFLNeH3sLKcxVvEw4CEZHkFCVA32qB2n0QswxtJVdn8Y3v1qOYCYlRdMPkve3wo9DZnt5vzkbgZd48+0lvVaORiat5SkGCfKjMnqIdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JpfVRS3ifomvkz9hJqZbKn/0k62rFK4N6x3Tzj4cz0=;
 b=qyTq/GquVinKqcY7QBtTjvkgHc8a+0fOVOEQixPB0HAB29Ot6xEDYaTJLxkRl3H70kw1b8KXP93J2+f0akckcdCbbiC7vRImGXbIq7ZLZOfoOh8pvDF2d3yLG7Fx6EITKqj9M+1TiUquFlHJcYwoWaKWXSeo7LgnTOde+SR+ayHfn44K4a7YfHadyrSNBIHKbgYfl/URiExYvbSqy1ORJDVy7tYOt4IdXdcqDKOLmkLCmkUP3cVP85Sx1A7aYdA6e8BChrLl/NIQ+467mM+Uo2eU/EXFM0H1UIC5i1I58W0q8BeKDcYBzX94i1cq7zVvm4XQkWADw8bGTMj6FwR/Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 19:38:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:41 +0000
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
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 1/7] selftests/x86: fix Makefile dependencies to work with clang
Date: Fri, 31 May 2024 12:38:32 -0700
Message-ID: <20240531193838.108454-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e460985-5d30-4a27-257c-08dc81a9467c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ce6LLYyug3MFv/Y691+7BmeTzqnNpeQ7NfZgqRUyDeB1Bzgn9S+4Zv05gsie?=
 =?us-ascii?Q?EUuAJ7lo3DKN+rae0N/U7BZu+oCTc2Hbf3YofF0VBsRw6XHsom3bJFYklV20?=
 =?us-ascii?Q?NiSTZRjOjUQrw/Db5o9dz6iq81Ua4mXDdhGyUi1fLp6qMkf70D8ZX77O5DF3?=
 =?us-ascii?Q?YW9tN/RDcrSbpiBu37gQ5YpqhSJss3OvPHW0LjWmxW4AWkAk6hiXisE7eNit?=
 =?us-ascii?Q?H6Ue6pItgy2qAsNU9zkOtSlOSNH9ZEUl1x4GtTw3dr17drlqoy1pQlXvkrXt?=
 =?us-ascii?Q?f6JHLolBjfKppdGV9rkHk8JdN5MwIQW0o0qTfLE5HFUD0PhxK6y2ddPsoqec?=
 =?us-ascii?Q?63vOyh6gzoj6dTKEH+86jc5XDZuxwmG0AKYPrnniqk0HspadjTt72CRTfb5K?=
 =?us-ascii?Q?6cche9XG2+olzHXUhmlz5WHXoMM86+BmkU4QEOUIrMBx3RWVAxwgebMb5oUT?=
 =?us-ascii?Q?IGVb+Kju5WDE5K2JjDQ/z5e7/6w3TSBTZOyvAFxGMOKs8zc8PZW4B5C/tWGY?=
 =?us-ascii?Q?XRrYjbODuWx7Rydo1NTSpgqNW+jG1FddyQR7SO8uEaeRPWf0/997gbYr7XKr?=
 =?us-ascii?Q?Zkcjn4R/4fI4YxjMSQPL8MX1dE8R4tlwYbwEsCSr8kjS4q6QoERBs7GHmt/F?=
 =?us-ascii?Q?kXXxoP8QDhj/nDDQnRk8MfshLnjleoOFsNUomaZAy1tN2wXv1WE+4F1Dvygl?=
 =?us-ascii?Q?Jkkfe5iV0OtRU126CD83Amu8P/jowgdwklir8WeJuX9bTc7YGpH6GXgSKHQL?=
 =?us-ascii?Q?0VMmInQZ08RGQWAvSeBRFoTdT1Q9qkWv4mOs9mSZqr4pTwKa9QCbWZQYd9kS?=
 =?us-ascii?Q?r5wmAjz6bqONCPBOfX9ZdL4LUtgDpnE8LlPdAadc8pNhpcuEmOKahTWtSWGt?=
 =?us-ascii?Q?oj67O0lBt6knwfv2QZw4Es7SKPnqWn6tOKOsvPkQysxtdjIMGKz+UPyxo0qK?=
 =?us-ascii?Q?CEXPIBJLCjkLb8VvLUuXnl+1ymthN5Dix6pUciekKGr6t9dNuf5plxTYQr6d?=
 =?us-ascii?Q?yHQFK25TilxGGPpazOZYguFMittPIUCHthlW+XCzd+3476m4OCowFk7H1StM?=
 =?us-ascii?Q?MgSx3jdKtnlSbPNOxgX+swVvmvzo0LxuEtQ6kb/Pp2qZ+GAgOv6VYydCVdtI?=
 =?us-ascii?Q?ZpCT+rNhz+ZSXVn4nBCVvV03YoRSYpJ8GhW2ecx3MVr7AD4QbJRICLfLugk/?=
 =?us-ascii?Q?D39yFOGR8nF8O+f0swqtqtpEeeDQ2TV5z+a/YMjyyIdcnnQqUpch37Qp7dqp?=
 =?us-ascii?Q?R+NU7kA8jKhHxdxaEjgcqQdxwjTpgIjpPDWbd3KqoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WtePqUbTNg5+B/P4WS/8vaiWbiwey2j19oZJQ5tZ1mnWxntFwRKt7UHgOPiZ?=
 =?us-ascii?Q?f13/+uUFB8uid8LXTWoOcFiJuC1/hsaRA6pc4Pl8QbQQEI+1Fk41ASJKtEnO?=
 =?us-ascii?Q?O2XdcveqHYbwa6X7rksB1kn8uqB2yRb5PdHsnvR1wJgV0Rt1Kk/4E1xCTTC2?=
 =?us-ascii?Q?ej59Mmt8siNXZPqdngKBEt65r+ckJR9ycWbni8IrXZ6xV5+nhxc8VpOeRy3/?=
 =?us-ascii?Q?5ptqCXbhXc0/bkThcuJpQ8P5nMT6LMTPh9DJI+KdPUciDVjefpWtgMkCxEmM?=
 =?us-ascii?Q?gTtqXAhzwyt8Ntu/gaQhLxtXCjEf2CLsXOeHl7HOtUO3JFvY7RfaXkJ7xyhE?=
 =?us-ascii?Q?UNyZn5AEystYuoTHQ+hWT+TXPUX+49XcwckStESlwq2IKRpRjQNGZ+2fDrV+?=
 =?us-ascii?Q?E/1rOzGN5ZSJyxGSFG/5q36VeYKTMT5aWInnwXcvT7VdmVkadJYpBySdgEQ0?=
 =?us-ascii?Q?Kt1/AjqqSEYK9sHCjGzKZvoWe9cMsLQn1TeWp2BFSNFG2ocw1h3arOruCQSB?=
 =?us-ascii?Q?lZOGg9o6aVDEjgzYP1xg67bkdPWz0eP4Gl6Zx3rFAPa6bL85pCAYigpNgXCk?=
 =?us-ascii?Q?FsFyBC8HWPQ29c8BorjxZq+OqlzeEyde/gbMwhmnD+Wuh/IOJHbDk1w4M2rH?=
 =?us-ascii?Q?f2vxtC62ZKhPMLBK9GfyeBUedVfqljJ93HV0aikE29PhABtDpFu5NFqbJC5q?=
 =?us-ascii?Q?jmzAK9l1bnVLHRTggA0/63a11aoS7F8rw8bUOgN7y6/hi9S11xKn1EnNeML3?=
 =?us-ascii?Q?MhmBKv1HvoQ3B9bll/z57qgTzZCMRuHjV09D69hcTuF7AS1SytLrPX0rA9jW?=
 =?us-ascii?Q?p+mnmgbsEZ8lwx2cSgXP3aig8evGkJqSxx1Ld4ZazV/XPy4ll5VU6EylrbKX?=
 =?us-ascii?Q?5fdACdBpDPK+ujb3eBIeUh+Iivfhutw5B4TveXBghayhJOTLFyZ0GM0GmNqP?=
 =?us-ascii?Q?Ma66SX4ThUwtaIEuEOjPlcK/iCthqa0DTPe3669oW87KAb64q3UC3QnLIKrQ?=
 =?us-ascii?Q?MrSKJfqTusDnbdSF2Wbx05Lyma/onSxcV6OB8CBfHmNFNqlKoKV1TNdjY76y?=
 =?us-ascii?Q?qNcWDzoNQR+4gss0YzfXrfzi6EBfGR8uNoC6ZhDBAmgODfUDHypWwpUBFhTG?=
 =?us-ascii?Q?ABldysCRiBbV+jarfkibOhYX7cFryTY+rK7MB4v3eJeVgSg1KtcZzGi+UQ2D?=
 =?us-ascii?Q?xmo0Ohj09yHoQpmRaVD0nvRClejSiCIRmJHpPvXgZJwtqKWPCuPoNQvUzG4G?=
 =?us-ascii?Q?Bir2Q5kvKjKhowX2aGeAm2fgeP7SP/8CtiHMADdp/Csim7Vvvzk/ENdbfvf5?=
 =?us-ascii?Q?qxHbUO4lJhwALkVBAWo0zYKnHCtnCFqbGO84FpC01P1iBA3MnPzxrHAKkMeX?=
 =?us-ascii?Q?7xhP0ywe7a/PE3TW2PmeV1biD8dBgupUjkeDk+nJ9pQJrbgxXMK0TarIACXl?=
 =?us-ascii?Q?FpJpz6NmqtIMY7PR1a359naL6+6HIGzTfItycqGInz/01wkUgZiGJD3QxThc?=
 =?us-ascii?Q?oeKdaOSvz5bM/n178V4peAzl5tl1RnM3/ICTnQuItXweGkkxVWuET+bf3378?=
 =?us-ascii?Q?JqPQr60mFhzbu204pbG4UYB5midqfE+1C/b3g4My?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e460985-5d30-4a27-257c-08dc81a9467c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:41.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQs6kbB5hxdddPTu+SJfRc+MH3Th1ncD7dkBCalxE7lGCueEnlns3znTtKxPDm0ikcgloZWBj0gmQz7TrA6HVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

When building with clang, via:

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
to pass to the compiler.

This commit splits those concepts up, by setting up both EXTRA_FILES and
the Makefile dependencies with a single call to the new Makefile
function extra-files.

That fixes the build failure, while still providing the correct
dependencies in all cases.

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
2.45.1


