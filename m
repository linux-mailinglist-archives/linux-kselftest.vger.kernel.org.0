Return-Path: <linux-kselftest+bounces-13880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C063934CCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 13:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C321C221A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6813AA39;
	Thu, 18 Jul 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="a+So2oUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2079.outbound.protection.outlook.com [40.107.117.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CD136E0E;
	Thu, 18 Jul 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303575; cv=fail; b=uhUP6H4bqX5LFHMkewORulWBfc7yLpq8/kRB10xLIOJm5aFd2SiixAz8N8EAwG10UowdUjnfRpEgh1kaqcP5/pDE690K8PSs3qsn/T1vTqJmmM0SVQ6DO/Gb/Y5PBKLjuh84XGQC1L15FeGp8tDeQtcdovDNEKzh7QkEMwnNolM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303575; c=relaxed/simple;
	bh=eHF6/4PpFNp4+Ytu2RUUYDEmdNd3PRPOAHvI6lEONzA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Cjhv5R51/GVItcQs4W9EitLzvMtv2Dddo/HXdWBpY9IU/IkDnTj/PH4aepY6XUytsm+nOsAD5rzZ9oWokZgI/0VxYCF+TFAQnwzupErkWArgKgy831vbXEA/hPwewU3yypUj/hoEmmqcZ0n+M3x1CkhBBu5RJG+l6CUKpRsVld4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=a+So2oUq; arc=fail smtp.client-ip=40.107.117.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqVMGxLSJJYrLQvh4H6oKRobDZrXksWhF7uVcrz/5Ci7wnEljljpy+hjrdoiFD62lDOYAPbRV0MsjSZ/TsiVJxYClNOWgcB8I2q/WQM+V21o/oxmFBeHVihHbn9RbTc5f3c6tTvqv2HO9Q5JxfZysgRJ3Ogk1eWf7Zz8CHmUsn1S3oJldVvccRuqFkJiTVkQjEXqYtHTHrCOhxFIpMGB11w8anuS34ZDoU5VzAqhDnySbNvPt/erZZaG3zt62hKnvSd7eS/BSKqNyd9gQqUQzkf91TwXLtZ8ORUlBTz743ZWEAUQZLWzmDekWD5HnjQTZTzNVKPh/+T31nBbBBiybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd0D1j0pvwiapwFT7O2WVjM0l0tN3Qkme4DfvHEl/X8=;
 b=VA0NXHFEAJStqizIPejUaYaGlAby61mK/L562ePrUyun6LyEf0LGpviNyh8OJgAjdzM7lAbqBv4/BXHBfmbs9EqtxqwH+iE22JPnR6wiHfo2LWNm49FcnwfT+mj/4wd6W2DdOBlZyD/YLh1WU6Khbx30rbig5Dxwa+lviciFkwAZ2xLXDhXb+7+HmvsTnuo/40O8c/SAE1Bo81t1aUL19EnWXV1lAxXT2+wdlimBNst0vSncKVZ1oStM/y/RMkFtKSpZC1EL1JLHZqSs6V1jaMruM+L9NqpAzDhqIZAkpJJPI99Ww7ekW8Jd7o0aIzBPToqDa5qhYO7wSF25yosuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd0D1j0pvwiapwFT7O2WVjM0l0tN3Qkme4DfvHEl/X8=;
 b=a+So2oUqdSCk1Sn9N+A8+epH6DJPw63ZWX1sTq7dLTlVppnCuU/A/STRVmlBIlBh0M989pyddBnCQe5va4aWWmNtrhuY4rYtu5ZOqWT7u6RSzsbHW4tjdrbyN3yymxaD2xAQQK77LLBX5gJ2axBfZSCswVX++KafX8B1dveMG2zwdFKjZ/mHHbf9adkSRcpAL355Gl3TccuUWbcMs0TAUYoy5k28DjZYOu4kJ/Qvc90pZjTNU22UrXTO5lYJvTl135k1jaPa1+Thw88QQe4H2w9/pJ/Oackr8cKbz+I6EwM5yK7UeN98BBdumqFj/GpUjC9S/7njWDz19Md/u4Z0hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 11:52:50 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 11:52:50 +0000
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
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Lin Yikai <yikai.lin@vivo.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH bpf-next v1 0/3] add bpf_file_d_path helper and selftests
Date: Thu, 18 Jul 2024 19:51:42 +0800
Message-Id: <20240718115153.1967859-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEYPR06MB5913.apcprd06.prod.outlook.com
 (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|TYUPR06MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a30d8fe-66d1-4fa4-efde-08dca7202604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2yipnE34Bd9KtNQC2Uj5hjX/iMLqrFglAqSULgr0mXacIgmosc4z+jfj18d?=
 =?us-ascii?Q?2FH0H5oyjJwpOH3nKK0P6BaIPIwiyzKHH5EB93ZElDFaciwDAI5jezFAruNa?=
 =?us-ascii?Q?KVXiaB68gIrhnhDeWTy/QAc5PMkExm6iul48/yTe7dTcVcEq+mskKdyGtJ6j?=
 =?us-ascii?Q?qAWDaCt3S0nfkr2txdzWxzysx6DA3tJMrSiX4yAI/zbyO6gidR2UDCFS3Guu?=
 =?us-ascii?Q?xUle/rAD0r6sIkEZ9flk1nw6BEjrpzz6DEhlSZ1ETx/yTl1U3Y/2W40BNsaF?=
 =?us-ascii?Q?aHWWzj/uvw2Cw8+TvYjHIxuLRbBCmd4dZvK7O9/t8GPm6KvssB5Q19VlHPLX?=
 =?us-ascii?Q?cyLM/evGoyU2zpM/0bXPXXpYng9+FXMnYB+zGDVtuxSxdj6tLYILNszjV2ri?=
 =?us-ascii?Q?D2QxL1ay0FCBb56t1dZQ3SCU8fH5/B7IGGR/b+gRTXJaa1gmcYUYKPGEVP5R?=
 =?us-ascii?Q?SbT9vLuJf2UA/7wxRUi9IEzueJOv4OFQknfddjrFXtFD32nqeuzrYC/NeNZ7?=
 =?us-ascii?Q?Oprh1Y7fXuP3RU8QlDt0L4R/Ls4UTAHlQpMZZmiAHs6Qwb2T/Ku8uT4zyFv7?=
 =?us-ascii?Q?pUT22BkNu6VszXr6IUMu7ypDjGi5ll49rN0h7GDWuPoqgyF5lYCX02p9wkM3?=
 =?us-ascii?Q?gIkXPVTxCCuL1v9vN6Q/7gHQfxGYZJzv6G9ihIwxZC8oqLZb9F+QkqubaNF9?=
 =?us-ascii?Q?pl6MYJAxIcEWKk8Eexya7cbq4A/tn1aK2amSoLgRDtgG3xozrs0EAhUUDtTr?=
 =?us-ascii?Q?ix38+h/hYrsqT4A8kBjwS9kTX3esecOprdU/pN+8vVrUIHV1hzvtAHqUMOB0?=
 =?us-ascii?Q?Cx2FCjJGqqcki9xmIWLF08jI4VmF1oxdw0YUWLUqLI8GJP7FbRzoamP2zkSQ?=
 =?us-ascii?Q?yNZNKiGUflldUwYUMn2+nZ0v2cA2LyUIYV8yOvWAFmWva2kLBsYgIxd8rTgZ?=
 =?us-ascii?Q?w1uOv/G6V14ayTWB8SlhxfC6Hraw8XU7GceelWpZzs877ol9Ip3WnEP2kha3?=
 =?us-ascii?Q?+CAhyGz0IgsPPhj/SceYDIrL7lA0Z96+XNtB72AAYbxlKLAbR2gK+9tHgv5c?=
 =?us-ascii?Q?/68VMZaE+4hQR5q5oy3yGNqdwuEnmWkr22rVaJLbnEgJTTNh7oF+XRqgGClT?=
 =?us-ascii?Q?KE4X9tyh2sBjw4bNrJ46XD7oHla9Fv+M6auinPfNIN7GicY5Jl22YcCienOB?=
 =?us-ascii?Q?tSsRuknSriIS0pdoNU2VeXMn0L77B9FaTzjeArI2De1lImzCFAnYgXERB6N6?=
 =?us-ascii?Q?S6yWqNAiMfs0TnNeTMTTrct68snFqFIk6sDtq3FrUOlBORaISmQKh+GCkypt?=
 =?us-ascii?Q?xeXg/wwIBgRbA+JDCnUqUT29yegpezhFeTtTg7VMc1QHwpUqV9UG+vxwvEpC?=
 =?us-ascii?Q?TLV8DJnIilr9OnQ5tI4TQr3cWE24xTlz0Nz7d2Y/dXVs+gBtzgl3UIv1sR0O?=
 =?us-ascii?Q?sm6eGrxNHkc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4n1epBWuxDiZKLI1amL6OmMQvMvmkoN5Z0YNh9dbnOd4znpqgyYHmZiVy1BL?=
 =?us-ascii?Q?xgEHm44cCBZhK7Jp0Y3aAEPNepta36m1clHBSEaIIe8skNDYl3/MEF343kJ4?=
 =?us-ascii?Q?U0mgiTCIMCzIspg8J5lfi9PC+6Jv6y+e8tqi1WLEMdfeEh5RRF+1uUtM/4WY?=
 =?us-ascii?Q?94bp8ZwlGo20H8EkmTHVG4PLYUBtVAXywWaUDq7cUceKn48PUWVy9f0zRnog?=
 =?us-ascii?Q?z7jkgrkiV7Ffi3kPubajkmPwl7ud1yHmEd07KvyT2gpEfXlj95BQLhhDo0TO?=
 =?us-ascii?Q?16oBqHZqEzr1WC2LAb7UeF8EvghJ6xObL8tWtroH5x1nrpzKZLnUGJ+6FBzD?=
 =?us-ascii?Q?E/CL6BMFFiZuYMP0tstCVO4fT1k1fxdgOp1dnzLmMH+U5T9hNOQAdsxs0JGK?=
 =?us-ascii?Q?Y8IK0pOny7oAYNAvdlaScAWSjg+8JFuAG4m3hEL06oM8jDK15cgMdw9luZ0n?=
 =?us-ascii?Q?y7/Y1MwM1vhllwScLf0//xcj13Q82q3lEmXyfIS+9ucbJ2At/z7IR0avUZs9?=
 =?us-ascii?Q?JZfmMegmf9Gb+73nYiLejm08SS9jL/4ENBqsBWEQLPbTCzpE3wgQr0Wrt2gJ?=
 =?us-ascii?Q?tv7kyxTkX/euS6+MeytcYKKt+9I9mUTG13XmrSIFEnMHEjVOTj+zJxdN9rk2?=
 =?us-ascii?Q?bbZ3iTCRMQxaK7B/q07sUSJsd/vm3GQMXeq0MW9QJ+GtSvLD+fhZL6M9wKmN?=
 =?us-ascii?Q?Y8XYO/e4vuMkMYLh2N2wwYOEocY2Lh0YyjXdPfG/O2AV5ygbJzYsW/ux3DKG?=
 =?us-ascii?Q?86soLSKRwsCfvVl/KedRBSefn2fUif3BnugXw+OLwno/xNCNJdmn4j7mcUz/?=
 =?us-ascii?Q?Ip1mvvrxKZsVhtLNSpuN6IBqiwEfXP9fO5+yK8I/dkRQ5l65gRN1M6o+s8hX?=
 =?us-ascii?Q?VucYrdgyI5cH7YwYfNMF0WWyy8TxTAQpL8pD5xfY54J8fYRVTaPD6Lr6YIB5?=
 =?us-ascii?Q?fLkdQ/08/4dJL79Xzs142xS/6c/L56vZ2JEuGFFieUy3+1KRf6KsIS0Z+UpG?=
 =?us-ascii?Q?00Fpw2Qc9Q5Pcvi9h7dUbbEQD65YiHBW1SZ8ryXZZQMCHuX2Sq4O6vjJddzU?=
 =?us-ascii?Q?Qg3QVNBFtLJu8q6+MXqc7BJWVScPXIWuN1l3OJs8mFdQIOVZ8Wu8QAxW1tHu?=
 =?us-ascii?Q?gPX0v1FjpAB6JUfpOma+G+vHAkZnts+t9aEMuSyNEVzUIYZsMScs2fy3P9DI?=
 =?us-ascii?Q?nxl2V8PlvYq8HLNb4sYC19v03nqZrvY4o9I9vZAPAqcAf+xc2A//B/qjJfe/?=
 =?us-ascii?Q?h6HyoSTuB1PjEs6w6NyxEWPefSpNjiGvtCnbQJoTpthta/5MMSOYEkou4Fsa?=
 =?us-ascii?Q?e2QsVrvxHMKzsOJronGK47VyCyShp/weTJx+1IwCN2qlUeLoLXsaj7ZUgCvu?=
 =?us-ascii?Q?cMBq4cs1ZAR77IVPT0f86PU0MQEImgWttvpKQ/kTNHA+dd6Z8iKOWlDfQLzJ?=
 =?us-ascii?Q?S+86vK5qXMZIXxvd7lzKKUOYE0UHs3aEVt80Or6weY2rIug0TyJiTQ3NZKK6?=
 =?us-ascii?Q?QUD6ey4n1WdOPqtOjZq9/coiySaft99DyYn1aZ47sW5FbF1WUdv6hR/J4Wwf?=
 =?us-ascii?Q?NhKoNe+uP9NaCEfqG/lFPxW25/UkoW3Rt2Td+Gf9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a30d8fe-66d1-4fa4-efde-08dca7202604
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 11:52:50.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Po2sKaPW6B0gc3398SurCAfbPatU1LVV3BtSyP0xQc1RYAKwbDu3s6wUjAeSC7xULJV4FvH1TqnLRBHyuNFVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6219

v1:
 - patch 2:
   - [1/2] add bpf_file_d_path helper
   - [2/2] add selftest to it

Hi, we are looking to add the "bpf_file_d_path" helper, 
used to retrieve the path from a struct file object.
	bpf_file_d_path(void *file, char *dst, u32 size);
	
It's worth noting that the "file" parameter is defined as "void*" type.

* Our problems *
Previously, we encountered issues 
on some user-space operating systems(OS):

1.Difficulty using vmlinux.h
(1) The OS lacks support for bpftool.
We can not use:
"bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h".
Bpftool need a separate complex cross-compilation environment to build.

(2) Many duplicate definitions between OS and vmlinux.h.

(3) The vmlinux.h size is large (2.8MB on arm64/Android), 
causing increased ebpf prog size and user space consumption.

2.The "struct file" has many internal variables and definitions,
and maybe change along with Linux version iterations,
making it hard to copy it to OS.


* Benefits of this commit *
1.There is no need to include vmlinux.h or redefine "struct file".

For example, with bpf on kprobe, 
we can directly pass param "(void*)PT_REGS_PARM1(pt_regs)"
to "bpf_file_d_path" helper in order to retrieve the path.


Appreciate your review and assistance. Thank you.
Yikai


Lin Yikai (2):
  bpf: Add bpf_file_d_path helper
  selftests/bpf:Adding test for bpf_file_d_path helper

 include/uapi/linux/bpf.h                      |  20 +++
 kernel/trace/bpf_trace.c                      |  34 ++++++
 tools/include/uapi/linux/bpf.h                |  20 +++
 .../selftests/bpf/prog_tests/file_d_path.c    | 115 ++++++++++++++++++
 .../selftests/bpf/progs/test_file_d_path.c    |  32 +++++
 5 files changed, 221 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_d_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_file_d_path.c

-- 
2.34.1


