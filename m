Return-Path: <linux-kselftest+bounces-16677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558F896445C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089F7280F98
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F119309C;
	Thu, 29 Aug 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kK8gqYuF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2067.outbound.protection.outlook.com [40.107.255.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144C191484;
	Thu, 29 Aug 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934377; cv=fail; b=VugqxbwE2Hqf0bf9Ts1Wbv+A4E7IKIZ+FROAyr2bkmYU79JtqET7DCbUQk29NmEhSsSWd1jAo+gd7gNtbi3tIl4fuEE6KfiyMoGKPFQ5wvs+i4zsMeFAEMLulYetOY+sxCuQyTLW8nS4oNCvvvQWXQ4ZX7a4qJZMqXAlClT3+iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934377; c=relaxed/simple;
	bh=fJmljRKixWFxV7kzmKolJUJrLHC1Zl8QjF8upD0sc00=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GPXmROuzD79RfNovJ3VNHYhZIBe0+f+qkgT0XejMeMgHQGUpFgzXgFe8dt8NX7GhKtUuEoREjM0E8SyOXwL635Hw9aXnG/Omt9V3uJaTIjBX28W0SzxVYzjACjbvSzRfcHVErRknKGeJdAGPL5iFiGYKA+014UyEX8hFaT7Gy/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kK8gqYuF; arc=fail smtp.client-ip=40.107.255.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5c5/oJiliCVcitwA8+Cvd7yV7hrVjh7LnG2PlwQ9b3uBz4xZOjPlNq2FRyqkPu1JWtJVETMi6FwEm0DkKge45pG8oRnN5H24OhhWAJgcPkYCqCJWrOnthj1q2/a1JY5ZCeL8sYZKW3GKCV45foo+rRIpr0X8N3zdjrnG+iYAySt3xh6QSJAo5+Q5WPEbPHtSHAcKx5LGlwpdd5ToSgimie4z+egiGFdItuzALqQYw8yUzFK08FyXo3FnmnrDUrzhY8DlPIt5ImR4UCzd+T7iCtcqBzb11xs3ZH51ey2gUFiraJT4uceH3UjtlcvqE3mdknLnr1ECkSJBFne+2APkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuG4Pu0GMPeBgFjEzUhrvDK1Gc2PlbYPSkEB4Xwg2FY=;
 b=r3rTw52Viumi7Z8MoHANeoWzbECIgLJbnRJfXpIuXNc3qQD7UmuabERB3uOqd7z/H461UaStEFgmUHErZceGAr7FeFT8YEIrnqFsBVdarzpcxcEhkrASUxU3HtR5em2i2IdbFnGM1pSotHw6AqYAnSYEq1PNo4U3dSzFPatKSIOMXDd/Fz8/YsG07XjtNCBmDbBiLNk1wE+zBzq+hDzwz9wEeR/uL2BQSCITfx+grFNQADfkEpfxRk/vYnXIz+yw40op9b3tZGwHQ9tZgaLWLA7iyGmNw52dSwV4Hx7SvULfazXud+i86cugBeRRj/1NRApvZI1TGEswGMrfGLtYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuG4Pu0GMPeBgFjEzUhrvDK1Gc2PlbYPSkEB4Xwg2FY=;
 b=kK8gqYuFE1Nx/EcOA8BccTddZdRhsG7r3lutzTY77mV8vNf8BjZORinYr843uLuvt722IACgb8KiZ27xjbBwyIa2aqeY2iXaVNdOYFUYILa5N2eBxfb9+cCq2hHAAp3M1GX2/k0Z6YysKQDpETAf4BFRYVjCxAgd+s7AmDkpeLEXt+uSQMIGfhIPGnUXOqCk0lLHqgAd7namJryzZ7LLXwpkQ/0w/JjnjgFLj6uBzQo3WGnoadIUg+NJKjpsFP+Gx6LZaQtgFquaJNHQSRB9hTQnkomEV7x1PuhWkXjgW+j8N17ajE8DHRkGaOUAGExEgbuJlWzniECW7w8TvaBbjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by SEZPR06MB7078.apcprd06.prod.outlook.com (2603:1096:101:1f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 12:26:12 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 12:26:12 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	yikai.lin@vivo.com
Subject: [PATCH bpf-next V1] enable virtFS(9p virtio) for sharing directory on VM to optimize debugging
Date: Thu, 29 Aug 2024 20:25:40 +0800
Message-Id: <20240829122540.2206118-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To SEYPR06MB5913.apcprd06.prod.outlook.com
 (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|SEZPR06MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 05daab0b-8f90-409e-c063-08dcc825c4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/FiuX06OyErSBAI6b3E+vEmnyBrvS+MIgcWPWWXh5MrIqtDK+2AmeIdICzI8?=
 =?us-ascii?Q?j2IhDPOg6i17hw2RA8qRJdbb4EEeHqu6lKfQb4KWT+GOGB+LTwcqTodMvakE?=
 =?us-ascii?Q?u7eBLEfhviy43Yv/xbSrf6M9Yqx+7Rsfq0pPWy9lVFiqDpgKi1dzZAtEOjp1?=
 =?us-ascii?Q?ER/RVLtlYbJwNWbLWnXGmnTLp8bJ6Y7L7Eg67ANQ9V4TzIj1fEOtq1pKJF0c?=
 =?us-ascii?Q?lfxx21GA9MILqPJ/rMEKSmsOcwESOILav2Tfh7++C7POlz3iDXuliojD+VI0?=
 =?us-ascii?Q?+lXr48koC8NUJP4Uv/Hl0zVL/XAt/Ix7OjA4H5PFX1YJ/uoxMQcATF3cW6W9?=
 =?us-ascii?Q?eFv5nm6RK/DjwaNYknvsbbtyuP4he39zRcZlGoWePqlqtPEwCq/lqV0+R7fR?=
 =?us-ascii?Q?BIGIyQFvgVvb1AO+dk9oDRcQ5pO6BXQSMtxGU9UsMxczMOlsuJsoPVPEF80z?=
 =?us-ascii?Q?K7/IvsyCVb/KPrvqNyLUSt+VFgA/KEwDOD7gleXTbbH15Q5llDLXmmsVDpHa?=
 =?us-ascii?Q?CnSKEHHUfKAKJ11JbGS3KQdmiIsRmy8qO6Wkqe717o8Ca2YmiwDyO+iR8Z+D?=
 =?us-ascii?Q?uW2b/Kl6sQ74kuDqxpawppRkXJmwigrTh1CBOlXpXWcFTRkyO/92Oph1R3oG?=
 =?us-ascii?Q?ib1wslLNl3fl/7ZrjfqI2QEa0XsO4kkZ5lip0mJcNVX0Smpf13U1AOHww+i5?=
 =?us-ascii?Q?jAP036NMwzqxWmSDmhV7NFubGjmJ5lY5HuGVtac2TmtJzF0qhNgbk8QmLyfJ?=
 =?us-ascii?Q?ZhJzbKlxEQq1TwKc2GdOZm9LoDDFVPHi7WwXN7tf2rJdneTT2+E5rHvJm/8v?=
 =?us-ascii?Q?7dKsce0WBEakkYUAJVpe+6EpmBcxFWtJRZQjY0yxuNi7ZchN+Gd1inLyk0Yz?=
 =?us-ascii?Q?RXcP3+e9b/+630o2w11O/WJ2qSXkrPTu9xvoFMhTvtcZKofrcBh1LGDOE7wv?=
 =?us-ascii?Q?P77BuY6KcPg4+m4l1mdtxLHaYT4i4wDDAfwyJPyzoHTpRu222pGcKBkJKjus?=
 =?us-ascii?Q?B5U7i7bL01D8khrHfh3B8H+xm1vtQ1WKVkEgFRMGE70C0Vl6Vau4LTDUoBXT?=
 =?us-ascii?Q?44Pm3iSzXCkbgtjj/1l4H7gOwYOFM9g/QcLwKffStO6PHOTsg1MXNXnjJx6s?=
 =?us-ascii?Q?JGEhO7xGCMZnpdiZ49+0dLR55vjU6EC2pE3imVlvNn+kUZmJ79l4fONlcnb5?=
 =?us-ascii?Q?oCSB/xWm/XuFyZwIv7dzyO9L/6N/0N/k0Qj2X6wGjbD+jw19E4LQrV2Vo+iP?=
 =?us-ascii?Q?y6EiWpmuGf31L9PixkgB2kIhMNggh7Pt3QCtilU0ykZsaqNYqXQsrcNqlqTZ?=
 =?us-ascii?Q?v43AQPJ56jceGaRDAPm/2ZffMtIuxaXCHZ5SiJKsEhPdJO2NLC3Od/gm27Ej?=
 =?us-ascii?Q?WsCEZwBr2KsC/kt3eH8Yt6QDiQOmhunFE72CuYpQFrObcShKm4QU72wDyRA6?=
 =?us-ascii?Q?EHHjOHr+sc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fdk+EmuQG7w6ODnUrEIQGS4LoHj+OUSgceQFeQxABfDDDcvGcOWDA8OpyFf5?=
 =?us-ascii?Q?93Ak9YvzRs72wlBnXWtcEXEusY1Zru/1VTMFt8wQYuE0MI+v36Gqqdihx0Bu?=
 =?us-ascii?Q?mPGiyboo8sAm1ZjxTd2mgXFLd2MhBAiehy17aC6wdJzhh4AUeiDPXhrQIDYR?=
 =?us-ascii?Q?VZj19GhjchUlPvp2oHDxX0lSuk7pn/Dwz6g6Iwu9K0nhvvb0IhDz+SFKSNTj?=
 =?us-ascii?Q?oS1UXlOXc+NDlv8UERcxYGKT9PerKSFaFt9a9YtW0dCzvzsHI+/hxd7FL7u/?=
 =?us-ascii?Q?F5G27MIc9MBTnqrgOA7By/IVcXa+xNkP+YoVHjwzRkuBMwYdicxbxyzN/iq6?=
 =?us-ascii?Q?ZPUi3PtSBiRjwb9y1VjNlwTC+U8dkn1h8d+ZQilJwEx7ROfOGku3dOUiErJB?=
 =?us-ascii?Q?ajRrFxWQgOK4uDGcs4xs7p32++tGyQTxoh+epCso9Bj5w7i1WqWxzC0H7diO?=
 =?us-ascii?Q?fjjjMsGHpk9T2ltmc2CNJ/9tbIgnZecKPcVYSvFjdQTqvGWHRRnO6HogLDPw?=
 =?us-ascii?Q?LDXiLILKnBBfKIILobT2FDHhKSMnLVrDWzVUGUze1iUK761npFhamKvXPUjI?=
 =?us-ascii?Q?bZweLe1A5asoeZjQyIXVWYD3quArH5/zQP0jTKnsJlEOgub3uWbBHAKqk2Qo?=
 =?us-ascii?Q?7+PXj4vxbDxXd6KMO1YWreuqneQoimxoGmEfLdQ3GWf5EC9cQ2Vd4XG7+5Zn?=
 =?us-ascii?Q?o3j86AXRkW1Tz3mFxAGN2iCYV202aUMHs79cNpXjPG+BEI4KkqhasCpqYmbe?=
 =?us-ascii?Q?eB48NAEaogJNItzrk8GHk8wXgt13hmxoR+M7mW7NoIEIDU2YlFHMMyCP57YM?=
 =?us-ascii?Q?HG0EnOoxwBPem3c37A94VfuWQWN3ddSIP5KxCMpt94H0tND8ga/cU8yvH46o?=
 =?us-ascii?Q?6eroFuyKryKhe/TUnBsD+vAYG84OP3S2tTYR3yXC3WBDRncL2VoBipuxqMjU?=
 =?us-ascii?Q?tUBlal21aE7nTkeVAHnHvDCUkwXs8rfl7xIFdWf3W6hupkIolS5seutGZP8d?=
 =?us-ascii?Q?1FwbyLdQdmvv+BxtZ4eL3Svo4MFFdjXo7uCnJEL3kgtK5Qz6SmkmZyqE4iuf?=
 =?us-ascii?Q?wlFqAxYKSpIIANnAu7LYH7PP3Fivb60JoVUUZguFBV+/r/HX8Oe2C5MLy4C8?=
 =?us-ascii?Q?B+6IP8nqPWzZlx/QOpna7koannn292N4TekEkCsi0YXtibmNBbC52VX9liAP?=
 =?us-ascii?Q?9XR43XvnKMpAKaZ8QXqLGOfZJdmXghxAN7zOqdoJ+bIpT+F7vJh402lUfK74?=
 =?us-ascii?Q?1EyZrf4mNxCpDA8Uy/nEycntxwJPt+1WXzbTuqosv+3/dp5lUWAQEaAzzEIW?=
 =?us-ascii?Q?uhBNp/lqcfXNYKU3ohu+R51C+VLjuDq0bwbq3Pb6tskJIWqtd8wPEJp1faWn?=
 =?us-ascii?Q?k5u7FqsCUmMxJMFI4UtxFguYqowP799m7ou4QQk61DWZwtSiu6lR5iGV/Kl/?=
 =?us-ascii?Q?1BjTlgktS7xKta8S2UJ9dcIuGb9FXmgU0mZWc3RTQoaDhl2YpwnthjAnY6vw?=
 =?us-ascii?Q?ucZwfJj6Z8r1V0cxSHcqipNCZXhQzpBjtcjbsBR9u4Xq1Xt/Zu6b9gQ5e9LG?=
 =?us-ascii?Q?AGrC2/g0gmHvPkWLefqfWV+bfdPt46dDjcDdPBVz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05daab0b-8f90-409e-c063-08dcc825c4e8
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:26:12.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: refxJAK+bl7DIrPmc3oa3Qa12CxaZIryYQze1DoGsyvI+Kz1tDRuyujV0fYPVP2s0xvpimH5iEJaJGjSFt7O7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7078

[Problem]
Sometimes, we have only x86_64 server for compiling BPF with target ARCH of arm64.
Therefore, the only way to debug bpf is using cross-compile and qemu.

Unfortunately, debugging online on VM is very inconvenient, when test_progs fails.
Such as:
1. We are unable to directly replace old test object
and still need to quit VM and restart, which consumes valuable time.
2. We also want to share other tools or binaries online for execution on the VM,
which is not supported by VM.

[Optimization]
I noitce that CONFIG_9P_FS is enabled in "config.vm",
so virtFS (9p virtio) is available on VM.

To achieve it, I add a new init file on qemu,
which only exists when '-v' option is appended.
  root@(none):/# cat /etc/rcS.d/S20-testDebug
  #!/bin/sh
  set -x
  rm -rf /mnt/shared
  mkdir -p /mnt/shared
  /bin/mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt/shared

[Usage]
Append the option '-v' to enable it.
For instance:
  LDLIBS=-static ./vmtest.sh -v -s -- ./test_progs -t d_path

This will share the directory
between VM's "/mnt/shared" with host's *${OUTPUT_DIR}/${MOUNT_DIR}/shared*.

On host:
  $ mv ./test_progs ~/workplace/bpf/arm64/.bpf_selftests/mnt/shared/
On VM(you can directly move it into /root/bpf):
  root@(none):/# ls /mnt/shared/
 test_progs


Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 75 ++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index c7461ed496ab..82afadde50da 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -70,10 +70,15 @@ LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
 EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
 
+DEBUG_CMD_INIT=""
+DEBUG_FILE_INIT="S20-testDebug"
+QEMU_FLAG_VIRTFS=""
+
+
 usage()
 {
 	cat <<EOF
-Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
+Usage: $0 [-i] [-s] [-v] [-d <output_dir>] -- [<command>]
 
 <command> is the command you would normally run when you are in
 tools/testing/selftests/bpf. e.g:
@@ -101,6 +106,8 @@ Options:
 	-s)		Instead of powering off the VM, start an interactive
 			shell. If <command> is specified, the shell runs after
 			the command finishes executing
+	-v)		enable virtFS (9p virtio) for sharing directory
+			of "/mnt/shared" on the VM
 EOF
 }
 
@@ -275,6 +282,7 @@ EOF
 		-serial mon:stdio \
 		"${QEMU_FLAGS[@]}" \
 		-enable-kvm \
+		${QEMU_FLAG_VIRTFS} \
 		-m 4G \
 		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
 		-kernel "${kernel_bzimage}" \
@@ -354,6 +362,60 @@ catch()
 	exit ${exit_code}
 }
 
