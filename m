Return-Path: <linux-kselftest+bounces-16049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB795B47B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C891C23105
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3611C9442;
	Thu, 22 Aug 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oo99bH4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1851C943A;
	Thu, 22 Aug 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328040; cv=fail; b=XBPqXekYdoGCgSaVanoWvHwoh95JkK2q+RbbjfXet7PdqxVq8Z33wiWOfkU4Z1WIiR8ccVmyCD/IktH/44iOnwYOG5gSBSo7DxI6NxpMgMPR9ydxmQVu2VbEWVZRnktW0ooMViAQ1HCRI764GQ6msE30jurCJo25pCt+iw14phg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328040; c=relaxed/simple;
	bh=LxSgESR/y6VX2mR1jVOt0TvHc1Nwl4kVROKfJdlA+XA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MUuYwhpHg1x5rXqETZsfznIusyWHaxWFOeI54fNle9yb4ZBxpNw7OBFqKWmXvBeLsONQiIYRdXSRfr+CYmPEjtROrbOx3IOdZrSEbibH5ESujJkmq4yO18SgpevTxf7lgmueWoZ9GqKag9SXenen+kxrhOaWzLEMGcGIHZBNVeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oo99bH4j; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuwWW3BOFzSbjiMxsNcc9fhD3G3tiQ4w8KkL/Sm0VUle+SVFqtdimVy9isY1xXbUo3FReaHFg2S9rit2zR8XaFiemrA/0wAyNDTWAIhatQoRbicrhQHR45bGQejoNB/+/6f3WyjK51mjINtUA3t9fCm98tam1L3AIrzMGxsF+vXAkWSOEFKwr05offXH2gq74kDK3/S2UryaqAy5climfxUDBKTBKRnvkunAPj2Re/0KXtIgFaah2+saCr3nO2u3AUOHd0K8SR/rfcXB03cfCujzJ977JM9qC3QMkoNxZg0O9ZM6bw9KvOstNR1c0uDBvONyLCqL7trrzAcCq6mn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGayROL6megTrakY8HhzrjtmU+vvXIsyVIoKwjoyLWk=;
 b=hg1GbXPENkf51e7ZkIhrjIi9cC861S1Mboaxa8xieEAlUrG9mRWHpBroAebIBWJ31m4thuCmQ0VImINQamxsQNONe1K/3IGQhRiyb3zW5xQquU1Bo1dQOJ0BuvDhaMj5dgejG5V/Aunoe1jRdp0j325VPs8IFxxxNU/B898OxD/+mgSv/G5mWMan3kz+HhiGihsmJPbAgfCrM5N5xjMMUWuav5e/j9RkaK8vCx91RUBVo3HbY6TWCX2ukaljyEwUqfctKePQp0YyPweXCsE5bPEIkbgCDT9U9iNYJHD01T654+OZJ4kXSKu3HyF2CuUNHnUhHQiFOTGR1BtSVh0BrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGayROL6megTrakY8HhzrjtmU+vvXIsyVIoKwjoyLWk=;
 b=oo99bH4jKgSn+m8UfpJ5h97wRj9ZXAzf6wHAWYIBFgwMj5PUpCaTkFlrHU1z10ClGAmMIdMuT5TDIXcc2UfNp7iyGiRD8URj9XbwantRa3xGP5M6AHAPN5Xz1Jty0xPDh+8HB0JLv12CnBvpr6HqjBoLftnGwYt+f3W8gP5DBD++EZ7pTHOMyoipnVS5MpamoQt1G2X+iLPb48vU5cwGeMIBb0JvX7vefs4o0qBE50LvQkLxv6WlG91Imoh2drmaQriPLAG1xdDXK1HY0bgTKb7IkAALJqZoOfFjU/1SpdCWN0zVIbkJ5w7NIxBoKXgkbSStZOuuFrFtGadk6r0DZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TY0PR06MB5730.apcprd06.prod.outlook.com (2603:1096:400:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 12:00:33 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 12:00:33 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v2] selftests:mm: Fix mmap() error paths to check for MAP_FAILED
