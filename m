Return-Path: <linux-kselftest+bounces-9323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BF8BA5FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0AF2839DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE6225CB;
	Fri,  3 May 2024 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KN+4OcUi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1E208DA;
	Fri,  3 May 2024 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709930; cv=fail; b=Mq33n5fsx+mou2d9OZZ6s591nEkGtXieHjTGiK1MksGi+KlKxox3lSihCps+hAxJl/tD0zndZy2VXU/4iIPoa8CG0RJFeBSUgnQzuTYeY6YULzFm6zp3tYQEHSumpHALKUASt5AlsUczd5FFhNlYKwADIG6f047WqIrGd49VjE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709930; c=relaxed/simple;
	bh=RAENeWBcdt8rEmDVrn0UaNvNDg5zfnnoehPjBh7BHhA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BCtLyhMH25E2HST2i0FDlffjvVXUapgZE/Y/Ku7EFNWywe9sYCBYRSg6z76tB/UE+i+LFAKjD6LxeGGO+VA0hORJq8fgTaCGEP1qVTTqCwBtzrZm5HtKo6RGH/pfwIpwM8sWXeXsCGT52mUAZoqhGtFNcMmmU3815msWDh8hjOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KN+4OcUi; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sub1QBJqo1rejyIaB3xeu4ILgIbSi2vowmTWk87LJp7ZIsq5OigaCpH732I+XxE8dS/qOmJMtM/42S8N+wBVO/UdIHe0xNBoSh+kfDGQ/JrbRPt7NCvZVFJPewBCdlCLTKcn4doSC6Bg+NlVTkWIdyPxJIRqr3M/XvteH1WZngXbe7Opd/62/ay8O0AsFyEeQEQaqFdIAgfVWSQbj/Zs59YIbDGM1AdDXVkGEi+XQbKde0YRQ1efx2Ez8p+XMz7ocqo/nYqFyd3Y0pKpixg7DbNk2WIOQutZU/49c1WngEuBinmxtUCngUePjXNUSEfQyXlJp+t/hix1I+c7PcpsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxGMsZGa57DvPdou0U1ZH8XsrCPgVatapezgDzCztoc=;
 b=a5Z5x2PK1WgA7WjQ1jVYi7kix1WIRytbzz9WN4JpA3wKxHLwmMVBREzq+ODlFMFwaYR7tUzhegyAZuMf9oBDB0PcRrNZd8CPLkEEHAlFMs10o/DykpRxvENdQa0wiAREE8d13aDqskopsSCKckQCfLzur1ST08bmNZGcW+z5m1S7cT0brTD5wARj3OntzkcXm6huZCTbax690QXzz7IH8AhyeIbe7A8HwEfV3IaaZ1BQkqnKyEucNZX36nplsb0+USCu+zYzoxH89Y4k2fIZ96aevuxUUZsROAlLYiohgHt8fjsgEzKZubXh715/nXBbizEOXb7BhDNaV0X2BbNg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxGMsZGa57DvPdou0U1ZH8XsrCPgVatapezgDzCztoc=;
 b=KN+4OcUiFqGXmrYxLvaNNAVm1LppgUJu7r1jhBQbZ1zudjRRRy5f3waEXl/DAw//3h4e80Z3BTfWZJFODL3VxexsGsHTSCOjLJ1n2dft53Ja8Erh4jQUFLNcbGea8IBRkYWuYW9ELLDCcPGeRh3mRnOqI5bs9kYWDMFhmvqDzcnoFuZDnWdXYT38ejviYsqhLbcuKBUHB2avaOJh25sLS6D12hUG9TPPna/xOwdW6ErIcn08v5Nk/UFrvRZCccLDWH7Vtfd9/F2bcbEPz1GV7Rn2kUn2rGBq/J4NeiuXWxDSlGDFWKU8knkI/0Qc1fmcrn35Mmh2XtryCGE3B+GSUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 04:18:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 04:18:45 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/3] selftests/futex: clang-inspired fixes
