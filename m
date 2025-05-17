Return-Path: <linux-kselftest+bounces-33239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061CBABA7B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 04:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A5B4A7E8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEC813BC3F;
	Sat, 17 May 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ox.ac.uk header.i=@ox.ac.uk header.b="csUSsKvA";
	dkim=pass (2048-bit key) header.d=UniOxfordNexus.onmicrosoft.com header.i=@UniOxfordNexus.onmicrosoft.com header.b="QF1V+cXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay18.mail.ox.ac.uk (relay18.mail.ox.ac.uk [163.1.2.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72415A86B;
	Sat, 17 May 2025 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=163.1.2.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747447228; cv=fail; b=Y8yy3/i4HRKA8IotsTxfGyxwh+onWq2vsGMA5kMs/M6oaMpgbUhQbOvKEUMiz1Fg+CsnxNyrC7yLOZlcRmRJqASfBXzh3ZwdbMJRKix6mw08f+mXHm7pYmlEy1Eg9wNNBJLOgiwlf8MXERW4kyWoBwZYm07HdGS7LZjUQYmZmqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747447228; c=relaxed/simple;
	bh=UYY4BsaRBHtAH3fsbs532dt1S8R6DX0yZgOha9eXU1M=;
	h=From:To:CC:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u0i8j2Q8AGbB2MK84BHud68vwmYguR+oP9j6MLg42WwFyRKgTBxlwfeew3WunhW7RAYFwybKv31IQOcz8kU8Ypm34eeSqq0bmLoOtXto1ALmeppAwQESqhxgrmkWM5LQcZsVBzZzp+8juNGgMQOEsU3qcqUeVYQ8ppco3EbWeE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=magd.ox.ac.uk; spf=pass smtp.mailfrom=magd.ox.ac.uk; dkim=pass (2048-bit key) header.d=ox.ac.uk header.i=@ox.ac.uk header.b=csUSsKvA; dkim=pass (2048-bit key) header.d=UniOxfordNexus.onmicrosoft.com header.i=@UniOxfordNexus.onmicrosoft.com header.b=QF1V+cXH; arc=fail smtp.client-ip=163.1.2.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=magd.ox.ac.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magd.ox.ac.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ox.ac.uk;
	 s=flood; h=MIME-Version:Content-Type:Message-Id:Date:Subject:CC:To:From:
	reply-to; bh=MDoj/XCROTt2dZBKeVF+QoqeprIcpfe8Yl5Sd7TdN9Q=; t=1747447224;
	x=1748311224; b=csUSsKvAOOMJia0dVRR8g4UOzZ3iBflGour352c70n+oTp/8qJ9jRc/PbEueQ
	4OLuIx6aE9D2Fnpyon8Lr2WxfhIJOjzysAkXtHmqTjQajKZFAMH+xXw3+Py3y7sZXejfIaZuQ6PGG
	y6vak2e+YJvrV51xw7m1HkiLIY6LPGeifNXD4t8LaBXksujGHIkVxj5QLDL7iSYDAocMJJ5eeyzNe
	t4o4LihkJjx/5BgzHgovT+yc8BGN/4t8nVZBcuFBGEDGU6PFuZY24Axb9MhSLnPF6VJg2Oj4RJDnP
	FZzWvnIGLbE7zzHXG5ukwzfEx3Wl7CyofLOY4fMuERO1h53xXg==;
Received: from ex02.nexus.ox.ac.uk ([163.1.154.242] helo=EX02.ad.oak.ox.ac.uk)
	by relay18.mail.ox.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <praveen.balakrishnan@magd.ox.ac.uk>)
	id 1uG6qX-0008ZI-8F; Sat, 17 May 2025 03:00:17 +0100