Date: Thu, 22 Aug 2024 20:00:22 +0800
Message-Id: <20240822120022.2095848-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:405:4::25) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TY0PR06MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e8f629-45d1-4e3a-220d-08dcc2a20669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S9U0H5rbsIALzzIK4Ulr62iJwNjnjAl3QHvWNZJ9jha64NXANCxYYmZcyI07?=
 =?us-ascii?Q?Zyq3F52F0n3nRbRGiq5VDkCqzsil6tAsThttX2B3PAWhNNLvWryr3Btn1xCV?=
 =?us-ascii?Q?aW0HTzMRMHLE2LoUaY4Sj9s2hdZ1TLUc4o+9ZxnlYcB/jdyIyHmnXaIJ8sIZ?=
 =?us-ascii?Q?paY26s9PKUIvv5sIcZFo9fB0kNJswJgFkUWvxFNQLOPVwWGTImSAKEVIsYiW?=
 =?us-ascii?Q?nApekJe15bd0HCbcV7GEjP4VPkXJLc6b7B39kxvCZ54AsVV1t8S/dVaGkP0a?=
 =?us-ascii?Q?jo+sXJz+NJ2qJenARpY8HFBj887M72LW/Z6jU/Xa1CLGzzz2yKguR9X3+Syv?=
 =?us-ascii?Q?fX3P0z0ACJqwd0cr2qk4LmN9Ct5y7yCB3Vaj10hlpnj99StINwb5iTimYAmQ?=
 =?us-ascii?Q?7K8W1eUwJznwaUCY2nHcFubM2iwa6iNuJ18mJbPbpGgJCCW44Zlg6uKfN8c1?=
 =?us-ascii?Q?SyOJ09of6LB8mxAbasdqEtyW+CptXTXXzejBHekU6tK3hH0I4mYazatM2V7k?=
 =?us-ascii?Q?LudxAoMeQo6zO0M6EgfxLPCkem9+U1BE1X91y5R0Age0Vwpzt0iEDo9bx44p?=
 =?us-ascii?Q?cgLZv/3YxJi0up/ymcZSoUSj4CqLfgtwlmQYAulvrviTSnHRowbEY9a7ZGqs?=
 =?us-ascii?Q?Q2q1GZFDpzX9tfGOG7ZB18vi6+NZJhgH73NiqriWFzljaO6sOZyGh0jwVbAv?=
 =?us-ascii?Q?QrfByC0ZBRmYafobsRuIJlIXoDx9SU6kH0K8U6aFcF5ans32nAwMBxEfCG6m?=
 =?us-ascii?Q?5a4oz5cUF6+UCSRZK0D7R942Tzd5KOaITo6xfSBAxcB6CkcPYVLqAoxTadYJ?=
 =?us-ascii?Q?bW5d988rSaoXkwLEW9R7CfthGXNE9pX/DpaN8J+HMyRN4rI4jMRi18pEGQnc?=
 =?us-ascii?Q?R+GUCSc9KUBizfu3uobEYhrUKjGLxLhtcdsP2d4hjTn55sImR3kUf5XHbG31?=
 =?us-ascii?Q?j4iXJMN0/ByFn7zstXtG0Vls/ZEUEvphHL5p/eWIKWnBo/uNMjena4D/B0Of?=
 =?us-ascii?Q?2fp4RaIIgBzFct6N8EvcXShXpHlVA1VKp0iMZCmNqoDydcr/2x2FKHy6eTzT?=
 =?us-ascii?Q?u15LJwKTeLXYL8/0bdg+uibaWZjEduflkgrXefwI7WUaneaD06ed6MUvWghg?=
 =?us-ascii?Q?qhrA+xmuFtvUzAPmPSdTJfIjvzv9suutg9xXU9w59EsUsz93mPXKst2BUHqv?=
 =?us-ascii?Q?nb8ztclbZWIPOqogv8bN07cjo1dzU94VNNvoj+CwKLSbF/Sp3G2uRjqaJhk2?=
 =?us-ascii?Q?vU4s3z7hAay3YF7mSddmPaW4Xj9b8e+gyYgtpHxYPKwazNEgEIbrAYiKhmkw?=
 =?us-ascii?Q?cUoIBMkfzYY9O8cRJ/xR+mqUKHh7MA2MWwfyMxNE3dx7W3sHONC//C1XveHI?=
 =?us-ascii?Q?TQdnSYMQxXR+RxD/WxVQvkAJ5AzcA95pMogxxV3XYJCr9HwSb3PwBFs76I3W?=
 =?us-ascii?Q?HdUhEY5L8Cg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJNExhu2VaQjkhkm9y/fXx0NBULB8wq7InB+iRSslIof+6EUGW0WAaZt+REk?=
 =?us-ascii?Q?gEOrpQtFLmpuz6grZDsw5wgIWSG/mJ5D1R9cR6RezGdNb8EbunByMYRFUjLI?=
 =?us-ascii?Q?W2E15PSz8ZKi8FsF0q1rPv1MPmVzDK1oRxmxqF+AeRQ8Yo6lNMZnYgdAIlz+?=
 =?us-ascii?Q?G5FckS8xARTHKIdjIeoVhv4j9P3zgCSAesUbA/FS8c79RlEwSvyDoc0YJ6iq?=
 =?us-ascii?Q?tue4WJrZSqamX94BMhGo+k4r95YOStPcwqM1hIjXUfgr887IBvVyiq3aslQf?=
 =?us-ascii?Q?CRErkpdkL0ESdOPo1slKZGKl+LVq+ETERpeMJHzlgQnc0rRykLsSURP5MoTa?=
 =?us-ascii?Q?URC8qS+dFb66Pv2IWFC+zoynVBUp+IkvmDva0pIE4/FmJd7C+1pDLBJzVb5Z?=
 =?us-ascii?Q?+jUw4YB4ybDU3tlNT98tfz6Dq7HkcuqG0pjU1q8ZI2x+XMaEjh4dngf6dRqS?=
 =?us-ascii?Q?jGDAH8uTn6kEogvy2P66euOwuG2IHx+Myh/RXOHMW3hgUoqmGAZIUJuqpleN?=
 =?us-ascii?Q?NuMB0RiquFlde2ti659AJNqFuttYs//FyKp3HMLGOKryJIglIE3Ui+qgPC5+?=
 =?us-ascii?Q?yh92vm2ZaiATJwWqiKDhWSg2/Mq1LGbrhk7u1OBJa4njFa+A//LtVQgVGCnr?=
 =?us-ascii?Q?UeD/6mKo2pmqpa/bUUzQubFIb+o0WxXunq5ZIWXGtHEobJZgZlpNQ1eadil/?=
 =?us-ascii?Q?/Msy6cOcNVeIVQeaVWtVXVymxAXcwO5bM/rBcC56jrigev+1xgqSw9p1lO0c?=
 =?us-ascii?Q?IqVQf1FJOT9kwKOoGhESuHd6DdRkf8cMz8MMEw4Mw231TFgZSSGbOttYceoO?=
 =?us-ascii?Q?ee0D55V26F6bYn2RcfdMrWewn2S/2zq6TOj2soXw84A3DvVEZ4R+BoDEJ/7Y?=
 =?us-ascii?Q?zb0VP8M+2cg4ooTXC2iyUPK3Ewc9aFg+iIEuGb4Q0Bf/rspY+7AhdWfjf6um?=
 =?us-ascii?Q?cLeoPPjy/qs6PZmEhKgEXIyCkQ/LIKw4dxY6Ii91BNV0qf4BC9RmTBGL2fZQ?=
 =?us-ascii?Q?jueskXV8ijCJb+RAj6jm+Nk6aGRsa7/BDdGn01jZn2cTy6oz+tROByyu9z6S?=
 =?us-ascii?Q?KoTQOakzyOVaPqqsTx8UxUDc7nxOuX7YpB1aqxyMXzVAjpka6BSh3Sc5DtdO?=
 =?us-ascii?Q?L/WvSK8gDk1bYoRm7YkPvZFROsTdgpQhSRO9k8iGZyliaDAbzkRPzhDSmGvE?=
 =?us-ascii?Q?pmVCL8cFKgemwf1SntQ9Vbwnq3BULE8j52zBxc/SLfXnAnL9tMo8NFhiUPzr?=
 =?us-ascii?Q?HUjOSxgILr1xL98I9RgFibDV0TBKocCiMfJk1xDkzlsRQw5ZkFADsycxV+GL?=
 =?us-ascii?Q?Kq0FwkmoK5Xdim4k93c5o1NRm0G9jzHAdmcGwCT6JqL3pF2DRg7c9k7AtKVd?=
 =?us-ascii?Q?8fP85OpLKoho0UZkMSwqEVHs2c/OADOH04Qy+an8hUagCIrfpuytW7PIJT3A?=
 =?us-ascii?Q?5dBPeJfVwCL3btzEFo86fPdWNAHkb2mNbU1/ihp4lucIc7Lewd6xg/CEy8Gq?=
 =?us-ascii?Q?lIeuIe27KrUaNSh2j686D4DSQ47kY+Nk2NeDuwoezKsm9tVt8a5Z8CVY4rDJ?=
 =?us-ascii?Q?H3v6HsU2SoBaIWmb4xE/rrrWVv36MNUNUTSavTlu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e8f629-45d1-4e3a-220d-08dcc2a20669
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:00:32.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAvH3G7ewUnyNRE1+4Wf6otYZvFHtFSn9/G2zf9fA2yVB4/60SaJHWqrpwI/fCcO2Y7IpEGWUN/DWAYrS6CJmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5730

