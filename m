Return-Path: <linux-kselftest+bounces-11913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8699081A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 04:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EB6284461
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F318411C;
	Fri, 14 Jun 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VyH2OoCK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22801836E1;
	Fri, 14 Jun 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332227; cv=fail; b=HQFJCv91yVRavYYY5WitBpzSbnfyVQ1ST//75koFzxfAGDy3AvltSlN6sai7p1Qu8dn5MTMEs5qdAuNpKD3RzYPdFeRI2JcD8SMms3PfEyMf4vLql/IlB1E1wJ1mhrC84Z/tcbAkCeZ4ExryjYTLp9XQyqOwF9kN9nqDFkQn9RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332227; c=relaxed/simple;
	bh=nzg2s3rjz0B1UeiVMDdEWpPXwFGw/HMBxRd5c7n9sVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhcKiQbWlwtgpiHe9bFgTh/ljp/5K92hKYQEzw0Vs0esUBi8gV+37IqnF0d67xvl7mHovmF1XvTcUvZ4cEG+6bMUfxdu6ILlHnKoUNkiSO76cbU1/9HzZIkctu27FcqL0jTQZvS1llYlJO41CwOwOwc9XWEjtAnFOoBmonGLxAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VyH2OoCK; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia+KAlpr4KHyVH8Fz2DupwZ+3mO8imjxAcB4mqvD3O0+y13sBgaRYdABo2+qjUR+sgRCxLjJ2wGExeyIanUYuqeygAsxKkmJMqzZc3dy0Fxq1SfYkwB8nijQDM+OowwBuHrkE6BB4j4vWyayZ0UdRjMIU7iOOrvbesSiGXgD7tsVd0vbqBfbAjKaRw/FYh72KgsTf4c1x0zyMSX/IHZsmTBhT0UPQCHMGwFVQ3cVzsi74AtwCvu4cMpzP1mYtmz6E6K8a6ifkBmD9XMoMF28Ym3IknCwxppPe3EX+oEAVqnFHx7ugJgcK2HmTN8UIueOvjERn+duaZfU5Y+B3X5/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/zjSJMPwPRfSrnEgDC+WhbZiIld+wnTeetp4tazPdo=;
 b=RbshwjQTZmRxT2fCFu7kVFAiw5MdbKxaCPrH7LSj/K+0r+Y2fNqdarIqertxPEBgho+l8CFQy6GWfZfuKPiBbwAaAqbCI5ACoAZ2VKCUWpX0s7hxA+DS+j6oI/Y1tGcUcmhQpQCjOJwc51afKV8B866Rc+GEczs0LHGSq9jcp06n3JHS+pw0hNgWwc2cf8RkVw4zeUbQqQRQ8zdsu7TfF+hlIR4Z74+DGSEjoSfw7LdxGj/IJDAAg+kXWiGkPlgccVeawL3OFYH23wDT3KeDQUl+J3WkyxiXZKDz9p2sh4ZerU/wP2gOaZq+jDMhycGIM42FT/xC1tHEK4AM8sgHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/zjSJMPwPRfSrnEgDC+WhbZiIld+wnTeetp4tazPdo=;
 b=VyH2OoCK5aZvluJ+9MBcJ0CGBW+TnBGRfSnphNxY2xdmOMLv66ifwq+4u8O+ziKXilG8Qy6iEvkrxbHC6vVgIiJxKctpC3tdTyORFBLXxSRP2ANIHZsLYr6tI3Yk8XjxGENPRZX1Y2Pn/7JCxTK5O/G+lmR1TEBznlLIDFTrdZ5eZ5BpiBKjnk84G4tpOnHRNLBsdMaPo5CdCIrMEykvjnr+GPQ17bmEQGgGTt1On5nL4YhXTWUMUEsndWNVWv0xCGz2w9Fb25ksJn2Dw4Gc/i+y8GTmDPrUftZE505Bj1itD4GSpkEUIVmsh2+MNCc1dlmIR2pgJhYdaxrtKcaDMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 02:30:11 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:30:11 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>,
	Rich Felker <dalias@libc.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/6] selftests/mm: mseal, self_elf: fix missing __NR_mseal
Date: Thu, 13 Jun 2024 19:30:04 -0700
Message-ID: <20240614023009.221547-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614023009.221547-1-jhubbard@nvidia.com>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: a237918b-bd26-4e06-b461-08dc8c19eaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/CTa7JrUkn99wOGkNFNnCfRjV7+mPe0gxTesTtba2ZBywLV0DUpx8JHmuQZ?=
 =?us-ascii?Q?GSnDfwq6vPhLZ7bjpHGwbZ8gwmGCqXhil9YnuT+fbNioE8ju+FslikoBN6pL?=
 =?us-ascii?Q?FBMs8oqq/S4TAW5vallLR0U5YB2PR0a19qGPDU0vfUrTfuIbqlVU/Tzjt6nf?=
 =?us-ascii?Q?RHnSRPKzKCbzqh+XMHp3amJ9l/h6sFqZqfcm24G8R5lj7j2WHPS0PDleAt1l?=
 =?us-ascii?Q?N8nJenX5D2CbhilfqQskEwduRsR0wihiFEe3bca6aCo+bvG3Mac8iLJ6+yH6?=
 =?us-ascii?Q?ZEUBjI+/97YJk1Gkt//8nbRrlWw0kA0il8nkr06P7JEYFmyP0PHm41R42+or?=
 =?us-ascii?Q?HPiDBOlpZS7EJptcFum4B1LQtYnYk6whjMwJMAGVk/qjL44U6eFgDZLEwoVr?=
 =?us-ascii?Q?YrBKsMTUOiSrwpNKKJYE9V0Fna4aPy0/SlvgB1YHYf931o+AVsrE8N2wgKuF?=
 =?us-ascii?Q?L5C6I433y4xrVEFNMnwRCE8D3s9rbUFTEQJbBb5P9WcawJi0oDd1taAfjft0?=
 =?us-ascii?Q?Mvy2QllJj6ujU3MyBvVy4CFZHxEdzIfnNJYOjM/gH3UXKu3e/DQhPn4y8ynu?=
 =?us-ascii?Q?Es2B3sEJfcoYVBo8N5pWmTIAhVoBdVSlJPLYVqiwqR18ohW+LiPQKCEmwhuj?=
 =?us-ascii?Q?QYzIbZ1VkTmTzIeofl+/JEd6z+jxRzad+5C6phSxtt0I+hC5vHzvi1dzp3bt?=
 =?us-ascii?Q?unWpD8W7W6SbcMd1r/3XUkALamQAmXqL6LoRPR29ElbDvbEPuIBKVfL0kzw6?=
 =?us-ascii?Q?zZmqL4CaTP6lj5qnHEsYyFcM8l3AXqWgSBeKVsJtmvjeHhUbLUTwlQFBf4bC?=
 =?us-ascii?Q?WCRwpiZhkkaySdeh2SKYo+oiu/goTH/V9w//sJ3h4uwUOusBYh0AbJFa4NgW?=
 =?us-ascii?Q?m67NaoT08fH3LUxtdaPtfnMNF7GomfuqATZ9s4wJn428GiLJ1yXQMp0vZtw8?=
 =?us-ascii?Q?Wv4ZoLlthQOSYVUfrUgUhL1YySDeVL+cbheiHbGSk7RegrRorUyHdh4OeRAn?=
 =?us-ascii?Q?VpmrZ54T33/+cqEne2WqlwPG+QoTW9ceW0m1LTfQiLDFftwSVfX5KVyShSyW?=
 =?us-ascii?Q?/39hqP+9HkjW8R37mKVshRI3HbGl8sQ9QmHumPv4moHAaTSO1e1YSSorhB7r?=
 =?us-ascii?Q?LkIniMz6awNW+PlGmDVeJtVdy7Hkbid3beyAWCmVhAICQW3pfA+qTKM7K2BJ?=
 =?us-ascii?Q?zpFHj/K2HwkBiTCst6TDuMz4Sjmq9xQoo6m8WxEhiO99EHKuFfFyQ21V1D2f?=
 =?us-ascii?Q?RP4zwjWIww29h1ucLxxoZGEhK7/V5bLjr8jigTqTdZwqJcV6WdTXZgtTxtJ/?=
 =?us-ascii?Q?yijsNgxbbC/sLHIOn0UUm32f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5kLdwgIHgIfE78gVq3yvBfUiLdbhx/eyaz4SD0frYGtpMXvwgWpeVYAJOltN?=
 =?us-ascii?Q?Tj5wZEo0/y4wCix0ATbOOFigPd4hzs9RpYg7nMBryNhxpWzZug0/VlPtAhm7?=
 =?us-ascii?Q?XLbDKEGQZ7wL6Imnv2s4oumojbI3V2OkgkLGkSwkfmgsbnEZrDXQa1lJWeXD?=
 =?us-ascii?Q?5ABqsjNH+LLsYUCasdJ0FbQ2d3zaigteWQFxatMJnpSV20ckdP1oBJhn6RVA?=
 =?us-ascii?Q?pbS9McaggBhyVCwQ5fk1X+qHSogBXwQGuhDIVAz/IEyz51GSAt4kCE70EdH6?=
 =?us-ascii?Q?XpjGqZEM71YmZJfswk0xH9tQdrr8mhl/Q51N8hGVL7hI8bl6cJA+rXQQMlIJ?=
 =?us-ascii?Q?vMy8oL+KvDJGiqJT8TYF7uvWYn14DV6vt+2L+9r9xr6/5dmPsPJpZ31F+Yls?=
 =?us-ascii?Q?662H0kLlHVpuNSc7quovqncOKvZOxEvyb8BC+rY/yfnV+Kv6i9SdQqi5sy3R?=
 =?us-ascii?Q?+ji+Q0IVKCASqUkIYGEDCgSEegcCFoylwos6pctEoLAEUXaPfPdkvnJLXfgY?=
 =?us-ascii?Q?QRN6mHqoLe9iMSWzAX3GjcYtQ2JDq0FmEp6HBRBrTsqTOSZYmF5lGdrDMWo4?=
 =?us-ascii?Q?qi7wCpmrlMhYWhQWIj8ImyKftfxcsA+0ap36hlUnw2KoDO93g83J5SxNGy6t?=
 =?us-ascii?Q?NQHb385ZQfYCT1rF36ESoMl7BcXWsnlvsW1VTapP16bVT7aKcnLizRm/iw6x?=
 =?us-ascii?Q?vtZ5DQmI0FJFdq7Lh9XiRw0DAiCMGLS9/rkM4YeoT0EowXdio6+JGVremj0d?=
 =?us-ascii?Q?1ZgAhqvPj5yAmd8Y6u6DbP3ZKCUUrSHeduGREeSZ/9cmtJrBDa9lewAEtnSh?=
 =?us-ascii?Q?xf7umbylDFze33XJL67REV2MWl9D8zx3lk5M3SoS4HRW/wGmmFjGmW6mBgyI?=
 =?us-ascii?Q?qxn6LqnyH0RF0Prs4hjujyM4C7BG7sQBRqqThFhZnc6DggEMNYkkPNwDTN/U?=
 =?us-ascii?Q?PysWmFUtlImVfQOino5pKtf5D5SqOuoX0o+8wl6xCovVgI456usc+tH/hUvC?=
 =?us-ascii?Q?OfG7vBnnQpfc5AZcWoQPfC/FOW4gAiSrGIaKqPRQUOmrxdiyG8OoJZvBgOkk?=
 =?us-ascii?Q?lmavND71sGsOoR9Lnwh81eXHGS1EvioH0wAUhtkVueWInfYOdWICGnK7i/6U?=
 =?us-ascii?Q?QvDgCymCqFr58i4AcY57bLs2tHyY3/cMZEsrNy3wq/IFyl1bGfAAvZfSMgee?=
 =?us-ascii?Q?K1K/aGq5XFeTTfmufeYfUI7mliQcZHT9aqM7kEyO4/bl0TCqY49M2EUcE1Ic?=
 =?us-ascii?Q?laUww/dNqVXg9hj+muP6ujH5NckOj8JtJEbwwilMQwFoGW3AiIY3qryii6mF?=
 =?us-ascii?Q?BKD6/7A3BSHIpPgMojsP9htYruacyAcBoalGW6eUhwx6yxLb0ywIdrse8hC8?=
 =?us-ascii?Q?oE8yTjp9hm7J7bRoCud53i+VIBkKUSeAE/okGBP10AsQRtcT1O46tDxNWP/O?=
 =?us-ascii?Q?UmtvkmorxW9YpGU1t2KfebOH1ieFd0DPNjk2keCh+IVjqEwAtITDlrl+hP1o?=
 =?us-ascii?Q?R8p07+sTBiD6xPE7JRvaEIoiyaVN5ZX1BPi+/5EZEir7F3kWMNhTkacZ8q0e?=
 =?us-ascii?Q?6rlLxYXPtFG/4pahnnaJ4yVpmAfX1uEiF1cm/b0s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a237918b-bd26-4e06-b461-08dc8c19eaa0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:30:11.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJN/ZfadH90jB3QSFVAqRHBMqUDmL+Z9epyleXLw23GPzmMJ6f6ABHjh3GH2XtoiZacu4Tv8n3FVbeeMl1PjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

