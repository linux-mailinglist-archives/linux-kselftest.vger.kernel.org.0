Return-Path: <linux-kselftest+bounces-48042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB99CED299
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88E3D30047B6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93635240611;
	Thu,  1 Jan 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBH65+YW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5BA930;
	Thu,  1 Jan 2026 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285272; cv=fail; b=bmOzTKmykI9uix9xvzhkdGZLJcZd2cSRN0jUm4hAfo7CgYlmM5uvWom+J6KgssWQ7aOKTlHIp7yxmkoTf0Jm8XK0WbANm+0XI5CYqGzL0lOlgXzAppQC9mPI4jiMJK/h03hpdY9m3oAZpODBdB7DodERlSlRtxD4xgZenBvDDPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285272; c=relaxed/simple;
	bh=M9KMZ8l+E4tP8WdxiSYNgNx/zmPuWFq/nAhJtA6mJHg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k9MIBcpSSSs7ok9Uie120XUJvNyMF7aJ9JFHihXXAn2RGXsb/uOaZJhl1XpisfAD/ocapQmL99cWxjiVRQRCuplMaqGjvHPDJUy2KqMIflDliaQ9Nae/GzuAyoQMTErWBgFebWHX+r0Xz0k5zA+PCXmnZlhK/AgrdJ9kr9LCzKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBH65+YW; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6RCSunYdOqLPvdY/9fGz5dDech9ub3lTm+67tXm2F+RcxxH4SvcySqJr3/t8/QWLSJlWeZVGxuXl+2ObJWEGbCvDpb/pOpbORxz2+kySerm2hrgduRi/n+Ox/r8uSV7KhSw293t6y0NYU5kZhkIBqMM/nW7Heq3bb80eA4gUck5sbD9uDcTk7DWuJhfV/iPYsU/KMFik+5B0nnRmovKmHweLLAeHVei1nDjlrlWQdRJS+L8X3vWyznvtbG1POuB41hIk/HLvK4Iuyn2qjENWFb2pyMpUH8q42b0rJdnXKR0RJorcJs7l7eaFvsbzvuiaj+nQ1QtZNJ0qHzWcd1Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypTtMiQRTHAxZL8xq+XYYmcnwYWSsb2IHiqViS0OqLk=;
 b=xM06Hzq1Tn42fD1BhAwLwpYG4Yl/qPmfoaXhLZpu7giaMHK2gYifn85aT7VZfZMLIHpxks3AbSJ6SH9DyTvuzORC1DaS/56Ip1xdjBjfl0eWeA1Ys0RQp5m/woOCcSP/ZZtxAgIjl0byfXfvtRVMZWJDCj6jlv1HE1b7UqSDc5WNzzv2sEWa4EyHI/+Wl75oc43BBkyxBlywKAHFhKuNy492A8jKoI+yS9LdDxDA0AO0FmwSv8e6TXzoCWYrI5EWJqlwxtbi0T9KAHCPpQ3L01RbDGuhICcJFwyXeDE13mdVBIyMkXbV33oRnWkPacfch3MUkKoAB2qWprGGhXKwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypTtMiQRTHAxZL8xq+XYYmcnwYWSsb2IHiqViS0OqLk=;
 b=tBH65+YWjEdW4GQEZgbKflLqy/aS5AKqgcpE5MfIQNst6WU3Q2DV9J8NK5E6UDJuKdxVCtzi1yetBGPVeNej+vRKm+ed8aPUkKAkxT70O54EY6+iP3ZqC8JEUzfH6Wyd1qhQO+lTOxniG6qYe9YC/mg2KnbWgp3gA4eoITfBYZr80W6hC9LS1GDPdD41I0/WCVdMGTTakMHaulKAs4IUGm0I2eAl95kKPCz+IB+af5LPEW/xl92EA9hr4AO0ylMW+oXNSBUgavT1AUPtnb8oX0e8mzKDwbDvoQl56lEd+R7qk/xYUrhaVz1rHJAtpAoGqQwJudv2pZdv+JL0Oq4UAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:28 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:28 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next 0/8] RCU updates from me for next merge window
