Return-Path: <linux-kselftest+bounces-11082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C78D6D66
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FA71F22356
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0822ADDC0;
	Sat,  1 Jun 2024 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9LnV4OP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756BBAD5A;
	Sat,  1 Jun 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206345; cv=fail; b=H226rxKy6gta4SzIHoMrNiUOJQuSeKZIZgHmUWXXUIH5lcaLq7SP9+In1yli58CrWOqLltPrT9G6XYMJDmQc/AkqMW3nuPn8blkpO50b+67eXPr47/iKL9LQ+TICmCSKe6auH8wLJuSawPUPILuyUjxHbx4VH0lF9oOPfdizp0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206345; c=relaxed/simple;
	bh=0rIzFoSjnVNBrlg1Hvb7HDWaFzYqIQGGE5smqzh35jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkZqpSp1B0NrQkA6nZXyJ9C/HOB7TRUlS99ZbsHvPNklSrKL0NxDrKC6kCM3FwJcQeWUTAoIBX9eKwL5BsS/iQeYwuM5mPtSx+33HPrnelduD2LjfmzQSYC8vLyHsgMcdojdanBMtbX9mShLNg/dH6cz9cIQ/jYHM3x6a7vvCMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9LnV4OP; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgzgVRPX7TvfFJmtWFIM1/feF/tAl92KniQ+jRQMQW+w3xx//jQTBFSw3GavL/1QicqKv9YZSqGfFRyZAKQNhZ3p0zjNg2OssrL0OOcm3gwlplc8n5ASTjz2ABgDEIpcTjF9MUodqOX6LSXQANUmUJ9vBpnoEESuOGlwjRvunIVOratuyenusptV+4YuD0u2kVn+gPWtShQESlPdAjHIsVs0Ouz9TQG57T4WPM22oHtJGxSufIs1ZlAw9Y1gzSS7yEtybtdYv97oZ+k6+gUKkSeGLDBv2yXfmfnnJibgYn57o/7jN8/jc3Hn+YgD1zKyapBKtAe9joGQkClEdPSRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwapW2MSa1l71cJBmo5BkSbBN6be7mpzKOxU6OmdV38=;
 b=TeBjjjYY40HH+EjTBcRjx/+c0lLPCra2YglKh9qiVxUCTiMn6NNoMiJKmHKfM3HDNQlMfaQusLtK0kBsMV8S2bJmXz23R8FhXKWGyzhSBNFl/NElYM4+N+6XL0FtvTKyDEZ6ilFBFW448WVneUT5riCwPPSt2opfYoEp5EsrOu5rjnYFV3R8GaTEoGFUw6556y7fvSs2neCu2DM+zXRRHrSMp7IH3Fqp6dVwqD3IUwP4ErgemFxOgbqaAVkiYswchYBeDpiZMS82z14QNdwQH+bq755GTxbbpj14h/XKiVikhtIGduKvel1THlV1MQUZErqec5U9M+sQO3PSKIwbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwapW2MSa1l71cJBmo5BkSbBN6be7mpzKOxU6OmdV38=;
 b=e9LnV4OPuprggLlTpc1s60NtOJfkCwmL5JrmGsHcx94YipINEHt+miBFZ0EPoXAdDJ3isHXP02TFG2aYns437wgbnAxXcOMZ/OpzerdQSAHqG6211Az+/L16Fi03lX5PtZCLjzxgR6FcnOIp3eFiGiYMWacKdrFhS4+3J7h3fdPpJ1sZMdgPLtK7ZvkU9flwadN8d/uCzvHiRNZKofbpJba44h1Eh/V+L07tw40KllWuRBQSKKLlQbMRgl1eZHVpHIVBOH8sMQI9elcrE0Z1i2ylFVfRH0qFhclfmvtmwfQdeEB3UR9Hu3FSxSKzTlQFXn7UZfVxBzhy1itRPjUKTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Sat, 1 Jun
 2024 01:45:38 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 01:45:38 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Alexey Gladkov <legion@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/2] selftests/fchmodat2: fix clang build failure due to -static-libasan