Date: Thu,  2 May 2024 21:18:40 -0700
Message-ID: <20240503041843.99136-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: d27e28f7-fce7-43cf-d675-08dc6b281fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZivCT63KiE1N+1jf0MK22io+UaoUQRB3l4Z5kng/B2cyS5QauCASEVaUaW5?=
 =?us-ascii?Q?55NUP14TG/urDGuhYQimIiLtDX0Ih+vWAff84jmD+fOiTBrqpgVQXNWz5a8L?=
 =?us-ascii?Q?M9JeJpZSfUNc0FUtNnYTJFICoVwpFxLTenXkjLqUd0RRbvGUBPXe0XUz3brk?=
 =?us-ascii?Q?hiSzsvneKv7Wwd2LaMRRKaCsZyTB5DTf85bE+XBabFfR9LjJSHnxgGtJ9FXX?=
 =?us-ascii?Q?T89D8OW8cMeKejBVGbgeoxbS+oLdD+XacY06wxaBkFnbXN4F9F++1R14JARr?=
 =?us-ascii?Q?nYHrE5qltHEwnE+QRx6MvUufCYPMP9cD1dvjTHrwqCL4Eae5p6GCsw0pYgjh?=
 =?us-ascii?Q?diJ44J/7WiMeBvh6qUL9a9CKFtjKZfvqB2rX81RPihdFE+1ROer7WI2nriTV?=
 =?us-ascii?Q?56sDRoXFEEL69qrJt1Y5sqPTeqMGH4lCQJunLoIG0TuGYCwiqJWWZle7RyAK?=
 =?us-ascii?Q?2PoXeI5+wrtdD3assJbO/MfEAfJOUBmmI5Q8jo4rnc4Qt/+NetuSHSMC7rxs?=
 =?us-ascii?Q?axFVvy9+beLCHgjsohGSfkFyJMMTpIFCssucoHwy8M6Ou2uLmC2DVOIhJKcX?=
 =?us-ascii?Q?e53mMVOXUkZR72hzrjvNQPZuK4v8xzAPuZqegcVpKJeBWPPp/NDXAOmpLXoz?=
 =?us-ascii?Q?rPtvQYaaVAq53qlWK5jOhKkVBO4f4P+AzjqR3Bo8kzwf0En+oFePu9nH7Ys9?=
 =?us-ascii?Q?EAHU2mjGzN7XFGEnvgvpPFjHnckvxvmhWbWxOwxZfk2kyqiZiFhIZEWfiErI?=
 =?us-ascii?Q?JEtvvfZuPGnizkQtNxclhrtpDZh2eFKkHC2fe+JDOdNtx08i7ML3PlB2hwYm?=
 =?us-ascii?Q?g9ZBUYRVCbyGqWY0zRotbI/hZJ9klXOJZ+BQfvQK1v1Dbq0xTjDkdUVZ8/sY?=
 =?us-ascii?Q?HU8zjAAqPqO/zvEM1g1oXowJfHy0cJ4W9bIyUJK3to129DqvNO3021Ru3fGx?=
 =?us-ascii?Q?n2gSM7OHBllyCUuTP9kSKjZ6rEq3cIVyo2OiWpkhgBI22nclHrIrCgVdD8P+?=
 =?us-ascii?Q?JZL/8RMS4Q44PGrfNY3N9Y30N3aYHXDQ4qjwZglyZT54fPmKOgAPRD7t/qdl?=
 =?us-ascii?Q?9qxf43Xl+MVr6ShWMZCbLMs6xnJMohppHQ3PAJpTYh+mAxn21rC2VvfZIYPp?=
 =?us-ascii?Q?QuZvl+AwY8uixpJxI9n/5XRlqcdrIpzg84K4J8s/6aZ11jBXImheS1/OEcXm?=
 =?us-ascii?Q?WBxXbjVDYoUOI9mVozmuTPL1sZXLp+zjrjvH+Xh2/iy8LmmhRh+zofIi9keK?=
 =?us-ascii?Q?UlcnltcHhKPbs0lQMbfPymnaWZT7DiiyI+S5jW9ANw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pus3XKYzQ2fd6M/qavtWGjW8b/EMrVpKqQvSrn1cpytBa7ZVjZGLBtEAugXD?=
 =?us-ascii?Q?/J1Tx1RB8T+fWsh5cqesHFf2MdhXTBP8TVUbkCNFZzJDr+V+5j9xw5pf01JS?=
 =?us-ascii?Q?sDAYBB3WxpAT/Oa47ocSfQ4HOEwc7uhRtEoHb5wOGpnVbzZ3l4N40D9O2/R4?=
 =?us-ascii?Q?dtAdJexG0a85QRjbT6r38EciPos/9mmvpPdyNRqaqeQH3gqNE5cuWEl3IsIM?=
 =?us-ascii?Q?z6Ey34ozWbZ+CYrLuVPJ/MWBdhBWEj3fC03bqalxdO8SmoxmEvJIJnHqVrar?=
 =?us-ascii?Q?xr125R0WbWrjMztgPvw+X/6qdfcTRQqsIjRHshpvzfSRVxzarp15ipPlE/wK?=
 =?us-ascii?Q?MAmhjsRU0c6Janry1pj6xzNsX/Rf/L7aV2ATXuC4Kfv9honnvY7nd1LxgQin?=
 =?us-ascii?Q?5IuB0IHNV9Zgw7cmoMyBgM0NoEroEG5M44FzrsTvC14IG71kaOUxoJNJp58l?=
 =?us-ascii?Q?6o9JHW5oJGluF4CxwMdKURd16sb28xdSZ/m3zgqJxFT+svhjuoZYrYjr9hpW?=
 =?us-ascii?Q?rT6+InNyok6LlFEV5dzhId5O0aOmoh0iMx2kZRBOI1PtM+TSuhdPzoTThYpa?=
 =?us-ascii?Q?04PlWb5AC/c9gJTMalPyGcK8cgP0viqgxJKTmyetgAsiEn1S4C6s5baiqQuz?=
 =?us-ascii?Q?olIzw4F+D/PsOT9XQdf10ZY+0HuFXYOsNGXBtD0Mq/r5QTpL5cA9gOpPemSt?=
 =?us-ascii?Q?ls+uiw46qCZU+YeiiurkADGcLciCrexh7P5J0HYmfy7/kKtCLrKHiXW6pUW9?=
 =?us-ascii?Q?jTd70+yIVd42NQahrCz2Fck2ZL3hDHAswj0Rl70g3z63drQyll5mlnHcrJpb?=
 =?us-ascii?Q?da8GyppuOd+tDf5FpRa+w0dy0o7UTTH7nmZIZ4opq5MNLCt9SLzB/tXRNphD?=
 =?us-ascii?Q?+33dq4C3Ktx/IrGzUMCbzzKj2J6E2tFvlQY4LnfiPZquzoWATKqdgQ43d2vc?=
 =?us-ascii?Q?kyX2FZ43ORGKMQpqDQx0ygGuzhDNLQpfwqc0yYTxpOsPRBYhmaQ1bQMipjbc?=
 =?us-ascii?Q?bOJs5VquVe9k4WlhJlekarlpSBtv8JfC875t+ChbDbxXh5khTDYm/BGE1aGV?=
 =?us-ascii?Q?Shd6AXL958sMxj1bKefrS2Hct1rXz4qhw8sjr5AWTaqJRDZ7c56YTtG1kTg5?=
 =?us-ascii?Q?52Z0xDkfqv80YUz3IgKnSUHKjIOsHhY+vWshxDfxGdO0IXuo6aSFqeXihlJ7?=
 =?us-ascii?Q?W7xYeub/GT6f22hveK/YLZLpcGOgiTtIgF89FpKt/8SUQ+1rbstnWyHNtSp1?=
 =?us-ascii?Q?1xC1n/1C77YC47BUbGOyPxP9LpVTPSfCFtko35UM/0iXuWLkgFxef6FUM9Js?=
 =?us-ascii?Q?+3QHj6WPov7geNjldEL09ZlwFpdayhTiJHHFk9yjogwoXK0jn5qcpflSEBj8?=
 =?us-ascii?Q?XVb2usRfdJAR4kdY/PUNTcnUUvXbThrgT4NEi4nuv4Oy7SbwA8qA2xt4bO0U?=
 =?us-ascii?Q?rURvYHNvf7qbDPDBV+5/gN6LebTQJce3A3YIjKOOtxnNC4dllJihoeRWiSqR?=
 =?us-ascii?Q?pYGEbepYQQhQbITwCzL8uBbbDZb99/O6jd6ngqDctetVR8cRTuOOZ3foHan1?=
 =?us-ascii?Q?Yfhk5y8gTxwABU3RVx+kpdViQrV3jwG6jcFZUnaX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27e28f7-fce7-43cf-d675-08dc6b281fde
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:18:45.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58ZO1gXTW0N6JhIlAxqmn06DxpCuda/d4QalsLQKSYvPNqICjOsECxmRhoD4STWNL3vie9QlQ2AkUhyGcDJGbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

Hi,

Here's a few fixes that are part of my effort to get all selftests
building cleanly under clang. Plus one that I noticed by inspection.

Enjoy!

thanks,
John Hubbard

John Hubbard (3):
  selftests/futex: don't redefine .PHONY targets (all, clean)
  selftests/futex: don't pass a const char* to asprintf(3)
  selftests/futex: pass _GNU_SOURCE without a value to the compiler

 tools/testing/selftests/futex/Makefile                      | 2 --
 tools/testing/selftests/futex/functional/Makefile           | 2 +-
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)


base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