Date: Thu,  1 Jan 2026 11:34:09 -0500
Message-Id: <20260101163417.1065705-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e50fc0f-1cca-4d0d-a529-08de4953a204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVGi0GDgUaWfb/TuJeI3KFesTRot3//M7dHWO2KIxI0AmXIjVoNg4cMEBlqp?=
 =?us-ascii?Q?f6LMgj3aP+TXERjoeiUvHe4yMSVjcnkr/TC62s5KXFpgxE3b+Dkjr4SbfllN?=
 =?us-ascii?Q?4suucwuEyh4cmocU1kUzit2CXbbZkllWrOje84mf7dWF/Y4G64C7+EtSO+1y?=
 =?us-ascii?Q?IuJsVEK9G4kf+UuKqYM6WtGTomHrkC9NeuaYpwhozkya5MXxC4AttmDsZ/lO?=
 =?us-ascii?Q?HYpMYgctsIk6pbaD9jJXL+RLwY/1c3uJ9EXpQrSN/eCmufTiIZFDkV2fAMHh?=
 =?us-ascii?Q?NI5DGs53D9nMyDhikZ2ksINp/ZXaVNTD4hN/NJ0jr1DE68sduoKLhLfOH5n4?=
 =?us-ascii?Q?OojO0tBRt6s6n/1ezOIIfqCGO9WyXRbTtVWWA2cYTavovjBOE/28uPIeuSqz?=
 =?us-ascii?Q?gYOAGdzPD1zt5etJLZidG3Zn0GELKKSH808GTNKxAO7hg9iFC7ty+BzZJH2S?=
 =?us-ascii?Q?Rz8JBGgLHEpCXhcKzwMKQm20Ok2lx9VWF96N+LNNQhJJ7zv51PLc9AIR6RyW?=
 =?us-ascii?Q?XPVbsunKkczXwMy19udv12fvXlI0ozD1CgPVy+Ra0nNPHl+A2iZiNajSCRqZ?=
 =?us-ascii?Q?E67B0lA1IiZzT27AD2tuEM5g4CGcJq80XcLn60Gh5d44jdhVM7VBCUGZYDgk?=
 =?us-ascii?Q?RAyEQtoU39cUNFhwyckV381AUKBeLPmd2EXjSrbkWb5IiKcmLuFp32waeKmd?=
 =?us-ascii?Q?J2ORBQ9UQJaM1tbB6UvVQDbiDGeqIeI3fMNvGDV8wznrRtdtLE9I5OjQiMUZ?=
 =?us-ascii?Q?GEScR2aoWa+Eb0S7hS55zJEPrOpk22XGFYIOmSkOUB/2BovXAuolyTk6U9m6?=
 =?us-ascii?Q?WZOqQU2Ld98CHuwXAO4u74foPgWuTYVMtA/clS5PeT9ikDNeQJwB5KZNinaA?=
 =?us-ascii?Q?8yZRzVi81tQEURkPagkNuhcZfo5txpaRpLMtc12wGbuVjg1NF/N8RVuXlZ0z?=
 =?us-ascii?Q?UH9VE/Yw/xYWP8o+SJq+IffDtuOht5SGrQU1q3LkESIKaDqGK4PksJi2NIbU?=
 =?us-ascii?Q?pJ0AGIglXxAkTw/7JGzQigrERkqkD8LlgyJjF85G97fm7KWAUSPnFb157i36?=
 =?us-ascii?Q?2kfEzWC/cvTZhRWx5Nxv7ZHzNUE1MUoLRwvKfYiRp3aiiSvsroi9danu6Gj4?=
 =?us-ascii?Q?lfiEOPPFecuR73grtMxhqiI5sEP4E6a1d5rigI6Owe33CHidqS0kToM4l4r3?=
 =?us-ascii?Q?/68Zq4EEkuMCxG9jld6H1Q2zNx1AYpmyZWCD7k6HtMFvJPAWlmuUKqY+TnNV?=
 =?us-ascii?Q?AjZ+rxCjiMmYHnK8ADAaTdC1ODTaJ8StAL5/kWfzD9jFrdolgCa81f1Uty97?=
 =?us-ascii?Q?zt/N+w0h3Wr8kr701vmbeNpsFjHkQG+lRem6KlT0xRSVvj0cUC/pNwHPCfTF?=
 =?us-ascii?Q?uunmH68CkWlU3KWYmjnJ524e1nYGRtTXvz/hLcjs7ErXi7VmjL+CYNkVt47b?=
 =?us-ascii?Q?DDJP0KF+LdsudkVzjujJlewgkrDHHvmej0i1G3xo10R599vzbDsN0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bXDUnnjMn+cAR0GKQaMlt7lxCOoSh85DCbdxNlo8BNp+Of5qOuCnMDj0MYRw?=
 =?us-ascii?Q?f79qKMoXD96rE8VkXOyjxVHixrw04Ygj6A0USkO95Px6wGh2pIW1AeFPv9fZ?=
 =?us-ascii?Q?ZZZfP5eGQ6IDUHZiIiv75JhUuI593fimv7yyyycQpelYMFzJtTg8pIKRXrQL?=
 =?us-ascii?Q?oCgEq0BlrjFR9X/r3NCxiZgaB9Nu8kMAnjsdBL2xSVzZ8/d2TcJsTqOkuP4K?=
 =?us-ascii?Q?dIhiiNwta8JYftY0W9g96MFeFNjGQOUTbB2irtZNTiMdZSLP/qN0lWzWkvka?=
 =?us-ascii?Q?bj6zjQ6z82V7pXJD0WFItsiQGiV4wXUQtHIDDZ2G4AddVl8Jh1JGbtGR3DV+?=
 =?us-ascii?Q?gSZ6lmeAAg3bxYgfIekIlVPhktOzSTIssKQPBWQiH0xufY0WA4RYFyQQcPB6?=
 =?us-ascii?Q?fcdEKBfSz/Xs4TPJFhIbdPFWHWmDztfNN8KzM4jkcnnITD6YANKtJzqP/16T?=
 =?us-ascii?Q?qUKdi0cx5DYFMvs88zF/CoiVeNIxQDunDew6YlXOJ5DnHpbtUz6dHIWDx2c8?=
 =?us-ascii?Q?meJdLccFS8tNMW0yDg5YAA7OcahW/cm+PTPQF2yJ5LZ9ozle644V5YUHH7GA?=
 =?us-ascii?Q?N+HBDH2njPlIFrp39sGjGWL8K5NuDU7mpl2Yjaf/D7zntpTX5IloTvgzVYAY?=
 =?us-ascii?Q?HcTXtE03i5UwlH+loXl59AghMKRsdHdC7ZJajq67O+Z0+/yUhi5WpXTH+zaV?=
 =?us-ascii?Q?HslK6i/PmnAo1MU0B9bIt3afjrtoj1N8j888+5cNEfOLcOxhnAblU3lyJ3S5?=
 =?us-ascii?Q?6Gq6JxIZA/xMwvPbix6GKRq+qwfYaUwyZGIWsbplouWm0Iww+xKLyraiPaZu?=
 =?us-ascii?Q?kIz6sg1y/TAZgvqqUvE3DJOBh4ettFp1Gv/XyTjjia1NvTXhHe0TJfYdhuOm?=
 =?us-ascii?Q?dpFXWf+VOYXTE0wIumWddYUUyNly9039Xy8nxR6YAa8qXu0TNkFlhqS9RUm/?=
 =?us-ascii?Q?Abvvl3IY+rsMuZBR7K2ytESOvMAgZ3jAIWAKCFybgZX5I6awvZn7sWxAJpXK?=
 =?us-ascii?Q?LGn+iR7w5vas791K560Wrx+k6VEfsU6oXcn6pFowyXvv4tvAnwRdQsVIN1yr?=
 =?us-ascii?Q?3Ja0nE4zqVcLQ5hq8E7G70217K71Ii7Lrpd/txVr56LuPGP0HouzXsB2B/1Z?=
 =?us-ascii?Q?uJzJLzCB/ve/grhKzPUnzrNy9N36W/rvbC4SWOrd4xLlrOg3JjPGKAKaaKCn?=
 =?us-ascii?Q?v9bx/WOHuq74SmhCxCCb/YiA8OwyRaSaWeUnvZ8OV/71PJlGyWbTs8iLOuL/?=
 =?us-ascii?Q?Ebt1QCXXn49fFN8fQOzjhiMYSx6cjxvtaC0pMajwuuide4ONagX3RrYlwSeI?=
 =?us-ascii?Q?gLqD/2uGrSjZezALuKaLAhrln7v1rzwL1W1iWxQBgHIvc8Xm/tClJeTzUPJT?=
 =?us-ascii?Q?Fhm737zxVqxdRcRREcpyyKgeWb654fVw46PBmYJMB6HXP2VA5is3sUsktk5v?=
 =?us-ascii?Q?z5zH4EmG4HuyL4XLdx6/qq4gncpjG5gnzFUh+HFyZFou91q8DKeAlVMzz66U?=
 =?us-ascii?Q?dz/DqDX4pn768hoTWVcvExunIPbsUFHQnnKIL9lTVrwtNmBQex/bRmEsDG5h?=
 =?us-ascii?Q?O4KAJk0nb1vg523wX2aG6gq9+iOymr9yyXYj0sMDY0jHJSOJVbQB49AdMVfq?=
 =?us-ascii?Q?oeVFIRgNdt7BKvBE6ssa/PpwnYHXtntupcs0DB/7t2yCbuoEoETN3/T2Ub6J?=
 =?us-ascii?Q?5Bwo0iIDBrCgjD+GuR+Yrz2+u0RgCwJ/CQeuuhsoq05cjSW3xslNSBiqnEj1?=
 =?us-ascii?Q?r3h86UWsSg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e50fc0f-1cca-4d0d-a529-08de4953a204
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:28.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+wcHKBJGRgNQdS4FFBwzb2qQGMMb3bZ328pjhs8uy5ELZwMxRQLBhbEx4RkfFbvu+U3RPmjS4OUS7IA3Iziwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