To correctly detect whether mmap is successful, must use if
(map_ptr == MAP_FAILED)to avoid incorrectly handling a valid
mapping.Fix mmap() error paths to check for MAP_FAILED.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 tools/testing/selftests/mm/ksm_tests.c     | 2 +-
 tools/testing/selftests/mm/madv_populate.c | 2 +-
 tools/testing/selftests/mm/soft-dirty.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index b748c4890..dad54840f 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -201,7 +201,7 @@ static void  *allocate_memory(void *ptr, int prot, int mapping, char data, size_
 {
 	void *map_ptr = mmap(ptr, map_size, PROT_WRITE, mapping, -1, 0);
 
-	if (!map_ptr) {
+	if (map_ptr == MAP_FAILED) {
 		perror("mmap");
 		return NULL;
 	}
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index ef7d911da..b89cb83ca 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -34,7 +34,7 @@ static void sense_support(void)
 
 	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
 		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
-	if (!addr)
+	if (addr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap failed\n");
 
 	ret = madvise(addr, pagesize, MADV_POPULATE_READ);
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index bdfa5d085..4ccbc053b 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -134,7 +134,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
 	if (anon) {
 		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
 			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-		if (!map)
+		if (map == MAP_FAILED)
 			ksft_exit_fail_msg("anon mmap failed\n");
 	} else {
 		test_fd = open(fname, O_RDWR | O_CREAT, 0664);
-- 
2.34.1


