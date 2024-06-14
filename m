Return-Path: <linux-kselftest+bounces-11908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9590819E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 04:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4595B22435
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0368C136653;
	Fri, 14 Jun 2024 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eiQA+WTD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986922071;
	Fri, 14 Jun 2024 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332218; cv=fail; b=KA3IKPIfdf8DN7JjAujFkndq1ddJoP1JI3pJDsRBx1fROkLdyvcKOO4zSFyFVExU7UO8gzG0SZjBMCkrph3Gd1rk5U7+ofLjGEyuQv5P5z7qeThDUv9WofG71TS6BeM5kwY2pY+Os9OFXRHMnXNyGEIX+IL1+/rBXVX7JuoLytM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332218; c=relaxed/simple;
	bh=spSKGj4u6/V/dHeupHIQQog4Iae5KSDGjJz+DiFyLHo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Lrgw2DswcL/I5nekzeomkjCL076dFEUBMafDrDyS3+iE21vlWUjEanzs4HiOZJhADNDWN9QqZf7YS2CI8NSREB27BWPISY05YsDLkjVYIdSo2Pl7u00aKPaIxiwwd6VYJk6i81hG2bWeU15m/HaX5bgJ86Q3NfOWcWq0H8mu5Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eiQA+WTD; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XO7Sapn5JlADwfYMTNDRR5o0Z8J6VUCsgQy8np/ee6aWKrKM5MjD36MHNEUJzg2nxHinVt/ZS2goyaTUXbENtha0VV8TFAebIt/whQgWZd7O2eGHsVmm7A6R4kZv6qUiMe0mmqNnkPrqJaDo3HMtJ+ldILyioUl3ybeey0UXaeOeoXzXC2Mj/+q+oZ9vpRtuDC+lGN/tJQrPEwsy7UDyUjDOwnmwRWj+xUIKewOeImoa+zPPqn7sJLWcxUyymzYcYRyrFOo2jt5f4sJbwPxCozt5Q67ArJBBrFUU/mpR4B6dwXyUxqWpoKQaH7+s2jQ7Q3ih6P6RPCZXL+xPnduj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urqConhiqN66QsXSjxzv45ufVsx/6iAfTidQznrRICk=;
 b=RiyZ8H1jE+0mgglauuBPzXMyeyoYA2knhyC1zdWAYqYxJTrze7txx6QjpDAVToVIl9mvO+ar0tsTj/iL+p69o04fsgnEF4fsLdC9Pzon/SOVQblUuBcoXllUuqFNYaAIMzPB1hjbxmJk0+2Ym5WmFu0FZJ/w5zn2oOeP8o6TpSJfDvMZO6/PRrocOh39hium3jZMZj/PLLlX6bMy5u6u7y20O3jCmuECHD1Don1x/Y+FTRV/OUktaBV7hYubrEzaXM7xi1/8tkukneZzKxqFvNw1uY5KIEXWjUYEEq2NVw/0nxv8ckpxWHDyD54GSKav/ylqwJRjHEVEPdX25PfsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urqConhiqN66QsXSjxzv45ufVsx/6iAfTidQznrRICk=;
 b=eiQA+WTDVP2Z76DeLxJSNOBF6vJE2K+iEOaxWy5HLMUx/kG24bNdCp7VHFgxyEmcs6wcnQoQwPbOMfGtTkwV+BujzHc/EilDyD9xwvBfTdnaCH+0EHS1rI04e5BlNiJ0AoGSgcooal/NgjH8k1XUgHiPJnmZoWM6QibwAIPw+mX7BM8my1bNSU/beioX4OXdhdVI1pZn+fEnQPiii97yhZG9UQekCQ+cKkXGyudbh4CW052kj4AXLmpcEUZzzd/f36fP2z2qz0vDMmjSZ2KbDVXUXpZJJkQYEKrdJfRGPhAPpU2ct3b+YYCDSuZUazXyr4NJokE9cPqk+haAgEP1aQ==
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
Subject: [PATCH v2 0/6] cleanups, fixes, and progress towards avoiding "make headers"
Date: Thu, 13 Jun 2024 19:30:03 -0700
Message-ID: <20240614023009.221547-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea265e8-1eb5-4676-757b-08dc8c19ea1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mj9OVyJC/FXkfjFPCtue2ufBeHg6LDFnpd8Wf5w8pYIbGNCpojpxLOtvQsP+?=
 =?us-ascii?Q?HcWKG5T7JN3fFfgMX06ZfBAdBdAZnreLnlS+r3iW6KAejUNSbCbRs4VzoDCe?=
 =?us-ascii?Q?gqcgbyUT2+2lYbkTewn1Y0nrIsY0RkcGtwgs2ptu6YzwJN+0oZaq+wutEetg?=
 =?us-ascii?Q?PukhE0fP26MeTWkY1eF/9OhitsCvx8wGSVN5UkaW2cPKeJA3vu+c6ksD5zed?=
 =?us-ascii?Q?OXNufcNpNIDNlMc2JnNaAP4NPvvIrPV44mKZs+MX8G88TBO3Bt+Nzs+E4W0v?=
 =?us-ascii?Q?GXgZNsYhxsL8GzeANR2m6uPznWdel9wsFVRuobiBtdRpVVo/xefp/GK9zULf?=
 =?us-ascii?Q?5lvjEZFgCGNdwOHIWDp2/IIZ//HS5iw4qiTkw3pUdTrzXZHGYYsd+guYj7ZX?=
 =?us-ascii?Q?Lpi2oyJWoMvx5FAYhzisEm+eBI/7kOhG2CHGMeBqdJbjYrRpTsMieH0YU9v8?=
 =?us-ascii?Q?255tMla4GgCfi+fAVC2n+yYwAvWZMQ8OhAlAbbdCEmCeKQVOsV4jQEBJ6bU1?=
 =?us-ascii?Q?WYkRzuuXUzACNj3SR+LwHdMEv23cMBhoHAykZZ+U3ggk1F3aZiDh5KZKBixs?=
 =?us-ascii?Q?PF/MEpsRnFcKtu9zhBL0+t6wstXy3vcC9ikoVxvORIhNgfOZx/34xU3+GqIe?=
 =?us-ascii?Q?81/LIxdLvWxqdzKak1CtLEAfmkQgd2e2mfAZTSqKbIT6CG9oCsSr8AuIE0Xw?=
 =?us-ascii?Q?f+B2fLyaQGqMNi8tk3kfmCyFef8FgXRTk5c/Gy0r9LWSyW/lv/pNSWnCaUU1?=
 =?us-ascii?Q?Rms5bZ7v/ONfalWZn4XktH50vGRqfeR/bR7z8FxCymCU5PMavvOyQoocAhcC?=
 =?us-ascii?Q?zHkEgX5VZirDDU2CAHRF++ybtTRsVpi8Xomlc8USfGmMsyxJsv+ogQE0I/sw?=
 =?us-ascii?Q?7my8HlI2DhZ+HQhEm7MNEYfcSjkjaK53MvLrAtuLIykZ0yyu8xm1njAPUptJ?=
 =?us-ascii?Q?KRDUfjnB7YzTZ1E7x7Mmw8AClLSwXTHdzh8wPdJ8lZjvntNE6JDXDEDKzvMy?=
 =?us-ascii?Q?SuyQUQ/mbKmi7t96Has6pnheurTwEIK/w0yj6PTQHmDYN05f3hTLZtJM7PVj?=
 =?us-ascii?Q?RLcyfzje96OK3/rSch17qFAaWN/rQfYh5T4WS5tbJwIu5gPb3ufZG0+aPuY5?=
 =?us-ascii?Q?uIOhbYe8SUnwXuuYLcHAZ21xN3Z0MwhvVeN5dAVDg1aK2G0tgykNQd1bW1Z+?=
 =?us-ascii?Q?Hm6l1/lblC43BD7ZkK/QeQTtYuTIT8pB7mJ8vDMcrPxVaOu9lfsWMPjtiRRe?=
 =?us-ascii?Q?7DF+Z4fMhdNfMdwLdJOhZkW0hfhHEerZvSgxO5qw4JEgaS8KKC3p5BUi7ZdP?=
 =?us-ascii?Q?Wwv7z1olx0k+P82sItFvpS5D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nht/yZH6sypaTJKcaOv8iaCnYWavGmdZU7Aj4+Jn3Yahv9lpvJqyM/fMkGnG?=
 =?us-ascii?Q?Kvps+XQ5rMw3cwoJsdpCCPFtKk3ydxtDLIZrwzHWzbxSLCnSjoL8NWfz/Qmv?=
 =?us-ascii?Q?Vmpfs5sL+rlTMlQn97FrySA9Ammz4nCebxu+B8uxaUFolpYgBlIUXc+5B9It?=
 =?us-ascii?Q?HW5QtS86WIHLa4d6skrXmA7P0SmBPG9dHQoWz6YZbyKSfktiQfY8wnRMJqOw?=
 =?us-ascii?Q?k+9RK5IBgZqAqn4DnpILEDmjMOyG5ObOXzmwMwORPEL5oSpk6WGy7UfqQui2?=
 =?us-ascii?Q?Ro6O8YgKsVHnjc176k0PLMgK+XJdVs+os/l6nvswAUdjP1zft7QHGkwsG2JI?=
 =?us-ascii?Q?9+0cTNSwwpuYhB6Dpfhqul8kFMWeXsRLgbncJAbC2JPY+s+Ddh3YcEeb1UYk?=
 =?us-ascii?Q?ykuGQE/JKA0LUl9b6TG7wYYsg9EM54GTINhQPh4K7UIGNQhUpOPYuWIEWLR7?=
 =?us-ascii?Q?t5Mm9VMXu1xv04dyofafsuNskqrfQJF3oj/aGa2A5w5wf7CEN/gdIk7PbWNu?=
 =?us-ascii?Q?WeSBoDd6WPCrIO/JoMpRmUjhI9IFRRsCGLX9ujnGNTnFKggEyC9riMCFwyMw?=
 =?us-ascii?Q?DtM/T/PlkSk3d4b9ooQ0KT7+/FWAG3R9w6SB6Agj3ZzvketE6yf9J2VIkqzw?=
 =?us-ascii?Q?yZPdRlMzrjp2xt51R5v/53A00cmVn9aTMQCX1haZZ9AduqNT7UZ0GGIDCI7X?=
 =?us-ascii?Q?HKfC0Me4KqnTZYCKKv0lle8uaRZipI3S8r0zTjNR8uihFL9PJUqGLz7hSuPv?=
 =?us-ascii?Q?Aiv0A2DRereAGFLNt2PzG9rFwcLAxXWscJe1h2a7TOsUj5s363BuoZQ0U7dp?=
 =?us-ascii?Q?zGKFTV2nzMR7pK7jrhzdYc+R3c55a+ZWJOGga8MNEWNUh1jQKnunnpxaq07M?=
 =?us-ascii?Q?NfWEZ3cXsVu/PXTsGj6Aq/ryLruJyeIgZ3I8hrkN+lnZQdnmn37Grz5qUMKY?=
 =?us-ascii?Q?NnXOhLtWDgb0aOCY1WCDxL9rLEW3HfM2zE8g/+jkDkFsbm+nOjwpLZnjzm9g?=
 =?us-ascii?Q?n2IANxCs9Dude8W4914P7FGpuIJWEOXgFj6kH2P9nhlnAisR77KVb2LF6YbE?=
 =?us-ascii?Q?XDrGLBkM+R0R3XmzKTIO6AmxF7PnhBbjJj4sXpKRAIY0EnIHl9/HA95RdDz2?=
 =?us-ascii?Q?9n/GQ4CQdpD4yRdaPAotEg4pAqUk/gDNYzBt8Ch8ICE4pniEjKLJEUrxTsNu?=
 =?us-ascii?Q?bGiaF083Gyyr4Z635sug3evJinYQ8L6+IbXPDIUllupHXkD2z9TwqgP7knZS?=
 =?us-ascii?Q?6HNFsHm+WHSejmb8FHGv4hnQT9EzWHy/rmE2W7hLyMj0KI4p+tnxIhinuJS/?=
 =?us-ascii?Q?LfYSr2kf3pO1JUsBA+sU37Fp2mQxdUZvuBMWd42TBjS9HLx8oWjKW11118vZ?=
 =?us-ascii?Q?GGz3vuN2Xk5RAqYfLD2HriQ5m6yrNzOAiLV/wRWDwSsGRqytVIwiGDLvKCf1?=
 =?us-ascii?Q?yKlhlhTqINQE9piG1iuqCoIVBjnyYijsb+Hgo8ztIorVNTP3YfcKWK47ZXSN?=
 =?us-ascii?Q?YUjOVrWgg+qiiw6vfju+k4W4Io1yTNaUnc/esdik4SAu75FC3abg3lJIuwsU?=
 =?us-ascii?Q?2dJkM/6XHVrt4GKhupxoWgP1ZJlhMLNvQVrY3+H2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea265e8-1eb5-4676-757b-08dc8c19ea1d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:30:11.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J54G0/t2inP7kkLJIfcBZuw+fzacq4pGoB6nij3R5lnLNwqTeQBGg5m00wd9ARBdDCvF28WdfXE9ZpzrUNm9kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