This series contains RCU fixes and improvements intended for the next
merge window. The nocb patches have had one round of review but still
need review tags.

- Updated commit messages for clarity based on review feedback

- Testing:
 All rcutorture scenarios tested successfully for 2 hours on:
  144-core ARM64 NVIDIA Grace (aarch64)
  128-core AMD EPYC (x86_64)

Link to tag:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/tag/?h=rcu-next-v1-20260101

Joel Fernandes (6):
  rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
  rcu/nocb: Add warning if no rcuog wake up attempt happened during
    overload
  rcu/nocb: Add warning to detect if overload advancement is ever useful
  rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS
    early
  rcutorture: Prevent concurrent kvm.sh runs on same source tree
  rcutorture: Add --kill-previous option to terminate previous kvm.sh
    runs

Yao Kai (1):
  rcu: Fix rcu_read_unlock() deadloop due to softirq

Zqiang (1):
  srcu: Use suitable gfp_flags for the init_srcu_struct_nodes()

 kernel/rcu/srcutree.c                         |  2 +-
 kernel/rcu/tree.c                             | 16 ++++++
 kernel/rcu/tree.h                             |  4 +-
 kernel/rcu/tree_nocb.h                        | 53 +++++++++----------
 kernel/rcu/tree_plugin.h                      | 15 +++---
 tools/testing/selftests/rcutorture/.gitignore |  1 +
 tools/testing/selftests/rcutorture/bin/kvm.sh | 40 ++++++++++++++
 7 files changed, 95 insertions(+), 36 deletions(-)


base-commit: d26143bb38e2546fe6f8c9860c13a88146ce5dd6
-- 
2.34.1


