Return-Path: <linux-kselftest+bounces-16540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47359626BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284C9B2313A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3917799F;
	Wed, 28 Aug 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="U2wlLubZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4F176259;
	Wed, 28 Aug 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847468; cv=fail; b=ePF4VQ0IT2keSshmumDcgD3nySeU3f7ssFqNrz5HV/RF9hLs51JDTA9qrWWdYphmEoejxUSx4+fM9AuAEcP3xJ/Bqe3O0buRa6yF4pQ5gwlRBwXvKWK+9Dz5LvWHw2PH54lqT5IxfEL5ewMbLiXw7htQj1CtAUxZsgNMg9Q9VcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847468; c=relaxed/simple;
	bh=W7Pf/beh55LSkU7u5QFgUZgcOvsu6zYrFFs9audhap0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gg2D+4fSOBu1Qr0M3yNj7kzESRWN6HCfI4lKSb40tVyAOJTI7KtyycxqXzf7L60QioXDn7ctlRwa8bB/lgqW9V/guzN/XmP4QsW193ReSRc9OxXaZOxE7Isq0kX3bsPCAmNcd+pvH403FC55g6cfEJIJTJkogLAK2iaSqdvdyTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=U2wlLubZ; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIxg9Nrg54BKbjtU3Jwt1J7/FNfjQp3gJY5hJm91P6ysSwDfutw3LkokncuqpM5iicMMeqMRXFzzpK7Y6oSqv01j4wI88tjzhPF09oogbKRoUh7XDTzYU2IYCyb2gYboPTzX1DnN20REDFMew1WoR6NVsLHKFFg1sJODeWdG1sa9YBNNs7BXp1omLlQ8NkLHisSHyBQbe7QNAkflzIJBMT92ufzerKDht55zVMzq2eyW9YcRO/EKvVPHloh6VJ41CnktuQrMHkghhQ6aLh3WdZqdEQYtm4yXMQ+ZbIXr6h633Oy0tqF3Dd9fyuE1PSbJWReSIc5HaIdwPJD7YTXjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHLIcIwjRUgWJ5T4eU7rRhy1/DMI61YC1bYUPUH9Dlc=;
 b=c7kXUZQsUC9RBX8lZRM0Ut1bjhB+uM2u9kOeimUscvZ+KP+59PklK017DLNz2Sua3DBP9YWQ+ZWBXS0O2fHd+joSelMT48AJyGYp49N3l0ySTFpjSa49b+5dT165EiqO5iUPS8oJ78ZF5+FXyPU9DnMBlmDn8SSJf8SFh0pX/lO44zhWWfnMatT/7AkGpk0FCAVvsKX8mryKfwmUXULW4SN5qZtV5JM5/yLhXfPZ/lqrl38cG7HSvvpCkag8Pu0qRzevOBiMiwYPlB2ZmXU5LcW7lPlCao+bkwgCfi3kaHbz8RPHixEa+rKXXvJUTrFjAuLkwOSPzA8msfCkvPEr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHLIcIwjRUgWJ5T4eU7rRhy1/DMI61YC1bYUPUH9Dlc=;
 b=U2wlLubZYcUO1ZpASpbFk3bFdyAUxfX9zoOmeUWYxSAyhSZQ4OYo+Vj4Zedxkdy9z/3w4a/XE1riYO/E3ObsV7iAPGEnc1B+M3fncZtz9GlI9F9rHqY2qvsoMWl6OUiUPkTO1LACofaWR1y/7txCJWUhrL4l6HBLkywTZR+M6HWDW2FfNei5GcjjDzQJZLvgb8lfPCWm0J3OBiZicHjyHNEkM+yiIou0I4XeIm5fUgU8/wC5ImNQ4uNmYgy46wUllku9HC7lbZjFjSuwZOXjB+/k2J2/KP539hAQD3WChDKHmUYwTaNgyQdE4dZBhZG/VQd3ZeE+X2DPNKMZM6TdzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by KL1PR06MB5884.apcprd06.prod.outlook.com (2603:1096:820:dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 12:17:39 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 12:17:39 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	terrelln@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	yikai.lin@vivo.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: fix static cross-compile error for liblstd.a linking.
Date: Wed, 28 Aug 2024 20:17:06 +0800
Message-Id: <20240828121706.1721287-3-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828121706.1721287-1-yikai.lin@vivo.com>
References: <20240828121706.1721287-1-yikai.lin@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|KL1PR06MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f7f8d6-0f34-49f2-4356-08dcc75b6867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3wFNbtBiOfF6AX6dd1OPYrIOye/8DmrO5Jo6IOj8KX5mdstGKF5WLuPgzHE2?=
 =?us-ascii?Q?Nuz4wm+VUgPZqgA4b/d4huR9rOEEwJi5iFTGH7H7KxCPqA1Veqj5QCuw1Eh/?=
 =?us-ascii?Q?D4Tgu2Bm3nyWE/92/iBZz2fgw0goBnwjv1Va8ttcXmo9QEsp8/VTA/HYLRQp?=
 =?us-ascii?Q?xOBwGa6nOtnexl79CInGttsHQDNX+KepoxLWe575a9+6ZQTq/6tKLbtGRIt4?=
 =?us-ascii?Q?i6HqitoOGDJgnztFBDtEWipxcCXFmVpRZgYRTFXt749KsCmU9AYPYfTBSeZZ?=
 =?us-ascii?Q?Y8lCl/XTHrQJHwlpQ+2ggflU9HSQZgOSs+maULoSoBXqn/p6rVVNC2BXxTWk?=
 =?us-ascii?Q?THbe/emEM07cEDjduuvbA18KbzZouh5lqDscdQQXBzrprEzj6UoIQH8dNTDX?=
 =?us-ascii?Q?7/oYWir3jp22ezNKJ/Lkzs3NRxETvoA54fNaZ9UpwX6q39QpHjyu38T6KwUv?=
 =?us-ascii?Q?aosSAYPImDc6f/R303EKHWv7SNUxyZ2qUkI32VxthdOwFsvRCaxcIU8QKnrH?=
 =?us-ascii?Q?QRg6M79ku2FyxxRbFcjfNF8TjVhK3SNtogo14A21wKocVv4eURHdFIiplZRF?=
 =?us-ascii?Q?4czk5y3Vl8+IW+MT9ivBICYmkPfCMH/754rYCTFx++EYqT6lCJ0f4wXBdJdz?=
 =?us-ascii?Q?jVGEJDI5Pyyfrrlt88yggjBSJQjGb/WR9+PARBtnal4ytzloHRCbIHwE7c3D?=
 =?us-ascii?Q?+tMaAvbk0xnfM+fCPuG6GhK9wsM4bC85tWOe61THIW/qThgbdYhSn0NMABre?=
 =?us-ascii?Q?prqAWhBU1nATPzyoX85x28jrWvl9pvtiBuPofyFyVvvnBdecRZA/X93KECvB?=
 =?us-ascii?Q?rRhWcsov8CEx2pvXI3dVJAAG+RrqX59Nj2l12PxNmXhRp5bZambM0nNvCRGV?=
 =?us-ascii?Q?LPN2DF1SO0WGec2VNyFcTA9x1qKmK+JK4rCQlkFzQ8Shg0t7NnTnxqm+2YlL?=
 =?us-ascii?Q?jojWOgLLFzNSeCLM7D4wGu/FJA4jzkyvRjAhzjtZYoST4sWFWZPZr+SOZQzI?=
 =?us-ascii?Q?RB395hzI8F94bLrxFdUpaVwQvmyWXf6eIy9cqtZZSBXjYX1K0RBtcj+uu4I2?=
 =?us-ascii?Q?wAZIgSvijoPA/+b/m3UOP5QOSSAylBdW2VBlGP8PdnCTqJXARKCAroHoV927?=
 =?us-ascii?Q?7b7v0RU1/8Ti3quTWZp7LdXasDh1K0Z8sMmQxHLTVoViAGf4D3zG8vgyols8?=
 =?us-ascii?Q?HzUb4i9GJLnnMiv5Vk1e6ve88ixWuU27aRhBusmxpQWJlS8aqzXE5ViZuJVu?=
 =?us-ascii?Q?T/UY0B6ziW7QR2t0QtfEW47QEu4o1mkPoGplK2K7bSMLmNONwefWq+nanvgH?=
 =?us-ascii?Q?X40Ri9amSeEBCMP9BmCIOm2YQg5RGK/4PBX9QgY0tRGbRi3uMZqXYgxWwq4d?=
 =?us-ascii?Q?9/dM7YAUJY8OStjkk5mwuS2fNuouZISyflBsG0si8EEr3wgmbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+DFHAUsPW2eG4DgGsxXhCFfqTpmUo3WrOnlRvxCg3kFMHP4vzNMgKaSqPz0T?=
 =?us-ascii?Q?SDufrHMnWMc1nZSn50/JrHTVmva6H3jSAVZXcRpVxVyd/27ye9LrXRtTP8Zv?=
 =?us-ascii?Q?ZWiyISFEunOd0Yl84O1Z8+2JoS6pVS0JAX9+Yfnb/YvEf6yKz/IFdujNMMnl?=
 =?us-ascii?Q?CZuPPtdz8T2Ne6hP72194BRR7WgGZB+RWMxWW4389Bzr0N5cPenrgTlwUr9k?=
 =?us-ascii?Q?hZQ/galdlVBf6xhAINSsJVWmcBO0bYATdHNISgKVHagd7OTgKPyIl9J4Udl7?=
 =?us-ascii?Q?uS6Ge8uUMbmBxtSm5UQlxdhNGl6xe4wPWD6TvR0maZAuqiwS4vDu4qYmvUNc?=
 =?us-ascii?Q?3CQeVjV/SXulvBmG4Gr23NjL3T2XbOPMt/sYu33ZeJrFlYYsUKYdVgq2ufUN?=
 =?us-ascii?Q?WRpo6B8rPXxMRVjlD0u3YviL+KBl1BivRsGbE4lgrSt2iZnTdqx7v/3NnH+E?=
 =?us-ascii?Q?WbD0z0jLmNodEgCaH4npw1gsfInyJw5jH7aDoz+C/grebfNMpELgorLLhP22?=
 =?us-ascii?Q?3Wa25rJ6m5kntMEIBweKW2SdVTujVcBDzOGIqSCPwZShwDylnUNfiy1FvpOj?=
 =?us-ascii?Q?na3IH0Q6sehLoxst0uPBPJFbT48W3derY+EBeX9c6M3sSPvgOi4V1wI9lRHo?=
 =?us-ascii?Q?q80JePxrNL7H5IX0LFGd6BjSSt3SQnCB3xygdAnSnCXzXj4HJb323DYvF1lF?=
 =?us-ascii?Q?FhUesGK4ZOEiinuj9j4LVHm47z6cdh5Dg6JQ3t4X1lIafE8v46123ZEA8fHW?=
 =?us-ascii?Q?OeW0nmeLV0rKxyQmGp39blVFPvvBcu61ry8JPxOuUuyxDG9xhfcE0n8Pe/aU?=
 =?us-ascii?Q?3LNs62MTp3unV7UuGSDBBXBy4VFYmwzN6bPbAqLBTYCGUQG9Y6Wo/xY6d/vv?=
 =?us-ascii?Q?fIcFPcVB1TCSl55n0uequOz/Apl+mP2tbGIDx1Mkoe06bCorrU7KxSTX/7qn?=
 =?us-ascii?Q?3X+uBsEcRCgdmw8u4vI/kDz5BapBB0GD+1bvLvuBxhKj8f4VK/uxg9BbBj9I?=
 =?us-ascii?Q?0SUYv9vZgZl+SEsBOiLuTHCMkf6Rqd3gfESRVAF+2aiS6Kxe0sf3vcnKJIp6?=
 =?us-ascii?Q?lcN/rTsDvT7vC8PehoKW5WRmQ3ZSoXN0LKzcKX7LL238NETTA60czMhurdp2?=
 =?us-ascii?Q?Wq+4Fl7X9M1bk8B12kwwz3pL4Vkghqb0zRay/nKJIdjLAQgM009fvkUVLP9b?=
 =?us-ascii?Q?hlCmNNSLcBW3Ip5Yo81jTF14hkBElNq1sjm231VRvkkYcv31fxlP8A11m+9n?=
 =?us-ascii?Q?oAgFMrZlUOqPOJEfe8rDJxPyURTcEn7rxFoTbpcPrd1HvFR+pXIUeUhYry2o?=
 =?us-ascii?Q?REOi0+G8rw9ssaeOlClZO5ImZMyYP9ybNyMY+4XrBNILTpSNCrkUQPROPnw9?=
 =?us-ascii?Q?gbAoQNhZ1Uo7OCuVmQnrnABrnpnfVmx/4pB9sjRfGGfuswjt6I0H6ujMKbG0?=
 =?us-ascii?Q?eGOU6VJWrdqE9YmJy9YkfHM8VnJcm/wMw4oD30A7I3Pi4mRBrhsq2+lFFlLO?=
 =?us-ascii?Q?21sBRlH+9LSMraZfZlVZrIf+NlQckaGXK8J6Uw0IhpT0tlexHoEyk47GENo7?=
 =?us-ascii?Q?GvNPsc/uQGkoPGPzhXfIePvihmXgF0Pa/wxO3ZB3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f7f8d6-0f34-49f2-4356-08dcc75b6867
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 12:17:39.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RowrE1P2spMgmXuwqd8vPV8yLF3GVZu7EQh4mikGEBrmLk2N3kCVfhrbseBaxQLwawtktpa2JXzjrVPEJdQC0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5884

Regard "LDLIBS += -lzstd" as a separate patch for static compile.
To fix static cross-compile error like this:

  $LDLIBS=-static LDFLAGS=--sysroot=/aarch64-linux-gnu/libc ./vmtest.sh -s -- ./test_progs

  /aarch64-linux-gnu/bin/ld: aarch64-linux-gnu/libc/usr/lib/libelf.a(elf_compress.o): in function `__libelf_compress':
  (.text+0xec): undefined reference to `ZSTD_createCCtx'
  /aarch64-linux-gnu/bin/ld: (.text+0xf0): undefined reference to `ZSTD_createCCtx'
  ...

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3f0f9a171651..17d75ac2f461 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,7 +46,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
+LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread -lzstd
 
 PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
 PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
-- 
2.34.1