Jeff Xu, I apologize for this churn: I was forced to drop your
Reviewed-by and Tested-by tags from 2 of the 3 mseal patches, because
the __NR_mseal fix is completely different now.

Changes since v1:

a) Reworked the mseal fix to use the kernel's in-tree unistd*.h files,
instead of hacking in a __NR_mseal definition directly. (Thanks to David
Hildenbrand for pointing out that this needed to be done.)

b) Fixed the subject line of the kvm and mdwe patch.

c) Reordered the patches so as to group the mseal changes together.

d) ADDED an additional patch, 6/6, to remove various __NR_xx items and
checks from the mm selftests.

Cover letter, updated for v2:

Eventually, once the build succeeds on a sufficiently old distro, the
idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
after that, from selftests/lib.mk and all of the other selftest builds.

For now, this series merely achieves a clean build of selftests/mm on a
not-so-old distro: Ubuntu 23.04. In other words, after this series is
applied, it is possible to delete $(KHDR_INCLUDES) from
selftests/mm/Makefile and the build will still succeed.

1. Add tools/uapi/asm/unistd_[32|x32|64].h files, which include
definitions of __NR_mseal, and include them (indirectly) from the files
that use __NR_mseal. The new files are copied from ./usr/include/asm,
which is how we have agreed to do this sort of thing, see [1].