Received: from EX02.ad.oak.ox.ac.uk (163.1.154.242) by EX02.ad.oak.ox.ac.uk
 (163.1.154.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Sat, 17 May
 2025 03:00:17 +0100
Received: from LO3P265CU004.outbound.protection.outlook.com (40.93.67.2) by
 EX02.ad.oak.ox.ac.uk (163.1.154.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Sat, 17 May 2025 03:00:17 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC0SOyn1+TdtIFvbU+4SoCPXZQPduw5grLVPtZq5/1dIEJ0z5DpXQFv8XNzxHEFLUg87ZmFIbL6TwplTYlCpt5Sbv+S3af6l5ouGJeWLd16q7ABw59UObYoNV3ftoJx8F9IWCcCdIz67DOypTZygN3Xs7vzLGsaCXUGx/OVpaBaT5yG3i1Uj9sEw7zai1bIkYDpnuUYKaVE9GUwuT+MiqNinP3OVYxG0NDSWR1mie39S7x4zQjB5o4eW9HW2YE+oSqsGiI8YrDb1cZeX7SPqwMqFZAj3Ywff2HSB7xyUC88BnwrMfGSDbmB/0b7Lna9ny5Vep3DX9lXNlX7drRT2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDoj/XCROTt2dZBKeVF+QoqeprIcpfe8Yl5Sd7TdN9Q=;
 b=Kzzcgug04bjGtNEWoXlylq8JhRR2rU3G9/JVGBQgF9eR97+ELF1RURaTNtksHxtpSbKYT9WoTCBSRGU3A0HD6MTqef5D8V0MaFBbUROgTFXA4satUHVInGkGbdDxiMkidOUQSwQv3jchITTi9wSwuBfTx304HXQ1klzfCIHGuJgvcouQarN9rT/XehDdP95lOA69WoqDMtYJaB5uFujDrA2YbsFt+2LJ8Sm1kbzaqM7y2kyiNU6Y3F4vdj9yYGXfs7lbjdip1sb+xAMUnEa2zmyY4KjK8CTdeQrHfCmKMxQWW55gqGWOD/B4KTk2lgS0vKRzRlq2V+pPLvnameRCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=magd.ox.ac.uk; dmarc=pass action=none
 header.from=magd.ox.ac.uk; dkim=pass header.d=magd.ox.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=UniOxfordNexus.onmicrosoft.com; s=selector2-UniOxfordNexus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDoj/XCROTt2dZBKeVF+QoqeprIcpfe8Yl5Sd7TdN9Q=;
 b=QF1V+cXH3I42DcZ3+ogFTqVIj86cCIrHrC+ySmZxnffqVQVURdD8AfSUoCJlmVte7G3PaUwsQuNGhJdU7/FNBgY0EwgLRJkvW56o8o/xYYkZG2EkgQG7MEynstpMpjMqLYtXpyZX3xqbpHCY6YIhRZZ5crq7uslGSxYGzfxYjT1lyZAO7KZE8eUV83o8KvJPN2GgIlQzAaxBobTRadbv8QwKwTJo8yDC9gu0keo/B6FFecig21ouF2Q1sn7OkpZmAAyUKf5DxXREZfWaGx4eLFCiBdDkLhQqdLDthk4i4UE7Dah6AvBFyr5lBzCNrq1Ue2trLdXSOtzh7jO2XOXBsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=magd.ox.ac.uk;
Received: from LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:323::12)
 by LO0P265MB2874.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sat, 17 May
 2025 02:00:16 +0000
Received: from LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 ([fe80::639f:86e3:3b7c:f6dd]) by LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 ([fe80::639f:86e3:3b7c:f6dd%5]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 02:00:16 +0000
From: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
To: <shuah@kernel.org>
CC: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: [PATCH] selftests: net: fix spelling and grammar mistakes
Date: Sat, 17 May 2025 02:59:12 +0100
Message-Id: <20250517015912.131187-1-praveen.balakrishnan@magd.ox.ac.uk>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::27) To LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:323::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P265MB6985:EE_|LO0P265MB2874:EE_
X-MS-Office365-Filtering-Correlation-Id: 130df9f6-2517-4bd2-ca32-08dd94e6914e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|41320700013|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rjBFNodhf+fSEVyF7agvGYwd1CoJmiRr4vHCo95A617vAdvkzNHqqXQkLAp5?=
 =?us-ascii?Q?1nbeu9WdqYVprFeeJzdFeIOhbugoA35cRoUvJ2KVG50UA5Tg8nWXKH5qu92L?=
 =?us-ascii?Q?W0VhpdieeOkQaONNAyilj9QYLQXYYejcoETPGbTyy/1h0qxjhS86NUl4/KmI?=
 =?us-ascii?Q?ko6KrC9uBWJcbYCvlEW4fQRoVIemqxfONSXLX+8a3xGgpE/aoUhKlMziszEn?=
 =?us-ascii?Q?goThHXiE/wl22+p0P+U5bkyWBYjd9AkdhBcU/Y22ee6mRacSS71a0+J7CBur?=
 =?us-ascii?Q?ROWpWwgw3gs1Ew553Lau8wn6OtybRDRW3TvMCXWIT1mLcwuzo4RHD4NBqxH8?=
 =?us-ascii?Q?GXiIGr/85QpiEt9McN01YGRtht3j4LNlWE2SFmH/6v3Ybx9lwVS6WOAUf/Zz?=
 =?us-ascii?Q?goEaHLjjyehY/KX9CUZcrVxOysAoxq0m8Y/z87i+Vz73WNIsOyOjvjh5f1PQ?=
 =?us-ascii?Q?9aI2a2/74N5HRwW5JhrawF0XbNpl8xhuY5vKAgNNGboXv07nXPnk4MvQNqDK?=
 =?us-ascii?Q?m1BB8sZgNJOZjGYZgUrZT9Y8Gdcr4QQupXFdfCZVGc2whtcyhrAbCYxg7a9h?=
 =?us-ascii?Q?JcRayDIVI8XFoPDw7eZ/bcyUh1jzje0uirKF+NXsv2wCHqMgX25+7vadWE9X?=
 =?us-ascii?Q?LL0TJqAWqN/VtfYEBCZdBQvqWyrHksZfYgW3zCQZzB/RUky9U+JXScBBSC/D?=
 =?us-ascii?Q?LyJUzBHCW+dkGw30IRCDlWOY1pQBu9RVNsVj8KOHJA1bXVFZD6x2d1enjG7A?=
 =?us-ascii?Q?SXOkLolPXiSXe85bJdwlGkZwYz7ocHSoiajVyQWBlFWZ7MEoAdRI5I4PVOLz?=
 =?us-ascii?Q?YJ5PV/PgvrRdDJb0Y3tU6kc5wrRYUrBsc1cwniAFu2dXJhDWhdumpZDfYG3h?=
 =?us-ascii?Q?ggQSeBHvrI8oY5ril9e31D0mswllrk/Y1nVUwKYPIVNgocaDX9wELLCJabab?=
 =?us-ascii?Q?YGMBFHJ4qezRttTsjsVH0BwOdDtULzdTIvs60J0xwxVAGEL+q1/LcbwSKWeK?=
 =?us-ascii?Q?wlEoDfH5UoeCPb1onb+6S3iqpqLdUFNXKhnehlAT2qEa87k8ayDzLpaskE/8?=
 =?us-ascii?Q?TZa/XdaqaZ8nFIWA5URdr/fhtruMocxr5Gky/2Tx4P7L3zmm803fugff3i0S?=
 =?us-ascii?Q?y/wNhtOgP8/jVtWAYg5frC9lD/XjI+bhbnyefMLImPb73Z+mK+ttgX3nuafl?=
 =?us-ascii?Q?x5SJY53KF4ivqGYQYANS4ZWAmtujVBx8ToDxKMXuvj+TuX54XrKiwD2+6/Eb?=
 =?us-ascii?Q?EdC9R2SE6ZHQP75g2Ie2sMUebbUOS+5GQuoXtajzvX3KVmrufrIMgtDQEZ6J?=
 =?us-ascii?Q?Il3WQI5gf8wyr7AUY+Qhv0eCuu0kGDO/gsbW8fEjM/0UWjzKXV9Qpy5fAXEv?=
 =?us-ascii?Q?+VTbdBe41mQ/PSUzSH6/28qxWYq+tOJYGnd9HQNRKBfs/w7NSOebdfYS5Vww?=
 =?us-ascii?Q?Z6X+SsaxlNI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mClkrCJEiJRNfjhs3gevsgfZ+t4yDqnCmT5R3/KN06LSHOGAFhB24ZUj+2Ib?=
 =?us-ascii?Q?w2QGnxAG9FaCu1yWacvQmSdkH3BUAn9ACSX0syOC+YwQWKTIxi55ckG22S72?=
 =?us-ascii?Q?tZvBEiilqZMtA9ucri13mdBzisPtpeUd8QdQeXqzEo6MrOIos3gyfUnls8sJ?=
 =?us-ascii?Q?5JZqCW9Py0gfwTIfwPirLHR3Qg+6J8ixNntTnyYoKo9KLDjRakdxHNFITjwL?=
 =?us-ascii?Q?WJGc1rl7Q1faYK0dBKwveZmYGhn54yI2nEZCjT9RHe8/BpUtVU313/YDYZJI?=
 =?us-ascii?Q?J2zZXEY4qpg+/B/lIk0Ux7I8gSnaMClw56J95FDNRL/SMfw75UE2UPiKwB0h?=
 =?us-ascii?Q?TW3IUAY2+GRUtrYadLYp4muLiRc9plLOVn3svnxyNCGMbB0KjRG1Gbjw7ZF3?=
 =?us-ascii?Q?l85pQt2lhcwK9nitE3CYVTyfHt0c2b8Ht4DdwxPWnbPkqnFOpUFjHcdcTwG1?=
 =?us-ascii?Q?tCAFQ3QvivffdN5DS7m3QyGuCYvm9SxsWJPri7kKB8x6Z700yHd3VKcVOdXZ?=
 =?us-ascii?Q?1T4Z2VrJ/lErBsfM/ezjuzvl46eGdYo8Db1Bc+uKQ0My7a9U9gEy08l+sYLp?=
 =?us-ascii?Q?GKEZNqXI4X9T0q+sNIfinJsFin9XMMOF7eZpWBqtz/3He8vJ57sl7xCXVKlL?=
 =?us-ascii?Q?6lysopgOSHFE24Hc1XK0jfcSxO5mZ3MPo5xSJ9esrcmIdk697EecC6pRwA0F?=
 =?us-ascii?Q?KL6WbgwnpQrWaFV5vqRimNFVrPbWC7FNAutPjLbV8K9FlZ7VKQmPewZG6cie?=
 =?us-ascii?Q?tQVqdLXYUWJk5MQYtyTtd7ZPfPDV1PmtqGLo+KoRI9zb+CkchhGI8FWvsbQJ?=
 =?us-ascii?Q?c8EHzs8y6fukDvR/nu9BK7yzN1I+zP1bKmW8j4GDlZjYdzyGuBn/eh2FtRbD?=
 =?us-ascii?Q?bgOYKeXafkSutnCVc7J/b5i2v18fVnn3HjEkW71tbPyAMg6KpiDdIhLJ1DkG?=
 =?us-ascii?Q?7ueO4DmAvt5D5R5H1NbBd5bKAW+nFD2hMbbd7wuHq8B+KTmKHxi1z1OXDRhS?=
 =?us-ascii?Q?S6C74/4Sju4MtxUEPJ8UAGvODgIj40TNc29kmQkqluPHShmKxUKymVt4fVl4?=
 =?us-ascii?Q?RPtN0fbpxJWodRGoasnuuP8/gBPZ7EuvaWpA10wm/CU7Zc4ulZ2EhNH7AkAH?=
 =?us-ascii?Q?khhTKQHxuI8Ld1AUiwEfLtX4SmvUybfxyxmBThaStK+dQZDDVA7ifgtc3hKg?=
 =?us-ascii?Q?Caoui8irDVWgxiHSpv4Kn73FcQUZbp9Mcw+SNh0f4IXcukCPTvBu9YeyB4HT?=
 =?us-ascii?Q?nOuaOPv4ukat/ewZcQvm5EaE6tJBnhz3aA2iOEFLCb1FdpwlbRW93jxvbzLW?=
 =?us-ascii?Q?+Hf9i3MIgQ9uBIjcoWySmWBItGM2w09M0fOzf8loj/atk5hisbGqM3m4dwlN?=
 =?us-ascii?Q?pnEljpfwTdOO0F3OvGu5yrfw/u8qltgfS0ZQNtM/9OrR9SdqDVvaZtqjC4V1?=
 =?us-ascii?Q?5vdE6axpJ80rGok2GIoMK2+Mk/wq1X/4gyB7g13tcpZyTox6c3lv+hQ2ahE4?=
 =?us-ascii?Q?HKKWYFkbM2pM4IQJi0Ya7VfgGa9tLBb+H45TTx0C82PfGb8siYRkjfjz1fwi?=
 =?us-ascii?Q?Vkb3wBXi5XB05Z4o8tRdfR+ZaIiEotihIGigRAhD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 130df9f6-2517-4bd2-ca32-08dd94e6914e
X-MS-Exchange-CrossTenant-AuthSource: LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 02:00:15.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cc95de1b-97f5-4f93-b4ba-fe68b852cf91
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN1mC0j0dDMKcAZEh1u60OVhu6dxJwbzUaz2/qF4X58Q2XvjhEWPFlz0Z0FwsdqVUqeJpzbv81kKCp+eTaa9Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2874
X-OriginatorOrg: magd.ox.ac.uk
X-NTG-DKIM-verify: pass 

Fix several spelling and grammatical mistakes in output messages from
the net selftests to improve readability.

Only the message strings for the test output have been modified. No
changes to the functional logic of the tests have been made.

Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
---
 .../testing/selftests/net/netfilter/conntrack_vrf.sh |  4 ++--
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py |  2 +-
 tools/testing/selftests/net/rps_default_mask.sh      | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_vrf.sh b/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
index e95ecb37c2b1..806d2bfbd6e7 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
@@ -236,9 +236,9 @@ EOF
 	ip netns exec "$ns1" ping -q -w 1 -c 1 "$DUMMYNET".2 > /dev/null
 
 	if ip netns exec "$ns0" nft list counter t fibcount | grep -q "packets 1"; then
-		echo "PASS: fib lookup returned exepected output interface"
+		echo "PASS: fib lookup returned expected output interface"
 	else
-		echo "FAIL: fib lookup did not return exepected output interface"
+		echo "FAIL: fib lookup did not return expected output interface"
 		ret=1
 		return
 	fi
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 8a0396bfaf99..b521e0dea506 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1877,7 +1877,7 @@ class OvsPacket(GenericNetlinkSocket):
                     elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
                         up.execute(msg)
                     else:
-                        print("Unkonwn cmd: %d" % msg["cmd"])
+                        print("Unknown cmd: %d" % msg["cmd"])
             except NetlinkError as ne:
                 raise ne
 
diff --git a/tools/testing/selftests/net/rps_default_mask.sh b/tools/testing/selftests/net/rps_default_mask.sh
index 4287a8529890..b200019b3c80 100755
--- a/tools/testing/selftests/net/rps_default_mask.sh
+++ b/tools/testing/selftests/net/rps_default_mask.sh
@@ -54,16 +54,16 @@ cleanup
 
 echo 1 > /proc/sys/net/core/rps_default_mask
 setup
-chk_rps "changing rps_default_mask dont affect existing devices" "" lo $INITIAL_RPS_DEFAULT_MASK
+chk_rps "changing rps_default_mask doesn't affect existing devices" "" lo $INITIAL_RPS_DEFAULT_MASK
 
 echo 3 > /proc/sys/net/core/rps_default_mask
-chk_rps "changing rps_default_mask dont affect existing netns" $NETNS lo 0
+chk_rps "changing rps_default_mask doesn't affect existing netns" $NETNS lo 0
 
 ip link add name $VETH type veth peer netns $NETNS name $VETH
 ip link set dev $VETH up
 ip -n $NETNS link set dev $VETH up
-chk_rps "changing rps_default_mask affect newly created devices" "" $VETH 3
-chk_rps "changing rps_default_mask don't affect newly child netns[II]" $NETNS $VETH 0
+chk_rps "changing rps_default_mask affects newly created devices" "" $VETH 3
+chk_rps "changing rps_default_mask doesn't affect newly child netns[II]" $NETNS $VETH 0
 ip link del dev $VETH
 ip netns del $NETNS
 
@@ -72,8 +72,8 @@ chk_rps "rps_default_mask is 0 by default in child netns" "$NETNS" lo 0
 
 ip netns exec $NETNS sysctl -qw net.core.rps_default_mask=1
 ip link add name $VETH type veth peer netns $NETNS name $VETH
-chk_rps "changing rps_default_mask in child ns don't affect the main one" "" lo $INITIAL_RPS_DEFAULT_MASK
+chk_rps "changing rps_default_mask in child ns doesn't affect the main one" "" lo $INITIAL_RPS_DEFAULT_MASK
 chk_rps "changing rps_default_mask in child ns affects new childns devices" $NETNS $VETH 1
-chk_rps "changing rps_default_mask in child ns don't affect existing devices" $NETNS lo 0
+chk_rps "changing rps_default_mask in child ns doesn't affect existing devices" $NETNS lo 0
 
 exit $ret
-- 
2.39.5