Date: Fri, 31 May 2024 18:45:34 -0700
Message-ID: <20240601014534.268360-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601014534.268360-1-jhubbard@nvidia.com>
References: <20240601014534.268360-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6bced3-57fa-4a00-e4d8-08dc81dc8941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TcN355kNuomKL2nP0+MZ8sH/iPPb4Ofiwu3tDnP3AQ3OSXy4j3I7zRk2xJh1?=
 =?us-ascii?Q?jL1MukvYkFMan/gexvwqrggrsQKf3CYlM0bSm+zMxoONyxsHrjuGNaVdegqo?=
 =?us-ascii?Q?o5WaZfKfVH1Dvx4v4VNwkwrIVsGNOWm2VG+GEpBhZmYIyqtXe7q/37d947uR?=
 =?us-ascii?Q?YngBneQ37jxmM08ZLN8k+NmPdNrxrcjifBlvrIabguDqu4Y7/ADvAE5rphnp?=
 =?us-ascii?Q?thAifVXC4tM4kSxHho2UWP0NuWRjLd1vQHsUW0OW3KsToUaLihGRvN3H2ZN8?=
 =?us-ascii?Q?H0Ob1f7XhFfCWXqqPKtn3Xf5up375mstgJSjcmLi6+goBF08jsqA/ogKC/K+?=
 =?us-ascii?Q?NG7fGKvf07TI+Oj+S7HPE9PVMmKnEWZR7PFaaYfxAYHO0GPu2PRmcq4ax3Ss?=
 =?us-ascii?Q?GMA3VP0RYLb1f54whB0nwr9tFV18xbgNbBH/F9pbtddVDaXwFwY8SfAtoW10?=
 =?us-ascii?Q?qnFxZldSJhmFagEkVlDKN0vL+lbKuxwGoicwOtRPK1ERAhajCOa/ZmAgQI7g?=
 =?us-ascii?Q?IYEipoSYxgrOeYPVpH1JrjSz2l2kio9IMHpwJsI97kdTg9CvYSEDt6OZs93Y?=
 =?us-ascii?Q?uUnprUUee/rWUNmiO77vZrJBM6jR3aYbvU+jTBMq0nQIbT/SJ9zeW7QVR2tb?=
 =?us-ascii?Q?medrl/sTZWij1ZFWyC66AxQDl7rxe4Wt1092SVgEqpJ7ImaWSgtfp49g7eMh?=
 =?us-ascii?Q?fSYSKGswynhk+SUPJNDIz1VkOGLgAeF4Z6iABAzfBiCPN2PiJouUGI3XNHqW?=
 =?us-ascii?Q?rWq9yl3zDxf9kcIqAcBYpfYTPLBu08KtRGNyPtHwxBO2khVOYZva3ncawuIP?=
 =?us-ascii?Q?nFdj5N21ojyAxNgeicx4nIP4+ke2jo6kOsrloKgJjeeiFlez6FLmyBZaT2YF?=
 =?us-ascii?Q?/RFmimt73LiCMOfxXIXk4pKwCcHmWHGrryZS++VENUIfnq5Mj1mbstqXWvZg?=
 =?us-ascii?Q?jQk92hRGAbv2mZEIljnmcdIBI2Lh77mhwjqzcZgjDs0Df3UNDRvokx38Eg6S?=
 =?us-ascii?Q?N5XiVAS4Rz6hovGozO7MZB9n2WqBYELudHEomCNw28tIdsNOrrQ5YfBC96kt?=
 =?us-ascii?Q?87pXp4iuGB2Zno+1vtXQcmGvAdX4lAGmcnuMDesfvkRqHiNL8pmdMdTdhs6I?=
 =?us-ascii?Q?DNGmJUPFNDKRCfChMtUgwKzxLR9X7mpfZd55HxPgz99bCtzqZ/ZyZVHpLrIw?=
 =?us-ascii?Q?qJcerKjAvXhm5toTw4Nlnsu0UF1T9uTsHBYMJyljnPUBYtgsvlNx1Q8KV3Dz?=
 =?us-ascii?Q?fyx14NTsgObG8U5LunTQyJ0RvIVhPvOSxa100/kuRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WrUx7RSxmOPzHK/+ZgaZrZZbueHsFEbfHaK+j7kI1W78KeArUg7ffDwnIA9b?=
 =?us-ascii?Q?Mcz4OmwOwEfnVgybEdKekPXJoF4SnX6BOYulMHXsNQoV10rFl2pg20oxtM8K?=
 =?us-ascii?Q?glzk7gGwzpkfBiAfrh2wfhwAAIBeMigkIYKiGBxPqGld1cZz0ghPYkNO0gp9?=
 =?us-ascii?Q?5/cUEky3VNJZueQTY/s5T5SgYXI0gXIXOyY6WoQPp3KMVICFXW7yJrTvrSLZ?=
 =?us-ascii?Q?Qtwa3C/LrNUvRzYdxoXkIw9Qp3Ro/WUK+b7N1+1mYL47VUuft8O0KFGGKy6P?=
 =?us-ascii?Q?im/XBJ5z3bcMg3wMVDmnEJGmk27d995wQGjWYvpqEAIkDc5vXFWFNbM/8gex?=
 =?us-ascii?Q?3Fm9gEwoqmQ0tv9T0q2XhOKf74HLvuYC+z2LK/l0z7cSbT0hmoeGCp+zPToK?=
 =?us-ascii?Q?ZwXs0Wk5tX8WsAW3rVFOV87vdPrfhRkSmMSfA/hIV4Tf1tXdTFIW19SxZTMh?=
 =?us-ascii?Q?l3gVrxL3rcIIKfcvXPnkWFpNLv0cGOKiye/kWZ0+BjNGUmr1GSqICGun5UfZ?=
 =?us-ascii?Q?HM8ZRjG7deaMNvEV5BCIO8PkAPIQ1KYnkxmFK9+fnTJ7YVCfRWjKGD4E+pb4?=
 =?us-ascii?Q?Y6Zv8zY1uZTJRhCJI3SH/WwR0hq15eweObZvZp4Du8YAzVkI1FsdZmMTASaC?=
 =?us-ascii?Q?qKAMUqVq0g2rotE/1ADHZpDCwUyMc2iQ3vuXWTc94r8o3FDkz+8CA2KS5GG1?=
 =?us-ascii?Q?Nz/nqJuaFRSuiyuQFMIztKualgvGd+pUt4bQSbrh8UiGnx5+lwW9jL8N5s+B?=
 =?us-ascii?Q?wZGD7VuEnNNDpVfLA2dsVxVvUeBwyXI5efdsrIZ+Vi+jet/270dfl0LsqqVS?=
 =?us-ascii?Q?kWVOXjnNhIOFik8T2j/ovDB8jhwLomo6gv/z00CdH8URlLS3JuR1Sx5FigAl?=
 =?us-ascii?Q?YELrw3EbDk2NwwnYWmHtcf5dfFQpMIqWIbq5zrsVikXluTiM/RCjIKqEmG1W?=
 =?us-ascii?Q?7lS5IaA76mbzezwrszOcuPQfHvuWfH5B7ItC2EHpQ1qAvLoEO0AmSOnbw34d?=
 =?us-ascii?Q?6dbpQzViKmGGGMvHdEoRp4n2MYB2pnlwTrQ45fNGDC5Hmguo1VWDle654T9s?=
 =?us-ascii?Q?HqGRsMV1Sjqei1QI6XsXk7CcRQfBK/zNclhqPjzlGfUJs18kd0GcEzVVwQJ4?=
 =?us-ascii?Q?VJ2gSQM5hGPvH/cYiZDOibBVDOuOBnICRQybHeT09oPZMU8pN2zB1DbAJMi3?=
 =?us-ascii?Q?fO/Bot0j/ch07ZgSz+PmeNHOSgDuLHsXyM/sA4jXrrUYeUaP1kd2sqQK39Jn?=
 =?us-ascii?Q?lSuu0MBnvjMyKA8UD9EjmetW5/RNF1ctn95SkFfhE2CSGuiaFQFUvvppDT3C?=
 =?us-ascii?Q?Sm8jJrWKHIEWioYwmaCbw9LN/Szym29PAMOB397fZnbYFe8RaDUsKpdC1XjU?=
 =?us-ascii?Q?aBdOzvdrcM64ucEEOP+bRp650ZiymWtAjhru6z6okt3W0KBZh8ulSUFOLzH4?=
 =?us-ascii?Q?LhhoNj/qiqMDQtaNOcSJJTf5HL8rE7gFEhKp0fTmdHTwX4p9+XbVtQTxkznP?=
 =?us-ascii?Q?Ow9UP6djQCnKzj9S/i57m6jbljt1r11wgjLYXrhozpUTJG5lPR/Z2FSziO7U?=
 =?us-ascii?Q?Fmg8pzqsLquV/gADbnMIdzGSp8PHlThXAsrqePxy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6bced3-57fa-4a00-e4d8-08dc81dc8941
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 01:45:37.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1bpij5keAzFKN9qQVJZ9KOcV/W+TSYirA64O0pQYLgDDe8nuLuSenhmvV1tzWckn3c1hbkmkheoAzpvUrdxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

gcc requires -static-libasan in order to ensure that Address Sanitizer's
library is the first one loaded. However, this leads to build failures
on clang, when building via:

    make LLVM=1 -C tools/testing/selftests

However, clang already does the right thing by default: it statically
links the Address Sanitizer if -fsanitize is specified. Therefore,
simply omit -static-libasan for clang builds. And leave behind a
comment, because the whole reason for static linking might not be
obvious.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/fchmodat2/Makefile | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
index 71ec34bf1501..4373cea79b79 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
+
+# gcc requires -static-libasan in order to ensure that Address Sanitizer's
+# library is the first one loaded. However, clang already statically links the
+# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
+# -static-libasan for clang builds.
+ifeq ($(LLVM),)
+    CFLAGS += -static-libasan
+endif
+
 TEST_GEN_PROGS := fchmodat2_test
 
 include ../lib.mk
-- 
2.45.1