+update_debug_init()
+{
+	#You can do something else just for debuging on qemu.
+	#The init script will be reset every time before vm running on host,
+	#and be executed on qemu before test_progs.
+	local init_script_dir="${OUTPUT_DIR}/${MOUNT_DIR}/etc/rcS.d"
+	local init_script_file="${init_script_dir}/${DEBUG_FILE_INIT}"
+
+	mount_image
+	if [[ "${DEBUG_CMD_INIT}" == "" ]]; then
+		sudo rm -rf ${init_script_file}
+		unmount_image
+		return
+	fi
+
+	if [[ ! -d "${init_script_dir}" ]]; then
+		cat <<EOF
+Could not find ${init_script_dir} in the mounted image.
+This likely indicates a bad or not default rootfs image,
+You need to change debug init manually
+according to the actual situation of the rootfs image.
+EOF
+		unmount_image
+		exit 1
+	fi
+
+	sudo bash -c "cat > ${init_script_file}" <<EOF
+#!/bin/sh
+set -x
+${DEBUG_CMD_INIT}
+EOF
+	sudo chmod 755 "${init_script_file}"
+	unmount_image
+}
+
+#Establish shared dir access by 9p virtfs
+#between "/mnt/shared" on qemu with *${OUTPUT_DIR}/${MOUNT_DIR}/shared* on local host.
+debug_by_virtfs_shared()
+{
+	local qemu_shared_dir="/mnt/shared"
+	local host_shared_dir="${OUTPUT_DIR}/${MOUNT_DIR}/shared"
+
+	#append virtfs shared flag for qemu
+	local flag="-virtfs local,mount_tag=host0,security_model=passthrough,id=host0,path=${host_shared_dir}"
+	mkdir -p "${host_shared_dir}"
+	QEMU_FLAG_VIRTFS="${QEMU_FLAG_VIRTFS} ${flag}"
+
+	#append mount cmd into init
+	DEBUG_CMD_INIT="${DEBUG_CMD_INIT}\
+rm -rf ${qemu_shared_dir}
+mkdir -p ${qemu_shared_dir}
+/bin/mount -t 9p -o trans=virtio,version=9p2000.L host0 ${qemu_shared_dir}"
+}
+
 main()
 {
 	local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
@@ -365,8 +427,9 @@ main()
 	local update_image="no"
 	local exit_command="poweroff -f"
 	local debug_shell="no"
+	local enable_virtfs_shared="no"
 
-	while getopts ':hskid:j:' opt; do
+	while getopts ':vhskid:j:' opt; do
 		case ${opt} in
 		i)
 			update_image="yes"
@@ -382,6 +445,9 @@ main()
 			debug_shell="yes"
 			exit_command="bash"
 			;;
+		v)
+			enable_virtfs_shared="yes"
+			;;
 		h)
 			usage
 			exit 0
@@ -449,6 +515,11 @@ main()
 		create_vm_image
 	fi
 
+	if [[ "${enable_virtfs_shared}" == "yes" ]]; then
+		debug_by_virtfs_shared
+	fi
+	update_debug_init
+
 	update_selftests "${kernel_checkout}" "${make_command}"
 	update_init_script "${command}" "${exit_command}"
 	run_vm "${kernel_bzimage}"
-- 
2.34.1