2. Add fs.h, similarly created: it was copied directly from a snapshot
of ./usr/include/linux/fs.h after running "make headers".

3. Add a few selected prctl.h values that the ksm and mdwe tests require.

4. Factor out some common code from mseal_test.c and seal_elf.c, into a
new mseal_helpers.h file.

5. Remove local __NR_* definitions and checks.

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

John Hubbard (6):
  selftests/mm: mseal, self_elf: fix missing __NR_mseal
  selftests/mm: mseal, self_elf: factor out test macros and other
    duplicated items
  selftests/mm: mseal, self_elf: rename TEST_END_CHECK to
    REPORT_TEST_PASS
  selftests/mm: fix vm_util.c build failures: add snapshot of fs.h
  selftests/mm: kvm, mdwe fixes to avoid requiring "make headers"
  selftests/mm: remove local __NR_* definitions

 tools/include/uapi/asm/unistd_32.h            | 458 ++++++++++++++++++
 tools/include/uapi/asm/unistd_64.h            | 380 +++++++++++++++
 tools/include/uapi/asm/unistd_x32.h           | 369 ++++++++++++++
 tools/include/uapi/linux/fs.h                 | 392 +++++++++++++++
 tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
 .../selftests/mm/ksm_functional_tests.c       |   8 +-
 tools/testing/selftests/mm/mdwe_test.c        |   1 +
 tools/testing/selftests/mm/memfd_secret.c     |  14 +-
 tools/testing/selftests/mm/mkdirty.c          |   8 +-
 tools/testing/selftests/mm/mlock2.h           |   1 +
 tools/testing/selftests/mm/mrelease_test.c    |   2 +-
 tools/testing/selftests/mm/mseal_helpers.h    |  41 ++
 tools/testing/selftests/mm/mseal_test.c       | 143 ++----
 tools/testing/selftests/mm/pagemap_ioctl.c    |   2 +-
 tools/testing/selftests/mm/protection_keys.c  |   2 +-
 tools/testing/selftests/mm/seal_elf.c         |  37 +-
 tools/testing/selftests/mm/uffd-common.c      |   4 -
 tools/testing/selftests/mm/uffd-stress.c      |  16 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  |  14 +-
 tools/testing/selftests/mm/vm_util.h          |  15 +
 20 files changed, 1717 insertions(+), 192 deletions(-)
 create mode 100644 tools/include/uapi/asm/unistd_32.h
 create mode 100644 tools/include/uapi/asm/unistd_64.h
 create mode 100644 tools/include/uapi/asm/unistd_x32.h
 create mode 100644 tools/include/uapi/linux/fs.h
 create mode 100644 tools/testing/selftests/mm/mseal_helpers.h


base-commit: 2ccbdf43d5e758f8493a95252073cf9078a5fea5
-- 
2.45.2