The selftests/mm build isn't exactly "broken", according to the current
documentation, which still claims that one must run "make headers",
before building the kselftests. However, according to the new plan to
get rid of that requirement [1], they are future-broken: attempting to
build selftests/mm *without* first running "make headers" will fail due
to not finding __NR_mseal.

Therefore,  add ./usr/include/asm/unistd_[32|x32|64].h (created via
"make headers") to tools/uapi/, and change the selftests/mm files that
require __NR_mseal to include from the correct location. The way to do
so is to include <linux/unistd.h> instead of just <unistd.h>.

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/include/uapi/asm/unistd_32.h      | 458 ++++++++++++++++++++++++
 tools/include/uapi/asm/unistd_64.h      | 380 ++++++++++++++++++++
 tools/include/uapi/asm/unistd_x32.h     | 369 +++++++++++++++++++
 tools/testing/selftests/mm/mseal_test.c |   2 +-
 tools/testing/selftests/mm/seal_elf.c   |   2 +-
 5 files changed, 1209 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/uapi/asm/unistd_32.h
 create mode 100644 tools/include/uapi/asm/unistd_64.h
 create mode 100644 tools/include/uapi/asm/unistd_x32.h

diff --git a/tools/include/uapi/asm/unistd_32.h b/tools/include/uapi/asm/unistd_32.h
new file mode 100644
index 000000000000..fb7b8b169bfa
--- /dev/null
+++ b/tools/include/uapi/asm/unistd_32.h
@@ -0,0 +1,458 @@
+#ifndef _ASM_UNISTD_32_H
+#define _ASM_UNISTD_32_H
+
+#define __NR_restart_syscall 0
+#define __NR_exit 1
+#define __NR_fork 2
+#define __NR_read 3
+#define __NR_write 4
+#define __NR_open 5
+#define __NR_close 6
+#define __NR_waitpid 7
+#define __NR_creat 8
+#define __NR_link 9
+#define __NR_unlink 10
+#define __NR_execve 11
+#define __NR_chdir 12
+#define __NR_time 13
+#define __NR_mknod 14
+#define __NR_chmod 15
+#define __NR_lchown 16
+#define __NR_break 17
+#define __NR_oldstat 18
+#define __NR_lseek 19
+#define __NR_getpid 20
+#define __NR_mount 21
+#define __NR_umount 22
+#define __NR_setuid 23
+#define __NR_getuid 24
+#define __NR_stime 25
+#define __NR_ptrace 26
+#define __NR_alarm 27
+#define __NR_oldfstat 28
+#define __NR_pause 29
+#define __NR_utime 30
+#define __NR_stty 31
+#define __NR_gtty 32
+#define __NR_access 33
+#define __NR_nice 34
+#define __NR_ftime 35
+#define __NR_sync 36
+#define __NR_kill 37
+#define __NR_rename 38
+#define __NR_mkdir 39
+#define __NR_rmdir 40
+#define __NR_dup 41
+#define __NR_pipe 42
+#define __NR_times 43
+#define __NR_prof 44
+#define __NR_brk 45
+#define __NR_setgid 46
+#define __NR_getgid 47
+#define __NR_signal 48
+#define __NR_geteuid 49
+#define __NR_getegid 50
+#define __NR_acct 51
+#define __NR_umount2 52
+#define __NR_lock 53
+#define __NR_ioctl 54
+#define __NR_fcntl 55
+#define __NR_mpx 56
+#define __NR_setpgid 57
+#define __NR_ulimit 58
+#define __NR_oldolduname 59
+#define __NR_umask 60
+#define __NR_chroot 61
+#define __NR_ustat 62
+#define __NR_dup2 63
+#define __NR_getppid 64
+#define __NR_getpgrp 65
+#define __NR_setsid 66
+#define __NR_sigaction 67
+#define __NR_sgetmask 68
+#define __NR_ssetmask 69
+#define __NR_setreuid 70
+#define __NR_setregid 71
+#define __NR_sigsuspend 72
+#define __NR_sigpending 73
+#define __NR_sethostname 74
+#define __NR_setrlimit 75
+#define __NR_getrlimit 76
+#define __NR_getrusage 77
+#define __NR_gettimeofday 78
+#define __NR_settimeofday 79
+#define __NR_getgroups 80
+#define __NR_setgroups 81
+#define __NR_select 82
+#define __NR_symlink 83
+#define __NR_oldlstat 84
+#define __NR_readlink 85
+#define __NR_uselib 86
+#define __NR_swapon 87
+#define __NR_reboot 88
+#define __NR_readdir 89
+#define __NR_mmap 90
+#define __NR_munmap 91
+#define __NR_truncate 92
+#define __NR_ftruncate 93
+#define __NR_fchmod 94
+#define __NR_fchown 95
+#define __NR_getpriority 96
+#define __NR_setpriority 97
+#define __NR_profil 98
+#define __NR_statfs 99
+#define __NR_fstatfs 100
+#define __NR_ioperm 101
+#define __NR_socketcall 102
+#define __NR_syslog 103
+#define __NR_setitimer 104
+#define __NR_getitimer 105
+#define __NR_stat 106
+#define __NR_lstat 107
+#define __NR_fstat 108
+#define __NR_olduname 109
+#define __NR_iopl 110
+#define __NR_vhangup 111
+#define __NR_idle 112
+#define __NR_vm86old 113
+#define __NR_wait4 114
+#define __NR_swapoff 115
+#define __NR_sysinfo 116
+#define __NR_ipc 117
+#define __NR_fsync 118
+#define __NR_sigreturn 119
+#define __NR_clone 120
+#define __NR_setdomainname 121
+#define __NR_uname 122
+#define __NR_modify_ldt 123
+#define __NR_adjtimex 124
+#define __NR_mprotect 125
+#define __NR_sigprocmask 126
+#define __NR_create_module 127
+#define __NR_init_module 128
+#define __NR_delete_module 129
+#define __NR_get_kernel_syms 130
+#define __NR_quotactl 131
+#define __NR_getpgid 132
+#define __NR_fchdir 133
+#define __NR_bdflush 134
+#define __NR_sysfs 135
+#define __NR_personality 136
+#define __NR_afs_syscall 137
+#define __NR_setfsuid 138
+#define __NR_setfsgid 139
+#define __NR__llseek 140
+#define __NR_getdents 141
+#define __NR__newselect 142
+#define __NR_flock 143
+#define __NR_msync 144
+#define __NR_readv 145
+#define __NR_writev 146
+#define __NR_getsid 147
+#define __NR_fdatasync 148
+#define __NR__sysctl 149
+#define __NR_mlock 150
+#define __NR_munlock 151
+#define __NR_mlockall 152
+#define __NR_munlockall 153
+#define __NR_sched_setparam 154
+#define __NR_sched_getparam 155
+#define __NR_sched_setscheduler 156
+#define __NR_sched_getscheduler 157
+#define __NR_sched_yield 158
+#define __NR_sched_get_priority_max 159
+#define __NR_sched_get_priority_min 160
+#define __NR_sched_rr_get_interval 161
+#define __NR_nanosleep 162
+#define __NR_mremap 163
+#define __NR_setresuid 164
+#define __NR_getresuid 165
+#define __NR_vm86 166
+#define __NR_query_module 167
+#define __NR_poll 168
+#define __NR_nfsservctl 169
+#define __NR_setresgid 170
+#define __NR_getresgid 171
+#define __NR_prctl 172
+#define __NR_rt_sigreturn 173
+#define __NR_rt_sigaction 174
+#define __NR_rt_sigprocmask 175
+#define __NR_rt_sigpending 176
+#define __NR_rt_sigtimedwait 177
+#define __NR_rt_sigqueueinfo 178
+#define __NR_rt_sigsuspend 179
+#define __NR_pread64 180
+#define __NR_pwrite64 181
+#define __NR_chown 182
+#define __NR_getcwd 183
+#define __NR_capget 184
+#define __NR_capset 185
+#define __NR_sigaltstack 186
+#define __NR_sendfile 187
+#define __NR_getpmsg 188
+#define __NR_putpmsg 189
+#define __NR_vfork 190
+#define __NR_ugetrlimit 191
+#define __NR_mmap2 192
+#define __NR_truncate64 193
+#define __NR_ftruncate64 194
+#define __NR_stat64 195
+#define __NR_lstat64 196
+#define __NR_fstat64 197
+#define __NR_lchown32 198
+#define __NR_getuid32 199
+#define __NR_getgid32 200
+#define __NR_geteuid32 201
+#define __NR_getegid32 202
+#define __NR_setreuid32 203
+#define __NR_setregid32 204
+#define __NR_getgroups32 205
+#define __NR_setgroups32 206
+#define __NR_fchown32 207
+#define __NR_setresuid32 208
+#define __NR_getresuid32 209
+#define __NR_setresgid32 210
+#define __NR_getresgid32 211
+#define __NR_chown32 212
+#define __NR_setuid32 213
+#define __NR_setgid32 214
+#define __NR_setfsuid32 215
+#define __NR_setfsgid32 216
+#define __NR_pivot_root 217
+#define __NR_mincore 218
+#define __NR_madvise 219
+#define __NR_getdents64 220
+#define __NR_fcntl64 221
+#define __NR_gettid 224
+#define __NR_readahead 225
+#define __NR_setxattr 226
+#define __NR_lsetxattr 227
+#define __NR_fsetxattr 228
+#define __NR_getxattr 229
+#define __NR_lgetxattr 230
+#define __NR_fgetxattr 231
+#define __NR_listxattr 232
+#define __NR_llistxattr 233
+#define __NR_flistxattr 234
+#define __NR_removexattr 235
+#define __NR_lremovexattr 236
+#define __NR_fremovexattr 237
+#define __NR_tkill 238
+#define __NR_sendfile64 239
+#define __NR_futex 240
+#define __NR_sched_setaffinity 241
+#define __NR_sched_getaffinity 242
+#define __NR_set_thread_area 243
+#define __NR_get_thread_area 244
+#define __NR_io_setup 245
+#define __NR_io_destroy 246
+#define __NR_io_getevents 247
+#define __NR_io_submit 248
+#define __NR_io_cancel 249
+#define __NR_fadvise64 250
+#define __NR_exit_group 252
+#define __NR_lookup_dcookie 253
+#define __NR_epoll_create 254
+#define __NR_epoll_ctl 255
+#define __NR_epoll_wait 256
+#define __NR_remap_file_pages 257
+#define __NR_set_tid_address 258
+#define __NR_timer_create 259
+#define __NR_timer_settime 260
+#define __NR_timer_gettime 261
+#define __NR_timer_getoverrun 262
+#define __NR_timer_delete 263
+#define __NR_clock_settime 264
+#define __NR_clock_gettime 265
+#define __NR_clock_getres 266
+#define __NR_clock_nanosleep 267
+#define __NR_statfs64 268
+#define __NR_fstatfs64 269
+#define __NR_tgkill 270
+#define __NR_utimes 271
+#define __NR_fadvise64_64 272
+#define __NR_vserver 273
+#define __NR_mbind 274
+#define __NR_get_mempolicy 275
+#define __NR_set_mempolicy 276
+#define __NR_mq_open 277
+#define __NR_mq_unlink 278
+#define __NR_mq_timedsend 279
+#define __NR_mq_timedreceive 280
+#define __NR_mq_notify 281
+#define __NR_mq_getsetattr 282
+#define __NR_kexec_load 283
+#define __NR_waitid 284
+#define __NR_add_key 286
+#define __NR_request_key 287
+#define __NR_keyctl 288
+#define __NR_ioprio_set 289
+#define __NR_ioprio_get 290
+#define __NR_inotify_init 291
+#define __NR_inotify_add_watch 292
+#define __NR_inotify_rm_watch 293
+#define __NR_migrate_pages 294
+#define __NR_openat 295
+#define __NR_mkdirat 296
+#define __NR_mknodat 297
+#define __NR_fchownat 298
+#define __NR_futimesat 299
+#define __NR_fstatat64 300
+#define __NR_unlinkat 301
+#define __NR_renameat 302
+#define __NR_linkat 303
+#define __NR_symlinkat 304
+#define __NR_readlinkat 305
+#define __NR_fchmodat 306
+#define __NR_faccessat 307
+#define __NR_pselect6 308
+#define __NR_ppoll 309
+#define __NR_unshare 310
+#define __NR_set_robust_list 311
+#define __NR_get_robust_list 312
+#define __NR_splice 313
+#define __NR_sync_file_range 314
+#define __NR_tee 315
+#define __NR_vmsplice 316
+#define __NR_move_pages 317
+#define __NR_getcpu 318
+#define __NR_epoll_pwait 319
+#define __NR_utimensat 320
+#define __NR_signalfd 321
+#define __NR_timerfd_create 322
+#define __NR_eventfd 323
+#define __NR_fallocate 324
+#define __NR_timerfd_settime 325
+#define __NR_timerfd_gettime 326
+#define __NR_signalfd4 327
+#define __NR_eventfd2 328
+#define __NR_epoll_create1 329
+#define __NR_dup3 330
+#define __NR_pipe2 331
+#define __NR_inotify_init1 332
+#define __NR_preadv 333
+#define __NR_pwritev 334
+#define __NR_rt_tgsigqueueinfo 335
+#define __NR_perf_event_open 336
+#define __NR_recvmmsg 337
+#define __NR_fanotify_init 338
+#define __NR_fanotify_mark 339
+#define __NR_prlimit64 340
+#define __NR_name_to_handle_at 341
+#define __NR_open_by_handle_at 342
+#define __NR_clock_adjtime 343
+#define __NR_syncfs 344
+#define __NR_sendmmsg 345
+#define __NR_setns 346
+#define __NR_process_vm_readv 347
+#define __NR_process_vm_writev 348
+#define __NR_kcmp 349
+#define __NR_finit_module 350
+#define __NR_sched_setattr 351
+#define __NR_sched_getattr 352
+#define __NR_renameat2 353
+#define __NR_seccomp 354
+#define __NR_getrandom 355
+#define __NR_memfd_create 356
+#define __NR_bpf 357
+#define __NR_execveat 358
+#define __NR_socket 359
+#define __NR_socketpair 360
+#define __NR_bind 361
+#define __NR_connect 362
+#define __NR_listen 363
+#define __NR_accept4 364
+#define __NR_getsockopt 365
+#define __NR_setsockopt 366
+#define __NR_getsockname 367
+#define __NR_getpeername 368
+#define __NR_sendto 369
+#define __NR_sendmsg 370
+#define __NR_recvfrom 371
+#define __NR_recvmsg 372
+#define __NR_shutdown 373
+#define __NR_userfaultfd 374
+#define __NR_membarrier 375
+#define __NR_mlock2 376
+#define __NR_copy_file_range 377
+#define __NR_preadv2 378
+#define __NR_pwritev2 379
+#define __NR_pkey_mprotect 380
+#define __NR_pkey_alloc 381
+#define __NR_pkey_free 382
+#define __NR_statx 383
+#define __NR_arch_prctl 384
+#define __NR_io_pgetevents 385
+#define __NR_rseq 386
+#define __NR_semget 393
+#define __NR_semctl 394
+#define __NR_shmget 395
+#define __NR_shmctl 396
+#define __NR_shmat 397
+#define __NR_shmdt 398
+#define __NR_msgget 399
+#define __NR_msgsnd 400
+#define __NR_msgrcv 401
+#define __NR_msgctl 402
+#define __NR_clock_gettime64 403
+#define __NR_clock_settime64 404
+#define __NR_clock_adjtime64 405
+#define __NR_clock_getres_time64 406
+#define __NR_clock_nanosleep_time64 407
+#define __NR_timer_gettime64 408
+#define __NR_timer_settime64 409
+#define __NR_timerfd_gettime64 410
+#define __NR_timerfd_settime64 411
+#define __NR_utimensat_time64 412
+#define __NR_pselect6_time64 413
+#define __NR_ppoll_time64 414
+#define __NR_io_pgetevents_time64 416
+#define __NR_recvmmsg_time64 417
+#define __NR_mq_timedsend_time64 418
+#define __NR_mq_timedreceive_time64 419
+#define __NR_semtimedop_time64 420
+#define __NR_rt_sigtimedwait_time64 421
+#define __NR_futex_time64 422
+#define __NR_sched_rr_get_interval_time64 423
+#define __NR_pidfd_send_signal 424
+#define __NR_io_uring_setup 425
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
+#define __NR_open_tree 428
+#define __NR_move_mount 429
+#define __NR_fsopen 430
+#define __NR_fsconfig 431
+#define __NR_fsmount 432
+#define __NR_fspick 433
+#define __NR_pidfd_open 434
+#define __NR_clone3 435
+#define __NR_close_range 436
+#define __NR_openat2 437
+#define __NR_pidfd_getfd 438
+#define __NR_faccessat2 439
+#define __NR_process_madvise 440
+#define __NR_epoll_pwait2 441
+#define __NR_mount_setattr 442
+#define __NR_quotactl_fd 443
+#define __NR_landlock_create_ruleset 444
+#define __NR_landlock_add_rule 445
+#define __NR_landlock_restrict_self 446
+#define __NR_memfd_secret 447
+#define __NR_process_mrelease 448
+#define __NR_futex_waitv 449
+#define __NR_set_mempolicy_home_node 450
+#define __NR_cachestat 451
+#define __NR_fchmodat2 452
+#define __NR_map_shadow_stack 453
+#define __NR_futex_wake 454
+#define __NR_futex_wait 455
+#define __NR_futex_requeue 456
+#define __NR_statmount 457
+#define __NR_listmount 458
+#define __NR_lsm_get_self_attr 459
+#define __NR_lsm_set_self_attr 460
+#define __NR_lsm_list_modules 461
+#define __NR_mseal 462
+
+
+#endif /* _ASM_UNISTD_32_H */
diff --git a/tools/include/uapi/asm/unistd_64.h b/tools/include/uapi/asm/unistd_64.h
new file mode 100644
index 000000000000..da439afee1cf
--- /dev/null
+++ b/tools/include/uapi/asm/unistd_64.h
@@ -0,0 +1,380 @@
+#ifndef _ASM_UNISTD_64_H
+#define _ASM_UNISTD_64_H
+
+#define __NR_read 0
+#define __NR_write 1
+#define __NR_open 2
+#define __NR_close 3
+#define __NR_stat 4
+#define __NR_fstat 5
+#define __NR_lstat 6
+#define __NR_poll 7
+#define __NR_lseek 8
+#define __NR_mmap 9
+#define __NR_mprotect 10
+#define __NR_munmap 11
+#define __NR_brk 12
+#define __NR_rt_sigaction 13
+#define __NR_rt_sigprocmask 14
+#define __NR_rt_sigreturn 15
+#define __NR_ioctl 16
+#define __NR_pread64 17
+#define __NR_pwrite64 18
+#define __NR_readv 19
+#define __NR_writev 20
+#define __NR_access 21
+#define __NR_pipe 22
+#define __NR_select 23
+#define __NR_sched_yield 24
+#define __NR_mremap 25
+#define __NR_msync 26
+#define __NR_mincore 27
+#define __NR_madvise 28
+#define __NR_shmget 29
+#define __NR_shmat 30
+#define __NR_shmctl 31
+#define __NR_dup 32
+#define __NR_dup2 33
+#define __NR_pause 34
+#define __NR_nanosleep 35
+#define __NR_getitimer 36
+#define __NR_alarm 37
+#define __NR_setitimer 38
+#define __NR_getpid 39
+#define __NR_sendfile 40
+#define __NR_socket 41
+#define __NR_connect 42
+#define __NR_accept 43
+#define __NR_sendto 44
+#define __NR_recvfrom 45
+#define __NR_sendmsg 46
+#define __NR_recvmsg 47
+#define __NR_shutdown 48
+#define __NR_bind 49
+#define __NR_listen 50
+#define __NR_getsockname 51
+#define __NR_getpeername 52
+#define __NR_socketpair 53
+#define __NR_setsockopt 54
+#define __NR_getsockopt 55
+#define __NR_clone 56
+#define __NR_fork 57
+#define __NR_vfork 58
+#define __NR_execve 59
+#define __NR_exit 60
+#define __NR_wait4 61
+#define __NR_kill 62
+#define __NR_uname 63
+#define __NR_semget 64
+#define __NR_semop 65
+#define __NR_semctl 66
+#define __NR_shmdt 67
+#define __NR_msgget 68
+#define __NR_msgsnd 69
+#define __NR_msgrcv 70
+#define __NR_msgctl 71
+#define __NR_fcntl 72
+#define __NR_flock 73
+#define __NR_fsync 74
+#define __NR_fdatasync 75
+#define __NR_truncate 76
+#define __NR_ftruncate 77
+#define __NR_getdents 78
+#define __NR_getcwd 79
+#define __NR_chdir 80
+#define __NR_fchdir 81
+#define __NR_rename 82
+#define __NR_mkdir 83
+#define __NR_rmdir 84
+#define __NR_creat 85
+#define __NR_link 86
+#define __NR_unlink 87
+#define __NR_symlink 88
+#define __NR_readlink 89
+#define __NR_chmod 90
+#define __NR_fchmod 91
+#define __NR_chown 92
+#define __NR_fchown 93
+#define __NR_lchown 94
+#define __NR_umask 95
+#define __NR_gettimeofday 96
+#define __NR_getrlimit 97
+#define __NR_getrusage 98
+#define __NR_sysinfo 99
+#define __NR_times 100
+#define __NR_ptrace 101
+#define __NR_getuid 102
+#define __NR_syslog 103
+#define __NR_getgid 104
+#define __NR_setuid 105
+#define __NR_setgid 106
+#define __NR_geteuid 107
+#define __NR_getegid 108
+#define __NR_setpgid 109
+#define __NR_getppid 110
+#define __NR_getpgrp 111
+#define __NR_setsid 112
+#define __NR_setreuid 113
+#define __NR_setregid 114
+#define __NR_getgroups 115
+#define __NR_setgroups 116
+#define __NR_setresuid 117
+#define __NR_getresuid 118
+#define __NR_setresgid 119
+#define __NR_getresgid 120
+#define __NR_getpgid 121
+#define __NR_setfsuid 122
+#define __NR_setfsgid 123
+#define __NR_getsid 124
+#define __NR_capget 125
+#define __NR_capset 126
+#define __NR_rt_sigpending 127
+#define __NR_rt_sigtimedwait 128
+#define __NR_rt_sigqueueinfo 129
+#define __NR_rt_sigsuspend 130
+#define __NR_sigaltstack 131
+#define __NR_utime 132
+#define __NR_mknod 133
+#define __NR_uselib 134
+#define __NR_personality 135
+#define __NR_ustat 136
+#define __NR_statfs 137
+#define __NR_fstatfs 138
+#define __NR_sysfs 139
+#define __NR_getpriority 140
+#define __NR_setpriority 141
+#define __NR_sched_setparam 142
+#define __NR_sched_getparam 143
+#define __NR_sched_setscheduler 144
+#define __NR_sched_getscheduler 145
+#define __NR_sched_get_priority_max 146
+#define __NR_sched_get_priority_min 147
+#define __NR_sched_rr_get_interval 148
+#define __NR_mlock 149
+#define __NR_munlock 150
+#define __NR_mlockall 151
+#define __NR_munlockall 152
+#define __NR_vhangup 153
+#define __NR_modify_ldt 154
+#define __NR_pivot_root 155
+#define __NR__sysctl 156
+#define __NR_prctl 157
+#define __NR_arch_prctl 158
+#define __NR_adjtimex 159
+#define __NR_setrlimit 160
+#define __NR_chroot 161
+#define __NR_sync 162
+#define __NR_acct 163
+#define __NR_settimeofday 164
+#define __NR_mount 165
+#define __NR_umount2 166
+#define __NR_swapon 167
+#define __NR_swapoff 168
+#define __NR_reboot 169
+#define __NR_sethostname 170
+#define __NR_setdomainname 171
+#define __NR_iopl 172
+#define __NR_ioperm 173
+#define __NR_create_module 174
+#define __NR_init_module 175
+#define __NR_delete_module 176
+#define __NR_get_kernel_syms 177
+#define __NR_query_module 178
+#define __NR_quotactl 179
+#define __NR_nfsservctl 180
+#define __NR_getpmsg 181
+#define __NR_putpmsg 182
+#define __NR_afs_syscall 183
+#define __NR_tuxcall 184
+#define __NR_security 185
+#define __NR_gettid 186
+#define __NR_readahead 187
+#define __NR_setxattr 188
+#define __NR_lsetxattr 189
+#define __NR_fsetxattr 190
+#define __NR_getxattr 191
+#define __NR_lgetxattr 192
+#define __NR_fgetxattr 193
+#define __NR_listxattr 194
+#define __NR_llistxattr 195
+#define __NR_flistxattr 196
+#define __NR_removexattr 197
+#define __NR_lremovexattr 198
+#define __NR_fremovexattr 199
+#define __NR_tkill 200
+#define __NR_time 201
+#define __NR_futex 202
+#define __NR_sched_setaffinity 203
+#define __NR_sched_getaffinity 204
+#define __NR_set_thread_area 205
+#define __NR_io_setup 206
+#define __NR_io_destroy 207
+#define __NR_io_getevents 208
+#define __NR_io_submit 209
+#define __NR_io_cancel 210
+#define __NR_get_thread_area 211
+#define __NR_lookup_dcookie 212
+#define __NR_epoll_create 213
+#define __NR_epoll_ctl_old 214
+#define __NR_epoll_wait_old 215
+#define __NR_remap_file_pages 216
+#define __NR_getdents64 217
+#define __NR_set_tid_address 218
+#define __NR_restart_syscall 219
+#define __NR_semtimedop 220
+#define __NR_fadvise64 221
+#define __NR_timer_create 222
+#define __NR_timer_settime 223
+#define __NR_timer_gettime 224
+#define __NR_timer_getoverrun 225
+#define __NR_timer_delete 226
+#define __NR_clock_settime 227
+#define __NR_clock_gettime 228
+#define __NR_clock_getres 229
+#define __NR_clock_nanosleep 230
+#define __NR_exit_group 231
+#define __NR_epoll_wait 232
+#define __NR_epoll_ctl 233
+#define __NR_tgkill 234
+#define __NR_utimes 235
+#define __NR_vserver 236
+#define __NR_mbind 237
+#define __NR_set_mempolicy 238
+#define __NR_get_mempolicy 239
+#define __NR_mq_open 240
+#define __NR_mq_unlink 241
+#define __NR_mq_timedsend 242
+#define __NR_mq_timedreceive 243
+#define __NR_mq_notify 244
+#define __NR_mq_getsetattr 245
+#define __NR_kexec_load 246
+#define __NR_waitid 247
+#define __NR_add_key 248
+#define __NR_request_key 249
+#define __NR_keyctl 250
+#define __NR_ioprio_set 251
+#define __NR_ioprio_get 252
+#define __NR_inotify_init 253
+#define __NR_inotify_add_watch 254
+#define __NR_inotify_rm_watch 255
+#define __NR_migrate_pages 256
+#define __NR_openat 257
+#define __NR_mkdirat 258
+#define __NR_mknodat 259
+#define __NR_fchownat 260
+#define __NR_futimesat 261
+#define __NR_newfstatat 262
+#define __NR_unlinkat 263
+#define __NR_renameat 264
+#define __NR_linkat 265
+#define __NR_symlinkat 266
+#define __NR_readlinkat 267
+#define __NR_fchmodat 268
+#define __NR_faccessat 269
+#define __NR_pselect6 270
+#define __NR_ppoll 271
+#define __NR_unshare 272
+#define __NR_set_robust_list 273
+#define __NR_get_robust_list 274
+#define __NR_splice 275
+#define __NR_tee 276
+#define __NR_sync_file_range 277
+#define __NR_vmsplice 278
+#define __NR_move_pages 279
+#define __NR_utimensat 280
+#define __NR_epoll_pwait 281
+#define __NR_signalfd 282
+#define __NR_timerfd_create 283
+#define __NR_eventfd 284
+#define __NR_fallocate 285
+#define __NR_timerfd_settime 286
+#define __NR_timerfd_gettime 287
+#define __NR_accept4 288
+#define __NR_signalfd4 289
+#define __NR_eventfd2 290
+#define __NR_epoll_create1 291
+#define __NR_dup3 292
+#define __NR_pipe2 293
+#define __NR_inotify_init1 294
+#define __NR_preadv 295
+#define __NR_pwritev 296
+#define __NR_rt_tgsigqueueinfo 297
+#define __NR_perf_event_open 298
+#define __NR_recvmmsg 299
+#define __NR_fanotify_init 300
+#define __NR_fanotify_mark 301
+#define __NR_prlimit64 302
+#define __NR_name_to_handle_at 303
+#define __NR_open_by_handle_at 304
+#define __NR_clock_adjtime 305
+#define __NR_syncfs 306
+#define __NR_sendmmsg 307
+#define __NR_setns 308
+#define __NR_getcpu 309
+#define __NR_process_vm_readv 310
+#define __NR_process_vm_writev 311
+#define __NR_kcmp 312
+#define __NR_finit_module 313
+#define __NR_sched_setattr 314
+#define __NR_sched_getattr 315
+#define __NR_renameat2 316
+#define __NR_seccomp 317
+#define __NR_getrandom 318
+#define __NR_memfd_create 319
+#define __NR_kexec_file_load 320
+#define __NR_bpf 321
+#define __NR_execveat 322
+#define __NR_userfaultfd 323
+#define __NR_membarrier 324
+#define __NR_mlock2 325
+#define __NR_copy_file_range 326
+#define __NR_preadv2 327
+#define __NR_pwritev2 328
+#define __NR_pkey_mprotect 329
+#define __NR_pkey_alloc 330
+#define __NR_pkey_free 331
+#define __NR_statx 332
+#define __NR_io_pgetevents 333
+#define __NR_rseq 334
+#define __NR_pidfd_send_signal 424
+#define __NR_io_uring_setup 425
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
+#define __NR_open_tree 428
+#define __NR_move_mount 429
+#define __NR_fsopen 430
+#define __NR_fsconfig 431
+#define __NR_fsmount 432
+#define __NR_fspick 433
+#define __NR_pidfd_open 434
+#define __NR_clone3 435
+#define __NR_close_range 436
+#define __NR_openat2 437
+#define __NR_pidfd_getfd 438
+#define __NR_faccessat2 439
+#define __NR_process_madvise 440
+#define __NR_epoll_pwait2 441
+#define __NR_mount_setattr 442
+#define __NR_quotactl_fd 443
+#define __NR_landlock_create_ruleset 444
+#define __NR_landlock_add_rule 445
+#define __NR_landlock_restrict_self 446
+#define __NR_memfd_secret 447
+#define __NR_process_mrelease 448
+#define __NR_futex_waitv 449
+#define __NR_set_mempolicy_home_node 450
+#define __NR_cachestat 451
+#define __NR_fchmodat2 452
+#define __NR_map_shadow_stack 453
+#define __NR_futex_wake 454
+#define __NR_futex_wait 455
+#define __NR_futex_requeue 456
+#define __NR_statmount 457
+#define __NR_listmount 458
+#define __NR_lsm_get_self_attr 459
+#define __NR_lsm_set_self_attr 460
+#define __NR_lsm_list_modules 461
+#define __NR_mseal 462
+
+
+#endif /* _ASM_UNISTD_64_H */
diff --git a/tools/include/uapi/asm/unistd_x32.h b/tools/include/uapi/asm/unistd_x32.h
new file mode 100644
index 000000000000..4fcb607c724b
--- /dev/null
+++ b/tools/include/uapi/asm/unistd_x32.h
@@ -0,0 +1,369 @@
+#ifndef _ASM_UNISTD_X32_H
+#define _ASM_UNISTD_X32_H
+
+#define __NR_read (__X32_SYSCALL_BIT + 0)
+#define __NR_write (__X32_SYSCALL_BIT + 1)
+#define __NR_open (__X32_SYSCALL_BIT + 2)
+#define __NR_close (__X32_SYSCALL_BIT + 3)
+#define __NR_stat (__X32_SYSCALL_BIT + 4)
+#define __NR_fstat (__X32_SYSCALL_BIT + 5)
+#define __NR_lstat (__X32_SYSCALL_BIT + 6)
+#define __NR_poll (__X32_SYSCALL_BIT + 7)
+#define __NR_lseek (__X32_SYSCALL_BIT + 8)
+#define __NR_mmap (__X32_SYSCALL_BIT + 9)
+#define __NR_mprotect (__X32_SYSCALL_BIT + 10)
+#define __NR_munmap (__X32_SYSCALL_BIT + 11)
+#define __NR_brk (__X32_SYSCALL_BIT + 12)
+#define __NR_rt_sigprocmask (__X32_SYSCALL_BIT + 14)
+#define __NR_pread64 (__X32_SYSCALL_BIT + 17)
+#define __NR_pwrite64 (__X32_SYSCALL_BIT + 18)
+#define __NR_access (__X32_SYSCALL_BIT + 21)
+#define __NR_pipe (__X32_SYSCALL_BIT + 22)
+#define __NR_select (__X32_SYSCALL_BIT + 23)
+#define __NR_sched_yield (__X32_SYSCALL_BIT + 24)
+#define __NR_mremap (__X32_SYSCALL_BIT + 25)
+#define __NR_msync (__X32_SYSCALL_BIT + 26)
+#define __NR_mincore (__X32_SYSCALL_BIT + 27)
+#define __NR_madvise (__X32_SYSCALL_BIT + 28)
+#define __NR_shmget (__X32_SYSCALL_BIT + 29)
+#define __NR_shmat (__X32_SYSCALL_BIT + 30)
+#define __NR_shmctl (__X32_SYSCALL_BIT + 31)
+#define __NR_dup (__X32_SYSCALL_BIT + 32)
+#define __NR_dup2 (__X32_SYSCALL_BIT + 33)
+#define __NR_pause (__X32_SYSCALL_BIT + 34)
+#define __NR_nanosleep (__X32_SYSCALL_BIT + 35)
+#define __NR_getitimer (__X32_SYSCALL_BIT + 36)
+#define __NR_alarm (__X32_SYSCALL_BIT + 37)
+#define __NR_setitimer (__X32_SYSCALL_BIT + 38)
+#define __NR_getpid (__X32_SYSCALL_BIT + 39)
+#define __NR_sendfile (__X32_SYSCALL_BIT + 40)
+#define __NR_socket (__X32_SYSCALL_BIT + 41)
+#define __NR_connect (__X32_SYSCALL_BIT + 42)
+#define __NR_accept (__X32_SYSCALL_BIT + 43)
+#define __NR_sendto (__X32_SYSCALL_BIT + 44)
+#define __NR_shutdown (__X32_SYSCALL_BIT + 48)
+#define __NR_bind (__X32_SYSCALL_BIT + 49)
+#define __NR_listen (__X32_SYSCALL_BIT + 50)
+#define __NR_getsockname (__X32_SYSCALL_BIT + 51)
+#define __NR_getpeername (__X32_SYSCALL_BIT + 52)
+#define __NR_socketpair (__X32_SYSCALL_BIT + 53)
+#define __NR_clone (__X32_SYSCALL_BIT + 56)
+#define __NR_fork (__X32_SYSCALL_BIT + 57)
+#define __NR_vfork (__X32_SYSCALL_BIT + 58)
+#define __NR_exit (__X32_SYSCALL_BIT + 60)
+#define __NR_wait4 (__X32_SYSCALL_BIT + 61)
+#define __NR_kill (__X32_SYSCALL_BIT + 62)
+#define __NR_uname (__X32_SYSCALL_BIT + 63)
+#define __NR_semget (__X32_SYSCALL_BIT + 64)
+#define __NR_semop (__X32_SYSCALL_BIT + 65)
+#define __NR_semctl (__X32_SYSCALL_BIT + 66)
+#define __NR_shmdt (__X32_SYSCALL_BIT + 67)
+#define __NR_msgget (__X32_SYSCALL_BIT + 68)
+#define __NR_msgsnd (__X32_SYSCALL_BIT + 69)
+#define __NR_msgrcv (__X32_SYSCALL_BIT + 70)
+#define __NR_msgctl (__X32_SYSCALL_BIT + 71)
+#define __NR_fcntl (__X32_SYSCALL_BIT + 72)
+#define __NR_flock (__X32_SYSCALL_BIT + 73)
+#define __NR_fsync (__X32_SYSCALL_BIT + 74)
+#define __NR_fdatasync (__X32_SYSCALL_BIT + 75)
+#define __NR_truncate (__X32_SYSCALL_BIT + 76)
+#define __NR_ftruncate (__X32_SYSCALL_BIT + 77)
+#define __NR_getdents (__X32_SYSCALL_BIT + 78)
+#define __NR_getcwd (__X32_SYSCALL_BIT + 79)
+#define __NR_chdir (__X32_SYSCALL_BIT + 80)
+#define __NR_fchdir (__X32_SYSCALL_BIT + 81)
+#define __NR_rename (__X32_SYSCALL_BIT + 82)
+#define __NR_mkdir (__X32_SYSCALL_BIT + 83)
+#define __NR_rmdir (__X32_SYSCALL_BIT + 84)
+#define __NR_creat (__X32_SYSCALL_BIT + 85)
+#define __NR_link (__X32_SYSCALL_BIT + 86)
+#define __NR_unlink (__X32_SYSCALL_BIT + 87)
+#define __NR_symlink (__X32_SYSCALL_BIT + 88)
+#define __NR_readlink (__X32_SYSCALL_BIT + 89)
+#define __NR_chmod (__X32_SYSCALL_BIT + 90)
+#define __NR_fchmod (__X32_SYSCALL_BIT + 91)
+#define __NR_chown (__X32_SYSCALL_BIT + 92)
+#define __NR_fchown (__X32_SYSCALL_BIT + 93)
+#define __NR_lchown (__X32_SYSCALL_BIT + 94)
+#define __NR_umask (__X32_SYSCALL_BIT + 95)
+#define __NR_gettimeofday (__X32_SYSCALL_BIT + 96)
+#define __NR_getrlimit (__X32_SYSCALL_BIT + 97)
+#define __NR_getrusage (__X32_SYSCALL_BIT + 98)
+#define __NR_sysinfo (__X32_SYSCALL_BIT + 99)
+#define __NR_times (__X32_SYSCALL_BIT + 100)
+#define __NR_getuid (__X32_SYSCALL_BIT + 102)
+#define __NR_syslog (__X32_SYSCALL_BIT + 103)
+#define __NR_getgid (__X32_SYSCALL_BIT + 104)
+#define __NR_setuid (__X32_SYSCALL_BIT + 105)
+#define __NR_setgid (__X32_SYSCALL_BIT + 106)
+#define __NR_geteuid (__X32_SYSCALL_BIT + 107)
+#define __NR_getegid (__X32_SYSCALL_BIT + 108)
+#define __NR_setpgid (__X32_SYSCALL_BIT + 109)
+#define __NR_getppid (__X32_SYSCALL_BIT + 110)
+#define __NR_getpgrp (__X32_SYSCALL_BIT + 111)
+#define __NR_setsid (__X32_SYSCALL_BIT + 112)
+#define __NR_setreuid (__X32_SYSCALL_BIT + 113)
+#define __NR_setregid (__X32_SYSCALL_BIT + 114)
+#define __NR_getgroups (__X32_SYSCALL_BIT + 115)
+#define __NR_setgroups (__X32_SYSCALL_BIT + 116)
+#define __NR_setresuid (__X32_SYSCALL_BIT + 117)
+#define __NR_getresuid (__X32_SYSCALL_BIT + 118)
+#define __NR_setresgid (__X32_SYSCALL_BIT + 119)
+#define __NR_getresgid (__X32_SYSCALL_BIT + 120)
+#define __NR_getpgid (__X32_SYSCALL_BIT + 121)
+#define __NR_setfsuid (__X32_SYSCALL_BIT + 122)
+#define __NR_setfsgid (__X32_SYSCALL_BIT + 123)
+#define __NR_getsid (__X32_SYSCALL_BIT + 124)
+#define __NR_capget (__X32_SYSCALL_BIT + 125)
+#define __NR_capset (__X32_SYSCALL_BIT + 126)
+#define __NR_rt_sigsuspend (__X32_SYSCALL_BIT + 130)
+#define __NR_utime (__X32_SYSCALL_BIT + 132)
+#define __NR_mknod (__X32_SYSCALL_BIT + 133)
+#define __NR_personality (__X32_SYSCALL_BIT + 135)
+#define __NR_ustat (__X32_SYSCALL_BIT + 136)
+#define __NR_statfs (__X32_SYSCALL_BIT + 137)
+#define __NR_fstatfs (__X32_SYSCALL_BIT + 138)
+#define __NR_sysfs (__X32_SYSCALL_BIT + 139)
+#define __NR_getpriority (__X32_SYSCALL_BIT + 140)
+#define __NR_setpriority (__X32_SYSCALL_BIT + 141)
+#define __NR_sched_setparam (__X32_SYSCALL_BIT + 142)
+#define __NR_sched_getparam (__X32_SYSCALL_BIT + 143)
+#define __NR_sched_setscheduler (__X32_SYSCALL_BIT + 144)
+#define __NR_sched_getscheduler (__X32_SYSCALL_BIT + 145)
+#define __NR_sched_get_priority_max (__X32_SYSCALL_BIT + 146)
+#define __NR_sched_get_priority_min (__X32_SYSCALL_BIT + 147)
+#define __NR_sched_rr_get_interval (__X32_SYSCALL_BIT + 148)
+#define __NR_mlock (__X32_SYSCALL_BIT + 149)
+#define __NR_munlock (__X32_SYSCALL_BIT + 150)
+#define __NR_mlockall (__X32_SYSCALL_BIT + 151)
+#define __NR_munlockall (__X32_SYSCALL_BIT + 152)
+#define __NR_vhangup (__X32_SYSCALL_BIT + 153)
+#define __NR_modify_ldt (__X32_SYSCALL_BIT + 154)
+#define __NR_pivot_root (__X32_SYSCALL_BIT + 155)
+#define __NR_prctl (__X32_SYSCALL_BIT + 157)
+#define __NR_arch_prctl (__X32_SYSCALL_BIT + 158)
+#define __NR_adjtimex (__X32_SYSCALL_BIT + 159)
+#define __NR_setrlimit (__X32_SYSCALL_BIT + 160)
+#define __NR_chroot (__X32_SYSCALL_BIT + 161)
+#define __NR_sync (__X32_SYSCALL_BIT + 162)
+#define __NR_acct (__X32_SYSCALL_BIT + 163)
+#define __NR_settimeofday (__X32_SYSCALL_BIT + 164)
+#define __NR_mount (__X32_SYSCALL_BIT + 165)
+#define __NR_umount2 (__X32_SYSCALL_BIT + 166)
+#define __NR_swapon (__X32_SYSCALL_BIT + 167)
+#define __NR_swapoff (__X32_SYSCALL_BIT + 168)
+#define __NR_reboot (__X32_SYSCALL_BIT + 169)
+#define __NR_sethostname (__X32_SYSCALL_BIT + 170)
+#define __NR_setdomainname (__X32_SYSCALL_BIT + 171)
+#define __NR_iopl (__X32_SYSCALL_BIT + 172)
+#define __NR_ioperm (__X32_SYSCALL_BIT + 173)
+#define __NR_init_module (__X32_SYSCALL_BIT + 175)
+#define __NR_delete_module (__X32_SYSCALL_BIT + 176)
+#define __NR_quotactl (__X32_SYSCALL_BIT + 179)
+#define __NR_getpmsg (__X32_SYSCALL_BIT + 181)
+#define __NR_putpmsg (__X32_SYSCALL_BIT + 182)
+#define __NR_afs_syscall (__X32_SYSCALL_BIT + 183)
+#define __NR_tuxcall (__X32_SYSCALL_BIT + 184)
+#define __NR_security (__X32_SYSCALL_BIT + 185)
+#define __NR_gettid (__X32_SYSCALL_BIT + 186)
+#define __NR_readahead (__X32_SYSCALL_BIT + 187)
+#define __NR_setxattr (__X32_SYSCALL_BIT + 188)
+#define __NR_lsetxattr (__X32_SYSCALL_BIT + 189)
+#define __NR_fsetxattr (__X32_SYSCALL_BIT + 190)
+#define __NR_getxattr (__X32_SYSCALL_BIT + 191)
+#define __NR_lgetxattr (__X32_SYSCALL_BIT + 192)
+#define __NR_fgetxattr (__X32_SYSCALL_BIT + 193)
+#define __NR_listxattr (__X32_SYSCALL_BIT + 194)
+#define __NR_llistxattr (__X32_SYSCALL_BIT + 195)
+#define __NR_flistxattr (__X32_SYSCALL_BIT + 196)
+#define __NR_removexattr (__X32_SYSCALL_BIT + 197)
+#define __NR_lremovexattr (__X32_SYSCALL_BIT + 198)
+#define __NR_fremovexattr (__X32_SYSCALL_BIT + 199)
+#define __NR_tkill (__X32_SYSCALL_BIT + 200)
+#define __NR_time (__X32_SYSCALL_BIT + 201)
+#define __NR_futex (__X32_SYSCALL_BIT + 202)
+#define __NR_sched_setaffinity (__X32_SYSCALL_BIT + 203)
+#define __NR_sched_getaffinity (__X32_SYSCALL_BIT + 204)
+#define __NR_io_destroy (__X32_SYSCALL_BIT + 207)
+#define __NR_io_getevents (__X32_SYSCALL_BIT + 208)
+#define __NR_io_cancel (__X32_SYSCALL_BIT + 210)
+#define __NR_lookup_dcookie (__X32_SYSCALL_BIT + 212)
+#define __NR_epoll_create (__X32_SYSCALL_BIT + 213)
+#define __NR_remap_file_pages (__X32_SYSCALL_BIT + 216)
+#define __NR_getdents64 (__X32_SYSCALL_BIT + 217)
+#define __NR_set_tid_address (__X32_SYSCALL_BIT + 218)
+#define __NR_restart_syscall (__X32_SYSCALL_BIT + 219)
+#define __NR_semtimedop (__X32_SYSCALL_BIT + 220)
+#define __NR_fadvise64 (__X32_SYSCALL_BIT + 221)
+#define __NR_timer_settime (__X32_SYSCALL_BIT + 223)
+#define __NR_timer_gettime (__X32_SYSCALL_BIT + 224)
+#define __NR_timer_getoverrun (__X32_SYSCALL_BIT + 225)
+#define __NR_timer_delete (__X32_SYSCALL_BIT + 226)
+#define __NR_clock_settime (__X32_SYSCALL_BIT + 227)
+#define __NR_clock_gettime (__X32_SYSCALL_BIT + 228)
+#define __NR_clock_getres (__X32_SYSCALL_BIT + 229)
+#define __NR_clock_nanosleep (__X32_SYSCALL_BIT + 230)
+#define __NR_exit_group (__X32_SYSCALL_BIT + 231)
+#define __NR_epoll_wait (__X32_SYSCALL_BIT + 232)
+#define __NR_epoll_ctl (__X32_SYSCALL_BIT + 233)
+#define __NR_tgkill (__X32_SYSCALL_BIT + 234)
+#define __NR_utimes (__X32_SYSCALL_BIT + 235)
+#define __NR_mbind (__X32_SYSCALL_BIT + 237)
+#define __NR_set_mempolicy (__X32_SYSCALL_BIT + 238)
+#define __NR_get_mempolicy (__X32_SYSCALL_BIT + 239)
+#define __NR_mq_open (__X32_SYSCALL_BIT + 240)
+#define __NR_mq_unlink (__X32_SYSCALL_BIT + 241)
+#define __NR_mq_timedsend (__X32_SYSCALL_BIT + 242)
+#define __NR_mq_timedreceive (__X32_SYSCALL_BIT + 243)
+#define __NR_mq_getsetattr (__X32_SYSCALL_BIT + 245)
+#define __NR_add_key (__X32_SYSCALL_BIT + 248)
+#define __NR_request_key (__X32_SYSCALL_BIT + 249)
+#define __NR_keyctl (__X32_SYSCALL_BIT + 250)
+#define __NR_ioprio_set (__X32_SYSCALL_BIT + 251)
+#define __NR_ioprio_get (__X32_SYSCALL_BIT + 252)
+#define __NR_inotify_init (__X32_SYSCALL_BIT + 253)
+#define __NR_inotify_add_watch (__X32_SYSCALL_BIT + 254)
+#define __NR_inotify_rm_watch (__X32_SYSCALL_BIT + 255)
+#define __NR_migrate_pages (__X32_SYSCALL_BIT + 256)
+#define __NR_openat (__X32_SYSCALL_BIT + 257)
+#define __NR_mkdirat (__X32_SYSCALL_BIT + 258)
+#define __NR_mknodat (__X32_SYSCALL_BIT + 259)
+#define __NR_fchownat (__X32_SYSCALL_BIT + 260)
+#define __NR_futimesat (__X32_SYSCALL_BIT + 261)
+#define __NR_newfstatat (__X32_SYSCALL_BIT + 262)
+#define __NR_unlinkat (__X32_SYSCALL_BIT + 263)
+#define __NR_renameat (__X32_SYSCALL_BIT + 264)
+#define __NR_linkat (__X32_SYSCALL_BIT + 265)
+#define __NR_symlinkat (__X32_SYSCALL_BIT + 266)
+#define __NR_readlinkat (__X32_SYSCALL_BIT + 267)
+#define __NR_fchmodat (__X32_SYSCALL_BIT + 268)
+#define __NR_faccessat (__X32_SYSCALL_BIT + 269)
+#define __NR_pselect6 (__X32_SYSCALL_BIT + 270)
+#define __NR_ppoll (__X32_SYSCALL_BIT + 271)
+#define __NR_unshare (__X32_SYSCALL_BIT + 272)
+#define __NR_splice (__X32_SYSCALL_BIT + 275)
+#define __NR_tee (__X32_SYSCALL_BIT + 276)
+#define __NR_sync_file_range (__X32_SYSCALL_BIT + 277)
+#define __NR_utimensat (__X32_SYSCALL_BIT + 280)
+#define __NR_epoll_pwait (__X32_SYSCALL_BIT + 281)
+#define __NR_signalfd (__X32_SYSCALL_BIT + 282)
+#define __NR_timerfd_create (__X32_SYSCALL_BIT + 283)
+#define __NR_eventfd (__X32_SYSCALL_BIT + 284)
+#define __NR_fallocate (__X32_SYSCALL_BIT + 285)
+#define __NR_timerfd_settime (__X32_SYSCALL_BIT + 286)
+#define __NR_timerfd_gettime (__X32_SYSCALL_BIT + 287)
+#define __NR_accept4 (__X32_SYSCALL_BIT + 288)
+#define __NR_signalfd4 (__X32_SYSCALL_BIT + 289)
+#define __NR_eventfd2 (__X32_SYSCALL_BIT + 290)
+#define __NR_epoll_create1 (__X32_SYSCALL_BIT + 291)
+#define __NR_dup3 (__X32_SYSCALL_BIT + 292)
+#define __NR_pipe2 (__X32_SYSCALL_BIT + 293)
+#define __NR_inotify_init1 (__X32_SYSCALL_BIT + 294)
+#define __NR_perf_event_open (__X32_SYSCALL_BIT + 298)
+#define __NR_fanotify_init (__X32_SYSCALL_BIT + 300)
+#define __NR_fanotify_mark (__X32_SYSCALL_BIT + 301)
+#define __NR_prlimit64 (__X32_SYSCALL_BIT + 302)
+#define __NR_name_to_handle_at (__X32_SYSCALL_BIT + 303)
+#define __NR_open_by_handle_at (__X32_SYSCALL_BIT + 304)
+#define __NR_clock_adjtime (__X32_SYSCALL_BIT + 305)
+#define __NR_syncfs (__X32_SYSCALL_BIT + 306)
+#define __NR_setns (__X32_SYSCALL_BIT + 308)
+#define __NR_getcpu (__X32_SYSCALL_BIT + 309)
+#define __NR_kcmp (__X32_SYSCALL_BIT + 312)
+#define __NR_finit_module (__X32_SYSCALL_BIT + 313)
+#define __NR_sched_setattr (__X32_SYSCALL_BIT + 314)
+#define __NR_sched_getattr (__X32_SYSCALL_BIT + 315)
+#define __NR_renameat2 (__X32_SYSCALL_BIT + 316)
+#define __NR_seccomp (__X32_SYSCALL_BIT + 317)
+#define __NR_getrandom (__X32_SYSCALL_BIT + 318)
+#define __NR_memfd_create (__X32_SYSCALL_BIT + 319)
+#define __NR_kexec_file_load (__X32_SYSCALL_BIT + 320)
+#define __NR_bpf (__X32_SYSCALL_BIT + 321)
+#define __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
+#define __NR_membarrier (__X32_SYSCALL_BIT + 324)
+#define __NR_mlock2 (__X32_SYSCALL_BIT + 325)
+#define __NR_copy_file_range (__X32_SYSCALL_BIT + 326)
+#define __NR_pkey_mprotect (__X32_SYSCALL_BIT + 329)
+#define __NR_pkey_alloc (__X32_SYSCALL_BIT + 330)
+#define __NR_pkey_free (__X32_SYSCALL_BIT + 331)
+#define __NR_statx (__X32_SYSCALL_BIT + 332)
+#define __NR_io_pgetevents (__X32_SYSCALL_BIT + 333)
+#define __NR_rseq (__X32_SYSCALL_BIT + 334)
+#define __NR_pidfd_send_signal (__X32_SYSCALL_BIT + 424)
+#define __NR_io_uring_setup (__X32_SYSCALL_BIT + 425)
+#define __NR_io_uring_enter (__X32_SYSCALL_BIT + 426)
+#define __NR_io_uring_register (__X32_SYSCALL_BIT + 427)
+#define __NR_open_tree (__X32_SYSCALL_BIT + 428)
+#define __NR_move_mount (__X32_SYSCALL_BIT + 429)
+#define __NR_fsopen (__X32_SYSCALL_BIT + 430)
+#define __NR_fsconfig (__X32_SYSCALL_BIT + 431)
+#define __NR_fsmount (__X32_SYSCALL_BIT + 432)
+#define __NR_fspick (__X32_SYSCALL_BIT + 433)
+#define __NR_pidfd_open (__X32_SYSCALL_BIT + 434)
+#define __NR_clone3 (__X32_SYSCALL_BIT + 435)
+#define __NR_close_range (__X32_SYSCALL_BIT + 436)
+#define __NR_openat2 (__X32_SYSCALL_BIT + 437)
+#define __NR_pidfd_getfd (__X32_SYSCALL_BIT + 438)
+#define __NR_faccessat2 (__X32_SYSCALL_BIT + 439)
+#define __NR_process_madvise (__X32_SYSCALL_BIT + 440)
+#define __NR_epoll_pwait2 (__X32_SYSCALL_BIT + 441)
+#define __NR_mount_setattr (__X32_SYSCALL_BIT + 442)
+#define __NR_quotactl_fd (__X32_SYSCALL_BIT + 443)
+#define __NR_landlock_create_ruleset (__X32_SYSCALL_BIT + 444)
+#define __NR_landlock_add_rule (__X32_SYSCALL_BIT + 445)
+#define __NR_landlock_restrict_self (__X32_SYSCALL_BIT + 446)
+#define __NR_memfd_secret (__X32_SYSCALL_BIT + 447)
+#define __NR_process_mrelease (__X32_SYSCALL_BIT + 448)
+#define __NR_futex_waitv (__X32_SYSCALL_BIT + 449)
+#define __NR_set_mempolicy_home_node (__X32_SYSCALL_BIT + 450)
+#define __NR_cachestat (__X32_SYSCALL_BIT + 451)
+#define __NR_fchmodat2 (__X32_SYSCALL_BIT + 452)
+#define __NR_map_shadow_stack (__X32_SYSCALL_BIT + 453)
+#define __NR_futex_wake (__X32_SYSCALL_BIT + 454)
+#define __NR_futex_wait (__X32_SYSCALL_BIT + 455)
+#define __NR_futex_requeue (__X32_SYSCALL_BIT + 456)
+#define __NR_statmount (__X32_SYSCALL_BIT + 457)
+#define __NR_listmount (__X32_SYSCALL_BIT + 458)
+#define __NR_lsm_get_self_attr (__X32_SYSCALL_BIT + 459)
+#define __NR_lsm_set_self_attr (__X32_SYSCALL_BIT + 460)
+#define __NR_lsm_list_modules (__X32_SYSCALL_BIT + 461)
+#define __NR_mseal (__X32_SYSCALL_BIT + 462)
+#define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
+#define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
+#define __NR_ioctl (__X32_SYSCALL_BIT + 514)
+#define __NR_readv (__X32_SYSCALL_BIT + 515)
+#define __NR_writev (__X32_SYSCALL_BIT + 516)
+#define __NR_recvfrom (__X32_SYSCALL_BIT + 517)
+#define __NR_sendmsg (__X32_SYSCALL_BIT + 518)
+#define __NR_recvmsg (__X32_SYSCALL_BIT + 519)
+#define __NR_execve (__X32_SYSCALL_BIT + 520)
+#define __NR_ptrace (__X32_SYSCALL_BIT + 521)
+#define __NR_rt_sigpending (__X32_SYSCALL_BIT + 522)
+#define __NR_rt_sigtimedwait (__X32_SYSCALL_BIT + 523)
+#define __NR_rt_sigqueueinfo (__X32_SYSCALL_BIT + 524)
+#define __NR_sigaltstack (__X32_SYSCALL_BIT + 525)
+#define __NR_timer_create (__X32_SYSCALL_BIT + 526)
+#define __NR_mq_notify (__X32_SYSCALL_BIT + 527)
+#define __NR_kexec_load (__X32_SYSCALL_BIT + 528)
+#define __NR_waitid (__X32_SYSCALL_BIT + 529)
+#define __NR_set_robust_list (__X32_SYSCALL_BIT + 530)
+#define __NR_get_robust_list (__X32_SYSCALL_BIT + 531)
+#define __NR_vmsplice (__X32_SYSCALL_BIT + 532)
+#define __NR_move_pages (__X32_SYSCALL_BIT + 533)
+#define __NR_preadv (__X32_SYSCALL_BIT + 534)
+#define __NR_pwritev (__X32_SYSCALL_BIT + 535)
+#define __NR_rt_tgsigqueueinfo (__X32_SYSCALL_BIT + 536)
+#define __NR_recvmmsg (__X32_SYSCALL_BIT + 537)
+#define __NR_sendmmsg (__X32_SYSCALL_BIT + 538)
+#define __NR_process_vm_readv (__X32_SYSCALL_BIT + 539)
+#define __NR_process_vm_writev (__X32_SYSCALL_BIT + 540)
+#define __NR_setsockopt (__X32_SYSCALL_BIT + 541)
+#define __NR_getsockopt (__X32_SYSCALL_BIT + 542)
+#define __NR_io_setup (__X32_SYSCALL_BIT + 543)
+#define __NR_io_submit (__X32_SYSCALL_BIT + 544)
+#define __NR_execveat (__X32_SYSCALL_BIT + 545)
+#define __NR_preadv2 (__X32_SYSCALL_BIT + 546)
+#define __NR_pwritev2 (__X32_SYSCALL_BIT + 547)
+
+
+#endif /* _ASM_UNISTD_X32_H */
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 41998cf1dcf5..b65bc20c04fc 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -3,7 +3,7 @@
 #include <linux/mman.h>
 #include <sys/mman.h>
 #include <stdint.h>
-#include <unistd.h>
+#include <linux/unistd.h>
 #include <string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index f2babec79bb6..6212434bd6e3 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -2,7 +2,7 @@
 #define _GNU_SOURCE
 #include <sys/mman.h>
 #include <stdint.h>
-#include <unistd.h>
+#include <linux/unistd.h>
 #include <string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-- 
2.45.2


